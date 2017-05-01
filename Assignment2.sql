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
foreign key (accommodation_name) references Place(place_name));

create table Sport_Venue (
venue_name varchar(20) primary key, 
foreign key (venue_name) references Place(place_name));

--drop table Athlete;
--drop table Staff;
--drop table official;
--drop table Olympic_Member;
--drop table Sport_Venue;
--drop table Accommodation;
--drop table Place;

--create table Olympic_Member (
--member_id number(10,0) primary key);

--insert into Olympic_Member values(10001000000);

--select * from Olympic_Member;
--drop table Olympic_Member;

create table Olympic_Member (
member_id number(10,0) primary key,
country_code varchar(3) references Country(code) not null,
accommodation_name varchar(20) references Accommodation(accommodation_name), 
title_name varchar(8), 
family_name varchar(20) not null,
given_name varchar(20) not null
);

create table Athlete (
member_id integer primary key references Olympic_Member(member_id));

create table Official (
member_id integer primary key references Olympic_Member(member_id));

create table Staff (
member_id integer primary key references Olympic_Member(member_id));


create trigger Members_Total 
before insert on Olympic_Member
referencing new as N
for each row
when (Count(*) from Athlete where Athlete.member_id = N.member_id add count(*) from Official where Official.member_id = N.member_id = 0)
begin
raise exception 'Action violates total covering constraint'
end;
drop table Journey;

create table Journey(
start_time timestamp not null,
start_date date not null,
nbooked integer, 
departure_from varchar(20) not null references Place(place_name), 
destination varchar(20) not null references Place(place_name), 
vehicle_code varchar(8) not null references Vehicle(code),
constraint pk_Journey primary key(start_time, start_date, vehicle_code));

create table Event (
event_name varchar(20) primary key, 
start_time timestamp not null, 
start_date date not null, 
result_type varchar(20) not null, 
sport_name varchar(20) not null references Sport(sport_name), 
venue_name varchar(20) not null references Sport_Venue(venue_name));

--create domain medal_type varchar(6) default null check(value in('gold','silver','bronze'));

create table Participates (
athelete_id integer references Athlete(member_id), 
event_name varchar(20) references Event(event_name), 
event_result varchar(20), 
medal varchar(6) default null check(medal in ('Gold','Silver','Bronze'))); 
  
Select * from Books; 
drop table Books;
drop table Participates;
drop table Event;
drop table Journey;

create table Books (
when_booked timestamp not null, 
start_time timestamp not null references Journey(start_time), 
start_date date not null references Journey(start_date), 
member_id integer references Olympic_Member(member_id), 
staff_id integer not null references Staff(member_id), 
vehicle_code varchar(8) not null references Vehicle(code),
constraint unique_Books primary key(start_time,start_date,vehicle_code,staff_id));



create table Runs (
event_name varchar(20) references Event(event_name), 
official_id integer references Official(member_id), 
official_role varchar(20) not null,
event_name not null, 
official_id not null);
