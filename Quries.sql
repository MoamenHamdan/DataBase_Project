-- 1. Retrieve all passengers who booked tickets for a flight departing from a specific city.
SELECT p.*
FROM passenger p
JOIN flight f ON p.flight_id = f.flight_id
JOIN airport a ON f.departure_airportcode = a.airport_code
JOIN city c ON a.city_name = c.city_name
WHERE c.city_name = 'London';


-- 2. Display all flights with available seats less than a specified number.
SELECT *
FROM flight
WHERE seats_available < 130;

-- 3. Find all flights arriving at a specific destination airport.
SELECT *
FROM flight
WHERE destination = 'LHR';

UPDATE flight
SET flight.airline_id = airplane.airline_id
FROM flight
JOIN airplane ON flight.airplane_id = airplane.airplane_id
JOIN airline ON airplane.airline_id = airline.airline_id;


-- 4. List all flights departing after a certain date and time.
SELECT *
FROM flight
WHERE departure_time > '2024-05-01';
select *from flight;
-- 5. Retrieve all flights operated by a specific airline.
SELECT *
FROM flight
WHERE airline_id = (SELECT airline_id FROM airline WHERE airline_name = 'Air France');


select * from city ;

-- 7. Find all flights departing from airports in a specific state.
SELECT *
FROM flight
JOIN airport a ON flight.departure_airportcode = a.airport_code
JOIN city c ON a.city_name = c.city_name
WHERE c.state = 'New York';

select * from flight;

-- 8. List all passengers who booked tickets for a flight with a specific flight type.
SELECT p.*
FROM passenger p
JOIN flight f ON p.flight_id = f.flight_id
WHERE f.flight_type = 'public';

-- 9. Retrieve all flights with a specific status (e.g., 'delayed', 'canceled').
SELECT *
FROM flight
WHERE status = 'delayed';
select * from flight;

-- 10. Display all flights with departure times between two specified airports.
SELECT flight_id , status , gate_number,airline_id
FROM flight
WHERE destination BETWEEN 'JFK' AND 'LHR';

select * from city ;

-- 11. Find all flights departing from cities in a specific country.
SELECT flight_id , status , gate_number,airline_id , origin
FROM flight f
JOIN airport a ON f.departure_airportcode = a.airport_code
JOIN city c ON a.city_name = c.city_name
WHERE c.country = 'Japan';


select * from gate;


-- 15. Find all flights departing from a specific gate.
SELECT *
FROM flight
WHERE gate_number = '01A';

select * from flight;


-- 16. List all passengers who booked tickets for a flight with a specific departure airport.
SELECT p.*
FROM passenger p
JOIN flight f ON p.flight_id = f.flight_id
JOIN airport a ON f.departure_airportcode = a.airport_code
WHERE a.airport_name = 'Haneda Airport';

-- 17. Retrieve all flights with a layover time longer than a specified duration.
SELECT *
FROM flight
WHERE layover_time > '2024-05-01';

-- 18. Display all flights with arrival times between two specified times.
SELECT *
FROM flight
WHERE arrival_time BETWEEN '2024-02-01' AND '2024-05-01';


select * from airport;
-- 20. List all passengers who booked tickets for a flight operated by a specific airline.
SELECT p.*
FROM passenger p
JOIN flight f ON p.flight_id = f.flight_id
JOIN airline a ON f.airline_id = a.airline_id
WHERE a.airline_name = 'Qantas';

-- 21. Retrieve all flights departing from airports with a specific location.
SELECT flight_id ,location , airline_id , gate_number , status 
FROM flight
JOIN airport ON flight.departure_airportcode = airport.airport_code
WHERE airport.location = 'London';

-- 22. Display all flights with a specific number of stops.
SELECT flight_id, airplane_id , airline_id
FROM flight
WHERE number_of_stops = 1;

-- 23. Find all flights departing from airports with a specific weather condition.
SELECT flight_id , status , gate_number , atmospheric_pressure , temperature
FROM flight f
JOIN weather w ON f.weather_time = w.weather_time
WHERE w.atmospheric_pressure < 1012;


-- 31. Find all flights departing from airports with a specific temperature.
SELECT  flight_id , status , gate_number , temperature
FROM flight f
JOIN weather w ON f.weather_time = w.weather_time
WHERE w.temperature <22;

