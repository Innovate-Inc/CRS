REM Use series of python scripts to geocode new Salesforce Records added to the
REM Salesforce_Data SQL Server database
REM Created by Jenny Holder, Innovate! Inc., jholder@innovateteam.com
REM April 2017

REM Exec Suite Data Weekly Run and Grassroots/Grasstops

ECHO Start time: %date% %time%

REM Grassroots and Grasstops Weekly Run
ECHO Geocoding Grassroots and Grasstops...
C:\Python27\ArcGIS10.5\python.exe D:\Salesforce_Data\Scripts\crsGeocodeIndividuals-Dev-Grassroots.py

ECHO Start time: %date% %time%
sqlcmd -U jenny.holder -P crs4fun -S 10.15.230.244\dev -i D:\Salesforce_Data\Scripts\updateExistingRecords.sql
ECHO Updated existing records

REM This also updates Overseas Projects in US Ops Map
ECHO Start time: %date% %time%

sqlcmd -U jenny.holder -P crs4fun -S 10.15.230.244\dev -i D:\Salesforce_Data\Scripts\crsTruncateTables_ExecSuite.sql
ECHO Truncated ExecutiveProjectsFC

ECHO Start time: %date% %time%
ECHO Geocoding Executive Projects...
C:\Python27\ArcGIS10.5\python.exe D:\Salesforce_Data\Scripts\crsGeocodeExecProjects_DEV.py

ECHO Start time: %date% %time%
ECHO Geocoding Executive Opportunities...
C:\Python27\ArcGIS10.5\python.exe D:\Salesforce_Data\Scripts\crsGeocodeExecOpportunities_DEV.py

ECHO End time: %date% %time%