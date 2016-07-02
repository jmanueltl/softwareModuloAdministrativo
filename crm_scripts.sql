SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


CREATE TABLE IF NOT EXISTS `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `auth_item` (`name`, `type`, `description`, `rule_name`, `data`, `created_at`, `updated_at`) VALUES
('admin', 1, NULL, 'userGroup', NULL, 1463261157, 1463261157),
('create_profile', 2, NULL, NULL, NULL, 1463261156, 1463261156),
('delete_profile', 2, NULL, 'console\\rbac\\CanDelete', NULL, 1463261156, 1463261156),
('super_admin', 1, NULL, 'userGroup', NULL, 1463261157, 1463261157),
('update_profile', 2, NULL, 'console\\rbac\\CanEdit', NULL, 1463261156, 1463261156),
('user', 1, NULL, 'userGroup', NULL, 1463261157, 1463261157);

CREATE TABLE IF NOT EXISTS `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `auth_item_child` (`parent`, `child`) VALUES
('super_admin', 'admin'),
('admin', 'create_profile'),
('admin', 'delete_profile'),
('user', 'update_profile'),
('admin', 'user');

CREATE TABLE IF NOT EXISTS `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `auth_rule` (`name`, `data`, `created_at`, `updated_at`) VALUES
('console\\rbac\\CanDelete', 'O:22:"console\\rbac\\CanDelete":3:{s:4:"name";s:22:"console\\rbac\\CanDelete";s:9:"createdAt";i:1463261156;s:9:"updatedAt";i:1463261156;}', 1463261156, 1463261156),
('console\\rbac\\CanEdit', 'O:20:"console\\rbac\\CanEdit":3:{s:4:"name";s:20:"console\\rbac\\CanEdit";s:9:"createdAt";i:1463261156;s:9:"updatedAt";i:1463261156;}', 1463261156, 1463261156),
('userGroup', 'O:26:"console\\rbac\\UserGroupRule":3:{s:4:"name";s:9:"userGroup";s:9:"createdAt";i:1463261156;s:9:"updatedAt";i:1463261156;}', 1463261156, 1463261156);

CREATE TABLE IF NOT EXISTS `campana` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: inactivo\n1: activo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

INSERT INTO `campana` (`id`, `nombre`, `estado`) VALUES
(1, 'Emprendemos', 1);

CREATE TABLE IF NOT EXISTS `catalogo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) DEFAULT NULL,
  `mes` int(11) DEFAULT NULL,
  `anio` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: INACTIVO\n1: ACTIVO',
  `codigo` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `catalogo` (`id`, `descripcion`, `mes`, `anio`, `estado`, `codigo`) VALUES
(1, 'Catalogo De Productos', 6, 2016, 1, '001'),
(2, 'Emprediendo', 6, 2016, 2, '002');

