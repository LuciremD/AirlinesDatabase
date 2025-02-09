----------------------------------------------------------------------
------------------------------CREATION--------------------------------
----------------------------------------------------------------------

create schema if not exists flights;

create table if not exists flights.Passengers (
    Passenger_id INTEGER PRIMARY KEY,
    Name VARCHAR(100),
    Surname VARCHAR(100),
    Fathers_name VARCHAR(100)
);

create table if not exists flights.Airlines (
    Airline_id VARCHAR(100) PRIMARY KEY,
    Name VARCHAR(100)
);

create table if not exists flights.Planes (
    Plane_id VARCHAR(100) PRIMARY KEY,
    Model VARCHAR(100),
    Airline_id VARCHAR(100) REFERENCES flights.Airlines,
    Date_of_creation DATE
);

create table if not exists flights.Airports (
    Airport_id VARCHAR(100) PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(100)
);

create table if not exists flights.Flights (
    Number INTEGER PRIMARY KEY,
    Airline_id VARCHAR(100) REFERENCES flights.Airlines,
    Plane_id VARCHAR(100) REFERENCES flights.Planes,
    Date_of_departure DATE,
    Airport_of_departure VARCHAR(100) REFERENCES flights.Airports,
    Date_of_arrival DATE,
    Airport_of_arrival VARCHAR(100) REFERENCES flights.Airports,
    CONSTRAINT unique_pair UNIQUE (Number, Airline_id)
);

create table if not exists flights.Passenger_Flight (
    Passenger_id INTEGER REFERENCES flights.Passengers,
    Number INTEGER REFERENCES flights.Flights,
    CONSTRAINT unique_pair_1 UNIQUE (Passenger_id, Number)
);

create table if not exists flights.Flight_Date (
    Number INTEGER REFERENCES flights.Flights,
    Old_date_of_departure DATE,
    New_date_of_departure DATE,
    Old_date_of_arrival DATE,
    New_date_of_arrival DATE
);

----------------------------------------------------------------------
------------------------------INSERTIONS------------------------------
----------------------------------------------------------------------

INSERT INTO flights.Passengers (Passenger_id, Name, Surname, Fathers_name) VALUES
    (1, 'Ivan', 'Ivanov', 'Ivanovich'),
    (2, 'Petr', 'Petrov', 'Petrovich'),
    (3, 'Anna', 'Sidorova', 'Mikhailovna'),
    (4, 'Yelena', 'Kozlova', 'Alekseevna'),
    (5, 'Aleksey', 'Smirnov', 'Petrovich'),
    (6, 'Mariya', 'Ivanova', 'Pavlovna'),
    (7, 'Sergey', 'Fedorov', 'Nikolaevich'),
    (8, 'Olga', 'Pavlova', 'Alekseevna'),
    (9, 'Nikolay', 'Kuznetsov', 'Sergeevich'),
    (10, 'Irina', 'Morozova', 'Dmitrievna'),
    (11, 'Dmitri', 'Vasiliev', 'Igorevich'),
    (12, 'Yevgeniya', 'Nikolaeva', 'Olegovna'),
    (13, 'Vladimir', 'Sokolov', 'Alekseevich'),
    (14, 'Anastasiya', 'Petrova', 'Sergeevna'),
    (15, 'Aleksandr', 'Kozlov', 'Mikhailovich');

INSERT INTO flights.Airlines (Airline_id, Name) VALUES
    ('SU', 'Аэрофлот'),
    ('S7', 'S7 Airlines'),
    ('U6', 'Уральские авиалинии'),
    ('DP', 'Победа'),
    ('B2', 'Белавиа'),
    ('UT', 'UTair'),
    ('7R', 'РусЛайн'),
    ('GH', 'Глобус'),
    ('N4', 'Нордавиа'),
    ('FV', 'Россия'),
    ('NN', 'Азимут'),
    ('5N', 'Нордстар'),
    ('G9', 'РусДжет'),
    ('IO', 'Икар'),
    ('I8', 'Ижавиа');

