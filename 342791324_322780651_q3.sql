SELECT  Table2.Location as Location ,MaxPriceAllCountry.Symbol as Symbol, Table2.maxprice as Price
FROM (
SELECT table1.Location, max(MaxPriceCompany) as maxprice from (
         SELECT IndustrializedCountry.Location
         FROM MaxPriceAllCountry
                  INNER JOIN IndustrializedCountry
                             ON IndustrializedCountry.Location = MaxPriceAllCountry.Location
         GROUP BY IndustrializedCountry.Location) as table1
INNER JOIN MaxPriceAllCountry
         ON Table1.Location = MaxPriceAllCountry.Location
group by table1.Location) as Table2
INNER JOIN MaxPriceAllCountry
ON Table2.Location = MaxPriceAllCountry.Location and Table2.maxprice = MaxPriceAllCountry.MaxPriceCompany
ORDER BY Table2.Location
