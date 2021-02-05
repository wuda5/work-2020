/*
 Navicat Premium Data Transfer

 Source Server         : 172.16.92.250
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 172.16.92.250:3306
 Source Schema         : gmis_seata

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 05/02/2021 14:03:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for branch_table
-- ----------------------------
DROP TABLE IF EXISTS `branch_table`;
CREATE TABLE `branch_table`  (
  `branch_id` bigint(20) NOT NULL,
  `xid` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `transaction_id` bigint(20) NULL DEFAULT NULL,
  `resource_group_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `resource_id` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `branch_type` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT NULL,
  `client_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `application_data` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime(6) NULL DEFAULT NULL,
  `gmt_modified` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`branch_id`) USING BTREE,
  INDEX `idx_xid`(`xid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of branch_table
-- ----------------------------
INSERT INTO `branch_table` VALUES (2027790469, '172.16.92.250:8091:2027789459', 2027789459, NULL, 'jdbc:mysql://172.16.92.250:3306/gmis_defaults', 'AT', 3, 'gmis-authority-server:172.17.0.3:42646', NULL, '2020-11-17 07:14:50.213166', '2020-11-17 07:14:50.723229');
INSERT INTO `branch_table` VALUES (2030405522, '172.16.92.250:8091:2030405488', 2030405488, NULL, 'jdbc:mysql://172.16.92.250:3306/gmis_defaults', 'AT', 0, 'gmis-authority-server:172.17.0.15:45304', NULL, '2020-12-21 02:26:36.628532', '2020-12-21 02:26:36.628532');

-- ----------------------------
-- Table structure for global_table
-- ----------------------------
DROP TABLE IF EXISTS `global_table`;
CREATE TABLE `global_table`  (
  `xid` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `transaction_id` bigint(20) NULL DEFAULT NULL,
  `status` tinyint(4) NOT NULL,
  `application_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transaction_service_group` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transaction_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `timeout` int(11) NULL DEFAULT NULL,
  `begin_time` bigint(20) NULL DEFAULT NULL,
  `application_data` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT NULL,
  `gmt_modified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`xid`) USING BTREE,
  INDEX `idx_gmt_modified_status`(`gmt_modified`, `status`) USING BTREE,
  INDEX `idx_transaction_id`(`transaction_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of global_table
-- ----------------------------

-- ----------------------------
-- Table structure for lock_table
-- ----------------------------
DROP TABLE IF EXISTS `lock_table`;
CREATE TABLE `lock_table`  (
  `row_key` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `xid` varchar(96) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `transaction_id` bigint(20) NULL DEFAULT NULL,
  `branch_id` bigint(20) NOT NULL,
  `resource_id` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `table_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pk` varchar(36) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gmt_create` datetime(0) NULL DEFAULT NULL,
  `gmt_modified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`row_key`) USING BTREE,
  INDEX `idx_branch_id`(`branch_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lock_table
-- ----------------------------
INSERT INTO `lock_table` VALUES ('jdbc:mysql://172.16.92.250:3306/gmis_defaults^^^c_common_opt_log^^^1328597197813448704', '172.16.92.250:8091:2027789459', 2027789459, 2027790469, 'jdbc:mysql://172.16.92.250:3306/gmis_defaults', 'c_common_opt_log', '1328597197813448704', '2020-11-17 07:14:49', '2020-11-17 07:14:49');
INSERT INTO `lock_table` VALUES ('jdbc:mysql://172.16.92.250:3306/gmis_defaults^^^c_common_opt_log^^^1336224737684094976', '172.16.92.250:8091:2029569683', 2029569683, 2029569709, 'jdbc:mysql://172.16.92.250:3306/gmis_defaults', 'c_common_opt_log', '1336224737684094976', '2020-12-08 08:22:58', '2020-12-08 08:22:58');
INSERT INTO `lock_table` VALUES ('jdbc:mysql://172.16.92.250:3306/gmis_defaults^^^c_common_opt_log^^^1340845894706135041', '172.16.92.250:8091:2030405488', 2030405488, 2030405522, 'jdbc:mysql://172.16.92.250:3306/gmis_defaults', 'c_common_opt_log', '1340845894706135041', '2020-12-21 02:26:27', '2020-12-21 02:26:27');

SET FOREIGN_KEY_CHECKS = 1;
