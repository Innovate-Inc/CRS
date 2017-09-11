## Script created by Jenny Holder, Innovate! Inc.
## Created: December 2016
## Updated: September 2017
## Creates an exhaustive Projects table, including countries listed in associated DSPN records,
##      finds the most updated list of donors based on the awards table, and calculates
##      all fiscal years a project is/was active
## 
## May have to install pypyodbc, ftfy, html5lib, webencodings, wcwidth
import arcpy, pypyodbc, sys, ftfy
from unidecode import unidecode

## Create connection to SQL Server database and open a cursor
connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.230.244\dev;' 'Database=Salesforce_Data;' 'uid=jenny.holder;pwd=crs4fun')
#connection = pypyodbc.connect('Driver={SQL Server Native Client 11.0};' 'Server=10.15.30.186;' 'Database=Salesforce_Data;' 'uid=sf_intregrationadmin;pwd=JetterbitCRS')

pyCursor = connection.cursor()

print "Made connection."

## Point to the sde connection
arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.5\ArcCatalog\Salesforce_Data (dev).sde"
#arcpy.env.workspace = "C:\Users\jenny.holder\AppData\Roaming\Esri\Desktop10.5\ArcCatalog\Connection to 10.15.30.186.sde"
#arcpy.env.workspace = "D:\Salesforce_Data\Salesforce_Data.sde"

