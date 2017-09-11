# -*- coding: cp1252 -*-
## Script created by Jenny Holder, Innovate! Inc. December 2016
## Creates feature class of all opportunties for Exec Suite export (not currently in any maps)
## 
import arcpy,  ftfy

#cleanName = "Me-Jenny"
cleanName = "RFA – Cooperative Agreement"
print cleanName
#unicode('\x80abc', errors='ignore')
if '-' in cleanName:
    #cleanName = cleanName.replace("–", "-").rstrip()
    #cleanName = cleanName.encode('utf-8')
    print "inside " + cleanName
    cleanName = ftfy.fix_text(cleanName)
print cleanName
