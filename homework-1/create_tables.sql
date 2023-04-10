-- SQL-команды для создания таблиц
CREATE TABLE employees
(
	employee_id INT PRIMARY KEY,
	first_name VARCHAR(10) NOT NULL,
	last_name VARCHAR(10) NOT NULL,
	title VARCHAR(30),
	birth_date DATE,
	notes text
);

CREATE TABLE customers
(
	customer_id VARCHAR(5) PRIMARY KEY,
	company_name VARCHAR(255),
	contact_name VARCHAR(255)
);

CREATE TABLE orders
(
	order_id INT PRIMARY KEY,
	customer_id VARCHAR(5) REFERENCES customers(customer_id),
	employee_id INT REFERENCES employees(employee_id) NOT NULL,
	order_date DATE,
	ship_city VARCHAR(20)
);
