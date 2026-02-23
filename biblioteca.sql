-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-02-2026 a las 17:16:25
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor`
--

CREATE TABLE `autor` (
  `AUT_COD` int(11) NOT NULL,
  `AUT_APELLIDO` varchar(45) NOT NULL,
  `AUT_NACIMIENTO` date NOT NULL,
  `AUT_FALLECIMIENTO` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `autor`
--

INSERT INTO `autor` (`AUT_COD`, `AUT_APELLIDO`, `AUT_NACIMIENTO`, `AUT_FALLECIMIENTO`) VALUES
(98, 'Smith', '1974-12-21', '2018-07-21'),
(123, 'Taylor', '1980-04-15', '0000-00-00'),
(234, 'Medina', '1977-06-21', '2005-09-12'),
(345, 'Wilson', '1975-08-29', '0000-00-00'),
(432, 'Miller', '1981-10-26', '0000-00-00'),
(456, 'Garcia', '1978-09-27', '2021-12-09'),
(567, 'Davis', '1983-03-04', '2010-03-28'),
(678, 'Silva', '1986-02-02', '0000-00-00'),
(765, 'López', '1976-07-08', '2024-07-08'),
(789, 'Rodriguez', '1985-12-10', '0000-00-00'),
(890, 'Brown', '1982-11-17', '0000-00-00'),
(901, 'Soto', '1979-05-13', '2015-11-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `LIB_ISBN` bigint(20) NOT NULL,
  `LIB_TITULO` varchar(255) NOT NULL,
  `LIB_GENERO` varchar(20) NOT NULL,
  `NUM_PAGINAS` int(11) NOT NULL,
  `DIAS_PRESTAMO` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libro`
--

