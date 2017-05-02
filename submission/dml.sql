insert into Country values('AUS','Australia');
insert into Country values('NZ','New Zealand');
insert into Country values('CAT','Catalonia');

insert into Sport values('Swimming');
insert into Sport values('Runing');
insert into Sport values('Cicling');

insert into Vehicle values('8wxj8394',100);
insert into Vehicle values('3cow5312',100);
insert into Vehicle values('9mbp0583',100);

insert into Place values('Olympic Village','North Sydney','151.234E','33.524S');
insert into Place values('Sydney Village','32 Oxford street','342.678N','109.437W');
insert into Place values('Victory House','54 Clibeland road','32.437E','320.760N');

insert into Place values('Olympic Stadium','West Sydney','150.234E','33.524S');
insert into Place values('Olympic Pool','1-3 City road','667.221O','879.211S');
insert into Place values('Coles Stadium','158 Pitt street','87.964E','12.844S');

insert into Accommodation values('Olympic Village');
insert into Accommodation values('Sydney Village');
insert into Accommodation values('Victory House');

insert into Venue values('Olympic Stadium');
insert into Venue values('Olympic Pool');
insert into Venue values('Coles Stadium');

insert into Member values(1102033333,'AUS','Olympic Village','Mr','Ian','Thorpe');
insert into Member values(1674827442,'NZ','Sydney Village','Mr','Ronnald','Noronha');
insert into Member values(1583902583,'CAT','Victory House','Miss','Laura','Marcet');

insert into Athlete values(1102033333);
insert into Athlete values(1674827442);
insert into Athlete values(1583902583);

insert into Member values(0048234748,'AUS','Olympic Village','Mr','Barry','Wite');
insert into Member values(0054122352,'NZ','Sydney Village','Mr','Charls','Smith');
insert into Member values(0054293523,'CAT','Victory House','Miss','Anna','Puig');

insert into Official values(0048234748);
insert into Official values(0054122352);
insert into Official values(0054293523);

insert into Member values(3947590239,'AUS',null,'Mr','Bob','Builder');
insert into Member values(4935738493,'NZ',null,'Miss','Ingrid','Blanc');
insert into Member values(5768653024,'CAT',null,'Mr','Joan','Palau');

insert into Staff values(3947590239);
insert into Staff values(4935738493);
insert into Staff values(5768653024);

insert into Event values('100m Freestyle',to_timestamp('2017-05-15 07:00','yyyy-mm-dd hh24:mi'),to_date('2017-05-15','yyyy-mm-dd'),'time','Swimming','Olympic Stadium');



