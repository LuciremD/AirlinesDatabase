# Таблицы для проекта по БД

## Таблица Passengers

| Название      | Описание                | Тип данных   | Ограничение |  
|---------------|-------------------------|--------------| ----------  |
| Passenger_id  | Идентефикатор пассажира | INTEGER      | PRIMARY KEY |
| Name          | Имя пассажира           | VARCHAR(100) |             |
| Surname       | Фамилия пассажира       | VARCHAR(100) |             |
| Father_name   | Отчество пассажира      | VARCHAR(100) |             |

## Таблица связи Passenger - Flight

| Название      | Описание                | Тип данных | Ограничение |  
|---------------|-------------------------|------------| ----------  |
| Passenger_id  | Идентефикатор пассажира | INTEGER    | FOREIGN KEY |
| Number        | Номер рейса             | INTEGER    | FOREIGN KEY |

### Замечание: Пара (Passenger_id, Number) уникальна

## Таблица Planes

| Название         | Описание                   | Тип данных   | Ограничение |  
|------------------|----------------------------|--------------| ----------  |
| Plane_id         | Идентефикатор самолета     | VARCHAR(100) | PRIMARY KEY |
| Model            | Модель самолета            | VARCHAR(100) |             |
| Airlane_id       | Идентефикатор авиакомпании | VARCHAR(100) | FOREIGN KEY |
| Date_of_creation | Дата выпуска               | Date         |             |

## Таблица Airlines

| Название   | Описание                   | Тип данных   | Ограничение |  
|------------|----------------------------|--------------| ----------  |
| Airlane_id | Идентефикатор авиакомпании | VARCHAR(100) | PRIMARY KEY |
| Name       | Название авиакомпании      | VARCHAR(100) |             |

## Таблица Airports

| Название   | Описание                            | Тип данных   | Ограничение |  
|------------|-------------------------------------|--------------| ----------  |
| Airport_id | Идентефикатор аэропорта             | VARCHAR(100) | PRIMARY KEY |
| Name       | Название аэропорта                  | VARCHAR(100) |             |
| City       | Город, в котором находится аэропорт | VARCHAR(100) |             |

## Таблица Flights

| Название             | Описание                   | Тип данных    | Ограничение |  
|----------------------|----------------------------|---------------| ----------  |
| Number               | Номер рейса                | INTEGER       | PRIMARY KEY |
| Airline_id           | Идентефикатор авиакомпании | VARCHAR(100)  | FOREIGN KEY |
| Plane_id             | Номер самолета             | VARCHAR(100)  | FOREIGN KEY |
| Date_of_departure    | Дата вылета                | Date and time |             |
| Airport_of_departure | Аэропорт вылета            | VARCHAR(100)  | FOREIGN KEY |
| Date_of_arrival      | Дата прилета               | Date and time |             |
| Airport_of_arrival   | Аэропорт прилета           | VARCHAR(100)  | FOREIGN KEY |

## Версионная таблица Flights - Date

| Название              | Описание         | Тип данных    | Ограничение |  
|-----------------------|------------------|---------------| ----------  |
| Number                | Номер рейса      | INTEGER       | FOREIGN KEY |
| Old_date_of_departure | Дата вылета      | Date and time |             |
| New_date_of_departure | Дата вылета      | Date and time |             |
| Old_date_of_arrival   | Дата вылета      | Date and time |             |
| New_date_of_arrival   | Дата вылета      | Date and time |             |
