-- 1
SELECT EventNo, DateHeld, Customer.CustNo, CustName, Facility.FacNo, FacName
FROM EventRequest, Customer, Facility
WHERE
EventRequest.CustNo = Customer.CustNo
AND
EventRequest.FacNo = Facility.FacNo
AND
city = 'Boulder'
AND
(DateHeld BETWEEN '2018-01-01' AND '2018-12-31');

-- 2
SELECT Customer.CustNo, CustName, EventNo, DateHeld, Facility.FacNo, FacName, EstCost/EstAudience AS CostPerPerson
FROM Customer, EventRequest, Facility
WHERE
(DateHeld BETWEEN '2018-01-01' AND '2018-12-31')
AND
EventRequest.CustNo = Customer.CustNo
AND
EventRequest.FacNo = Facility.FacNo
AND EstCost/EstAudience < 0.2;

-- 3
SELECT EventRequest.CustNo, CustName, SUM(EstCost) AS SumCost
FROM Customer, EventRequest
WHERE
Status = 'Approved'
AND
EventRequest.CustNo = Customer.CustNo
GROUP BY EventRequest.CustNo, CustName;

-- 4
INSERT INTO Customer
(CustNo, CustName, Address, Internal, Contact, Phone, City, State, Zip)
VALUES ('C106', 'Litrobol', 'Pmoyka st.', 'Y', 'Levi', '123', 'Ekb', 'CO', '12345');

-- 7
DELETE FROM Customer
WHERE CustNo = 'C106';

-- 5
UPDATE ResourceTbl
SET rate = rate*1.1
WHERE ResName = 'nurse';

-- 5.1
UPDATE ResourceTbl
SET rate = 20
WHERE ResName = 'nurse';