/* PL/SQL의 INSERT */
CREATE TABLE emp
(
empno number not null,
ename varchar2(10),
deptno number );
select * from emp;

create or replace procedure insert_test
( 
    v_empno in emp.empno%type,
    v_ename in emp.ename%type,
    v_deptno in emp.deptno%type
)
is

begin
    dbms_output.enable;
    
    insert into emp( empno, ename, deptno ) 
    values(v_empno, v_ename, v_deptno);
    
    commit;
    
    DBMS_OUTPUT.PUT_LINE( '사원번호 : ' || v_empno );
    DBMS_OUTPUT.PUT_LINE( '사원이름 : ' || v_ename );
    DBMS_OUTPUT.PUT_LINE( '사원부서 : ' || v_deptno );
    DBMS_OUTPUT.PUT_LINE( '데이터 입력 성공 ' );
    
end;
/

SELECT * FROM USER_source  where type='PROCEDURE' and name='INSERT_TEST';
set serveroutput on;
execute insert_test(101,'test',30);

select * from emp;


/* PL/SQL의 update */
create or replace procedure update_test
( v_empno in emp.empno%type,
  v_deptno in emp.deptno%type
  )
  
is
    --수정 테이블을 확인하기 위한 변수
    v_emp emp%rowtype;
begin
    dbms_output.enable;
    
    update emp
    set deptno =  v_deptno
    where empno = 100;
    
    commit;
    
   dbms_output.put_line('데이터수정 성공');
   
   -- 수정된 데이터를 확인하기 위해 검색
   select empno,ename,deptno
   into v_emp.empno, v_emp.ename, v_emp.deptno
   from emp
   where empno= v_empno;
   
    DBMS_OUTPUT.PUT_LINE( ' **** 수 정 확 인 **** ');
    DBMS_OUTPUT.PUT_LINE( '사원번호 : ' || v_emp.empno );
    DBMS_OUTPUT.PUT_LINE( '사원이름 : ' || v_emp.ename );
    DBMS_OUTPUT.PUT_LINE( '부서번호 : ' || v_emp.deptno );
        
end;
/

set serveroutput on;
execute update_test(100,40);
select * from emp;

/* PL/SQL의 delete */
create or replace procedure delete_test
( p_empno in emp.empno%type)
is
    type del_record is record
    (
        v_empno emp.empno%type,
        v_ename emp.ename%type,
        v_deptno emp.deptno%type
    );
    v_emp del_record;
begin

    dbms_output.enable;
    
    --삭제된 데이터 확인용 쿼리
    select empno,ename,deptno
    into v_emp.v_empno, v_emp.v_ename, v_emp.v_deptno
    from emp
    where empno = p_empno;
    
    DBMS_OUTPUT.PUT_LINE( '사원번호 : ' || v_emp.v_empno );
    DBMS_OUTPUT.PUT_LINE( '사원이름 : ' || v_emp.v_ename );
    DBMS_OUTPUT.PUT_LINE( '부서번호 : ' || v_emp.v_deptno );
    
    --삭제 쿼리
    delete from emp where empno = p_empno;
    commit;
    
    dbms_output.put_line('delete success');
end;
/

set serveroutput on;
select * from emp;
execute delete_test(100);



