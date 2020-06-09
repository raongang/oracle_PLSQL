/*
  3.1 스칼라 데이터 타입
   - 일반 단일 데이터타입 변수 , %Type 데이터형 변수
   3.2 복합데이터 타입
    - PL/SQL테이블과 레코드, %ROWTYPE
*/

Select *  from ALL_TAB_COLUMNS where TABLE_NAME = 'USERS';
SELECT * FROM USERS;

CREATE OR REPLACE PROCEDURE USERS_PRINT
(P_ID IN USERS.ID%TYPE)
IS
--%TYPE 데이터형 변수 선언
V_ID USERS.ID%TYPE;
V_NAME USERS.NAME%TYPE;
V_PASSWORD USERS.PASSWORD%TYPE;
V_EMAIL USERS.EMAIL%TYPE;

BEGIN
 
 DBMS_OUTPUT.ENABLE;
 
 --%TYPE 데이터형 변수 사용
 SELECT ID,NAME,PASSWORD, EMAIL
 INTO V_ID,V_NAME,V_PASSWORD, V_EMAIL
 FROM   USERS
 WHERE ID = P_ID;
 
 --결과값 출력
 DBMS_OUTPUT.PUT_LINE('ID : ' || V_ID);
 DBMS_OUTPUT.PUT_LINE('NAME : ' || V_NAME);
 DBMS_OUTPUT.PUT_LINE('PASSWORD : ' || V_PASSWORD);
 DBMS_OUTPUT.PUT_LINE('EMAIL : ' || V_EMAIL);
 END;
/
-- DBMS_OUTPUT 결과값을 화면에 출력하기 위해
SET SERVEROUTPUT ON;
EXECUTE USERS_PRINT('green');


/* 복합 데이터 타입
    - 하나 이상의 데이터값을 갖는 데이터 타입으로 배열과 비슷한 역할을 하고 재사용이 가능
    - %ROWTYPE, PL/SQL 테이블과 레코드 
*/

create or replace procedure rowType_test
(p_id in users.id%type)
is
-- %ROWTYPE 변수선언,
-- users 테이블의 속성을 그대로 사용할 수 있다.
v_users users%ROWTYPE;

begin
    dbms_output.enable;
    
    select id, name,password,login, recommend, email
    into v_users.id, v_users.name, v_users.password, v_users.login, v_users.recommend, v_users.email
    from users
    where id = p_id;
    
    DBMS_OUTPUT.PUT_LINE('ID : ' || v_users.id);
    DBMS_OUTPUT.PUT_LINE('NAME : ' || v_users.name);
    DBMS_OUTPUT.PUT_LINE('PASSWORD : ' || v_users.password);
    DBMS_OUTPUT.PUT_LINE('EMAIL : ' || v_users.email);
 end;
/

set serveroutput on;
execute rowtype_test('bumjin');


select * from users;


