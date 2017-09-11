REM Use series of python scripts to geocode new Salesforce Records added to the
REM Salesforce_Data SQL Server database
REM Created by Jenny Holder, Innovate! Inc., jholder@innovateteam.com
REM Updated August 2017

ECHO Start time: %date% %time%
ECHO Delete old records first...

REM US Ops ALL Data Bi-Monthly Run
sqlcmd -U jenny.holder -P crs4fun -S 10.15.230.244\dev -i D:\Salesforce_Data\Scripts\crsTruncateTables_USOps.sql
ECHO Truncated GeocodeErrors, DonationsFC, RiceBowlsFC, ProjectsFC, SenateFC/HouseFC

ECHO Start time: %date% %time%

ECHO Geocoding Institutions...
C:\Python27\ArcGIS10.5\python.exe D:\Salesforce_Data\Scripts\crsGeocodeInstitutions-Dev.py

ECHO Start time: %date% %time%

ECHO Geocoding Individuals...
C:\Python27\ArcGIS10.5\python.exe D:\Salesforce_Data\Scripts\crsGeocodeIndividuals-Dev.py

ECHO Start time: %date% %time%

sqlcmd -U jenny.holder -P crs4fun -S 10.15.230.244\dev -i D:\Salesforce_Data\Scripts\updateExistingRecords.sql
ECHO Updated CBI/PAC in existing records

ECHO Start time: %date% %time%

ECHO Geocoding Donations...
C:\Python27\ArcGIS10.5\python.exe D:\Salesforce_Data\Scripts\crsGeocodeDonations.py

ECHO Update Congress...
C:\Python27\ArcGIS10.5\python.exe D:\Salesforce_Data\Scripts\crsGeocodeCongress.py

ECHO End time: %date% %time%