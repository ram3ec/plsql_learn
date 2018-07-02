create table departments
(
id_department number primary key,
v_name varchar2(32),
id_parent number
);
/
insert into departments(id_department, v_name, id_parent) values(1, '�������', null);
insert into departments(id_department, v_name, id_parent) values(2, '����������� 1', 1);
insert into departments(id_department, v_name, id_parent) values(3, '����������� 2', 1);
insert into departments(id_department, v_name, id_parent) values(4, '����������� 1-1', 2);
insert into departments(id_department, v_name, id_parent) values(5, '����������� 2-1', 3);
insert into departments(id_department, v_name, id_parent) values(6, '����������� 1-2', 2);
insert into departments(id_department, v_name, id_parent) values(7, '����������� 2-2', 3);
/
select *
from departments dp
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--������, ��������������� �������� � ����� WHERE, ����������� �� �������, � ��� �� ������� � ���
select *
from departments dp
where level != 2
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--level - �������������, ������� ���������� ������� ������� ��������
select level from dual connect by level < 10;
/
--nocycle - ��� ���������� ����������� ������
insert into departments(id_department, v_name, id_parent) values(8, '����������� 2-a', 9);
insert into departments(id_department, v_name, id_parent) values(9, '����������� 2-b', 10);
insert into departments(id_department, v_name, id_parent) values(10, '����������� 2-c', 8);
-- ORA-01436: CONNECT BY loop in user data
--select * from departments dp connect by prior dp.id_department = dp.id_parent start with dp.id_parent = 8;
select * from departments dp connect by nocycle prior dp.id_department = dp.id_parent start with dp.id_parent = 8;
rollback;
/
--connect_by_root - ���������� �������� ������� ������
select dp.*, connect_by_root(dp.v_name)
from departments dp
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--SYS_CONNECT_BY_PATH - ���������� ������ ���� � �������� � ��������� ������������
select dp.*, SYS_CONNECT_BY_PATH(dp.v_name, '->')
from departments dp
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--CONNECT_BY_ISCYCLE � ������� ���������� 1 ��� �����, � ������� ���� �������, ����������� �� ������� � 0 ��� ���� ���������. ����������� ������ � NOCYCLE
select dp.*, CONNECT_BY_ISCYCLE
from departments dp
connect by nocycle prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--CONNECT_BY_ISLEAF � ������� ���������� 1 ��� �������(���������, �� ������� ��������) � 0 ��� ���� ���������
select dp.*, CONNECT_BY_ISLEAF
from departments dp
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--ORDER SIBILINGS BY � ��������� ��� ���������� �������� � ����������� ������ � �������� ������ ��������
select dp.*
from departments dp
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null
order SIBLINGS by id_department;
/