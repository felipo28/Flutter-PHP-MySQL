-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 16, 2022 at 04:00 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `proyectoandroid`
--

-- --------------------------------------------------------

--
-- Table structure for table `materiaxestudiante`
--

CREATE TABLE `materiaxestudiante` (
  `cedulaEStu` int(12) DEFAULT NULL,
  `idMateria` int(12) DEFAULT NULL,
  `id` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `materiaxestudiante`
--

INSERT INTO `materiaxestudiante` (`cedulaEStu`, `idMateria`, `id`) VALUES
(123, 3, 11),
(1098, 3, 18),
(2020, 2, 1),
(2020, 3, 12),
(5050, 3, 13),
(5070, 3, 17),
(6060, 3, 14),
(9090, 1, 2),
(9090, 3, 15),
(1651321, 8, 20),
(42456413, 3, 10),
(52393216, 3, 19),
(1001118440, 3, 16);

-- --------------------------------------------------------

--
-- Table structure for table `tblestudiante`
--

CREATE TABLE `tblestudiante` (
  `nombres` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `cedula` int(11) NOT NULL,
  `genero` varchar(255) NOT NULL,
  `nacionalidad` varchar(255) NOT NULL,
  `fecha_nacimiento` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `celular` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblestudiante`
--

INSERT INTO `tblestudiante` (`nombres`, `apellidos`, `cedula`, `genero`, `nacionalidad`, `fecha_nacimiento`, `direccion`, `celular`) VALUES
('karen', 'Snelly', 123, 'Femenino', 'España', '06/10/2000', 'suba', '111'),
('orlando', 'uribe', 1098, 'Masculino', 'Colombia', '11/08/1950', 'cra 54d # 5', '311'),
('Dariel', 'Vega', 2020, 'Masculino', 'Colombia', '07/01/1998', 'engativa', '315'),
('Dayana', 'Guzman', 5050, 'Femenino', 'España', '06/08/2000', 'calle 25a #105-20', '31465872'),
('santiago', 'rivera', 5070, 'Masculino', 'España', '02/09/1987', 'av 39 # 139 -40', '316230'),
('Michael', 'Rocha', 6060, 'Masculino', 'Colombia', '11/08/1988', 'cra 54a # 134', '311 5922210'),
('Diego', 'Roncancio', 9090, 'Masculino', 'Canada', '04/07/2022', 'casita', '313'),
('Ivonne', 'Sammaca', 1651321, 'Femenino', 'Colombia', '05/08/1998', 'cra 7 # 39-105', '314864511'),
('Juan Esteban', 'Briceo', 42456413, 'Masculino', 'Colombia', '14/04/2002', 'Cra 40', '2147483647'),
('Ivanna', 'Garcia', 52393216, 'Femenino', 'Colombia', '16/03/2000', 'cra 113 # 35 - 106', '313513165'),
('maria', 'guerrero', 1001118440, 'Femenino', 'Colombia', '21/04/2003', 'Cra 101c # 139 - 36', '321545454');

-- --------------------------------------------------------

--
-- Table structure for table `tblmateria`
--

CREATE TABLE `tblmateria` (
  `id_Materia` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `cedula` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblmateria`
--

INSERT INTO `tblmateria` (`id_Materia`, `nombre`, `cedula`) VALUES
(1, 'Matematicas', 1010114567),
(2, 'ingles', 2147483647),
(3, 'Español', 1010),
(4, 'Quimica', 1010),
(5, 'Estadistica', 1010),
(6, 'Ciencias Naturales', 1010),
(7, 'Geografía', 1010),
(8, 'Francés', 1010);

-- --------------------------------------------------------

--
-- Table structure for table `tblnotas`
--

CREATE TABLE `tblnotas` (
  `id_notas` int(11) NOT NULL,
  `primer_parcial` decimal(5,1) NOT NULL,
  `id` int(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblnotas`
--

INSERT INTO `tblnotas` (`id_notas`, `primer_parcial`, `id`) VALUES
(1, '4.3', 1),
(2, '4.3', 2),
(1, '1.5', 3),
(1, '3.7', 5),
(2, '3.5', 6),
(12, '4.0', 23),
(12, '4.0', 24),
(12, '4.3', 25),
(12, '3.2', 28),
(12, '2.7', 29),
(14, '1.0', 47),
(19, '1.2', 48),
(11, '1.9', 50),
(11, '3.0', 51);

-- --------------------------------------------------------

--
-- Table structure for table `tblprofesores`
--

CREATE TABLE `tblprofesores` (
  `nombre` varchar(255) NOT NULL,
  `apellidos` varchar(255) NOT NULL,
  `usuario` varchar(255) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `cedula` int(255) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tblprofesores`
--

INSERT INTO `tblprofesores` (`nombre`, `apellidos`, `usuario`, `clave`, `cedula`, `email`) VALUES
('Felipe', 'Macias', 'Fm', '123', 1010, 'felipe@gmail.com'),
('asd', 'asd', 'asdas', 'asd', 255423, 'asdasd'),
('Andres', 'Guerrero', 'Ag', '123', 1010114567, 'pipe@gmail.com'),
('andres', 'guerrero', 'agf', '1010', 1010114568, 'pipe@gmail.com'),
('Ivonne', 'Samaca', 'Ivonsa', '123', 2147483647, 'ivone@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `materiaxestudiante`
--
ALTER TABLE `materiaxestudiante`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `prueba` (`cedulaEStu`,`idMateria`),
  ADD KEY `idMateria` (`idMateria`);

--
-- Indexes for table `tblestudiante`
--
ALTER TABLE `tblestudiante`
  ADD PRIMARY KEY (`cedula`);

--
-- Indexes for table `tblmateria`
--
ALTER TABLE `tblmateria`
  ADD PRIMARY KEY (`id_Materia`),
  ADD KEY `id_Docente` (`cedula`);

--
-- Indexes for table `tblnotas`
--
ALTER TABLE `tblnotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_notas` (`id_notas`);

--
-- Indexes for table `tblprofesores`
--
ALTER TABLE `tblprofesores`
  ADD PRIMARY KEY (`cedula`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `materiaxestudiante`
--
ALTER TABLE `materiaxestudiante`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `tblestudiante`
--
ALTER TABLE `tblestudiante`
  MODIFY `cedula` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001118441;

--
-- AUTO_INCREMENT for table `tblmateria`
--
ALTER TABLE `tblmateria`
  MODIFY `id_Materia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tblnotas`
--
ALTER TABLE `tblnotas`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `tblprofesores`
--
ALTER TABLE `tblprofesores`
  MODIFY `cedula` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2147483648;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `materiaxestudiante`
--
ALTER TABLE `materiaxestudiante`
  ADD CONSTRAINT `materiaxestudiante_ibfk_2` FOREIGN KEY (`idMateria`) REFERENCES `tblmateria` (`id_Materia`),
  ADD CONSTRAINT `materiaxestudiante_ibfk_3` FOREIGN KEY (`cedulaEStu`) REFERENCES `tblestudiante` (`cedula`);

--
-- Constraints for table `tblmateria`
--
ALTER TABLE `tblmateria`
  ADD CONSTRAINT `tblmateria_ibfk_1` FOREIGN KEY (`cedula`) REFERENCES `tblprofesores` (`cedula`);

--
-- Constraints for table `tblnotas`
--
ALTER TABLE `tblnotas`
  ADD CONSTRAINT `tblnotas_ibfk_1` FOREIGN KEY (`id_notas`) REFERENCES `materiaxestudiante` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
