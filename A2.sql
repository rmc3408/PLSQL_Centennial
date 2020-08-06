DROP SEQUENCE dd_PTRACK_SEQ;
DROP TABLE dd_paytrack CASCADE CONSTRAINTS;
DROP TABLE dd_pledge CASCADE CONSTRAINTS;
DROP TRIGGER TRIGGER_ACTIVITY_PAY;
DROP TRIGGER FP_CHECK_ADD;

DELETE DD_PLEDGE WHERE IDPLEDGE = 115;

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

drop sequence dd_projid_seq;
delete from dd_project where idproj = 530;
SELECT * FROM dd_project;



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



-- Question 3-11

DECLARE 
    TYPE pledge_type IS TABLE OF dd_pledge%ROWTYPE 
        INDEX BY PLS_INTEGER; 
    table_pledge pledge_type;
    payment VARCHAR2(12);
BEGIN 
    SELECT * BULK COLLECT 
        INTO table_pledge 
        FROM dd_pledge
        WHERE idpledge IN(
            SELECT idpledge
            FROM dd_pledge
            WHERE EXTRACT(MONTH FROM TO_DATE(pledgedate, 'DD-MON-YYYY')) = '10')
        ORDER BY paymonths;
    FOR x IN 1.. table_pledge.COUNT LOOP
        IF table_pledge (x).paymonths = 0 THEN
            payment := 'Lump Sum';
        ELSE
            payment := 'Monthly - '|| table_pledge (x).paymonths;
        END IF;
        DBMS_OUTPUT.PUT_LINE(
        'Pledge Date: ' ||table_pledge (x).pledgedate || 
        ' , Pledge ID: ' || table_pledge (x).idpledge || 
        ' , Pledge Amount: ' || table_pledge (x).pledgeamt || 
        ' , PayMent ' || payment);
    END LOOP; 
END;



-- Question 3-12

DECLARE
    p dd_pledge%ROWTYPE;
    amt dd_pledge.pledgeamt%TYPE;
    Balance dd_pledge.pledgeamt%TYPE;
    id dd_pledge.idpledge%TYPE := 104;
BEGIN
    SELECT *
    INTO p
    FROM dd_pledge
    WHERE idpledge = id;
    SELECT sum(payamt)
    INTO amt
    FROM dd_payment
    WHERE idpledge =id;
    BALANCE := p.pledgeamt - amt;
    DBMS_OUTPUT.PUT_LINE('Pledge ID: ' || p.idpledge || 
        ' Donor ID: ' || p.iddonor || 
        ' Pledge amount: '|| p.pledgeamt || 
        ' Total: ' || amt || 
        ' Balance: ' || Balance);
END;




-- Question 3-13

DECLARE
  p_name dd_project.projname%TYPE;
  d_start dd_project.projstartdate%TYPE;
  f_goal dd_project.projfundgoal%TYPE;  
  new_Fgoal	dd_project.projfundgoal%TYPE := 22000;
  p_id dd_project.idproj%TYPE := 501;
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



