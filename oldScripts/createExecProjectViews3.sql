CREATE VIEW [dbo].[vExecutiveProjectsAgricultureFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%') AND (Program_Areas__c LIKE '%Agriculture%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%') AND (Program_Areas__c LIKE '%Agriculture%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Agriculture%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



CREATE VIEW [dbo].[vExecutiveProjectsCapacityStrengtheningFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%') AND (Program_Areas__c LIKE '%Capacity Strengthening%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%') AND (Program_Areas__c LIKE '%Capacity Strengthening%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Capacity Strengthening%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



CREATE VIEW [dbo].[vExecutiveProjectsEducationFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%') AND (Program_Areas__c LIKE '%Education%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%') AND (Program_Areas__c LIKE '%Education%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Education%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



CREATE VIEW [dbo].[vExecutiveProjectsEmergencyFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%') AND (Program_Areas__c LIKE '%Emergency%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%') AND (Program_Areas__c LIKE '%Emergency%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Emergency%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



CREATE VIEW [dbo].[vExecutiveProjectsFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



CREATE VIEW [dbo].[vExecutiveProjectsHealthFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%') AND (Program_Areas__c LIKE '%Health%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%') AND (Program_Areas__c LIKE '%Health%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Health%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



CREATE VIEW [dbo].[vExecutiveProjectsHIVAIDSFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%') AND (Program_Areas__c LIKE '%HIV/AIDS%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%') AND (Program_Areas__c LIKE '%HIV/AIDS%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%HIV/AIDS%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



CREATE VIEW [dbo].[vExecutiveProjectsMicrofinanceFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%') AND (Program_Areas__c LIKE '%Microfinance%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%') AND (Program_Areas__c LIKE '%Microfinance%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Microfinance%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



CREATE VIEW [dbo].[vExecutiveProjectsPeacebuildingFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%') AND (Program_Areas__c LIKE '%Peacebuilding%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%') AND (Program_Areas__c LIKE '%Peacebuilding%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Peacebuilding%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



CREATE VIEW [dbo].[vExecutiveProjectsSafetyNetFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%') AND (Program_Areas__c LIKE '%Safety Net%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%') AND (Program_Areas__c LIKE '%Safety Net%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Safety Net%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



CREATE VIEW [dbo].[vExecutiveProjectsWaterSanitationFY2017]
AS
SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2017%') AND (Program_Areas__c LIKE '%Water and Sanitation%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2017%') AND (Program_Areas__c LIKE '%Water and Sanitation%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Water and Sanitation%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)