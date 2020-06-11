/*
 7. 예외절 처리
  7.1 예외
  7.2 미리 정의된 예외
  7.3 미리 정의되지 않은 예외
  7.4 사용자 정의 예외
  7.5 SQLCODE, SQLERRM
  
*/

/*
 7.2 미리 정의된 예외 
 예)
  - NO_DATA_FOUND : SELECT문이 아무런 데이터 행을 반환하지 못할 때
  - DUP_VAL_ON_INDEX : UNIQUE 제약을 갖는 컬럼에 중복되는 데이터가 INSERT 될 때
  - ZERO_DIVIDE : 0으로 나눌 때
  - INVALID_CURSOR : 잘못된 커서 연산
*/
CREATE OR REPLACE PROCEDURE PreException_test
         (v_deptno  IN emp.deptno%TYPE)  
   IS
       v_emp   emp%ROWTYPE;
   BEGIN

      DBMS_OUTPUT.ENABLE;

      /*
      SELECT empno, ename, deptno
      INTO v_emp.empno, v_emp.ename, v_emp.deptno
      FROM emp
      WHERE deptno = v_deptno ;
      */
      for emplist in ( 
SELECT empno, ename, deptno
  FROM emp
 WHERE deptno = v_deptno)

loop

DBMS_OUTPUT.PUT_LINE('사번 : ' || emplist.empno);
DBMS_OUTPUT.PUT_LINE('이름 : ' || emplist.ename);
DBMS_OUTPUT.PUT_LINE('부서번호 : ' || emplist.deptno);

end loop;
/*
DBMS_OUTPUT.PUT_LINE('사번 : ' || v_emp.empno);
DBMS_OUTPUT.PUT_LINE('이름 : ' || v_emp.ename);
DBMS_OUTPUT.PUT_LINE('부서번호 : ' || v_emp.deptno);
*/
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('데이터가 존재 합니다.'); DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX 에러 발생'); WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS에러 발생'); WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND에러 발생'); WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('기타 에러 발생');

END;

--execute PreException_test(20);  
--TOO_MANY_ROWS에러 발생

/*
 7.3 미리 정의되지 않은 예외
*/

create or replace procedure NonPreException_Test is not_null_test exception; -- 예외이름선언

/* not_null_test는 선언된 예외 이름  
-1400 Error 처리번호는 표준 Oracle7 Server Error 번호 
PRAGMA EXCEPTION_INIT문장으로 예외의 이름과 오라클 서버 오류 번호를 결합 (선언절)
*/
pragma exception_init(not_null_test, -1400); begin DBMS_OUTPUT.ENABLE;
-- empno를 입력하지 않아서 NOT NULL 에러 발생
insert into emp(ename, deptno) values('tiger', 30);

exception when not_null_test then DBMS_OUTPUT.PUT_LINE('not null 에러 발생 '); dbms_output.put_line('Error : ' || SQLERRM); end;

select * from user_source where type = 'PROCEDURE' and name = 'NONPREEXCEPTION_TEST';

--EXECUTE NonPreException_Test;
--not null 에러 발생

/*
 7.4. 사용자 정의 예외
   오라클 저장함수 RAISE_APPLICATION_ERROR를 사용하여 오류코드 -20000부터 -20999의 범위 내에서 사용자 정의 예외를 만들수 있다.
*/

--입력한 부서의 사원이 5명보다 적으면 사용자 정의 예외가 발생하는 예제
CREATE OR REPLACE PROCEDURE User_Exception(v_deptno IN emp.deptno%type) IS

-- 예외의 이름을 선언
user_define_error EXCEPTION; -- STEP 1
cnt NUMBER;

BEGIN

DBMS_OUTPUT.ENABLE;

SELECT COUNT(empno) INTO cnt FROM emp WHERE deptno = v_deptno;

IF cnt < 5 THEN
-- RAISE문을 사용하여 직접적으로 예외를 발생시킨다
RAISE user_define_error; -- STEP 2
END IF;

EXCEPTION
-- 예외가 발생할 경우 해당 예외를 참조한다.
WHEN user_define_error THEN -- STEP 3
RAISE_APPLICATION_ERROR(-20001, '부서에 사원이 몇명 안되네요..');

END;

-- EXECUTE  User_Exception(10);
--  EXECUTE  User_Exception(20);


CREATE OR REPLACE PROCEDURE Errcode_Exception 
        (v_deptno IN emp.deptno%type ) 
     IS

         v_emp   emp%ROWTYPE ;  

     BEGIN  

         DBMS_OUTPUT.ENABLE;

         -- ERROR발생 for문을 돌려야 됨
         SELECT * 
         INTO v_emp
         FROM emp
         WHERE deptno = v_deptno;
      
         DBMS_OUTPUT.PUT_LINE('사번 : ' || v_emp.empno);    
         DBMS_OUTPUT.PUT_LINE('이름 : ' || v_emp.ename);    
          
     EXCEPTION
      
     WHEN OTHERS THEN

          DBMS_OUTPUT.PUT_LINE('ERR CODE : ' || TO_CHAR(SQLCODE));
          DBMS_OUTPUT.PUT_LINE('ERR MESSAGE : ' || SQLERRM);

  END;  
  /
  
  SET SERVEROUTPUT ON; 
  EXECUTE Errcode_Exception(30);



