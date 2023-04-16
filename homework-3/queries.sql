-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT c.company_name AS НАЗВАНИЕ_КОМПАНИИ,
       CONCAT(e.first_name, ' ', e.last_name) AS ИМЯ_ФАМИЛИЯ_СОТРУДНИКА,
       /* Для дополнительной проверки в явном виде вывел поля для фильтрации*/
       c.city AS ГОРОД_РЕГИСТРАЦИИ_ЗАКАЗЧИКА,
       e.city AS ГОРОД_РЕГИСТРАЦИИ_СОТРУДНИКА,
       s.company_name AS КОМПАНИЯ_ДОСТАВЩИК
FROM orders AS o
JOIN customers AS c USING(customer_id)
JOIN employees AS e USING(employee_id)
JOIN shippers AS s ON o.ship_via = s.shipper_id
WHERE e.city = 'London' and c.city = 'London' and s.company_name = 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT p.product_name AS НАИМЕНОВАНИЕ_ПРОДУКТА,
       p.units_in_stock AS В_НАЛИЧИИ_ШТ,
       s.contact_name AS ПОСТАВЩИК,
       s.phone AS ТЕЛЕФОН,
       /* Для дополнительной проверки в явном виде вывел поля для фильтрации*/
       c.category_name AS КАТЕГОРИЯ_ПРОДУКТА,
       p.discontinued AS СНЯТ_С_ПРОДАЖИ
FROM products AS p
JOIN suppliers AS s USING(supplier_id)
JOIN categories AS c USING(category_id)
WHERE p.discontinued <> 1 AND p.units_in_stock < 25 and c.category_name in ('Dairy Products', 'Condiments')
ORDER BY p.units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT c.company_name AS НАЗВАНИЕ_КОМПАНИИ,
       /* Для дополнительной проверки в явном виде вывел поля с айдишником заказа (если заказа нет, то айдишник NULL)*/
       o.order_id AS НОМЕР_ЗАКАЗА
FROM customers AS c
LEFT JOIN orders AS o USING(customer_id)
WHERE o.order_id IS NULL

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT p.product_name AS НАЗВАНИЕ_ПРОДУКТА
FROM products AS p
WHERE p.product_id = ANY(SELECT od.product_id FROM order_details AS od WHERE od.quantity = 10)
