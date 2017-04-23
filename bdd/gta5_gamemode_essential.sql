-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Sam 22 Avril 2017 à 08:38
-- Version du serveur :  5.7.14
-- Version de PHP :  5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gta5_gamemode_essential`
--

-- --------------------------------------------------------

--
-- Structure de la table `bans`
--

CREATE TABLE `bans` (
  `id` int(10) UNSIGNED NOT NULL,
  `banned` varchar(50) NOT NULL DEFAULT '0',
  `banner` varchar(50) NOT NULL,
  `reason` varchar(150) NOT NULL DEFAULT '0',
  `expires` datetime NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `job_id` int(11) NOT NULL,
  `job_name` varchar(40) NOT NULL,
  `salary` int(11) NOT NULL DEFAULT '500'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `jobs`
--

INSERT INTO `jobs` (`job_id`, `job_name`, `salary`) VALUES
(1, 'Chomeur', 500),
(2, 'Policier', 1200),
(3, 'Pompier', 1200),
(4, 'Mineur', 700),
(5, 'Chauffeur de taxi', 1000);

-- --------------------------------------------------------

--
-- Structure de la table `outfits`
--

CREATE TABLE `outfits` (
  `identifier` varchar(50) DEFAULT NULL,
  `hair` int(11) DEFAULT NULL,
  `haircolour` int(11) DEFAULT NULL,
  `torso` int(11) DEFAULT NULL,
  `torsotexture` int(11) DEFAULT NULL,
  `torsoextra` int(11) DEFAULT NULL,
  `torsoextratexture` int(11) DEFAULT NULL,
  `pants` int(11) DEFAULT NULL,
  `pantscolour` int(11) DEFAULT NULL,
  `shoes` int(11) DEFAULT NULL,
  `shoescolour` int(11) DEFAULT NULL,
  `bodyaccesoire` int(11) DEFAULT NULL,
  `undershirt` int(11) DEFAULT NULL,
  `armor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `personalvehicle`
--

CREATE TABLE `personalvehicle` (
  `id` int(11) NOT NULL,
  `owner` varchar(255) NOT NULL DEFAULT '0',
  `vehicle` varchar(255) NOT NULL DEFAULT '0',
  `colorp` varchar(255) NOT NULL DEFAULT '0',
  `colors` varchar(255) NOT NULL DEFAULT '0',
  `auto_upgrade` int(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(255) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `group` varchar(50) NOT NULL DEFAULT '0',
  `permission_level` int(11) NOT NULL DEFAULT '0',
  `money` double NOT NULL DEFAULT '0',
  `personalvehicle` varchar(255) NOT NULL DEFAULT 'faggio2',
  `bankbalance` int(32) DEFAULT '0',
  `job` int(11) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_vehicle`
--

CREATE TABLE `user_vehicle` (
  `ID` int(10) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `vehicle_model` varchar(60) DEFAULT NULL,
  `vehicle_plate` varchar(60) DEFAULT NULL,
  `vehicle_state` varchar(60) DEFAULT NULL,
  `vehicle_colorsecondary` varchar(60) DEFAULT NULL,
  `vehicle_colorprimary` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_weapons`
--

CREATE TABLE `user_weapons` (
  `ID` int(10) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `weapon_model` varchar(60) NOT NULL,
  `withdraw_cost` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `bans`
--
ALTER TABLE `bans`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`job_id`);

--
-- Index pour la table `personalvehicle`
--
ALTER TABLE `personalvehicle`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- Index pour la table `user_vehicle`
--
ALTER TABLE `user_vehicle`
  ADD PRIMARY KEY (`ID`);

--
-- Index pour la table `user_weapons`
--
ALTER TABLE `user_weapons`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `bans`
--
ALTER TABLE `bans`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `job_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `personalvehicle`
--
ALTER TABLE `personalvehicle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `user_vehicle`
--
ALTER TABLE `user_vehicle`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT pour la table `user_weapons`
--
ALTER TABLE `user_weapons`
  MODIFY `ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
