drop trigger Members_Total;
drop trigger nBooked_check;
drop table Runs;
drop table Books;
drop table Participates;
drop table Event;
drop table Journey;
drop table Staff;
drop table Official;
drop table Athlete;
drop table Member;
drop table Venue;
drop table Accommodation;
drop table Place;
drop table Sport;
drop table Vehicle;
drop table Country;

create table Country (
code varchar(3) primary key, 
country_name varchar(20) not null);

drop table Vehicle;
create table Vehicle (
code varchar2(8) primary key, 
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
--foreign key (accommodation_name) references Place(place_name) on update cascade);-- on update cascade);

create table Sport_Venue (
venue_name varchar(20) primary key, 
foreign key (venue_name) references Place(place_name) on delete cascade); 

create table Olympic_Member (
member_id number(10,0) primary key,
country_code varchar(3) references Country(code) on delete set null,
accommodation_name varchar(20) references Accommodation(accommodation_name) on delete set null, 
title_name varchar(8), 
family_name varchar(20) not null,
given_name varchar(20) not null
);

create table Athlete (
member_id integer primary key references Olympic_Member(member_id) on delete cascade);

create table Official (
member_id integer primary key references Olympic_Member(member_id) on delete cascade);

create table Staff (
member_id integer primary key references Olympic_Member(member_id) on delete cascade);

drop trigger nBooked_check;
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

-- create assertion statement
create or replace trigger Members_Total 
before insert on Olympic_Member
for each row
declare total_participation exception;
athlete_count integer;
official_count integer;
begin
Select count(*) into athlete_count from Athlete where Athlete.member_id = :new.member_id; 
Select count(*) into official_count from Official where Official.member_id = :new.member_id;
if athlete_count+official_count>0
then
raise total_participation;
end if;
end;

create or replace trigger disjoint_Place_Accommodation
before insert on Accommodation
for each row
declare Accommodation_place exception;
places_count integer;
sports_venue_count integer;
begin
select count(*) into places_count from Place where place_name = :new.accommodation_name;
select count(*) into sports_venue_count from Sport_Venue where venue_name = :new.accommodation_name;
if places_count = 0 or sports_venue_count >0
then
raise Accommodaton_place;
end if;
end;
drop disjoint_Place_Accommodation;

create table Journey(
start_time timestamp not null,
start_date date not null,
nbooked integer, 
departure_from varchar(20) not null references Place(place_name) on delete cascade, 
destination varchar(20) not null references Place(place_name)on delete cascade, 
vehicle_code varchar(8) not null references Vehicle(code) on delete cascade,
constraint pk_Journey primary key(start_time, start_date, vehicle_code));

create table Event (
event_name varchar(20) primary key, 
start_time timestamp not null, 
start_date date not null, 
result_type varchar(20) not null, 
sport_name varchar(20) not null references Sport(sport_name) on delete cascade, 
venue_name varchar(20) not null references Sport_Venue(venue_name) on delete cascade);

create table Participates (
athelete_id integer references Athlete(member_id) on delete cascade, 
event_name varchar(20) references Event(event_name) on delete cascade, 
event_result varchar(20), 
medal varchar(6) default null check(medal in ('Gold','Silver','Bronze'))); 

create table Books (
when_booked timestamp not null, 
start_time timestamp not null, 
start_date date not null, 
member_id integer references Olympic_Member(member_id) on delete set null, 
staff_id integer not null references Staff(member_id) on delete cascade, 
vehicle_code varchar(8) not null,
constraint unique_Books primary key(start_time,start_date,vehicle_code,staff_id),
constraint for_key foreign key(start_time,start_date,vehicle_code) references Journey(start_time,start_date,vehicle_code));

create table Runs (
event_name varchar(20) references Event(event_name) on delete cascade, 
official_id integer references Official(member_id) on delete cascade, 
official_role varchar(20) not null,
constraint pk_Runs primary key(event_name,official_id));