INSERT INTO flights.Planes (Plane_id, Model, Airline_id, Date_of_creation) VALUES
    ('SU1001', 'Airbus A320', 'SU', '2015-10-15'),
    ('SU1002', 'Boeing 777', 'SU', '2018-04-23'),
    ('SU1003', 'Airbus A330', 'SU', '2019-07-30'),

    ('S7001', 'Airbus A319', 'S7', '2014-12-28'),
    ('S7002', 'Boeing 737', 'S7', '2017-09-14'),
    ('S7003', 'Embraer E170', 'S7', '2019-02-10'),

    ('U6001', 'Airbus A321', 'U6', '2016-06-20'),
    ('U6002', 'Boeing 767', 'U6', '2018-11-05'),
    ('U6003', 'Airbus A320neo', 'U6', '2020-03-18'),

    ('DP001', 'Boeing 737 MAX 8', 'DP', '2019-08-10'),
    ('DP002', 'Airbus A320neo', 'DP', '2021-01-07'),
    ('DP003', 'Boeing 737-800', 'DP', '2017-05-12'),

    ('B2001', 'Embraer E195', 'B2', '2018-09-30'),
    ('B2002', 'Boeing 737-500', 'B2', '2016-03-25'),
    ('B2003', 'CRJ-200', 'B2', '2019-11-14'),

    ('UT001', 'Boeing 737-700', 'UT', '2015-08-17'),
    ('UT002', 'Airbus A321', 'UT', '2017-12-02'),
    ('UT003', 'ATR 72', 'UT', '2020-06-28'),

    ('7R001', 'Sukhoi Superjet 100', '7R', '2018-02-11'),
    ('7R002', 'Bombardier CRJ-100', '7R', '2016-07-19'),
    ('7R003', 'Embraer E175', '7R', '2019-10-03'),

    ('GH001', 'Boeing 737-400', 'GH', '2017-04-05'),
    ('GH002', 'Airbus A320', 'GH', '2019-08-21'),
    ('GH003', 'Sukhoi Superjet 100', 'GH', '2016-12-14'),

    ('N4001', 'Boeing 737-700', 'N4', '2015-11-29'),
    ('N4002', 'Airbus A319', 'N4', '2018-03-06'),
    ('N4003', 'Bombardier CRJ-200', 'N4', '2017-07-18'),

    ('FV001', 'Airbus A320', 'FV', '2016-10-24'),
    ('FV002', 'Boeing 737-800', 'FV', '2019-05-12'),
    ('FV003', 'Sukhoi Superjet 100', 'FV', '2017-09-03');

INSERT INTO flights.Airports (Airport_id, Name, City) VALUES
    ('LHR', 'London Heathrow Airport', 'London'),
    ('JFK', 'John F. Kennedy International Airport', 'New York'),
    ('CDG', 'Charles de Gaulle Airport', 'Paris'),
    ('FRA', 'Frankfurt am Main Airport', 'Frankfurt'),
    ('AMS', 'Amsterdam Airport Schiphol', 'Amsterdam'),
    ('DXB', 'Dubai International Airport', 'Dubai'),
    ('HND', 'Tokyo Haneda Airport', 'Tokyo'),
    ('SIN', 'Singapore Changi Airport', 'Singapore'),
    ('SYD', 'Sydney Kingsford Smith Airport', 'Sydney'),
    ('PEK', 'Beijing Capital International Airport', 'Beijing'),
    ('ICN', 'Incheon International Airport', 'Seoul'),
    ('YYZ', 'Toronto Pearson International Airport', 'Toronto'),
    ('MUC', 'Munich Airport', 'Munich'),
    ('JNB', 'O. R. Tambo International Airport', 'Johannesburg'),
    ('IST', 'Istanbul Airport', 'Istanbul'),
    ('DEL', 'Indira Gandhi International Airport', 'Delhi'),
    ('MEX', 'Mexico City International Airport', 'Mexico City'),
    ('FCO', 'Leonardo da Vinci–Fiumicino Airport', 'Rome'),
    ('DME', 'Domodedovo International Airport', 'Moscow'),
    ('SVO', 'Sheremetyevo International Airport', 'Moscow'),
    ('LED', 'Pulkovo Airport', 'Saint Petersburg'),
    ('AER', 'Sochi International Airport', 'Sochi');


