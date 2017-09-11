## Script created by Jenny Holder, Innovate! Inc. September 2016
## Associates donations with institutions addresses (locations) and writes all to DonationsFC table
##  For donations with Fund Name CRS Rice Bowls, record is also written to RiceBowlsFC
## 
## May have to install pypyodbc
import arcpy, pypyodbc, sys, ftfy

## Create connection to SQL Server database and open a cursor
connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.230.244\dev;' 'Database=Salesforce_Data;' 'uid=jenny.holder;pwd=crs4fun')
#connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.30.186;' 'Database=Salesforce_Data;' 'uid=sf_intregrationadmin;pwd=JetterbitCRS')

pyCursor = connection.cursor()

print "Made connection."

## Point to the sde connection
arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Salesforce_Data (dev).sde"
#arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Connection to 10.15.30.186.sde"
#arcpy.env.workspace = "D:\Salesforce_Data\Salesforce_Data.sde"

#### Create set of current donations to match against if rerunning manually
##lookupSet = set()
##lookupTable = 'Salesforce_Data.dbo.DonationsFC'
##lookupFields = ["ID"]
##with arcpy.da.SearchCursor(lookupTable, lookupFields) as lCursor:
##    for row in lCursor:
##        sfid = row[0].encode("utf8") 
##        lookupSet.add(sfid)
##print "Created Lookup Set."


fd = 'Salesforce_Data.dbo.Donations'
fieldNames = [f.name for f in arcpy.ListFields(fd)]
print fieldNames
with arcpy.da.SearchCursor(fd, fieldNames) as sCursor:
    for row in sCursor:

##        ## Use when rerunning manually via lookup set        
##        if row[0] in lookupSet:
##            pass
##            print "Passed " + row[0]
##        else:

        ## Find point location of Institution
        locationString = "SELECT Shape.STAsText() FROM InstitutionsFC where ID = '" + str(row[6]) + "'"
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
            region = ''
            diocese = ''
            congDist = ''
            usState = ''

        if row[1] is None:
            amount = 0
        else:
            amount = row[1]
        #print amount
        
        if row[2] is None:
            closeDate = ''
        else:
            closeDate = row[2]
        #print closeDate

        if row[3] is None:
            cleanName = ''
        else:
            cleanName = ftfy.fix_text(row[3])
            cleanName = cleanName.replace("'", "''").rstrip()
       

        ## Find next Object ID to continue incrementing in full Donations table
        pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'DonationsFC', @myval OUTPUT SELECT @myval")
        for thisrow in pyCursor.fetchall():
            nextID = thisrow[0]
            #print nextID

        insertFields = str(nextID) + ", '" + str(row[0]) + "', '"  + str(amount) + "', '" + str(closeDate) + "', '" + str(row[3]) + "', '" + str(row[4]) + "', '" + str(row[5]) + "', '" + str(row[6]) + "', '" + region + "', '" + diocese + "', '" + congDist + "', '" + usState + "', " + location
        outFields = 'ObjectID, ID, Amount, CloseDate, Name, StageName, Type_, AccountID, Region, Diocese, CongressionalDistrict, USState, Shape'
        sqlString = "Use Salesforce_Data Insert into DonationsFC(" + outFields + ") values (" + insertFields + ")"
        #print sqlString
        print "Added to Donations:" + str(row[0])
        pyCursor.execute(sqlString)
        connection.commit()

        
        if row[7] is None:
            pass
            print "----"
            
        elif 'CRS Rice Bowl' in str(row[7]):
            print str(row[7])
            ## Find next Object ID to continue incrementing in stand alone Rice Bowls table
            pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'RiceBowlsFC', @myval OUTPUT SELECT @myval")
            for thisrow in pyCursor.fetchall():
                nextID = thisrow[0]
                #print nextID

            insertFields = str(nextID) + ", '" + str(row[0]) + "', '"  + str(amount) + "', '" + str(closeDate) + "', '" + str(row[3]) + "', '" + str(row[4]) + "', '" + str(row[5]) + "', '" + str(row[6]) + "', '" + region + "', '" + diocese + "', '" + congDist + "', '" + usState + "', " + location
            outFields = 'ObjectID, ID, Amount, CloseDate, Name, StageName, Type_, AccountID, Region, Diocese, CongressionalDistrict, USState, Shape'
            sqlString = "Use Salesforce_Data Insert into RiceBowlsFC(" + outFields + ") values (" + insertFields + ")"
            #print sqlString
            print "*** Added to Rice Bowls:" + str(row[0])
            pyCursor.execute(sqlString)
            connection.commit()

## Close/delete the cursor and the connection
pyCursor.close()
del pyCursor
connection.close()
               
