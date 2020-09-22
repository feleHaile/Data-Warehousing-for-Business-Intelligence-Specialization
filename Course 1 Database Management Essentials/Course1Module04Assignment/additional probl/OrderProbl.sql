SELECT CustNo, CustFirstName, CustLastName, CustBal -- 1
FROM Customer;

SELECT CustNo, CustFirstName, CustLastName, CustBal -- 2
FROM Customer
WHERE CustState = 'CO';


SELECT * -- 3
FROM Product
WHERE ProdPrice > 50
ORDER BY ProdMfg, ProdName;

SELECT CustNo, CustFirstName, CustLastName, CustCity, CustBal -- 4
FROM Customer
WHERE
(CustCity = 'Denver' AND CustBal > 150)
OR
(CustCity = 'Seattle' AND CustBal > 300)
;


SELECT OrdNo, OrdDate, OrderTbl.CustNo, CustFirstName, CustLastName -- 5
FROM OrderTbl, Customer
WHERE 
(OrderTbl.CustNo = Customer.CustNo)
AND
(OrdDate BETWEEN '2017-01-01' AND '2017-01-31')
AND CustCity = 'Colorado'
;


SELECT CustCity, AVG(CustBal) AS AvgBal
FROM Customer
WHERE CustState = 'WA'
GROUP BY CustCity
;

SELECT CustCity, AVG(CustBal) AS AvgBal, COUNT(*)
FROM Customer
WHERE CustState = 'WA'
GROUP BY CustCity
HAVING COUNT(*) >= 2
;
