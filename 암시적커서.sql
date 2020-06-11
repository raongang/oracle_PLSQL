/* 암시적 커서(implicit Cursor)

  암시적인 커서는 오라클이나 PL/SQL실행 메커니즘에 의해 처리되는 SQL문장이 처리되는 곳에 대한 익명의 주소이다.
  오라클 데이터베이스에서 실행되는 모든 SQL문장은 암시적인 커서가 생성되며, 커서 속성을 사용 할 수 있다.
  암시적 커서는 SQL 문이 실행되는 순간 자동으로 OPEN과 CLOSE를 실행 한다.
  
암시적 커서의 속성
- SQL%ROWCOUNT : 해당 SQL 문에 영향을 받는 행의 수
- SQL%FOUND : 해당 SQL 영향을 받는 행의 수가 한 개 이상일 경우 TRUE
- SQL%NOTFOUND : 해당 SQL 문에 영향을 받는 행의 수가 없을 경우 TRUE
- SQL%ISOPEN : 항상 FALSE, 암시적 커서가 열려 있는지의 여부 검색
 */
 
 select * from emp;
 create or replace procedure implicit_Cursor
 ( p_empno in emp.empno%type)
 is
    v_deptno emp.deptno%type;
    v_update_row number;
 begin
    select deptno
    into v_deptno
    from emp
    where empno = p_empno;
    
    if sql%found then
        DBMS_OUTPUT.PUT_LINE('검색한 데이터가 존재합니다 : '||v_deptno);
    end if;        
    -- 수정
    v_update_row := sql%rowcount;
    DBMS_OUTPUT.PUT_LINE('v_update_row : '|| v_update_row);
    
    EXCEPTION    
    WHEN   NO_DATA_FOUND  THEN  
    DBMS_OUTPUT.PUT_LINE(' 검색한 데이터가 없네요... ');
 end;
 /
 
select * from emp;
set serveroutput on;
execute implicit_Cursor(100);


 
 