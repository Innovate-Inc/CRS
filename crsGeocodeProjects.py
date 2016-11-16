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

fd = 'CRSSalesforce.dbo.Projects'
fieldNames = [f.name for f in arcpy.ListFields(fd)]
print fieldNames
with arcpy.da.SearchCursor(fd, fieldNames) as sCursor:
    for row in sCursor:
        print row

        # Salesforce ID
        if row[0] is not None:
            sfID = row[0].encode("utf8").rstrip()

        # Project Name
        if row[1] is None:
            projName = ''
        elif row[1].find("'") > -1:
            projName = row[1].replace("'", "").encode("utf8").rstrip()
        else:
            projName = row[1].encode("utf8").rstrip()

        # Project Name
        if row[6] is not None:
            projDonor = row[6].encode("utf8").rstrip()
        else:
            projDonor = '-'

        # Project Name
        if row[7] is None:
            projDonor2 = '-'
        else:
            projDonor2 = row[7].encode("utf8").rstrip()

        # Project Name
        if row[8] is not None:
            projDonor3 = row[8].encode("utf8").rstrip()
        else:
            projDonor3 = '-'    

        # Project Name
        if row[9] is not None:
            projDonor4 = row[9].encode("utf8").rstrip()
        else:
            projDonor4 = '-'

        # Project Name
        if row[10] is not None:
            projDonor5 = row[10].encode("utf8").rstrip()
        else:
            projDonor5 = '-'

            
        countryNames = []
        # Find list of country names
        if row[2] is None:
            country = ''
            # need to log this as an error somewhere?
            
        elif row[2].find(";") > -1:
            countryList = row[2].encode("utf8").split(";")
            num = 0
            for country in countryList:
                print "this is in a list " + str(num) + " " + country.rstrip()
                num = num + 1
                print sfID + " " + projName + " " + country + " " + str(num) + " " + projDonor + " " + projDonor2 + " " + projDonor3 + " " + projDonor4 + " " + projDonor5

                ## Find next Object ID to continue incrementing
                pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'ProjectsFC', @myval OUTPUT SELECT @myval")
                for thisrow in pyCursor.fetchall():
                    nextID = thisrow[0]
                    print nextID
        
                insertFields = str(nextID) + ", '" + sfID + "', '" + projName + "', '"  + country  + "', '" + projDonor + "', '" + projDonor2 + "', '" + projDonor3 + "', '" + projDonor4 + "', '" + projDonor5 + "'"
                outFields = 'ObjectID, ID, Name, Country_New__c, Project_Donor__c, Project_Donor_2__c, Project_Donor_3__c, Project_Donor_4__c, Project_Donor_5__c, Shape'
                sqlString = "Use CRSSalesforce Declare @g geometry; Set @g = (SELECT poly.Shape FROM worldcountries as poly where poly.Name = '" + country + "') Insert into ProjectsFC(" + outFields + ") values (" + insertFields + ", @g)"
                print sqlString
                pyCursor.execute(sqlString)
                connection.commit()
                
        else:
            country = row[2].encode("utf8").rstrip()
            print sfID + " " + projName + " " + country + " " + projDonor

            ## Find next Object ID to continue incrementing
            pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'ProjectsFC', @myval OUTPUT SELECT @myval")
            for thisrow in pyCursor.fetchall():
                nextID = thisrow[0]
                print nextID

            insertFields = str(nextID) + ", '" + sfID + "', '" + projName + "', '"  + country  + "', '" + projDonor + "', '" + projDonor2 + "', '" + projDonor3 + "', '" + projDonor4 + "', '" + projDonor5 + "'"
            outFields = 'ObjectID, ID, Name, Country_New__c, Project_Donor__c, Project_Donor_2__c, Project_Donor_3__c, Project_Donor_4__c, Project_Donor_5__c, Shape'
            sqlString = "Use CRSSalesforce Declare @g geometry; Set @g = (SELECT poly.Shape FROM worldcountries as poly where poly.Name = '" + country + "') Insert into ProjectsFC(" + outFields + ") values (" + insertFields + ", @g)"
            print sqlString
            pyCursor.execute(sqlString)
            connection.commit()
           
