## Script created by Jenny Holder, Innovate! Inc. September 2016
## Associates congress people with state/district and subcommittees
## Only needs to be run if congress/individual records are updated
## 
import arcpy, pypyodbc, requests, sets

## Create connection to SQL Server database and open a cursor
connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.230.244\dev;' 'Database=Salesforce_Data;' 'uid=jenny.holder;pwd=crs4fun')
#connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.30.186;' 'Database=Salesforce_Data;' 'uid=sf_intregrationadmin;pwd=JetterbitCRS')

pyCursor = connection.cursor()
print "Made connection."

## Point to the sde connection
arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Salesforce_Data (dev).sde"
#arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Connection to 10.15.30.186.sde"
#arcpy.env.workspace = "D:\Salesforce_Data\Salesforce_Data.sde"



#### Create set of senator names
senatorSet = set()
lookupTable = 'Salesforce_Data.dbo.vCongressSenators'
lookupFields = ['Senator']
with arcpy.da.SearchCursor(lookupTable, lookupFields) as lCursor:
    for row in lCursor:
        name = row[0].encode("utf8").rstrip()
        if name.find("'") > -1:
            name = name.replace("'", "")
        else:
            name = name
        senatorSet.add(name)
senatorList = list(set(senatorSet))
print senatorList

print "Created Senators Lookup Set."

## For each senator, create a list of the sub/committees he/she is on
for s in senatorList:
    fd = 'Salesforce_Data.dbo.vCongressSenators'
    fieldNames = [f.name for f in arcpy.ListFields(fd)]
    queryString = "Senator = '" + s + "'"
    committeeList = []
    with arcpy.da.SearchCursor(fd, fieldNames, where_clause=queryString) as sCursor:
        for row in sCursor:
            committeeList.append(row[1].encode("utf8").rstrip())
            if row[5] is None:
                print "No State"
            else:
                sfID = row[0].encode("utf8").rstrip()
                senator = row[2].encode("utf8").rstrip()
                if senator.find("'") > -1:
                    senator = senator.replace("'", "")
                else:
                    senator = senator
                chamber = row[3].encode("utf8").rstrip()
                title = row[4].encode("utf8").rstrip()
                stateCoverage = row[5].encode("utf8").rstrip()[:2]
            
    ## Create cleaned list of committees
    committeeString = '; '.join(committeeList)
    if committeeString.find("'") > -1:
        committeeString = committeeString.replace("'", "")
    else:
        committeeString = committeeString
    #print committeeString


    ## Find next Object ID to continue incrementing
    pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'SenateFC', @myval OUTPUT SELECT @myval")
    #print "Used nextID"
    for thisrow in pyCursor.fetchall():
        nextID = thisrow[0]
        #print nextID
        
    insertFields = str(nextID) + ", '" + sfID + "', '" + committeeString + "', '"  + senator  + "', '" + chamber + "', '" + title + "', '" + stateCoverage + "'"
    outFields = 'ObjectID, ID, Committee, Senator, Chamber, Title, StateCoverage, SHAPE'
    sqlString = "Use Salesforce_Data Declare @g geometry; Set @g = (SELECT TOP (1) states.Shape FROM dbo.USSTATESAGOL AS states WHERE states.State_Abbr = " + "'" + stateCoverage + "') Insert into SenateFC(" + outFields + ") values (" + insertFields + ", @g)"
    #print sqlString
    pyCursor.execute(sqlString)
    connection.commit()

    print "Added Senator " + senator + " to table."



## Create set of House of Representative names
repSet = set()
lookupTable = 'Salesforce_Data.dbo.vCongressHouseRepresentatives'
lookupFields = ["Representative"]
with arcpy.da.SearchCursor(lookupTable, lookupFields) as lCursor:
    for row in lCursor:
        name = row[0].encode("utf8").rstrip()
        if name.find("'") > -1:
            name = name.replace("'", "")
        else:
            name = name
        repSet.add(name)
repList = list(set(repSet))
print repList

print "Created Representative Lookup Set."

## For each senator, create a list of the sub/committees he/she is on
for r in repList:
    fd = 'Salesforce_Data.dbo.vCongressHouseRepresentatives'
    fieldNames = [f.name for f in arcpy.ListFields(fd)]
    queryString = "Representative = '" + r + "'"
    committeeList = []
    with arcpy.da.SearchCursor(fd, fieldNames, where_clause=queryString) as sCursor:
        for row in sCursor:
            #print row
            committeeList.append(row[1].encode("utf8").rstrip())
            if row[3] is None:
                print "No Chamber"
            else:
                sfID = row[0].encode("utf8").rstrip()
                rep = row[2].encode("utf8").rstrip()
                chamber = row[3].encode("utf8").rstrip()
                title = row[4].encode("utf8").rstrip()
            #print row
        

    ## Create cleaned list of committees
    committeeString = '; '.join(committeeList)
    if committeeString.find("'") > -1:
        committeeString = committeeString.replace("'", "")
    else:
        committeeString = committeeString
    #print committeeString

    distString = "SELECT poly.CongDist FROM vCongressCongressionalDistrictPolygons as poly where poly.CongressPerson = '" + rep + "'"
    #print distString
    pyCursor.execute(distString)
    #print "Found Congressional District"

    try:
        for congRow in pyCursor.fetchone():
            congDist = congRow
            if congDist is None:
                congDist = ''
            #print congDist
    except:
        congDist = ''


    ## Find next Object ID to continue incrementing
    pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'HouseFC', @myval OUTPUT SELECT @myval")
    #print "Used nextID"
    for thisrow in pyCursor.fetchall():
        nextID = thisrow[0]
        #print nextID
        
    insertFields = str(nextID) + ", '" + sfID + "', '" + committeeString + "', '" + rep + "', '" + chamber + "', '" + title + "','" + congDist + "'"
    outFields = 'ObjectID, ID, Committee, Representative, Chamber, Title, CongressionalDistrict, SHAPE'
    sqlString = "Use Salesforce_Data Declare @g geometry; Set @g = (SELECT top (1) poly.Shape FROM vCongressCongressionalDistrictPolygons as poly where poly.CongressPerson = '" + rep + "') Insert into HouseFC(" + outFields + ") values (" + insertFields + ", @g)"
    #print sqlString
    pyCursor.execute(sqlString)
    connection.commit()

    print "Added Representative " + rep + " to table."


## Close/delete the cursor and the connection
pyCursor.close()
del pyCursor
connection.close()
