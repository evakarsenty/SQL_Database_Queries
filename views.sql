--q3

CREATE VIEW OldCompany
AS
SELECT Symbol, Founded, Location
FROM Company
WHERE Founded < 1990;

CREATE VIEW IndustrializedCountry
AS
SELECT  OldCompany.Location
FROM OldCompany
INNER JOIN Company
ON OldCompany.Symbol = Company.Symbol
GROUP BY OldCompany.Location
HAVING count(OldCompany.Symbol) > 5;

CREATE VIEW MaxPriceAllCountry
AS
SELECT MAX(Stock.Price) AS MaxPriceCompany, Company.Symbol, Company.Location
FROM Stock
INNER JOIN Company
ON Company.Symbol = Stock.Symbol
GROUP BY Company.Location, Company.Symbol;

--q4

CREATE VIEW ImprovedCompany
AS
SELECT DISTINCT Symbol
FROM Stock
WHERE Symbol NOT IN
(SELECT DISTINCT  Stock1.Symbol
FROM Stock AS Stock1
inner join Stock AS Stock2
ON Stock1.Symbol = Stock2.Symbol AND Stock1.tDate >= Stock2.tDate AND Stock1.Price < Stock2.Price);


CREATE VIEW ALLSYMBOLSECTOR
AS
SELECT ImprovedCompany.Symbol , Sector
FROM Company, ImprovedCompany
WHERE ImprovedCompany.Symbol = Company.Symbol;


CREATE VIEW NotShineCompany
AS
SELECT DISTINCT ALL1.SYMBOL, ALL1.SECTOR
FROM ALLSYMBOLSECTOR AS ALL1
INNER JOIN ALLSYMBOLSECTOR AS ALL2
ON ALL1.Symbol !=ALL2.Symbol AND ALL1.Sector = ALL2.Sector;


CREATE VIEW ShineCompany
AS
SELECT ALLSYMBOLSECTOR.Symbol , ALLSYMBOLSECTOR.Sector
FROM ALLSYMBOLSECTOR
WHERE ALLSYMBOLSECTOR.Symbol NOT IN (SELECT NotShineCompany.SYMBOL
                                     FROM NotShineCompany);

CREATE VIEW MINMAXShineCompany
AS
SELECT ShineCompany.Symbol , ShineCompany.Sector , MAX(Stock.Price) AS MAXPRICE ,MIN(Stock.Price) AS MINPRICE
FROM ShineCompany , Stock
WHERE ShineCompany.Symbol = Stock.Symbol
GROUP BY ShineCompany.Symbol , ShineCompany.Sector;
