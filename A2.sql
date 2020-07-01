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
commit; 
END;



project_name dd_project.projname%type := 'HK Animal Shelter Extension',
project_start dd_project.projstartdate%type := (to_date( '01/01/2013', 'mm/dd/yyyy'),
project_end dd_project.projenddate%type  := (to_date( '05/31/2013', 'mm/dd/yyyy')),
project_funding dd_project.projfundgoal%type := '65000');





