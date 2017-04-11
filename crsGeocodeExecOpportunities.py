## Script created by Jenny Holder, Innovate! Inc. December 2016
## Creates feature class of all opportunties for Exec Suite export (not currently in any maps)
## 
import arcpy, pypyodbc

## Create connection to SQL Server database and open a cursor
#connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.230.244\dev;' 'Database=Salesforce_Data;' 'uid=jenny.holder;pwd=crs4fun')
connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.30.186;' 'Database=Salesforce_Data;' 'uid=sf_intregrationadmin;pwd=JetterbitCRS')

pyCursor = connection.cursor()

print "Made connection."

## Point to the sde connection
#arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Salesforce_Data (dev).sde"
#arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Connection to 10.15.30.186.sde"
arcpy.env.workspace = "D:\Salesforce_Data\Salesforce_Data.sde"


## Create set of current donations to match against
##lookupSet = set()
##lookupTable = 'Salesforce_Data.dbo.OpportunitiesFC'
##lookupFields = ["ID"]
##with arcpy.da.SearchCursor(lookupTable, lookupFields) as lCursor:
##    for row in lCursor:
##        sfid = row[0].encode("utf8") 
##        lookupSet.add(sfid)
##print "Created Lookup Set."


fd = 'Salesforce_Data.dbo.Opportunities'
fieldNames = [f.name for f in arcpy.ListFields(fd)]
print fieldNames
with arcpy.da.SearchCursor(fd, fieldNames) as sCursor:
    for row in sCursor:
        print row

##        if row[0] in lookupSet:
##            pass
##            print "Passed " + row[0]
##        else:

        ## Find point location of Institution
        locationString = "SELECT Shape.STAsText() FROM InstitutionsFC where ID = '" + str(row[3]) + "'"
        #print locationString
        pyCursor.execute(locationString)
        try:
            #print "trying location"
            for loc in pyCursor.fetchone():
                location = "geometry::STPointFromText('" + loc + "', 3857)"
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


        except:
            location = 'Null'
            #print location
            region = ''
            diocese = ''
            congDist = ''
            usState = ''

        if row[4] is None:
            amount = 0
        else:
            amount = row[4]
        #print amount
        
        if row[5] is None:
            closeDate = ''
        else:
            closeDate = row[5]
        #print closeDate

        if row[1] is None:
            cleanName = '-' 
        elif row[1].find("'") > -1:
            cleanName = row[1].replace("'", "")
        else:
            cleanName = row[1]
       

        ## Find next Object ID to continue incrementing
        pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'OpportunitiesFC', @myval OUTPUT SELECT @myval")
        for thisrow in pyCursor.fetchall():
            nextID = thisrow[0]
            #print nextID

        insertFields = str(nextID) + ", '" + str(row[0]) + "', '"  + str(amount) + "', '" + str(closeDate) + "', '" + cleanName + "', '" + str(row[6]) + "', '" + str(row[2]) + "', '" + str(row[3]) + "', '" + region + "', '" + diocese + "', '" + congDist + "', '" + usState + "', " + location
        outFields = 'ObjectID, ID, Amount, CloseDate, Name, StageName, Type, AccountID, Region, Diocese, CongressionalDistrict, USState, Shape'
        sqlString = "Use Salesforce_Data Insert into OpportunitiesFC(" + outFields + ") values (" + insertFields + ")"
        #print sqlString
        print "Added " + str(row[0]) + " to OpportunitiesFC."
        pyCursor.execute(sqlString)
        connection.commit()


## Close/delete the cursor and the connection
pyCursor.close()
del pyCursor
connection.close()
               