INSERT INTO flights.Flights (Number, Airline_id, Plane_id, Date_of_departure, Airport_of_departure, Date_of_arrival, Airport_of_arrival) VALUES
    (101, 'SU', 'SU1001', '2024-04-01 08:00:00', 'DME', '2024-04-01 10:30:00', 'LED'),
    (102, 'SU', 'SU1002', '2024-04-02 11:15:00', 'SVO', '2024-04-02 14:45:00', 'CDG'),

    (103, 'S7', 'S7001', '2024-04-03 09:30:00', 'LED', '2024-04-03 13:45:00', 'FRA'),
    (104, 'S7', 'S7002', '2024-04-04 14:00:00', 'CDG', '2024-04-04 18:30:00', 'DXB'),

    (105, 'U6', 'U6001', '2024-04-05 07:45:00', 'FRA', '2024-04-05 11:20:00', 'IST'),
    (106, 'U6', 'U6002', '2024-04-06 12:30:00', 'DXB', '2024-04-06 17:10:00', 'HND'),

    (107, 'DP', 'DP001', '2024-04-07 10:20:00', 'HND', '2024-04-07 16:00:00', 'SYD'),
    (108, 'DP', 'DP002', '2024-04-08 13:45:00', 'IST', '2024-04-08 19:30:00', 'JFK'),

    (109, 'B2', 'B2001', '2024-04-09 08:55:00', 'SYD', '2024-04-09 13:25:00', 'AMS'),
    (110, 'B2', 'B2002', '2024-04-10 11:10:00', 'JFK', '2024-04-10 17:00:00', 'DEL'),

    (111, 'UT', 'UT001', '2024-04-11 06:40:00', 'AMS', '2024-04-11 10:55:00', 'SYD'),
    (112, 'UT', 'UT002', '2024-04-12 09:20:00', 'DEL', '2024-04-12 14:45:00', 'CDG'),

    (113, '7R', '7R001', '2024-04-13 14:30:00', 'CDG', '2024-04-13 17:10:00', 'FCO'),
    (114, '7R', '7R002', '2024-04-14 08:20:00', 'FCO', '2024-04-14 10:45:00', 'MUC'),

    (115, 'GH', 'GH001', '2024-04-15 12:10:00', 'MUC', '2024-04-15 18:35:00', 'JFK'),
    (116, 'GH', 'GH002', '2024-04-16 15:30:00', 'JFK', '2024-04-16 22:20:00', 'SYD'),

    (117, 'N4', 'N4001', '2024-04-17 07:55:00', 'SYD', '2024-04-17 12:30:00', 'AMS'),
    (118, 'N4', 'N4002', '2024-04-18 10:20:00', 'AMS', '2024-04-18 14:40:00', 'CDG'),

    (119, 'FV', 'FV001', '2024-04-19 13:45:00', 'CDG', '2024-04-19 19:15:00', 'DEL'),
    (120, 'FV', 'FV002', '2024-04-20 16:20:00', 'DEL', '2024-04-20 22:10:00', 'IST'),

    (121, 'SU', 'SU1003', '2024-04-21 08:00:00', 'DME', '2024-04-21 10:30:00', 'LED'),
    (122, 'SU', 'SU1002', '2024-04-22 11:15:00', 'SVO', '2024-04-22 14:45:00', 'CDG'),

    (123, 'S7', 'S7003', '2024-04-23 09:30:00', 'LED', '2024-04-23 13:45:00', 'FRA'),
    (124, 'S7', 'S7002', '2024-04-24 14:00:00', 'CDG', '2024-04-24 18:30:00', 'DXB'),

    (125, 'U6', 'U6003', '2024-04-25 07:45:00', 'FRA', '2024-04-25 11:20:00', 'IST'),
    (126, 'U6', 'U6002', '2024-04-26 12:30:00', 'DXB', '2024-04-26 17:10:00', 'HND'),

    (127, 'DP', 'DP003', '2024-04-27 10:20:00', 'HND', '2024-04-27 16:00:00', 'SYD'),
    (128, 'DP', 'DP002', '2024-04-28 13:45:00', 'IST', '2024-04-28 19:30:00', 'JFK'),

    (129, 'B2', 'B2003', '2024-04-29 08:55:00', 'SYD', '2024-04-29 13:25:00', 'AMS'),
    (130, 'B2', 'B2002', '2024-04-30 11:10:00', 'JFK', '2024-04-30 17:00:00', 'DEL');

INSERT INTO flights.Passenger_Flight (Passenger_id, Number) VALUES
    (1, 101), (2, 101),
    (3, 102), (4, 102),
    (5, 103), (6, 103),
    (7, 104), (8, 104),
    (9, 105), (10, 105),
    (11, 106), (12, 106),
    (13, 107), (14, 107),
    (15, 108), (1, 108),
    (2, 109), (3, 109),
    (4, 110), (5, 110),
    (6, 111), (7, 111),
    (8, 112), (9, 112),
    (10, 113), (11, 113),
    (12, 114), (13, 114),
    (14, 115), (15, 115),
    (1, 116), (2, 116),
    (3, 117), (4, 117),
    (5, 118), (6, 118),
    (7, 119), (8, 119),
    (9, 120), (10, 120),
    (11, 121), (12, 121),
    (13, 122), (14, 122),
    (15, 123), (1, 123),
    (2, 124), (3, 124),
    (4, 125), (5, 125),
    (1, 126), (2, 126),
    (3, 127), (4, 127),
    (5, 128), (6, 128),
    (7, 129), (8, 129),
    (9, 130), (10, 130);

