-- Обновляет таблицу с всей инфой о рейсах после
-- после добавления изменений в версионную таблицу
CREATE OR REPLACE FUNCTION update_flight_date()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE flights.Flights
    SET Date_of_departure = NEW.New_date_of_departure,
        Date_of_arrival = NEW.New_date_of_arrival
    WHERE Number = NEW.Number;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_flight_date_trigger
AFTER UPDATE ON flights.Flight_Date
FOR EACH ROW
EXECUTE FUNCTION update_flight_date();

-- Проверка наличия рейса в таблице с изменениями
-- при удалении из таблицы со всеми данными о рейсе
CREATE OR REPLACE FUNCTION delete_flight_date_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM flights.Flight_Date WHERE Number = OLD.Number) THEN
        RAISE EXCEPTION 'Flight % not found in Flight_Date table', OLD.Number;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_flight_date_trigger
BEFORE DELETE ON flights.Flights
FOR EACH ROW
EXECUTE FUNCTION delete_flight_date_trigger();

-- Проверка на наличие самолета с таким же номером
-- при добавлении нового самолета
CREATE OR REPLACE FUNCTION check_unique_plane_id_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM flights.Planes WHERE Plane_id = NEW.Plane_id) THEN
        RAISE EXCEPTION 'Plane with id % already exists', NEW.Plane_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_unique_plane_id_trigger
BEFORE INSERT ON flights.Planes
FOR EACH ROW
EXECUTE FUNCTION check_unique_plane_id_trigger();

