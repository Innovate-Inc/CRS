REM Use series of python scripts to geocode new Salesforce Records added to the
REM Salesforce_Data SQL Server database
REM Created by Jenny Holder, Innovate! Inc., jholder@innovateteam.com
REM December 2016

ECHO Start time: %date% %time%
ECHO Delete old records first...

sqlcmd -U jenny.holder -P crs4fun -S 10.15.230.244\dev -i D:\Salesforce_Data\Scripts\crsTruncateTables_Dev.sql
ECHO Truncated GeocodeErrors, DonationsFC, RiceBowlsFC, ProjectsFC, ExecutiveProjectsFC, SenateFC/HouseFC

ECHO Geocoding Institutions...
REM C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeInstitutions.py

ECHO Start time: %date% %time%

ECHO Geocoding Individuals...
REM C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeIndividuals.py

ECHO Start time: %date% %time%

REM sqlcmd -U jenny.holder -P crs4fun -S 10.15.230.244\dev -i D:\Salesforce_Data\Scripts\updateExistingRecords.sql
ECHO Updated CBI/PAC in existing records

ECHO Start time: %date% %time%

ECHO Geocoding Donations...
REM C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeDonations.py

ECHO Geocoding Projects...
REM C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeProjects.py

ECHO Geocoding Executive Projects...
C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeExecProjects_Dev.py

ECHO Geocoding Opportunities...
C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeExecOpportunities_Dev.py

ECHO Update Congress...
REM C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeCongress.py

ECHO End time: %date% %time%