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
   /*
   
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

-- 6.2.3. 명시적 커서의 속성

-- 6.2.4. 파라미터가 있는 커서

-- 6.2.5. The Where Current of Clause



