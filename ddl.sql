CREATE DATABASE IF NOT EXISTS `db-movies`;
USE `db-movies`;

CREATE TABLE IF NOT EXISTS movie (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  synopsis VARCHAR(1000),
  rating INT,
  release_date DATE
);
