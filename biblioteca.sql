-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 06-04-2026 a las 03:19:16
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

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizar_socio` (IN `p_SOC_NUMERO` INT, IN `p_DIRECCION_N` VARCHAR(255), IN `p_TELEFONO_N` VARCHAR(10))   BEGIN
	UPDATE socio
	SET SOC_DIRECCION=p_DIRECCION_N,
    	SOC_TELEFONO=p_TELEFONO_N
	WHERE SOC_NUMERO=p_SOC_NUMERO;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_libro` (IN `N_LIBRO` VARCHAR(255))   SELECT * FROM libro
WHERE LIB_TITULO=N_LIBRO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_libro` (IN `COPIA_ISBN` BIGINT)   BEGIN
    DECLARE total INT;

    SELECT COUNT(*) INTO total
    FROM prestamo
    WHERE ISBN = COPIA_ISBN;

    IF total = 0 THEN
        DELETE FROM libro
        WHERE LIB_ISBN = COPIA_ISBN;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_leftJoin` ()   SELECT * FROM socio s 
LEFT JOIN prestamo p 
ON s.SOC_NUMERO=p.COPIA_NUMERO$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_listaAutores` ()   SELECT AUT_COD, AUT_APELLIDO
FROM autor
ORDER BY AUT_APELLIDO DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tipoAutor` (`TP` VARCHAR(20))   SELECT AUT_APELLIDO as 'Autor', TIP_AUTOR
FROM autor
INNER JOIN tipoautores
ON AUT_COD=COPIA_AUTOR
WHERE TIP_AUTOR=TP$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_socio` (IN `p_numero` INT(11), IN `p_nombre` VARCHAR(45), IN `p_apellido` VARCHAR(45), IN `p_direccion` VARCHAR(45), IN `p_telefono` VARCHAR(10))   BEGIN
    INSERT INTO `socio` (`SOC_NUMERO`, `SOC_NOMBRE`, `SOC_APELLIDO`, `SOC_DIRECCION`, `SOC_TELEFONO`)
    VALUES (p_numero, p_nombre, p_apellido, p_direccion, p_telefono);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_libro` (`c1_isbn` BIGINT(20), `c2_titulo` VARCHAR(255), `c3_genero` VARCHAR(20), `c4_paginas` INT(11), `c5diaspres` TINYINT(4))   INSERT INTO `libro`(`LIB_ISBN`, `LIB_TITULO`, `LIB_GENERO`, `NUM_PAGINAS`, `DIAS_PRESTAMO`)
VALUES (c1_isbn,c2_titulo,c3_genero, c4_paginas,c5diaspres)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `listar_libros_p` ()   BEGIN
SELECT
l.LIB_TITULO AS 'Título del Libro',
s.SOC_NOMBRE AS 'Nombre del Socio',
s.SOC_APELLIDO AS 'Apellido del Socio',
p.PRES_FPRESTAMO AS 'Fecha de Préstamo'
FROM libro l
INNER JOIN prestamo p ON l.LIB_ISBN= p.COPIA_ISBN
INNER JOIN socio s ON p.COPIA_NUMERO=s.SOC_NUMERO;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `DIAS_PRESTAMO` (`p_isbn` BIGINT(20)) RETURNS INT(11) DETERMINISTIC BEGIN
DECLARE dias INT DEFAULT 0;
SELECT DATEDIFF(PRES_FDEVOLUCION, PRES_FPRESTAMO) INTO dias
FROM prestamo
WHERE COPIA_ISBN = p_isbn
ORDER BY PRES_FPRESTAMO DESC
LIMIT 1;
IF dias IS NULL THEN
SET dias = 0;
END IF;
RETURN dias;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `socios_registrados` () RETURNS INT(11) DETERMINISTIC BEGIN
DECLARE total INT;
SELECT COUNT(*) INTO total FROM socio;

