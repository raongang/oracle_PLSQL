/*
    5.1.1 FOR LOOP
    5.1.2 LOOP, WHILE
    5.2  IF
*/

select * from emp;
------------------- FOR LOOP -------------------
declare
 type ename_tables is table of emp.ename%type index by binary_integer;
 type empno_tables is table of emp.empno%type index by binary_integer; 
        
 ename_tab ename_tables;
 empno_tab empno_tables;
 
 i binary_integer :=0;
 
begin
    dbms_output.enable;
    
    -- emp_list는 자동선언되는 binary_integer형 변수이며, 1씩 증가한다.
    -- in대신 reverse 옵션도 사용가능
    -- in다음에는 select문이나 cursor가 올수 있음.
    for emp_list in (select empno, ename, deptno from emp) loop

    i := i+1;
    ename_tab(i) := emp_list.ename;
    empno_tab(i) := emp_list.empno;
    
    --dbms_output.put_line('empno : ' || empno_tab(i));
    --dbms_output.put_line('ename : ' || ename_tab(i));
        
    end loop;
    
    dbms_output.put_line('화면 출력');
    --화면에 출력
    -- 
    for cnt in 1 ..i loop
        dbms_output.put_line('empno : ' || empno_tab(cnt));
        dbms_output.put_line('ename : ' || ename_tab(cnt));
    end loop;
end;
/


------------------- LOOP -------------------
SET SERVEROUTPUT ON ;  
select * from emp;

DECLARE
 v_cnt number:=10;
begin
 DBMS_OUTPUT.ENABLE ;
 
 loop
    insert into emp(empno, ename, deptno ) 
    values(v_cnt,'test'||to_char(v_cnt),10);
    commit;
    v_cnt :=v_cnt+1;
    exit when v_cnt > 20;
 end loop;
 
    DBMS_OUTPUT.PUT_LINE('데이터 입력 완료');
    DBMS_OUTPUT.PUT_LINE(v_cnt-10 || '개의 데이터가 입력되었습니다');
end;
/

select * from emp order by empno;

------------------- WHILE LOOP -------------------
DECLARE
    V_CNT NUMBER:=100;
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    WHILE V_CNT < 110 LOOP
        INSERT INTO EMP(EMPNO, ENAME, DEPTNO)
         values(v_cnt,'test'||to_char(v_cnt),10);
         commit;
         V_CNT:= V_CNT+1;
         EXIT WHEN V_CNT>110;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('DATA INSERT SUCCESS');
    DBMS_OUTPUT.PUT_LINE(v_cnt-10 || '개의 데이터가 입력되었습니다');
END;
/

select * from emp;

------------------- IF -------------------

create or replace procedure ename_search
(p_empno in emp.empno%type)
is
    v_ename emp.ename%type;
begin
    dbms_output.enable;
    
    select ename
    into v_ename
    from emp
    where empno = p_empno;
    
    if v_ename = 'test' then 
        dbms_output.put_line('test deptno is 10');
    elsif v_ename='test2' then
        dbms_output.put_line('test2 deptno is 10');
    else 
        dbms_output.put_line('i dont know deptno for ' || p_empno);
    end if;
    exception
        when no_data_found then
            dbms_output.put_line('i dont know deptno for ' || p_empno);    
end;
/


set serveroutput on;
execute ename_search(1);
execute ename_search(9999);







