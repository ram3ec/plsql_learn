create table departments
(
id_department number primary key,
v_name varchar2(32),
id_parent number
);
/
insert into departments(id_department, v_name, id_parent) values(1, '√лавный', null);
insert into departments(id_department, v_name, id_parent) values(2, 'ƒепартамент 1', 1);
insert into departments(id_department, v_name, id_parent) values(3, 'ƒепартамент 2', 1);
insert into departments(id_department, v_name, id_parent) values(4, 'ƒепартамент 1-1', 2);
insert into departments(id_department, v_name, id_parent) values(5, 'ƒепартамент 2-1', 3);
insert into departments(id_department, v_name, id_parent) values(6, 'ƒепартамент 1-2', 2);
insert into departments(id_department, v_name, id_parent) values(7, 'ƒепартамент 2-2', 3);
/
select *
from departments dp
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--строки, отфильтрованные условием в блоке WHERE, исключаютс€ из выборки, а вот их потомки Ч нет
select *
from departments dp
where level != 2
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--level - псевдостолбец, который показывает текущий уровень иерархии
select level from dual connect by level < 10;
/
--nocycle - дл€ исключени€ циклических ссылок
insert into departments(id_department, v_name, id_parent) values(8, 'ƒепартамент 2-a', 9);
insert into departments(id_department, v_name, id_parent) values(9, 'ƒепартамент 2-b', 10);
insert into departments(id_department, v_name, id_parent) values(10, 'ƒепартамент 2-c', 8);
-- ORA-01436: CONNECT BY loop in user data
--select * from departments dp connect by prior dp.id_department = dp.id_parent start with dp.id_parent = 8;
select * from departments dp connect by nocycle prior dp.id_department = dp.id_parent start with dp.id_parent = 8;
rollback;
/
--connect_by_root - возвращает корневой элемент дерева
select dp.*, connect_by_root(dp.v_name)
from departments dp
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--SYS_CONNECT_BY_PATH - возвращает полный путь к элементу с указанным разделителем
select dp.*, SYS_CONNECT_BY_PATH(dp.v_name, '->')
from departments dp
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--CONNECT_BY_ISCYCLE Ч функци€ возвращает 1 дл€ строк, у которых есть потомок, ссылающийс€ на предков и 0 дл€ всех остальных. ѕримен€етс€ только с NOCYCLE
select dp.*, CONNECT_BY_ISCYCLE
from departments dp
connect by nocycle prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--CONNECT_BY_ISLEAF Ч функци€ возвращает 1 дл€ листьев(элементов, не имеющих потомков) и 0 дл€ всех остальных
select dp.*, CONNECT_BY_ISLEAF
from departments dp
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null;
/
--ORDER SIBILINGS BY Ч созран€ет при сортировке иерархию и упор€дочить строки в пределах общего родител€
select dp.*
from departments dp
connect by prior dp.id_department = dp.id_parent
start with dp.id_parent is null
order SIBLINGS by id_department;
/