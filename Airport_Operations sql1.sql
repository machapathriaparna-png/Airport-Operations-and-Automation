-- =========================================
-- PROJECT: AIRPORT OPERATIONS & AUTOMATION
-- =========================================

-- SECTION 1: DATABASE CREATION

CREATE DATABASE Airport_Operations;

-- Select Database

USE Airport_Operations;

-- Verify Database

SHOW DATABASES;


-- =========================================
-- SECTION 2: AIRPORTS TABLE CREATION
-- =========================================

CREATE TABLE Airports (
    airport_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    country VARCHAR(50),
    airport_code VARCHAR(10) UNIQUE
);

-- Verify Table Structure
DESC Airports;

-- =========================================
-- SECTION 3: INSERT AIRPORT DATA
-- =========================================
INSERT INTO Airports
(airport_name, city, country, airport_code)
VALUES
('Rajiv Gandhi International Airport', 'Hyderabad', 'India', 'HYD'),
('Indira Gandhi International Airport', 'Delhi', 'India', 'DEL'),
('Chhatrapati Shivaji Maharaj International Airport', 'Mumbai', 'India', 'BOM'),
('Kempegowda International Airport', 'Bangalore', 'India', 'BLR'),
('Chennai International Airport', 'Chennai', 'India', 'MAA');

-- Verify Inserted Records
SELECT * FROM Airports;

-- =========================================
-- SECTION 4: FLIGHTS TABLE CREATION
-- =========================================

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(20) NOT NULL,
    airline VARCHAR(50) NOT NULL,
    departure_airport_id INT,
    arrival_airport_id INT,
    departure_time DATETIME,
    arrival_time DATETIME,
    flight_status VARCHAR(20) DEFAULT 'Scheduled',

    FOREIGN KEY (departure_airport_id)
    REFERENCES Airports(airport_id),

    FOREIGN KEY (arrival_airport_id)
    REFERENCES Airports(airport_id)
);

-- Verify Table Structure
DESC Flights;


-- =========================================
-- SECTION 5: INSERT FLIGHT DATA
-- =========================================
INSERT INTO Flights
(flight_number, airline, departure_airport_id,
 arrival_airport_id, departure_time, arrival_time, flight_status)
VALUES
('AI101', 'Air India', 1, 2, '2026-12-01 08:00:00', '2026-12-01 10:30:00', 'Scheduled'),
('6E202', 'IndiGo', 2, 3, '2026-12-01 09:00:00', '2026-12-01 11:00:00', 'Scheduled'),
('SG303', 'SpiceJet', 3, 4, '2026-12-01 12:00:00', '2026-12-01 13:30:00', 'Delayed'),
('AI404', 'Air India', 4, 5, '2026-12-01 14:00:00', '2026-12-01 15:30:00', 'Scheduled'),
('6E505', 'IndiGo', 5, 1, '2026-12-01 17:00:00', '2026-12-01 18:30:00', 'Cancelled');

-- Verify Inserted Records
SELECT * FROM Flights;

-- =========================================
-- SECTION 6: PASSENGERS TABLE CREATION
-- =========================================
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    gender VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    nationality VARCHAR(50)
);

-- Verify Table Structure
DESC Passengers;

-- =========================================
-- SECTION 7: INSERT PASSENGER DATA
-- =========================================
INSERT INTO Passengers
(first_name, last_name, age, gender, email, phone, nationality)
VALUES
('Shyam', 'Kumar', 25, 'Male', 'shyam@gmail.com', '9876543210', 'Indian'),
('Aparna', 'Reddy', 23, 'Female', 'aparna@gmail.com', '9876543211', 'Indian'),
('Rahul', 'Sharma', 30, 'Male', 'rahul@gmail.com', '9876543212', 'Indian'),
('Priya', 'Verma', 27, 'Female', 'priya@gmail.com', '9876543213', 'Indian'),
('Arjun', 'Rao', 35, 'Male', 'arjun@gmail.com', '9876543214', 'Indian'),
('Sneha', 'Patel', 22, 'Female', 'sneha@gmail.com', '9876543215', 'Indian'),
('Kiran', 'Reddy', 29, 'Male', 'kiran@gmail.com', '9876543216', 'Indian'),
('Divya', 'Nair', 26, 'Female', 'divya@gmail.com', '9876543217', 'Indian');

-- Verify Passenger Records
SELECT * FROM Passengers;


-- =========================================
-- SECTION 8: BOOKINGS TABLE CREATION
-- =========================================
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    flight_id INT NOT NULL,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    ticket_price DECIMAL(10,2) NOT NULL,
    booking_status VARCHAR(20) DEFAULT 'Confirmed',

    FOREIGN KEY (passenger_id)
    REFERENCES Passengers(passenger_id),

    FOREIGN KEY (flight_id)
    REFERENCES Flights(flight_id)
);

-- Verify Table Structure
DESC Bookings;


-- =========================================
-- SECTION 9: INSERT BOOKING DATA
-- =========================================
INSERT INTO Bookings
(passenger_id, flight_id, booking_date, ticket_price, booking_status)
VALUES
(1, 1, '2026-11-20 10:00:00', 5500.00, 'Confirmed'),
(2, 1, '2026-11-20 11:30:00', 5500.00, 'Confirmed'),
(3, 2, '2026-11-21 09:00:00', 4200.00, 'Confirmed'),
(4, 2, '2026-11-21 10:30:00', 4200.00, 'Cancelled'),
(5, 3, '2026-11-21 12:00:00', 6800.00, 'Confirmed'),
(6, 3, '2026-11-22 14:00:00', 6800.00, 'Confirmed'),
(7, 4, '2026-11-22 15:00:00', 3900.00, 'Confirmed'),
(8, 5, '2026-11-23 16:00:00', 4500.00, 'Cancelled');

-- Verify Booking Records
SELECT * FROM Bookings;


-- =========================================
-- SECTION 10: BAGGAGE TABLE CREATION
-- =========================================
CREATE TABLE Baggage (
    baggage_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    booking_id INT NOT NULL,
    baggage_tag VARCHAR(30) UNIQUE,
    baggage_weight DECIMAL(5,2),
    baggage_status VARCHAR(30) DEFAULT 'Checked-In',

    FOREIGN KEY (passenger_id)
    REFERENCES Passengers(passenger_id),

    FOREIGN KEY (booking_id)
    REFERENCES Bookings(booking_id)
);

-- Verify Table Structure
DESC Baggage;


-- =========================================
-- SECTION 11: INSERT BAGGAGE DATA
-- =========================================
INSERT INTO Baggage
(passenger_id, booking_id, baggage_tag, baggage_weight, baggage_status)
VALUES
(1, 1, 'HYD001', 18.50, 'Checked-In'),
(2, 2, 'HYD002', 22.00, 'Loaded'),
(3, 3, 'DEL003', 15.75, 'Checked-In'),
(4, 4, 'DEL004', 20.00, 'Cancelled'),
(5, 5, 'BOM005', 25.50, 'Loaded'),
(6, 6, 'BOM006', 19.00, 'Checked-In'),
(7, 7, 'BLR007', 17.25, 'Loaded'),
(8, 8, 'MAA008', 21.00, 'Cancelled');

