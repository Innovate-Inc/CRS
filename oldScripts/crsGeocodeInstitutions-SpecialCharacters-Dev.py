## Script created by Jenny Holder, Innovate! Inc. November 2016
## Creates full institution feature class for both US Ops and Exec Suite
## 
## Had to install pypyodbc, requests and copied here:
## C:\Python27\ArcGISx6410.4\Lib\site-packages
import arcpy, sets, pypyodbc, requests, ftfy

## Create connection to SQL Server database and open a cursor
#connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.230.244\dev;' 'Database=Salesforce_Data;' 'uid=jenny.holder;pwd=crs4fun')
connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.30.186;' 'Database=Salesforce_Data;' 'uid=sf_intregrationadmin;pwd=JetterbitCRS')

pyCursor = connection.cursor()

print "Made connection."

## Point to the sde connection
arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Salesforce_Data (dev).sde"
#arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Connection to 10.15.30.186.sde"
#arcpy.env.workspace = "D:\Salesforce_Data\Salesforce_Data.sde"

## Create set of current addresses to match against
lookupSet = set()
lookupTable = 'Salesforce_Data.dbo.InstitutionsFC'
lookupFields = ["Address"]
with arcpy.da.SearchCursor(lookupTable, lookupFields) as lCursor:
    for row in lCursor:
        address = row[0].encode("utf8") 
        lookupSet.add(address)
print "Created Institutions Address Lookup Set."


lookupSetID = set()
lookupTableID = 'Salesforce_Data.dbo.InstitutionsFC'
lookupFieldsID = ["ID"]
with arcpy.da.SearchCursor(lookupTableID, lookupFieldsID) as lCursor:
    for row in lCursor:
        sfID = row[0].encode("utf8") 
        lookupSetID.add(sfID)
print "Created Institutions ID Lookup Set."
        

fd = 'Salesforce_Data.dbo.vInstitutionsAddress'
fieldNames = [f.name for f in arcpy.ListFields(fd)]
print fieldNames
with arcpy.da.SearchCursor(fd, fieldNames) as sCursor:
    for row in sCursor:
        
    ## For each record in the view:

        # Some rows have apostrophes to take care of
        # Create clean version of Address field to insert back into database
        if row[0] is None:
            cleanAddress = '-'
        else:
            cleanAddress = ftfy.fix_text(row[0])
            cleanAddress = cleanAddress.replace("'", "''").rstrip()

        # Create clean version of Name field to insert back into database
        if row[2] is None:
            cleanName = ''
            print cleanName
        else:
            cleanName = ftfy.fix_text(row[2])
            #print cleanName + "--ftfy"
            cleanName = cleanName.replace("'", "''").rstrip()
            print cleanName

        if cleanAddress in lookupSet and row[1] in lookupSetID:
            pass
            print "Passed " + cleanAddress
        else:
            #try:
            # First field in each view is the concatenated address
            # Use address to geocode

            # If the address does not already exist, check to see if the Salesforce record was simply updated
            # If the SF record exists, delete the old one from FC so new data can be written to the SF ID
            findExisting = "If exists (Select * from INSTITUTIONSFC where id = '" + row[1] + "') Delete from Institutionsfc where ID = '" + row[1] + "'"
            pyCursor.execute(findExisting)
            connection.commit()
                
            response = requests.get('http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/find',
                                            {'text': cleanAddress,
                                             'f': 'json',
                                             'outSR': '3857'})
            response = response.json()
            if len(response['locations']) == 0:
                ## Write to output about it
                ## Insert errors into "error" type
                ## This means there is no match for the address
                score = 0
                insertFields = "'" + cleanName + "', '" + str(row[1]) + "', '"  + cleanAddress  + "', '" + str(fd) + "', '" + str(score) + "'"
                outFields = 'Name, Id, Address, TableName, Score'
                sqlString = "Use Salesforce_Data Insert into GeocodeErrors(" + outFields + ") values (" + insertFields + ")"
                print "Put " + cleanName + " in errors."
                pyCursor.execute(sqlString)
                connection.commit()
        
    
            else:
                # A location is returned and assigned x/y, but
                # Score is no longer being returned by the geocoding services
                # Score now entered into the database is arbitrary, for the time being
                #score = response['locations'][0]['feature']['attributes']['Score']
                x = response['locations'][0]['feature']['geometry']['x']
                y = response['locations'][0]['feature']['geometry']['y']
                score = ''
