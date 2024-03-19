SELECT M1.Symbol , M1.Sector, ROUND(M1.Yield,3) AS Yield
FROM(SELECT MINMAXShineCompany.Symbol , MINMAXShineCompany.Sector , (MINMAXShineCompany.MAXPRICE/MINMAXShineCompany.MINPRICE)*100 - 100 AS Yield
FROM MINMAXShineCompany) AS M1
ORDER BY Yield DESC;