RETURN total;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_autor`
--

CREATE TABLE `audi_autor` (
  `ID_AUDI` int(11) NOT NULL,
  `AUT_COD_OLD` int(11) DEFAULT NULL,
  `AUT_APELLIDO_OLD` varchar(45) DEFAULT NULL,
  `AUT_NACIMIENTO_OLD` date DEFAULT NULL,
  `AUT_FALLECIMIENTO_OLD` date DEFAULT NULL,
  `AUT_FALLECIMIENTO_NEW` date DEFAULT NULL,
  `FECHA_MODIFICACION` datetime DEFAULT NULL,
  `USUARIO` varchar(25) DEFAULT NULL,
  `ACCION` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audi_autor`
--

INSERT INTO `audi_autor` (`ID_AUDI`, `AUT_COD_OLD`, `AUT_APELLIDO_OLD`, `AUT_NACIMIENTO_OLD`, `AUT_FALLECIMIENTO_OLD`, `AUT_FALLECIMIENTO_NEW`, `FECHA_MODIFICACION`, `USUARIO`, `ACCION`) VALUES
(1, 890, 'Brown', '1982-11-17', '0000-00-00', '2026-03-31', '2026-03-31 17:10:29', 'root@localhost', 'ACTUALIZADO'),
(29, 98, 'Smith', '1974-12-21', '2018-07-21', NULL, '2026-04-05 19:34:19', 'root@localhost', 'ELIMINADO');

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

--
-- Disparadores `autor`
--
DELIMITER $$
CREATE TRIGGER `act_autor` BEFORE UPDATE ON `autor` FOR EACH ROW BEGIN 
INSERT INTO audi_autor (
    AUT_COD_OLD ,
	AUT_APELLIDO_OLD ,
	AUT_NACIMIENTO_OLD ,
	AUT_FALLECIMIENTO_OLD,
    AUT_FALLECIMIENTO_NEW,
    FECHA_MODIFICACION,
    USUARIO,
    ACCION
)
 VALUES (
     OLD.AUT_COD,
     OLD.AUT_APELLIDO,
     OLD.AUT_NACIMIENTO,
     OLD.AUT_FALLECIMIENTO,
     NEW.AUT_FALLECIMIENTO,
     NOW(),
     CURRENT_USER, 
     'ACTUALIZADO');
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `del_autor` BEFORE DELETE ON `autor` FOR EACH ROW BEGIN 
INSERT INTO audi_autor (
    AUT_COD_OLD ,
	AUT_APELLIDO_OLD ,
	AUT_NACIMIENTO_OLD ,
	AUT_FALLECIMIENTO_OLD,
    FECHA_MODIFICACION,
    USUARIO,
    ACCION
)
 VALUES (
     OLD.AUT_COD,
     OLD.AUT_APELLIDO,
     OLD.AUT_NACIMIENTO,
     OLD.AUT_FALLECIMIENTO,
     NOW(),
     CURRENT_USER, 
     'ELIMINADO');