-- Verify Baggage Records
SELECT * FROM Baggage;


-- =========================================
-- SECTION 12: FLIGHT LOGS TABLE CREATION
-- =========================================
CREATE TABLE Flight_Logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT NOT NULL,
    previous_status VARCHAR(20),
    new_status VARCHAR(20) NOT NULL,
    change_reason VARCHAR(100),
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (flight_id)
    REFERENCES Flights(flight_id)
);

-- Verify Table Structure
DESC Flight_Logs;


-- =========================================
-- SECTION 13: INSERT FLIGHT LOGS DATA
-- =========================================
INSERT INTO Flight_Logs
(flight_id, previous_status, new_status, change_reason)
VALUES
(1, 'Scheduled', 'Delayed', 'Weather conditions'),
(2, 'Scheduled', 'Delayed', 'Technical issue'),
(3, 'Scheduled', 'Delayed', 'Air traffic congestion'),
(4, 'Scheduled', 'Cancelled', 'Operational issue'),
(5, 'Scheduled', 'Cancelled', 'Weather conditions');

-- Verify Flight Logs
SELECT * FROM Flight_Logs;


-- =========================================
-- SECTION 14: DATABASE VERIFICATION
-- =========================================
SHOW TABLES;


-- =========================================
-- SECTION 15: DATA QUALITY CHECK
-- TASK 1: CHECK MISSING VALUES
-- =========================================
SELECT *
FROM Passengers
WHERE first_name IS NULL
   OR last_name IS NULL
   OR email IS NULL;
   
   
   -- =========================================
-- SECTION 16: DUPLICATE DATA CHECK
-- TASK 1: CHECK DUPLICATE EMAILS
-- =========================================
SELECT email, COUNT(*) AS duplicate_count
FROM Passengers
GROUP BY email
HAVING COUNT(*) > 1;


-- =========================================
-- SECTION 17: DUPLICATE DATA CHECK
-- TASK 2: CHECK DUPLICATE PASSENGERS
-- =========================================
SELECT first_name, last_name, COUNT(*) AS duplicate_count
FROM Passengers
GROUP BY first_name, last_name
HAVING COUNT(*) > 1;


-- =========================================
-- SECTION 18: DATA VALIDATION
-- TASK 1: CHECK INVALID AGES
-- =========================================
SELECT *
FROM Passengers
WHERE age <= 0 OR age > 100;


-- =========================================
-- SECTION 19: CHECK MISSING AGE VALUES
-- =========================================
SELECT *
FROM Passengers
WHERE age IS NULL;


-- =========================================
-- SECTION 20: MISSING VALUE COUNT
-- TASK 1: COUNT MISSING PASSENGER AGES
-- =========================================
SELECT COUNT(*) AS missing_age_count
FROM Passengers
WHERE age IS NULL;


-- =========================================
-- SECTION 21: EMAIL DATA VALIDATION
-- TASK 1: CHECK INVALID EMAIL ADDRESSES
-- =========================================
SELECT *
FROM Passengers
WHERE email IS NULL
   OR email NOT LIKE '%@%.%';
   
   
   -- =========================================
-- SECTION 22: PHONE NUMBER VALIDATION
-- TASK 1: CHECK INVALID PHONE NUMBERS
-- =========================================
SELECT *
FROM Passengers
WHERE phone IS NULL
   OR phone NOT REGEXP '^[0-9]{10}$';
   
   
   -- =========================================
-- SECTION 23: BOOKING DATA VALIDATION
-- TASK 1: CHECK INVALID TICKET PRICES
-- =========================================
SELECT *
FROM Bookings
WHERE ticket_price <= 0
   OR ticket_price IS NULL;
   
   
   -- =========================================
-- SECTION 24: BOOKING STATUS VALIDATION
-- TASK 1: CHECK INVALID BOOKING STATUS
-- =========================================
SELECT *
FROM Bookings
WHERE booking_status NOT IN ('Confirmed', 'Cancelled')
   OR booking_status IS NULL;
   
   
   -- =========================================
-- SECTION 25: FLIGHT STATUS VALIDATION
-- TASK 1: CHECK INVALID FLIGHT STATUS
-- =========================================
SELECT *
FROM Flights
WHERE flight_status NOT IN ('Scheduled', 'Delayed', 'Cancelled')
   OR flight_status IS NULL;
   
   
   -- =========================================
-- SECTION 26: FLIGHT TIME VALIDATION
-- TASK 1: CHECK INVALID FLIGHT TIMES
-- =========================================
SELECT *
FROM Flights
WHERE arrival_time <= departure_time;
   
   
   -- =========================================
-- SECTION 27: DUPLICATE FLIGHT VALIDATION
-- TASK 1: CHECK DUPLICATE FLIGHT NUMBERS
-- =========================================
SELECT
    flight_number,
    COUNT(*) AS duplicate_count
FROM Flights
GROUP BY flight_number
HAVING COUNT(*) > 1;


-- =========================================
-- SECTION 28: BAGGAGE DATA VALIDATION
-- TASK 1: CHECK INVALID BAGGAGE WEIGHT
-- =========================================
SELECT *
FROM Baggage
WHERE baggage_weight IS NULL
   OR baggage_weight <= 0;
   
   
   -- =========================================
-- SECTION 29: BAGGAGE STATUS VALIDATION
-- TASK 1: CHECK INVALID BAGGAGE STATUS
-- =========================================
SELECT *
FROM Baggage
WHERE baggage_status NOT IN ('Checked-In', 'Loaded', 'Cancelled')
   OR baggage_status IS NULL;
   
   
   -- =========================================
-- SECTION 30: BOOKING RELATIONSHIP VALIDATION
-- TASK 1: CHECK INVALID PASSENGER REFERENCES
-- =========================================
SELECT b.*
FROM Bookings b
LEFT JOIN Passengers p
    ON b.passenger_id = p.passenger_id
WHERE p.passenger_id IS NULL;

-- =========================================
-- SECTION 31: FLIGHT RELATIONSHIP VALIDATION
-- TASK 1: CHECK INVALID FLIGHT REFERENCES
-- =========================================
SELECT b.*
FROM Bookings b
LEFT JOIN Flights f
    ON b.flight_id = f.flight_id
WHERE f.flight_id IS NULL;

-- =========================================
-- SECTION 32: BAGGAGE RELATIONSHIP VALIDATION
-- TASK 1: CHECK INVALID PASSENGER REFERENCES
-- =========================================
SELECT b.*
FROM Baggage b
LEFT JOIN Passengers p
    ON b.passenger_id = p.passenger_id
WHERE p.passenger_id IS NULL;


