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
  
update individualsfc
  set Relationship_Types__c = indv.Relationship_Types__c, Name=indv.Name, Title__C = indv.Title__c,
  AccountID=indv.AccountID, kw__Chamber__c= indv.kw__Chamber__c, kw__StateOfCoverage__c=indv.kw__StateOfCoverage__c
  from INDIVIDUALSFC as i, Individuals as indv
  where i.id = indv.ID
  
 update INSTITUTIONSFC
  set Relationship_Types__c = inst.Relationship_Types__c, Name=inst.Name, Institution_Type__c=inst.Institution_Type__c,
  Institution_Sub_Type__c=inst.Institution_Sub_Type__c, Institution_Sub_Sub_Type__c=inst.Institution_Sub_Sub_Type__c,
  Region__c=inst.Region__c, ParentID=inst.ParentID, District__c=inst.District__c, Cath_Pop__c=inst.Cath_Pop__c,
  Hisp_Cath_pop__c=inst.Hisp_Cath_Pop__c, Num_Cath_High_Schools__c=inst.Num_Cath_High_Schools__c, 
  Num_Cath_K8_Schools__c=inst.Num_Cath_K_8_Schools__c, Num_Parishes__c=inst.Num_Parishes__c, 
  Interactions_6_Months__c=inst.of_interactions_6_Months__c, Interactions_12_Months__c= inst.of_Interactions_12_Months__c,
  Institutional_Affiliation__c=inst.Institutional_Affiliation__c
  from INSTITUTIONSFC as i, Institutions as inst
  where i.id = inst.ID
  
GO