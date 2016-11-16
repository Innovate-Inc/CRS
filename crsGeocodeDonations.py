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

fd = 'CRSSalesforce.dbo.vDonations'
fieldNames = [f.name for f in arcpy.ListFields(fd)]
print fieldNames
with arcpy.da.SearchCursor(fd, fieldNames) as sCursor:
    for row in sCursor:
        print row

        ## Find point location of Institution
        locationString = "SELECT Shape.STAsText() FROM InstitutionsFC  where ID = '" + str(row[6]) + "'"
        print locationString
        pyCursor.execute(locationString)
        try:
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

        except:
            location = 'Null'
            print location
            region = ''
            diocese = ''
            congDist = ''

        if row[1] is None:
            amount = 0
        else:
            amount = row[1]
        print amount
        
        if row[2] is None:
            closeDate = ''
        else:
            closeDate = row[2]
        print closeDate
##        
##        if row[3] is None:
##            distributed = 0
##        else:
##            distributed = row[3]
##        print distributed
##
##        if row[4] is None:
##            dateOrder = ''
##        else:
##            dateOrder = row[4]
##        print dateOrder
##            
##            

       

        ## Find next Object ID to continue incrementing
        pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'DonationsFC', @myval OUTPUT SELECT @myval")
        for thisrow in pyCursor.fetchall():
            nextID = thisrow[0]
            print nextID

        insertFields = str(nextID) + ", '" + str(row[0]) + "', '"  + str(amount) + "', '" + str(closeDate) + "', '" + str(row[3]) + "', '" + str(row[4]) + "', '" + str(row[5]) + "', '" + str(row[6]) + "', '" + region + "', '" + diocese + "', '" + congDist + "', " + location
        outFields = 'ObjectID, ID, Amount, CloseDate, Name, StageName, Type_, AccountID, Region, Diocese, CongressionalDistrict, Shape'
        sqlString = "Use CRSSalesforce Insert into DonationsFC(" + outFields + ") values (" + insertFields + ")"
        print sqlString
        pyCursor.execute(sqlString)
        connection.commit()
           
