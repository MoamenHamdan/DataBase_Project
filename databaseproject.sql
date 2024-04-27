create database PROJECTDATABASE ;
use PROJECTDATABASE;

--create city entity(done)
create table city(
city_name varchar(50) primary key,
country varchar(50) not null,
state varchar(50)not null,
);



--create airport entity(done)
create table airport (
airport_code varchar(4) primary key,
airport_name varchar(35) not null unique,
location varchar(30) not null,
city_name varchar(50) not null,
foreign key (city_name)references city(city_name),
);


--create airline entity(done)
create table airline(
airline_id int primary key identity (1,1),
airline_name varchar(50) not null,
number_of_airplanes_owned int ,
);


--create hangar entity(done)
create table hangar(
hangar_number int primary key ,
hangar_capacity int not null,
hangar_location varchar(50) not null,
);


--create airplane entity(done)
create table airplane(
airplane_id int primary key ,
airline_id int not null,
registration_number int not null,
hangar_number int not null,
capacity int not null,
type varchar(50)not null,
maitenance_status varchar(20) not null check(maitenance_status='in maintenance' or maitenance_status='up to date'or maitenance_status='under repair'or maitenance_status='out of service'),
foreign key(hangar_number) references hangar(hangar_number), 
foreign key(airline_id)references airline(airline_id),
);



--create class entity (done)
create table class(
class_id int identity(1,1) primary key,
Description varchar(max),
Availability char(1) check (Availability = 'T' or Availability = 'F') ,
Capacity int not null,
luxury_amenities varchar(255) ,
exclusive_services varchar(255),
privacy_features varchar(255),
lounge_access bit,
priority_service bit,
);

--create ticket entity (done)
create table ticket(
class_id int not null ,
ticket_number int Identity(100,1),
flight_number int not null,
destination nvarchar(50),
Takeoff_location nvarchar(50),
seat_number int ,
Date_to_travel date ,
date_of_cancelation date,
surcharge money,
date_of_booking date,
foreign key (class_id) references class(class_id),
primary key (ticket_number , flight_number),
);


--create payment entity (done)
create table payment(
ticket_number int not null,
flight_number int not null,
transaction_id int identity(1,1) primary key ,
price money not null,
payment_mode nvarchar(40),
foreign key (ticket_number , flight_number) references ticket(ticket_number , flight_number),
);


---create contain relation(done)
create table contain(
airport_code varchar(4) not null,
airline_id int not null,
primary key(airport_code,airline_id),
foreign key (airport_code)references airport(airport_code),
foreign key(airline_id)references airline(airline_id),
);

---create gate entity(done)
create table gate(
gate_number varchar(3) check(gate_number like '[0-9][0-9][A-G]') primary key,
gate_status varchar(20) check(gate_status='Open' or gate_status='Close' or gate_status='boarding'),
airport_code varchar(4) not null,
foreign key (airport_code)references airport(airport_code),
);

--create weather entity(done)
create table weather(
weather_time time primary key,
atmospheric_pressure decimal(10,2),
temperature decimal(5,2),
);

--create flight entity(done)
create table flight(
    flight_id int primary key identity(1,1),
    status varchar(20) check(status in ('on time', 'canceled', 'delayed', 'landed', 'arrived', 'departed')),
    seats_available int not null,
    airplane_id int not null,
    origin varchar(50) not null,
    destination varchar(50) not null,
    departure_time datetime ,
    arrival_time datetime ,
    flight_type varchar(10) not null check (flight_type in ('private', 'public')),
    time datetime,
    layover_time datetime,
    number_of_stops int,
    gate_number varchar(3) not null,
    departure_airportcode char(3) not null check(departure_airportcode like '[A-Z][A-Z][A-Z]'),
    arrival_airportcode char(3) not null check(arrival_airportcode like '[A-Z][A-Z][A-Z]'),
    weather_time time not null,
    foreign key (airplane_id) references airplane(airplane_id),
    foreign key (gate_number) references gate(gate_number),
    foreign key (weather_time) references weather(weather_time)
);
alter table flight
add airline_id int foreign key references airline(airline_id);




---create runway entity(done)
create table runway_data(
runway_id int primary key identity(10,1),
flight_id int not null,
capacity int not null,
availability varchar(15) not null check (availability='available'or availability='occupied'or availability='closed'or availability='maitenance'),
maintenance_status varchar(15) check(maintenance_status in('up to date','scheduled','in maintenance','out of service')),
foreign key (flight_id)references flight(flight_id),
);

--create passenger entity 
create table passenger (
passenger_id int identity (20240000,1) primary key,
flight_id int not null,
gender char(1)  check (gender = 'T' or gender = 'F'),
age int not null,
address nvarchar(max),
ticket_number int not null,
flight_number int not null,
name nvarchar(max) not null,
phone varchar(15) not null unique ,
email varchar(30) not null unique ,
date_of_booking date not null,
foreign key (ticket_number , flight_number) references ticket(ticket_number , flight_number),
foreign key (flight_id)references flight(flight_id),
);

--create ground_transportation entity(done)
create table ground_transportation(
service_id int primary key identity(200,2),
type varchar(20) check(type in('taxi','private car','shuttle')),
rate decimal(10,2),
provider varchar(30),
availability bit default 0,
);

--create provides entity
create table provides(
passenger_id int not null,
service_id int not null,
primary key(passenger_id,service_id),
foreign key(passenger_id)references passenger(passenger_id),
foreign key(service_id)references ground_transportation(service_id),
);

