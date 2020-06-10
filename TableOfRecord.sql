/*
    PL/SQL TABLE변수 선언과 비슷하며 데이터타입을 %ROWTYPE으로 선언한다.
    PL/SQL TABLE과 RECORD의 복합 기능을 한다.
*/
SELECT * FROM USERS;

create or replace procedure table_test 
is
 i binary_integer :=0;
 -- PL/SQL Table of Record의 선언
 type users_table_types is table of users%rowtype index by binary_integer;
 
 users_table users_table_types;
 
begin
    for users_list in ( select * from users) loop
        i:=i+1;
        --table of record에 데이터 보관 
        users_table(i).id := users_list.id;
        users_table(i).name := users_list.name;
        users_table(i).password := users_list.password;
        users_table(i).login := users_list.login;
        users_table(i).recommend := users_list.recommend;
        users_table(i).email := users_list.email;
    end loop;
    
    for cnt in 1..i loop
      -- 데이터 출력
      dbms_output.put_line('아아디 : ' || users_table(cnt).id);
      dbms_output.put_line('이름 : ' || users_table(cnt).name);
      dbms_output.put_line('로그인횟수 : ' || users_table(cnt).password);
    end loop;
  
end;
/

SELECT * FROM USER_source where type='PROCEDURE' and name='TABLE_TEST';
set serveroutput on;
execute table_test;

