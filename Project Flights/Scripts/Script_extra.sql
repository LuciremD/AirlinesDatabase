---- VIEW ----
-- Russian airports --
CREATE OR REPLACE VIEW flights.Russian_Airports AS
SELECT *
FROM flights.Airports
WHERE City = 'Moscow' OR City = 'Saint Petersburg' OR City = 'Sochi';

SELECT *
FROM flights.Russian_Airports;

-- Old planes --
CREATE OR REPLACE  VIEW flights.Old_Planes AS
SELECT *
FROM flights.Planes
WHERE Date_of_creation <= '2018-06-01';

SELECT *
FROM flights.Old_Planes;

-- Airlines that ouw old planes --
CREATE OR REPLACE  VIEW flights.Old_Planes_With_Airlines AS
SELECT p.Plane_id, p.Model, p.Airline_id, p.Date_of_creation, a.Name AS Airline_name
FROM flights.Old_Planes p
JOIN flights.Airlines a ON p.Airline_id = a.Airline_id;

SELECT *
FROM flights.Old_Planes_With_Airlines;

-- INDEXES --
-- index for airlines --
CREATE INDEX idx_airline_id ON flights.Airlines (Airline_id);

-- index for plains --
CREATE INDEX idx_plane_id ON flights.Planes (Plane_id);

-- index for airports --
CREATE INDEX idx_airport_id ON flights.Airports (Airport_id);

-- index for flights --
CREATE INDEX idx_flight_number ON flights.Flights (Number);

-- FUNCTIONS --
-- Information about flight via its number --
CREATE OR REPLACE FUNCTION get_flight_info_by_number(flight_number_ INTEGER)
RETURNS TABLE (
    flight_number INTEGER,
    airline_name VARCHAR(100),
    plane_model VARCHAR(100),
    departure_date DATE,
    departure_airport VARCHAR(100),
    arrival_date DATE,
    arrival_airport VARCHAR(100)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        f.Number,
        a.Name AS Airline_Name,
        p.Model AS Plane_Model,
        f.Date_of_departure,
        d.Name AS Departure_Airport,
        f.Date_of_arrival,
        port.Name AS Arrival_Airport
    FROM
        flights.Flights f
    JOIN
        flights.Airlines a ON f.Airline_id = a.Airline_id
    JOIN
        flights.Planes p ON f.Plane_id = p.Plane_id
    JOIN
        flights.Airports d ON f.Airport_of_departure = d.Airport_id
    JOIN
        flights.Airports port ON f.Airport_of_arrival = port.Airport_id
    WHERE
        f.Number = flight_number_;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_flight_info_by_number(101);

-- Information about passenger via its id --
CREATE OR REPLACE FUNCTION get_passenger_info_by_id(passenger_id_ INTEGER)
RETURNS TABLE (
    passenger_id INTEGER,
    name VARCHAR(100),
    surname VARCHAR(100),
    fathers_name VARCHAR(100),
    flight_number INTEGER,
    departure_date DATE,
    arrival_date DATE,
    departure_airport VARCHAR(100),
    arrival_airport VARCHAR(100)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        p.Passenger_id,
        p.Name,
        p.Surname,
        p.Fathers_name,
        f.Number AS Flight_Number,
        f.Date_of_departure,
        f.Date_of_arrival,
        da.Name AS Departure_Airport,
        aa.Name AS Arrival_Airport
    FROM
        flights.Passengers p
    JOIN
        flights.Passenger_Flight pf ON p.Passenger_id = pf.Passenger_id
    JOIN
        flights.Flights f ON pf.Number = f.Number
    JOIN
        flights.Airports da ON f.Airport_of_departure = da.Airport_id
    JOIN
        flights.Airports aa ON f.Airport_of_arrival = aa.Airport_id
    WHERE
        p.Passenger_id = passenger_id_;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_passenger_info_by_id(1);

-- flights between two dates --
CREATE OR REPLACE FUNCTION get_flights_between_dates(start_date DATE, end_date DATE)
RETURNS TABLE (
    flight_number INTEGER,
    airline_name VARCHAR(100),
    plane_model VARCHAR(100),
    departure_date DATE,
    departure_airport VARCHAR(100),
    arrival_date DATE,
    arrival_airport VARCHAR(100)
)
AS $$
BEGIN
    RETURN QUERY
    SELECT
        f.Number,
        a.Name AS Airline_Name,
        p.Model AS Plane_Model,
        f.Date_of_departure,
        d.Name AS Departure_Airport,
        f.Date_of_arrival,
        port.Name AS Arrival_Airport
    FROM
        flights.Flights f
    JOIN
        flights.Airlines a ON f.Airline_id = a.Airline_id
    JOIN
        flights.Planes p ON f.Plane_id = p.Plane_id
    JOIN
        flights.Airports d ON f.Airport_of_departure = d.Airport_id
    JOIN
        flights.Airports port ON f.Airport_of_arrival = port.Airport_id
    WHERE
        f.Date_of_departure BETWEEN start_date AND end_date;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_flights_between_dates('2024-04-01', '2024-04-10');