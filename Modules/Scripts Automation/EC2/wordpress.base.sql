CREATE DATABASE Wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'wp7102#56';
GRANT ALL ON Wordpress.* TO 'wp_user'@'localhost';