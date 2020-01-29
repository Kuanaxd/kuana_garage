-- --------------------------------------------------------
-- Anfitrião:                    127.0.0.1
-- Versão do servidor:           10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Versão:              10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for essentialmode
CREATE DATABASE IF NOT EXISTS `essentialmode` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `essentialmode`;

-- Dumping structure for table essentialmode.owned_vehicles
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(22) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'State of the car',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) NOT NULL,
  `x` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `y` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `z` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `h` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0',
  `health` int(11) DEFAULT 0,
  `nitro` varchar(50) NOT NULL DEFAULT 'nao',
  `lockcheck` varchar(50) NOT NULL DEFAULT 'nao',
  `lastid` int(20) DEFAULT NULL,
  `lasthouse` int(11) DEFAULT 0,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table essentialmode.owned_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `owned_vehicles` DISABLE KEYS */;
INSERT INTO `owned_vehicles` (`owner`, `state`, `plate`, `vehicle`, `type`, `job`, `x`, `y`, `z`, `h`, `health`, `nitro`, `lockcheck`, `lastid`, `lasthouse`) VALUES
	('steam:11000010c41d185', 0, 'EXX201', '{"modSuspension":-1,"modDashboard":-1,"modOrnaments":-1,"modBrakes":-1,"modHydrolic":-1,"modXenon":false,"modStruts":-1,"extras":[],"modWindows":-1,"modAirFilter":-1,"wheelColor":156,"modAPlate":-1,"plate":"EXX201","neonColor":[255,0,255],"modVanityPlate":-1,"wheels":1,"modEngine":-1,"tyres":[false,false,false,false,false,false,false],"modFrame":-1,"fuelLevel":55.474201202393,"pearlescentColor":0,"modSideSkirt":-1,"modFrontWheels":-1,"color2":95,"plateIndex":0,"modBackWheels":-1,"modExhaust":-1,"modRightFender":-1,"modShifterLeavers":-1,"modTrimA":-1,"modTransmission":-1,"modHorns":-1,"windowTint":-1,"tyreSmokeColor":[255,255,255],"modTank":-1,"health":1000,"modPlateHolder":-1,"modHood":-1,"modTrunk":-1,"neonEnabled":[false,false,false,false],"modFrontBumper":-1,"modTrimB":-1,"doors":[false,false,false,false,false,false],"dirtLevel":4.4071135520935,"modSteeringWheel":-1,"modSpoilers":-1,"modRoof":-1,"modArchCover":-1,"modSpeakers":-1,"color1":93,"modAerials":-1,"model":-1205801634,"modSmokeEnabled":1,"modFender":-1,"modArmor":-1,"modDial":-1,"modEngineBlock":-1,"modGrille":-1,"modSeats":-1,"modDoorSpeaker":-1,"modTurbo":false,"modRearBumper":-1,"modLivery":-1,"windows":[1,1,1,false,false,1,1,1,1,1,1,false,1]}', 'car', '', '-339.97256469726563', '6206.998046875', '30.687292098999023', '326.5118408203125', 1000, 'nao', 'sim', NULL, 0);
/*!40000 ALTER TABLE `owned_vehicles` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
