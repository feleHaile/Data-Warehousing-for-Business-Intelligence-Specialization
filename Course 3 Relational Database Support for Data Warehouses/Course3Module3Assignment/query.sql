--Query1
SELECT name, SUM(extcost) AS SUMextcost,
RANK() OVER (ORDER BY SUM(extcost) DESC) AS costRank
FROM inventory_fact, cust_vendor_dim
WHERE cust_vendor_dim.custvendorkey = inventory_fact.custvendorkey
AND transtypekey = 5
GROUP BY name;


--Query2
SELECT state, name, SUM(extcost) AS SUMextcost,
RANK() OVER (PARTITION BY state
			 ORDER BY SUM(extcost) DESC) AS costRank
FROM inventory_fact, cust_vendor_dim
WHERE cust_vendor_dim.custvendorkey = inventory_fact.custvendorkey
AND transtypekey = 5
GROUP BY state, name;


--Query3
SELECT name, COUNT(transtypekey) AS SUMtrans,
RANK() OVER (ORDER BY COUNT(transtypekey) DESC) AS transRank,
DENSE_RANK() OVER (ORDER BY COUNT(transtypekey) DESC) AS transDense
FROM inventory_fact, cust_vendor_dim
WHERE cust_vendor_dim.custvendorkey = inventory_fact.custvendorkey
AND transtypekey = 5
GROUP BY name;

--Query4
SELECT zip, calyear, calmonth, SUM(extcost) AS SUMextcost,
SUM(SUM(extcost)) OVER (ORDER BY zip, calyear, calmonth
						ROWS UNBOUNDED PRECEDING) AS CumExtCost
FROM inventory_fact, cust_vendor_dim, date_dim
WHERE cust_vendor_dim.custvendorkey = inventory_fact.custvendorkey
AND date_dim.datekey = inventory_fact.datekey
AND transtypekey = 5
GROUP BY zip, calyear, calmonth;

--Query5
SELECT zip, calyear, calmonth, SUM(extcost) AS SUMextcost,
SUM(SUM(extcost)) OVER (PARTITION BY zip, calyear
						ORDER BY zip, calyear, calmonth
						ROWS UNBOUNDED PRECEDING) AS CumExtCost
FROM inventory_fact, cust_vendor_dim, date_dim
WHERE cust_vendor_dim.custvendorkey = inventory_fact.custvendorkey
AND date_dim.datekey = inventory_fact.datekey
AND transtypekey = 5
GROUP BY zip, calyear, calmonth;

--Using postgresql
--Query6
SELECT seconditemid, SUMitemextcost, SUMitemextcost/Sumextcost AS ratio

FROM
(SELECT seconditemid, SUM(extcost) AS SUMitemextcost
FROM inventory_fact, item_master_dim
WHERE item_master_dim.itemmasterkey = inventory_fact.itemmasterkey
AND transtypekey = 1
GROUP BY seconditemid) X1,

(SELECT SUM(extcost) AS SUMextcost
FROM inventory_fact
WHERE transtypekey = 1) X2

ORDER BY SUMitemextcost DESC;

--Using postgresql
--Query7
SELECT X1.calyear, seconditemid, SUMitemextcost, SUMitemextcost/Sumextcost AS ratio

FROM
(SELECT calyear, seconditemid, SUM(extcost) AS SUMitemextcost
FROM inventory_fact, item_master_dim, date_dim
WHERE item_master_dim.itemmasterkey = inventory_fact.itemmasterkey
AND date_dim.datekey = inventory_fact.datekey
AND transtypekey = 1
GROUP BY calyear, seconditemid) X1,

(SELECT calyear, SUM(extcost) AS SUMextcost
FROM inventory_fact, date_dim
WHERE transtypekey = 1
AND date_dim.datekey = inventory_fact.datekey
GROUP BY calyear
) X2

WHERE X1.calyear = X2.calyear
ORDER BY X1.calyear, SUMitemextcost DESC;


--QUERY8
SELECT BPName, companykey, carryingcost,
RANK() OVER (ORDER BY carryingcost),
Percent_Rank() OVER (ORDER BY carryingcost),
CUME_DIST() OVER (ORDER BY carryingcost)
FROM branch_plant_dim;

--QUERY9
SELECT BPName, companykey, carryingcost, CumCost
FROM
(SELECT BPName, companykey, carryingcost,
CUME_DIST() OVER (ORDER BY carryingcost) AS CumCost
FROM branch_plant_dim) X1

WHERE CumCost >= 0.85;



--Query10
-- SELECT extcost,
-- CUME_DIST() OVER (ORDER BY extcost)
-- FROM
-- (SELECT DISTINCT extcost
-- FROM inventory_fact, cust_vendor_dim
-- WHERE Inventory_fact.custvendorkey = cust_vendor_dim.custvendorkey
-- AND state = 'CO') X1;




