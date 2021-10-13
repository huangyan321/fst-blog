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

 Date: 13/10/2021 23:55:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_blog
-- ----------------------------
DROP TABLE IF EXISTS `t_blog`;
CREATE TABLE `t_blog`  (
  `blog_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `uid` int(0) NULL DEFAULT 1 COMMENT 'uid',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `create_time` datetime(0) NOT NULL COMMENT '注册时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `publish` tinyint(0) NULL DEFAULT 0 COMMENT '是否发布',
  `brief` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  `ext_info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`blog_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_blog
-- ----------------------------
INSERT INTO `t_blog` VALUES (1, '我是改了tags后的title哦', 1, '我是内容哦', '2021-10-09 15:09:37', '2021-10-13 23:48:13', 1, '啊实打实', 1, '这是额外的信息');
INSERT INTO `t_blog` VALUES (2, '这是一个标题', 1, '这是一个内容', '2021-10-09 15:24:22', '2021-10-13 22:30:25', 0, '这是一个简介', 0, '这是额外的信息');
INSERT INTO `t_blog` VALUES (3, '这是一个标题', 1, '这是一个内容', '2021-10-09 15:24:39', '2021-10-13 22:30:28', 1, '这是一个简介', 0, '这是额外的信息');
INSERT INTO `t_blog` VALUES (4, '这是一个标题', 1, '这是一个内容', '2021-10-09 17:59:27', '2021-10-13 22:30:30', 1, '这是一个简介', 0, '这是额外的信息');
INSERT INTO `t_blog` VALUES (5, '这是一个标题', 1, '这是一个内容', '2021-10-12 23:21:55', '2021-10-13 22:30:38', 1, '这是一个简介', 0, '这是额外的信息');
INSERT INTO `t_blog` VALUES (6, '这是一个标题', 1, '这是一个内容', '2021-10-12 23:21:55', '2021-10-13 22:27:46', 1, '这是一个简介', 0, '这是额外的信息');
INSERT INTO `t_blog` VALUES (9, '21321312', 1, 'neirong', '2021-10-13 23:08:29', '2021-10-13 23:08:29', 1, '12312', 0, NULL);
INSERT INTO `t_blog` VALUES (10, '21321312', 1, 'neirong', '2021-10-13 23:11:28', '2021-10-13 23:11:28', 1, '12312', 0, NULL);
INSERT INTO `t_blog` VALUES (11, '21321312', 1, 'neirong', '2021-10-13 23:28:18', '2021-10-13 23:28:18', 1, '12312', 0, NULL);
INSERT INTO `t_blog` VALUES (12, '21321312', 1, 'neirong', '2021-10-13 23:28:37', '2021-10-13 23:34:28', 1, '12312', 1, NULL);

-- ----------------------------
-- Table structure for t_img
-- ----------------------------
DROP TABLE IF EXISTS `t_img`;
CREATE TABLE `t_img`  (
  `img_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(0) NOT NULL COMMENT 'uid',
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片url',
  `create_time` datetime(0) NOT NULL COMMENT '注册时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`img_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_img
-- ----------------------------
INSERT INTO `t_img` VALUES (1, 1, 'swiper1.jpeg', 'http://127.0.0.1:3000/static/0d4c377fd0f7a06b77cab10624638da4', '2021-10-12 23:14:57', '2021-10-12 23:14:57', 0);

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `tag_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名',
  `uid` int(0) NOT NULL COMMENT 'uid',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `is_delete` tinyint(1) NULL DEFAULT 0,
  `blog_id` int(0) NULL DEFAULT NULL COMMENT '博客id',
  PRIMARY KEY (`tag_id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (100, 'vuejs', 1, '2021-10-08 17:35:03', '2021-10-13 23:42:52', 0, 1);
INSERT INTO `t_tag` VALUES (101, 'javascript', 1, '2021-10-09 14:51:57', '2021-10-13 23:42:55', 0, 1);
INSERT INTO `t_tag` VALUES (102, 'html', 1, '2021-10-09 14:57:01', '2021-10-13 23:42:55', 0, 1);
INSERT INTO `t_tag` VALUES (103, 'css', 1, '2021-10-09 15:03:20', '2021-10-13 23:42:56', 0, 1);
INSERT INTO `t_tag` VALUES (104, 'reactjs', 1, '2021-10-09 15:04:20', '2021-10-13 23:42:56', 0, 1);
INSERT INTO `t_tag` VALUES (105, 'nodejs', 1, '2021-10-13 22:25:18', '2021-10-13 22:43:10', 0, 2);
INSERT INTO `t_tag` VALUES (111, '啊实打实的', 1, '2021-10-13 23:28:37', '2021-10-13 23:42:58', 0, 12);
INSERT INTO `t_tag` VALUES (112, '你好', 1, '2021-10-13 23:47:29', '2021-10-13 23:47:29', 0, 1);
INSERT INTO `t_tag` VALUES (113, '我叫', 1, '2021-10-13 23:47:29', '2021-10-13 23:47:29', 0, 1);
INSERT INTO `t_tag` VALUES (114, '撒打算', 1, '2021-10-13 23:47:29', '2021-10-13 23:47:29', 0, 1);
INSERT INTO `t_tag` VALUES (123, 'js', 1, '2021-10-13 23:48:13', '2021-10-13 23:48:13', 0, 1);

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
INSERT INTO `t_user` VALUES (1, 'admin', '123456', '2021-10-08 17:35:30', '2021-10-13 22:43:32', 0);

SET FOREIGN_KEY_CHECKS = 1;
