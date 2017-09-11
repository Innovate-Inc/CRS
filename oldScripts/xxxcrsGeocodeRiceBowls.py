## Script created by Jenny Holder, Innovate! Inc. September 2016
## 
## May have to install pypyodbc
import arcpy, pypyodbc

## Create connection to SQL Server database and open a cursor
connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.230.244\dev;' 'Database=Salesforce_Data;' 'uid=jenny.holder;pwd=crs4fun')
pyCursor = connection.cursor()

## Point to the sde connection
arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Salesforce_Data (dev).sde"

## Create set of current donations to match against
lookupSet = set()
lookupTable = 'Salesforce_Data.dbo.RiceBowlsFC'
lookupFields = ["ID"]
with arcpy.da.SearchCursor(lookupTable, lookupFields) as lCursor:
    for row in lCursor:
        sfid = row[0].encode("utf8") 
        lookupSet.add(sfid)
print "Created Lookup Set."


fd = 'Salesforce_Data.dbo.RiceBowls'
fieldNames = [f.name for f in arcpy.ListFields(fd)]
print fieldNames
with arcpy.da.SearchCursor(fd, fieldNames) as sCursor:
    for row in sCursor:
        print row

        if row[0] in lookupSet:
            pass
            print "Passed " + row[0]
        else:

            ## Find point location of Institution
            locationString = "SELECT Shape.STAsText() FROM InstitutionsFC  where ID = '" + str(row[5]) + "'"
            pyCursor.execute(locationString)
            try:
                #print "trying location"
                for loc in pyCursor.fetchone():
                    location = "geometry::STPointFromText('" + loc + "', 3857)"

                ## Find diocese the point is in
                intersectString = "Select Name_other from USDIOCESESAGOL where Shape.STContains(" + location + ") = 1"
                pyCursor.execute(intersectString)
                try:
                    for d in pyCursor.fetchone():
                        diocese = d
                except:
                    diocese = ''

                ## Find region the point is in
                intersectString = "Select RegionName from USREGIONSAGOL where Shape.STContains(" + location + ") = 1"
                pyCursor.execute(intersectString)
                try:
                    for r in pyCursor.fetchone():
                        region = r
                except:
                    region = ''

                ## Find congressional district the point is in 
                intersectString = "Select UniqueID from USCONGRESSIONALDISTRICTSAGOL where Shape.STContains(" + location + ") = 1"
                pyCursor.execute(intersectString)
                try:
                    for c in pyCursor.fetchone():
                        congDist = str(c)
                except:
                    congDist = ''

                ## Find US state the point is in 
                intersectString = "Select STATE_NAME from USSTATESAGOL where Shape.STContains(" + location + ") = 1"
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

            if row[1] is None:
                funds = 0
            else:
                funds = row[1]
            #print funds
            
            if row[2] is None:
                collected = 0
            else:
                collected = row[2]
            #print collected
            
            if row[3] is None:
                distributed = 0
            else:
                distributed = row[3]
            #print distributed

            if row[4] is None:
                dateOrder = ''
            else:
                dateOrder = row[4]
            #print dateOrder
                
                

           

            ## Find next Object ID to continue incrementing
            pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'RiceBowlsFC', @myval OUTPUT SELECT @myval")
            for thisrow in pyCursor.fetchall():
                nextID = thisrow[0]
                #print nextID

            insertFields = str(nextID) + ", '" + str(row[0]) + "', '"  + str(funds) + "', '" + str(collected) + "', '" + str(distributed) + "', '" + str(dateOrder) + "', '" + str(row[5]) + "', '" + region + "', '" + diocese + "', '" + congDist + "', '" + usState + "', " + location
            outFields = 'ObjectID, ID, Amt_Rice_Bowl_funds_raised__c, Num_Rice_Bowls_collected__c, Num_Rice_Bowls_distributed__c, Order_Date__c, Institution__c, Region, Diocese, CongressionalDistrict, USState, Shape'
            sqlString = "Use Salesforce_Data Insert into RICEBOWLSFC(" + outFields + ") values (" + insertFields + ")"
            #print sqlString
            print "Adding " + row[0] + " to RiceBowlsFC."
            pyCursor.execute(sqlString)
            connection.commit()


## Close/delete the cursor and the connection
pyCursor.close()
del pyCursor
connection.close()
               
