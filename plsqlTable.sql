/*
   pl/sql의 테이블
     - 일종의 일차원 배열
     - 크기에 제한이 없다.
     - 그 ROW의 수는 데이터가 들어옴에 따라 자동 증가
     - Binary_integer 타입의 인덱스 번호로 순서가 정해진다.
     - 하나의 테이블에 한개의 컬럼 데이터를 저장한다.
*/

create or replace procedure table_test
( v_id in users.id%type)

is
--각 컬럼에서 사용할 테이블의 선어
type userid_tables is table of users.id%type index by binary_integer;
type username_tables is table of users.name%type index by binary_integer;
type userlogin_tables is table of users.login%type index by binary_integer;

--테이블 타입으로 변수를 선언해서 사용
-- ※ 변수선언을 먼저하고 타입선언을 함.
userid_tab userid_tables;
username_tab username_tables;
userlogin_tab userlogin_tables;
i binary_integer := 0;

begin
    dbms_output.enable;
    -- user_list는 자동선언되는 binary_integer 형 변수로 1씩 증가한다.
    -- user_list 대신 다른 문자열 사용가능.
    for users_list in (
        select id,name,login
        from    users where id= v_id)LOOP
        
    i := i+1;
    dbms_output.put_line('i : ' || i);
    --테이블 변수에 검색된 결과를 넣는다.
     userid_tab(i) := users_list.id;
     username_tab(i):=users_list.name;
     userlogin_tab(i):=users_list.login;
    end loop;
    
    --1부터 i까지 for문 실행
    for cnt in 1..i loop
      -- table 변수에 넣은 값을 뿌려줌
      dbms_output.put_line('아아디 : ' || userid_tab(cnt));
      dbms_output.put_line('이름 : ' || username_tab(cnt));
      dbms_output.put_line('로그인횟수 : ' || userlogin_tab(cnt));
      
    end loop;
end;
/

SELECT * FROM USER_source where name='TABLE_TEST';
SET SERVEROUTPUT ON;
EXECUTE TABLE_TEST('green');



