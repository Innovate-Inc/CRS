create view [dbo].[vExecutiveProjectsFY2014] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



create view [dbo].[vExecutiveProjectsFY2015] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsFY2016] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2016%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2016%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



create view [dbo].[vExecutiveProjectsHealthFY2014] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%') AND (Program_Areas__c LIKE '%Health%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%') AND (Program_Areas__c LIKE '%Health%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Health%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)

create view [dbo].[vExecutiveProjectsHealthFY2015] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%') AND (Program_Areas__c LIKE '%Health%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%Health%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Health%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsHealthFY2016] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2016%') AND (Program_Areas__c LIKE '%Health%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2016%') AND (Program_Areas__c LIKE '%Health%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Health%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



create view [dbo].[vExecutiveProjectsHIVAIDSFY2014] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%') AND (Program_Areas__c LIKE '%HIV/AIDS%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%') AND (Program_Areas__c LIKE '%HIV/AIDS%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%HIV/AIDS%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsHIVAIDSFY2015] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%') AND (Program_Areas__c LIKE '%HIV/AIDS%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%HIV/AIDS%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%HIV/AIDS%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



create view [dbo].[vExecutiveProjectsHIVAIDSFY2016] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2016%') AND (Program_Areas__c LIKE '%HIV/AIDS%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2016%') AND (Program_Areas__c LIKE '%HIV/AIDS%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%HIV/AIDS%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsMicrofinanceFY2014] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%') AND (Program_Areas__c LIKE '%Microfinance%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%') AND (Program_Areas__c LIKE '%Microfinance%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Microfinance%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsMicrofinanceFY2015] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015') AND (Program_Areas__c LIKE '%Microfinance%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%Microfinance%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Microfinance%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)

create view [dbo].[vExecutiveProjectsMicrofinanceFY2016] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2016%') AND (Program_Areas__c LIKE '%Microfinance%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2016%') AND (Program_Areas__c LIKE '%Microfinance%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Microfinance%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsPeacebuildingFY2014] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%') AND (Program_Areas__c LIKE '%Peacebuilding%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%') AND (Program_Areas__c LIKE '%Peacebuilding%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Peacebuilding%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsPeacebuildingFY2015] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%') AND (Program_Areas__c LIKE '%Peacebuilding%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%Peacebuilding%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Peacebuilding%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsPeacebuildingFY2016] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2016%') AND (Program_Areas__c LIKE '%Peacebuilding%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2016%') AND (Program_Areas__c LIKE '%Peacebuilding%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Peacebuilding%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



create view [dbo].[vExecutiveProjectsSafetyNetFY2014] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%') AND (Program_Areas__c LIKE '%Safety Net%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%') AND (Program_Areas__c LIKE '%Safety Net%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Safety Net%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



create view [dbo].[vExecutiveProjectsSafetyNetFY2015] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%') AND (Program_Areas__c LIKE '%Safety Net%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%Safety Net%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Safety Net%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)



create view [dbo].[vExecutiveProjectsSafetyNetFY2016] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2016%') AND (Program_Areas__c LIKE '%Safety Net%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2016%') AND (Program_Areas__c LIKE '%Safety Net%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Safety Net%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsWaterSanitationFY2014] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2014%') AND (Program_Areas__c LIKE '%Water and Sanitation%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2014%') AND (Program_Areas__c LIKE '%Water and Sanitation%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Water and Sanitation%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)

create view [dbo].[vExecutiveProjectsWaterSanitationFY2015] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%') AND (Program_Areas__c LIKE '%Water and Sanitation%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%Water and Sanitation%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Water and Sanitation%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)


create view [dbo].[vExecutiveProjectsWaterSanitationFY2016] as

SELECT        a.Country_New__c AS ProjectCountry, a.TotalProjects, c.TotalDSPNs, b.TotalBSDIs, c.FY_to_Date_Expend, c.Current_FY_Amend_Budget, c.Incept_To_Date_Expend, c.Obligated_Amount, b.Direct_Beneficiaries, 
                         b.Indirect_Beneficiaries, b.Total_Beneficiaries, poly.Shape
FROM            (SELECT        SUM(TotalProjects) AS TotalProjects, Country_New__c
                          FROM            dbo.vExecutiveTotalProjects
                          WHERE        (FY LIKE '%2015%') AND (Program_Areas__c LIKE '%Water and Sanitation%')
                          GROUP BY Country_New__c) AS a FULL OUTER JOIN
                             (SELECT        Country, SUM(TotalBSDIs) AS TotalBSDIs, SUM(Beneficiaries_Direct__c) AS Direct_Beneficiaries, SUM(Beneficiaries_Indirect__c) AS Indirect_Beneficiaries, 
                                                         SUM(Beneficiaries_Indirect__c + Beneficiaries_Direct__c) AS Total_Beneficiaries
                               FROM            dbo.vExecutiveTotalBSDIs
                               WHERE        (Fiscal_Year__c LIKE '%2015%') AND (Program_Areas__c LIKE '%Water and Sanitation%')
                               GROUP BY Country) AS b ON a.Country_New__c LIKE b.Country FULL OUTER JOIN
                             (SELECT        SUM(TotalDSPNs) AS TotalDSPNs, Country_New__c, SUM(FY_to_Date_Expend) AS FY_to_Date_Expend, SUM(Current_FY_Amend_Budget) AS Current_FY_Amend_Budget, 
                                                         SUM(Incept_To_Date_Expend) AS Incept_To_Date_Expend, SUM(Obligated_Amount) AS Obligated_Amount
                               FROM            dbo.vExecutiveTotalDSPNs
                               WHERE        (Program_Areas__c LIKE '%Water and Sanitation%')
                               GROUP BY Country_New__c) AS c ON b.Country LIKE c.Country_New__c OR a.Country_New__c LIKE c.Country_New__c INNER JOIN
                             (SELECT        Country, Shape
                               FROM            dbo.COUNTRIESAGOL) AS poly ON a.Country_New__c LIKE poly.Country OR b.Country LIKE poly.Country OR c.Country_New__c LIKE poly.Country
WHERE        (a.Country_New__c IS NOT NULL)