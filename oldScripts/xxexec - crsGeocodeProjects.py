## Script created by Jenny Holder, Innovate! Inc. September 2016
## 
## May have to install pypyodbc
import arcpy, pypyodbc, sys

## Create connection to SQL Server database and open a cursor
connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.230.244\dev;' 'Database=Salesforce_Data;' 'uid=jenny.holder;pwd=crs4fun')
#connection = pypyodbc.connect('Driver={SQL Server};' 'Server=localhost\sqlexpress;' 'Database=CRS;' 'uid=JSONDataWriter;pwd=Write$om3Data4fun!')
#connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0}; Server=localhost\sqlexpress; Database=CRSSalesforce; uid=JSONDataWriter;pwd=Write$om3Data4fun!')
pyCursor = connection.cursor()

## Point to the sde connection
arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.4\ArcCatalog\Salesforce_Data (dev).sde"
#arcpy.env.workspace = "C:\Users\jholder\AppData\Roaming\ESRI\Desktop10.4\ArcCatalog\CRSSalesforce.sde"

fd = 'Salesforce_Data.dbo.Projects'
fieldNames = [f.name for f in arcpy.ListFields(fd)]
print fieldNames
with arcpy.da.SearchCursor(fd, fieldNames) as sCursor:
    for row in sCursor:

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

##        # Project Donor 1
##        if row[6] is not None:
##            projDonor =  'https://catholicreliefservices--crsfullsnd.cs30.my.salesforce.com/' + row[6].encode("utf8").rstrip()
##        else:
##            projDonor = '-'
##
##        # Project Donor 2
##        if row[8] is None:
##            projDonor2 = '-'
##        else:
##            projDonor2 = 'https://catholicreliefservices--crsfullsnd.cs30.my.salesforce.com/' + row[8].encode("utf8").rstrip()
##
##        # Project Donor 3
##        if row[9] is not None:
##            projDonor3 = 'https://catholicreliefservices--crsfullsnd.cs30.my.salesforce.com/' + row[9].encode("utf8").rstrip()
##        else:
##            projDonor3 = '-'    
##
##        # Project Donor 4
##        if row[10] is not None:
##            projDonor4 = 'https://catholicreliefservices--crsfullsnd.cs30.my.salesforce.com/' + row[10].encode("utf8").rstrip()
##        else:
##            projDonor4 = '-'
##
##        # Project Donor 5
##        if row[11] is not None:
##            projDonor5 = 'https://catholicreliefservices--crsfullsnd.cs30.my.salesforce.com/' + row[11].encode("utf8").rstrip()
##        else:
##            projDonor5 = '-'

        ## Find most updated donor records in Awards table
        pyCursor.execute("SELECT Donor__c FROM Award where Project__c = '" + row[0] + "'")
        try:
            donorList = 0
            for thisrow in pyCursor.fetchall():
                donorList = donorList + 1
                if donorList == 1:
                    projDonor1 = 'https://catholicreliefservices--crsfullsnd.cs30.my.salesforce.com/' + thisrow[0].encode("utf8").rstrip()
                    print projDonor1
                    projDonor2 = ''
                    projDonor3 = ''
                    projDonor4 = ''
                    projDonor5 = ''
                if donorList == 2:
                    try:
                        projDonor2 = 'https://catholicreliefservices--crsfullsnd.cs30.my.salesforce.com/' + thisrow[0].encode("utf8").rstrip()
                        print projDonor2
                    except:
                        projDonor2 = ''
                        print "No project Donor 2"
                elif donorList == 3:
                    try:
                        projDonor3 = 'https://catholicreliefservices--crsfullsnd.cs30.my.salesforce.com/' + thisrow[0].encode("utf8").rstrip()
                        print projDonor3
                    except:
                        projDonor3 = ''
                        print "No project Donor 3"
                elif donorList == 4:
                    try:
                        projDonor4 = 'https://catholicreliefservices--crsfullsnd.cs30.my.salesforce.com/' + thisrow[0].encode("utf8").rstrip()
                        print projDonor4
                    except:
                        projDonor4 = ''
                        print "No project Donor 4"
                elif donorList == 5:
                    try:
                        projDonor5 = 'https://catholicreliefservices--crsfullsnd.cs30.my.salesforce.com/' + thisrow[0].encode("utf8").rstrip()
                        print projDonor5
                    except:
                        projDonor5 = ''
                        print "No project Donor 5"
            print "This many rows returned: " + str(donorList)
        except:
            #sys.exit("No Donor")
            projDonor1 = ''
            projDonor2 = ''
            projDonor3 = ''
            projDonor4 = ''
            projDonor5 = ''

        # Region
        if row[7] is not None:
            region = row[7].encode("utf8").rstrip()
        else:
            region = '-'


        # Find list of fiscal years project is active
        if row[3] is None:
            fYears = ''
            
        else:
           # print row[3]
            fyBeg = row[3]

            if fyBeg.month < 10:
                #print "September or less"
                begYear = fyBeg.year
                #print begYear
            elif fyBeg.month > 10:
                #print "October or more"
                begYear = fyBeg.year + 1
                #print begYear

            fyEnd = row[4]
            if fyEnd.month < 10:
                #print "September or less"
                endYear = fyEnd.year
                #print endYear
            elif fyEnd.month > 10:
                #print "October or more"
                endYear = fyEnd.year + 1
                #print endYear

            fYears = [begYear, endYear]
            for i in range(begYear, endYear):
                if i not in fYears:
                    fYears.append(i)
            fyString = str(fYears)
            fyString = fyString.replace('[', '')
            fyString = fyString.replace(']', '')

            #print fyString  

            
        countryNames = []
        # Find list of country names
        if row[2] is None:
            country = ''
            # need to log this as an error somewhere
            
        elif row[2].find(";") > -1:
            print row
            countryList = row[2].encode("utf8").rstrip().split(";")
            totalCountries = len(countryList)
            print totalCountries

            

            #sys.exit("Found divided countries")

            # Write a new record with the appropriate protion of funds for each country
            for country in countryList:
                
                #print sfID + " " + projName + " " + country + " " + str(num) + " " + projDonor + " " + projDonor2 + " " + projDonor3 + " " + projDonor4 + " " + projDonor5

                ## Find next Object ID to continue incrementing
                pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'EXECPROJECTsbyCountry2', @myval OUTPUT SELECT @myval")
                for thisrow in pyCursor.fetchall():
                    nextID = thisrow[0]
                    #print nextID
        
                insertFields = str(nextID) + ", '" + sfID + "', '" + projName + "', '"  + country  + "', '" + fyString + "', '" + str(row[3]) + "', '" + str(row[4]) + "', '"  + projDonor1 + "', '" + projDonor2 + "', '" + projDonor3 + "', '" + projDonor4 + "', '" + projDonor5 + "', '" + region + "', '" + str(row[12]) + "', '" + str(row[13]) + "'"
                outFields = 'ObjectID, ID, Name, Country_New__c, FY, Start_Date__c, End_Date__c, Project_Donor__c, Project_Donor_2__c, Project_Donor_3__c, Project_Donor_4__c, Project_Donor_5__c, Region__c, Program_Areas__c, Program_Areas_Service_Areas__c, Shape'
                sqlString = "Use Salesforce_Data Declare @g geometry; Set @g = (SELECT poly.Shape FROM countriesAGOL as poly where poly.country = '" + country + "') Insert into EXECPROJECTsbyCountry2 (" + outFields + ") values (" + insertFields + ", @g)"
                print sqlString
                pyCursor.execute(sqlString)
                connection.commit()

                #sys.exit("Found divided countries")
                
        else:
            pass