INSERT INTO flights.Flight_Date (Number, Old_date_of_departure, New_date_of_departure, Old_date_of_arrival, New_date_of_arrival) VALUES
    (101, '2024-04-01 08:00:00', '2024-04-01 10:00:00', '2024-04-01 10:30:00', '2024-04-01 12:30:00'),
    (102, '2024-04-02 11:15:00', '2024-04-02 12:15:00', '2024-04-02 14:45:00', '2024-04-02 15:45:00'),

    (103, '2024-04-03 09:30:00', '2024-04-03 12:30:00', '2024-04-03 13:45:00', '2024-04-03 16:45:00'),
    (104, '2024-04-04 14:00:00', '2024-04-04 15:00:00', '2024-04-04 18:30:00', '2024-04-04 19:30:00'),

    (105, '2024-04-05 07:45:00', '2024-04-05 08:45:00', '2024-04-05 11:20:00', '2024-04-05 12:20:00'),
    (106, '2024-04-06 12:30:00', '2024-04-06 14:30:00', '2024-04-06 17:10:00', '2024-04-06 19:10:00'),

    (107, '2024-04-07 10:20:00', '2024-04-07 13:20:00', '2024-04-07 16:00:00', '2024-04-07 19:00:00'),
    (108, '2024-04-08 13:45:00', '2024-04-08 16:45:00', '2024-04-08 19:30:00', '2024-04-08 22:30:00'),

    (109, '2024-04-09 08:55:00', '2024-04-09 11:55:00', '2024-04-09 13:25:00', '2024-04-09 16:25:00'),
    (110, '2024-04-10 11:10:00', '2024-04-10 13:10:00', '2024-04-10 17:00:00', '2024-04-10 19:00:00'),

    (111, '2024-04-11 06:40:00', '2024-04-11 08:40:00', '2024-04-11 10:55:00', '2024-04-11 12:55:00'),
    (112, '2024-04-12 09:20:00', '2024-04-12 11:20:00', '2024-04-12 14:45:00', '2024-04-12 16:45:00'),

    (113, '2024-04-13 14:30:00', '2024-04-13 17:30:00', '2024-04-13 17:10:00', '2024-04-13 20:10:00'),
    (114, '2024-04-14 08:20:00', '2024-04-14 10:20:00', '2024-04-14 10:45:00', '2024-04-14 12:45:00'),

    (115, '2024-04-15 12:10:00', '2024-04-15 15:10:00', '2024-04-15 18:35:00', '2024-04-15 21:35:00'),
    (116, '2024-04-16 15:30:00', '2024-04-16 18:30:00', '2024-04-16 22:20:00', '2024-04-17 01:20:00'),

    (117, '2024-04-17 07:55:00', '2024-04-17 09:55:00', '2024-04-17 12:30:00', '2024-04-17 15:30:00'),
    (118, '2024-04-18 10:20:00', '2024-04-18 11:20:00', '2024-04-18 14:40:00', '2024-04-18 15:40:00'),

    (119, '2024-04-19 13:45:00', '2024-04-19 16:45:00', '2024-04-19 19:15:00', '2024-04-19 22:15:00'),
    (120, '2024-04-20 16:20:00', '2024-04-20 17:20:00', '2024-04-20 22:10:00', '2024-04-20 23:10:00'),

    (121, '2024-04-21 08:00:00', '2024-04-21 09:00:00', '2024-04-21 10:30:00', '2024-04-21 11:30:00'),
    (122, '2024-04-22 11:15:00', '2024-04-22 13:15:00', '2024-04-22 14:45:00', '2024-04-22 16:45:00'),

    (123, '2024-04-23 09:30:00', '2024-04-23 11:30:00', '2024-04-23 13:45:00', '2024-04-23 15:45:00'),
    (124, '2024-04-24 14:00:00', '2024-04-24 16:00:00', '2024-04-24 18:30:00', '2024-04-24 20:30:00'),

    (125, '2024-04-25 07:45:00', '2024-04-25 10:45:00', '2024-04-25 11:20:00', '2024-04-25 14:20:00'),
    (126, '2024-04-26 12:30:00', '2024-04-26 15:30:00', '2024-04-26 17:10:00', '2024-04-26 20:10:00'),

    (127, '2024-04-27 10:20:00', '2024-04-27 12:20:00', '2024-04-27 16:00:00', '2024-04-27 18:00:00'),
    (128, '2024-04-28 13:45:00', '2024-04-28 15:45:00', '2024-04-28 19:30:00', '2024-04-28 21:30:00'),

    (129, '2024-04-29 08:55:00', '2024-04-29 09:55:00', '2024-04-29 13:25:00', '2024-04-29 14:25:00'),
    (130, '2024-04-30 11:10:00', '2024-04-30 12:10:00', '2024-04-30 17:00:00', '2024-04-30 18:00:00');

SELECT * from flights.Passengers;
SELECT * from flights.Airlines;
SELECT * FROM flights.Planes;
SELECT * FROM flights.Airports;
SELECT * FROM flights.Flights;
SELECT * FROM flights.Passenger_Flight;
SELECT * FROM flights.Flight_Date;