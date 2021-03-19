DROP DATABASE vk;

CREATE DATABASE vk;

USE vk;

CREATE TABLE users (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 first_name VARCHAR(145) NOT NULL, -- COMMENT "Имя",
 last_name VARCHAR(145) NOT NULL,
 email VARCHAR(145) NOT NULL,
 phone INT UNSIGNED NOT NULL,
 password_hash CHAR(65) DEFAULT NULL, -- dfhgjrd -> hash -> catmew
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, -- NOW
 UNIQUE INDEX email_unique (email),
 UNIQUE INDEX phone_unique (phone)
) ENGINE=InnoDB;


CREATE TABLE profiles (
 user_id BIGINT UNSIGNED NOT NULL,
 gender ENUM('f', 'm', 'x') NOT NULL,
 birthday DATE NOT NULL,
 photo_id INT UNSIGNED,
 user_status VARCHAR(30),
 city VARCHAR(130),
 country VARCHAR(130),
 UNIQUE INDEX fk_profiles_users_to_idx (user_id),
 CONSTRAINT fk_profiles_users FOREIGN KEY (user_id) REFERENCES users (id)
);


CREATE TABLE messanges (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,-- 1
 from_user_id BIGINT UNSIGNED NOT NULL,-- id = 1
 to_user_id BIGINT UNSIGNED NOT NULL,-- id = 2
 txt TEXT NOT NULL, -- txt = privet
 is_dilivered boolean DEFAULT FALSE,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 update_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- ON UPDATE COMMENT "Время обновления строки"
 INDEX fk_messanges_from_user_idx (from_user_id),
 INDEX fk_messanges_to_user_idx (to_user_id),
 CONSTRAINT fk_messanger_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
 CONSTRAINT fk_messanger_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);


CREATE TABLE friend_requests (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,-- 1
 from_user_id BIGINT UNSIGNED NOT NULL,-- id = 1
 to_user_id BIGINT UNSIGNED NOT NULL,-- id = 2
 accepted BOOLEAN DEFAULT FALSE,
 INDEX fk_friend_requests_from_user_idx (from_user_id),
 INDEX fk_friend_requests_to_user_idx (to_user_id),
 CONSTRAINT fk_friend_requests_users_1 FOREIGN KEY (from_user_id) REFERENCES users (id),
 CONSTRAINT fk_friend_requests_users_2 FOREIGN KEY (to_user_id) REFERENCES users (id)
);


CREATE TABLE communities (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(145) NOT NULL,
 description VARCHAR(245) DEFAULT NULL,
 admin_id BIGINT UNSIGNED NOT NULL,
 INDEX fk_communities_users_admin_idx (admin_id),
 CONSTRAINT fk_friend_requests_users FOREIGN KEY (admin_id) REFERENCES users (id)
) ENGINE=InnoDB;


CREATE TABLE communities_users (
 community_id BIGINT UNSIGNED NOT NULL,
 user_id BIGINT UNSIGNED NOT NULL,
 created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 PRIMARY KEY (community_id, user_id),
 INDEX fk_communities_users_comm_idx (community_id),
 INDEX fk_communities_users_users_idx (user_id),
 CONSTRAINT fk_communities_users_comm FOREIGN KEY (community_id) REFERENCES communities (id),
 CONSTRAINT fk_communities_users_users FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE=InnoDB;


CREATE TABLE media_types (
 id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 name VARCHAR(45) NOT NULL
) ENGINE=InnoDB;


CREATE TABLE media (
 id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
 user_id BIGINT UNSIGNED NOT NULL,
 media_types_id INT UNSIGNED NOT NULL,
 file_name VARCHAR(245) DEFAULT NULL,
 file_size BIGINT DEFAULT NULL,
 create_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
 INDEX fk_media_media_types_idx (media_types_id),
 INDEX fk_media_users_idx (user_id),
 CONSTRAINT fk_media_media_types FOREIGN KEY (media_types_id) REFERENCES media_types (id),
 CONSTRAINT fk_media_users FOREIGN KEY (user_id) REFERENCES users (id)
);


CREATE TABLE education (
 user_id BIGINT UNSIGNED NOT NULL,
 school VARCHAR(245) DEFAULT NULL,
 university VARCHAR(245) DEFAULT NULL,
 INDEX fk_education_users_idx (user_id),
 CONSTRAINT fk_education_users FOREIGN KEY (user_id) REFERENCES users (id)
);


CREATE TABLE black_list(
 user_send_to_id BIGINT UNSIGNED NOT NULL,
 user_departing_to_id BIGINT UNSIGNED NOT NULL,
 INDEX fk_user_send_to_idx (user_send_to_id),
 INDEX fk_user_departing_to_idx (user_departing_to_id),
 CONSTRAINT fk_user_send_to FOREIGN KEY (user_send_to_id) REFERENCES users (id),
 CONSTRAINT fk_user_departing_to FOREIGN KEY (user_departing_to_id) REFERENCES users (id)
);
