-- Question 3-09

DECLARE
  p_id dd_project.idproj%TYPE;
  p_name dd_project.projname%TYPE;
  pledge_num dd_pledge.pledgeamt%TYPE;
  pledge_avg dd_pledge.pledgeamt%TYPE;
  pledge_sum dd_pledge.pledgeamt%TYPE;
BEGIN
  SELECT dd_project.idProj, dd_project.projname, count(pledgeamt), sum(pledgeamt), avg(pledgeamt)
   INTO p_id, p_name, pledge_num, pledge_sum,  pledge_avg
   FROM dd_project JOIN dd_pledge
   ON dd_project.idproj = dd_pledge.idproj and dd_project.idproj = 504
   group by dd_project.idproj,projname;

      DBMS_OUTPUT.PUT_LINE('Project ID: ' || p_id ||' Project Name: ' || p_name);
      DBMS_OUTPUT.PUT_LINE('Number Pledges Made: '|| pledge_num ||' Total Sum of Dollars Pledged: '|| pledge_sum||' Average Dollars Pledged: '|| pledge_avg );
END;




-- Question 3-10

CREATE SEQUENCE dd_projid_seq
  START WITH     530
  INCREMENT BY   1
  NOCACHE
  NOCYCLE;


DECLARE 
TYPE type_project IS RECORD(
p_name dd_project.projname%TYPE := 'HK Animal Shelter Extension',
p_start dd_project.projstartdate%TYPE := (to_date( '01/01/2013', 'mm/dd/yyyy')),
p_end dd_project.projenddate%TYPE := (to_date ('05/31/2013', 'mm/dd/yyyy')),
p_funding dd_project.projfundgoal%TYPE := 65000 );
new_project type_project;
BEGIN
INSERT INTO dd_project (idproj, projname, projstartdate, projenddate, projfundgoal)
VALUES (dd_projid_seq.NEXTVAL, new_project.p_name, new_project.p_start, new_project.p_end, new_project.p_funding);
COMMIT; 
END;

SELECT * FROM dd_project;




-- Question 3-11

DECLARE 
PLEDGES DD_PLEDGE%ROWTYPE;
s_Date DD_PLEDGE.PLEDGEDATE%TYPE := '01-OCT-12';
e_Date DD_PLEDGE.PLEDGEDATE%TYPE := '31-OCT-12';

BEGIN
FOR PLEDGES IN
    (SELECT IDPLEDGE, IDDONOR, PLEDGEAMT, 

CASE 
  WHEN PAYMONTHS = 0 THEN 'Lump Sum.'
  ELSE 'Monthly - ' || PAYMONTHS END AS Monthly
  
    FROM DD_PLEDGE
    WHERE PLEDGEDATE >= s_Date AND PLEDGEDATE <= e_Date
    ORDER BY PAYMONTHS)

LOOP 
DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || PLEDGES.IDPLEDGE 
|| ', Donor ID: '|| PLEDGES.IDDONOR 
|| ', Pledge Amount: ' ||TO_CHAR(PLEDGES.PLEDGEAMT,'$999999.99') 
|| ', Monthly Payments: ' || PLEDGES.Monthly);
END LOOP;
END;




-- Question 3-12

DECLARE
PLEDGES DD_PLEDGE%ROWTYPE;
BALANCE DD_PLEDGE.PLEDGEAMT%TYPE;
MONTHS_TOTAL DD_PLEDGE.PAYMONTHS%TYPE:= 24;
PLEDGE_MONTHLY DD_PLEDGE.PLEDGEAMT%TYPE;
BEGIN
  SELECT * INTO PLEDGES
  FROM DD_PLEDGE
  WHERE IDPLEDGE = 105;
  IF PLEDGES.PAYMONTHS = 0 THEN
  BALANCE := 0;
  ELSE BALANCE := (MONTHS_TOTAL-PLEDGES.PAYMONTHS)*(PLEDGES.PLEDGEAMT/PLEDGES.PAYMONTHS);
  END IF;
    DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || PLEDGES.IDPLEDGE 
    || ', Donor ID: ' || PLEDGES.IDDONOR 
    || ', Pledge amount: ' || PLEDGES.PLEDGEAMT 
    || ', Balance: ' || BALANCE);
END;





-- Question 3-13

DECLARE
  p_name dd_project.projname%TYPE;
  d_start dd_project.projstartdate%TYPE;
  f_goal dd_project.projfundgoal%TYPE;  
  new_Fgoal	dd_project.projfundgoal%TYPE := 150000;

  p_id dd_project.idproj%TYPE := 502;

BEGIN
  SELECT projname, projstartdate, projfundgoal
  INTO p_name, d_start, f_goal
  FROM DD_PROJECT
  WHERE idproj = p_id; 

  UPDATE dd_project
  SET projfundgoal = new_Fgoal
  WHERE idproj = p_id;  
DBMS_OUTPUT.PUT_LINE('Project Name: ' || p_name);
DBMS_OUTPUT.PUT_LINE('Start Date: ' || d_start );
DBMS_OUTPUT.PUT_LINE('Previous Goal: ' || f_goal);
DBMS_OUTPUT.PUT_LINE('New Goal: ' || new_Fgoal); 
END;
