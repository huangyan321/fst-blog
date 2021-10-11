/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 80026
Source Host           : localhost:3306
Source Database       : db_myblog

Target Server Type    : MYSQL
Target Server Version : 80026
File Encoding         : 65001

Date: 2021-10-11 08:51:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL COMMENT '标题',
  `uid` int DEFAULT '1' COMMENT 'uid',
  `content` text COMMENT '内容',
  `create_time` datetime NOT NULL COMMENT '注册时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `note_id` varchar(45) DEFAULT NULL,
  `publish` tinyint DEFAULT '0' COMMENT '是否发布',
  `brief` text,
  `is_delete` tinyint(1) DEFAULT '0' COMMENT '是否删除',
  `ext_info` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES ('1', null, '1', null, '2021-10-09 15:09:37', null, null, '0', null, '0', null);
INSERT INTO `t_blog` VALUES ('5', null, '1', null, '2021-10-09 15:24:22', '2021-10-09 15:26:12', '5', '0', null, '1', null);
INSERT INTO `t_blog` VALUES ('6', null, '1', null, '2021-10-09 15:24:39', '2021-10-09 15:26:07', '6', '0', null, '0', null);
INSERT INTO `t_blog` VALUES ('7', '你好', '1', 'async/await 中的异常处理很让人混乱。尽管有很多种方式来应对async 函数的异常，但是连经验丰富的开发者有时候也会搞错。  假设你有一个叫做run()的异步函数。在本文中，我会描述 3 种方式来处理run()的异常情形： try/catch, Go 语言风格, 函数调用的时候使用 catch()(即run().catch())。 我会跟你解释为什么其实几乎只需要catch()就足够。', '2021-10-09 17:59:27', null, '101', '1', 'async/await 中的异常处理很让人混乱。', '0', null);

-- ----------------------------
-- Table structure for t_img
-- ----------------------------
DROP TABLE IF EXISTS `t_img`;
CREATE TABLE `t_img` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL COMMENT 'uid',
  `create_time` datetime NOT NULL COMMENT '注册时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `name` varchar(40) DEFAULT NULL,
  `is_delete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_img
-- ----------------------------

-- ----------------------------
-- Table structure for t_note
-- ----------------------------
DROP TABLE IF EXISTS `t_note`;
CREATE TABLE `t_note` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '笔记本名',
  `uid` int NOT NULL COMMENT 'uid',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_note
-- ----------------------------
INSERT INTO `t_note` VALUES ('1', 'admin', '0', '2021-10-08 17:35:03', '2021-10-08 17:35:06', '0');
INSERT INTO `t_note` VALUES ('2', 'xiaoming', '1', '2021-10-09 14:51:57', null, '0');
INSERT INTO `t_note` VALUES ('4', 'xiaomin', '1', '2021-10-09 14:57:01', null, '0');
INSERT INTO `t_note` VALUES ('5', '你好我修改了名字', '1', '2021-10-09 15:03:20', '2021-10-09 15:44:47', '1');
INSERT INTO `t_note` VALUES ('6', 'xiaomin阿松大a是的', '1', '2021-10-09 15:04:20', '2021-10-09 15:23:31', '1');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `uid` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `create_time` datetime NOT NULL COMMENT '注册时间',
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', 'admin', '123', '2021-10-08 17:35:30', '2021-10-08 17:35:33', '0');
