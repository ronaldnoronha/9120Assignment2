drop trigger Members_Total;
drop table if exists Runs;
drop table if exists Books;
drop table if exists Participates;
drop table if exists Event;
drop table if exists Journey;
drop table if exists Staff;
drop table if exists Official;
drop table if exists Athlete;
drop table if exists Olympic_Member;
drop table if exists Sport_Venue;
drop table if exists Accommodation;
drop table if exists Place;
drop table if exists Sport;
drop table if exists Vehicle;
drop table if exists Country;

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

create table Participates (
athelete_id integer references Athlete(member_id), 
event_name varchar(20) references Event(event_name), 
event_result varchar(20), 
medal varchar(6) default null check(medal in ('Gold','Silver','Bronze'))); 

create table Books (
when_booked timestamp not null, 
start_time timestamp not null, 
start_date date not null, 
member_id integer references Olympic_Member(member_id), 
staff_id integer not null references Staff(member_id), 
vehicle_code varchar(8) not null,
constraint unique_Books primary key(start_time,start_date,vehicle_code,staff_id),
constraint for_key foreign key(start_time,start_date,vehicle_code) references Journey(start_time,start_date,vehicle_code));

create table Runs (
event_name varchar(20) references Event(event_name), 
official_id integer references Official(member_id), 
official_role varchar(20) not null,
constraint pk_Runs primary key(event_name,official_id));
