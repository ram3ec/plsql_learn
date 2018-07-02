create table departments
(
id_department number primary key,
v_name varchar2(32),
id_parent number
);
/
insert into departments(id_department, v_name, id_parent) values(1, 'Главный', null);
insert into departments(id_department, v_name, id_parent) values(2, 'Департамент 1', 1);
insert into departments(id_department, v_name, id_parent) values(3, 'Департамент 2', 1);
insert into departments(id_department, v_name, id_parent) values(4, 'Департамент 1-1', 2);
insert into departments(id_department, v_name, id_parent) values(5, 'Департамент 2-1', 3);
insert into departments(id_department, v_name, id_parent) values(6, 'Департамент 1-2', 2);
insert into departments(id_department, v_name, id_parent) values(7, 'Департамент 2-2', 3);
/