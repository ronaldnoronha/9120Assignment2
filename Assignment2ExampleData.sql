insert into Country values('AUS','Australia');

insert into Sport values('Swimming');

insert into Vehicle values('8wxj8394',100);

insert into Place values('Olympic Village','North Sydney','151.234E','33.524S');

insert into Place values('Olympic Stadium','West Sydney','150.234E','33.524S');

insert into Accommodation values('Olympic Village');

insert into Sport_Venue values('Olympic Stadium');

delete from Place where (place_name = 'Olympic Village');
select * from Olympic_Member;


insert into Olympic_Member values(1102033333,'AUS','Olympic Village','Mr','Ian','Thorpe');

insert into Athlete values(1102033333);

insert into Olympic_Member values(0048234748,'AUS','Olympic Village','Mr','Grant','Hackett');

insert into Official values(0048234748);

insert into Olympic_Member values(3947590239,'AUS',null,'Mr','Bob','Builder');

insert into Staff values(3947590239);

--create table experiment_time(start_date date primary key);--

--insert into experiment_time values(TO_DATE('15-May-2017','dd-mon-yyyy'));--

insert into Event values('100m Freestyle',to_timestamp('2017-05-15 07:00','yyyy-mm-dd hh24:mi'),to_date('2017-05-15','yyyy-mm-dd'),'time','Swimming','Olympic Stadium');



