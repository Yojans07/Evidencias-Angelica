-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-03-2026 a las 17:14:45
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_libro` (`c1_isbn` BIGINT(20), `c2_titulo` VARCHAR(255), `c3_genero` VARCHAR(20), `c4_paginas` INT(11), `c5diaspres` TINYINT(4))   INSERT INTO `libro`(`LIB_ISBN`, `LIB_TITULO`, `LIB_GENERO`, `NUM_PAGINAS`, `DIAS_PRESTAMO`)
VALUES (c1_isbn,c2_titulo,c3_genero, c4_paginas,c5diaspres)$$

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
(1, 890, 'Brown', '1982-11-17', '0000-00-00', '2026-03-09', '2026-03-09 10:22:23', 'root@localhost', 'ACTUALIZADO'),
(2, 0, 'DANIEL', '2008-05-12', '0000-00-00', NULL, '2026-03-09 10:37:23', 'root@localhost', 'ELIMINADO');

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
(890, 'Brown', '1982-11-17', '2026-03-09'),
(901, 'Soto', '1979-05-13', '2015-11-05'),
(1010, 'SOSA', '2023-08-17', '0000-00-00');

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

--
-- Disparadores `libro`
--
DELIMITER $$
CREATE TRIGGER `libro_insert` AFTER INSERT ON `libro` FOR EACH ROW BEGIN

INSERT INTO audi_libro(
    id_audi_libro,
    id_diaPrestamo_nuevo,
    audi_genero_nuevo,
    audi_isbn_nuevo,
    audi_numeroPaginas_nuevo,
    audi_titulo_nuevo,
    audi_fecha_modificacion,
    audi_usuario,
    audi_accion
)
VALUES(
    NEW.lib_isbn,
    NEW.DIAS_PRESTAMO,
    NEW.lib_genero,
    NEW.lib_isbn,
    NEW.NUM_Paginas,
    NEW.lib_titulo,
    NOW(),
    CURRENT_USER(),
    'Insercion'
);

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `libro_update` BEFORE UPDATE ON `libro` FOR EACH ROW INSERT INTO audi_libro(
    id_audi_libro,
    id_diaPrestamo_anterior,
    audi_genero_anterior,
    audi_isbn_anterior,
    audi_numeroPaginas_anterior,
    audi_titulo_anterior,
    id_diaPrestamo_nuevo,
    audi_genero_nuevo,
    audi_isbn_nuevo,
    audi_numeroPaginas_nuevo,
    audi_titulo_nuevo,
    audi_fecha_modificacion,
    audi_usuario,
    audi_accion
)
VALUES(
    NEW.lib_isbn,
    OLD.DIAS_PRESTAMO,
    OLD.lib_genero,
    OLD.NUM_Paginas,
    OLD.lib_titulo,
    NEW.DIAS_PRESTAMO,
    NEW.lib_genero,
    NEW.NUM_PAGINAS,
    NEW.lib_titulo,
    NOW(),
    CURRENT_USER(),
    'Actualizacion'
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `nombre_correo`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `nombre_correo` (
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posiciones`
--

CREATE TABLE `posiciones` (
  `id` int(11) NOT NULL,
  `grupo` char(10) NOT NULL,
  `pais` varchar(45) NOT NULL,
  `jugados` int(11) NOT NULL,
  `ganados` int(11) NOT NULL,
  `empatados` int(11) NOT NULL,
  `perdidos` int(11) NOT NULL,
  `puntos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

--
-- Disparadores `socio`
--
DELIMITER $$
CREATE TRIGGER `socio_after_delete` AFTER DELETE ON `socio` FOR EACH ROW INSERT INTO audi_socio(
    soc_numero_audi,
    soc_nombre_anterior,
    soc_apellido_anterior,
    soc_direccion_anterior,
    soc_telefono_anterior,
    audi_fecha_modificacion,
    audi_usuario,
    audi_accion)
VALUES (
    old.soc_numero,
    old.soc_nombre,
    old.soc_apellido,
    old.soc_direccion,
    old.soc_telefono,
    NOW(),
    CURRENT_USER(),
    'registro eliminado')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `socios_after_delete` AFTER DELETE ON `socio` FOR EACH ROW INSERT INTO audi_socio(
socNumero_audi,
socNombre_anterior,
socApellido_anterior,
socDireccion_anterior,
socTelefono_anterior,
audi_fechaModificacion,
audi_usuario,
audi_accion)
VALUES(
old.soc_numero,
old.soc_nombre,
old.soc_apellido,
old.soc_direccion,
old.soc_telefono,
NOW(),
CURRENT_USER(),
'Registro eliminado')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `socios_before_update` BEFORE UPDATE ON `socio` FOR EACH ROW INSERT INTO audi_socio(
socNumero_audi,
socNombre_anterior,
socApellido_anterior,
socDireccion_anterior,
socTelefono_anterior,
socNombre_nuevo,
socApellido_nuevo,
socDireccion_nuevo,
socTelefono_nuevo,
audi_fechaModificacion,
audi_usuario,
audi_accion)
VALUES(
new.soc_numero,
old.soc_nombre,
old.soc_apellido,
old.soc_direccion,
old.soc_telefono,
new.soc_nombre,
new.soc_apellido,
new.soc_direccion,
new.soc_telefono,
NOW(),
CURRENT_USER(),
'Actualización')
$$
DELIMITER ;

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
(2718281828, 789, 'Traductor'),
(8888888888, 234, 'Autor'),
(2468135790, 234, 'Autor'),
(9876543210, 567, 'Autor'),
(8642097531, 345, 'Autor'),
(8888888888, 345, 'Coautor'),
(5555555555, 678, 'Autor'),
(3141592653, 901, 'Autor'),
(9517530862, 432, 'Autor'),
(7777777777, 765, 'Autor'),
(9999999999, 98, 'Autor');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_autores`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_autores` (
`AUT_COD` int(11)
,`AUT_APELLIDO` varchar(45)
,`AUT_NACIMIENTO` date
,`AUT_FALLECIMIENTO` date
);

-- --------------------------------------------------------

--
-- Estructura para la vista `nombre_correo`
--
DROP TABLE IF EXISTS `nombre_correo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `nombre_correo`  AS SELECT `aprendiz`.`apr_nombre` AS `apr_nombre`, `aprendiz`.`apr_correo` AS `apr_correo` FROM `aprendiz` ORDER BY `aprendiz`.`apr_nombre` ASC ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_autores`
--
DROP TABLE IF EXISTS `vista_autores`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_autores`  AS SELECT `autor`.`AUT_COD` AS `AUT_COD`, `autor`.`AUT_APELLIDO` AS `AUT_APELLIDO`, `autor`.`AUT_NACIMIENTO` AS `AUT_NACIMIENTO`, `autor`.`AUT_FALLECIMIENTO` AS `AUT_FALLECIMIENTO` FROM `autor` ;

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
-- Indices de la tabla `posiciones`
--
ALTER TABLE `posiciones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pais` (`pais`),
  ADD KEY `grupo` (`grupo`);

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
  MODIFY `ID_AUDI` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `posiciones`
--
ALTER TABLE `posiciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
CREATE DEFINER=`root`@`localhost` EVENT `anual_eliminar_prestamos` ON SCHEDULE EVERY 1 YEAR STARTS '2026-03-09 06:42:05' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
    DELETE FROM prestamo
    WHERE PRES_FDEVOLUCION <= NOW() - INTERVAL 1 YEAR;
    #datos menores a la fecha actual - 1 año
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