--create baggage entity
create table baggage(
passenger_id int not null,
luggage_id varchar(4) primary key check(luggage_id like'[A-Z][A-Z][A-Z][0-9]'),
weight decimal (5,2),
flight_number int not null,
baggage_claim_area_no varchar(2) not null check(baggage_claim_area_no like'[A-Z][0-9]'),
luggage_type varchar(20) not null check(luggage_type in('carry on','fragile','personal item','checked')),
foreign key(passenger_id)references passenger(passenger_id),
foreign key (flight_number)references flight(flight_id),
);

--create lost_and_found entity
create table lost_and_found(
passenger_id int not null,
luggage_id varchar(4) check(luggage_id like'[A-Z][A-Z][A-Z][0-9]'),
datefound date ,
locationfound varchar(20),
description varchar(50),
foreign key(passenger_id)references passenger(passenger_id),
foreign key (luggage_id)references baggage(luggage_id),
);

--create dutyfree entity
create table dutyfree_product(
product_id int primary key identity(1,1),
price money,
discount float,
brand varchar(100),
name varchar(20),
expiration_date date,
);
DELETE FROM dutyfree_product;
DBCC CHECKIDENT ('dutyfree_product', RESEED, 0);


--create purchase entity
create table purchases(
passenger_id int not null,
product_id int not null,
foreign key(passenger_id)references passenger(passenger_id),
foreign key(product_id)references dutyfree_product(product_id),
);
---create vendor entity
create table vendor(
shop_number int primary key,
name varchar(max) not null,
gate_number varchar(3) not null,
foreign key(gate_number)references gate(gate_number), 
);

--create employee entity
create table employee(
ssn int primary key,
emp_age int ,
emp_phone varchar(8) not null unique,
first_name varchar(15) not null,
last_name varchar(20) not null,
salary money not null,
emp_gender char(1)  check (emp_gender = 'M' or emp_gender = 'F'),
airport_code varchar(4) not null,
job_type char(1) check(job_type in ('P','G','B','S','F')),
foreign key(airport_code) references airport(airport_code),
);

--create table pilot
create table pilot(
experience int,
Pilot_rank int ,
license_id int unique,
ssn int not null primary key,
foreign key(ssn)references employee(ssn),
);

--create table flies
create table flies(
ssn int not null,
airplane_id int not null,
foreign key(ssn)references pilot(ssn),
foreign key (airplane_id)references airplane(airplane_id)
);
DELETE FROM flies;
DBCC CHECKIDENT ('flies', RESEED, 0);

--create table Gate_staff
create table Gate_staff(
position int,
G_shift int,
Gate_number varchar(3) check(gate_number like '[0-9][0-9][A-G]') not null,
ssn int not null primary key,
foreign key(Gate_number)references Gate(gate_number),
foreign key(ssn)references employee(ssn),
);

--create flight_attendant
create table flight_attendant(
ssn int not null primary key,
roster_id int unique,
foreign key(ssn)references employee(ssn),
unifrom_size char(1) check(unifrom_size in('s','m')),
);

--create serves relation
create table serves(
passenger_id int not null,
ssn int not null,
foreign key(ssn)references flight_attendant(ssn),
foreign key(passenger_id)references passenger(passenger_id),
);

--create assigned relation
create table assigned(
ssn int not null,
flight_id int not null,
foreign key(ssn)references flight_attendant(ssn),
foreign key(flight_id)references flight(flight_id),
);

--create baggage_staff entity
create table baggage_staff(
languages_spoken varchar(15),
ssn int not null primary key,
foreign key(ssn)references employee(ssn),
);
ALTER TABLE baggage_staff
ALTER COLUMN languages_spoken VARCHAR(max);



--create handles relation
create table handles(
ssn int not null,
foreign key(ssn)references baggage_staff(ssn),
baggage_id varchar(4)check(baggage_id like'[A-Z][A-Z][A-Z][0-9]'),
foreign key(baggage_id)references baggage(luggage_id),
);


---create security entity
create table security_point(
seized_item_number int identity(1,1) primary key,
seized_item_type varchar(20) check(seized_item_type in ('weapons','liquids','drugs','prohibited items','cigarettes')),
security_checkpoint_number varchar(2) check(security_checkpoint_number like '[A-Z][0-9]'),
);

--create securitystaff entity
create table security_staff(
ssn int not null primary key,
foreign key(ssn)references employee(ssn),
training_certification varchar(255) ,
emergency_response_training varchar(255) ,
security_seized_item_number int not null,
foreign key(security_seized_item_number)references security_point(seized_item_number),
);

--create table supervisor
create table supervisor(
ssn_supervisor int,
ssn_supervisee int,
foreign key(ssn_supervisor)references employee(ssn),
foreign key(ssn_supervisee)references employee(ssn),
);

CREATE TABLE passenger_lounge (
    lounge_id int PRIMARY KEY IDENTITY(2,2),
    capacity int NOT NULL,
    lounge_location varchar(50) CHECK (lounge_location LIKE 'Terminal [1-9] Gate [a-g][1-9]'),
    amenities varchar(100)
);




--create serves entity
create table serves2(
lounge_id int not null,
airline_id int not null,
primary key(lounge_id, airline_id),
foreign key(lounge_id)references passenger_lounge(lounge_id),
foreign key(airline_id)references airline(airline_id),
);

--create check_incounter entity
create table checkin(
counter_id int primary key identity(200,1),
airline_id int not null,
foreign key(airline_id) references airline(airline_id),
);

---create location attribute
create table location(
counter_id int not null,
checkin_location varchar(30) not null,
foreign key(counter_id) references checkin(counter_id),
);
--create private entity
create table private_airplane(
airplane_id int not null,
id int not null,
refer_to nvarchar(20),
foreign key (airplane_id)references airplane(airplane_id),
primary key(airplane_id,id)
);