##            sys.exit("Not here")
##            country = row[2].encode("utf8").rstrip()
##            #print sfID + " " + projName + " " + country + " " + projDonor1
##
##            ## Find next Object ID to continue incrementing
##            pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'EXECPROJECTsbyCountry2', @myval OUTPUT SELECT @myval")
##            for thisrow in pyCursor.fetchall():
##                nextID = thisrow[0]
##                #print nextID
##
##            ## Find most updated donor records in Awards table
##            pyCursor.execute("SELECT Donor__c FROM Award where Project__c = '" + row[0] + "'")
##            print pyCursor.description
##
##            #insertFields = str(nextID) + ", '" + sfID + "', '" + projName + "', '"  + country  + "', '" + projDonor + "', '" + projDonor2 + "', '" + projDonor3 + "', '" + projDonor4 + "', '" + projDonor5 + "', '" + region + "', '" + str(row[12]) + "', '" + str(row[13]) + "', '" + str(row[14]) + "', '" + str(row[15]) + "', '" + str(row[16]) + "', '" + str(row[17]) + "', '" + str(row[18]) + "', '" + str(row[19]) + "', '" + str(row[20]) + "', '" + str(row[21]) + "'"
##            #outFields = 'ObjectID, ID, Name, Country_New__c, Project_Donor__c, Project_Donor_2__c, Project_Donor_3__c, Project_Donor_4__c, Project_Donor_5__c, Region__c, Program_Areas__c, Program_Areas_Service_Areas__c, Program_Manager__c, Award_Obligated_Amount__c, Incept_to_Date_Expend__c, Current_FY_Amended_Budget__c, FY_to_Date_Expenditures__c, Act_Direct_Beneficiaries__c, Act_Indirect_Beneficiaries__c, Total_Beneficiaries__c, Shape'
##            insertFields = str(nextID) + ", '" + sfID + "', '" + projName + "', '"  + country  + "', '" + fyString + "', '" + str(row[3]) + "', '" + str(row[4]) + "', '"  + projDonor1 + "', '" + projDonor2 + "', '" + projDonor3 + "', '" + projDonor4 + "', '" + projDonor5 + "', '" + region + "', '" + str(row[12]) + "', '" + str(row[13]) + "'"
##            outFields = 'ObjectID, ID, Name, Country_New__c, FY, Start_Date__c, End_Date__c, Project_Donor__c, Project_Donor_2__c, Project_Donor_3__c, Project_Donor_4__c, Project_Donor_5__c, Region__c, Program_Areas__c, Program_Areas_Service_Areas__c, Shape'            
##
##            sqlString = "Use Salesforce_Data Declare @g geometry; Set @g = (SELECT poly.Shape FROM countriesAGOL as poly where poly.country = '" + country + "') Insert into EXECPROJECTsbyCountry2 (" + outFields + ") values (" + insertFields + ", @g)"
##            print sqlString
##            pyCursor.execute(sqlString)
##            connection.commit()


## Close/delete the cursor and the connection
pyCursor.close()
del pyCursor
connection.close()
           
