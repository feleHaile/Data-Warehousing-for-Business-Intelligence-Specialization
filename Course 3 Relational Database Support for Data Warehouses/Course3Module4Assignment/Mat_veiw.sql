DROP MATERIALIZED VIEW IF EXISTS SalesByVendorDateKeyMV2011,
SalesByVendorDateKeyMV2012;

--View1
CREATE MATERIALIZED VIEW SalesByVendorDateKeyMV2011 AS
SELECT custvendorkey, date_dim.datekey, SUM(extcost) AS SUMextcost,
SUM(quantity) AS SUMquantity, count(*) AS COUNTtrans
FROM inventory_fact, date_dim
WHERE transtypekey = 5
AND calyear = 2011
AND date_dim.datekey = inventory_fact.datekey
GROUP BY custvendorkey, date_dim.datekey;

SELECT *
FROM SalesByVendorDateKeyMV2011;

--View2
CREATE MATERIALIZED VIEW SalesByVendorDateKeyMV2012 AS
SELECT custvendorkey, date_dim.datekey, SUM(extcost) AS SUMextcost, SUM(quantity) AS SUMquantity,
COUNT(*) AS COUNTtrans
FROM inventory_fact, date_dim
WHERE date_dim.datekey = inventory_fact.datekey
AND calyear = 2012
AND transtypekey = 5
GROUP BY custvendorkey, date_dim.datekey;

SELECT *
FROM SalesByVendorDateKeyMV2012;


--View3
SELECT d.calmonth, c.addrcatcode1, SUM(s.SUMextcost) AS SUMextcost, SUM(s.SUMquantity) AS SUMquantity
FROM SalesByVendorDateKeyMV2011 s, cust_vendor_dim c, date_dim d
WHERE s.datekey = d.datekey
AND c.CustVendorKey = s.custvendorKey
GROUP BY CUBE(d.calmonth, c.addrcatcode1);



-- select CalMonth, AddrCatCode1, sum(ExtCost) as tot_cost, 
--        sum(Quantity) as tot_qty
-- from inventory_fact i, cust_vendor_dim c, date_dim d
-- where TransTypeKey = 5 and
--       d.Calyear = 2011 and 
--       i.CustVendorKey = c.CustVendorKey and
--       i.DateKey = d.DateKey
-- group by CUBE(AddrCatCode1, d.calmonth);


--View4
SELECT X1.calquarter, X1.zip, X1.name,
SUM(X1.SUMextcost) AS SUMextcost, SUM(X1.COUNTtrans) AS COUNTtrans
FROM
(
SELECT d.calquarter, c.zip, c.name, V2011.SUMextcost, V2011.COUNTtrans
FROM SalesByVendorDateKeyMV2011 V2011, date_dim d, cust_vendor_dim c
WHERE V2011.datekey = d.datekey
AND V2011.CustVendorKey = c.CustVendorKey

UNION

SELECT d.calquarter, c.zip, c.name, V2012.SUMextcost, V2012.COUNTtrans
FROM SalesByVendorDateKeyMV2012 V2012, date_dim d, cust_vendor_dim c
WHERE V2012.datekey = d.datekey
AND V2012.CustVendorKey = c.CustVendorKey
) X1
GROUP BY CUBE(X1.calquarter, X1.zip, X1.name)
;






-- SELECT d.calquarter, c.zip, c.name,
-- SUM(V2011.SUMextcost) AS SUMcost, SUM(V2011.SUMquantity) AS SUMqty
-- FROM SalesByVendorDateKeyMV2011 V2011, date_dim d, cust_vendor_dim c
-- WHERE V2011.datekey = d.datekey
-- AND V2011.CustVendorKey = c.CustVendorKey
-- GROUP BY CUBE(d.calquarter, c.zip, c.name)




-- select Name, Zip, CalQuarter, sum(ExtCost) as tot_cost, count(*) as Cnt
-- from inventory_fact i, cust_vendor_dim c, date_dim d
-- where TransTypeKey = 5 and
--       d.Calyear BETWEEN 2011 AND 2012 AND 
--       d.datekey = i.datekey and
--       i.CustVendorKey = c.CustVendorKey AND
--       i.DateKey = d.DateKey
-- group by CUBE(c.Name, Zip, d.CalQuarter);


