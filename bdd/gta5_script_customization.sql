-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Sam 22 Avril 2017 à 08:39
-- Version du serveur :  5.7.14
-- Version de PHP :  5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gta5_script_customization`
--

-- --------------------------------------------------------

--
-- Structure de la table `outfits`
--

CREATE TABLE `outfits` (
  `identifier` varchar(50) NOT NULL,
  `hair` int(11) NOT NULL,
  `haircolour` int(11) NOT NULL,
  `torso` int(11) NOT NULL,
  `torsotexture` int(11) NOT NULL,
  `torsoextra` int(11) NOT NULL,
  `torsoextratexture` int(11) NOT NULL,
  `pants` int(11) NOT NULL,
  `pantscolour` int(11) NOT NULL,
  `shoes` int(11) NOT NULL,
  `shoescolour` int(11) NOT NULL,
  `bodyaccesoire` int(11) NOT NULL,
  `undershirt` int(11) NOT NULL,
  `armor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `outfits`
--
ALTER TABLE `outfits`
  ADD PRIMARY KEY (`identifier`,`hair`,`haircolour`,`torso`,`torsotexture`,`torsoextra`,`torsoextratexture`,`pants`,`pantscolour`,`shoes`,`shoescolour`,`bodyaccesoire`,`undershirt`,`armor`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
