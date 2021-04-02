/* Практическое задание #5. */

/* Операторы, фильтрация, сортировка и ограничение */

/* Задание # 1.
 * Пусть в таблице users поля created_at и updated_at оказались незаполненными.
 *  Заполните их текущими датой и временем.
*/
USE shop;

-- Измениние столбцов created_at и updated_at
-- 1
UPDATE users 
SET created_at = NOW(), updated_at = NOW()
WHERE id = 1;
-- 2
UPDATE users 
SET created_at = NOW(), updated_at = NOW()
WHERE id = 2;
-- 3
UPDATE users 
SET created_at = NOW(), updated_at = NOW()
WHERE id = 3;
-- 4
UPDATE users 
SET created_at = NOW(), updated_at = NOW()
WHERE id = 4;
-- 5
UPDATE users 
SET created_at = NOW(), updated_at = NOW()
WHERE id = 5;
-- 6
UPDATE users 
SET created_at = NOW(), updated_at = NOW()
WHERE id = 6;

/* Задание # 2.
 * Таблица users была неудачно спроектирована.
 * Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10.
 * Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.
*/
-- Изменение формата для created_at
ALTER TABLE users MODIFY created_at DATETIME;
-- Изменение формата для updated_at
ALTER TABLE users MODIFY updated_at DATETIME;

/* Задание # 3.
 * В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0,
 *  если товар закончился и выше нуля, если на складе имеются запасы.
 *  Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value.
 * Однако нулевые запасы должны выводиться в конце, после всех записей.
*/
INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, 543, 0),
  (1, 789, 2500),
  (1, 3432, 0),
  (1, 826, 30),
  (1, 719, 500),
  (1, 638, 1);

SELECT id, storehouse_id, product_id, value, created_at, created_at, updated_at
FROM storehouses_products
ORDER BY value; -- Не понял как отобразить "Однако нулевые запасы должны выводиться в конце, после всех записей."

/* Агрегация данных */

/* Задание # 1.
 * Подсчитайте средний возраст пользователей в таблице users.
*/
-- Создание таблицы age
CREATE TABLE age (
id SERIAL PRIMARY KEY,
users_age BIGINT,
users_birthday_at DATE
);
-- Перенос дат
INSERT INTO age (id, users_birthday_at)
SELECT id, birthday_at
FROM users ;
-- Подсчет и запись колтчества лет пользователей
UPDATE age 
SET users_age = (TO_DAYS(NOW()) - TO_DAYS(users_birthday_at)) / 365.25
WHERE id;
-- Вывод среднего количества лет
SELECT ((SUM(users_age)) / 6) AS average
FROM age;

/* Задание # 2.
 * Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
 *  Следует учесть, что необходимы дни недели текущего года, а не года рождения.
*/
DROP TABLE birthday;
CREATE TABLE birthday(
id SERIAL PRIMARY KEY,
date_birthday DATE
);

INSERT INTO birthday (id, date_birthday)
SELECT id, birthday_at
FROM users ;

UPDATE birthday 
SET date_birthday = DATE_FORMAT(date_birthday, '%m%d')
WHERE id;

SELECT DAYNAME(birthday_at) birthday
FROM users;
