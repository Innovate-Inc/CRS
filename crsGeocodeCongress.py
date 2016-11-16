## Script created by Jenny Holder, Innovate! Inc. September 2016
## 
## May have to install pypyodbc
import arcpy, pypyodbc, requests, sets

## Create connection to SQL Server database and open a cursor
#connection = pypyodbc.connect('Driver={SQL Server};' 'Server=10.15.230.244\dev;' 'Database=Salesforce_Data;' 'uid=jenny.holder;pwd=crs4fun')
#connection = pypyodbc.connect('Driver={SQL Server};' 'Server=localhost\sqlexpress;' 'Database=CRS;' 'uid=JSONDataWriter;pwd=Write$om3Data4fun!')
connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0}; Server=localhost\sqlexpress; Database=CRSSalesforce; uid=JSONDataWriter;pwd=Write$om3Data4fun!')
pyCursor = connection.cursor()

## Point to the sde connection
#arcpy.env.workspace = "C:\Users\Innovate\AppData\Roaming\ESRI\Desktop10.3\ArcCatalog\CRS.sde"
arcpy.env.workspace = "C:\Users\jholder\AppData\Roaming\ESRI\Desktop10.4\ArcCatalog\CRSSalesforce.sde"


#### Create set of senator names
##senatorSet = set()
##lookupTable = 'CRSSalesforce.dbo.vSenators'
##lookupFields = ["Senator"]
##with arcpy.da.SearchCursor(lookupTable, lookupFields) as lCursor:
##    for row in lCursor:
##        name = row[0].encode("utf8").rstrip()
##        senatorSet.add(name)
##senatorList = list(set(senatorSet))
##print senatorList
##print len(senatorList)
##
##print "Created Lookup Set."
##
#### For each senator, create a list of the sub/committees he/she is on
##for s in senatorList:
##    fd = 'CRSSalesforce.dbo.vSenators'
##    fieldNames = [f.name for f in arcpy.ListFields(fd)]
##    queryString = "Senator = '" + s + "'"
##    committeeList = []
##    with arcpy.da.SearchCursor(fd, fieldNames, where_clause=queryString) as sCursor:
##        for row in sCursor:
##            committeeList.append(row[1].encode("utf8").rstrip())
##            if row[5] is None:
##                print "No State"
##            else:
##                sfID = row[0].encode("utf8").rstrip()
##                senator = row[2].encode("utf8").rstrip()
##                chamber = row[3].encode("utf8").rstrip()
##                title = row[4].encode("utf8").rstrip()
##                stateCoverage = row[5].encode("utf8").rstrip()[:2]
##            
##            print row
##
##    ## Create cleaned list of committees
##    committeeString = '; '.join(committeeList)
##    if committeeString.find("'") > -1:
##        committeeString = committeeString.replace("'", "")
##    else:
##        committeeString = committeeString
##    print committeeString
##
##
##    ## Find next Object ID to continue incrementing
##    pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'SenateFC', @myval OUTPUT SELECT @myval")
##    print "Used nextID"
##    for thisrow in pyCursor.fetchall():
##        nextID = thisrow[0]
##        print nextID
##        
##    insertFields = str(nextID) + ", '" + sfID + "', '" + committeeString + "', '"  + senator  + "', '" + chamber + "', '" + title + "', '" + stateCoverage + "'"
##    outFields = 'ObjectID, ID, Committee, Senator, Chamber, Title, StateCoverage, SHAPE'
##    sqlString = "Use CRSSalesforce Declare @g geometry; Set @g = (SELECT TOP (1) states.Shape FROM dbo.USSTATESAGOL AS states WHERE states.State_Abbr = " + "'" + stateCoverage + "') Insert into SenateFC(" + outFields + ") values (" + insertFields + ", @g)"
##    print sqlString
##    pyCursor.execute(sqlString)
##    connection.commit()






## Create set of House of Representative names
repSet = set()
lookupTable = 'CRSSalesforce.dbo.vHouseRepresentatives'
lookupFields = ["Representative"]
with arcpy.da.SearchCursor(lookupTable, lookupFields) as lCursor:
    for row in lCursor:
        name = row[0].encode("utf8").rstrip()
        repSet.add(name)
repList = list(set(repSet))
print repList

print "Created Lookup Set."

## For each senator, create a list of the sub/committees he/she is on
for r in repList:
    fd = 'CRSSalesforce.dbo.vHouseRepresentatives'
    fieldNames = [f.name for f in arcpy.ListFields(fd)]
    queryString = "Representative = '" + r + "'"
    committeeList = []
    with arcpy.da.SearchCursor(fd, fieldNames, where_clause=queryString) as sCursor:
        for row in sCursor:
            committeeList.append(row[1].encode("utf8").rstrip())
            if row[3] is None:
                print "No Chamber"
            else:
                sfID = row[0].encode("utf8").rstrip()
                rep = row[2].encode("utf8").rstrip()
                chamber = row[3].encode("utf8").rstrip()
                title = row[4].encode("utf8").rstrip()
            print row
        

    ## Create cleaned list of committees
    committeeString = '; '.join(committeeList)
    if committeeString.find("'") > -1:
        committeeString = committeeString.replace("'", "")
    else:
        committeeString = committeeString
    print committeeString

    distString = "SELECT poly.CongDist FROM vCongressPersonbyCongPolygon as poly where poly.CongressPerson = '" + rep + "'"
    print distString
    pyCursor.execute(distString)
    print "Found Congressional District"

    try:
        for congRow in pyCursor.fetchone():
            congDist = congRow
            if congDist is None:
                conDist = ''
            print congDist
    except:
        congDist = ''


    ## Find next Object ID to continue incrementing
    pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'HouseFC', @myval OUTPUT SELECT @myval")
    print "Used nextID"
    for thisrow in pyCursor.fetchall():
        nextID = thisrow[0]
        print nextID
        
    insertFields = str(nextID) + ", '" + sfID + "', '" + committeeString + "', '" + rep + "', '" + chamber + "', '" + title + "','" + congDist + "'"
    outFields = 'ObjectID, ID, Committee, Representative, Chamber, Title, CongressionalDistrict, SHAPE'
    sqlString = "Use CRSSalesforce Declare @g geometry; Set @g = (SELECT top (1) poly.Shape FROM vCongressPersonbyCongPolygon as poly where poly.CongressPerson = '" + rep + "') Insert into HouseFC(" + outFields + ") values (" + insertFields + ", @g)"
    print sqlString
    pyCursor.execute(sqlString)
    connection.commit()
