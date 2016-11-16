## Script created by Jenny Holder, Innovate! Inc. September 2016
## 
## May have to install pypyodbc
import arcpy, pypyodbc

## Create connection to SQL Server database and open a cursor
#connection = pypyodbc.connect('Driver={SQL Server};' 'Server=10.15.230.244\dev;' 'Database=Salesforce_Data;' 'uid=jenny.holder;pwd=crs4fun')
#connection = pypyodbc.connect('Driver={SQL Server};' 'Server=localhost\sqlexpress;' 'Database=CRS;' 'uid=JSONDataWriter;pwd=Write$om3Data4fun!')
connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0}; Server=localhost\sqlexpress; Database=CRSSalesforce; uid=JSONDataWriter;pwd=Write$om3Data4fun!')
pyCursor = connection.cursor()

## Point to the sde connection
#arcpy.env.workspace = "C:\Users\Innovate\AppData\Roaming\ESRI\Desktop10.3\ArcCatalog\CRS.sde"
arcpy.env.workspace = "C:\Users\jholder\AppData\Roaming\ESRI\Desktop10.4\ArcCatalog\CRSSalesforce.sde"

fd = 'CRSSalesforce.dbo.vRiceBowls'
fieldNames = [f.name for f in arcpy.ListFields(fd)]
print fieldNames
with arcpy.da.SearchCursor(fd, fieldNames) as sCursor:
    for row in sCursor:
        print row

        ## Find point location of Institution
        locationString = "SELECT Shape.STAsText() FROM InstitutionsFC  where ID = '" + str(row[5]) + "'"
        print locationString
        pyCursor.execute(locationString)
        #try:
        print "trying location"
        for loc in pyCursor.fetchone():
            location = "geometry::STPointFromText('" + loc + "', 3857)"
            print location

        ## Find diocese the point is in
        intersectString = "Select Name_other from USDIOCESESAGOL where Shape.STContains(" + location + ") = 1"
        print intersectString
        pyCursor.execute(intersectString)
        try:
            for d in pyCursor.fetchone():
                diocese = d
                print diocese
        except:
            diocese = ''
            print diocese

        ## Find region the point is in
        intersectString = "Select RegionName from USREGIONSAGOL where Shape.STContains(" + location + ") = 1"
        print intersectString
        pyCursor.execute(intersectString)
        try:
            for r in pyCursor.fetchone():
                region = r
                print region
        except:
            region = ''
            print region

        ## Find congressional district the point is in 
        intersectString = "Select UniqueID from USCONGRESSIONALDISTRICTSAGOL where Shape.STContains(" + location + ") = 1"
        print intersectString
        pyCursor.execute(intersectString)
        try:
            for c in pyCursor.fetchone():
                congDist = str(c)
                print congDist
        except:
            congDist = ''
            print congDist

##        except:
##            location = 'Null'
##            print location
##            region = ''
##            diocese = ''
##            congDist = ''

        if row[1] is None:
            funds = 0
        else:
            funds = row[1]
        print funds
        
        if row[2] is None:
            collected = 0
        else:
            collected = row[2]
        print collected
        
        if row[3] is None:
            distributed = 0
        else:
            distributed = row[3]
        print distributed

        if row[4] is None:
            dateOrder = ''
        else:
            dateOrder = row[4]
        print dateOrder
            
            

       

        ## Find next Object ID to continue incrementing
        pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'RiceBowlsFC', @myval OUTPUT SELECT @myval")
        for thisrow in pyCursor.fetchall():
            nextID = thisrow[0]
            print nextID

        insertFields = str(nextID) + ", '" + str(row[0]) + "', '"  + str(funds) + "', '" + str(collected) + "', '" + str(distributed) + "', '" + str(dateOrder) + "', '" + str(row[5]) + "', '" + region + "', '" + diocese + "', '" + congDist + "', " + location
        outFields = 'ObjectID, ID, Amt_Rice_Bowl_funds_raised__c, Num_Rice_Bowls_collected__c, Num_Rice_Bowls_distributed__c, Order_Date__c, Institution__c, Region, Diocese, CongressionalDistrict, Shape'
        sqlString = "Use CRSSalesforce Insert into RICEBOWLSFC(" + outFields + ") values (" + insertFields + ")"
        print sqlString
        pyCursor.execute(sqlString)
        connection.commit()
           
