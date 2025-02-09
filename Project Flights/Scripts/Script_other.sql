-- 1) Идентефикаторы аэропортов в городах, начинающихс я с 'S'
SELECT Airport_id
FROM flights.airports
WHERE City LIKE 'S%';

-- 2) Общее количесвто самолетов каждого типа
SELECT Model, COUNT(*) AS Total_Aircraft
FROM flights.Planes
GROUP BY Model;

-- 3) Идентефикаторы и имена пассажиров, у которых инициалы *АМ
SELECT Passenger_id, Name
FROM flights.passengers
WHERE Name like 'A%' and Fathers_name like 'M%';

-- 4) Список всех авиакомпаний и общего количества рейсов, проведенных каждой из них
SELECT a.Name AS Airline, COUNT(f.Number) AS Total_Flights
FROM flights.Airlines a
LEFT JOIN flights.Flights f ON a.Airline_id = f.Airline_id
GROUP BY a.Name;

-- 5) Список пассажиров, совершивых не 4 полетов в месяц, и количество их полетов
SELECT p.Passenger_id, COUNT(pf.Number) AS Total_Flights
FROM flights.Passenger_Flight pf
JOIN flights.Passengers p ON pf.Passenger_id = p.Passenger_id
GROUP BY p.Passenger_id
HAVING COUNT(pf.Number) != 4
ORDER BY p.Passenger_id;

-- 6) Список рейсов, на которых есть хотя бы один пассажир с именем на А, и количество таких пассажиров
SELECT f.Number,
       (SELECT COUNT(*)
        FROM flights.Passenger_Flight pf
        JOIN flights.Passengers p ON pf.Passenger_id = p.Passenger_id
        WHERE pf.Number = f.Number AND p.Name LIKE 'A%') AS amount_of_A_passengers
FROM flights.Flights f
JOIN flights.Passenger_Flight pf ON f.Number = pf.Number
JOIN flights.Passengers p ON pf.Passenger_id = p.Passenger_id
WHERE p.Name LIKE 'A%';

-- 7) Рейсы, напрявляющиеся в Сидней и авиакомпании этих рейсов
SELECT f.Number, f.Airline_id
FROM flights.Flights f
JOIN flights.Airports a_dep ON f.Airport_of_departure = a_dep.Airport_id
WHERE a_dep.Airport_id = 'SYD'
ORDER BY f.Date_of_departure DESC;

-- 8) Количество пассажиров для всех авиакомпаний за апредь 2024
SELECT a.Name AS Airline_Name, COUNT(pf.Passenger_id) AS Total_Passengers
FROM flights.Passenger_Flight pf
JOIN flights.Flights f ON pf.Number = f.Number
JOIN flights.Airlines a ON f.Airline_id = a.Airline_id
WHERE EXTRACT(YEAR FROM f.Date_of_departure) = 2024
  AND EXTRACT(MONTH FROM f.Date_of_departure) = 4
GROUP BY f.Airline_id, a.Name;

-- 9) Среднее число пассажиров на рейсах авиакомпании
SELECT f.Airline_id, AVG(passenger_count) AS Avg_Passengers_Per_Flight
FROM (
    SELECT pf.Number, COUNT(pf.Passenger_id) AS passenger_count
    FROM flights.Passenger_Flight pf
    GROUP BY pf.Number
) AS flight_passenger_count
JOIN flights.Flights f ON flight_passenger_count.Number = f.Number
GROUP BY f.Airline_id;

-- 10) Три самых популярных аэропорта отправления
SELECT Airport_of_departure, COUNT(*) AS Departure_Count
FROM flights.Flights
GROUP BY Airport_of_departure
ORDER BY Departure_Count DESC
LIMIT 3;