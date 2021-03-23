/* Практическое задание #3. */

/* Задание # 2.
 * Придумать 2-3 таблицы для БД vk, которую мы создали на занятии 
 * (с перечнем полей, указанием индексов и внешних ключей). Прислать результат в виде скрипта *.sql.
*/
-- Создание таблицы образование
CREATE TABLE education (
 user_id BIGINT UNSIGNED NOT NULL,
 school VARCHAR(245) DEFAULT NULL,
 university VARCHAR(245) DEFAULT NULL,
 INDEX fk_education_users_idx (user_id),
 CONSTRAINT fk_education_users FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Создание таблицы черный список
CREATE TABLE black_list(
 user_send_to_id BIGINT UNSIGNED NOT NULL,
 user_departing_to_id BIGINT UNSIGNED NOT NULL,
 INDEX fk_user_send_to_idx (user_send_to_id),
 INDEX fk_user_departing_to_idx (user_departing_to_id),
 CONSTRAINT fk_user_send_to FOREIGN KEY (user_send_to_id) REFERENCES users (id),
 CONSTRAINT fk_user_departing_to FOREIGN KEY (user_departing_to_id) REFERENCES users (id)
);
