insert into Country values('AUST','Australia');

insert into Sport values('Swimming');

insert into Place values('Olympic Village','North Sydney','151.234E','33.524S');

insert into Place values('Coles Stadium','158 Pitt street','87.964E','12.844S');

insert into Accommodation values('Olympic Village');

insert into Venue values('Coles Stadium');

insert into Member values(11020uy333,'AUS','Olympic Village','Mr','Ian','Thorpe');

insert into Athlete values(1583902583);

insert into Member values(0048234748,'AUS','Olympic Village','Mr','Barry','Wite');

insert into Official values(0054293523);

insert into Member values(3947590239,'AUS',null,'Mr','Bob','Builder');

insert into Staff values(5768653024);

insert into Event values('100m Freestyle',to_timestamp('2017-05-15 07:00','yyyy-mm-dd hh24:mi'),to_date('2017-05-15','yyyy-mm-dd'),'time','Swimming','Olympic Stadium');

insert into Participates values(1102033333,'100m Freestyle','123.03s','silver');

-- Demo Trigger contraint broken

insert into Vehicle values('9mbp2583',0);
Select * from Vehicle;

insert into Journey values(to_timestamp('2017-05-15 07:00','yyyy-mm-dd hh24:mi'),to_date('2017-05-15','yyyy-mm-dd'), 0, 'Olympic Village', 'Olympic Pool', '9mbp2583');
Select * from Journey;



insert into Books values(to_timestamp('2017-05-14 07:00','yyyy-mm-dd hh24:mi'),to_timestamp('2017-05-15 07:00','yyyy-mm-dd hh24:mi'),to_date('2017-05-15','yyyy-mm-dd'),0048234748,3947590239,'9mbp2583');

insert into Runs values('100m Freestyle',0048234748,'Cleaner');