-- =========================================
-- SECTION 33: BAGGAGE BOOKING VALIDATION
-- TASK 1: CHECK INVALID BOOKING REFERENCES
-- =========================================
SELECT b.*
FROM Baggage b
LEFT JOIN Bookings bk
    ON b.booking_id = bk.booking_id
WHERE bk.booking_id IS NULL;

-- =========================================
-- SECTION 34: FLIGHT LOG VALIDATION
-- TASK 1: CHECK INVALID FLIGHT REFERENCES
-- =========================================
SELECT fl.*
FROM Flight_Logs fl
LEFT JOIN Flights f
    ON fl.flight_id = f.flight_id
WHERE f.flight_id IS NULL;

-- =========================================
-- SECTION 35: FLIGHT LOG STATUS VALIDATION
-- TASK 1: CHECK INVALID LOG STATUSES
-- =========================================
SELECT *
FROM Flight_Logs
WHERE previous_status NOT IN ('Scheduled', 'Delayed', 'Cancelled')
   OR new_status NOT IN ('Scheduled', 'Delayed', 'Cancelled')
   OR previous_status IS NULL
   OR new_status IS NULL;
   
   -- =========================================
-- SECTION 36: FLIGHT OPERATIONS ANALYSIS
-- TASK 1: FLIGHT STATUS SUMMARY
-- BUSINESS QUESTION:
-- How many flights are currently Scheduled,
-- Delayed, and Cancelled?
-- =======================================
SELECT
    flight_status,
    COUNT(*) AS total_flights
FROM Flights
GROUP BY flight_status;


-- =========================================
-- SECTION 37: AIRLINE-WISE FLIGHT ANALYSIS
-- TASK 2: FLIGHTS OPERATED BY EACH AIRLINE
-- BUSINESS QUESTION:
-- How many flights does each airline operate?
-- =========================================
SELECT
    airline,
    COUNT(*) AS total_flights
FROM Flights
GROUP BY airline;

-- =========================================
-- SECTION 38: AIRPORT OPERATIONS ANALYSIS
-- TASK 3: AIRPORT-WISE DEPARTURES
-- BUSINESS QUESTION:
-- How many flights depart from each airport?
-- =========================================
SELECT
    a.airport_name,
    a.city,
    COUNT(f.flight_id) AS total_departures
FROM Airports a
LEFT JOIN Flights f
    ON a.airport_id = f.departure_airport_id
GROUP BY a.airport_id, a.airport_name, a.city;


-- =========================================
-- SECTION 39: AIRPORT OPERATIONS ANALYSIS
-- TASK 4: AIRPORT-WISE ARRIVALS
-- BUSINESS QUESTION:
-- How many flights arrive at each airport?
-- =========================================
SELECT
    a.airport_name,
    a.city,
    COUNT(f.flight_id) AS total_arrivals
FROM Airports a
LEFT JOIN Flights f
    ON a.airport_id = f.arrival_airport_id
GROUP BY a.airport_id, a.airport_name, a.city;


-- =========================================
-- SECTION 40: PASSENGER BOOKING ANALYSIS
-- TASK 5: PASSENGER-WISE BOOKING COUNT
-- BUSINESS QUESTION:
-- How many bookings has each passenger made?
-- =========================================
SELECT
    p.passenger_id,
    p.first_name,
    p.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM Passengers p
LEFT JOIN Bookings b
    ON p.passenger_id = b.passenger_id
GROUP BY
    p.passenger_id,
    p.first_name,
    p.last_name;
    
    
-- =========================================
-- SECTION 41: REVENUE ANALYSIS
-- TASK 6: TOTAL BOOKING REVENUE
-- BUSINESS QUESTION:
-- What is the total revenue generated from all
-- flight bookings, including cancelled bookings?
-- =========================================
SELECT
    SUM(ticket_price) AS total_revenue
FROM Bookings;


-- =========================================
-- SECTION 42: REVENUE ANALYSIS
-- TASK 7: CONFIRMED BOOKING REVENUE
-- BUSINESS QUESTION:
-- How much revenue is generated from confirmed
-- bookings only?
-- =========================================
SELECT
    SUM(ticket_price) AS confirmed_revenue
FROM Bookings
WHERE booking_status = 'Confirmed';


-- =========================================
-- SECTION 43: BOOKING CANCELLATION ANALYSIS
-- TASK 8: TOTAL CANCELLED BOOKINGS
-- BUSINESS QUESTION:
-- How many flight bookings have been cancelled?
-- =========================================
SELECT
    COUNT(*) AS total_cancelled_bookings
FROM Bookings
WHERE booking_status = 'Cancelled';