CREATE TABLE IF NOT EXISTS `catalogo_producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `catalogo_id` int(11) NOT NULL,
  `campana_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `incentivo_id` int(11) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: INACTIVO\n1: ACTIVO',
  PRIMARY KEY (`id`),
  KEY `fk_catalogo_producto_catalogo_idx` (`catalogo_id`),
  KEY `fk_catalogo_producto_producto1_idx` (`producto_id`),
  KEY `fk_catalogo_producto_incentivo1_idx` (`incentivo_id`),
  KEY `fk_catalogo_producto_campana1_idx` (`campana_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `despacho` (
  `id` int(11) NOT NULL,
  `operacion_id` int(11) DEFAULT NULL,
  `pedido_id` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: INACTIVO\n1: ACTIVO',
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_despacho_operacion1_idx` (`operacion_id`),
  KEY `fk_despacho_pedido1_idx` (`pedido_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `distrito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` char(10) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `latitud` varchar(255) DEFAULT NULL,
  `longitud` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `distrito` (`id`, `codigo`, `nombre`, `latitud`, `longitud`, `estado`) VALUES
(1, 'LIMA 1', 'CERCADO DE LIMA', '', '', 1),
(2, 'LIMA 40', 'CALLAO', '', '', 1);

CREATE TABLE IF NOT EXISTS `entrega_premios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_entrega_premios_producto1_idx` (`producto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `familia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: inactivo\n1: activo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

INSERT INTO `familia` (`id`, `nombre`, `estado`) VALUES
(1, 'Familia 1', 1),
(2, 'Familia 2', 1),
(3, 'Familia 3', 1);

CREATE TABLE IF NOT EXISTS `ganadoras` (
  `id` int(11) NOT NULL,
  `entrega_premios_id` int(11) NOT NULL,
  `interlocutor_comercial_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ganadoras_entrega_premios1_idx` (`entrega_premios_id`),
  KEY `fk_ganadoras_interlocutor_comercial1_idx` (`interlocutor_comercial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `incentivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_incentivo_id` int(11) NOT NULL,
  `puntaje_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: inactivo\n1: activo',
  PRIMARY KEY (`id`),
  KEY `fk_incentivo_tipo_incentivo1_idx` (`tipo_incentivo_id`),
  KEY `fk_incentivo_puntaje1_idx` (`puntaje_id`),
  KEY `fk_incentivo_producto1_idx` (`producto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `interlocutor_comercial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zona_id` int(11) NOT NULL,
  `roles_id` int(11) NOT NULL,
  `codigo` char(10) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_interlocutor_comercial_zona1_idx` (`zona_id`),
  KEY `fk_interlocutor_comercial_roles1_idx` (`roles_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

INSERT INTO `interlocutor_comercial` (`id`, `zona_id`, `roles_id`, `codigo`, `nombre`, `apellido`, `email`, `telefono`, `estado`) VALUES
(1, 1, 1, 'P0001', 'Nombre 1', 'Apellido 1', 'nombre@mail.com', '12345678', 1),
(2, 1, 1, 'P0002', 'Nombre 2', 'Apellido 2', 'nombre@persona.net', '1234567', 1),
(3, 1, 1, 'P0003', 'NOMBRE 3', 'APELLIDO 3', 'nombre2@persona.com', '135454354', 1);

CREATE TABLE IF NOT EXISTS `mail_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_type` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `template` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

INSERT INTO `mail_templates` (`id`, `template_type`, `subject`, `template`) VALUES
(1, 'email-verification', 'Email Verification', '<p>Dear {user_name},</p>\n                <p>Thank you for expressing your interest in our site. To finalize your request we need to verify your email address.</p>\n                <p>Please <a href="{email_verification_url}">click here</a> to complete the registration process.</p>\n                <p>Thank you again for your interest.</p>\n                <p>Best regards,</p>\n                <p>Advanced Template</p>\n                <p>advanced-template.dev</p>'),
(2, 'welcome-mail', 'Welcome', '<p>Dear {user_name},</p>\r\n\r\n<p>Thank you completing your registration with our site.</p>\r\n\r\n<p>Best regards,</p>\r\n\r\n<p>Advanced Template</p>\r\n\r\n<p>software.dev</p>\r\n');

CREATE TABLE IF NOT EXISTS `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1463261021),
('m130524_201442_init', 1463261024),
('m150909_161409_mail_templates', 1463261025),
('m150915_102235_rbac_init', 1463261027);

CREATE TABLE IF NOT EXISTS `operacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_operacion_id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  `codigo_operacion` varchar(255) DEFAULT NULL,
  `monto_operacion` decimal(10,2) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: INACTIVO\n1: ACTIVO',
  `observacion` varchar(45) NOT NULL,
  `fecha_operacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_operacion_tipo_operacion2_idx` (`tipo_operacion_id`),
  KEY `fk_operacion_pedido1_idx` (`pedido_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

INSERT INTO `operacion` (`id`, `tipo_operacion_id`, `pedido_id`, `codigo_operacion`, `monto_operacion`, `estado`, `observacion`, `fecha_operacion`) VALUES
(1, 1, 1, 'OPE0001', 100.00, 1, 'Enviado', '2016-06-01 00:00:00'),
(2, 1, 2, 'OPE0002', 50.00, 1, 'Enviado', '2016-06-02 00:00:00'),
(3, 2, 3, 'OPE00003', 35.00, 1, 'enviado', '2016-06-03 00:00:00'),
(4, 2, 4, 'OPE0004', 55.00, 1, 'no enviado', '2016-06-11 00:00:00');

CREATE TABLE IF NOT EXISTS `operacion_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `producto_id_operacion` int(11) DEFAULT NULL,
  `operacion_id` int(11) NOT NULL,
  `zona_id` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `secuencia` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: ANULADO\n1: NO ANULADO',
  `fecha_operacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_operacion_detalle_producto1_idx` (`producto_id`),
  KEY `fk_operacion_detalle_operacion1_idx` (`operacion_id`),
  KEY `fk_operacion_detalle_zona1_idx` (`zona_id`),
  KEY `fk_operacion_detalle_producto2_idx` (`producto_id_operacion`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

INSERT INTO `operacion_detalle` (`id`, `producto_id`, `producto_id_operacion`, `operacion_id`, `zona_id`, `cantidad`, `monto`, `secuencia`, `estado`, `fecha_operacion`) VALUES
(1, 1, 2, 1, 1, 2, 50.00, 1, 1, '2016-06-11 00:00:00');

CREATE TABLE IF NOT EXISTS `pedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_pedido_id` int(11) NOT NULL,
  `interlocutor_comercial_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pedido_tipo_pedido1_idx` (`tipo_pedido_id`),
  KEY `fk_pedido_interlocutor_comercial1_idx` (`interlocutor_comercial_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

INSERT INTO `pedido` (`id`, `tipo_pedido_id`, `interlocutor_comercial_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 2);

CREATE TABLE IF NOT EXISTS `pedido_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pedido_detalle_producto1_idx` (`producto_id`),
  KEY `fk_pedido_detalle_pedido1_idx` (`pedido_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `personal_despacho` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `despacho_id` int(11) NOT NULL,
  `codigo` char(10) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_personal_despacho_despacho1_idx` (`despacho_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `familia_id` int(11) NOT NULL,
  `codigo` char(10) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `unidad` int(11) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `precio_vta` decimal(10,2) DEFAULT NULL,
  `descuento` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_producto_familia1_idx` (`familia_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

INSERT INTO `producto` (`id`, `familia_id`, `codigo`, `nombre`, `unidad`, `precio`, `precio_vta`, `descuento`, `estado`) VALUES
(1, 1, 'PROD001', 'PRODUCTO 1', 5, 6.00, 6.30, 20, 1),
(2, 2, 'PROD0002', 'PRODUCTO 2', 20, 8.00, 8.50, 10, 1),
(3, 2, 'PROD0003', 'PRODUCTO3', 60, 3.50, 3.90, 15, 1),
(4, 3, 'PROD0004', 'PRODUCTO 4', 15, 100.00, 101.00, 8, 1),
(5, 3, 'PROD0004', 'PRODUCTO 5', 40, 12.00, 12.40, 12, 1),
(6, 1, '002', 'Perfume', 3, 30.00, 40.00, 5, NULL),
(7, 1, '00252', 'Perfume', 10, 50.00, 60.00, 5, NULL);

CREATE TABLE IF NOT EXISTS `puntaje` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interlocutor_comercial_id` int(11) NOT NULL,
  `puntaje` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: inactivo\n1: activo',
  `fecha` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_puntaje_interlocutor_comercial1_idx` (`interlocutor_comercial_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `relacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_relacion_id` int(11) NOT NULL,
  `interlocutor_comercial_id` int(11) NOT NULL,
  `interlocutor_comercial_id_alt` int(11) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_relacion_tipo_relacion1_idx` (`tipo_relacion_id`),
  KEY `fk_relacion_interlocutor_comercial1_idx` (`interlocutor_comercial_id`),
  KEY `fk_relacion_interlocutor_comercial2_idx` (`interlocutor_comercial_id_alt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` char(10) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `roles` (`id`, `codigo`, `nombre`, `estado`) VALUES
(1, 'R0001', 'Rol 1', 1),
(2, 'R0002', 'ROL 2', 1);

CREATE TABLE IF NOT EXISTS `stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stock_producto1_idx` (`producto_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `tipo_incentivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: inactivo\n1: activo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `tipo_operacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detalle` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL COMMENT '0: INACTIVO\n1: ACTIIVO',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `tipo_operacion` (`id`, `detalle`, `estado`) VALUES
(1, 'Tipo operacion 1', 1),
(2, 'Tipo operacion 2', 1);

CREATE TABLE IF NOT EXISTS `tipo_pedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `tipo_pedido` (`id`, `nombre`, `estado`) VALUES
(1, 'Tipo pedido 1', 1),
(2, 'Tipo pedido 2', 1);

CREATE TABLE IF NOT EXISTS `tipo_relacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` char(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `surname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '1',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `role` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_verification_status` tinyint(1) NOT NULL DEFAULT '0',
  `email_verification_code` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

INSERT INTO `user` (`id`, `code`, `name`, `surname`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `status`, `created_at`, `updated_at`, `role`, `username`, `email_verification_status`, `email_verification_code`) VALUES
(1, NULL, NULL, NULL, '3LgKD7CFmKr8JXVl4L5SThWDlO459HPK', '$2y$13$DIXHWWMhGQfSzO60UAX7C.R/iIM4E0nNHOAKkSOX8Zn03xpqZeKtq', NULL, 'admin@crm.com', 1, 1463261124, 1463261124, 'super_admin', NULL, 1, 'rznbntOOJMqgk1NA'),
(2, NULL, NULL, NULL, 'zf-lHYIIB0jd0O57brZQ8kfaPTlCWkgb', '$2y$13$oAlzqmHPn2v1OOhvVS5gxubnAcaGVFiJO6z4VhJryTR.489vLJGSO', NULL, 'cmamani@crm.com', 1, 1463261381, 1463263040, 'admin', NULL, 1, 'qkLqRWVE4gOhe0Pb'),
(3, NULL, NULL, NULL, 'zFC4B7F88J25feMCTvhB4wa4iPxbVnuc', '$2y$13$eLWizBO/RGKFxLsXM/gzNuPiRcVQi2sDbKur0LAtQlx/MATR3vYla', NULL, 'eparodi@crm.com', 1, 1463263067, 1463263188, 'user', NULL, 0, 'f0hRA6adapRQ5eHA');

CREATE TABLE IF NOT EXISTS `venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `despacho_id` int(11) NOT NULL,
  `pedido_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_venta_pedido1_idx` (`pedido_id`),
  KEY `fk_venta_despacho1_idx` (`despacho_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `venta_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `venta_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_venta_detalle_venta1_idx` (`venta_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `zona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `distrito_id` int(11) NOT NULL,
  `codigo` char(10) DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_zona_distrito1_idx` (`distrito_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

INSERT INTO `zona` (`id`, `distrito_id`, `codigo`, `nombre`, `estado`) VALUES
(1, 1, 'Z0001', 'ZONA 01', 1),
(2, 2, 'Z0002', 'ZONA 2', 1);


ALTER TABLE `auth_assignment`
  ADD CONSTRAINT `auth_assignment_ibfk_1` FOREIGN KEY (`item_name`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `auth_item`
  ADD CONSTRAINT `auth_item_ibfk_1` FOREIGN KEY (`rule_name`) REFERENCES `auth_rule` (`name`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `auth_item_child`
  ADD CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `catalogo_producto`
  ADD CONSTRAINT `fk_catalogo_producto_campana1` FOREIGN KEY (`campana_id`) REFERENCES `campana` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_catalogo_producto_catalogo` FOREIGN KEY (`catalogo_id`) REFERENCES `catalogo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_catalogo_producto_incentivo1` FOREIGN KEY (`incentivo_id`) REFERENCES `incentivo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_catalogo_producto_producto1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `despacho`
  ADD CONSTRAINT `fk_despacho_operacion1` FOREIGN KEY (`operacion_id`) REFERENCES `operacion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_despacho_pedido1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `entrega_premios`
  ADD CONSTRAINT `fk_entrega_premios_producto1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `ganadoras`
  ADD CONSTRAINT `fk_ganadoras_entrega_premios1` FOREIGN KEY (`entrega_premios_id`) REFERENCES `entrega_premios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ganadoras_interlocutor_comercial1` FOREIGN KEY (`interlocutor_comercial_id`) REFERENCES `interlocutor_comercial` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `incentivo`
  ADD CONSTRAINT `fk_incentivo_producto1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_incentivo_puntaje1` FOREIGN KEY (`puntaje_id`) REFERENCES `puntaje` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_incentivo_tipo_incentivo1` FOREIGN KEY (`tipo_incentivo_id`) REFERENCES `tipo_incentivo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `interlocutor_comercial`
  ADD CONSTRAINT `fk_interlocutor_comercial_roles1` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_interlocutor_comercial_zona1` FOREIGN KEY (`zona_id`) REFERENCES `zona` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `operacion`
  ADD CONSTRAINT `fk_operacion_pedido1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_operacion_tipo_operacion2` FOREIGN KEY (`tipo_operacion_id`) REFERENCES `tipo_operacion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `operacion_detalle`
  ADD CONSTRAINT `fk_operacion_detalle_operacion1` FOREIGN KEY (`operacion_id`) REFERENCES `operacion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_operacion_detalle_producto1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_operacion_detalle_producto2` FOREIGN KEY (`producto_id_operacion`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_operacion_detalle_zona1` FOREIGN KEY (`zona_id`) REFERENCES `zona` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_pedido_interlocutor_comercial1` FOREIGN KEY (`interlocutor_comercial_id`) REFERENCES `interlocutor_comercial` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_tipo_pedido1` FOREIGN KEY (`tipo_pedido_id`) REFERENCES `tipo_pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `pedido_detalle`
  ADD CONSTRAINT `fk_pedido_detalle_pedido1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_pedido_detalle_producto1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `personal_despacho`
  ADD CONSTRAINT `fk_personal_despacho_despacho1` FOREIGN KEY (`despacho_id`) REFERENCES `despacho` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `producto`
  ADD CONSTRAINT `fk_producto_familia1` FOREIGN KEY (`familia_id`) REFERENCES `familia` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `puntaje`
  ADD CONSTRAINT `fk_puntaje_interlocutor_comercial1` FOREIGN KEY (`interlocutor_comercial_id`) REFERENCES `interlocutor_comercial` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `relacion`
  ADD CONSTRAINT `fk_relacion_interlocutor_comercial1` FOREIGN KEY (`interlocutor_comercial_id`) REFERENCES `interlocutor_comercial` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_relacion_interlocutor_comercial2` FOREIGN KEY (`interlocutor_comercial_id_alt`) REFERENCES `interlocutor_comercial` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_relacion_tipo_relacion1` FOREIGN KEY (`tipo_relacion_id`) REFERENCES `tipo_relacion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `stock`
  ADD CONSTRAINT `fk_stock_producto1` FOREIGN KEY (`producto_id`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_despacho1` FOREIGN KEY (`despacho_id`) REFERENCES `despacho` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_venta_pedido1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `venta_detalle`
  ADD CONSTRAINT `fk_venta_detalle_venta1` FOREIGN KEY (`venta_id`) REFERENCES `venta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `zona`
  ADD CONSTRAINT `fk_zona_distrito1` FOREIGN KEY (`distrito_id`) REFERENCES `distrito` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
