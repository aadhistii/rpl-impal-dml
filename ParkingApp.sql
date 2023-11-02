-- DDL

CREATE TYPE STATUS AS ENUM ('booked', 'check in', 'check out', 'canceled');

CREATE TABLE IF NOT EXISTS customer (
	customerId	SERIAL PRIMARY KEY,
	username	VARCHAR(16) UNIQUE,
	password	CHAR(64),
	fullName	VARCHAR(50),
	email		VARCHAR(50),
	phoneNumber	VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS employee (
	employeeId	SERIAL PRIMARY KEY,
	username	VARCHAR(16) UNIQUE,
	password	CHAR(64),
	fullName	VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS vehicle (
	vehicleId		SERIAL PRIMARY KEY,
	customerId		INT,
	driver			VARCHAR(50),
	brandType		VARCHAR(50),
	color			VARCHAR(24),
	policeNumber	VARCHAR(8) UNIQUE,
	FOREIGN KEY (customerId) REFERENCES customer (customerId) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS booking (
	bookingId		SERIAL PRIMARY KEY,
	customerId		INT,
	vehicleId		INT,
	bookingdate		TIMESTAMP,
	status			STATUS,
	baseFee			INT,
	FOREIGN KEY (customerId) REFERENCES customer (customerId) ON DELETE CASCADE,
	FOREIGN KEY (vehicleId) REFERENCES vehicle (vehicleId) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS history (
	historyId		SERIAL PRIMARY KEY,
	bookingId		INT,
	checkPoint		TIMESTAMP,
	status			STATUS,
	FOREIGN KEY (bookingId) REFERENCES booking (bookingId) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS transaction (
	transactionId	SERIAL PRIMARY KEY,
	bookingId		INT,
	employeeId		INT,
	totalFee		INT,
	FOREIGN KEY (bookingId) REFERENCES booking (bookingId) ON DELETE CASCADE,
	FOREIGN KEY (employeeId) REFERENCES employee (employeeId) ON DELETE CASCADE
);

INSERT INTO customer (username, password, fullName, email, phoneNumber)
VALUES 
	('john_doe', 'password123', 'John Doe', 'john.doe@email.com', '123-456-7890'),
	('jane_smith', 'securePass', 'Jane Smith', 'jane.smith@email.com', '987-654-3210'),
	('alice_wonder', 'secretPassword', 'Alice Wonderland', 'alice@email.com', '555-123-4567'),
	('bob_jones', '1234pass', 'Bob Jones', 'bob@email.com', '777-888-9999'),
	('lisa_davis', 'strongPassword', 'Lisa Davis', 'lisa@email.com', '111-222-3333');

INSERT INTO employee (password, username, fullName)
VALUES 
	('admin123', 'admin', 'Candra Gun'),
	('password123', 'jokowi', 'Joko Widodo'),
	('securePass', 'mega', 'Megawati Soekarnoputri'),
	('secretPassword', 'sby', 'Susilo Bambang Yudhoyono'),
	('1234pass', 'jusuf', 'Jusuf Kalla'),
	('strongPassword', 'prabowo', 'Prabowo Subianto');

INSERT INTO vehicle (customerId, driver, brandType, color, policeNumber)
VALUES 
	(1, 'John Doe', 'Toyota Camry', 'Blue', 'ABC123'),
	(2, 'Jane Smith', 'Honda Civic', 'Red', 'XYZ789'),
	(3, 'Alice Wonderland', 'Ford Focus', 'Green', 'DEF456'),
	(4, 'Bob Jones', 'Chevrolet Malibu', 'Silver', 'GHI789'),
	(5, 'Lisa Davis', 'Nissan Altima', 'Black', 'JKL012'),
	(5, 'Luca', 'Hyundai Elantra', 'Silver', 'JWE065');

INSERT INTO booking (customerId, vehicleId, bookingdate, status, baseFee)
VALUES 
	(1, 1, '2023-11-01 14:00:00', 'booked', 3000),
	(2, 2, '2023-11-01 15:00:00', 'booked', 3000),
	(3, 3, '2023-11-01 16:00:00', 'booked', 3000),
	(3, 3, '2023-11-01 17:00:01', 'canceled', 3000),
	(4, 4, '2023-11-01 18:00:00', 'booked', 3000),
	(5, 6, '2023-11-01 18:10:00', 'booked', 3000),
	(1, 1, '2023-11-01 19:10:00', 'booked', 3000);

INSERT INTO history (bookingId, checkPoint, status)
VALUES 
	(1, '2023-11-01 14:30:00', 'check in'),
	(2, '2023-11-01 15:30:00', 'check in'),
	(4, '2023-11-01 18:10:00', 'check in'),
	(1, '2023-11-01 19:00:00', 'check out'),
	(5, '2023-11-01 19:05:00', 'check in'),
	(4, '2023-11-01 19:30:00', 'check out'),
	(5, '2023-11-01 19:40:00', 'check out'),
	(2, '2023-11-01 20:00:00', 'check out'),
	(1, '2023-11-01 19:15:00', 'check in');

INSERT INTO transaction (bookingId, employeeId, totalFee)
VALUES 
(1, 1, 15000),
(4, 1, 6000),
(5, 1, 3000),
(2, 1, 15000);

-- DML

SELECT * FROM customer;
SELECT * FROM employee;
SELECT * FROM vehicle;
SELECT * FROM booking;
SELECT * FROM history;
SELECT * FROM transaction;