-- 32. List all passengers who booked tickets for a flight with a specific flight number.
SELECT *
FROM passenger p
JOIN flight f ON p.flight_id = f.flight_id
WHERE f.flight_id = 2;

-- 33. Retrieve all flights with a specific departure gate status.
SELECT flight_id , flight_type
FROM flight
JOIN gate ON flight.gate_number = gate.gate_number
WHERE gate.gate_status = 'open';



select * from flight;
-- UPDATE queries:
-- 41. Update the status of a specific flight to 'canceled'.
UPDATE flight
SET status = 'canceled'
WHERE flight_id = 2;

-- 42. Update the number of available seats for a specific flight.
UPDATE flight
SET seats_available = 50
WHERE flight_id = 2;

-- 43. Update the departure time of a specific flight.
UPDATE flight
SET departure_time = '02-04-2024'
WHERE flight_id = 4;

-- 44. Update the arrival time of a specific flight.
UPDATE flight
SET arrival_time = '11-12-2024'
WHERE flight_id = 5;

-- 45. Update the gate number for a specific flight.
UPDATE flight
SET gate_number = '01A'
WHERE flight_id = 5;

-- 46. Update the maintenance status of a specific airplane.
UPDATE airplane
SET maitenance_status = 'up-to-date'
WHERE airplane_id = 3;

-- 47. Update the price of a specific ticket.
UPDATE ticket
SET surcharge = '200'
WHERE ticket_number = 102 AND flight_number = 2;


-- 48. Update the capacity of a specific class.
UPDATE class
SET Capacity = '30'
WHERE class_id = 3;


-- DELETE queries:
-- 51. Delete a specific flight from the database.
DELETE FROM flight
WHERE flight_id = 3;

-- 52. Delete a specific passenger from the database.
DELETE FROM passenger
WHERE passenger_id = 202302491;

-- 53. Delete a specific ticket from the database.
DELETE FROM ticket
WHERE ticket_number = 100 AND flight_number = 3;

select * from airplane;
-- 54. Delete a specific airplane from the database.
DELETE FROM airplane
WHERE airplane_id = 1005;

-- 55. Delete a specific airport from the database.
DELETE FROM airport
WHERE airport_code = 'ASR';

-- 56. Delete a specific class from the database.
DELETE FROM class
WHERE class_id = 103;

-- 57. Delete a specific gate from the database.
DELETE FROM gate
WHERE gate_number = '01A';


-- 58. Delete a specific employee from the database.
DELETE FROM employee

WHERE ssn = 123456789;


-- 59. Delete a specific lounge from the database.
DELETE FROM passenger_lounge
WHERE lounge_id = 8;

-- 60. Delete a specific duty-free product from the database.
DELETE FROM dutyfree_product
WHERE product_id = 4;

-- 61. Retrieve flights with their corresponding airline names, departure city, and destination city
SELECT f.flight_id, f.departure_time, f.arrival_time, f.flight_type, al.airline_name, a1.city_name AS departure_city, a2.city_name AS destination_city
FROM flight f
JOIN airplane a ON f.airplane_id = a.airplane_id
JOIN airline al ON a.airline_id = al.airline_id
JOIN airport ap1 ON f.departure_airportcode = ap1.airport_code
JOIN city a1 ON ap1.city_name = a1.city_name
JOIN airport ap2 ON f.arrival_airportcode = ap2.airport_code
JOIN city a2 ON ap2.city_name = a2.city_name
WHERE f.status = 'on time' AND a1.country = 'USA' AND a2.country != 'USA';

--62 Calculate the Total Capacity of Hangars
SELECT SUM(hangar_capacity) AS total_capacity
FROM hangar;
--63 Find the Airlines with the Most Owned Airplanes
SELECT TOP 3 airline_name, number_of_airplanes_owned
FROM airline
ORDER BY number_of_airplanes_owned DESC;

--64 List the Airports with Available Gates
SELECT airport_name, COUNT(gate_number) AS available_gates
FROM airport a
LEFT JOIN gate g ON a.airport_code = g.airport_code
WHERE g.gate_status = 'Open' 
GROUP BY airport_name;