##                score = response['locations'][0]['feature']['attributes']['Score']
##                addressType = response['locations'][0]['feature']['attributes']['Addr_Type']
##                if score <= 79.99:
##                    insertFields = "'" + cleanName + "', '" + str(row[1]) + "', '"  + cleanAddress + "', '" + str(fd) + "', '" + str(score)  + "'"
##                    outFields = 'Name, Id, Address, TableName, Score'
##                    sqlString = "Use Salesforce_Data Insert into GeocodeErrors(" + outFields + ") values (" + insertFields + ")"
##                    pyCursor.execute(sqlString)
##                    connection.commit()
##                else:
                ## Create shape value from x,y point
                location = "geometry::STPointFromText('Point (" + str(x) + " " + str(y) + ")', 3857)"
                #print location
                
                ## Find diocese the point is in
                intersectString = "Select Name_other from USDIOCESESAGOL where Shape.STContains(" + location + ") = 1"
                #print intersectString
                pyCursor.execute(intersectString)
                try:
                    for d in pyCursor.fetchone():
                        diocese = d
                        #print diocese
                except:
                    diocese = ''
                    #print diocese

                ## Find region the point is in
                intersectString = "Select RegionName from USREGIONSAGOL where Shape.STContains(" + location + ") = 1"
                #print intersectString
                pyCursor.execute(intersectString)
                try:
                    for r in pyCursor.fetchone():
                        region = r
                        #print region
                except:
                    region = ''
                    #print region

                ## Find congressional district the point is in 
                intersectString = "Select UniqueID from USCONGRESSIONALDISTRICTSAGOL where Shape.STContains(" + location + ") = 1"
                #print intersectString
                pyCursor.execute(intersectString)
                try:
                    for c in pyCursor.fetchone():
                        congDist = str(c)
                        #print congDist
                except:
                    congDist = ''
                    #print congDist

                ## Find US state the point is in 
                intersectString = "Select STATE_NAME from USSTATESAGOL where Shape.STContains(" + location + ") = 1"
                #print intersectString
                pyCursor.execute(intersectString)
                try:
                    for s in pyCursor.fetchone():
                        usState = str(s)
                        #print usState
                except:
                    usState = ''
                    #print usState
            
                 
                ## Try inserting into Institutions table
                try:
                    if row[9] is None:
                        cathPop = 0
                    else:
                        cathPop = row[9]
                    #print cathPop
                    
                    if row[10] is None:
                        hispPop = 0
                    else:
                        hispPop = row[10]
                    #print hispPop
                    
                    if row[11] is None:
                        numHS = 0
                    else:
                        numHS = row[11]
                    #print numHS
                    
                    if row[12] is None:
                        numK8 = 0
                    else:
                        numK8 = row[12]
                    #print numK8

                        
                    if row[13] is None:
                        numParish = 0
                    else:
                        numParish = row[13]
                    #print numParish
                    
                    if row[14] is None:
                        totPop = 0
                    else:
                        totPop = row[14]
                    #print totPop

                    if row[16] is None:
                        instAff = ''
                    else:
                        instAff = row[16]

                    if row[17] is None:
                        sixMo = 0
                    else:
                        sixMo = row[17]
                    #print sixMo

                    if row[18] is None:
                        twelveMo = 0
                    else:
                        twelveMo = row[18]
                    #print twelveMo

                    ## Determine if Institution is a CBI (Capacity Building Initiative)
                    cbiString = "Select ID from Relationships where From_Institution__c = '" + str(row[1]) + "' and Second_Relationship_type__c like '%cbi%'"
                    #print cbiString
                    pyCursor.execute(cbiString)
                    try:
                        for c in pyCursor.fetchone():
                            #print c
                            cbi = 'Yes'
                            #print cbi
                    except:
                        cbi = 'No'
                        #print cbi


                    ## Determine if Institution is a Parish Ambassador (PAC)
                    pacString = "Select ID from Relationships where To_Institution__c = '" + str(row[1]) + "' and Second_Relationship_type__c like '%Parish Ambassador (PAC)%'"
                    #print pacString
                    pyCursor.execute(pacString)
                    try:
                        for p in pyCursor.fetchone():
                            #print p
                            pac = 'Yes'
                            #print pac
                    except:
                        pac = 'No'
                        #print pac
                    
                    ## Find next Object ID to continue incrementing (unique ID required by ArcGIS)
                    pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'InstitutionsFC', @myval OUTPUT SELECT @myval")
                    #print "Used nextID"
                    
                    for thisrow in pyCursor.fetchall():
                        nextID = thisrow[0]
                        #print nextID
                   
                   
                    insertFields = str(nextID) + ", '" + cleanAddress + "', '" + str(row[1]) + "', '"  + cleanName  + "', '" + str(score) + "', '" + str(row[3]) + "', '" + str(row[4]) + "', '" + str(row[5]) + "', '" + str(row[6]) + "', '" + str(row[7]) + "', '" + str(row[8]) + "', '" + str(cathPop) + "', '" + str(hispPop) + "', '" + str(numHS) + "', '" + str(numK8) + "', '" + str(numParish) + "', '" + str(totPop) + "', " + location + ", '" + diocese + "', '" + region + "', '" + congDist + "', '" + cbi + "', '" + pac + "', '" + usState + "', '" + instAff + "', '" + str(sixMo) + "', '" + str(twelveMo) + "'"
                    #print insertFields
                    outFields = 'ObjectID, Address, ID, Name, Score, Institution_Type__c, Institution_Sub_Type__c, Institution_Sub_Sub_Type__c, Region__c, ParentID, District__c, Cath_Pop__c, Hisp_Cath_Pop__c, Num_Cath_High_Schools__c, Num_Cath_K8_Schools__c, Num_Parishes__c, Total_pop__c, Shape, Diocese, Region, CongressionalDistrict, CapacityBuildingInitiative, ParishAmbassador, USState, Institutional_Affiliation__c, Interactions_6_Months__c, Interactions_12_Months__c'
                    sqlString = "Use Salesforce_Data Insert into InstitutionsFC(" + outFields + ") values (" + insertFields + ")"
                    #print sqlString
                    pyCursor.execute(sqlString)
                    connection.commit()
                    print "Inserted " + cleanName + " to Institutions table."
                    
                except:
                    #print "Found error in fields other than name and address."
                    print "Adding to GeocodeErrors table now..."
                    score = 0
                    insertFields = "'" + cleanName + "', '" + str(row[1]) + "', '"  + cleanAddress  + "', '" + str(fd) + "', '" + str(score)  + "'"
                    outFields = 'Name, Id, Address, TableName, Score'
                    sqlString = "Use Salesforce_Data Insert into GeocodeErrors(" + outFields + ") values (" + insertFields + ")"
                    #print sqlString
                    pyCursor.execute(sqlString)
                    connection.commit()

## Close/delete the cursor and the connection
pyCursor.close()
del pyCursor
connection.close()
