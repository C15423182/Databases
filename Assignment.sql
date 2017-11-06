DROP TABLE program;
DROP TABLE slot;
DROP TABLE ad;
DROP TABLE region;
DROP TABLE client;
DROP TABLE agency;
DROP TABLE audience;

SELECT * FROM audience;
SELECT * FROM agency;
SELECT * FROM client;
SELECT * FROM region;
SELECT * FROM ad;
SELECT * FROM slot;
SELECT * FROM program;





CREATE TABLE audience
(
    aud_id INT PRIMARY KEY,
    aud_type VARCHAR(200),
    aud_desc VARCHAR(200)
    
);

INSERT INTO audience VALUES(0004,'Teens','Between 12 and 18');

CREATE TABLE agency
(
    agency_id INT PRIMARY KEY,
    agency_name VARCHAR(50),
    agency_con_num VARCHAR(15)
);
INSERT INTO agency VALUES(0001,'Jeffers Adverts','353-1-530527');

CREATE TABLE client
(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(50)
);  

INSERT INTO client VALUES(0002,'Odehoes');

CREATE TABLE region
(
    region_id INT PRIMARY KEY,
    aud_id REFERENCES audience,
    region_type VARCHAR(50), /*Specifies region type i.e post-watershed, early am */
    rate INT
);

INSERT INTO region VALUES(2001,0004,'Early morning',1.4);
    
CREATE TABLE ad
(
    ad_id INT PRIMARY KEY,
    agency_id REFERENCES agency,
    region_id REFERENCES region,
    client_id REFERENCES client,
    brand VARCHAR(50),
    cert VARCHAR(15),
    start_date DATE,
    no_runs INT,
    ad_duration INT
);

INSERT INTO ad VALUES(0001,0001,2001,0002,'Fanta','TRUE','12-DEC-17',5,30);

CREATE TABLE slot
(
    slot_id INT PRIMARY KEY,
    ad_id REFERENCES ad,
    region_id REFERENCES region,
    slot_date DATE,
    prog_before VARCHAR(30),
    prog_after VARCHAR(30),
    event VARCHAR(4),
    status VARCHAR(4)
);

INSERT INTO slot VALUES(0123,0001,2001,'12-DEC-17','Midnight Murder','HoundSlash','FALS','FREE');

CREATE TABLE program
(
    prog_id INT,
    slot_id REFERENCES slot,
    aud_id REFERENCES audience,
    region_key REFERENCES region,
    prog_name VARCHAR(20),
    prog_date DATE
);
INSERT INTO program VALUES(0310,0123,0004,2001,'HoundSlash','12-DEC-17');

------------------Transactions Role------------------------
drop table agency;
drop sequence increment_agent_id;

create table agency
(
    agent_id integer not null primary key,
    agency_name varchar2(50) not null,
    agent_name varchar2(50) not null,
    agent_phone varchar(10)
);
---------------------------------------------------------------------------------------
--Agency Transactions
create sequence increment_agent_id
start with 1
increment by 1;

set serveroutput on
/
declare 
    v_id agency.agent_id%TYPE := increment_agent_id.NEXTVAL;
    v_agency_name agency.agency_name%TYPE :='&Enter_Agency_Name';
    v_agent_name agency.agent_name%TYPE :='&Enter_Agents_Name';
    v_phone agency.agent_phone%TYPE :='&Enter_Agents_Number';
    
begin
    insert into agency values (v_id,v_agency_name,v_agent_name,v_phone);
    commit;
    dbms_output.put_line ('Agent has been added with; \nID: ' || v_id || ' \nAgency Name: ' || v_agency_name 
    || ' \nAgency Name: ' || v_agent_name || '\nAgent Phone Number :' || v_phone);
    
exception
when others then 
     dbms_output.put_line ('Error ' || SQLCODE|| ' meaning ' ||SQLERRM ||'. Rolling back....');
     rollback;
end;
/

select * from agency;
















