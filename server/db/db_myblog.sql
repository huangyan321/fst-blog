/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80026
 Source Host           : localhost:3306
 Source Schema         : db_myblog

 Target Server Type    : MySQL
 Target Server Version : 80026
 File Encoding         : 65001

 Date: 13/10/2021 08:04:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `uid` int(0) NULL DEFAULT 1 COMMENT 'uid',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `create_time` datetime(0) NOT NULL COMMENT '注册时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `note_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `publish` tinyint(0) NULL DEFAULT 0 COMMENT '是否发布',
  `brief` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `ext_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES (1, NULL, 1, NULL, '2021-10-09 15:09:37', NULL, NULL, 0, NULL, 0, NULL);
INSERT INTO `t_blog` VALUES (5, NULL, 1, NULL, '2021-10-09 15:24:22', '2021-10-09 15:26:12', '5', 0, NULL, 1, NULL);
INSERT INTO `t_blog` VALUES (6, NULL, 1, NULL, '2021-10-09 15:24:39', '2021-10-12 23:54:40', '6', 1, NULL, 1, NULL);
INSERT INTO `t_blog` VALUES (7, '这是一个标题', 1, '这是一个内容', '2021-10-09 17:59:27', '2021-10-12 23:31:18', '123', 1, '这是一个简介', 1, NULL);
INSERT INTO `t_blog` VALUES (8, '这是一个标题', 1, '这是一个内容', '2021-10-12 23:21:55', NULL, '123', 1, '这是一个简介', 0, NULL);

-- ----------------------------
-- Table structure for t_img
-- ----------------------------
DROP TABLE IF EXISTS `t_img`;
CREATE TABLE `t_img`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(0) NOT NULL COMMENT 'uid',
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片url',
  `create_time` datetime(0) NOT NULL COMMENT '注册时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_img
-- ----------------------------
INSERT INTO `t_img` VALUES (1, 1, 'swiper1.jpeg', 'http://127.0.0.1:3000/static/0d4c377fd0f7a06b77cab10624638da4', '2021-10-12 23:14:57', '2021-10-12 23:14:57', 0);

-- ----------------------------
-- Table structure for t_note
-- ----------------------------
DROP TABLE IF EXISTS `t_note`;
CREATE TABLE `t_note`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '笔记本名',
  `uid` int(0) NOT NULL COMMENT 'uid',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_note
-- ----------------------------
INSERT INTO `t_note` VALUES (1, 'admin', 0, '2021-10-08 17:35:03', '2021-10-08 17:35:06', 0);
INSERT INTO `t_note` VALUES (2, 'xiaoming', 1, '2021-10-09 14:51:57', NULL, 0);
INSERT INTO `t_note` VALUES (4, 'xiaomin', 1, '2021-10-09 14:57:01', NULL, 0);
INSERT INTO `t_note` VALUES (5, '你好我修改了名字', 1, '2021-10-09 15:03:20', '2021-10-09 15:44:47', 1);
INSERT INTO `t_note` VALUES (6, 'xiaomin阿松大a是的', 1, '2021-10-09 15:04:20', '2021-10-09 15:23:31', 1);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `uid` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `create_time` datetime(0) NOT NULL COMMENT '注册时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'admin', '123', '2021-10-08 17:35:30', '2021-10-08 17:35:33', 0);

SET FOREIGN_KEY_CHECKS = 1;
