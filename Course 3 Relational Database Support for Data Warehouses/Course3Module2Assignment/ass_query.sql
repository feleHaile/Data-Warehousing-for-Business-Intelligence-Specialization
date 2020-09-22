-- SELECT inventorykey, transtypekey
-- FROM inventory_fact
-- WHERE transtypekey = 5;

-- SELECT calmonth, addrcatdesc, extcost, quantity, calyear 
-- FROM inventory_fact, date_dim, addr_cat_code1, cust_vendor_dim
-- WHERE inventory_fact.datekey = date_dim.datekey
-- AND inventory_fact.custvendorkey = cust_vendor_dim.custvendorkey
-- AND cust_vendor_dim.addrcatcode1 = addr_cat_code1.addrcatcodekey
-- AND date_dim.calyear = 2011
-- AND inventory_fact.transtypekey = 5
-- ;


-- Query 1
SELECT calmonth, addrcatdesc, SUM(extcost) AS extcostSUM, SUM(quantity) AS quantitySUM
FROM inventory_fact, date_dim, addr_cat_code1, cust_vendor_dim
WHERE inventory_fact.datekey = date_dim.datekey
AND inventory_fact.custvendorkey = cust_vendor_dim.custvendorkey
AND cust_vendor_dim.addrcatcode1 = addr_cat_code1.addrcatcodekey
AND date_dim.calyear = 2011
AND inventory_fact.transtypekey = 5
GROUP BY CUBE (calmonth, addrcatdesc)
-- ORDER BY calmonth, addrcatdesc
;


-- Query 2
SELECT calquarter, zip, name, SUM(extcost) AS extcostSUM, COUNT(transtypekey) AS transCOUNT
FROM inventory_fact, date_dim, cust_vendor_dim
WHERE inventory_fact.datekey = date_dim.datekey
AND cust_vendor_dim.custvendorkey = inventory_fact.custvendorkey
AND calyear IN(2011, 2012)
AND inventory_fact.transtypekey = 5
GROUP BY GROUPING SETS((calquarter, zip, name), (calquarter, zip), (calquarter, name), (zip, name), calquarter, zip, name, ())
-- GROUP BY calyear, calquarter, zip, name
-- GROUP BY calyear, CUBE(calquarter, zip, name)
;


-- Q3
SELECT companyname, bpname, SUM(extcost) AS extcostSUM, SUM(quantity) AS quantitySUM
FROM inventory_fact, branch_plant_dim, company_dim
WHERE inventory_fact.transtypekey = 2
AND inventory_fact.branchplantkey = branch_plant_dim.branchplantkey
AND branch_plant_dim.companykey = company_dim.companykey
GROUP BY ROLLUP(companyname, bpname);

--Q4
SELECT transdescription, companyname, bpname, SUM(extcost) AS extcostSUM, COUNT(inventory_fact.transtypekey) AS transCOUNT
FROM inventory_fact, trans_type_dim, company_dim, branch_plant_dim
WHERE inventory_fact.transtypekey = trans_type_dim.transtypekey
AND inventory_fact.branchplantkey = branch_plant_dim.branchplantkey
AND branch_plant_dim.companykey = company_dim.companykey
GROUP BY GROUPING SETS((transdescription, companyname, bpname), (transdescription, companyname), (transdescription), ());

-- -- --Q5
-- SELECT calyear, calquarter, name, SUM(extcost) AS extcostSUM, COUNT(inventory_fact.transtypekey) AS transCOUNT
-- FROM inventory_fact, date_dim, cust_vendor_dim
-- WHERE inventory_fact.transtypekey = 5
-- AND inventory_fact.datekey = date_dim.datekey
-- AND calyear IN(2011, 2012)
-- AND inventory_fact.custvendorkey = cust_vendor_dim.custvendorkey
-- GROUP BY ROLLUP(calyear, calquarter), name;

-- --Q6
-- SELECT calmonth, addrcatdesc, SUM(extcost) AS extcostSUM, SUM(quantity) AS quantitySUM
-- FROM inventory_fact, date_dim, addr_cat_code1, cust_vendor_dim
-- WHERE inventory_fact.datekey = date_dim.datekey
-- AND inventory_fact.custvendorkey = cust_vendor_dim.custvendorkey
-- AND cust_vendor_dim.addrcatcode1 = addr_cat_code1.addrcatcodekey
-- AND date_dim.calyear = 2011
-- AND inventory_fact.transtypekey = 5
-- GROUP BY calmonth, addrcatdesc