-- =========================================
-- SECTION 44: BOOKING CANCELLATION ANALYSIS
-- TASK 9: BOOKING CANCELLATION RATE
-- BUSINESS QUESTION:
-- What percentage of total bookings have
-- been cancelled?
-- =========================================
SELECT
    COUNT(*) AS total_bookings,
    SUM(CASE
        WHEN booking_status = 'Cancelled' THEN 1
        ELSE 0
    END) AS cancelled_bookings,
    ROUND(
        SUM(CASE
            WHEN booking_status = 'Cancelled' THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate_percentage
FROM Bookings;



-- =========================================
-- SECTION 45: TICKET PRICE ANALYSIS
-- TASK 10: AVERAGE TICKET PRICE
-- BUSINESS QUESTION:
-- What is the average ticket price across
-- all flight bookings?
-- =========================================
SELECT
    ROUND(AVG(ticket_price), 2) AS average_ticket_price
FROM Bookings;


-- =========================================
-- SECTION 46: TICKET PRICE ANALYSIS
-- TASK 11: HIGHEST TICKET PRICE
-- BUSINESS QUESTION:
-- What is the highest ticket price recorded
-- among all bookings?
-- =========================================
SELECT
    MAX(ticket_price) AS highest_ticket_price
FROM Bookings;


-- =========================================
-- SECTION 47: TICKET PRICE ANALYSIS
-- TASK 12: LOWEST TICKET PRICE
-- BUSINESS QUESTION:
-- What is the lowest ticket price recorded
-- among all bookings?
-- =========================================
SELECT
    MIN(ticket_price) AS lowest_ticket_price
FROM Bookings;


-- =========================================
-- SECTION 48: FLIGHT BOOKING ANALYSIS
-- TASK 13: FLIGHT-WISE BOOKING COUNT
-- BUSINESS QUESTION:
-- How many bookings are recorded for each flight?
-- =========================================
SELECT
    f.flight_number,
    f.airline,
    COUNT(b.booking_id) AS total_bookings
FROM Flights f
LEFT JOIN Bookings b
    ON f.flight_id = b.flight_id
GROUP BY
    f.flight_id,
    f.flight_number,
    f.airline;
    
    
    -- =========================================
-- SECTION 49: FLIGHT BOOKING ANALYSIS
-- TASK 14: FLIGHT-WISE CONFIRMED BOOKINGS
-- BUSINESS QUESTION:
-- How many confirmed bookings does each flight have?
-- =========================================
SELECT
    f.flight_number,
    f.airline,
    COUNT(b.booking_id) AS confirmed_bookings
FROM Flights f
LEFT JOIN Bookings b
    ON f.flight_id = b.flight_id
   AND b.booking_status = 'Confirmed'
GROUP BY
    f.flight_id,
    f.flight_number,
    f.airline;
    
-- =========================================
-- SECTION 50: AIRLINE REVENUE ANALYSIS
-- TASK 15: AIRLINE-WISE CONFIRMED REVENUE
-- BUSINESS QUESTION:
-- How much confirmed booking revenue does
-- each airline generate?
-- =========================================
SELECT
    f.airline,
    SUM(b.ticket_price) AS total_confirmed_revenue
FROM Flights f
INNER JOIN Bookings b
    ON f.flight_id = b.flight_id
WHERE b.booking_status = 'Confirmed'
GROUP BY f.airline;


-- =========================================
-- SECTION 51: BAGGAGE ANALYSIS
-- TASK 16: FLIGHT-WISE TOTAL BAGGAGE WEIGHT
-- BUSINESS QUESTION:
-- What is the total baggage weight carried
-- on each flight?
-- =========================================
SELECT
    f.flight_number,
    f.airline,
    SUM(bg.baggage_weight) AS total_baggage_weight
FROM Flights f
INNER JOIN Bookings b
    ON f.flight_id = b.flight_id
INNER JOIN Baggage bg
    ON b.booking_id = bg.booking_id
GROUP BY
    f.flight_id,
    f.flight_number,
    f.airline;


    -- =========================================
-- SECTION 52: BAGGAGE OPERATIONS ANALYSIS
-- TASK 17: BAGGAGE STATUS SUMMARY
-- BUSINESS QUESTION:
-- How many baggage items are Checked-In,
-- Loaded, and Cancelled?
-- =========================================
SELECT
    baggage_status,
    COUNT(*) AS total_baggage
FROM Baggage
GROUP BY baggage_status;


-- =========================================
-- SECTION 53: BAGGAGE WEIGHT ANALYSIS
-- TASK 18: AVERAGE BAGGAGE WEIGHT
-- BUSINESS QUESTION:
-- What is the average weight of baggage
-- handled across all flights?
-- =========================================
SELECT
    ROUND(AVG(baggage_weight), 2) AS average_baggage_weight
FROM Baggage;


-- =========================================
-- SECTION 54: BAGGAGE WEIGHT ANALYSIS
-- TASK 19: HEAVIEST BAGGAGE IDENTIFICATION
-- BUSINESS QUESTION:
-- Which passenger has the heaviest baggage,
-- and which flight is it associated with?
-- =========================================
SELECT
    p.first_name,
    p.last_name,
    f.flight_number,
    bg.baggage_tag,
    bg.baggage_weight
FROM Baggage bg
INNER JOIN Passengers p
    ON bg.passenger_id = p.passenger_id
INNER JOIN Bookings b
    ON bg.booking_id = b.booking_id
INNER JOIN Flights f
    ON b.flight_id = f.flight_id
ORDER BY bg.baggage_weight DESC
LIMIT 1;


-- =========================================
-- SECTION 55: FLIGHT DELAY ANALYSIS
-- TASK 20: DELAYED FLIGHTS IDENTIFICATION
-- BUSINESS QUESTION:
-- Which flights are currently delayed,
-- and which airlines operate them?
-- =========================================
SELECT
    f.flight_number,
    f.airline,
    dep.airport_name AS departure_airport,
    arr.airport_name AS arrival_airport,
    f.flight_status
FROM Flights f
INNER JOIN Airports dep
    ON f.departure_airport_id = dep.airport_id
INNER JOIN Airports arr
    ON f.arrival_airport_id = arr.airport_id
WHERE f.flight_status = 'Delayed';


-- =========================================
-- SECTION 56: FLIGHT CANCELLATION ANALYSIS
-- TASK 21: CANCELLED FLIGHTS IDENTIFICATION
-- BUSINESS QUESTION:
-- Which flights have been cancelled,
-- and which airlines operate them?
-- =========================================
SELECT
    f.flight_number,
    f.airline,
    dep.airport_name AS departure_airport,
    arr.airport_name AS arrival_airport,
    f.flight_status
FROM Flights f
INNER JOIN Airports dep
    ON f.departure_airport_id = dep.airport_id
INNER JOIN Airports arr
    ON f.arrival_airport_id = arr.airport_id
WHERE f.flight_status = 'Cancelled';


-- =========================================
-- SECTION 57: FLIGHT STATUS HISTORY ANALYSIS
-- TASK 22: FLIGHT STATUS CHANGE HISTORY
-- BUSINESS QUESTION:
-- How have flight statuses changed over time,
-- and what were the reasons for those changes?
-- =========================================
SELECT
    f.flight_number,
    f.airline,
    fl.previous_status,
    fl.new_status,
    fl.change_reason,
    fl.changed_at
FROM Flight_Logs fl
INNER JOIN Flights f
    ON fl.flight_id = f.flight_id
ORDER BY fl.changed_at DESC;



-- =========================================
-- SECTION 58: FLIGHT DATA CONSISTENCY
-- TASK 1: COMPARE CURRENT STATUS WITH LATEST LOG
-- BUSINESS QUESTION:
-- Are the current flight statuses consistent
-- with the latest recorded status history
-- for each flight?
-- =========================================
SELECT
    f.flight_number,
    f.flight_status AS current_status,
    fl.new_status AS latest_logged_status
FROM Flights f
INNER JOIN Flight_Logs fl
    ON f.flight_id = fl.flight_id
WHERE fl.changed_at = (
    SELECT MAX(fl2.changed_at)
    FROM Flight_Logs fl2
    WHERE fl2.flight_id = f.flight_id
)
AND f.flight_status <> fl.new_status;




-- =========================================
-- SECTION 59: CANCELLED FLIGHT ANALYSIS
-- TASK 1: FIND BOOKINGS FOR CANCELLED FLIGHTS
-- BUSINESS QUESTION:
-- Which bookings are associated with cancelled
-- flights, and what are their booking statuses
-- and ticket prices?
-- =========================================
SELECT
    f.flight_number,
    f.airline,
    b.booking_id,
    b.booking_status,
    b.ticket_price
FROM Flights f
INNER JOIN Bookings b
    ON f.flight_id = b.flight_id
WHERE f.flight_status = 'Cancelled';

-- =========================================
-- SECTION 60: CANCELLED FLIGHT ANALYSIS
-- TASK 2: COUNT CONFIRMED BOOKINGS
-- BUSINESS QUESTION:
-- How many confirmed bookings are associated
-- with cancelled flights?
-- =========================================
SELECT
    COUNT(*) AS confirmed_bookings_on_cancelled_flights
FROM Flights f
INNER JOIN Bookings b
    ON f.flight_id = b.flight_id
WHERE f.flight_status = 'Cancelled'
AND b.booking_status = 'Confirmed';


-- =========================================
-- SECTION 61: PASSENGER IMPACT ANALYSIS
-- TASK 1: IDENTIFY AFFECTED PASSENGER
-- BUSINESS QUESTION:
-- Which passengers have confirmed bookings
-- on cancelled flights, and what are their
-- contact and booking details?
-- =========================================
SELECT
    p.first_name,
    p.last_name,
    p.email,
    f.flight_number,
    f.flight_status,
    b.booking_status,
    b.ticket_price
FROM Passengers p
INNER JOIN Bookings b
    ON p.passenger_id = b.passenger_id
INNER JOIN Flights f
    ON b.flight_id = f.flight_id
WHERE f.flight_status = 'Cancelled'
AND b.booking_status = 'Confirmed';


-- =========================================
-- SECTION 62: FINANCIAL IMPACT ANALYSIS
-- TASK 1: CALCULATE AFFECTED BOOKING VALUE
-- BUSINESS QUESTION:
-- What is the total ticket value of confirmed
-- bookings affected by flight cancellations?
-- =========================================

SELECT
    SUM(b.ticket_price) AS affected_booking_value
FROM Flights f
INNER JOIN Bookings b
    ON f.flight_id = b.flight_id
WHERE f.flight_status = 'Cancelled'
AND b.booking_status = 'Confirmed';


-- =========================================
-- SECTION 63: BAGGAGE OPERATIONAL ANALYSIS
-- TASK 1: FIND LOADED BAGGAGE ON CANCELLED FLIGHTS
-- BUSINESS QUESTION:
-- Which passengers have loaded baggage assigned
-- to cancelled flights, and what are the baggage
-- details?
-- =========================================
SELECT
    f.flight_number,
    f.flight_status,
    p.first_name,
    p.last_name,
    bg.baggage_tag,
    bg.baggage_weight,
    bg.baggage_status
FROM Flights f
INNER JOIN Bookings b
    ON f.flight_id = b.flight_id
INNER JOIN Passengers p
    ON b.passenger_id = p.passenger_id
INNER JOIN Baggage bg
    ON b.booking_id = bg.booking_id
WHERE f.flight_status = 'Cancelled'
AND bg.baggage_status = 'Loaded';


-- =========================================
-- SECTION 64: BAGGAGE OPERATIONAL ANALYSIS
-- TASK 2: CALCULATE LOADED BAGGAGE WEIGHT
-- BUSINESS QUESTION:
-- What is the total weight of loaded baggage
-- associated with cancelled flights?
-- =========================================
SELECT
    SUM(bg.baggage_weight) AS total_loaded_baggage_weight
FROM Flights f
INNER JOIN Bookings b
    ON f.flight_id = b.flight_id
INNER JOIN Baggage bg
    ON b.booking_id = bg.booking_id
WHERE f.flight_status = 'Cancelled'
AND bg.baggage_status = 'Loaded';


-- =========================================
-- SECTION 65: OPERATIONAL EXCEPTION REPORT
-- TASK 1: COMBINE PASSENGER, FLIGHT AND BAGGAGE DETAILS
-- BUSINESS QUESTION:
-- Which passengers have confirmed bookings on
-- cancelled flights, and what are their related
-- flight, ticket, and baggage details?
-- =========================================
SELECT
    p.first_name,
    p.last_name,
    f.flight_number,
    f.airline,
    b.booking_status,
    b.ticket_price,
    bg.baggage_tag,
    bg.baggage_weight,
    bg.baggage_status
FROM Passengers p
INNER JOIN Bookings b
    ON p.passenger_id = b.passenger_id
INNER JOIN Flights f
    ON b.flight_id = f.flight_id
LEFT JOIN Baggage bg
    ON b.booking_id = bg.booking_id
WHERE f.flight_status = 'Cancelled'
AND b.booking_status = 'Confirmed';


-- =========================================
-- SECTION 66: CREATE OPERATIONAL REPORT VIEW
-- TASK 1: SAVE EXCEPTION REPORT
-- BUSINESS QUESTION:
-- How can the operational exception report be
-- saved for repeated analysis without rewriting
-- the complete SQL query?
-- =========================================
CREATE VIEW Cancelled_Flight_Exception_Report AS
SELECT
    p.first_name,
    p.last_name,
    f.flight_number,
    f.airline,
    b.booking_status,
    b.ticket_price,
    bg.baggage_tag,
    bg.baggage_weight,
    bg.baggage_status
FROM Passengers p
INNER JOIN Bookings b
    ON p.passenger_id = b.passenger_id
INNER JOIN Flights f
    ON b.flight_id = f.flight_id
LEFT JOIN Baggage bg
    ON b.booking_id = bg.booking_id
WHERE f.flight_status = 'Cancelled'
AND b.booking_status = 'Confirmed';


-- =========================================
-- SECTION 67: VIEW VERIFICATION
-- TASK 1: DISPLAY EXCEPTION REPORT
-- BUSINESS QUESTION:
-- Does the saved operational exception report
-- correctly display the affected passenger,
-- flight, booking, and baggage details?
-- =========================================
SELECT *
FROM Cancelled_Flight_Exception_Report;

-- =========================================
-- SECTION 68: VIEW STRUCTURE ANALYSIS
-- TASK 1: DESCRIBE SAVED VIEW
-- BUSINESS QUESTION:
-- What columns and data structures are available
-- in the saved operational exception report?
-- =========================================
DESC Cancelled_Flight_Exception_Report;


-- =========================================
-- SECTION 69: VIEW-BASED ANALYSIS
-- TASK 1: FILTER EXCEPTIONS BY AIRLINE
-- BUSINESS QUESTION:
-- What operational exceptions are associated
-- with Air India flights?
-- =========================================
SELECT *
FROM Cancelled_Flight_Exception_Report
WHERE airline = 'Air India';


-- =========================================
-- SECTION 70: VIEW-BASED ANALYSIS
-- TASK 2: COUNT EXCEPTION RECORDS
-- BUSINESS QUESTION:
-- How many operational exception records are
-- currently available in the saved report?
-- =========================================
SELECT
    COUNT(*) AS total_exception_records
FROM Cancelled_Flight_Exception_Report;


-- =========================================
-- SECTION 71: AIRLINE-WISE EXCEPTION ANALYSIS
-- TASK 1: COUNT EXCEPTIONS BY AIRLINE
-- BUSINESS QUESTION:
-- How many operational exceptions and what
-- total affected booking value are associated
-- with each airline?
-- =========================================

SELECT
    airline,
    COUNT(*) AS total_exceptions,
    SUM(ticket_price) AS affected_booking_value
FROM Cancelled_Flight_Exception_Report
GROUP BY airline;


-- =========================================
-- SECTION 72: STORED PROCEDURES
-- TASK 1: CREATE FLIGHT STATUS PROCEDURE
-- BUSINESS QUESTION:
-- How can airport management retrieve the
-- current status of all flights using a
-- reusable SQL procedure?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_Flight_Status()
BEGIN
    SELECT
        flight_number,
        airline,
        flight_status
    FROM Flights;
END //

DELIMITER ;

-- =========================================
-- SECTION 73: STORED PROCEDURES
-- TASK 2: EXECUTE FLIGHT STATUS PROCEDURE
-- BUSINESS QUESTION:
-- What are the current statuses of all
-- flights when the flight status procedure
-- is executed?
-- =========================================
CALL Get_Flight_Status();


-- =========================================
-- SECTION 74: STORED PROCEDURES
-- TASK 3: PASSENGER BOOKING DETAILS
-- BUSINESS QUESTION:
-- How can airport management retrieve
-- booking details for a specific passenger
-- using their passenger ID?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_Passenger_Bookings(
    IN p_passenger_id INT
)
BEGIN
    SELECT
        p.first_name,
        p.last_name,
        f.flight_number,
        f.airline,
        b.booking_status,
        b.ticket_price
    FROM Passengers p
    INNER JOIN Bookings b
        ON p.passenger_id = b.passenger_id
    INNER JOIN Flights f
        ON b.flight_id = f.flight_id
    WHERE p.passenger_id = p_passenger_id;
END //

DELIMITER ;


-- =========================================
-- SECTION 75: STORED PROCEDURES
-- TASK 4: GET PASSENGER BOOKINGS
-- BUSINESS QUESTION:
-- What are the flight booking details of
-- the passenger with ID 7?
-- =========================================
CALL Get_Passenger_Bookings(7);


-- =========================================
-- SECTION 76: STORED PROCEDURES
-- TASK 5: TEST ANOTHER PASSENGER
-- BUSINESS QUESTION:
-- What are the flight booking details of
-- the passenger with ID 5?
-- =========================================
CALL Get_Passenger_Bookings(5);


-- =========================================
-- SECTION 77: STORED PROCEDURES
-- TASK 6: TEST INVALID PASSENGER ID
-- BUSINESS QUESTION:
-- What happens when the passenger booking
-- procedure is executed with a passenger ID
-- that does not exist in the database?
-- =========================================
CALL Get_Passenger_Bookings(100);


-- =========================================
-- SECTION 78: STORED PROCEDURES
-- TASK 7: DELAYED FLIGHT ANALYSIS
-- BUSINESS QUESTION:
-- Which flights are currently delayed, and
-- what are their airlines and departure
-- and arrival cities?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_Delayed_Flights()
BEGIN
    SELECT
        f.flight_number,
        f.airline,
        dep.city AS departure_city,
        arr.city AS arrival_city,
        f.flight_status
    FROM Flights f
    INNER JOIN Airports dep
        ON f.departure_airport_id = dep.airport_id
    INNER JOIN Airports arr
        ON f.arrival_airport_id = arr.airport_id
    WHERE f.flight_status = 'Delayed';
END //

DELIMITER ;


-- =========================================
-- SECTION 79: STORED PROCEDURES
-- TASK 8: EXECUTE DELAYED FLIGHTS REPORT
-- BUSINESS QUESTION:
-- Which delayed flights and affected routes
-- are returned when the delayed flights
-- procedure is executed?
-- =========================================
CALL Get_Delayed_Flights();


-- =========================================
-- SECTION 80: STORED PROCEDURES
-- TASK 9: CANCELLED FLIGHT ANALYSIS
-- BUSINESS QUESTION:
-- Which flights are currently cancelled,
-- and what are their airlines and departure
-- and arrival cities?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_Cancelled_Flights()
BEGIN
    SELECT
        f.flight_number,
        f.airline,
        dep.city AS departure_city,
        arr.city AS arrival_city,
        f.flight_status
    FROM Flights f
    INNER JOIN Airports dep
        ON f.departure_airport_id = dep.airport_id
    INNER JOIN Airports arr
        ON f.arrival_airport_id = arr.airport_id
    WHERE f.flight_status = 'Cancelled';
END //

DELIMITER ;


-- =========================================
-- SECTION 81: STORED PROCEDURES
-- TASK 10: EXECUTE CANCELLED FLIGHTS REPORT
-- BUSINESS QUESTION:
-- Which cancelled flights and affected routes
-- are returned when the cancelled flights
-- procedure is executed?
-- =========================================
CALL Get_Cancelled_Flights();


-- =========================================
-- SECTION 82: STORED PROCEDURES
-- TASK 11: CONFIRMED BOOKINGS REPORT
-- BUSINESS QUESTION:
-- Which passengers have confirmed flight
-- bookings, and what are their flight and
-- ticket details?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_Confirmed_Bookings()
BEGIN
    SELECT
        p.first_name,
        p.last_name,
        f.flight_number,
        f.airline,
        b.ticket_price,
        b.booking_status
    FROM Passengers p
    INNER JOIN Bookings b
        ON p.passenger_id = b.passenger_id
    INNER JOIN Flights f
        ON b.flight_id = f.flight_id
    WHERE b.booking_status = 'Confirmed';
END //

DELIMITER ;

-- =========================================
-- SECTION 83: STORED PROCEDURES
-- TASK 12: EXECUTE CONFIRMED BOOKINGS REPORT
-- BUSINESS QUESTION:
-- Which confirmed passenger bookings are
-- displayed when the confirmed bookings
-- procedure is executed?
-- =========================================
call Get_Confirmed_Bookings();


-- =========================================
-- SECTION 84: STORED PROCEDURES
-- TASK 13: CANCELLED BOOKINGS REPORT
-- BUSINESS QUESTION:
-- Which passengers have cancelled their
-- bookings, and what are the related flight
-- and ticket details?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_Cancelled_Bookings()
BEGIN
    SELECT
        p.first_name,
        p.last_name,
        f.flight_number,
        f.airline,
        b.ticket_price,
        b.booking_status
    FROM Passengers p
    INNER JOIN Bookings b
        ON p.passenger_id = b.passenger_id
    INNER JOIN Flights f
        ON b.flight_id = f.flight_id
    WHERE b.booking_status = 'Cancelled';
END //

DELIMITER ;


-- =========================================
-- SECTION 85: STORED PROCEDURES
-- TASK 14: EXECUTE CANCELLED BOOKINGS REPORT
-- BUSINESS QUESTION:
-- Which cancelled passenger bookings are
-- displayed when the cancelled bookings
-- procedure is executed?
-- =========================================
CALL Get_Cancelled_Bookings();


-- =========================================
-- SECTION 86: STORED PROCEDURES
-- TASK 15: AIRLINE-WISE REVENUE REPORT
-- BUSINESS QUESTION:
-- How many total bookings and how much
-- confirmed booking value does each airline
-- generate?
-- =========================================

DELIMITER //

CREATE PROCEDURE Get_Airline_Revenue()
BEGIN
    SELECT
        f.airline,
        COUNT(b.booking_id) AS total_bookings,
        SUM(
            CASE
                WHEN b.booking_status = 'Confirmed'
                THEN b.ticket_price
                ELSE 0
            END
        ) AS confirmed_booking_value
    FROM Flights f
    INNER JOIN Bookings b
        ON f.flight_id = b.flight_id
    GROUP BY f.airline;
END //

DELIMITER ;



-- =========================================
-- SECTION 87: STORED PROCEDURES
-- TASK 16: EXECUTE AIRLINE-WISE REVENUE REPORT
-- BUSINESS QUESTION:
-- What are the total booking counts and
-- confirmed booking values for each airline
-- in the generated report?
-- =========================================
CALL Get_Airline_Revenue();


-- =========================================
-- SECTION 88: STORED PROCEDURES
-- TASK 17: HIGH-VALUE BOOKINGS REPORT
-- BUSINESS QUESTION:
-- Which passengers have bookings with ticket
-- prices equal to or above a specified
-- minimum price?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_High_Value_Bookings(
    IN p_min_price DECIMAL(10,2)
)
BEGIN
    SELECT
        p.first_name,
        p.last_name,
        f.flight_number,
        f.airline,
        b.ticket_price,
        b.booking_status
    FROM Passengers p
    INNER JOIN Bookings b
        ON p.passenger_id = b.passenger_id
    INNER JOIN Flights f
        ON b.flight_id = f.flight_id
    WHERE b.ticket_price >= p_min_price;
END //

DELIMITER ;


-- =========================================
-- SECTION 89: STORED PROCEDURES
-- TASK 18: EXECUTE HIGH-VALUE BOOKINGS REPORT
-- BUSINESS QUESTION:
-- Which passenger bookings have a ticket
-- price of ₹5,000 or more?
-- =========================================
CALL Get_High_Value_Bookings(5000);

-- =========================================
-- SECTION 90: STORED PROCEDURES
-- TASK 19: PASSENGER BOOKING SUMMARY
-- BUSINESS QUESTION:
-- How many total, confirmed, and cancelled
-- bookings does each passenger have?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_Passenger_Booking_Summary()
BEGIN
    SELECT
        p.passenger_id,
        p.first_name,
        p.last_name,
        COUNT(b.booking_id) AS total_bookings,
        SUM(
            CASE
                WHEN b.booking_status = 'Confirmed'
                THEN 1
                ELSE 0
            END
        ) AS confirmed_bookings,
        SUM(
            CASE
                WHEN b.booking_status = 'Cancelled'
                THEN 1
                ELSE 0
            END
        ) AS cancelled_bookings
    FROM Passengers p
    LEFT JOIN Bookings b
        ON p.passenger_id = b.passenger_id
    GROUP BY
        p.passenger_id,
        p.first_name,
        p.last_name;
END //

DELIMITER ;



-- =========================================
-- SECTION 91: STORED PROCEDURES
-- TASK 20: EXECUTE PASSENGER BOOKING SUMMARY
-- BUSINESS QUESTION:
-- What is the booking summary for each
-- passenger when the stored procedure
-- is executed?
-- =========================================
CALL Get_Passenger_Booking_Summary();


-- =========================================
-- SECTION 92: STORED PROCEDURES
-- TASK 21: BAGGAGE WEIGHT ANALYSIS
-- BUSINESS QUESTION:
-- What are the total, average, and maximum
-- baggage weights handled by each flight,
-- and how many baggage items are associated
-- with each flight?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_Baggage_Weight_Analysis()
BEGIN
    SELECT
        f.flight_number,
        f.airline,
        COUNT(bg.baggage_id) AS total_baggage,
        SUM(bg.baggage_weight) AS total_baggage_weight,
        AVG(bg.baggage_weight) AS average_baggage_weight,
        MAX(bg.baggage_weight) AS maximum_baggage_weight
    FROM Flights f
    INNER JOIN Bookings b
        ON f.flight_id = b.flight_id
    INNER JOIN Baggage bg
        ON b.booking_id = bg.booking_id
    GROUP BY
        f.flight_number,
        f.airline;
END //

DELIMITER ;


-- =========================================
-- SECTION 93: STORED PROCEDURES
-- TASK 22: EXECUTE BAGGAGE WEIGHT ANALYSIS
-- BUSINESS QUESTION:
-- What baggage weight statistics are
-- returned for each flight when the
-- baggage analysis procedure is executed?
-- =========================================
CALL Get_Baggage_Weight_Analysis();


-- =========================================
-- SECTION 94: STORED PROCEDURES
-- TASK 23: HEAVY BAGGAGE IDENTIFICATION
-- BUSINESS QUESTION:
-- Which passengers have baggage weighing
-- equal to or above a specified minimum
-- weight, and what are its details?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_Heavy_Baggage(
    IN p_min_weight DECIMAL(5,2)
)
BEGIN
    SELECT
        p.first_name,
        p.last_name,
        f.flight_number,
        bg.baggage_tag,
        bg.baggage_weight,
        bg.baggage_status
    FROM Baggage bg
    INNER JOIN Passengers p
        ON bg.passenger_id = p.passenger_id
    INNER JOIN Bookings b
        ON bg.booking_id = b.booking_id
    INNER JOIN Flights f
        ON b.flight_id = f.flight_id
    WHERE bg.baggage_weight >= p_min_weight;
END //

DELIMITER ;

-- =========================================
-- SECTION 95: STORED PROCEDURES
-- TASK 24: EXECUTE HEAVY BAGGAGE REPORT
-- BUSINESS QUESTION:
-- Which passengers have baggage weighing
-- 20 kg or more, and what are their baggage
-- details and current baggage statuses?
-- =========================================
CALL Get_Heavy_Baggage(20);


-- =========================================
-- SECTION 96: STORED PROCEDURES
-- TASK 25: FLIGHT-WISE PASSENGER MANIFEST
-- BUSINESS QUESTION:
-- Which passengers are associated with a
-- selected flight, and what are their
-- booking and contact details?
-- =========================================
DELIMITER //
CREATE PROCEDURE Get_Flight_Passenger_Manifest(
    IN p_flight_number VARCHAR(20)
)
BEGIN
    SELECT
        f.flight_number,
        f.airline,
        p.passenger_id,
        p.first_name,
        p.last_name,
        p.email,
        b.booking_status
    FROM Flights f
    INNER JOIN Bookings b
        ON f.flight_id = b.flight_id
    INNER JOIN Passengers p
        ON b.passenger_id = p.passenger_id
    WHERE f.flight_number = p_flight_number;
END //

DELIMITER ;


-- =========================================
-- SECTION 97: STORED PROCEDURES
-- TASK 26: EXECUTE FLIGHT PASSENGER MANIFEST
-- BUSINESS QUESTION:
-- Which passengers are booked on flight
-- AI101, and what are their booking details?
-- =========================================
CALL Get_Flight_Passenger_Manifest('AI101');



-- =========================================
-- SECTION 98: STORED PROCEDURES
-- TASK 27: FLIGHT OPERATIONS SUMMARY
-- BUSINESS QUESTION:
-- What is the overall operational summary
-- of each flight, including flight status,
-- booking counts, confirmed booking value,
-- and total baggage weight?
-- =========================================
DELIMITER //

CREATE PROCEDURE Get_Flight_Operations_Summary()
BEGIN
    SELECT
        f.flight_number,
        f.airline,
        f.flight_status,
        COALESCE(b.total_bookings, 0) AS total_bookings,
        COALESCE(b.confirmed_bookings, 0) AS confirmed_bookings,
        COALESCE(b.cancelled_bookings, 0) AS cancelled_bookings,
        COALESCE(b.confirmed_booking_value, 0) AS confirmed_booking_value,
        COALESCE(bg.total_baggage_weight, 0) AS total_baggage_weight
    FROM Flights f
    LEFT JOIN (
        SELECT
            flight_id,
            COUNT(*) AS total_bookings,
            SUM(
                CASE
                    WHEN booking_status = 'Confirmed'
                    THEN 1
                    ELSE 0
                END
            ) AS confirmed_bookings,
            SUM(
                CASE
                    WHEN booking_status = 'Cancelled'
                    THEN 1
                    ELSE 0
                END
            ) AS cancelled_bookings,
            SUM(
                CASE
                    WHEN booking_status = 'Confirmed'
                    THEN ticket_price
                    ELSE 0
                END
            ) AS confirmed_booking_value
        FROM Bookings
        GROUP BY flight_id
    ) b
        ON f.flight_id = b.flight_id
    LEFT JOIN (
        SELECT
            b.flight_id,
            SUM(bg.baggage_weight) AS total_baggage_weight
        FROM Bookings b
        INNER JOIN Baggage bg
            ON b.booking_id = bg.booking_id
        GROUP BY b.flight_id
    ) bg
        ON f.flight_id = bg.flight_id;
END //

DELIMITER ;


-- =========================================
-- SECTION 99: STORED PROCEDURES
-- TASK 28: EXECUTE FLIGHT OPERATIONS SUMMARY
-- BUSINESS QUESTION:
-- What is the consolidated operational
-- performance of all flights when the
-- flight operations summary is executed?
-- =========================================
CALL Get_Flight_Operations_Summary();


-- =========================================
-- SECTION 100: FLIGHT STATUS LOGGING
-- TASK 1: CREATE UPDATE TRIGGER
-- BUSINESS QUESTION:
-- How can flight status changes be
-- automatically recorded in the flight
-- status history table?
-- =========================================
DELIMITER //
CREATE TRIGGER trg_flight_status_update
AFTER UPDATE ON Flights
FOR EACH ROW
BEGIN
    IF OLD.flight_status <> NEW.flight_status THEN

        INSERT INTO Flight_Logs (
            flight_id,
            previous_status,
            new_status,
            change_reason,
            changed_at
        )
        VALUES (
            NEW.flight_id,
            OLD.flight_status,
            NEW.flight_status,
            'Automatic status update',
            NOW()
        );

    END IF;
END //
DELIMITER ;

-- =========================================
-- SECTION 101: FLIGHT STATUS LOGGING
-- TASK 2: TEST AUTOMATIC TRIGGER
-- BUSINESS QUESTION:
-- Does changing a flight's status
-- automatically activate the trigger and
-- record the status change?
-- =========================================
UPDATE Flights
SET flight_status = 'Delayed'
WHERE flight_id = 1;

-- =========================================
-- SECTION 102: FLIGHT STATUS LOGGING
-- TASK 3: VERIFY TRIGGER OUTPUT
-- BUSINESS QUESTION:
-- Has the automatic trigger successfully
-- recorded the latest flight status change
-- in the flight history table?
-- =========================================
SELECT *
FROM Flight_Logs
WHERE flight_id = 1
ORDER BY changed_at DESC;


-- =========================================
-- SECTION 103: FLIGHT STATUS LOGGING
-- TASK 4: RESTORE ORIGINAL FLIGHT STATUS
-- BUSINESS QUESTION:
-- Can the original flight status be restored
-- after testing the automatic status update
-- trigger?
-- =========================================
UPDATE Flights
SET flight_status = 'Scheduled'
WHERE flight_id = 1;

-- =========================================
-- SECTION 104: FLIGHT STATUS LOGGING
-- TASK 5: VERIFY RESTORED STATUS
-- BUSINESS QUESTION:
-- Has the original flight status been successfully
-- restored after testing the automatic status
-- update trigger?
-- =========================================
SELECT
    flight_number,
    flight_status
FROM Flights
WHERE flight_id = 1;

-- =========================================
-- SECTION 105: FLIGHT STATUS LOGGING
-- TASK 6: VERIFY STATUS CHANGE HISTORY
-- BUSINESS QUESTION:
-- Has the automatic trigger correctly recorded
-- all status changes for flight AI101
-- in the flight history table?
-- =========================================
SELECT
    flight_id,
    previous_status,
    new_status,
    change_reason,
    changed_at
FROM Flight_Logs
WHERE flight_id = 1
ORDER BY changed_at DESC;

-- =========================================
-- SECTION 106: FLIGHT STATUS LOGGING
-- TASK 7: PREVENT DUPLICATE STATUS LOGS
-- BUSINESS QUESTION:
-- Does the automatic trigger prevent duplicate
-- history records when a flight status is updated
-- to its existing status?
-- =========================================
UPDATE Flights
SET flight_status = 'Scheduled'
WHERE flight_id = 1;

-- =========================================
-- SECTION 107: FLIGHT STATUS LOGGING
-- TASK 8: VERIFY DUPLICATE LOG PREVENTION
-- BUSINESS QUESTION:
-- Has the trigger successfully prevented duplicate 
-- status history records when the flight status
-- remains unchanged?
-- =========================================
SELECT COUNT(*) AS total_logs
FROM Flight_Logs
WHERE flight_id = 1;

USE Airport_Operations;

SHOW TABLES;

-- =========================================
-- PROJECT: AIRPORT OPERATIONS & AUTOMATION
-- RELATIONSHIP VALIDATION
-- STEP 2: CHECK FOREIGN KEY RELATIONSHIPS
-- BUSINESS QUESTION:
-- Which tables are connected through foreign
-- key relationships, and which parent tables
-- do they reference?
-- =========================================
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'Airport_Operations'
AND REFERENCED_TABLE_NAME IS NOT NULL
ORDER BY TABLE_NAME;


-- =========================================
-- PROJECT: AIRPORT OPERATIONS & AUTOMATION
-- RELATIONSHIP VALIDATION
-- STEP 3: CHECK UNIQUE CONSTRAINT
-- BUSINESS QUESTION:
-- Can a single booking have multiple baggage
-- records, or is each booking limited to
-- one baggage record?
-- =========================================

SELECT
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'Airport_Operations'
AND TABLE_NAME = 'Baggage'
AND COLUMN_NAME = 'booking_id';

SHOW INDEX FROM Baggage;


 