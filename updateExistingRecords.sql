USE [Salesforce_Data]
GO

update individualsfc
 set ParishAmbassador = 'No', ActionTaker = 'No', GrassrootsSupporter = 'No'

update institutionsfc
 set  ParishAmbassador = 'No',  CapacityBuildingInitiative = 'No'

update individualsfc
  set ParishAmbassador = 'Yes'
  from INDIVIDUALSFC as i, Relationships as r
  where i.id = R.From_Individual__c and r.Second_Relationship_type__c like '%PAC%'

update individualsfc
  set ActionTaker = 'Yes'
  from INDIVIDUALSFC as i, vActionTakers as a
  where i.id = a.Response_From__c

update individualsfc
  set GrassrootsSupporter = 'Yes'
  from INDIVIDUALSFC as i, Subscriptions as s
  where i.id = s.Subscriber__c

update institutionsfc
  set CapacityBuildingInitiative = 'Yes'
  from institutionsfc as i, Relationships as r
  where i.id = R.from_Institution__c and r.Second_Relationship_type__c like '%cbi%'

 update institutionsfc
  set ParishAmbassador = 'Yes'
  from institutionsfc as i, Relationships as r
  where i.id = R.to_Institution__c and r.Second_Relationship_type__c like '%parish ambassador (PAC)%'
  
GO