END
$$
DELIMITER ;

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
(9788426706, 'sql', 'ingenieria', 384, 15),
(9876543210, 'El Laberinto de los Recuerdos', 'cuento', 412, 7),
(9999999999, 'La Última Llave del Destino', 'romance', 156, 7),
(9788426721006, 'sql', 'ingenieria', 384, 15);

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
('pres10', '2026-02-02', '2026-02-09', 5, 8642097531),
('pres11', '2026-02-20', '2026-02-27', 7, 9517530862),
('pres12', '2026-03-10', '2026-03-17', 4, 7777777777),
('pres8', '2026-01-05', '2026-01-12', 1, 1357924680),
('pres9', '2026-01-18', '2026-01-25', 3, 3141592653);

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
(7, 'Carlos ', 'Sánchez', 'Calle 78 SUR, Bogotá', '3256875451'),
(8, 'Laura ', 'Ramírez ', 'Carrera del Mar 567, Playa Azul, Palma de Mal', '1312345678'),
(9, 'Luis ', 'Hernández', 'Avenida de la Montaña 890, Monte Verde, Grana', '6101234567'),
(10, 'Andrea ', 'García ', 'Calle del Sol 432, La Colina, Zaragoza ', '1112345678'),
(11, 'Alejandro ', 'Torres ', 'Carrera del Oeste 765, Ciudad Nueva, Murcia ', '4951234567'),
(12, 'Sofia ', 'Morales ', 'Avenida del Mar 098, Costa Brava, Gijón', '5512345678'),
(13, 'Carlos', 'Pérez', 'Calle Nueva 100, Bogotá', '3001234567');

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
(7777777777, 765, 'Autor');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_libros_autores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_libros_autores` (
`LIB_ISBN` bigint(20)
,`LIB_TITULO` varchar(255)
,`LIB_GENERO` varchar(20)
,`NUM_PAGINAS` int(11)
,`AUT_APELLIDO` varchar(45)
,`TIP_AUTOR` varchar(20)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_socios_prestamos`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_socios_prestamos` (
`SOC_NUMERO` int(11)
,`SOC_NOMBRE` varchar(45)
,`SOC_APELLIDO` varchar(45)
,`SOC_TELEFONO` varchar(10)
,`PRES_ID` varchar(20)
,`PRES_FPRESTAMO` date
,`PRES_FDEVOLUCION` date
,`COPIA_ISBN` bigint(20)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_libros_autores`
--
DROP TABLE IF EXISTS `vista_libros_autores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_libros_autores`  AS SELECT `l`.`LIB_ISBN` AS `LIB_ISBN`, `l`.`LIB_TITULO` AS `LIB_TITULO`, `l`.`LIB_GENERO` AS `LIB_GENERO`, `l`.`NUM_PAGINAS` AS `NUM_PAGINAS`, `a`.`AUT_APELLIDO` AS `AUT_APELLIDO`, `t`.`TIP_AUTOR` AS `TIP_AUTOR` FROM ((`libro` `l` join `tipoautores` `t` on(`l`.`LIB_ISBN` = `t`.`COPIA_ISBNN`)) join `autor` `a` on(`t`.`COPIA_AUTOR` = `a`.`AUT_COD`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_socios_prestamos`
--
DROP TABLE IF EXISTS `vista_socios_prestamos`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_socios_prestamos`  AS SELECT `s`.`SOC_NUMERO` AS `SOC_NUMERO`, `s`.`SOC_NOMBRE` AS `SOC_NOMBRE`, `s`.`SOC_APELLIDO` AS `SOC_APELLIDO`, `s`.`SOC_TELEFONO` AS `SOC_TELEFONO`, `p`.`PRES_ID` AS `PRES_ID`, `p`.`PRES_FPRESTAMO` AS `PRES_FPRESTAMO`, `p`.`PRES_FDEVOLUCION` AS `PRES_FDEVOLUCION`, `p`.`COPIA_ISBN` AS `COPIA_ISBN` FROM (`socio` `s` left join `prestamo` `p` on(`s`.`SOC_NUMERO` = `p`.`COPIA_NUMERO`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `audi_autor`
--
ALTER TABLE `audi_autor`
  ADD PRIMARY KEY (`ID_AUDI`);

--
-- Indices de la tabla `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`AUT_COD`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`LIB_ISBN`),
  ADD KEY `idx_libro` (`LIB_TITULO`);

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
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `audi_autor`
--
ALTER TABLE `audi_autor`
  MODIFY `ID_AUDI` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

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

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `eliminar_prestamos_vencidos` ON SCHEDULE EVERY 1 DAY STARTS '2026-04-01 00:00:00' ENDS '2026-12-31 23:59:59' ON COMPLETION PRESERVE ENABLE DO DELETE FROM prestamo
    WHERE PRES_FDEVOLUCION < NOW()$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
