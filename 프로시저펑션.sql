-------------------- 6월 08일 실습 --------------------

select *  from ALL_TAB_COLUMNS where TABLE_NAME = 'USERS';

-------------------- 프로시저 --------------------
grant create session, create table, create sequence, create view to tobi;
grant create procedure to tobi;

create or replace procedure update_recommend 
(v_recommend in number, v_id in varchar2 )
is
begin
    update users
    set recommend = v_recommend
    where id = v_id;
    
    commit;
end update_recommend;
/
SELECT * FROM USER_source where name='UPDATE_RECOMMEND';
select * from users;
execute update_recommend(2,'green');
select * from users;

-------------------- 함수 --------------------
/*
    out 파라미터 이용불가
    return문 필수
*/

create or replace function update_login
( v_id in varchar2)
return number
is
/* 변수선언부분.
   %type
     - 기술한 DB Column의 타입을 정확하게 알지 못할 경우 유용.
     - 기술한 DB Column의 타입이 변경되어도 PL/SQL을 다시 고칠 필요가 없다.
*/

v_login users.login%type;
begin
    update users
    set login=login*2
    where id = v_id;
    
    commit;
    
    -- select 한 값을 변수로 저장.
    select login
    into v_login 
    from users
    where id = v_id;
    
return v_login;
end;
/
SELECT * FROM USER_source where TYPE='FUNCTION';
select * from users;

--반환값을 저장할 변수 선언
var login_temp number;
--실행
execute :login_temp := update_login('green');
--PRINT문을 이용해력
print login_temp;

select * from users;