INSERT INTO `libro` (`LIB_ISBN`, `LIB_TITULO`, `LIB_GENERO`, `NUM_PAGINAS`, `DIAS_PRESTAMO`) VALUES
(1234567890, 'El Sueño de los Susurros', 'novela', 275, 7),
(1357924680, 'El Jardín de las Mariposas Perdidas', 'novela', 536, 7),
(2468135790, 'La Melodía de la Oscuridad', 'romance', 189, 7),
(2718281828, 'El Bosque de los Suspiros', 'novela', 387, 2),
(3141592653, 'El Secreto de las Estrellas Olvidadas', 'Misterio', 203, 7),
(5555555555, 'La Última Llave del Destino', 'cuento', 503, 7),
(7777777777, 'El Misterio de la Luna Plateada', 'Misterio', 422, 7),
(8642097531, 'El Reloj de Arena Infinito', 'novela', 321, 7),
(8888888888, 'La Ciudad de los Susurros', 'Misterio', 274, 1),
(9517530862, 'Las Crónicas del Eco Silencioso', 'fantasía', 448, 7),
(9876543210, 'El Laberinto de los Recuerdos', 'cuento', 412, 7),
(9999999999, 'La Última Llave del Destino', 'romance', 156, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `PRES_ID` varchar(20) NOT NULL,
  `PRES_FPRESTAMO` date DEFAULT NULL,
  `PRES_FDEVOLUCION` date DEFAULT NULL,
  `COPIA_NUMERO` int(11) NOT NULL,
  `COPIA_ISBN` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamo`
--

INSERT INTO `prestamo` (`PRES_ID`, `PRES_FPRESTAMO`, `PRES_FDEVOLUCION`, `COPIA_NUMERO`, `COPIA_ISBN`) VALUES
('pres1', '2023-01-15', '2023-01-20', 1, 1234567890),
('pres2', '2023-02-03', '2023-02-04', 2, 9999999999),
('pres3', '2023-04-09', '2023-04-11', 6, 2718281828),
('pres4', '2023-06-14', '2023-06-15', 9, 8888888888),
('pres5', '2023-07-02', '2023-07-09', 10, 5555555555),
('pres6', '2023-08-19', '2023-08-26', 12, 5555555555),
('pres7', '2023-10-24', '2023-10-27', 3, 1357924680);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE `socio` (
  `SOC_NUMERO` int(11) NOT NULL,
  `SOC_NOMBRE` varchar(45) NOT NULL,
  `SOC_APELLIDO` varchar(45) NOT NULL,
  `SOC_DIRECCION` varchar(45) NOT NULL,
  `SOC_TELEFONO` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `socio`
--

INSERT INTO `socio` (`SOC_NUMERO`, `SOC_NOMBRE`, `SOC_APELLIDO`, `SOC_DIRECCION`, `SOC_TELEFONO`) VALUES
(1, 'Ana ', 'Ruiz ', 'Calle Primavera 123, Ciudad Jardín, Barcelona', '9123456780'),
(2, 'Andrés Felipe', 'Galindo Luna', ' Avenida del Sol 456, Pueblo Nuevo, Madrid', '2123456789'),
(3, 'Juan ', 'González ', 'Calle Principal 789, Villa Flores, Valencia ', '2012345678'),
(4, 'María', 'Rodríguez ', 'Carrera del Río 321, El Pueblo, Sevilla', '3012345678'),
(5, 'Pedro ', 'Martínez ', 'Calle del Bosque 654, Los Pinos, Málaga ', '1234567812'),
(6, 'Ana ', 'López ', 'Avenida Central 987, Villa Hermosa, Bilbao ', '6123456781'),
(7, 'Carlos ', 'Sánchez', 'Calle de la Luna 234, El Prado, Alicante ', '1123456781'),
(8, 'Laura ', 'Ramírez ', 'Carrera del Mar 567, Playa Azul, Palma de Mal', '1312345678'),
(9, 'Luis ', 'Hernández', 'Avenida de la Montaña 890, Monte Verde, Grana', '6101234567'),
(10, 'Andrea ', 'García ', 'Calle del Sol 432, La Colina, Zaragoza ', '1112345678'),
(11, 'Alejandro ', 'Torres ', 'Carrera del Oeste 765, Ciudad Nueva, Murcia ', '4951234567'),
(12, 'Sofia ', 'Morales ', 'Avenida del Mar 098, Costa Brava, Gijón', '5512345678');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoautores`
--

CREATE TABLE `tipoautores` (
  `COPIA_ISBNN` bigint(20) NOT NULL,
  `COPIA_AUTOR` int(11) NOT NULL,
  `TIP_AUTOR` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipoautores`
--

INSERT INTO `tipoautores` (`COPIA_ISBNN`, `COPIA_AUTOR`, `TIP_AUTOR`) VALUES
(1357924680, 123, 'Traductor'),
(1234567890, 123, 'Autor'),
(1234567890, 456, 'Coautor'),
(2718281828, 789, 'Traductor'),
(8888888888, 234, 'Autor'),
(2468135790, 234, 'Autor'),
(9876543210, 567, 'Autor'),
(1234567890, 890, 'Autor'),
(8642097531, 345, 'Autor'),
(8888888888, 345, 'Coautor'),
(5555555555, 678, 'Autor'),
(3141592653, 901, 'Autor'),
(9517530862, 432, 'Autor'),
(7777777777, 765, 'Autor'),
(9999999999, 98, 'Autor');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`AUT_COD`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`LIB_ISBN`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`PRES_ID`),
  ADD KEY `COPIA_NUMERO` (`COPIA_NUMERO`),
  ADD KEY `COPIA_ISBN` (`COPIA_ISBN`);

--
-- Indices de la tabla `socio`
--
ALTER TABLE `socio`
  ADD PRIMARY KEY (`SOC_NUMERO`);

--
-- Indices de la tabla `tipoautores`
--
ALTER TABLE `tipoautores`
  ADD KEY `COPIA_ISBNN` (`COPIA_ISBNN`),
  ADD KEY `COPIA_AUTOR` (`COPIA_AUTOR`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`COPIA_NUMERO`) REFERENCES `socio` (`SOC_NUMERO`),
  ADD CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`COPIA_ISBN`) REFERENCES `libro` (`LIB_ISBN`);

--
-- Filtros para la tabla `tipoautores`
--
ALTER TABLE `tipoautores`
  ADD CONSTRAINT `tipoautores_ibfk_1` FOREIGN KEY (`COPIA_ISBNN`) REFERENCES `libro` (`LIB_ISBN`),
  ADD CONSTRAINT `tipoautores_ibfk_2` FOREIGN KEY (`COPIA_AUTOR`) REFERENCES `autor` (`AUT_COD`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
