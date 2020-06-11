
/*
    패키지(package)는 오라클 데이터베이스에 저장되어 있는 서로 관련있는 PL/SQL 프로지져와 함수들의 집합 이다.
*/

-- 패키지 선언부 생성
create or replace package emp_info as 
    procedure all_emp_info;
    procedure all_sal_info;
    
    procedure dept_emp_info(v_deptno in number);
    procedure dept_sal_info(v_deptno in number);
    
end emp_info;
/

--패키지 본문 생성 예제
create or replace package body emp_info as

    --모든 사원의 사원정보
    procedure all_emp_info
    is
        cursor emp_cursor is
        select empno,ename,to_char(hiredate,'RRRR/MM/DD') hiredate 
        from    emp
        order by hiredate;
    begin
        for aa in emp_cursor loop
             DBMS_OUTPUT.PUT_LINE('사번 : ' || aa.empno);
             DBMS_OUTPUT.PUT_LINE('성명 : ' || aa.ename);
             DBMS_OUTPUT.PUT_LINE('입사일 : ' || aa.hiredate);
        end loop;
        
    
    exception 
           WHEN OTHERS THEN
             DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');    
    
    end all_emp_info;
    
    -- 모든 사원의 급여정보
    procedure all_sal_info
    is 
        cursor emp_cursor is
        select round(avg(sal),3) avg_sal,  max(sal) max_sal, min(sal) min_sal
        from emp;
    begin
         FOR  aa  IN emp_cursor LOOP
 
             DBMS_OUTPUT.PUT_LINE('전체급여평균 : ' || aa.avg_sal);
             DBMS_OUTPUT.PUT_LINE('최대급여금액 : ' || aa.max_sal);
             DBMS_OUTPUT.PUT_LINE('최소급여금액 : ' || aa.min_sal);
         
         END LOOP;

         EXCEPTION
            WHEN OTHERS THEN
               DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
    
    end all_sal_info;
    
     --특정 부서의  사원 정보
     PROCEDURE dept_emp_info (v_deptno IN  NUMBER)
     IS

         CURSOR emp_cursor IS
         SELECT empno, ename, to_char(hiredate, 'RRRR/MM/DD') hiredate
         FROM emp
         WHERE deptno = v_deptno
         ORDER BY hiredate;

     BEGIN

         FOR  aa  IN emp_cursor LOOP

             DBMS_OUTPUT.PUT_LINE('사번 : ' || aa.empno);
             DBMS_OUTPUT.PUT_LINE('성명 : ' || aa.ename);
             DBMS_OUTPUT.PUT_LINE('입사일 : ' || aa.hiredate);

         END LOOP;

        EXCEPTION
            WHEN OTHERS THEN
               DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');

     END dept_emp_info;


     --특정 부서의  급여 정보
     PROCEDURE dept_sal_info (v_deptno IN  NUMBER)
     IS
    
         CURSOR emp_cursor IS
         SELECT round(avg(sal),3) avg_sal, max(sal) max_sal, min(sal) min_sal
         FROM emp 
         WHERE deptno = v_deptno;
             
     BEGIN

         FOR  aa  IN emp_cursor LOOP 
 
             DBMS_OUTPUT.PUT_LINE('전체급여평균 : ' || aa.avg_sal);
             DBMS_OUTPUT.PUT_LINE('최대급여금액 : ' || aa.max_sal);
             DBMS_OUTPUT.PUT_LINE('최소급여금액 : ' || aa.min_sal);
         
         END LOOP;

         EXCEPTION
             WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');

     END dept_sal_info;        
    
  END emp_info;
  /    
  
  
  
    
SET SERVEROUTPUT ON ;     
EXEC emp_info.all_emp_info;
EXEC emp_info.all_sal_info;    
EXEC emp_info.dept_emp_info(10);
EXEC emp_info.dept_sal_info(10); 