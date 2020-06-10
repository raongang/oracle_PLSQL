/*
    PL/SQL 레코드
      - 여러 개의 데이터 타입을 갖는 변수들의 집합
      - 스칼라, RECORD, 또는 PL/SQL TABLE datatype중 하나 이상의 요소로 구성.
      - PL/SQL테이블과 다르게 개별 필드의 이름을 부여할 수 있고, 선언시 초기화 가능
*/

SELECT * FROM USER_source;

CREATE OR REPLACE PROCEDURE RECORD_TEST
( P_ID IN USERS.ID%TYPE)
IS
 --하나의 레코드의 세가지의 변수타입 선언
  TYPE USERS_RECORD IS RECORD
  ( V_ID VARCHAR2(10),
    V_NAME VARCHAR2(30),
    V_LOGIN NUMBER);
    
    USERS_REC USERS_RECORD;

BEGIN

    DBMS_OUTPUT.ENABLE;
    --레코드 사용
    SELECT ID, NAME,LOGIN 
    INTO USERS_REC.V_ID, USERS_REC.V_NAME, USERS_REC.V_LOGIN
    FROM USERS
    WHERE ID = P_ID;
    
    dbms_output.put_line('아아디 : ' || USERS_REC.V_ID);
    dbms_output.put_line('이름 : ' ||   USERS_REC.V_NAME);
    dbms_output.put_line('로그인횟수 : ' ||  USERS_REC.V_LOGIN);
    
END;
/

set serveroutput on;
execute record_test('bumjin');

