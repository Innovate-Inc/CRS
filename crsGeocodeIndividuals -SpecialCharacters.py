## Script created by Jenny Holder, Innovate! Inc. November 2016
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
#arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Salesforce_Data (dev).sde"
#arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Connection to 10.15.30.186.sde"
arcpy.env.workspace = "D:\Salesforce_Data\Salesforce_Data.sde"

## Create set of current addresses to match against
lookupSet = set()
lookupTable = 'Salesforce_Data.dbo.IndividualsFC'
lookupFields = ["Address"]
with arcpy.da.SearchCursor(lookupTable, lookupFields) as lCursor:
    for row in lCursor:
        address = row[0].encode("utf8") 
        lookupSet.add(address)
print "Created Individuals Address Lookup Set."

lookupSetID = set()
lookupTableID = 'Salesforce_Data.dbo.IndividualsFC'
lookupFieldsID = ["ID"]
with arcpy.da.SearchCursor(lookupTableID, lookupFieldsID) as lCursor:
    for row in lCursor:
        sfID = row[0].encode("utf8") 
        lookupSetID.add(sfID)
print "Created Individuals ID Lookup Set."
        

fd = 'Salesforce_Data.dbo.vIndividualsAddress'
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
            #print cleanName + " -- after"

        if cleanAddress in lookupSet and row[1] in lookupSetID:
            pass
            print "Passed " + cleanAddress
        else:
            #try:
            # First field in each view is the concatenated address
            # Use address to geocode

            # If the address does not already exist, check to also see if the Salesforce record was simply updated
            # If the SF record exists, delete the old one from FC so new data can be written to the SF ID
            findExisting = "If exists (Select * from INDIVIDUALSFC where id = '" + row[1] + "') Delete from INDIVIDUALSFC where ID = '" + row[1] + "'"
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
                score = 0
                insertFields = "'" + cleanName + "', '" + str(row[1]) + "', '"  + cleanAddress  + "', '" + str(fd) + "', '" + str(score) + "'"
                outFields = 'Name, Id, Address, TableName, Score'
                sqlString = "Use Salesforce_Data Insert into GeocodeErrors(" + outFields + ") values (" + insertFields + ")"
                print "Put " + cleanName + " in errors."
                pyCursor.execute(sqlString)
                connection.commit()
    
            else:
                x = response['locations'][0]['feature']['geometry']['x']
                y = response['locations'][0]['feature']['geometry']['y']
                score = response['locations'][0]['feature']['attributes']['Score']
                addressType = response['locations'][0]['feature']['attributes']['Addr_Type']
                if score <= 79.99:
                    insertFields = "'" + cleanName + "', '" + str(row[1]) + "', '"  + cleanAddress + "', '" + str(fd) + "', '" + str(score)  + "'"
                    outFields = 'Name, Id, Address, TableName, Score'
                    sqlString = "Use Salesforce_Data Insert into GeocodeErrors(" + outFields + ") values (" + insertFields + ")"
                    pyCursor.execute(sqlString)
                    connection.commit()
                else:
                   
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
                    except:
                        usState = ''
                     
                    ## Find table to put output of individuals
                    try:
                        print "Start adding to Individuals."
                        
                        if row[3] is None:
                            titlec = ''
                        else:
                            titlec = ftfy.fix_text(row[3])
                            titlec = titlec.replace("'", "''").rstrip()

                        ## Determine if Individual is Grassroots Supporter
                        gpString = "Select ID from Subscriptions where Subscriber__c = '" + str(row[1]) + "'"
                        #print gpString
                        pyCursor.execute(gpString)
                        try:
                            for c in pyCursor.fetchone():
                                #print c
                                ccgp = 'Yes'
                                #print ccgp
                        except:
                            ccgp = 'No'
                            #print ccgp

                        ## Determine if Individual is Grassroots Action Taker
                        atString = "Select ID from vActionTakers where Response_From__c = '" + str(row[1]) + "'"
                        #print atString
                        pyCursor.execute(atString)
                        try:
                            for a in pyCursor.fetchone():
                                #print a
                                grat = 'Yes'
                                #print grat
                        except:
                            grat = 'No'
                            #print grat

                        ## Determine if Individual is Parish Ambassador
                        pacString = "Select ID from Relationships where From_Individual__c = '" + str(row[1]) + "' and Second_Relationship_type__c like '%Parish Ambassador%'"
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

                        
                        ## Find next Object ID to continue incrementing
                        pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'IndividualsFC', @myval OUTPUT SELECT @myval")
                        for thisrow in pyCursor.fetchall():
                            nextID = thisrow[0]
                            #print nextID
                     
                        insertFields = str(nextID) + ", '" + cleanAddress + "', '" + str(row[1]) + "', '"  + cleanName  + "', '" + str(score) + "', '" + titlec + "', '" + str(row[4]) + "', '" + str(row[5]) + "', " + location + ", '" + diocese + "', '" + region + "', '" + congDist + "', '" + str(row[6]) + "', '" + str(row[7]) + "', '" + ccgp + "', '" + grat + "', '" + pac + "', '" + usState + "'"
                        outFields = 'OBJECTID, Address, Id, Name, Score, Title__c, AccountID, Relationship_Types__c, Shape, Diocese, Region, CongressionalDistrict, kw__Chamber__c, kw__StateOfCoverage__c, GrassrootsSupporter, ActionTaker, ParishAmbassador, USState'
                        sqlString = "Use Salesforce_Data Insert into INDIVIDUALSFC(" + outFields + ") values (" + insertFields + ")"
                        #print sqlString
                        print "Inserting " + cleanName + " into Individuals table."
                        pyCursor.execute(sqlString)
                        connection.commit()
                    except:
                        print "Found error in fields other than name and address."
                        print "Adding to GeocodeErrors table now..."
                        print row
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

print "Individuals geocoding complete!"
