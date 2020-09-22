-- 1 Semantic error
SELECT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, employee, facility, eventplan
WHERE estaudience > 5000
  AND eventplan.empno = employee.empno 
  AND eventrequest.facno = facility.facno
  AND eventrequest.eventno = eventplan.eventno
  AND facname = 'Football stadium' 
  AND empname = 'Mary Manager';


-- 2 Redundancy. Group by is not needed
SELECT DISTINCT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, eventplan
WHERE estaudience > 4000
  AND eventplan.eventno = eventrequest.eventno;



-- 3 Semantic: employee and eventplan tables are not needed
SELECT DISTINCT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, facility
WHERE estaudience > 5000 
  AND eventrequest.facno = facility.facno
  AND facname = 'Football stadium';
  
  
-- 4 Syntax
SELECT DISTINCT eventrequest.eventno, dateheld, status, estcost
FROM eventrequest, employee, eventplan
WHERE estaudience BETWEEN 5000 AND 10000
  AND eventplan.empno = employee.empno 
  AND eventrequest.eventno = eventplan.eventno
  AND empname = 'Mary Manager';
  
  
-- 5 Bad alignment and incompatible constant
SELECT eventplan.planno, lineno, resname, numberfld, timestart, timeend
FROM eventrequest, facility, eventplan, eventplanline, resourcetbl
WHERE estaudience = 10000 -- incompatible constant
AND eventplan.planno = eventplanline.planno
AND eventrequest.facno = facility.facno
AND facname = 'Basketball arena'
AND eventplanline.resno = resourcetbl.resno
AND eventrequest.eventno = eventplan.eventno 












