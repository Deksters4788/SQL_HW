/* Практическое задание #4. */

/* Задание # 3.
 * Написать запрос для переименования названий типов медиа (колонка name в media_types)
 * в осмысленные для полученного дампа с данными (например, в "фото", "видео", ...).
*/
-- Запрос на смену первого типа
UPDATE media_types 
SET name = 'Photo'
WHERE id = 1;
-- Запрос на смену второго типа
UPDATE media_types 
SET name = 'Video'
WHERE id = 2;
-- Запрос на смену третьего типа
UPDATE media_types 
SET name = 'Audio'
WHERE id = 3;
-- Запрос на смену четвертого типа
UPDATE media_types 
SET name = 'Clip'
WHERE id = 4;