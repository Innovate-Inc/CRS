CREATE VIEW [dbo].[vExecutiveProjects]
AS
SELECT        p.Name, p.Country_New__c AS Country, p.Region__c AS Region, p.Program_Areas__c AS ProgramAreas, p.Program_Areas_Service_Areas__c AS ProgramAreasServiceAreas, p.Start_Date__c AS StartDate, 
                         p.End_Date__c AS EndDate, p.Project_Donor__c AS ProjectDonor1, p.Project_Donor_2__c AS ProjectDonor2, p.Project_Donor_3__c AS ProjectDonor3, p.Project_Donor_4__c AS ProjectDonor4, 
                         p.Project_Donor_5__c AS ProjectDonor5, poly.Shape
FROM            dbo.EXECUTIVEPROJECTSFC AS p INNER JOIN
                         dbo.COUNTRIESAGOL AS poly ON p.Country_New__c = poly.Country
WHERE        (poly.Shape.STIsValid() = 1) AND (poly.Shape IS NOT NULL)


CREATE VIEW [dbo].[vExecutiveTotalProjects]
AS
SELECT DISTINCT COUNT(ID) AS TotalProjects, FY, Country_New__c, Program_Areas__c
FROM            dbo.EXECUTIVEPROJECTSFC
GROUP BY Country_New__c, FY, Program_Areas__c

CREATE VIEW [dbo].[vExecutiveTotalDSPNs]
AS
SELECT DISTINCT 
                         COUNT(ID) AS TotalDSPNs, Reporting_FY_Period_s__c, Country_New__c, Program_Areas__c, SUM(FY_to_Date_Expenditures__c) AS FY_to_Date_Expend, SUM(Current_FY_Amended_Budget__c) 
                         AS Current_FY_Amend_Budget, SUM(Incept_to_Date_Expend__c) AS Incept_To_Date_Expend, SUM(Obligated_Pledge_Commit_Amt__c) AS Obligated_Amount
FROM            dbo.DSPN AS d
GROUP BY Country_New__c, Reporting_FY_Period_s__c, Program_Areas__c


CREATE VIEW [dbo].[vExecutiveTotalBSDIs]
AS
SELECT        d.Country_New__c AS Country, b.Program_Areas__c, COUNT(b.ID) AS TotalBSDIs, SUM(b.Beneficiaries_Direct__c) AS Beneficiaries_Direct__c, SUM(b.Beneficiaries_Indirect__c) AS Beneficiaries_Indirect__c, 
                         b.Fiscal_Year__c
FROM            dbo.BSDI AS b INNER JOIN
                         dbo.DSPN AS d ON d.ID = b.DSPN__c
GROUP BY d.Country_New__c, b.Program_Areas__c, b.Fiscal_Year__c



create view [dbo].[vExecutiveProjectsAgricultureFY2014] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%') AND (Program_Areas__c LIKE '%Agriculture%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%') AND (Program_Areas__c LIKE '%Agriculture%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Agriculture%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)

create view [dbo].[vExecutiveProjectsAgricultureFY2015] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%') AND (Program_Areas__c LIKE '%agriculture%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%agriculture%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%agriculture%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)

create view [dbo].[vExecutiveProjectsAgricultureFY2016] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2016%') AND (Program_Areas__c LIKE '%agriculture%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2016%') AND (Program_Areas__c LIKE '%agriculture%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%agriculture%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



create view [dbo].[vExecutiveProjectsCapacityStrengtheningFY2014] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%') AND (Program_Areas__c LIKE '%Capacity Strengthening%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%') AND (Program_Areas__c LIKE '%Capacity Strengthening%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Capacity Strengthening%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsCapacityStrengtheningFY2015] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%') AND (Program_Areas__c LIKE '%Capacity Strengthening%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%Capacity Strengthening%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Capacity Strengthening%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)

create view [dbo].[vExecutiveProjectsCapacityStrengtheningFY2016] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2016%') AND (Program_Areas__c LIKE '%Capacity Strengthening%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2016%') AND (Program_Areas__c LIKE '%Capacity Strengthening%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Capacity Strengthening%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



create view [dbo].[vExecutiveProjectsEducationFY2014] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%') AND (Program_Areas__c LIKE '%Education%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%') AND (Program_Areas__c LIKE '%Education%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Education%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsEducationFY2015] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%') AND (Program_Areas__c LIKE '%Education%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%Education%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Education%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



create view [dbo].[vExecutiveProjectsEducationFY2016] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2016%') AND (Program_Areas__c LIKE '%Education%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2016%') AND (Program_Areas__c LIKE '%Education%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Education%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)

create view [dbo].[vExecutiveProjectsEmergencyFY2014] as
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%') AND (Program_Areas__c LIKE '%Emergency%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%') AND (Program_Areas__c LIKE '%Emergency%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Emergency%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)

create view [dbo].[vExecutiveProjectsEmergencyFY2015] as
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%') AND (Program_Areas__c LIKE '%Emergency%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%Emergency%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Emergency%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsEmergencyFY2016] as
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2016%') AND (Program_Areas__c LIKE '%Emergency%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2016%') AND (Program_Areas__c LIKE '%Emergency%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Emergency%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)