fd = 'Salesforce_Data.dbo.Projects'
fieldNames = [f.name for f in arcpy.ListFields(fd)]
print fieldNames
with arcpy.da.SearchCursor(fd, fieldNames) as sCursor:
    for row in sCursor:

        # Salesforce ID
        if row[0] is not None:
            sfID = row[0].encode("utf8").rstrip()
            # Create the Project link
            projLink =  'https://catholicreliefservices--crsfullsnd.cs53.my.salesforce.com/' + row[0].encode("utf8").rstrip()
            #projLink =  'https://catholicreliefservices.my.salesforce.com/' + row[0].encode("utf8").rstrip()
        else:
            projLink = '-'

        # Project Name
        if row[1] is None:
            projName = ''
        else:
            projName = ftfy.fix_text(row[1])
            projName = unidecode(projName)
            print projName + "--unidecode"
            projName = projName.replace("'", "''").rstrip()

        if row[3] is None:
            startDate = ''
        else:
            startDate = row[3]

        if row[4] is None:
            endDate = ''
        else:
            endDate = row[4]


        ## Find most updated donor records in Awards table
        pyCursor.execute("SELECT Donor__c FROM Award where Project__c = '" + row[0] + "'")
        try:
            donorList = 0
            projDonor1 = ''
            projDonor2 = ''
            projDonor3 = ''
            projDonor4 = ''
            projDonor5 = ''
            for thisrow in pyCursor.fetchall():
                print thisrow
                donorList = donorList + 1
                print "this is the position in the donorlist" + str(donorList)
                if donorList == 1:
                    pyCursor.execute("SELECT Name FROM Institutions where ID = '" + thisrow[0] + "'")
                    for thisDonor in pyCursor.fetchall():
                        #print thisDonor[0]
                        projDonor1 = ftfy.fix_text(thisDonor[0])
                        projDonor1 = unidecode(projDonor1)
                        projDonor1 = projDonor1.replace("'", "''").rstrip()
                        #print projDonor1 + " -- 1 donor after"
                    projDonor2 = ''
                    projDonor3 = ''
                    projDonor4 = ''
                    projDonor5 = ''
                if donorList == 2:
                    try:
                        pyCursor.execute("SELECT Name FROM Institutions where ID = '" + thisrow[0] + "'")
                        for thisDonor in pyCursor.fetchall():
                            #print thisDonor[0]
                            projDonor2 = ftfy.fix_text(thisDonor[0])
                            projDonor2 = unidecode(projDonor2)
                            projDonor2 = projDonor2.replace("'", "''").rstrip()
                            #print projDonor2 + " -- 2 donor after"
                        print projDonor2
                    except:
                        projDonor2 = ''
                        #print "No project Donor 2"
                elif donorList == 3:
                    try:
                        pyCursor.execute("SELECT Name FROM Institutions where ID = '" + thisrow[0] + "'")
                        for thisDonor in pyCursor.fetchall():
                            #print thisDonor[0]
                            projDonor3 = ftfy.fix_text(thisDonor[0])
                            projDonor3 = unidecode(projDonor3)
                            projDonor3 = projDonor3.replace("'", "''").rstrip()
                            #print projDonor3 + " -- 3 donor after"
                        print projDonor3
                    except:
                        projDonor3 = ''
                        #print "No project Donor 3"
                elif donorList == 4:
                    try:
                        pyCursor.execute("SELECT Name FROM Institutions where ID = '" + thisrow[0] + "'")
                        for thisDonor in pyCursor.fetchall():
                            #print thisDonor[0]
                            projDonor4 = ftfy.fix_text(thisDonor[0])
                            projDonor4 = unidecode(projDonor4)
                            projDonor4 = projDonor4.replace("'", "''").rstrip()
                            #print projDonor4 + " -- donor 4 after"
                        print projDonor4
                    except:
                        projDonor4 = ''
                        #print "No project Donor 4"
                elif donorList == 5:
                    try:
                        pyCursor.execute("SELECT Name FROM Institutions where ID = '" + thisrow[0] + "'")
                        for thisDonor in pyCursor.fetchall():
                            #print thisDonor[0]
                            projDonor5 = ftfy.fix_text(thisDonor[0])
                            projDonor5 = unidecode(projDonor5)
                            projDonor5 = projDonor5.replace("'", "''").rstrip()
                            #print projDonor5 + " -- 5 donor after"
                        print projDonor5
                    except:
                        projDonor5 = ''
                        #print "No project Donor 5"
            print "This many rows returned: " + str(donorList)
        except:
            projDonor1 = ''
            projDonor2 = ''
            projDonor3 = ''
            projDonor4 = ''
            projDonor5 = ''

        #print "-----------------------------"
        #print projDonor1
        #print projDonor2
        #print projDonor3
        #print projDonor4
        #print projDonor5
        print "-----------------------------"

        # Region
        if row[7] is not None:
            region = row[7].encode("utf8").rstrip()
        else:
            region = '-'


        # Find list of fiscal years project is active
        #     Fiscal year defined October 1, Year - September 30, Year+1
        if row[3] is None or row[4] is None:
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


        ## Find any other countries listed for a project in DSPNs not already listed on a project record
        ## **Note: country field is editable on both Project (parent) and DSPN (child) SF records, and therefore
        ##      do not always match.**   
        countryNames = []
        pyCursor.execute("SELECT Country_New__c FROM DSPN where Project__c = '" + row[0] + "'")
        try:
            for thisrow in pyCursor.fetchall():
                if thisrow[0] not in countryNames:
                    countryNames.append(thisrow[0].encode("utf8"))
            print "Found these in DSPN records " + str(countryNames)
        except:
            print "No other DSPN countries"


        # Find list of country names listed on a project record
        if row[2] is None:
            country = ''
            
        # If multiple countries are listed on a project record, parse the list apart and cross-reference against DSPN country list
        elif row[2].find(";") > -1:
            countryList = row[2].encode("utf8").rstrip().split(";")
            print "This is countryList: " + str(countryList)
            for c in countryList:
                if c not in countryNames:
                    countryNames.append(c)
            print "This is countryNames after appending: " + str(countryNames) 


            # Write a new record with all project information for each country in the full list
            for indvCountry in countryNames:
                
                ## Find next Object ID to continue incrementing
                pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'ExecutiveProjectsFC', @myval OUTPUT SELECT @myval")
                for thisrow in pyCursor.fetchall():
                    nextID = thisrow[0]
                    #print nextID
        
                insertFields = str(nextID) + ", '" + projLink + "', '" + sfID + "', '" + projName + "', '"  + indvCountry  + "', '" + fyString + "', '" + str(startDate) + "', '" + str(endDate) + "', '"  + projDonor1 + "', '" + projDonor2 + "', '" + projDonor3 + "', '" + projDonor4 + "', '" + projDonor5 + "', '" + region + "', '" + str(row[12]) + "', '" + str(row[13]) + "'"
                outFields = 'ObjectID, ProjectLink, ID, Name, Country_New__c, FY, Start_Date__c, End_Date__c, Project_Donor__c, Project_Donor_2__c, Project_Donor_3__c, Project_Donor_4__c, Project_Donor_5__c, Region__c, Program_Areas__c, Program_Areas_Service_Areas__c, Shape'
                sqlString = "Use Salesforce_Data Declare @g geometry; Set @g = (SELECT poly.Shape FROM countriesAGOL as poly where poly.country = '" + country + "') Insert into ExecutiveProjectsFC (" + outFields + ") values (" + insertFields + ", @g)"
                print sqlString
                pyCursor.execute(sqlString)
                connection.commit()
             

        # If only one country is listed on the project, check for other countries listed on the DPSN record    
        else:
            country = row[2].encode("utf8").rstrip()
            #print country

            if country not in countryNames:
                countryNames.append(country)
                print "Here are independent countries" + str(countryNames)
            else:
                print countryNames
                
            # Write a new record with all project information for each country in the full list
            for indvCountry in countryNames:
                ## Find next Object ID to continue incrementing
                pyCursor.execute("DECLARE @myval int EXEC dbo.next_rowid 'dbo', 'ExecutiveProjectsFC', @myval OUTPUT SELECT @myval")
                for thisrow in pyCursor.fetchall():
                    nextID = thisrow[0]

                insertFields = str(nextID) + ", '" + projLink + "', '" + sfID + "', '" + projName + "', '"  + indvCountry + "', '" + fyString + "', '" + str(startDate) + "', '" + str(endDate) + "', '"  + projDonor1 + "', '" + projDonor2 + "', '" + projDonor3 + "', '" + projDonor4 + "', '" + projDonor5 + "', '" + region + "', '" + str(row[12]) + "', '" + str(row[13]) + "'"
                outFields = 'ObjectID, ProjectLink, ID, Name, Country_New__c, FY, Start_Date__c, End_Date__c, Project_Donor__c, Project_Donor_2__c, Project_Donor_3__c, Project_Donor_4__c, Project_Donor_5__c, Region__c, Program_Areas__c, Program_Areas_Service_Areas__c, Shape'            
                sqlString = "Use Salesforce_Data Declare @g geometry; Set @g = (SELECT poly.Shape FROM countriesAGOL as poly where poly.country = '" + country + "') Insert into ExecutiveProjectsFC (" + outFields + ") values (" + insertFields + ", @g)"
                print sqlString
                pyCursor.execute(sqlString)
                connection.commit()


## Close/delete the cursor and the connection
pyCursor.close()
del pyCursor
connection.close()
           
