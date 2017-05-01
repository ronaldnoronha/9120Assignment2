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



insert into Participates values(







drop table Libraryitem;

create table Libraryitem(call_num integer primary key, title varchar(30));
create table Book( call_num integer primary key references Libraryitem(call_num), pages_book integer not null);
create table Dvd(call_num integer primary key references Libraryitem(call_num), duration_time integer not null);

create trigger Del_items
after delete on Book
for each row
when ((select count(*) from Dvd where call_num=:OLD.call_num) =0 )
begin
delete from Libraryitem where call_num = :OLD.call_num
end;



