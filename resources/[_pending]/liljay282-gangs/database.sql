CREATE TABLE `zones` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`gang` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `gangs` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`leader` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`members` LONGTEXT NOT NULL COLLATE 'utf8mb4_general_ci',
	`money` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;