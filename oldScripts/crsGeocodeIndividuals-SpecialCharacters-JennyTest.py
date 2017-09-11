## Script created by Jenny Holder, Innovate! Inc. November 2016
## 
## Had to install pypyodbc, requests and copied here:
## C:\Python27\ArcGISx6410.4\Lib\site-packages
import arcpy, sets, pypyodbc, requests, ftfy

#cleanAddress = "3700 Rexmere Rd, Baltimore MD 21218-2010"
#cleanAddress = "Test2, Baltimore MD 21218-2010"
cleanAddress = ''
#response = requests.get('http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/find',
requestString = 'http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/findAddressCandidates?singleLine=' + cleanAddress + '&outFields=*&f=json&outSR=3857'
print requestString

response = requests.get(requestString)
response = response.json()

response = {u'candidates': [], u'spatialReference': {u'wkid': 102100, u'latestWkid': 3857}}
print response
print len(response['candidates'])

score = response['candidates'][0]['score']
print score
x = response['candidates'][0]['location']['x']
y = response['candidates'][0]['location']['y']
print x
print y

print '-------'
response = requests.get('http://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer/find',
                                            {'text': cleanAddress,
                                             'f': 'json',
                                             'outSR': '3857'})
response = requests.get(requestString)
response = response.json()
print response
