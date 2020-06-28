-- Select rows from a Table

SELECT officer_ID, first FROM OFFICERS
WHERE STATUS = 'A';


DECLARE
lv_tax number(3,2) := 0.13;
BEGIN
    DBMS_OUTPUT.put_LINE(lv_tax);
END;
