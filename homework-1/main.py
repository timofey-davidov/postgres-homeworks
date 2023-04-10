"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv


with open("north_data/employees_data.csv", newline='') as csv_file:
    reader = csv.DictReader(csv_file, delimiter=",")
    conn = psycopg2.connect(host="localhost", database="north", user="postgres", password="123456")
    cur = conn.cursor()
    counter = 0
    for row in reader:
        counter += 1
        cur.execute("INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)",
                    (counter, row["first_name"], row["last_name"], row["title"], row["birth_date"], row["notes"]))
        conn.commit()
    cur.close()
    conn.close()

with open("north_data/customers_data.csv", newline='') as csv_file:
    reader = csv.DictReader(csv_file, delimiter=",")
    conn = psycopg2.connect(host="localhost", database="north", user="postgres", password="123456")
    cur = conn.cursor()
    for row in reader:
        cur.execute("INSERT INTO customers VALUES (%s, %s, %s)",
                    (row["customer_id"], row["company_name"], row["contact_name"]))
        conn.commit()
    cur.close()
    conn.close()

with open("north_data/orders_data.csv", newline='') as csv_file:
    reader = csv.DictReader(csv_file, delimiter=",")
    conn = psycopg2.connect(host="localhost", database="north", user="postgres", password="123456")
    cur = conn.cursor()
    for row in reader:
        cur.execute("INSERT INTO orders VALUES (%s, %s, %s, %s, %s)",
                    (row["order_id"], row["customer_id"], row["employee_id"], row["order_date"], row["ship_city"]))
        conn.commit()
    cur.close()
    conn.close()


