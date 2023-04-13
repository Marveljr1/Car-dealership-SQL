CREATE TABLE salesperson(
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	department VARCHAR(25) NOT NULL
);

CREATE TABLE cars(
	car_id SERIAL PRIMARY KEY,
	serial_number INTEGER NOT NULL,
	make VARCHAR NOT NULL,
	model VARCHAR NOT NULL,
	"year" INTEGER NOT NULL,
	color VARCHAR NOT NULL,
	status VARCHAR NOT NULL,
	car_price NUMERIC(8,2),
	employee_id INTEGER NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES salesperson(employee_id)
);

CREATE TABLE invoice(
	invoice_id SERIAL PRIMARY KEY,
	purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	sale_car_id INTEGER NOT NULL,
	FOREIGN KEY(car_id) REFERENCES cars(car_id),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	employee_id INTEGER NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES salesperson(employee_id)
);

CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25) NOT NULL,
	phone_number VARCHAR(15),
	email VARCHAR(50)
);

CREATE TABLE service(
	service_car_id SERIAL PRIMARY KEY,
	serial_number VARCHAR NOT NULL,
	make VARCHAR NOT NULL,
	model VARCHAR NOT NULL,
	"year" INTEGER NOT NULL,
	color VARCHAR NOT NULL,
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE service_ticket(
	ticket_id SERIAL PRIMARY KEY,
	service_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	employee_id INTEGER NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES employee(employee_id),
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	service_car_id INTEGER NOT NULL,
	FOREIGN KEY(service_car_id) REFERENCES car_for_service(service_car_id)
);

CREATE TABLE service_record(
	customer_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	ticket_id INTEGER NOT NULL,
	FOREIGN KEY(ticket_id) REFERENCES service_ticket(ticket_id),
	employee_id INTEGER NOT NULL,
	FOREIGN key(employee_id) REFERENCES salesperson(employee_id),
	service_car_id INTEGER NOT NULL,
	FOREIGN KEY(service_car_id) REFERENCES service(service_car_id) 
);

-- Inserts the employee information to the employee table
INSERT INTO employee(
	first_name,
	last_name,
	department 
)VALUES (
	'Terry',
	'King',
	'Sales'
);

INSERT INTO employee(
	first_name,
	last_name,
	department 
)VALUES (
	'Micheal',
	'Jackson',
	'Sales'
);

--Customer Procedure
CREATE OR REPLACE PROCEDURE add_customer(
	first_name VARCHAR, 
	last_name VARCHAR, 
	phone_number VARCHAR(15), 
	email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO customer(first_name, last_name, phone_number, email)
	values(first_name, last_name, phone_number, email);
END;
$$;

-- Add Customer
CALL add_customer('Kang', 'Conqueror', '(111) 111-1111', 'Kang@Conqueror.com');

CALL add_customer('Dave', 'Franco', '(222) 222-2222', 'David@franco.com' );

SELECT *
FROM customer 

-- cars procedure
CREATE OR REPLACE PROCEDURE add_car_sale(
	serial_number VARCHAR,	
	make VARCHAR,
	model VARCHAR,
	"year" INTEGER,
	color VARCHAR,
	status VARCHAR,
	car_price NUMERIC(8,2)
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO cars(serial_number, make, model, "year", color, status, car_price)
	VALUES(serial_number, make, model, "year", color, status, car_price);
END;
$$;

--Cars information
CALL add_cars('A56D4F6A4', 'Dodge', 'Highlander', 2018, 'Silver', 'SOLD', 50,000);
CALL add_cars('A6DFA12DF', 'Chevy', 'Equinox', 2019, 'Black', 'AVAILABLE', 60,000);
CALL add_cars('FEA2F1A5D', 'Jeep', 'Cherokee', 2006, 'Black', 'AVAILABLE', 40,000); 
CALL add_cars('4A65D1F2D', 'Fiat', 'Smallcar', 2021, 'Blue', 'SOLD', 30,000);
CALL add_cars('A65D4F41A1', 'Jeep', 'Wrangler', 2018, 'Black', 'AVAILABLE', 50,000);
CALL add_cars('A94F3A21', 'Tesla', 'Model x', 2020, 'Green', 'SOLD', 30,000);

SELECT *
FROM cars;