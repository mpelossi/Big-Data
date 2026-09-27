-- Single aiport
CREATE TABLE airports (
  code varchar(5) primary key,
  name varchar(80) not null,
  city varchar(40) not null,
  residence varchar(2) not null,
  latitude float not null,
  longtide float not null
);

CREATE TABLE airlines (
  code varchar(5) primary key,
  name varchar(40) not null,
  residence varchar(2) not null
);

create table flights (
  id int primary key,
  flight_number varchar(7) not null,
  airline varchar(5) not null references airlines(code) on update cascade on delete cascade,
  departure varchar(4) not null references airports (code) on update cascade on delete cascade,
  arrival varchar(4) not null references airports (code) on update cascade on delete cascade,
  year int not null,
  month int not null,
  day int not null,
  load_factor float not null
);

create table flights_delay (
  flight_id int not null,
  arrival_delay int not null,
  cancellation boolean not null,
  divertion boolean not null,
  foreign key (flight_id) references flights (id)
);

