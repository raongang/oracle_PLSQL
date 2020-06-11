/*
     트리거(trigger) 
       - INSERT, UPDATE, DELETE문이 TABLE에 대해 행해질 때 묵시적으로 수행되는 PROCEDURE 이다.
       - 트리거는 TABLE과는 별도로 DATABASE에 저장 된다.
       - 트리거는 VIEW에 대해서가 아니라 TABLE에 관해서만 정의 될 수 있다.
       - 행 트리거 : 컬럼의 각각의 행의 데이터 행 변화가 생길때마다 실행되며, 그 데이터 행의 실제값을 제어할 수 있다.
       - 문장 트리거 : 트리거 사건에 의해 단 한번 실행되며, 컬럼의 각 데이터 행을 제어 할 수 없다.
  
*/

CREATE OR REPLACE TRIGGER triger_test
       BEFORE
       UPDATE ON dept
       FOR EACH ROW
	   
	   BEGIN
        DBMS_OUTPUT.PUT_LINE('변경 전 컬럼 값 : ' || :OLD.DNAME);
        DBMS_OUTPUT.PUT_LINE('변경 후 컬럼 값 : ' || :NEW.DNAME);
     END;
     /
     
SET SERVEROUTPUT ON ;      

UPDATE dept SET dname = '총무부' WHERE deptno = 30;
select * from dept where deptno=30;

create or replace trigger sum_trigger
before
insert or update on emp
for each row

declare
--변수를 선언할때는 declare를 써야 한다.
    avg_sal number;
begin
    select round(avg(sal),3)
    into avg_sal
    from emp;
    
     DBMS_OUTPUT.PUT_LINE('급여 평균 : ' || avg_sal);
end;
/

set serveroutput on;

 INSERT INTO EMP(EMPNO, ENAME, JOB, HIREDATE, SAL) VALUES(1000, 'LION', 'SALES', SYSDATE, 5000);
 --급여 평균 : 2073.214

select round(avg(sal),3) from emp;
