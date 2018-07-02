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