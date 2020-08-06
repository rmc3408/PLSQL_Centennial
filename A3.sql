-- ASSIGNMENT 9-9 

CREATE TABLE dd_paytrack(
    track_idtrack         NUMBER,
    track_logon           VARCHAR2(30),
    track_currentdate     DATE,
    track_actiontaken     VARCHAR2(30),
    track_idPay           NUMBER(6,0),
    CONSTRAINT dd_paytrack_pk PRIMARY KEY (track_idtrack)
    );


CREATE SEQUENCE dd_ptrack_seq;

CREATE OR REPLACE TRIGGER trigger_activity_pay
    AFTER 
        INSERT OR 
        UPDATE OR 
        DELETE 
    ON dd_payment
    FOR EACH ROW  
    DECLARE
      log_action  dd_paytrack.track_actiontaken%TYPE; 
      id_pay      dd_paytrack.track_idPay%TYPE;    
    BEGIN
    id_pay := :NEW.idpay;
    IF INSERTING THEN
    log_action := 'Insert';
    ELSIF UPDATING THEN
    log_action := 'Update';
    ELSIF DELETING THEN
    id_pay := :OLD.idpay;
    log_action := 'Delete';
    ELSE
        DBMS_OUTPUT.PUT_LINE('---- Wrong command -----');
    END IF;

    INSERT INTO dd_paytrack (track_idtrack, track_logon, track_currentdate, track_actiontaken, track_idPay)
      VALUES(dd_ptrack_seq.NEXTVAL, USER, TO_CHAR(SYSDATE, 'DD-MON-YY'), log_action, id_pay);

    END trigger_activity_pay;


INSERT INTO dd_payment(idpay, idpledge, payamt, paydate, paymethod)
VALUES (1465, 100, 0, SYSDATE, 'CC');

UPDATE dd_payment SET payamt = 1200 WHERE idpay = 1465;

DELETE dd_payment WHERE idpay= 1465;

commit;




-- ASSIGNMENT 9-10 

CREATE OR REPLACE TRIGGER firstPledge_check_add FOR INSERT ON dd_pledge   
  compound trigger     
    
  yes_pledge     constant dd_pledge.firstpledge%type := 'Y';
  no_pledge      constant dd_pledge.firstpledge%type := 'N';
    
  type      don_type is table of dd_pledge.iddonor%type;   
  v_don  don_type := don_type();    

  before each row is    
    begin  
        v_don.extend;
        v_don (v_don.count)  :=  :new.iddonor;    
        :new.firstpledge           := no_pledge;     
    end before each row;    

  after statement is                  
    begin      
    forall i_doner in 1 .. v_don.count
    update dd_pledge   p1 
      set firstpledge = yes_pledge
      where p1.iddonor = v_don(i_doner) 
      and not exists ( select null from dd_pledge p2
          where p1.iddonor = p2.iddonor and p1.rowid != p2.rowid );    
    end after statement;

end firstPledge_check_add;

INSERT INTO DD_PLEDGE(IDPLEDGE, IDDONOR, PLEDGEDATE, PLEDGEAMT, IDPROJ,
 IDSTATUS, WRITEOFF, PAYMONTHS, CAMPAIGN, FIRSTPLEDGE)
 VALUES (113, 303, SYSDATE, 999, 500, 20, NULL, 0, 749, 'Y');


INSERT INTO DD_PLEDGE(IDPLEDGE, IDDONOR, PLEDGEDATE, PLEDGEAMT, IDPROJ,
 IDSTATUS, WRITEOFF, PAYMONTHS, CAMPAIGN, FIRSTPLEDGE)
 VALUES (114, 303, SYSDATE, 999, 500, 20, NULL, 12, 749, 'N');
