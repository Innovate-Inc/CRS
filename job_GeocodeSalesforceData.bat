REM Use series of python scripts to geocode new Salesforce Records added to the
REM Salesforce_Data SQL Server database
REM Created by Jenny Holder, Innovate! Inc., jholder@innovateteam.com
REM Updated August 2017

ECHO Start time: %date% %time%
ECHO Delete old records first...

REM US Ops Data Processing
sqlcmd -U sf_intregrationadmin -P JetterbitCRS -S 10.15.30.186 -i D:\Salesforce_Data\Scripts\crsTruncateTables_USOps.sql
ECHO Truncated GeocodeErrors, DonationsFC, RiceBowlsFC, ProjectsFC, SenateFC/HouseFC

ECHO Geocoding Institutions...
C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeInstitutions.py

ECHO Start time: %date% %time%

ECHO Geocoding Individuals...
C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeIndividuals.py

ECHO Start time: %date% %time%

sqlcmd -U sf_intregrationadmin -P JetterbitCRS -S 10.15.30.186 -i D:\Salesforce_Data\Scripts\updateExistingRecords.sql
ECHO Updated CBI/PAC in existing records

ECHO Start time: %date% %time%

ECHO Geocoding Donations...
C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeDonations.py

ECHO Geocoding Projects...
C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeProjects.py

ECHO Update Congress...
C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeCongress.py


REM Exec Suite Data Processing
sqlcmd -U sf_intregrationadmin -P JetterbitCRS -S 10.15.30.186 -i D:\Salesforce_Data\Scripts\crsTruncateTables_ExecSuite.sql
ECHO Truncated ExecutiveProjectsFC

ECHO Geocoding Executive Projects...
C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeExecProjects.py

ECHO Geocoding Executive Opportunities...
C:\Python27\ArcGIS10.4\python.exe D:\Salesforce_Data\Scripts\crsGeocodeExecOpportunities.py


ECHO End time: %date% %time%