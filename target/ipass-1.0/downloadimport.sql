DROP TABLE IF EXISTS `user`;
        
CREATE TABLE `user` (
  `name` VARCHAR(32) NOT NULL,
  `password` VARCHAR(256) NOT NULL,
  `avatar` VARCHAR(256) NULL DEFAULT NULL,
  `about` TEXT NULL DEFAULT NULL,
  `role` INTEGER(2) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `level`;
        
CREATE TABLE `level` (
  `filename` VARCHAR(32) NOT NULL,
  `user_name` VARCHAR(32) NOT NULL,
  `title` VARCHAR(128) NOT NULL,
  `description` TEXT NOT NULL,
  `version` VARCHAR(32) NOT NULL,
  `history` VARCHAR(256) NULL DEFAULT NULL,
  `game` VARCHAR(256) NOT NULL,
  `gametype` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
  `rid` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `level_filename` VARCHAR(32) NOT NULL,
  `user_name` VARCHAR(32) NOT NULL,
  `feedback` TEXT NOT NULL,
  `graphic_rating` INTEGER(1) NOT NULL,
  `technical_rating` INTEGER(1) NOT NULL,
  `gametype_ratings` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `level` ADD FOREIGN KEY (user_name) REFERENCES `user` (`name`);
ALTER TABLE `review` ADD FOREIGN KEY (level_filename) REFERENCES `level` (`filename`);
ALTER TABLE `review` ADD FOREIGN KEY (user_name) REFERENCES `user` (`name`);