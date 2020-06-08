-------------------- 6�� 08�� �ǽ� --------------------

select *  from ALL_TAB_COLUMNS where TABLE_NAME = 'USERS';

-------------------- ���ν��� --------------------
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

-------------------- �Լ� --------------------
/*
    out �Ķ���� �̿�Ұ�
    return�� �ʼ�
*/

create or replace function update_login
( v_id in varchar2)
return number
is
/* ��������κ�.
   %type
     - ����� DB Column�� Ÿ���� ��Ȯ�ϰ� ���� ���� ��� ����.
     - ����� DB Column�� Ÿ���� ����Ǿ PL/SQL�� �ٽ� ��ĥ �ʿ䰡 ����.
*/

v_login users.login%type;
begin
    update users
    set login=login*2
    where id = v_id;
    
    commit;
    
    -- select �� ���� ������ ����.
    select login
    into v_login 
    from users
    where id = v_id;
    
return v_login;
end;
/
SELECT * FROM USER_source where TYPE='FUNCTION';
select * from users;

--��ȯ���� ������ ���� ����
var login_temp number;
--����
execute :login_temp := update_login('green');
--PRINT���� �̿��ط�
print login_temp;

select * from users;





