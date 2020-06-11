/*
  6.2 명시적커서(explicit cursor)
   - 오라클 서버에 의해 실행되는 모든 SQL문은 연관된 각각의 커서를 소유하고 있다.
   - 명시적 커서 : 프로그래머에 의해 선언되며 이름이 있는 커서이다.
   cursor cursor_name 
   select statement
*/
select * from emp;
select * from dept;
select * from bonus;
select * from salgrade;

-- 6.2.1. 명시적 커서
--특정부서의 평균급여와 사원수를 출력
create or replace procedure expCursor_test
(v_deptno in dept.deptno%type)
is
    cursor dept_avg is 
    select b.dname, count(a.empno) cnt, round(avg(a.sal),3) salary
    from emp a, dept b
    where a.deptno = b.deptno
    and b.deptno = 10
    group by b.dname;
    
    --커서를 패치하기 위한 편수 선언
    v_dname dept.dname%type;
    emp_cnt number;
    sal_avg number;
   
begin
   --커서 오픈
   open dept_avg;
   
   /* 커서 패치
   커서의 SELECT문의 컬럼의 수와 OUTPUT변수의 수가 동일해야 한다.
   커서 컬럼의 변수의 타입과 OUTPUT변수의 데이터 타입도 동일해야 한다.
   커서는 한 라인씩 데이터를 패치 한다.
   */
   
   fetch dept_avg into v_dname,emp_cnt,sal_avg;
   
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || v_dname);
    DBMS_OUTPUT.PUT_LINE('사원수 : ' || emp_cnt);
    DBMS_OUTPUT.PUT_LINE('평균급여 : ' || sal_avg);
    --커서 close
    close dept_avg;
    
    exception
    when others then
         DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');      
end;
/
set serveroutput on;
execute expCursor_test(30);

-- 6.2.2. FOR문에서 커서사용
-- for문 사용시 커서의 open, fetch, close가 자동 발생하므로 따로 기술할 필요가 없고, 레코드 이름도 자동 선언되므로 따로 선언 할 필요가 없음
SELECT * FROM USER_source ;

create or replace procedure forCursor_test
is
--Cursor선언
        CURSOR dept_sum IS
        SELECT b.dname, COUNT(a.empno) cnt, SUM(a.sal) salary
        FROM emp a, dept b
        WHERE a.deptno = b.deptno
        GROUP BY b.dname;

begin
    -- cursor를 for문에서 실행시킨다
       FOR emp_list IN dept_sum LOOP
          DBMS_OUTPUT.PUT_LINE('부서명 : ' || emp_list.dname);
          DBMS_OUTPUT.PUT_LINE('사원수 : ' || emp_list.cnt);
          DBMS_OUTPUT.PUT_LINE('급여합계 : ' || emp_list.salary);
       END LOOP;
    
    exception
    when others then
    DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
end;
/
set serveroutput on;
execute forCursor_test;


-- 6.2.3. 명시적 커서의 속성
-- 속성 : %isopen, %notfound, %found, %rowcount
create or replace procedure afterCursor_Test
is
v_empno emp.empno%type;
v_ename emp.ename%type;
v_sal emp.sal%type;

CURSOR emp_list IS
select empno, ename, sal
from emp;

begin
    dbms_output.enable;
    
    OPEN emp_list;
    
    LOOP 
        FETCH emp_list INTO v_empno, v_ename, v_sal;
        --데이터를 찾지 못하면 빠져 나간다.
        EXIT WHEN emp_list%notfound;
        
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('전체데이터 수 ' || emp_list%ROWCOUNT);
    
    CLOSE emp_list;
    EXCEPTION
         WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM);    
end;
/
EXECUTE afterCursor_Test;

-- 6.2.4. 파라미터가 있는 커서

CREATE OR REPLACE PROCEDURE ParaCursor_Test
(param_deptno emp.deptno%type)

IS
 --parameter가 있는 커서의 선언
 CURSOR emp_list(v_deptno emp.deptno%type) is 
 select ename
 from emp
 where deptno = v_deptno;
 
BEGIN
    dbms_output.enable;
    DBMS_OUTPUT.PUT_LINE(' ****** 입력한 부서에 해당하는 사람들 ****** ');            
    
    -- parameter 변수의 값을 전달(open될때 값을 전달한다)
    FOR emplst in emp_list(param_deptno) LOOP
           DBMS_OUTPUT.PUT_LINE('이름 : ' || emplst.ename);
    END LOOP;
    
   EXCEPTION  
  WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM);         
END;
/
EXECUTE ParaCursor_Test(10);

-- 6.2.5. The Where Current of Clause
-- ROWID를 이용하지 않고도 현재 참조하는 행을 갱신하고 삭제할 수 있게 한다.
--추가적으로 FETCH문에 의해 가장 최근에 처리된 행을 참조하기 위해서 "WHERE CURRENT OF 커서이름 " 절로 DELETE나 UPDATE문 작성이 가능하다.
--이 절을 사용할 때 참조하는 커서가 있어야 하며, FOR UPDATE절이 커서 선언 query문장 안에 있어야 한다. 그렇지 않으면 에러가 발생한다.
create or replace procedure where_current
is

cursor emp_list is
select empno
from emp
where empno=7934
for update;

begin
    DBMS_OUTPUT.ENABLE;    
    for emplist in emp_list loop
        --emp_list 커서에 해당하는 사람들의 작업을 salesman으로 업데이트 시킨다.
        update emp
        set job='salesman'
        where current of emp_list;
        DBMS_OUTPUT.PUT_LINE('수정 성공');
        
    end loop;

   EXCEPTION
           WHEN OTHERS THEN 
           -- 에러 발생시 에러 메시지 출력
           DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM);         
end;
/

execute where_current;
select * from emp where empno=7934;




