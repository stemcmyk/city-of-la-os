CREATE TABLE IF NOT EXISTS `stem_combatlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` 
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial` (`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;