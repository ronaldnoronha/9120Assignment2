
create table Country (
code varchar(3) primary key, 
name varchar(20) not null);

create table Vehicle (
code varchar2(8) primary key check(length(code) =8), 
vehicle_capacity integer not null);

create table Sport(sport_name varchar(20) primary key);

create table Place(
place_name varchar(20) primary key, 
address varchar(20) not null,
gps_longitude varchar(20) not null, 
gps_latitude varchar(20) not null,
constraint unique_gps unique(gps_longitude,gps_latitude));

create table Accommodation(
accommodation_name varchar(20) primary key, 
foreign key (accommodation_name) references Place(place_name) on delete cascade);

create table Venue (
venue_name varchar(20) primary key, 
foreign key (venue_name) references Place(place_name) on delete cascade); 

create table Member (
member_id number(10,0) primary key,
country_code varchar(3) references Country(code) on delete set null,
accommodation_name varchar(20) references Accommodation(accommodation_name) on delete set null, 
title varchar(8), 
family varchar(20) not null,
given varchar(20) not null
);

create table Athlete (
member_id integer primary key references Member(member_id) on delete cascade);

create table Official (
member_id integer primary key references Member(member_id) on delete cascade);

create table Staff (
member_id integer primary key references Member(member_id) on delete cascade);

create table Journey(
start_time timestamp not null,
start_date date not null,
nbooked integer default 0, 
"from" varchar(20) not null references Place(place_name) on delete cascade, 
"to" varchar(20) not null references Place(place_name)on delete cascade, 
vehicle_code varchar(8) not null references Vehicle(code) on delete cascade,
constraint pk_Journey primary key(start_time, start_date, vehicle_code));

create table Event (
event_name varchar(20) primary key, 
start_time timestamp not null, 
start_date date not null, 
result_type varchar(20) not null, 
sport_name varchar(20) not null references Sport(sport_name) on delete cascade, 
venue_name varchar(20) not null references Venue(venue_name) on delete cascade);

create table Participates (
athelete_id integer references Athlete(member_id) on delete cascade, 
event_name varchar(20) references Event(event_name) on delete cascade, 
event_result varchar(20), 
medal varchar(6) default null check(medal in ('Gold','Silver','Bronze'))); 

create table Books (
when_booked timestamp not null, 
start_time timestamp not null, 
start_date date not null, 
member_id integer references Member(member_id) on delete set null, 
staff_id integer not null references Staff(member_id) on delete cascade, 
vehicle_code varchar(8) not null,
constraint for_key foreign key(start_time,start_date,vehicle_code) references Journey(start_time,start_date,vehicle_code),
constraint unique_Books primary key(start_time,start_date,vehicle_code,staff_id,when_booked)
);

create table Runs (
event_name varchar(20) references Event(event_name) on delete cascade, 
official_id integer references Official(member_id) on delete cascade, 
official_role varchar(20) not null,
constraint pk_Runs primary key(event_name,official_id));

create or replace trigger nBooked_check
before insert on Books
for each row
declare total_capacity_reached exception;
v_capacity integer;
total_booked integer;
begin
--update nbooked
--violation of capacity
Select sum(nbooked) into total_booked from Journey where (vehicle_code = :new.vehicle_code  
and start_time = :new.start_time and start_date = :new.start_date);
Select vehicle_capacity into v_capacity from Vehicle where code = :new.vehicle_code;
if (total_booked+1 > v_capacity)
then
raise total_capacity_reached;
else 
update Journey set nbooked = total_booked+1 where (vehicle_code = :new.vehicle_code  
and start_time = :new.start_time and start_date = :new.start_date);
end if;
end;

--create assertion Capacity_exceeded check(exists(select * from Journey where(nbooked>Vehicle.vehicle_capacity and Vehicle.code = vehicle_code);