--65 Retrieve the Top 10 Best-Selling Duty-Free Products
SELECT TOP 10 name, SUM(price) AS total_sales
FROM purchases p
JOIN dutyfree_product dp ON p.product_id = dp.product_id
GROUP BY name
ORDER BY total_sales DESC;

select * from ticket;

--66 Find the Top 3 Airlines with the Highest Revenue
SELECT TOP 3 a.airline_name, SUM(p.price) AS total_revenue
FROM ticket t
JOIN payment p ON t.ticket_number = p.ticket_number AND t.flight_number = p.flight_number
JOIN flight f ON t.flight_number = f.flight_id  
JOIN airline a ON f.airline_id = a.airline_id  
GROUP BY a.airline_name
ORDER BY total_revenue DESC;

--67 Calculate the Average Age of Passengers on Each Flight
SELECT flight_number, AVG(age) AS avg_passenger_age
FROM passenger
GROUP BY flight_number;

--68 Identify the Airports with Overbooked Flights
SELECT airport_name, COUNT(*) AS overbooked_flights
FROM flight f
JOIN airport a ON f.departure_airportcode = a.airport_code
WHERE f.seats_available < 0
GROUP BY airport_name;

-- 69 Find the Most Commonly Seized Items by Security Staff
SELECT seized_item_type, COUNT(*) AS total_seizures
FROM security_point sp
JOIN security_staff ss ON sp.seized_item_number = ss.security_seized_item_number
GROUP BY seized_item_type
ORDER BY total_seizures DESC;
-- 70 DERIVED ATTRIBUTE that calculate the time of the flight
SELECT flight_id, 
       departure_time, 
       arrival_time, 
       DATEDIFF(minute, departure_time, arrival_time) AS flight_duration_minutes
FROM flight;


--71 Retrieve maximum, average, and minimum number of airplanes owned by an airline, along with the total number of airlines
SELECT 
    (SELECT MAX(number_of_airplanes_owned) FROM airline) AS max_planes_owned,
    (SELECT AVG(number_of_airplanes_owned) FROM airline) AS avg_planes_owned,
    (SELECT MIN(number_of_airplanes_owned) FROM airline) AS min_planes_owned,
    (SELECT COUNT(*) FROM airline) AS total_airlines;
-- 72 Retrieve employee details along with their supervisor details and calculate the number of employees each supervisor supervises.
SELECT 
    e1.ssn AS employee_ssn,
    e1.first_name AS employee_first_name,
    e1.last_name AS employee_last_name,
    e1.job_type AS employee_job_type,
    e2.ssn AS supervisor_ssn,
    e2.first_name AS supervisor_first_name,
    e2.last_name AS supervisor_last_name,
    e2.job_type AS supervisor_job_type,
    COUNT(e1.ssn) AS employees_supervised
FROM 
    employee e1
LEFT JOIN 
    supervisor s ON e1.ssn = s.ssn_supervisee
LEFT JOIN 
    employee e2 ON s.ssn_supervisor = e2.ssn
GROUP BY 
    e1.ssn, e1.first_name, e1.last_name, e1.job_type, e2.ssn, e2.first_name, e2.last_name, e2.job_type
ORDER BY 
    employees_supervised DESC;
--73  Retrieve the SSN, first name, last name, job type, and salary of all employees who earn more than the average salary of all employees, ordered by salary in descending order
SELECT SSN, first_name, last_name, job_type, salary
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee)
ORDER BY salary DESC;

DELETE FROM flight_attendant
WHERE ssn IN (
    SELECT ssn 
    FROM employee 
    WHERE job_type = 'F' 
    AND ssn NOT IN (
        SELECT ssn 
        FROM assigned
    )
);
--75 Average Salary by Job Type
SELECT 
    job_type, 
    AVG(salary) AS avg_salary
FROM 
    employee
GROUP BY 
    job_type;

	--76 Count the number of lost luggage items per passenger.
	SELECT 
    passenger_id, 
    COUNT(*) AS lost_luggage_count
FROM 
    lost_and_found
GROUP BY 
    passenger_id;


--77 Calculate the average weight of baggage for each flight
SELECT 
    flight_number, 
    AVG(weight) AS avg_baggage_weight
FROM 
    baggage
GROUP BY 
    flight_number;