-- UNION
-- SELECT calmonth, NULL, SUM(extcost) AS extcostSUM, SUM(quantity) AS quantitySUM
-- FROM inventory_fact, date_dim, addr_cat_code1, cust_vendor_dim
-- WHERE inventory_fact.datekey = date_dim.datekey
-- AND inventory_fact.custvendorkey = cust_vendor_dim.custvendorkey
-- AND cust_vendor_dim.addrcatcode1 = addr_cat_code1.addrcatcodekey
-- AND date_dim.calyear = 2011
-- AND inventory_fact.transtypekey = 5
-- GROUP BY calmonth

-- UNION
-- SELECT NULL, addrcatdesc, SUM(extcost) AS extcostSUM, SUM(quantity) AS quantitySUM
-- FROM inventory_fact, date_dim, addr_cat_code1, cust_vendor_dim
-- WHERE inventory_fact.datekey = date_dim.datekey
-- AND inventory_fact.custvendorkey = cust_vendor_dim.custvendorkey
-- AND cust_vendor_dim.addrcatcode1 = addr_cat_code1.addrcatcodekey
-- AND date_dim.calyear = 2011
-- AND inventory_fact.transtypekey = 5
-- GROUP BY addrcatdesc

-- UNION
-- SELECT NULL, NULL, SUM(extcost) AS extcostSUM, SUM(quantity) AS quantitySUM
-- FROM inventory_fact, date_dim, addr_cat_code1, cust_vendor_dim
-- WHERE inventory_fact.datekey = date_dim.datekey
-- AND inventory_fact.custvendorkey = cust_vendor_dim.custvendorkey
-- AND cust_vendor_dim.addrcatcode1 = addr_cat_code1.addrcatcodekey
-- AND date_dim.calyear = 2011
-- AND inventory_fact.transtypekey = 5;

-- --Q7
-- SELECT companyname, bpname, SUM(extcost) AS extcostSUM, SUM(quantity) AS quantitySUM
-- FROM inventory_fact, branch_plant_dim, company_dim
-- WHERE inventory_fact.transtypekey = 2
-- AND inventory_fact.branchplantkey = branch_plant_dim.branchplantkey
-- AND branch_plant_dim.companykey = company_dim.companykey
-- GROUP BY companyname, bpname

-- UNION
-- SELECT companyname, NULL, SUM(extcost) AS extcostSUM, SUM(quantity) AS quantitySUM
-- FROM inventory_fact, branch_plant_dim, company_dim
-- WHERE inventory_fact.transtypekey = 2
-- AND inventory_fact.branchplantkey = branch_plant_dim.branchplantkey
-- AND branch_plant_dim.companykey = company_dim.companykey
-- GROUP BY companyname

-- UNION
-- SELECT NULL, NULL, SUM(extcost) AS extcostSUM, SUM(quantity) AS quantitySUM
-- FROM inventory_fact, branch_plant_dim, company_dim
-- WHERE inventory_fact.transtypekey = 2
-- AND inventory_fact.branchplantkey = branch_plant_dim.branchplantkey
-- AND branch_plant_dim.companykey = company_dim.companykey
-- ;

-- --Q8
-- SELECT name, calyear, calquarter, SUM(extcost) AS extcostSUM, COUNT(transtypekey) AS transCOUNT
-- FROM inventory_fact, date_dim, cust_vendor_dim
-- WHERE inventory_fact.datekey = date_dim.datekey
-- AND cust_vendor_dim.custvendorkey = inventory_fact.custvendorkey
-- AND calyear IN(2011, 2012)
-- AND inventory_fact.transtypekey = 5
-- GROUP BY CUBE(name, (calyear, calquarter));

-- --Q9
-- SELECT calmonth, addr_cat_code1.addrcatcodekey,
-- SUM(extcost) AS extcostSUM,
-- SUM (quantity) AS quantitySUM,
-- GROUPING (calmonth, addr_cat_code1.addrcatcodekey) AS groupNumber
-- FROM 
-- inventory_fact, cust_vendor_dim, addr_cat_code1, date_dim
-- WHERE 
-- inventory_fact.datekey = date_dim.datekey
-- AND inventory_fact.custvendorkey = cust_vendor_dim.custvendorkey
-- AND cust_vendor_dim.addrcatcode1 = addr_cat_code1.addrcatcodekey
-- AND date_dim.calyear = 2011
-- AND inventory_fact.transtypekey = 5
-- GROUP BY CUBE(calmonth, addr_cat_code1.addrcatcodekey);


-- --Q10
-- SELECT name, calyear, calquarter, SUM(extcost) AS extcostSUM, COUNT(transtypekey) AS transCOUNT
-- FROM inventory_fact, date_dim, cust_vendor_dim
-- WHERE inventory_fact.datekey = date_dim.datekey
-- AND cust_vendor_dim.custvendorkey = inventory_fact.custvendorkey
-- AND calyear IN(2011, 2012)
-- AND inventory_fact.transtypekey = 5
-- GROUP BY GROUPING SETS(name, ROLLUP(calyear, calquarter));




