/*
 Navicat Premium Data Transfer

 Source Server         : 172.16.92.250
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 172.16.92.250:3306
 Source Schema         : gmis_SCOTT

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 05/02/2021 14:03:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ACT_HI_PROCESS
-- ----------------------------
DROP TABLE IF EXISTS `ACT_HI_PROCESS`;
CREATE TABLE `ACT_HI_PROCESS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程实例序号',
  `FLOWID` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程模型ID',
  `FLOWNAME` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程名称',
  `OWERID` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建者ID',
  `OWERNAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建者',
  `PROCESS` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程实例数据JSON',
  `CREATETIME` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建时间',
  `FLOWTYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程模型类型'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_HI_PROCESS
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RE_FLOW
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_FLOW`;
CREATE TABLE `ACT_RE_FLOW`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '序号',
  `NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程模型名',
  `SMS` decimal(20, 0) NOT NULL COMMENT '短信通知',
  `MEMO` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `OWERID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `OWERNAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者名字',
  `UPDATETIME` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `FLOWTYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '节点类型'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RE_FLOW
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RE_FLOW_NODE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RE_FLOW_NODE`;
CREATE TABLE `ACT_RE_FLOW_NODE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '自增ID',
  `FLOWID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程ID',
  `NOID` decimal(20, 0) NOT NULL COMMENT '节点ID',
  `NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '节点名字',
  `NODETYPE` decimal(11, 0) NULL DEFAULT NULL COMMENT '节点类型',
  `PARENTNOID` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '父节点',
  `CHILDNOID` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'YES子节点',
  `CHILDNOID2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'NO子节点',
  `EXECUTOR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '执行者ID',
  `EXECUTORNAME` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '执行者名字',
  `PARAMETER` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数1',
  `PARAMETER2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数2',
  INDEX `INDEX_FLOWID_NOID`(`NOID`, `FLOWID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RE_FLOW_NODE
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_PROCESS
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_PROCESS`;
CREATE TABLE `ACT_RU_PROCESS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '流程实例序号',
  `FLOWID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程模型ID',
  `NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作流名',
  `STATUS` decimal(20, 0) NULL DEFAULT NULL COMMENT '状态',
  `STARTNOID` decimal(20, 0) NULL DEFAULT NULL COMMENT '开始节点',
  `RUNNOID` decimal(20, 0) NULL DEFAULT NULL COMMENT '进行节点',
  `ENDNOID` decimal(20, 0) NULL DEFAULT NULL COMMENT '结束节点',
  `OWERID` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者ID',
  `OWERNAME` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `CREATETIME` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `ATTACHMENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '附件信息',
  `PARAMS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '实例参数(json串)',
  `FROMMODULEID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源模块编号',
  `FROMMODULESUBID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源模块子编号',
  INDEX `INDEX_OWERID`(`OWERID`) USING BTREE,
  INDEX `INDEX_OWERID_FROMMODULE`(`OWERID`, `FROMMODULEID`, `FROMMODULESUBID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_PROCESS
-- ----------------------------

-- ----------------------------
-- Table structure for ACT_RU_PROCESS_NODE
-- ----------------------------
DROP TABLE IF EXISTS `ACT_RU_PROCESS_NODE`;
CREATE TABLE `ACT_RU_PROCESS_NODE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '自增ID',
  `PROCESSID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程实例ID',
  `FLOWID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程模型ID',
  `FLOWNODEID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程模型节点ID',
  `FLOWNODENAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程模型节点名称',
  `EXECUTORID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作人ID',
  `EXECUTORNAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作人名字',
  `STATUS` decimal(20, 0) NULL DEFAULT NULL COMMENT '审批(0:未审批，1:同意，2:不同意',
  `COMMENTS` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '评论',
  `ATTACHMENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '附件信息(json格式)',
  `CREATETIME` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  INDEX `INDEX_FLOW`(`FLOWID`, `FLOWNODEID`) USING BTREE,
  INDEX `INDEX_PROCESSID`(`PROCESSID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ACT_RU_PROCESS_NODE
-- ----------------------------

-- ----------------------------
-- Table structure for APP_CONTEXT_PATH
-- ----------------------------
DROP TABLE IF EXISTS `APP_CONTEXT_PATH`;
CREATE TABLE `APP_CONTEXT_PATH`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CONTEXT_PATH` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_CONTEXT_PATH
-- ----------------------------

-- ----------------------------
-- Table structure for APP_CUSTAPK_VERSION
-- ----------------------------
DROP TABLE IF EXISTS `APP_CUSTAPK_VERSION`;
CREATE TABLE `APP_CUSTAPK_VERSION`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `VERSION` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'APK版本号',
  `RELEASE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `PATH` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '存储路径',
  `UPDATE_TYPE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否强制更新、0不更新，1可选更新、2强制更新',
  `FILE_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上传文件名',
  `FILE_TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件扩展名',
  `UPDATE_DETAIL` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '更新描述',
  `VERSION_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '版本名称//展示个用户看的',
  `APK_TYPE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '应用类型，值取自数据字典applicationType'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_CUSTAPK_VERSION
-- ----------------------------

-- ----------------------------
-- Table structure for APP_FEEDBACKS
-- ----------------------------
DROP TABLE IF EXISTS `APP_FEEDBACKS`;
CREATE TABLE `APP_FEEDBACKS`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `FEEDBACKS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_DATETIME` datetime(0) NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_FEEDBACKS
-- ----------------------------

-- ----------------------------
-- Table structure for APP_HELPS
-- ----------------------------
DROP TABLE IF EXISTS `APP_HELPS`;
CREATE TABLE `APP_HELPS`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `HELPS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_DATETIME` datetime(0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_HELPS
-- ----------------------------

-- ----------------------------
-- Table structure for APP_INVENTORY_ENTRY
-- ----------------------------
DROP TABLE IF EXISTS `APP_INVENTORY_ENTRY`;
CREATE TABLE `APP_INVENTORY_ENTRY`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WAREHOUSE_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库id',
  `TOTAL` decimal(11, 2) NULL DEFAULT NULL COMMENT '入库总金额',
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '入库时间',
  `CREATE_BY` datetime(0) NULL DEFAULT NULL COMMENT '经手人',
  `DELIVERYMAN` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '送货人',
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库类型,1.正常;2.盘点',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '入库' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_INVENTORY_ENTRY
-- ----------------------------

-- ----------------------------
-- Table structure for APP_INVENTORY_WAREHOUSE
-- ----------------------------
DROP TABLE IF EXISTS `APP_INVENTORY_WAREHOUSE`;
CREATE TABLE `APP_INVENTORY_WAREHOUSE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '仓库名称',
  `CHECK_DATE` datetime(0) NULL DEFAULT NULL COMMENT '最后盘点时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '仓库设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_INVENTORY_WAREHOUSE
-- ----------------------------

-- ----------------------------
-- Table structure for APP_LOGIN_STATISTICS
-- ----------------------------
DROP TABLE IF EXISTS `APP_LOGIN_STATISTICS`;
CREATE TABLE `APP_LOGIN_STATISTICS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LOGIN_USER` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登陆用户手机号',
  `LOGIN_TIME` datetime(0) NOT NULL COMMENT '登陆时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_LOGIN_STATISTICS
-- ----------------------------

-- ----------------------------
-- Table structure for APP_NOTICE
-- ----------------------------
DROP TABLE IF EXISTS `APP_NOTICE`;
CREATE TABLE `APP_NOTICE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知编号',
  `CONTENT` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '通知内容',
  `ANNUNCIATOR` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通知发布人名称',
  `ANNUNCIATOR_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发布人用户ID',
  `RELEASE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '发布时间',
  `CREATE_USER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通知创建用户',
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '通知创建时间',
  `NOTICE_STATUS` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知状态，N标识新建；0标识停播，1表示开播',
  `PROCLAMATION_DEPART` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通知部门',
  `TITLE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知主题',
  `TYPE` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通知分类 0表示公司内部通知，1表示客户通知'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_NOTICE
-- ----------------------------

-- ----------------------------
-- Table structure for APP_PARAMETERS
-- ----------------------------
DROP TABLE IF EXISTS `APP_PARAMETERS`;
CREATE TABLE `APP_PARAMETERS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'app参数Id',
  `APP_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'APP名字',
  `APP_LOG` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'log图片路径',
  `SERVER_PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务电话',
  `STORE_ENABLED` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商城是否可用',
  `UPDATE_USER` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '执行更新操作的用户',
  `UPDATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '数据更新时间',
  `IS_READING` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '扫描抄表',
  `IS_SECURITY_CHECK` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '扫描安检'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_PARAMETERS
-- ----------------------------
INSERT INTO `APP_PARAMETERS` VALUES ('PARAM01', '燃气宝', NULL, NULL, '0', 'admin', '2019-01-08 00:00:00', NULL, NULL);

-- ----------------------------
-- Table structure for APP_PRINT
-- ----------------------------
DROP TABLE IF EXISTS `APP_PRINT`;
CREATE TABLE `APP_PRINT`  (
  `TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类别，0安检1抄表',
  `DATA` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '打印内容',
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_PRINT
-- ----------------------------

-- ----------------------------
-- Table structure for APP_STORE_DELIVERY_ADDRESS
-- ----------------------------
DROP TABLE IF EXISTS `APP_STORE_DELIVERY_ADDRESS`;
CREATE TABLE `APP_STORE_DELIVERY_ADDRESS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收货地址ID',
  `LOGIN_PHONE` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用于登陆APP的手机号码',
  `PHONE` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收货联系人',
  `RECEIVER` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收货人姓名',
  `CUSTOMER_CODE` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '燃气客户编号',
  `IS_DEFAULT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否默认 1:是；0:否 任何时候只能有一个默认1',
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '最后一次修改时间',
  `DELETE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '删除时间',
  `ADDRESS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收货地址，详细地址',
  `ADDRESS_NO` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货地址，地址编码',
  `ADDRESS_NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货地址城市_中文',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_STORE_DELIVERY_ADDRESS
-- ----------------------------

-- ----------------------------
-- Table structure for APP_STORE_ORDER
-- ----------------------------
DROP TABLE IF EXISTS `APP_STORE_ORDER`;
CREATE TABLE `APP_STORE_ORDER`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户编号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `CUSTOMER_ADDRESS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户地址',
  `DELIVERY_ADDRESS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收货地址',
  `PHONE_NUM` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `PRODUCT_CODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品编号',
  `PRODUCT_NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品名称',
  `QUANTITY` decimal(5, 0) NULL DEFAULT NULL COMMENT '购买商品数量',
  `PRICE` decimal(12, 2) NULL DEFAULT NULL COMMENT '商品单价',
  `TOTAL_PRICE` decimal(12, 2) NULL DEFAULT NULL COMMENT '商品总价',
  `STATUS` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '订单状态',
  `DELIVERY_ORDER_CODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出货单号',
  `EXPRESS_COMPANY_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递公司名称',
  `EXPRESS_ORDER_CODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '快递单号',
  `PAY_WAY` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付费方式',
  `PAID_UP_ACCOUNT` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付费账号',
  `BANK_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行名称',
  `REMARK` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ORDER_CREATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '下单时间',
  `DELIVERY_TIME` datetime(0) NULL DEFAULT NULL COMMENT '出库时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_STORE_ORDER
-- ----------------------------

-- ----------------------------
-- Table structure for APP_USER
-- ----------------------------
DROP TABLE IF EXISTS `APP_USER`;
CREATE TABLE `APP_USER`  (
  `USER_NAME` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'APP登陆手机及号',
  `NICKNAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `PROFILE_PICTURE_PATH` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户头像路径',
  `DEFAULT_CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `DEFAULT_CUSTOMER_NUM` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户编号',
  `FIRST_LOGIN_TIME` datetime(0) NULL DEFAULT NULL COMMENT '第一次登陆时间',
  `END_LOGIN_TIME` datetime(0) NULL DEFAULT NULL COMMENT '最近一次登陆时间',
  PRIMARY KEY (`USER_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_USER
-- ----------------------------

-- ----------------------------
-- Table structure for APP_WARES
-- ----------------------------
DROP TABLE IF EXISTS `APP_WARES`;
CREATE TABLE `APP_WARES`  (
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品编号',
  `NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品名称',
  `WARESTYPE_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品类别编号',
  `WARESTYPE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品类别名称',
  `FACTORY` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '厂家'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_WARES
-- ----------------------------

-- ----------------------------
-- Table structure for APP_WARESPICES
-- ----------------------------
DROP TABLE IF EXISTS `APP_WARESPICES`;
CREATE TABLE `APP_WARESPICES`  (
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WARES_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品编号',
  `PICES` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '规格',
  `PRICE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单价',
  `REBATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '折扣（0—100）',
  `RELPRICE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行价（单价*折扣）',
  `STATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '0在用1停用'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_WARESPICES
-- ----------------------------

-- ----------------------------
-- Table structure for APP_WARESTYPE
-- ----------------------------
DROP TABLE IF EXISTS `APP_WARESTYPE`;
CREATE TABLE `APP_WARESTYPE`  (
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品类别名称',
  `PID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '父类id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of APP_WARESTYPE
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_ADDRESS
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_ADDRESS`;
CREATE TABLE `ARCHIVES_ADDRESS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ADMINISTRATIVE_REGION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_AREAS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STREET_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `HOUSE_NUMBER` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `COMMUNITY_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BUILDING_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `UNIT_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ROOM_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BUILDING_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `THISTIME_PLANNED_METERING_DATE` datetime(0) NULL DEFAULT NULL,
  `THIS_PRACTICAL_METERING_DATE` datetime(0) NULL DEFAULT NULL,
  `NEXTTIME_PLANNED_METERING_DATE` datetime(0) NULL DEFAULT NULL,
  `DOWNLOADED_STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `METERING_PERSON` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BOOKLET_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '该字段不使用，废弃',
  `SECURITY_CHECKS` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否安检；0否、1是；默认1',
  `OPEN_GAS` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否通气 0-否 1-是',
  `STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DETAILED_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `ADMINISTRATIVE_REGION_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_AREAS_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_ADDRESS
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_AGREEMENT
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_AGREEMENT`;
CREATE TABLE `ARCHIVES_AGREEMENT`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AGREEMENT_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AGREEMENT_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SIGNED_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SIGNED_TIME` datetime(0) NULL DEFAULT NULL,
  `REMARK` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ACCESSORY` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_AGREEMENT
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_ALIAS
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_ALIAS`;
CREATE TABLE `ARCHIVES_ALIAS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `COMPANY_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公司名称',
  `CUSTOMER_CREATE_FEE_ALIAS` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '开户费别名',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_ALIAS
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_BUILDING
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_BUILDING`;
CREATE TABLE `ARCHIVES_BUILDING`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BUILDING_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_AREAS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `UNIT_NUMBER` decimal(65, 30) NULL DEFAULT NULL,
  `FLOOR_NUMBER` decimal(65, 30) NULL DEFAULT NULL,
  `HOUSEHOLDS_NUMBER` decimal(65, 30) NULL DEFAULT NULL,
  `DOORPLATE_CREATE_WAY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `COMMUNITY_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `COMMUNITY_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_REGION_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_AREAS_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STREET_NAMES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `HOUSE_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DETAILED_ADDRESS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_REGION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `OPEN_GAS` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_BUILDING
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_CHARGE
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_CHARGE`;
CREATE TABLE `ARCHIVES_CHARGE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '费用收取ID',
  `APPROVAL_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '申请ID（流水号）',
  `CHARGE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收费项目名集合',
  `ACCOUNTS_DUE` decimal(10, 2) NOT NULL COMMENT '应收金额',
  `IS_SETTLE` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否结清，0未结清，1已结清（该字段不作为结果）',
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '费用创建时间',
  `CREATE_USER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `UPDATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `UPDATE_USER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `CHARGE_IDS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '费用项目ID集合'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_CHARGE
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_CLOSE_ACCOUNT
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_CLOSE_ACCOUNT`;
CREATE TABLE `ARCHIVES_CLOSE_ACCOUNT`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CUSTOMER_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `GAS_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CLOSE_REASON` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AFTER_READ` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AFTER_READ_TIME` datetime(0) NULL DEFAULT NULL,
  `DEADLINE` decimal(65, 30) NULL DEFAULT NULL,
  `RETURN_CHARGE_WAY` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ACCOUNT_BANK` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BANK_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ACCOUNT_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PROPOSER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL,
  `ACCESSORY` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PROCESS_STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `APPROVAL_PERSON` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `APPROVAL_TIME` datetime(0) NULL DEFAULT NULL,
  `APPROVAL_OPINION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `APPROVAL_PERSON_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_CLOSE_ACCOUNT
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_CLOSE_ACCOUNT_COST
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_CLOSE_ACCOUNT_COST`;
CREATE TABLE `ARCHIVES_CLOSE_ACCOUNT_COST`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CLOSE_ACCOUNT_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHARGE_PROJECT_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AMOUNT_RECEIVABLE` decimal(65, 30) NULL DEFAULT NULL,
  `SETTLEMENT_MARK` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_CLOSE_ACCOUNT_COST
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_COMMUNITY
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_COMMUNITY`;
CREATE TABLE `ARCHIVES_COMMUNITY`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `COMMUNITY_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_REGION_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_AREAS_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STREET_NAMES` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `HOUSE_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DETAILED_ADDRESS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BUILDING_NUMBER` decimal(65, 30) NULL DEFAULT NULL,
  `PROJECT_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DEVELOPMENT_ORGANIZATION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PROJECT_LEADER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PROJECT_ACCEPTOR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_COMMUNITY
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_CREDENTIALS
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_CREDENTIALS`;
CREATE TABLE `ARCHIVES_CREDENTIALS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREDENTIALS_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREDENTIALS_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ACCESSORY` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_CREDENTIALS
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_CUSTOMER
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_CUSTOMER`;
CREATE TABLE `ARCHIVES_CUSTOMER`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `CUSTOMER_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户类型 字段名改为 “用气类型”BUG编号 #434',
  `CERTIFICATE_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件类型',
  `CERTIFICATE_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `GAS_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气地址',
  `ADDRESS_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址ID',
  `PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `SMS_NUMBER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信联系号码',
  `EMAIL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电子邮箱',
  `LINKMAN_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人姓名',
  `LINKMAN_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人地址',
  `LINKMAN_PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人电话',
  `ACCOUNT_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户人姓名',
  `ACCOUNT_BANK` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户银行',
  `ACCOUNT_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '银行账户号码',
  `TAX_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发票税号',
  `PRINT_INVOICE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否打印发票',
  `GAS_SCALE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气规模',
  `CUSTOMER_STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户状态',
  `NOTIFICATION_OF_ARREARS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '欠费通知方式',
  `SPECIAL_CUSTOMER_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '特殊客户类型',
  `VIP` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否是VIP',
  `CONFINED` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否受限',
  `OPEN_GAS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通气状态',
  `RENT_CUSTOMER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否租凭客户',
  `HEATING_CUSTOMER` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否采暖期用户',
  `HIGH_ENERGY_CUSTOMER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否高能耗用户',
  `STOVE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否有灶具',
  `WATER_HEATER` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否有热水器',
  `PREPAID_THRESHOLD` decimal(11, 2) NULL DEFAULT NULL COMMENT '预付阈值',
  `PREPAID_DEPOSIT` decimal(11, 2) NULL DEFAULT NULL COMMENT '预存款',
  `CASH_DEPOSIT` decimal(11, 2) NULL DEFAULT NULL COMMENT '保证金',
  `MANTISSA` decimal(11, 2) NULL DEFAULT NULL COMMENT '调尾数（已废弃）',
  `PAY_WAY` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缴费方式',
  `WITHHOLDING_BANK` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '代扣银行',
  `AFFILIATED_BUSINESS_HALL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属营业厅',
  `FILING_TIME` datetime(0) NULL DEFAULT NULL COMMENT '建档时间',
  `FILING_PERSON` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '档案创建人',
  `UPDATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `UPDATE_PERSON` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `TEAM_PAYMENT_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '团缴户Id,未使用',
  `PRESTORE_STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '预存签约状态',
  `PRESTORE_START_TIME` datetime(0) NULL DEFAULT NULL COMMENT '预存签约生效开始时间',
  `PRESTORE_END_TIME` datetime(0) NULL DEFAULT NULL COMMENT '预存签约生效结束时间',
  `IS_USED` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否启用过，0为未启用过，1为启用过，如果为1，则不能改变',
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建用户',
  `GAS_PROPERTY_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气性质ID',
  `ORG_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属机构ID',
  `ORG_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属机构名称',
  `WECHAT_NUM` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信号',
  `CONNECTION_MODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表具连接方式',
  `INSTALLATION_MODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表具安装方式',
  `FAMILY` decimal(65, 30) NULL DEFAULT NULL COMMENT '家庭成员，默认为0'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_CUSTOMER
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_CUSTOMR_INFO
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_CUSTOMR_INFO`;
CREATE TABLE `ARCHIVES_CUSTOMR_INFO`  (
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户ID',
  `CREATE_ACCOUNT_CHARGE_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费ID',
  `CREATE_ACCOUNT_CHARGE_TYPE_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费项目ID',
  `CREATE_ACCOUNT_HAS_CHARGE` decimal(65, 30) NULL DEFAULT NULL COMMENT '是否已收费',
  `CREATE_ACCOUNT_AMOUNT` decimal(65, 30) NULL DEFAULT NULL COMMENT '开户金额',
  `CREATE_ACCOUNT_AMOUNT_PAY` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开户费支付方式',
  PRIMARY KEY (`CUSTOMER_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_CUSTOMR_INFO
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_DISTRIBUTION_RECORD
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_DISTRIBUTION_RECORD`;
CREATE TABLE `ARCHIVES_DISTRIBUTION_RECORD`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ORIGIN_CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源客户ID',
  `ORIGIN_CUSTOMER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '源客户名称',
  `DESTINATION_CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '目标客户ID',
  `DESTINATION_CUSTOMER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '目标客户名称',
  `METER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表编号',
  `METER_CODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `ACTION_DATE` datetime(0) NOT NULL COMMENT '操作时间',
  `ACTION_USER` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_DISTRIBUTION_RECORD
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_EQUIPMENT
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_EQUIPMENT`;
CREATE TABLE `ARCHIVES_EQUIPMENT`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EQUIPMENT_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `EQUIPMENT_MODEL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATE_FACTORY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RELEASE_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SECURITY_CHECK` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `GAS_CONSUMPTION` decimal(65, 30) NULL DEFAULT NULL,
  `EQUIPMENT_NUMBER` decimal(65, 30) NULL DEFAULT NULL,
  `METER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `INSTALL_WAY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CONNECTION_WAY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REMARK` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_EQUIPMENT
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_GASPROPERTY_CHANGE
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_GASPROPERTY_CHANGE`;
CREATE TABLE `ARCHIVES_GASPROPERTY_CHANGE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户编号',
  `GAS_ADDRESS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气地址',
  `CUSTOMER_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `CHANGE_REASON` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '调整原因',
  `APPLICATION_TIME` datetime(0) NULL DEFAULT NULL COMMENT '申请时间',
  `REMARK` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `PROCESS_STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程状态',
  `APPROVAL_OPINION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审批意见',
  `PROPOSER` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请人',
  `ACCESSORY` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附件',
  `APPROVING_PERSON` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审批人',
  `APPROVING_PERSON_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审批人ID',
  `OLD_GAS_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原用气类型ID',
  `OLD_GAS_PROPERTY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原用气性质ID',
  `NEW_GAS_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变更后的用气类型ID',
  `NEW_GAS_PROPERTY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变更后的用气性质ID'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_GASPROPERTY_CHANGE
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_HEATING_GAS_PROPERTY
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_HEATING_GAS_PROPERTY`;
CREATE TABLE `ARCHIVES_HEATING_GAS_PROPERTY`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `GAS_PROPERTY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '普通用气性质',
  `HEATING_GAS_PROPERTY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '采暖期用气性质',
  `GAS_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '普通用气类型',
  `HEATING_GAS_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '采暖期用气类型',
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CREATE_USER` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_HEATING_GAS_PROPERTY
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_HEATING_SIGN
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_HEATING_SIGN`;
CREATE TABLE `ARCHIVES_HEATING_SIGN`  (
  `IS_HEATING_PERIOD` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否采暖期，0表示否，1表示是'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_HEATING_SIGN
-- ----------------------------
INSERT INTO `ARCHIVES_HEATING_SIGN` VALUES ('1');

-- ----------------------------
-- Table structure for ARCHIVES_METER
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_METER`;
CREATE TABLE `ARCHIVES_METER`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表具编号',
  `GAS_METER_FACTORY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `GAS_METER_MODEL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表具型号和名称表具型号ID组合，使用“，”分隔',
  `RELEASE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '出厂日期',
  `INSTALLATION_SITE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '安装位置',
  `GAS_ENVIRONMENT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气环境',
  `FIRST_LOAD_TIME` datetime(0) NULL DEFAULT NULL COMMENT '初次装表时间',
  `MONTH_ALARM_NUMBER` decimal(65, 30) NULL DEFAULT NULL COMMENT '月报警气量',
  `INITIAL_TABLE_BASE` decimal(65, 30) NULL DEFAULT NULL COMMENT '初始表底数',
  `REGULATO_BOX_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '调压箱编号',
  `RISER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '立管编号',
  `IC_CARD_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IC卡卡号',
  `TELEX_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '远传通讯号',
  `PAY_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预付/后附',
  `PRICING_MANNER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计价方式：2018/12/25废弃',
  `ENABLED` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ADDRESS_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址编号',
  `IS_ENABLE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表具是否启用:0 - 未启用 1 - 启用',
  `COMMUNITY_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小区编号',
  `BUILDING_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '楼栋编号',
  `METER_CODE` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户编号',
  `IS_DEL` decimal(1, 0) NOT NULL COMMENT '删除表示位，0表示未删除，1表示已删除',
  `TYPE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类标识',
  `NS_METER_ID` decimal(13, 0) NULL DEFAULT NULL COMMENT '表具内部唯一标识ID',
  `INVENTORY_STATUS` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '库存状态:0-在库 1-出库 2-报装 3-在用 4-维修 5-报废',
  `STORAGE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '入库时间',
  `HANDLER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '入库经手人',
  `CLAIMING_DATE` datetime(0) NULL DEFAULT NULL COMMENT '领用日期',
  `CLAIMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '领用人',
  `RECORD_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '档案ID,由3.0返回，通过回调更新',
  `LOGIC_REG` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '逻辑域注册 0-否 1-是',
  `DEVICE_REG` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备注册 0-否 1-是',
  `CHARGE_TIME` decimal(65, 30) NOT NULL COMMENT '充值次数',
  `VOLUME` decimal(65, 30) NOT NULL COMMENT '累计气量',
  `IC_STATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IC卡开卡状态，0:未开卡，1:开卡中，2:已开卡',
  `INTAKE_DIRECTION` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '进气方向',
  `FIRST_USE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '启用日期'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_METER
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_METER_CUSTOMER
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_METER_CUSTOMER`;
CREATE TABLE `ARCHIVES_METER_CUSTOMER`  (
  `METER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表具ID',
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户ID',
  `CREATE_TIME` datetime(0) NOT NULL COMMENT '客户表具关联时间',
  `CLOSE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '客户表具取消关联时间',
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关系ID',
  `IS_VALID` decimal(1, 0) NULL DEFAULT NULL COMMENT '是否有效0表示无效、1标识有效'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_METER_CUSTOMER
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_METER_LIMIT
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_METER_LIMIT`;
CREATE TABLE `ARCHIVES_METER_LIMIT`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `METER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DAY_GAS_NUMBER` decimal(10, 2) NULL DEFAULT NULL,
  `MONTH_GAS_NUMBER` decimal(10, 2) NULL DEFAULT NULL,
  `TEMPORARY_LIMIT_NUMBER` decimal(10, 2) NULL DEFAULT NULL,
  `TEMPORARY_LIMIT_REASON` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_METER_LIMIT
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_OTHER_FILE
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_OTHER_FILE`;
CREATE TABLE `ARCHIVES_OTHER_FILE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `FILE_NAMES` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `FILE_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ACCESSORY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REMARK` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_OTHER_FILE
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_REGISTER_DEVICE_INFO
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_REGISTER_DEVICE_INFO`;
CREATE TABLE `ARCHIVES_REGISTER_DEVICE_INFO`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备档案ID--archiveId',
  `IMEI` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SIM` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ARCHIVE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '生产日期',
  `END_DATE` datetime(0) NULL DEFAULT NULL COMMENT 'SIM卡有效期',
  `BIND_DATE` datetime(0) NULL DEFAULT NULL COMMENT '逻辑域绑定日期',
  `FACTORY_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备生产厂商编号，由QNMS3.0约定',
  `VERSION_NO` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设备版号，由QNMS3.0约定',
  `BASE_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '基表类型',
  `CONTROL_MODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '控制模式',
  `TRANSACTION_NO` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '该值来自于3.0阀控，请求流水编号，获取执行状态或推送执行状态时使用的识别项'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_REGISTER_DEVICE_INFO
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_TEAM_PAYMENT
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_TEAM_PAYMENT`;
CREATE TABLE `ARCHIVES_TEAM_PAYMENT`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REMARK` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_TEAM_PAYMENT
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_TRANSFER_ACCOUNT
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_TRANSFER_ACCOUNT`;
CREATE TABLE `ARCHIVES_TRANSFER_ACCOUNT`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `OLD_CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `OLD_CUSTOMER_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `GAS_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TRANSFER_REASON` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AFTER_READ` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AFTER_READ_TIME` datetime(0) NULL DEFAULT NULL,
  `DEADLINE` decimal(65, 30) NULL DEFAULT NULL,
  `RETURN_CHARGE_WAY` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `OLD_ACCOUNT_BANK` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原银行账户',
  `OLD_BANK_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原银行卡号',
  `OLD_ACCOUNT_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '原银行开户名',
  `PROPOSER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL,
  `ACCESSORY` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `PROCESS_STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '申请状态',
  `APPROVAL_PERSON` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请人',
  `APPROVAL_TIME` datetime(0) NULL DEFAULT NULL COMMENT '申请时间',
  `APPROVAL_OPINION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NEW_CUSTOMER_NAMES` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '新客户名称',
  `CERTIFICATE_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件类型ID',
  `CERTIFICATE_NUMBER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证件号码',
  `NEW_ACCOUNT_BANK` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新的银行账户',
  `NEW_BANK_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新的银行卡号',
  `NEW_ACCOUNT_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新的银行账户名',
  `LINKMAN` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `LINKPHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `APPROVAL_PERSON_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审批人ID',
  `PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户电话',
  `SMS_NUMBER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信号码',
  `RENT_CUSTOMER` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否租户',
  `NOTIFICATION_OF_ARREARS` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '欠费通知',
  `PRINT_INVOICE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否打印增值税发票',
  `TAX_NUMBER` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '纳税人识别号'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_TRANSFER_ACCOUNT
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVES_TRANSFER_ACCOUNT_COST
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVES_TRANSFER_ACCOUNT_COST`;
CREATE TABLE `ARCHIVES_TRANSFER_ACCOUNT_COST`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TRANSFER_ACCOUNT_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHARGE_PROJECT_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AMOUNT_RECEIVABLE` decimal(65, 30) NULL DEFAULT NULL,
  `SETTLEMENT_MARK` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVES_TRANSFER_ACCOUNT_COST
-- ----------------------------

-- ----------------------------
-- Table structure for ARCHIVE_TEAM_PAYMENT_CUSTOMER
-- ----------------------------
DROP TABLE IF EXISTS `ARCHIVE_TEAM_PAYMENT_CUSTOMER`;
CREATE TABLE `ARCHIVE_TEAM_PAYMENT_CUSTOMER`  (
  `TEAM_PAYMENT_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_TEAM_PAYMENT` decimal(38, 0) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ARCHIVE_TEAM_PAYMENT_CUSTOMER
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_ADMINISTRATIVE_AREA
-- ----------------------------
DROP TABLE IF EXISTS `BASE_ADMINISTRATIVE_AREA`;
CREATE TABLE `BASE_ADMINISTRATIVE_AREA`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `PARENT_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '上级区域id',
  `STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态，有效|无效',
  `PARENT_IDS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所有父节点id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '行政区域' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_ADMINISTRATIVE_AREA
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_AREADATA
-- ----------------------------
DROP TABLE IF EXISTS `BASE_AREADATA`;
CREATE TABLE `BASE_AREADATA`  (
  `INTERVAL` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '间隔时间',
  `STARTTIME` datetime(0) NOT NULL COMMENT '上传起始时间',
  `ENDTIME` datetime(0) NOT NULL COMMENT '上传终止时间',
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `UPDATE_USER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `UPDATE_TIME` datetime(0) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_AREADATA
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_AREALIST
-- ----------------------------
DROP TABLE IF EXISTS `BASE_AREALIST`;
CREATE TABLE `BASE_AREALIST`  (
  `X` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'x坐标',
  `Y` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'y坐标',
  `NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '上报人姓名',
  `TIME` datetime(0) NOT NULL COMMENT '上报时间',
  `POWER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电量'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_AREALIST
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_ATTACHMENT
-- ----------------------------
DROP TABLE IF EXISTS `BASE_ATTACHMENT`;
CREATE TABLE `BASE_ATTACHMENT`  (
  `ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '附件名称',
  `ORIGINAL_FILE_NAME` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '附件原名',
  `TYPE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '附件类型',
  `SOURCE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '附件来源',
  `APPLICATION` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '附件用途',
  `URL` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '附件地址',
  `RELATED_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关编号',
  `HYPERLINK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '超链接地址',
  `IS_SHOW` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否展示 0-否 1-是',
  `REMARK` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '附件管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_ATTACHMENT
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_BUSINESS_HALL
-- ----------------------------
DROP TABLE IF EXISTS `BASE_BUSINESS_HALL`;
CREATE TABLE `BASE_BUSINESS_HALL`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '营业厅' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_BUSINESS_HALL
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_BUSINESS_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_BUSINESS_TYPE`;
CREATE TABLE `BASE_BUSINESS_TYPE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '业务类型名称',
  `IS_ENABLE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '使用标志,是|否',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '业务类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_BUSINESS_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_CHECK_CHECKED
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CHECK_CHECKED`;
CREATE TABLE `BASE_CHECK_CHECKED`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECKED` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CHECK_CHECKED
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_CHECK_DANGE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CHECK_DANGE`;
CREATE TABLE `BASE_CHECK_DANGE`  (
  `CHECK_PLAN_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DANGER_TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DANGER_LEVEL` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DANGER_MIAOSU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `DANGER_STATE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DANGER_RESULT` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHANGE_TIME` datetime(0) NULL DEFAULT NULL,
  `CHANGER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `FUJIAN` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECKER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_DATE` datetime(0) NULL DEFAULT NULL,
  `CUSTOMER_CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADDRESS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DANGE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ISSPECIAL` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CHECK_DANGE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_CHECK_DANGELEVEL
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CHECK_DANGELEVEL`;
CREATE TABLE `BASE_CHECK_DANGELEVEL`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DANGENAME` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CHECK_DANGELEVEL
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_CHECK_OVERPLAN
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CHECK_OVERPLAN`;
CREATE TABLE `BASE_CHECK_OVERPLAN`  (
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PHONE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `OVER_DAY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `LAST_CHECKER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `LAST_CHECKDATE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PLAN_CHECKER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PLAN_DATE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STATE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CHECK_OVERPLAN
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_CHECK_PLAN
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CHECK_PLAN`;
CREATE TABLE `BASE_CHECK_PLAN`  (
  `ID` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `ADDRESS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_DATE` datetime(0) NULL DEFAULT NULL,
  `CHECKER` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_STATE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `OWNER` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `LATE_STATE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PLAN_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CHECK_PLAN
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_CHECK_RESULT
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CHECK_RESULT`;
CREATE TABLE `BASE_CHECK_RESULT`  (
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADDRESS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_PLAN_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHECKER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_DATE` datetime(0) NULL DEFAULT NULL,
  `REMARKS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `PROPAGANDA` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `EXAMINE_STATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `EXAMINE_OWNER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `EXAMINE_DATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DANGER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_RESULT` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `FUJIAN` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CHECK_RESULT
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_CHECK_RESULT_CHECK
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CHECK_RESULT_CHECK`;
CREATE TABLE `BASE_CHECK_RESULT_CHECK`  (
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECKED` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CHECK_RESULT_CHECK
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_CHECK_YEAR_CHECK
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CHECK_YEAR_CHECK`;
CREATE TABLE `BASE_CHECK_YEAR_CHECK`  (
  `YEAR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CHECK_YEAR_CHECK
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_CODE_RULE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CODE_RULE`;
CREATE TABLE `BASE_CODE_RULE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BUSINESS_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '业务名称',
  `PREFIX` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '前缀',
  `RULE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '规则',
  `GENERATE_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成方式，每日|每周|每月|每年',
  `SERIAL_NUMBER_LENGTH` decimal(38, 0) NOT NULL COMMENT '流水号长度',
  `STEP_LENGTH` decimal(38, 0) NOT NULL COMMENT '步长',
  `INITIAL_VALUE` decimal(38, 0) NOT NULL COMMENT '初始值',
  `IS_USE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否使用',
  `USE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '上次使用日期',
  `IS_PAD` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否补零',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CODE_RULE
-- ----------------------------
INSERT INTO `BASE_CODE_RULE` VALUES ('013317a8-6eca-4450-beb6-81e6b8ee8a26', '充值', 'GCLS', '{yyyyMMDDNO}', '1', 5, 1, 1, '1', '2019-10-15 10:34:22', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('0780513f-b9de-451b-9f5a-8c351ed0cc40', '拆表申请', 'GBSQ', '{yyyyMMDDNO}', '1', 5, 1, 1, '1', '2019-11-18 14:48:55', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('0dc8bb45-da9b-4ea8-a6b7-d0b8db5ead95', '维修申请', 'WXSQ', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-11-08 17:36:00', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('0ebcd1c7-333b-4471-a21a-d6c4a53d55e9', '补卡', 'BKLS', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-10-15 10:35:47', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('1056c1df-dacd-4aff-ab5d-00a94bc75cf2', '短信', 'DXBH', '{yyyyMMDDNO}', '1', 8, 1, 1, '1', '2019-05-22 10:50:59', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('1423c7cb-510a-4b28-95f3-a35a5fb677d3', '角色编号', 'JSBH', '{NO}', NULL, 2, 1, 1, '1', '2019-10-07 13:55:37', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('1c9543d0-3830-4bce-beab-fb6559b34bd2', '清卡', 'QKLS', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-09-20 17:16:48', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('1d2bb49a-9825-4c46-8812-f8ea85dbaebc', '特困低保客户补贴', 'TKBT', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-06-12 16:56:59', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('20af0f64-29f3-4f43-adb3-eee5dd2a29d5', '工作流配置编号', 'GZL', '{NO}', NULL, 5, 1, 1, '1', '2019-10-21 15:16:54', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('216a6c77-4e75-4847-bcb2-3e916ee987e1', '管理区域编号', 'QYBH', '{NO}', NULL, 2, 1, 1, '1', '2019-03-07 14:32:56', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('21c01b25-0833-417b-b87c-705ef39bdacc', '取消充值', 'QXCZ', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-06-12 16:15:35', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('230bad80-ae61-4781-ac45-f46ed6899ff7', '费用设置编号', 'FYSZ', '{NO}', NULL, 3, 1, 1, '1', '2019-08-30 11:30:31', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('2673409f-905f-4c67-ac37-2f358ddcb595', '新增文件', 'FILE', '{yyyyMMDDNO}', '1', 2, 1, 1, '1', '2019-06-04 20:38:14', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('27f95886-ea3b-468c-915a-702fa60f757b', '回款统计编号', 'HKTJ', '{yyyyMMNO}', '3', 5, 1, 1, '1', '2019-06-09 17:21:38', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('28b28ad7-4197-4267-aea7-0c407140ad47', '临时抄表状态', 'LSST', '{yyyyMMDDNO}', '1', 4, 1, 1, '0', NULL, '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('2c5eb3ce-f028-430a-91bf-22afe82901e4', '换表申请', 'HBBH', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-09-30 10:56:22', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('2ce825af-0ed5-4822-b8bd-9c17102d971b', '知识', 'HJZS', '{NO}', NULL, 8, 1, 1, '1', '2019-06-20 09:36:02', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('2f95144e-7a36-43a0-af99-b944a39d2907', '挂表申请', 'GBSQ', '{yyyyMMDDNO}', '1', 5, 1, 1, '1', '2019-05-16 09:58:51', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('320a92f9-6832-4aec-ae97-4167500d30a1', '欠款统计编号', 'QKTJ', '{yyyyMMNO}', '3', 5, 1, 1, '1', '2019-06-09 14:07:47', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('34b94e48-8c5c-4457-9f29-de45d9ebe67a', '操作员编号', 'QZBH', '{NO}', NULL, 4, 1, 1, '1', '2019-12-20 15:05:51', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('38f2a29c-52ea-49a6-b85c-f09d2b25fccb', '商品规格编号', 'SPGG', '{NO}', NULL, 4, 1, 1, '1', '2019-09-10 16:18:13', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('39a659c8-ccf8-495e-9b34-acd9a9540872', '第三方对账编号', 'SFDZ', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2018-12-24 16:01:21', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('3b63ad92-51cf-428b-adf4-93ed3f642564', '工单编号', 'GDBH', '{yyyyMMDDNO}', '1', 6, 1, 1, '1', '2019-12-05 10:45:54', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('3b703de7-47c8-48bb-ae17-2f69cf97427b', '新增表具', 'QBBH', '{NO}', NULL, 7, 1, 1, '1', '2019-11-12 12:01:45', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('3d6a295d-d6a5-4126-8993-2bdb81678df1', '票据编号', 'PJBH', '{NO}', NULL, 10, 1, 1, '1', '2019-09-28 09:16:20', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('42a5dd1d-b8c6-40cc-8730-40bfaa9d58ed', '自定义菜单编号', 'ZDYCD', '{NO}', NULL, 6, 1, 1, '1', '2019-11-26 15:37:08', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('42e28153-3413-406b-a298-3cfb28cd5744', '新增小区', 'XQBH', '{NO}', NULL, 4, 1, 1, '1', '2019-10-12 15:57:34', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('49e63ccc-12c7-4bfd-9034-30590649578b', '新增安检计划', 'CHEC', '{NO}', NULL, 7, 1, 1, '1', '2019-12-05 16:05:37', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('4a97b2a5-6ee8-45ee-b42b-554f12ac82f8', '抄表设备', 'SBBH', '{NO}', NULL, 5, 1, 1, '1', '2019-12-30 19:46:37', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('4c4b8d28-4870-4a73-af14-978110e1398e', '待处理任务编号', 'RWBH', '{yyyyMMDDNO}', '1', 6, 1, 1, '1', '2019-12-05 10:45:54', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('50272c99-c5c1-4876-b063-71b006d2081c', '工单', 'GDBH', '{yyyyMMDDNO}', '1', 6, 1, 1, '0', NULL, '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('512b7d31-0739-48e8-a231-b6570e21da7a', '阶梯计价方案', NULL, '{NO}', NULL, 5, 1, 1, '1', '2019-10-28 16:56:32', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('55476710-8be9-47d6-a108-7047a3f59ffb', '收费交接编号', 'SFJJ', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-09-25 09:15:18', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('55502367-438f-404a-8713-31efca7bdb3b', '冲正管理编号', 'CZBH', '{YYYYMMDDNO}', '1', 3, 1, 1, '1', '2019-10-21 16:36:59', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('56060e66-023b-4ac4-9e84-c8ff5eae2b59', '违约金减免编号', 'JMSQ', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-05-06 15:51:55', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('57f5e3d4-70e5-4a44-bfb1-59e1b4a44ccd', '抄表数据', 'CBJL', '{yyyyMMDDNO}', '1', 5, 1, 1, '1', '2019-11-21 11:40:45', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('5a25025f-c289-4e32-95e1-3b472f12c9a2', '险情上报', 'XQSB', '{NO}', NULL, 7, 1, 1, '1', '2019-10-29 15:56:29', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('5bc0afe1-eddb-4a73-9bee-52add498e949', '新增过户申请', 'GHSQ', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-11-06 14:06:38', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('60aa8983-72a8-4049-b308-7ee17b7a1c1d', '呼叫记录', 'HJJL', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-05-06 09:59:55', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('61edbd04-0a02-4de4-bdfb-6e9cf5c42ebc', '票本编号', 'PBBH', '{NO}', NULL, 6, 1, 1, '1', '2019-07-24 11:55:05', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('6229ffcd-e5f4-40c3-9399-131f69e99873', '商品编号', 'SPBH', '{NO}', NULL, 4, 1, 1, '1', '2019-07-31 14:01:34', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('6a07a302-1b6f-4462-b6c2-0977da4eec5b', '柜台收费编号', 'SFLS', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-11-06 14:06:38', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('6d2d3abe-81cf-4b30-937a-3695cb3879b1', '员工编号', 'YGBH', '{NO}', NULL, 4, 1, 1, '1', '2019-09-18 11:42:58', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('71b2b18f-e6ae-4317-81c4-f45f256fa117', '补气', 'BQLS', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-10-15 10:36:13', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('73ed86df-bd51-44eb-af55-a768c79200c2', '地址编码', 'ADDR', '{NO}', '1', 7, 1, 1, '0', NULL, '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('78a992ab-fd2e-4af2-ac75-d66582497500', '自助终端通知编号', 'ZZZD', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-10-08 14:20:17', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('7c1a3048-834d-4f85-98c7-2b51c9bac289', '新增限购', 'XGBH', '{NO}', NULL, 7, 1, 1, '1', '2019-05-16 09:40:21', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('7dddc16e-6453-4440-a290-d2d3fdeb68f2', '费用减免', 'FYJM', '{yyyyMMDDNO}', '1', 7, 1, 1, '1', '2019-05-30 09:33:16', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('7f78cb1b-8d58-4618-919b-bb91bfb316f4', '新增变更申请', 'BGSQ', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-10-11 16:52:10', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('864a504e-5869-42e6-a588-3a90fbb93857', '新增通知', 'TZBH', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-11-14 11:56:15', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('89077b03-2597-4a99-9bb8-b3177e0e6c21', '预存款统计报表编号', 'YCTJ', '{yyyyMMNO}', '3', 5, 1, 1, '1', '2019-03-06 14:16:15', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('8b0693a1-da1a-430a-9499-334df5d2fd7c', '收费解款编号', 'JKBH', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-10-07 17:14:27', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('8c7d9d25-c0f6-4da4-abb3-c5798789e15c', '帮助信息编号', 'BZXX', '{NO}', NULL, 5, 1, 1, '1', '2019-04-19 10:42:39', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('8cf7a7b4-8e7f-4127-8ff7-b4f0de1f116e', '反馈信息编号', 'FKXX', '{yyyyMMDDNO}', '1', 5, 1, 1, '1', '2019-08-02 13:04:24', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('8e13dc68-2048-4c61-8df2-4f3a0bb32226', '新增表设备信息', 'SBBH', '{NO}', NULL, 6, 1, 1, '1', '2018-12-06 11:03:07', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('90090b77-fb16-4c22-8e94-5857b7e8b837', '过户', 'GH', '{YYYYMMDDHH}', NULL, 8, 1, 20181219, '0', NULL, '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('90ffb404-58a3-4c30-bf35-60e496d57ada', '抄表册', 'CBCH', '{NO}', NULL, 4, 1, 1, '1', '2019-07-24 10:26:50', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('941c9569-27e5-49d3-8076-3bebc2ffd741', '新增团缴户', 'TJH', '{NO}', NULL, 4, 1, 1, '1', '2019-03-12 17:13:08', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('950679cf-5997-4497-a74e-ad03ce27b42d', '支付宝配置编号', 'ALPC', '{NO}', NULL, 5, 1, 1, '1', '2019-01-10 09:08:35', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('97f6adea-ffb4-4c4b-8855-aa710d0aa511', '传感网络设置编号', 'CGBH', '{NO}', NULL, 4, 1, 1, '1', '2019-09-19 14:17:40', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('983b804a-a22f-4af6-9289-ca4f026e0ee8', '新增楼栋', 'LDBH', '{NO}', NULL, 6, 1, 1, '1', '2019-10-31 15:54:14', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('9fb1ac54-5204-47bf-95c2-f671642dda61', '票本领取记录', 'PBLQ', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-09-28 09:16:20', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('a022502b-28bb-417a-9337-8bce98b87cd7', '报装类型', 'BZLE', '{NO}', NULL, 3, 1, 1, '1', '2019-10-30 10:27:20', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('a11ce0ca-94a5-4ee5-98a2-df17bbdb4da5', '报警编号', 'BJBH', '{yyyyMMDDNO}', '1', 6, 1, 1, '1', '2019-11-08 14:32:30', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('a22d5b13-d7af-42bf-91d6-9a0147cb555a', '新增年度安检计划', 'ANJH', '{NO}', NULL, 7, 1, 1, '1', '2019-06-13 12:01:08', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('a6aa3085-315a-4c7e-adca-8e8b79094f87', '新增业务设置', 'SETT', '{NO}', NULL, 5, 1, 1, '1', '2019-06-15 13:11:24', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('a7c258b2-0cf5-4eeb-943f-1adafd9aa73b', '岗位编码', 'GWBH', '{NO}', NULL, 4, 1, 1, '1', '2019-09-18 10:57:32', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('a966408b-51ae-49ba-ab35-24fdafc8facc', '预存款记录编号', 'YCJL', '{yyyyMMDDNO}', '1', 7, 1, 1, '1', '2019-11-06 14:06:39', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('a988a78a-b26d-47f1-84a6-b0edeac1b8e3', '申请编号', 'WXSQ', '{yyyyMMddNO}', NULL, 4, 1, 1, '1', '2018-12-21 14:50:19', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('ab88f3dc-31d5-4250-a277-03306332ba9c', '机构编码', 'JGBH', '{NO}', NULL, 2, 1, 1, '1', '2019-10-21 10:27:28', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('b1afc3aa-11bb-4353-95c9-edcfa43ebbf4', '应收费编号', 'YSBH', '{yyyyMMDDNO}', '1', 7, 1, 1, '1', '2019-11-06 14:06:38', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('b54f45fe-ba8b-466f-b30d-a1f60387f0ae', '新增地址', 'ADDR', '{NO}', NULL, 7, 1, 1, '1', '2019-10-31 15:54:14', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('b58e9bcd-fa59-45e6-9996-9eb270a9f854', '充值记录编号', 'CZJL', '{yyyyMMDDNO}', '1', 5, 1, 1, '1', '2019-10-18 14:33:50', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('b832e6c9-8e3b-4406-b778-6a60db8e80d1', '安检计划编号', 'ajjh', '{NO}', NULL, 6, 1, 1, '1', NULL, '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('b832e6c9-8e3b-4406-b778-6a60db8e80de', '新增收费', 'FYBH', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2018-11-29 12:05:34', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('ba97f334-bfde-4b6f-954b-b6c85269cc22', '新增销户申请', 'XHSQ', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-06-24 14:07:25', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('bd2249a3-f9f8-4ba7-aef3-2b538b1763d0', '追加气量', 'ZJBH', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-11-21 15:44:18', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('bf6cb911-1041-4c89-93a3-2b8f342540cb', '银行对账编号', 'YHDZ', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2018-12-24 15:48:05', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('c21ffb1e-c584-42a9-8360-6726a1757780', '隐患级别', 'DANG', '{NO}', NULL, 7, 1, 1, '1', '2019-07-23 15:13:34', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('c4a19f7c-958a-4a8a-bd7e-1c9d94ee53c0', '价格设置', 'JGSZ', '{NO}', NULL, 6, 1, 1, '1', '2019-08-29 15:05:20', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('c4f769cb-a7a5-4f53-88c2-ed41a0e4cd00', '气表型号', NULL, '{NO}', NULL, 8, 1, 1, '1', '2019-10-28 15:11:42', '0');
INSERT INTO `BASE_CODE_RULE` VALUES ('c85d6cba-371d-4224-9bb2-4c4f516f5529', '新增合同', 'HTBH', '{yyyyMMDDNO}', '1', 5, 1, 1, '1', '2019-11-06 15:02:40', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('cb5d7237-2603-4e5c-bffb-ceb2cd7ce70f', '远程表操作', 'YCMO', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-03-19 16:16:01', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('cb775191-2f05-452d-a35c-21967c05e09a', '安检隐患', 'AJYH', '{NO}', NULL, 7, 1, 1, '1', '2019-09-25 15:51:45', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('ccb5c5d1-2d41-4661-97e6-40f38da73039', '新增证件', 'ZJBH', '{yyyyMMDDNO}', '1', 5, 1, 1, '1', '2019-06-04 15:06:56', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('cda019e7-5db2-4aab-88a9-acf63ca98a6e', '票据模板编号', 'PJMB', '{NO}', NULL, 5, 1, 1, '1', '2019-09-22 18:05:12', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('cf3c6f97-45ea-4714-a613-0ece31bcd284', '知识类型', 'ZSLX', '{NO}', NULL, 8, 1, 1, '1', '2019-05-04 09:11:36', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('d06f3059-6816-4150-a4cc-c8b34aac7bd0', '用气类型', NULL, '{NO}', NULL, 4, 1, 1, '1', '2019-12-11 14:41:26', '0');
INSERT INTO `BASE_CODE_RULE` VALUES ('d18d7a75-add8-4843-9ac5-edd85f5c1894', '退费管理编号', 'TFSQ', '{YYYYMMDDNO}', '1', 3, 1, 1, '1', '2019-05-08 07:44:18', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('d22462fa-a075-4f98-8244-a916e013db37', '设置采暖性质', 'CLBH', '{NO}', NULL, 4, 1, 1, '1', '2019-03-01 09:31:02', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('d38b55e7-ada4-4e5d-95e5-4d88df85b5be', '开卡', 'ICLS', '{NO}', NULL, 8, 1, 1, '1', '2019-10-23 09:45:03', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('d3d11cb1-8952-4e08-818c-0d4dce603047', '转账编号', 'ZZBH', '{yyyyMMDDNO}', NULL, 3, 1, 1, '1', '2019-05-09 08:49:09', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('d497afcf-de4c-4196-a982-c12be2e20a62', '特殊客户补贴编号', 'TKYZ', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-02-25 17:10:45', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('d4be6ce4-19fe-4f98-a260-1c0bc6852fdb', '商品类别', 'LBBH', '{NO}', NULL, 4, 1, 1, '1', '2019-09-10 16:16:12', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('d56bfe5f-e164-4ab9-84d7-110bb9f0f69d', '新增客户', 'CUST', '{NO}', NULL, 7, 1, 1, '1', '2019-10-24 10:04:03', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('d7484d62-4b3f-4890-8041-ba17b4d45c93', '收费远程交接编号', 'YCJJ', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-09-25 09:33:53', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('da2b2369-729e-46d9-8a3d-a70cc73a7dcc', '气量调整', 'TZBH', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-10-12 15:19:50', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('e4edfe38-017a-461f-8aa6-055af47f3bf3', '微信配置编号', 'WXPC', '{NO}', NULL, 5, 1, 1, '1', '2019-09-19 16:10:04', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('e6ef425f-29e2-4fb7-81e2-fcb9383db23c', '报装改造', 'BZGZ', '{yyyyMMDDNO}', '1', 4, 1, 1, '1', '2019-10-23 10:49:07', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('e855479a-a308-405b-ad16-01548eedf20a', '客户调账编号', 'TZSQ', '{yyyyMMDDNO}', '1', 3, 1, 1, '0', NULL, '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('eeb7779a-704b-445e-9ae4-0058e39c60c2', '工单创建', 'GDBH', '{yyyyMMDDNO}', '1', 6, 1, 1, '0', NULL, '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('f1bf8be0-ab9a-4533-b4f2-cdfc24aedf9a', '票据类型编号', 'PJLX', '{NO}', NULL, 3, 1, 1, '1', '2019-03-07 09:52:46', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('f606debf-71dc-4537-b85e-c635285a8442', '工作流编号', 'GZBM', '{yyyyMMDDNO}', '1', 5, 1, 1, '1', '2019-06-18 10:50:28', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('f84ee0b8-f7a5-47eb-a504-7f15d025ef11', '临时任务', 'LSRW', '{yyyyMMDDNO}', '1', 3, 1, 1, '1', '2019-10-09 16:46:59', '1');
INSERT INTO `BASE_CODE_RULE` VALUES ('f9e1da35-3dc3-47f8-aa80-bef62b5cc995', '退费编号', 'TRM', '{yyyyMMDDNO}', '1', 5, 1, 1, '1', '2018-09-28 09:46:48', '1');

-- ----------------------------
-- Table structure for BASE_COLLECTION_AGENCY
-- ----------------------------
DROP TABLE IF EXISTS `BASE_COLLECTION_AGENCY`;
CREATE TABLE `BASE_COLLECTION_AGENCY`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `FTP` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'FTP地址',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方代收机构' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_COLLECTION_AGENCY
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_COOKER_CONNECTION_MODE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_COOKER_CONNECTION_MODE`;
CREATE TABLE `BASE_COOKER_CONNECTION_MODE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '灶具连接方式' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_COOKER_CONNECTION_MODE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_COOKER_INSTALLATION_MODE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_COOKER_INSTALLATION_MODE`;
CREATE TABLE `BASE_COOKER_INSTALLATION_MODE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '灶具安装方式' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_COOKER_INSTALLATION_MODE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_CREDENTIALS_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CREDENTIALS_TYPE`;
CREATE TABLE `BASE_CREDENTIALS_TYPE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '证件类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CREDENTIALS_TYPE
-- ----------------------------
INSERT INTO `BASE_CREDENTIALS_TYPE` VALUES ('67f474ba-d15d-4448-bf69-a2dbf9417a2c', '临时身份证');
INSERT INTO `BASE_CREDENTIALS_TYPE` VALUES ('b14b2eb4-b557-4268-b06b-7ed6469e0b31', '护照');
INSERT INTO `BASE_CREDENTIALS_TYPE` VALUES ('b59a7245-15c4-4ca1-a8e2-9aa78facd46a', '二代社保卡');
INSERT INTO `BASE_CREDENTIALS_TYPE` VALUES ('d04cba35-ff24-4ed8-9f84-84fcdc543d7e', '身份证');

-- ----------------------------
-- Table structure for BASE_CUSTOMER_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_CUSTOMER_TYPE`;
CREATE TABLE `BASE_CUSTOMER_TYPE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户类型',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '客户类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_CUSTOMER_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_DEFAULT_SETTINGS
-- ----------------------------
DROP TABLE IF EXISTS `BASE_DEFAULT_SETTINGS`;
CREATE TABLE `BASE_DEFAULT_SETTINGS`  (
  `INSTALL_METER_JOB_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '挂表工单类型',
  `UNINSTALL_METER_JOB_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拆表工单类型',
  `CHANGE_METER_JOB_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '换表工单类型',
  `VENTILATE_JOB_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通气工单类型',
  `MAINTENANCE_JOB_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '维修工单类型',
  `INSTALL_APPLICATION_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报装工单类型',
  `SERVER_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IC卡服务地址',
  `SERVER_PORT` decimal(38, 0) NULL DEFAULT NULL COMMENT 'IC卡服务端口',
  `SERVER_PATH` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IC卡服务路径',
  `IS_NOTICE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表审核后通知客户',
  `SMS_VERIFY` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录是否需要短信验证',
  `REMOTE_METER_ALERT_JOB_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '远传表报警工单类型',
  `PAGE_SIZE` decimal(4, 0) NULL DEFAULT NULL COMMENT '每页条数',
  `REMOTE_METER_AUTO_AUDIT` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统结算远传表自动审核（是\\否）',
  `REMOTE_METER_TYPE1` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '远程表类型一',
  `REMOTE_METER_TYPE2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '远程表类型二',
  `IC_METER_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'IC卡燃气表',
  `DATA_PERMISSION` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据权限',
  `AUDITDATE_METERDATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计费方案'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '默认设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_DEFAULT_SETTINGS
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_FACTORY
-- ----------------------------
DROP TABLE IF EXISTS `BASE_FACTORY`;
CREATE TABLE `BASE_FACTORY`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编号',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_FACTORY
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_GAS_METER_MODEL
-- ----------------------------
DROP TABLE IF EXISTS `BASE_GAS_METER_MODEL`;
CREATE TABLE `BASE_GAS_METER_MODEL`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表类型id',
  `MODEL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表型号',
  `MAKER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产厂家',
  `RATED_FLOW` decimal(13, 2) NOT NULL COMMENT '额定流量',
  `MAX_FLOW` decimal(13, 2) NOT NULL COMMENT '最大流量',
  `CARD_INSERT_DIRECTION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '插卡方向',
  `INTAKE_DIRECTION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '进气方向',
  `CALIBRATION_RANGE` decimal(13, 2) NULL DEFAULT NULL COMMENT '标定量程',
  `TEMPERATURE_COMPENSATION` decimal(13, 2) NULL DEFAULT NULL COMMENT '温度补偿',
  `METER_DIGIT` decimal(38, 0) NOT NULL COMMENT '表位数',
  `PAY_TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '付费类型',
  `IS_ENABLE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否在用',
  `CARD_FLAG` decimal(38, 0) NULL DEFAULT NULL COMMENT 'ic卡标识',
  `STATEMENT_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '结算方式',
  `VERSION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '气表版号',
  `MAKER_CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '厂家代码',
  `FLOWMETER_BORE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流量计口径',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '气表型号' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_GAS_METER_MODEL
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_GAS_METER_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_GAS_METER_TYPE`;
CREATE TABLE `BASE_GAS_METER_TYPE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表类型',
  `IS_MANUAL_METER_READING` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否需要人工抄表',
  `IS_REMOTE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否远程',
  `REMOTE_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '远程表类型code',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '气表类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_GAS_METER_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_GAS_PROPERTY
-- ----------------------------
DROP TABLE IF EXISTS `BASE_GAS_PROPERTY`;
CREATE TABLE `BASE_GAS_PROPERTY`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气性质名称',
  `GT_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气类型id',
  `SECURITY_CHECK_CYCLE` decimal(9, 0) NOT NULL COMMENT '安检周期(月)',
  `PENALTY_START_DAY` decimal(38, 0) NULL DEFAULT NULL COMMENT '违约金起算天数',
  `PENALTY_START_MONEY` decimal(13, 2) NULL DEFAULT NULL COMMENT '违约金起算金额',
  `PENALTY_PERCENT` decimal(13, 2) NULL DEFAULT NULL COMMENT '违约金比例',
  `PENALTY_PERCENT_UPPER_LIMIT` decimal(13, 2) NULL DEFAULT NULL COMMENT '违约金比例上限',
  `REMARKS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  `IS_ENABLE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '使用标志，是|否',
  `IS_HEATING` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否采暖期,是|否',
  `DERATE_PENALTY_DAY_TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '免滞纳金天数计算方式',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用气性质' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_GAS_PROPERTY
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_GAS_PURCHASE_ORG
-- ----------------------------
DROP TABLE IF EXISTS `BASE_GAS_PURCHASE_ORG`;
CREATE TABLE `BASE_GAS_PURCHASE_ORG`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `FULLNAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单位全称',
  `SHORTNAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单位简称',
  `CONTACTS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `ADDRESS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '单位地址',
  `IS_ENABLE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '使用标志,是|否',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '购气单位' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_GAS_PURCHASE_ORG
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_GAS_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_GAS_TYPE`;
CREATE TABLE `BASE_GAS_TYPE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气类型',
  `IS_ENABLE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '使用标志，是|否',
  `ADVANCE_DEPOSIT_THRESHOLD` decimal(11, 2) NULL DEFAULT NULL COMMENT '预存款阈值',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用气类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_GAS_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_IC_KEY
-- ----------------------------
DROP TABLE IF EXISTS `BASE_IC_KEY`;
CREATE TABLE `BASE_IC_KEY`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `FACTORY_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WRITE_KEY1` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `WRITE_KEY2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_IC_KEY
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_IC_PARAM
-- ----------------------------
DROP TABLE IF EXISTS `BASE_IC_PARAM`;
CREATE TABLE `BASE_IC_PARAM`  (
  `FIRST_EARLY_WARNING` decimal(13, 2) NOT NULL COMMENT '一次预警量',
  `SECOND_EARLY_WARNING` decimal(13, 2) NOT NULL COMMENT '二次预警量',
  `RECHARGE_LOWER_LIMIT` decimal(13, 2) NOT NULL COMMENT '充值下限',
  `RECHARGE_UPPER_LIMIT` decimal(13, 2) NOT NULL COMMENT '充值上限',
  `OVERDRAFT` decimal(13, 2) NULL DEFAULT NULL,
  `GAS_TYPE_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'IC卡参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_IC_PARAM
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_INSTALL_LOCATION
-- ----------------------------
DROP TABLE IF EXISTS `BASE_INSTALL_LOCATION`;
CREATE TABLE `BASE_INSTALL_LOCATION`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '位置名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '安装位置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_INSTALL_LOCATION
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_KNOWLEDGE_BASE_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_KNOWLEDGE_BASE_TYPE`;
CREATE TABLE `BASE_KNOWLEDGE_BASE_TYPE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `SUBTYPEID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PIDS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL,
  `UPDATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `UPDATE_DATE` datetime(0) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_KNOWLEDGE_BASE_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_MATERIAL
-- ----------------------------
DROP TABLE IF EXISTS `BASE_MATERIAL`;
CREATE TABLE `BASE_MATERIAL`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `MT_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '材料分类id',
  `SPECIFICATIONS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格',
  `TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '型号',
  `UNIT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单位',
  `REMARKS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  `PRICE` decimal(13, 2) NULL DEFAULT NULL COMMENT '单价',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '材料' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_MATERIAL
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_MATERIAL_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_MATERIAL_TYPE`;
CREATE TABLE `BASE_MATERIAL_TYPE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类名称',
  `IS_ENABLE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '使用标识，是|否',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '材料分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_MATERIAL_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_NEED_SETTING
-- ----------------------------
DROP TABLE IF EXISTS `BASE_NEED_SETTING`;
CREATE TABLE `BASE_NEED_SETTING`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BUSINESS_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '业务名称',
  `FIND_SIGN` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一查询标识',
  `IS_NEED` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设置是否',
  `SETTING_TIME` datetime(0) NULL DEFAULT NULL COMMENT '设置时间',
  `SETTING_USER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '设置用户'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_NEED_SETTING
-- ----------------------------
INSERT INTO `BASE_NEED_SETTING` VALUES ('SETT00002', '用气性质变更审批', 'GASC', '1', '2019-03-20 14:22:50', 'super');
INSERT INTO `BASE_NEED_SETTING` VALUES ('SETT00004', '通气审批', 'TQSP', '1', '2019-03-28 19:01:10', 'super');
INSERT INTO `BASE_NEED_SETTING` VALUES ('SETT00006', '销户审批', 'XHSP', '1', '2019-06-15 22:28:00', NULL);
INSERT INTO `BASE_NEED_SETTING` VALUES ('SETT00007', '过户审批', 'GHSP', '1', '2019-06-16 17:39:30', NULL);

-- ----------------------------
-- Table structure for BASE_PAY_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_PAY_TYPE`;
CREATE TABLE `BASE_PAY_TYPE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '结算方式' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_PAY_TYPE
-- ----------------------------
INSERT INTO `BASE_PAY_TYPE` VALUES ('25d988b4-86ef-4e7e-8cdf-e326d0b2ae9a', '刷卡');
INSERT INTO `BASE_PAY_TYPE` VALUES ('36917c58-a1be-4cb1-b66e-ba4fdcb98e11', '微信');
INSERT INTO `BASE_PAY_TYPE` VALUES ('474e7add-fd36-4538-94a5-337ac9b84a42', '挂账');
INSERT INTO `BASE_PAY_TYPE` VALUES ('8e336aee-0814-4c4e-b635-2a0cbfc1b692', '预存款');
INSERT INTO `BASE_PAY_TYPE` VALUES ('a3140051-e908-487b-8b98-dd50e7baafe3', '现金');
INSERT INTO `BASE_PAY_TYPE` VALUES ('b79a21c5-5166-45f7-9008-2cdfc40bdaec', '支付宝');
INSERT INTO `BASE_PAY_TYPE` VALUES ('c47d229c-ec4e-4a5b-a016-5c7d8f715c82', '转账');
INSERT INTO `BASE_PAY_TYPE` VALUES ('c7f163f4-1daa-41f2-8557-adf853280d3b', '支票');

-- ----------------------------
-- Table structure for BASE_PRICE_SETTINGS
-- ----------------------------
DROP TABLE IF EXISTS `BASE_PRICE_SETTINGS`;
CREATE TABLE `BASE_PRICE_SETTINGS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `PRICE` decimal(13, 2) NOT NULL COMMENT '价格',
  `CHARGE_WAY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新用户开户当年收取方法',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '价格设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_PRICE_SETTINGS
-- ----------------------------
INSERT INTO `BASE_PRICE_SETTINGS` VALUES ('JGSZ000001', '开户费用', 500.00, '3');
INSERT INTO `BASE_PRICE_SETTINGS` VALUES ('JGSZ000002', '过户费用', 350.55, '1');
INSERT INTO `BASE_PRICE_SETTINGS` VALUES ('JGSZ000003', '销户费用', 1000.00, '2');

-- ----------------------------
-- Table structure for BASE_RTS
-- ----------------------------
DROP TABLE IF EXISTS `BASE_RTS`;
CREATE TABLE `BASE_RTS`  (
  `SENSOR` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '传感网络IP及端口',
  `SERVICE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '远传微服务IP及端口',
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_RTS
-- ----------------------------
INSERT INTO `BASE_RTS` VALUES ('http://39.100.66.204:9000/rts/cis', 'http://39.100.66.204:', '1');

-- ----------------------------
-- Table structure for BASE_SECURITY_CHECK_CONTENT
-- ----------------------------
DROP TABLE IF EXISTS `BASE_SECURITY_CHECK_CONTENT`;
CREATE TABLE `BASE_SECURITY_CHECK_CONTENT`  (
  `GP_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气性质id',
  `SCSI_IDS` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '安检子项ids,多个id用,分开'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '安检内容' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_SECURITY_CHECK_CONTENT
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_SECURITY_CHECK_ITEM
-- ----------------------------
DROP TABLE IF EXISTS `BASE_SECURITY_CHECK_ITEM`;
CREATE TABLE `BASE_SECURITY_CHECK_ITEM`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '安检项名称',
  `TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '安检项类型,单选框|复选框|文字框',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '安检项' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_SECURITY_CHECK_ITEM
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_SECURITY_CHECK_SUBITEM
-- ----------------------------
DROP TABLE IF EXISTS `BASE_SECURITY_CHECK_SUBITEM`;
CREATE TABLE `BASE_SECURITY_CHECK_SUBITEM`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `SCI_IDS` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '安检项ids,多个用逗号分开',
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '安检子项名称',
  `DANGELEVEL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MIAOSHU` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '安检子项' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_SECURITY_CHECK_SUBITEM
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_SENSORNETWORK
-- ----------------------------
DROP TABLE IF EXISTS `BASE_SENSORNETWORK`;
CREATE TABLE `BASE_SENSORNETWORK`  (
  `POLLCODE` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `DOMAINID` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SENSOR_NETWORK` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `MICRO_SERVICE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DEPARTMENTID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DEPARTMENTNAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `LICENSE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_SENSORNETWORK
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_SENSORWORK_SCOTT
-- ----------------------------
DROP TABLE IF EXISTS `BASE_SENSORWORK_SCOTT`;
CREATE TABLE `BASE_SENSORWORK_SCOTT`  (
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DOMAINID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DBUSER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_SENSORWORK_SCOTT
-- ----------------------------
INSERT INTO `BASE_SENSORWORK_SCOTT` VALUES ('CGBH0004', '9bec1173-f616-4055-8562-11f839815d28', 'qcdb002.');
INSERT INTO `BASE_SENSORWORK_SCOTT` VALUES ('CGBH0005', '2ff82649-b783-450e-9980-0ec077675736', 'qcdb002.');
INSERT INTO `BASE_SENSORWORK_SCOTT` VALUES ('CGBH0006', '1c39515f-95de-4262-8f6e-8cf3692f90f4', 'qcdb002.');
INSERT INTO `BASE_SENSORWORK_SCOTT` VALUES ('CGBH0002', '3abe0cb6-d287-41ff-9afa-240292f457ae', 'qcdb002.');
INSERT INTO `BASE_SENSORWORK_SCOTT` VALUES ('CGBH0003', '013496d5-50de-4e61-83fb-67d054c73de2', 'qcdb002.');

-- ----------------------------
-- Table structure for BASE_SPECIAL_CUSTOMER_SUBSIDY
-- ----------------------------
DROP TABLE IF EXISTS `BASE_SPECIAL_CUSTOMER_SUBSIDY`;
CREATE TABLE `BASE_SPECIAL_CUSTOMER_SUBSIDY`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `SCT_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '特殊客户类型id',
  `SUBSIDY_GAS` decimal(13, 2) NOT NULL COMMENT '补贴气量',
  `SUBSIDY_MONEY` decimal(13, 2) NOT NULL COMMENT '补贴金额',
  `IS_ENABLE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否启用',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '特殊客户补贴参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_SPECIAL_CUSTOMER_SUBSIDY
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_SPECIAL_CUSTOMER_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_SPECIAL_CUSTOMER_TYPE`;
CREATE TABLE `BASE_SPECIAL_CUSTOMER_TYPE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '特殊客户类型',
  `IS_ENABLE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '启用标志,是|否',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '特殊客户类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_SPECIAL_CUSTOMER_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_STEP_PRICE_PARAM
-- ----------------------------
DROP TABLE IF EXISTS `BASE_STEP_PRICE_PARAM`;
CREATE TABLE `BASE_STEP_PRICE_PARAM`  (
  `NEW_IS_CONVERT` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '新户是否折算阶梯量，是|否'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '阶梯计费参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_STEP_PRICE_PARAM
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_STEP_PRICE_PROGRAMME
-- ----------------------------
DROP TABLE IF EXISTS `BASE_STEP_PRICE_PROGRAMME`;
CREATE TABLE `BASE_STEP_PRICE_PROGRAMME`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '方案名称',
  `CYCLE_UNIT` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '周期单位，月|季|年',
  `CYCLE_VALUE` decimal(38, 0) NOT NULL COMMENT '周期值',
  `CYCLE_EFFECTIVE_DATE` datetime(0) NOT NULL COMMENT '周期起始日期',
  `EFFECTIVE_DATE` datetime(0) NOT NULL COMMENT '方案生效日期',
  `IS_CLEAR` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调价是否清零',
  `GP_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气性质id',
  `IS_ENABLE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '启用标志，是|否',
  `STEP_MODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '阶梯方式，分段阶梯|实时阶梯',
  `STEP_NUM` decimal(38, 0) NOT NULL COMMENT '阶梯数，不能大于5',
  `FIRST_STEP_GAS` decimal(13, 2) NOT NULL COMMENT '第一阶梯气量',
  `FIRST_STEP_PRICE` decimal(13, 2) NOT NULL COMMENT '第一阶梯单价',
  `SECOND_STEP_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '第二阶梯气量',
  `SECOND_STEP_PRICE` decimal(13, 2) NULL DEFAULT NULL COMMENT '第二阶梯单价',
  `THIRD_STEP_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '第三阶梯气量',
  `THIRD_STEP_PRICE` decimal(13, 2) NULL DEFAULT NULL COMMENT '第三阶梯单价',
  `FOURTH_STEP_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '第四阶梯气量',
  `FOURTH_STEP_PRICE` decimal(13, 2) NULL DEFAULT NULL COMMENT '第四阶梯单价',
  `FIFTH_STEP_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '第五阶梯气量',
  `FIFTH_STEP_PRICE` decimal(13, 2) NULL DEFAULT NULL COMMENT '第五阶梯单价',
  `END_DATE` datetime(0) NULL DEFAULT NULL COMMENT '失效日期',
  `IS_USED` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否已被使用，是|否',
  `HEATING_PLAN` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '采暖期 0:表示不是采暖计划，1:采暖计划',
  `FAMILY_TOTAL` decimal(11, 0) NULL DEFAULT NULL COMMENT '家庭人口基数',
  `HUMAN_INCREMENT` decimal(11, 0) NULL DEFAULT NULL COMMENT '人增量',
  `VALUATION_OBJ` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计价对象,1.表具;2.家庭',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '阶梯计费方案' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_STEP_PRICE_PROGRAMME
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_SUPERPHONE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_SUPERPHONE`;
CREATE TABLE `BASE_SUPERPHONE`  (
  `PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'super账号电话号码',
  `NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '平台名称',
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_SUPERPHONE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_WORK_ORDER_PROCEDURE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_WORK_ORDER_PROCEDURE`;
CREATE TABLE `BASE_WORK_ORDER_PROCEDURE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WOT_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工单类型id',
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理流程名称',
  `CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '处理流程编号，自动生成',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工单流程' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_WORK_ORDER_PROCEDURE
-- ----------------------------

-- ----------------------------
-- Table structure for BASE_WORK_ORDER_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `BASE_WORK_ORDER_TYPE`;
CREATE TABLE `BASE_WORK_ORDER_TYPE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '工单类型',
  `TIME` decimal(10, 1) NOT NULL COMMENT '处理时间（时）',
  `IS_EXECUTE_END` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '工单类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BASE_WORK_ORDER_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for BONUS
-- ----------------------------
DROP TABLE IF EXISTS `BONUS`;
CREATE TABLE `BONUS`  (
  `ENAME` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `JOB` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SAL` decimal(65, 30) NULL DEFAULT NULL,
  `COMM` decimal(65, 30) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BONUS
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_ACTIVATE_CARD
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_ACTIVATE_CARD`;
CREATE TABLE `BUSINESS_ACTIVATE_CARD`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '开卡流水号',
  `CARD_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IC卡编号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `GAS_ADDRESS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气地址',
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表编号',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `FIRST_EARLY_WARNING` decimal(13, 2) NOT NULL COMMENT '一次预警量',
  `SECOND_EARLY_WARNING` decimal(13, 2) NOT NULL COMMENT '二次预警量',
  `RECHARGE_LOWER_LIMIT` decimal(13, 2) NOT NULL COMMENT '充值下限',
  `RECHARGE_UPPER_LIMIT` decimal(13, 2) NOT NULL COMMENT '充值上限',
  `PAY_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付费类别',
  `UNUSED_DAYS` decimal(38, 0) NULL DEFAULT NULL COMMENT '闲置天数',
  `IS_ACTIVATE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否开卡成功',
  `RECEIVE_RECORD_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应收费id',
  `IS_ACTIVATE_RECHARGE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否开卡后没有上表就充值',
  `TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开卡类型',
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '开卡时间',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经手人',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '开卡' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_ACTIVATE_CARD
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_BUY_GAS
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_BUY_GAS`;
CREATE TABLE `BUSINESS_BUY_GAS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '购气流水号',
  `BUY_ORG` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '购进单位',
  `BUY_GAS_QUANTITY` decimal(13, 2) NOT NULL COMMENT '购气量(方)',
  `BUY_GAS_AMOUNT` decimal(13, 2) NOT NULL COMMENT '单价',
  `ACCOUNT_MONTH` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账期月份',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '经手人',
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '购气' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_BUY_GAS
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_CANCEL_RECHARGE
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_CANCEL_RECHARGE`;
CREATE TABLE `BUSINESS_CANCEL_RECHARGE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '取消充值流水号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `CARD_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IC卡号',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `CREATE_DATE` datetime(0) NOT NULL COMMENT '取消时间',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收费员',
  `CORRECTION_AMOUNT` decimal(13, 2) NOT NULL COMMENT '冲正金额',
  `RECHARGE_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '充值流水号',
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '取消原因',
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表编号',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '取消充值' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_CANCEL_RECHARGE
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_CARD_ADJUST
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_CARD_ADJUST`;
CREATE TABLE `BUSINESS_CARD_ADJUST`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调整流水号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `CARD_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IC卡号',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `CREATE_DATE` datetime(0) NOT NULL COMMENT '调整日期',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '经手人',
  `CONTENT` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '调整内容',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'IC卡数据调整' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_CARD_ADJUST
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_CHANGE_METER
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_CHANGE_METER`;
CREATE TABLE `BUSINESS_CHANGE_METER`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '换表编号',
  `CUSTOMER_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `ADDRESS_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气地址id',
  `GAS_ADDRESS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气地址',
  `OLD_METER_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '旧表编号',
  `OLD_METER_CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '旧表表身号',
  `OLD_METER_LAST_READING` decimal(13, 2) NOT NULL COMMENT '旧表上次读数',
  `OLD_METER_FACTORY` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '旧表厂家',
  `OLD_METER_MODEL` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '旧表型号',
  `OLD_METER_READING` decimal(13, 2) NOT NULL COMMENT '旧表止数',
  `NEW_METER_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新表编号',
  `NEW_METER_CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新表表身号',
  `NEW_METER_MODEL` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新表型号',
  `NEW_METER_READING` decimal(13, 2) NULL DEFAULT NULL COMMENT '新表读数',
  `NEW_METER_FACTORY` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新表厂家',
  `NEW_METER_COMMUNICATION` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '新表通讯号',
  `NEW_INSTALLATION_SITE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '安装位置',
  `NEW_PAY_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付费类型',
  `NEW_PRICING_MANNER` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计价方式',
  `CHANGE_METER_DATE` datetime(0) NULL DEFAULT NULL COMMENT '换表日期',
  `CHANGE_METER_CAUSE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '换表原因',
  `CHANGE_METER_APPEND` decimal(13, 2) NULL DEFAULT NULL COMMENT '换表追加气量',
  `CHANGE_METER_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '换表人员',
  `IS_ENABLE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否启用',
  `JOB_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应工单号',
  `BOOKLET_DATA_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表记录编号',
  `OLD_METER_BALANCE` decimal(13, 2) NULL DEFAULT NULL COMMENT '旧表余额',
  `OLD_METER_RESIDUAL_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '旧表剩余气量',
  `CONTACTS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `PREDICT_COMPLETE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '预计完成时间',
  `CONTENT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作内容',
  `SYS_ORG_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单部门',
  `SYS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单人',
  `WORK_ORDER_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单类型',
  `METER_STATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表状态',
  `APPEND_CAUSE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '追加气量原因',
  `IS_SUPPLY` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否补过气',
  `NEW_METER_SUPPLY` decimal(11, 2) NULL DEFAULT NULL COMMENT '新表补气量',
  `IS_CLEAR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '3.0移除设备接口参数,是否清零',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '换表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_CHANGE_METER
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_CLEAR_CARD
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_CLEAR_CARD`;
CREATE TABLE `BUSINESS_CLEAR_CARD`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '清卡流水号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `CARD_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IC卡号',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `CREATE_DATE` datetime(0) NOT NULL COMMENT '清卡日期',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '经手人',
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '清卡原因',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '清卡' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_CLEAR_CARD
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_INSTALL_METER
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_INSTALL_METER`;
CREATE TABLE `BUSINESS_INSTALL_METER`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '挂表编号',
  `CUSTOMER_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `ADDRESS_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址编号',
  `GAS_ADDRESS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气地址',
  `CONTACTS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系人',
  `PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系电话',
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `JOB_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应工单号',
  `IS_FINISH` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否完成',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '经手人',
  `CREATE_DATE` datetime(0) NOT NULL COMMENT '申请时间',
  `PREDICT_COMPLETE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '预计完成时间',
  `CONTENT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作内容',
  `SYS_ORG_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单部门',
  `SYS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单人',
  `WORK_ORDER_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单类型',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '挂表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_INSTALL_METER
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_METER
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_METER`;
CREATE TABLE `BUSINESS_METER`  (
  `ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `METER_CODE` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `apply_date` datetime(0) NULL DEFAULT NULL,
  `applicant` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_METER
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_POOR_SUBSIDY
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_POOR_SUBSIDY`;
CREATE TABLE `BUSINESS_POOR_SUBSIDY`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '补贴流水号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `CARD_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IC卡号',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `CREATE_DATE` datetime(0) NOT NULL COMMENT '补贴日期',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '经手人',
  `SUBSIDY_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '补贴方式,金额|气量',
  `SUBSIDY_AMOUNT` decimal(13, 2) NULL DEFAULT NULL COMMENT '补贴金额',
  `SUBSIDY_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '补贴气量',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '特困低保客户补贴' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_POOR_SUBSIDY
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_RECHARGE
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_RECHARGE`;
CREATE TABLE `BUSINESS_RECHARGE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '充值流水号',
  `CARD_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IC卡编号',
  `BALANCE` decimal(13, 2) NOT NULL COMMENT '本次结余',
  `RECHARGE_AMOUNT` decimal(13, 2) NOT NULL COMMENT '写卡金额',
  `RECHARGE_QUANTITY` decimal(13, 2) NOT NULL COMMENT '写卡量',
  `CREATE_DATE` datetime(0) NOT NULL COMMENT '购气时间',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '经手人',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表身号',
  `STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '充值状态,0:已取消,1:成功,2:失败,3:写卡中',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表编号',
  `GAS1` decimal(11, 2) NULL DEFAULT NULL COMMENT '一阶梯气量',
  `AMOUNT1` decimal(11, 2) NULL DEFAULT NULL COMMENT '一阶梯费用',
  `GAS2` decimal(11, 2) NULL DEFAULT NULL COMMENT '二阶梯气量',
  `AMOUNT2` decimal(11, 2) NULL DEFAULT NULL COMMENT '二阶梯费用',
  `GAS3` decimal(11, 2) NULL DEFAULT NULL COMMENT '三阶梯气量',
  `AMOUNT3` decimal(11, 2) NULL DEFAULT NULL COMMENT '三阶梯费用',
  `GAS4` decimal(11, 2) NULL DEFAULT NULL COMMENT '四阶梯气量',
  `AMOUNT4` decimal(11, 2) NULL DEFAULT NULL COMMENT '四阶梯费用',
  `GAS5` decimal(11, 2) NULL DEFAULT NULL COMMENT '五阶梯气量',
  `AMOUNT5` decimal(11, 2) NULL DEFAULT NULL COMMENT '五阶梯费用',
  `COUNTER_CHARGE_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费编号',
  `STEP_PRICE_PROGRAMME_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阶梯id',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '充值' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_RECHARGE
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_SMS_INFO
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_SMS_INFO`;
CREATE TABLE `BUSINESS_SMS_INFO`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '短信编号',
  `TEMPLATE_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信模版',
  `SMS_CONTENT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '短信内容',
  `SEND_OBJ` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '发送对象,可以是管理区域、街道、小区、楼栋或客户号',
  `GAS_PROPERTY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气性质id',
  `IS_AUDIT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否审核',
  `AUDIT_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `AUDIT_DATE` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `AUDIT_OPINION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核意见',
  `AUDIT_STATE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '审核状态，未发起|待审核|已审核|拒绝|退回',
  `IS_SEND` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发送状态，未发送|发送中|已发送',
  `SEND_RESULT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发送结果',
  `SEND_TIME` datetime(0) NULL DEFAULT NULL COMMENT '发送时间',
  `OBJ_TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发送对象类型,人员|区域',
  `IS_TIMING` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否定时发送',
  `REAL_SEND_TIME` datetime(0) NULL DEFAULT NULL COMMENT '实际发送时间',
  `SEND_OBJ_NAME` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '发送对象名称',
  `BUSINESS_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信类型',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短信信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_SMS_INFO
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_SMS_TEMPLATE
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_SMS_TEMPLATE`;
CREATE TABLE `BUSINESS_SMS_TEMPLATE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模板编号',
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模板名称',
  `BUSINESS_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '短信类型,通知类|营销类',
  `TEMPLATE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模板内容',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '短信模板' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_SMS_TEMPLATE
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_SUPPLEMENT_CARD
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_SUPPLEMENT_CARD`;
CREATE TABLE `BUSINESS_SUPPLEMENT_CARD`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '开卡流水号',
  `CARD_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IC卡编号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `GAS_ADDRESS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气地址',
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表编号',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `IS_ACTIVATE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否开卡成功',
  `RECEIVE_RECORD_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应收费id',
  `CREATE_DATE` datetime(0) NOT NULL COMMENT '补卡日期',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '经手人',
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '补卡类型',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '补卡' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_SUPPLEMENT_CARD
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_SUPPLY_GAS
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_SUPPLY_GAS`;
CREATE TABLE `BUSINESS_SUPPLY_GAS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '补气流水号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `CARD_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IC卡号',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `CREATE_DATE` datetime(0) NOT NULL COMMENT '销卡日期',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '经手人',
  `SUPPLY_GAS_QUANTITY` decimal(13, 2) NULL DEFAULT NULL COMMENT '补气量',
  `SUPPLY_GAS_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '补气类型',
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '补气类型',
  `METER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表编号',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '补气' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_SUPPLY_GAS
-- ----------------------------

-- ----------------------------
-- Table structure for BUSINESS_UNINSTALL_METER
-- ----------------------------
DROP TABLE IF EXISTS `BUSINESS_UNINSTALL_METER`;
CREATE TABLE `BUSINESS_UNINSTALL_METER`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '拆表编号',
  `CUSTOMER_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `GAS_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气地址',
  `METER_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '气表编号',
  `METER_CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表表身号',
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '申请人',
  `CREATE_DATE` datetime(0) NOT NULL COMMENT '申请时间',
  `JOB_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应工单号',
  `ADDRESS_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址编号',
  `UNINSTALL_READING` decimal(13, 2) NULL DEFAULT NULL COMMENT '拆表读数',
  `CARD_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '卡表气量',
  `CARD_COST` decimal(13, 2) NULL DEFAULT NULL COMMENT '卡表费用',
  `UPDATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '录入人',
  `UPDATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '录入时间',
  `BOOKLET_DATA_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表记录编号',
  `CONTACTS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `PREDICT_COMPLETE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '预计完成时间',
  `CONTENT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作内容',
  `SYS_ORG_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单部门',
  `SYS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单人',
  `WORK_ORDER_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单类型',
  `METER_STATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表状态',
  `IS_CLEAR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '3.0移除设备接口参数,是否清零',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '拆表申请' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of BUSINESS_UNINSTALL_METER
-- ----------------------------

-- ----------------------------
-- Table structure for CHECK_RESK
-- ----------------------------
DROP TABLE IF EXISTS `CHECK_RESK`;
CREATE TABLE `CHECK_RESK`  (
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMERNO` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户编号',
  `BRIEF` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '险情简述',
  `PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `DETAIL` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '险情详述',
  `ADDRESS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '险情地址',
  `PIC` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否存在附件1存在0不存在',
  `STATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单状态0未发起1处理中2处理完毕',
  `DEPARTMENT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单部门',
  `PEOPLE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单人',
  `TYPE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单类别',
  `WORK_CODE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单编号',
  `DEPARTMENTID` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单部门ID'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of CHECK_RESK
-- ----------------------------
INSERT INTO `CHECK_RESK` VALUES ('XQSB0000001', '11', '22', '44', '33', '55', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for COST_RELIEF
-- ----------------------------
DROP TABLE IF EXISTS `COST_RELIEF`;
CREATE TABLE `COST_RELIEF`  (
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '减免编号',
  `REMISSION_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '减免类型',
  `RELATED_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '相关申请编号',
  `FEE_REDUCTIONS` double NOT NULL COMMENT '减免费用',
  `RELIEF_REASON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '减免原因',
  `APPROVER` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `APPLY_DATE` datetime(0) NOT NULL COMMENT '申请时间',
  `AUDIT_TIME` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `REMISSION_STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `AUDIT_RESULT` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核结果',
  `AUDIT_OPINION` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '审核意见',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '费用减免' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of COST_RELIEF
-- ----------------------------

-- ----------------------------
-- Table structure for DATA_COPY_INFO
-- ----------------------------
DROP TABLE IF EXISTS `DATA_COPY_INFO`;
CREATE TABLE `DATA_COPY_INFO`  (
  `TABLE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '8.0表名称',
  `PAGE_SIZE` decimal(65, 30) NOT NULL COMMENT '每页记录数',
  `CURRENT_PAGE` decimal(65, 30) NOT NULL COMMENT '当前页',
  `IS_OVER` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否完成',
  `ACTION_TIME` datetime(0) NULL DEFAULT NULL COMMENT '执行时间',
  `DB_USER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账套/数据库用户',
  `ID` decimal(10, 0) NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of DATA_COPY_INFO
-- ----------------------------

-- ----------------------------
-- Table structure for DATA_MOVE
-- ----------------------------
DROP TABLE IF EXISTS `DATA_MOVE`;
CREATE TABLE `DATA_MOVE`  (
  `OLDID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '原ID',
  `NEWID` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '新ID',
  `DBUSER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账套信息'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据库迁移中间表，替换字段用' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of DATA_MOVE
-- ----------------------------

-- ----------------------------
-- Table structure for DB_CLEAN_EXCLUDE
-- ----------------------------
DROP TABLE IF EXISTS `DB_CLEAN_EXCLUDE`;
CREATE TABLE `DB_CLEAN_EXCLUDE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EXCLUDE_TABLE_NAME` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '排除表名',
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of DB_CLEAN_EXCLUDE
-- ----------------------------
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('0d9d32da-a62e-4004-b6ac-97af5e1b7d25', 'QRTZ_SIMPLE_TRIGGERS', '2019-09-17 17:26:40');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('10d3857e-4ef9-459b-b61e-3eb512229b46', 'SYS_MODULE', '2019-09-17 18:26:37');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('139f93ab-cec6-4082-9fc8-df41240551a9', 'BASE_AREADATA', '2019-09-17 18:13:59');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('2e1a3bba-0709-4d54-89d5-2d02eaf663a3', 'ARCHIVES_HEATING_SIGN', '2019-09-17 18:15:30');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('36c1e96e-eb5c-4fdb-90e6-7a3dae923662', 'QRTZ_PAUSED_TRIGGER_GRPS', '2019-09-17 17:26:18');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('3b85fa1d-ea0a-44f0-8668-12dea8e63ffa', 'FINANCE_NOTES_TYPE', '2019-09-17 17:39:35');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('49f2df49-4168-4d4e-8490-c27d70525fb7', 'QRTZ_SIMPROP_TRIGGERS', '2019-09-17 17:26:51');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('55775f15-5daa-4c2b-923e-ea7598ad5afc', 'QRTZ_FIRED_TRIGGERS', '2019-09-17 17:25:44');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('570cbf17-75bb-4425-b6d7-51c1d9fccab5', 'QRTZ_LOCKS', '2019-09-17 17:26:07');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('5d9185a7-e84b-451b-b7ff-ebb8551610e3', 'QRTZ_TRIGGERS', '2019-09-17 17:27:03');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('653d1b30-f6c2-47de-8311-558018f8b94e', 'BASE_NEED_SETTING', '2019-09-17 18:11:21');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('6b4ff2fb-7b5c-4e04-8d55-518499f5c506', 'QRTZ_JOB_DETAILS', '2019-09-17 17:25:55');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('6d6cefa8-269b-422c-87f5-e67ec17f7e5d', 'SYS_DICTIONARY', '2019-09-17 18:16:52');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('71b7fcef-9a1d-4b0f-af19-5ae6d5e783d7', 'SYS_ORG', '2019-09-20 15:23:55');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('78bb1be8-a972-4ba7-904e-daa8ca24f014', 'SYS_USER', '2019-09-20 15:28:29');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('7c46f87b-2cf7-4703-a4d1-ac42874f8d90', 'base_pay_type', '2019-09-17 17:38:51');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('849bdcba-9674-4998-b553-42345d665d50', 'QRTZ_CALENDARS', '2019-09-17 17:25:23');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('90e84aa2-7cca-4a80-a210-01ec171ce831', 'APP_PARAMETERS', '2019-09-17 18:15:20');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('b09d3e6a-da78-4b0a-9123-157869bcf579', 'BASE_CODE_RULE', '2019-09-17 18:08:39');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('b7863514-098a-4978-92e3-2aeb237eea0f', 'BASE_CREDENTIALS_TYPE', '2019-09-17 18:16:01');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('bfb450c1-985a-4ea6-a030-fd3aa981feca', 'SYS_MODULEGROUP', '2019-09-17 18:29:57');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('c0843a2a-74c1-4cc5-9b8b-c75412997447', 'BASE_GAS_METER_TYPE', '2019-09-17 18:09:18');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('cf0a9415-ed41-4510-ae9d-292bbcb2869f', 'SYS_OPERATION', '2019-09-17 18:30:06');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('d1d0799d-8752-4219-b889-00a0076dab72', 'BASE_PAY_TYPE', '2019-09-17 18:09:51');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('db74a539-998c-419b-9b34-1826166defb8', 'BASE_PRICE_SETTINGS', '2019-09-17 18:11:00');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('dd5df64e-377c-4424-a34c-d3b543a03d97', 'SCHEDULE_JOB', '2019-09-17 17:27:20');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('e2ac0428-8a73-498e-aa56-7afacff166cf', 'SYS_USER_ROLE_MAPPING', '2019-09-20 15:29:01');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('ea769c38-6bb5-4a08-a62c-3ff3d8a2f363', 'SYS_BUTTON', '2019-09-17 18:16:43');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('ef3508f7-e6c5-4577-ae47-373f30865965', 'SYS_PARMA', '2019-09-20 15:24:20');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('f08171d6-4c77-4add-a968-f8d63f83800c', 'QRTZ_BLOB_TRIGGERS', '2019-09-17 17:25:11');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('f704497b-ed5b-410c-af08-6bb704b88bf3', 'SYS_ROLE', '2019-09-20 15:24:57');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('fb5055d5-00d6-4200-94d0-2beb3360f9ce', 'QRTZ_CRON_TRIGGERS', '2019-09-17 17:25:33');
INSERT INTO `DB_CLEAN_EXCLUDE` VALUES ('fc7f709c-95a2-4d29-9011-296f2b2cdadd', 'QRTZ_SCHEDULER_STATE', '2019-09-17 17:26:29');

-- ----------------------------
-- Table structure for DEPT
-- ----------------------------
DROP TABLE IF EXISTS `DEPT`;
CREATE TABLE `DEPT`  (
  `DEPTNO` decimal(2, 0) NOT NULL,
  `DNAME` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `LOC` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`DEPTNO`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of DEPT
-- ----------------------------
INSERT INTO `DEPT` VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO `DEPT` VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO `DEPT` VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO `DEPT` VALUES (40, 'OPERATIONS', 'BOSTON');

-- ----------------------------
-- Table structure for EMP
-- ----------------------------
DROP TABLE IF EXISTS `EMP`;
CREATE TABLE `EMP`  (
  `EMPNO` decimal(4, 0) NOT NULL,
  `ENAME` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `JOB` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `MGR` decimal(4, 0) NULL DEFAULT NULL,
  `HIREDATE` datetime(0) NULL DEFAULT NULL,
  `SAL` decimal(7, 2) NULL DEFAULT NULL,
  `COMM` decimal(7, 2) NULL DEFAULT NULL,
  `DEPTNO` decimal(2, 0) NULL DEFAULT NULL,
  PRIMARY KEY (`EMPNO`) USING BTREE,
  INDEX `FK_DEPTNO`(`DEPTNO`) USING BTREE,
  CONSTRAINT `FK_DEPTNO` FOREIGN KEY (`DEPTNO`) REFERENCES `DEPT` (`DEPTNO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of EMP
-- ----------------------------
INSERT INTO `EMP` VALUES (7369, 'SMITH', 'CLERK', 7902, '1980-12-17 00:00:00', 800.00, NULL, 20);
INSERT INTO `EMP` VALUES (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20 00:00:00', 1600.00, 300.00, 30);
INSERT INTO `EMP` VALUES (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22 00:00:00', 1250.00, 500.00, 30);
INSERT INTO `EMP` VALUES (7566, 'JONES', 'MANAGER', 7839, '1981-04-02 00:00:00', 2975.00, NULL, 20);
INSERT INTO `EMP` VALUES (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28 00:00:00', 1250.00, 1400.00, 30);
INSERT INTO `EMP` VALUES (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01 00:00:00', 2850.00, NULL, 30);
INSERT INTO `EMP` VALUES (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09 00:00:00', 2450.00, NULL, 10);
INSERT INTO `EMP` VALUES (7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19 00:00:00', 3000.00, NULL, 20);
INSERT INTO `EMP` VALUES (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17 00:00:00', 5000.00, NULL, 10);
INSERT INTO `EMP` VALUES (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08 00:00:00', 1500.00, 0.00, 30);
INSERT INTO `EMP` VALUES (7876, 'ADAMS', 'CLERK', 7788, '1987-05-23 00:00:00', 1100.00, NULL, 20);
INSERT INTO `EMP` VALUES (7900, 'JAMES', 'CLERK', 7698, '1981-12-03 00:00:00', 950.00, NULL, 30);
INSERT INTO `EMP` VALUES (7902, 'FORD', 'ANALYST', 7566, '1981-12-03 00:00:00', 3000.00, NULL, 20);
INSERT INTO `EMP` VALUES (7934, 'MILLER', 'CLERK', 7782, '1982-01-23 00:00:00', 1300.00, NULL, 10);

-- ----------------------------
-- Table structure for FINANCE_ALI_PAY
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE_ALI_PAY`;
CREATE TABLE `FINANCE_ALI_PAY`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `APP_ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `SELLER_ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `APP_PRIVATE_KEY` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ALIPAY_PUBLIC_KEY` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `RETURN_URL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PAY_NOTIFY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REFUND_NOTIFY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `GATEWAY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHARSET` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SIGN_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PARAM_TYPE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SUCCESS_REQUEST` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TRADE_CLOSE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATE_DATETIME` datetime(0) NOT NULL,
  `CREATE_EMPLOYEE_CODE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_EMPLOYEE_NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REMARK` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `APP_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RATE` decimal(11, 2) NOT NULL,
  `ORG_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '机构id',
  `ORG_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '机构名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FINANCE_ALI_PAY
-- ----------------------------

-- ----------------------------
-- Table structure for FINANCE_BANK_CHECK
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE_BANK_CHECK`;
CREATE TABLE `FINANCE_BANK_CHECK`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHECK_DATETIME` datetime(0) NOT NULL,
  `CHECK_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHECK_EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `FILE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_CHECK` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_ERROR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_CORRECT` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FINANCE_BANK_CHECK
-- ----------------------------

-- ----------------------------
-- Table structure for FINANCE_NOTES_MANAGE
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE_NOTES_MANAGE`;
CREATE TABLE `FINANCE_NOTES_MANAGE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TICKET_MANAGE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TICKET_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `STATUS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USE_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USE_EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USE_DATETIME` datetime(0) NOT NULL,
  `ADMINISTRATIVE_AREA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域',
  `ADMINISTRATIVE_AREA_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域编号',
  `NOTES_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_PRINT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NOTES_TYPE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NOTES_TYPE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USE_CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `USE_CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHARGE_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHARGE_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `USE_CUSTOMER_DATETIME` datetime(0) NULL DEFAULT NULL,
  `AFFILIATED_BUSINESS_HALL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业厅',
  `AFFILIATED_BUSINESS_HALL_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业厅编号',
  `TICKET_USE_RECORD_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '领用编号'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FINANCE_NOTES_MANAGE
-- ----------------------------
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000001', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4302', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000002', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4303', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000003', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4304', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000004', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4305', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000005', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4306', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000006', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4307', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000007', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4308', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000008', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4309', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000009', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4310', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000010', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4311', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000011', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4312', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000012', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4313', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000013', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4314', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000014', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4315', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000015', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4316', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000016', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4317', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000017', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4318', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000018', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4319', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000019', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4320', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000020', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4321', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000021', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4322', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000022', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4323', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000023', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4324', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000024', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4325', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000025', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4326', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000026', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4327', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000027', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4328', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000028', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4329', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000029', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4330', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000030', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4331', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000031', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4332', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000032', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4333', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000033', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4334', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000034', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4335', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000035', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4336', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000036', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4337', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000037', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4338', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000038', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4339', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000039', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4340', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000040', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4341', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000041', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4342', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000042', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4343', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000043', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4344', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000044', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4345', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000045', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4346', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000046', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4347', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000047', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4348', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000048', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4349', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000049', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4350', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000050', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4351', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000051', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4352', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000052', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4353', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000053', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4354', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000054', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4355', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000055', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4356', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000056', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4357', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000057', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4358', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000058', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4359', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000059', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4360', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000060', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4361', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000061', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4362', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000062', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4363', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000063', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4364', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000064', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4365', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000065', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4366', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000066', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4367', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000067', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4368', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000068', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4369', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000069', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4370', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000070', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4371', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000071', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4372', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000072', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4373', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000073', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4374', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000074', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4375', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000075', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4376', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000076', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4377', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000077', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4378', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000078', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4379', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000079', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4380', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000080', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4381', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000081', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4382', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000082', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4383', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000083', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4384', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000084', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4385', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000085', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4386', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000086', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4387', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000087', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4388', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000088', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4389', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000089', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4390', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000090', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4391', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000091', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4392', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000092', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4393', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000093', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4394', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000094', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4395', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000095', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4396', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000096', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4397', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000097', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4398', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000098', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4399', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000099', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4400', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000100', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4401', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000101', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4402', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000102', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4403', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000103', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4404', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000104', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4405', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000105', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4406', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000106', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4407', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000107', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4408', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000108', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4409', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000109', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4410', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000110', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4411', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000111', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4412', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000112', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4413', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000113', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4414', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000114', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4415', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000115', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4416', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000116', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4417', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000117', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4418', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000118', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4419', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000119', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4420', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000120', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4421', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000121', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4422', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000122', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4423', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000123', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4424', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000124', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4425', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000125', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4426', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000126', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4427', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000127', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4428', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000128', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4429', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000129', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4430', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000130', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4431', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000131', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4432', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000132', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4433', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000133', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4434', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000134', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4435', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000135', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4436', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000136', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4437', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000137', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4438', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000138', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4439', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000139', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4440', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000140', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4441', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000141', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4442', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000142', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4443', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000143', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4444', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000144', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4445', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000145', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4446', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000146', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4447', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000147', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4448', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000148', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4449', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000149', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4450', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000150', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4451', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000242', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4543', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000243', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4544', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000244', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4545', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000245', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4546', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000246', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4547', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000247', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4548', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000248', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4549', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000249', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4550', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000250', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4551', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000251', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4552', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000252', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4553', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000253', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4554', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000254', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4555', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000255', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4556', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000256', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4557', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000257', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4558', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000258', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4559', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000259', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4560', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000260', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4561', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000261', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4562', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000262', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4563', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000263', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4564', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000264', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4565', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000265', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4566', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000266', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4567', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000267', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4568', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000268', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4569', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000269', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4570', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000270', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4571', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000271', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4572', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000272', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4573', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000273', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4574', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000274', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4575', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000275', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4576', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000276', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4577', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000277', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4578', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000278', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4579', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000279', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4580', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000280', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4581', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000281', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4582', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000282', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4583', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000283', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4584', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000284', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4585', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000285', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4586', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000286', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4587', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000287', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4588', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000288', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4589', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000289', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4590', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000290', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4591', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000291', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4592', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000292', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4593', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000293', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4594', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000294', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4595', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000295', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4596', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000296', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4597', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000297', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4598', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000298', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4599', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000299', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4600', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000300', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4601', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000301', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4602', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000151', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4452', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000152', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4453', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000153', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4454', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000154', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4455', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000155', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4456', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000156', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4457', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000157', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4458', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000158', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4459', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000159', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4460', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000160', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4461', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000161', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4462', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000162', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4463', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000163', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4464', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000164', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4465', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000165', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4466', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000166', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4467', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000167', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4468', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000168', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4469', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000169', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4470', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000170', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4471', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000171', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4472', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000172', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4473', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000173', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4474', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000174', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4475', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000175', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4476', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000176', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4477', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000177', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4478', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000178', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4479', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000179', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4480', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000180', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4481', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000181', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4482', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000302', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4603', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000303', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4604', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000304', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4605', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000305', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4606', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000306', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4607', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000307', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4608', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000308', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4609', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000309', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4610', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000310', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4611', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000311', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4612', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000312', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4613', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000313', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4614', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000314', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4615', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000315', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4616', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000316', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4617', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000317', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4618', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000318', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4619', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000319', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4620', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000320', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4621', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000321', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4622', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000322', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4623', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000323', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4624', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000324', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4625', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000325', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4626', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000326', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4627', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000327', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4628', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000328', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4629', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000329', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4630', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000330', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4631', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000331', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4632', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000332', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4633', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000333', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4634', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000334', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4635', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000335', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4636', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000336', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4637', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000337', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4638', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000338', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4639', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000339', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4640', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000340', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4641', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000341', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4642', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000342', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4643', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000343', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4644', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000344', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4645', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000345', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4646', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000346', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4647', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000347', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4648', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000348', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4649', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000349', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4650', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000350', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4651', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000351', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4652', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000352', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4653', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000353', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4654', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000354', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4655', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000355', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4656', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000356', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4657', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000357', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4658', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000358', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4659', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000359', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4660', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000360', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4661', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000361', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4662', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000362', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4663', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000363', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4664', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000364', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4665', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000365', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4666', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000366', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4667', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000367', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4668', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000368', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4669', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000369', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4670', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000370', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4671', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000371', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4672', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000372', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4673', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000373', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4674', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000374', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4675', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000375', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4676', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000376', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4677', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000377', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4678', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000378', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4679', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000379', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4680', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000380', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4681', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000381', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4682', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000382', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4683', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000383', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4684', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000384', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4685', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000385', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4686', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000386', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4687', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000387', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4688', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000388', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4689', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000389', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4690', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000390', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4691', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000182', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4483', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000183', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4484', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000184', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4485', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000185', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4486', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000186', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4487', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000187', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4488', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000188', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4489', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000189', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4490', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000190', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4491', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000191', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4492', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000192', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4493', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000193', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4494', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000194', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4495', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000195', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4496', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000196', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4497', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000197', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4498', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000198', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4499', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000199', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4500', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000200', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4501', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000201', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4502', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000202', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4503', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000203', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4504', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000204', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4505', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000205', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4506', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000206', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4507', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000207', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4508', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000208', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4509', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000209', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4510', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000210', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4511', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000211', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4512', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000212', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4513', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000213', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4514', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000214', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4515', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000215', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4516', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000216', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4517', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000217', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4518', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000218', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4519', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000219', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4520', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000220', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4521', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000221', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4522', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000222', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4523', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000223', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4524', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000224', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4525', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000225', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4526', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000226', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4527', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000227', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4528', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000228', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4529', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000229', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4530', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000230', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4531', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000231', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4532', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000232', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4533', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000233', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4534', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000234', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4535', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000235', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4536', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000236', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4537', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000237', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4538', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000238', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4539', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000239', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4540', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000240', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4541', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000241', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4542', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000571', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4872', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000572', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4873', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000573', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4874', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000574', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4875', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000575', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4876', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000576', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4877', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000577', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4878', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000578', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4879', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000579', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4880', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000580', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4881', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000581', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4882', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000582', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4883', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000583', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4884', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000584', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4885', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000585', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4886', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000586', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4887', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000587', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4888', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000588', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4889', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000589', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4890', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000590', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4891', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000591', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4892', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000592', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4893', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000593', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4894', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000594', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4895', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000595', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4896', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000596', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4897', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000597', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4898', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000598', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4899', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000599', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4900', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000600', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4901', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000391', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4692', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000452', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4753', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000453', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4754', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000454', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4755', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000455', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4756', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000456', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4757', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000457', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4758', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000458', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4759', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000459', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4760', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000460', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4761', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000461', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4762', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000462', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4763', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000463', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4764', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000464', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4765', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000465', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4766', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000466', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4767', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000467', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4768', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000468', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4769', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000469', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4770', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000470', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4771', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000471', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4772', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000472', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4773', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000473', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4774', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000474', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4775', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000475', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4776', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000476', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4777', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000477', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4778', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000478', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4779', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000479', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4780', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000480', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4781', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000481', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4782', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000482', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4783', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000483', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4784', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000484', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4785', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000485', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4786', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000486', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4787', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000487', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4788', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000488', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4789', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000489', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4790', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000490', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4791', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000491', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4792', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000492', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4793', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000493', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4794', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000494', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4795', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000495', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4796', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000496', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4797', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000497', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4798', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000498', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4799', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000499', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4800', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000500', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4801', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000501', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4802', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000502', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4803', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000503', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4804', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000504', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4805', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000505', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4806', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000506', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4807', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000507', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4808', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000508', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4809', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000509', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4810', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000510', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4811', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000392', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4693', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000393', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4694', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000394', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4695', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000395', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4696', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000396', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4697', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000397', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4698', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000398', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4699', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000399', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4700', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000400', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4701', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000401', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4702', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000402', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4703', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000403', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4704', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000404', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4705', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000405', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4706', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000406', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4707', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000407', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4708', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000408', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4709', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000409', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4710', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000410', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4711', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000411', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4712', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000412', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4713', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000413', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4714', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000414', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4715', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000415', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4716', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000416', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4717', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000417', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4718', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000418', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4719', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000419', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4720', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000420', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4721', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000421', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4722', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000422', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4723', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000423', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4724', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000424', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4725', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000425', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4726', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000426', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4727', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000427', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4728', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000428', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4729', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000429', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4730', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000430', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4731', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000431', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4732', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000432', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4733', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000433', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4734', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000434', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4735', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000435', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4736', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000436', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4737', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000437', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4738', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000438', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4739', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000439', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4740', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000440', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4741', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000441', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4742', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000442', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4743', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000443', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4744', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000444', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4745', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000445', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4746', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000446', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4747', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000447', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4748', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000448', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4749', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000449', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4750', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000450', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4751', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000451', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4752', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000511', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4812', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000512', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4813', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000513', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4814', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000514', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4815', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000515', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4816', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000516', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4817', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000517', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4818', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000518', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4819', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000519', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4820', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000520', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4821', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000521', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4822', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000522', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4823', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000523', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4824', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000524', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4825', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000525', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4826', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000526', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4827', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000527', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4828', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000528', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4829', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000529', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4830', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000530', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4831', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000531', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4832', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000532', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4833', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000533', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4834', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000534', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4835', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000535', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4836', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000536', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4837', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000537', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4838', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000538', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4839', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000539', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4840', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000540', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4841', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000541', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4842', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000542', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4843', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000543', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4844', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000544', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4845', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000545', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4846', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000546', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4847', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000547', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4848', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000548', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4849', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000549', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4850', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000550', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4851', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000551', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4852', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000552', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4853', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000553', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4854', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000554', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4855', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000555', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4856', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000556', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4857', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000557', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4858', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000558', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4859', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000559', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4860', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000560', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4861', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000561', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4862', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000562', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4863', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000563', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4864', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000564', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4865', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000565', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4866', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000566', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4867', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000567', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4868', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000568', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4869', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000569', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4870', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000570', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4871', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000601', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4902', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000602', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4903', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000603', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4904', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000604', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4905', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000605', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4906', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000606', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4907', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000607', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4908', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000608', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4909', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000609', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4910', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000610', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4911', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000611', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4912', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000612', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4913', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000613', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4914', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000614', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4915', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000615', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4916', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000616', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4917', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000617', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4918', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000618', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4919', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000619', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4920', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000620', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4921', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000621', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4922', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000622', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4923', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000623', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4924', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000624', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4925', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000625', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4926', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000626', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4927', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000627', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4928', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000628', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4929', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000629', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4930', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000630', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4931', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000631', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4932', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000632', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4933', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000633', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4934', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000634', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4935', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000635', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4936', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000636', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4937', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000637', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4938', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000638', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4939', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000639', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4940', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000640', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4941', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000641', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4942', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000642', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4943', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000643', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4944', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000644', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4945', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000645', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4946', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000646', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4947', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000647', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4948', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000648', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4949', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000649', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4950', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000650', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4951', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000651', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4952', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000652', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4953', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000653', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4954', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000654', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4955', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000655', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4956', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000656', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4957', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000657', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4958', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000658', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4959', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000659', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4960', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000660', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4961', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000661', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4962', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000662', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4963', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000663', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4964', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000664', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4965', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000665', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4966', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000666', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4967', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000667', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4968', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000668', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4969', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000669', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4970', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000670', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4971', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000671', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4972', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000672', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4973', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000673', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4974', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000674', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4975', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000675', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4976', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000676', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4977', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000677', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4978', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000678', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4979', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000679', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4980', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000680', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4981', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000681', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4982', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000682', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4983', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000683', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4984', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000684', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4985', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000685', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4986', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000686', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4987', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000687', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4988', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000688', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4989', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000689', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4990', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000690', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4991', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000691', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4992', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000692', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4993', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000693', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4994', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000694', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4995', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000695', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4996', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000696', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4997', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000697', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4998', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000698', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '4999', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');
INSERT INTO `FINANCE_NOTES_MANAGE` VALUES ('PJBH0000000699', 'PBBH000001', 'zd00001', '2', '8c07ab23-44e0-440a-92b6-8f9e3ceaf3df', '吴芸', '2019-09-20 13:25:04', NULL, NULL, '5000', '-1', 'PJLX002', '气票票据', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PBLQ20190920001');

-- ----------------------------
-- Table structure for FINANCE_NOTES_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE_NOTES_TYPE`;
CREATE TABLE `FINANCE_NOTES_TYPE`  (
  `ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MONEY_MAX` decimal(20, 2) NOT NULL,
  `SERVICE_CALL` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TIP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '温馨提示',
  `CREATE_DATETIME` datetime(0) NOT NULL,
  `CREATE_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FINANCE_NOTES_TYPE
-- ----------------------------
INSERT INTO `FINANCE_NOTES_TYPE` VALUES ('PJLX001', '预存票据', 10000.00, '02866666666', NULL, '2019-03-07 09:49:50', '67ea4527-617f-446a-b36b-d705757df0af', '系统管理员');
INSERT INTO `FINANCE_NOTES_TYPE` VALUES ('PJLX002', '气票票据', 20000.00, '02866666666', NULL, '2019-03-07 09:52:46', '67ea4527-617f-446a-b36b-d705757df0af', '系统管理员');

-- ----------------------------
-- Table structure for FINANCE_THIRD_CHECK
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE_THIRD_CHECK`;
CREATE TABLE `FINANCE_THIRD_CHECK`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHECK_DATETIME` datetime(0) NOT NULL,
  `CHECK_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHECK_EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `FILE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_CHECK` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_ERROR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_CORRECT` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ORGANIZATION_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ORGANIZATION_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FINANCE_THIRD_CHECK
-- ----------------------------

-- ----------------------------
-- Table structure for FINANCE_TICKET_MANAGE
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE_TICKET_MANAGE`;
CREATE TABLE `FINANCE_TICKET_MANAGE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `VOLUME` decimal(11, 0) NOT NULL,
  `NOTES_TYPE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NOTES_TYPE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `START_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `END_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IN_DATETIME` datetime(0) NOT NULL,
  `IN_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IN_EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ADMINISTRATIVE_AREA_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ADMINISTRATIVE_AREA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REMAIN_VOLUME` decimal(11, 0) NOT NULL COMMENT '剩余数量',
  `TICKET_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FINANCE_TICKET_MANAGE
-- ----------------------------

-- ----------------------------
-- Table structure for FINANCE_TICKET_TEMPLATE
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE_TICKET_TEMPLATE`;
CREATE TABLE `FINANCE_TICKET_TEMPLATE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `SUBJECT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TEMPLATE_BASE64` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATE_DATETIME` datetime(0) NULL DEFAULT NULL,
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FINANCE_TICKET_TEMPLATE
-- ----------------------------

-- ----------------------------
-- Table structure for FINANCE_TICKET_USE_RECORD
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE_TICKET_USE_RECORD`;
CREATE TABLE `FINANCE_TICKET_USE_RECORD`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TICKET_MANAGE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TICKET_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `STATUS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USE_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USE_EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ADMINISTRATIVE_AREA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ADMINISTRATIVE_AREA_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USE_DATETIME` datetime(0) NOT NULL,
  `USE_START_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USE_END_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `VOLUME` decimal(11, 2) NOT NULL,
  `REMAIN_VOLUME` decimal(11, 2) NOT NULL,
  `NOTES_TYPE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NOTES_TYPE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FINANCE_TICKET_USE_RECORD
-- ----------------------------

-- ----------------------------
-- Table structure for FINANCE_TRANSFER_MANAGE
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE_TRANSFER_MANAGE`;
CREATE TABLE `FINANCE_TRANSFER_MANAGE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `AGENT_UNIT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRANSFER_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MONEY` decimal(11, 2) NOT NULL,
  `TRANSFER_DATE` datetime(0) NOT NULL,
  `ACCOUNTING_DATE` datetime(0) NULL DEFAULT NULL,
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_DATETIME` datetime(0) NOT NULL,
  `REMARK` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FINANCE_TRANSFER_MANAGE
-- ----------------------------

-- ----------------------------
-- Table structure for FINANCE_WECHAT_PAY
-- ----------------------------
DROP TABLE IF EXISTS `FINANCE_WECHAT_PAY`;
CREATE TABLE `FINANCE_WECHAT_PAY`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MCH_ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `APP_ID` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `APP_SECRET` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NOTIFY_PAY` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NOTIFY_REFUND` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `UNIFIED_ORDER_URL` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TRADE_TYPE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SUCCESS_REQUEST` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SPBILL_CREATE_IP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATE_DATETIME` datetime(0) NOT NULL,
  `CREATE_EMPLOYEE_CODE` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_EMPLOYEE_NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REMARK` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `APP_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RATE` decimal(11, 2) NULL DEFAULT NULL,
  `CERT_PATH` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ORG_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '机构id',
  `ORG_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '机构名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of FINANCE_WECHAT_PAY
-- ----------------------------

-- ----------------------------
-- Table structure for INSTALL_APPLICATION_FILE
-- ----------------------------
DROP TABLE IF EXISTS `INSTALL_APPLICATION_FILE`;
CREATE TABLE `INSTALL_APPLICATION_FILE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `APPLICATION_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请编号',
  `UPLOAD_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上传人ID',
  `UPLOAD_USER_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上传人',
  `UPLOAD_TIME` datetime(0) NULL DEFAULT NULL COMMENT '上传时间',
  `FILE_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `FILE_SIZE` decimal(32, 0) NULL DEFAULT NULL COMMENT '文件大小',
  `FILE_FORMAT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件格式',
  `DOWNLOAD_ADDRESS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下载地址',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '报装申请附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of INSTALL_APPLICATION_FILE
-- ----------------------------

-- ----------------------------
-- Table structure for INSTALL_APPLICATION_INFO
-- ----------------------------
DROP TABLE IF EXISTS `INSTALL_APPLICATION_INFO`;
CREATE TABLE `INSTALL_APPLICATION_INFO`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '申请编号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户姓名',
  `PHONE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气地址',
  `APPLICATION_STATUS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请状态:未发起|已发起|已完成',
  `APPLICATION_CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '申请内容',
  `CREATE_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '录入人ID',
  `CREATE_USER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '录入人',
  `APPLICATION_START_TIME` datetime(0) NULL DEFAULT NULL COMMENT '申请时间',
  `APPLCATION_FEE` decimal(10, 2) NULL DEFAULT NULL COMMENT '申请费用',
  `DEDUCTION_FEE` decimal(10, 2) NULL DEFAULT NULL COMMENT '减免费用',
  `PAY_FEE` decimal(10, 2) NULL DEFAULT NULL COMMENT '应交费用',
  `ACTUAL_FEE` decimal(10, 2) NULL DEFAULT NULL COMMENT '实收费用',
  `DEDUCTION_USER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '减免批准人ID',
  `DEDUCTION_USER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '减免批准人',
  `ESTIMTE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '预计完成时间',
  `APPLICATION_END_TIME` datetime(0) NULL DEFAULT NULL COMMENT '申请结束时间',
  `SETTLE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否结清：是|否',
  `INSTALL_TYPE_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报装类型ID',
  `OTHER_FEE` decimal(10, 2) NULL DEFAULT NULL COMMENT '其他费用',
  `INSTALL_PROCESS_VERSION_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报装流程版本实例id',
  `ACT_RU_PROCESS_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '执行流程实例id',
  `RECEIVE_RECORD_CODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应收费实例编号',
  `WORK_ORDER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单编号',
  `SYS_ORG_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单部门id',
  `SYS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单人id',
  `WORK_ORDER_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单类型',
  `TITLE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报装主题',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '报装申请信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of INSTALL_APPLICATION_INFO
-- ----------------------------

-- ----------------------------
-- Table structure for INSTALL_BASE_STATISTICS
-- ----------------------------
DROP TABLE IF EXISTS `INSTALL_BASE_STATISTICS`;
CREATE TABLE `INSTALL_BASE_STATISTICS`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `INSTALL_TYPE_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报装类型id',
  `APPLICATION_START_TIME` datetime(0) NULL DEFAULT NULL COMMENT '申请时间',
  `STATUS_NO_INIT_CNT` decimal(10, 0) NULL DEFAULT NULL COMMENT '未发起数量',
  `STATUS_PROCESSING_CNT` decimal(10, 0) NULL DEFAULT NULL COMMENT '处理中数量',
  `STATUS_OVER_CNT` decimal(10, 0) NULL DEFAULT NULL COMMENT '已完成数量',
  `STATUS_CNT` decimal(10, 0) NULL DEFAULT NULL COMMENT '总数量',
  `MANAGEMENT_AREA_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域',
  `OVER_WEEK` decimal(10, 0) NULL DEFAULT NULL COMMENT '从申请日期算起第几周完成',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '报装基本统计' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of INSTALL_BASE_STATISTICS
-- ----------------------------

-- ----------------------------
-- Table structure for INSTALL_FEE_DETAIL
-- ----------------------------
DROP TABLE IF EXISTS `INSTALL_FEE_DETAIL`;
CREATE TABLE `INSTALL_FEE_DETAIL`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编号',
  `APPLICATION_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '申请编号',
  `FEE_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '费用类型：材料|设备|费用',
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `MANUFACTURER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `STANDARD` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规格',
  `QUANTITY` decimal(10, 2) NULL DEFAULT NULL COMMENT '数量',
  `UNIT_PRICE` decimal(10, 2) NULL DEFAULT NULL COMMENT '单价',
  `TOTAL_PRICE` decimal(10, 2) NULL DEFAULT NULL COMMENT '小计',
  `TYPE_TABLE_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型表id',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '报装费用详情表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of INSTALL_FEE_DETAIL
-- ----------------------------
INSERT INTO `INSTALL_FEE_DETAIL` VALUES ('069e603b-5015-492c-ac69-3611d4a2c2d0', 'BZGZ201910090001', '0', '软管', NULL, NULL, 1.00, 5.00, 5.00, 'ae066250-4ec2-42f7-8875-2593bd47b79a');
INSERT INTO `INSTALL_FEE_DETAIL` VALUES ('07f98291-0e6f-4a84-8e5e-95d353fec706', 'BZGZ201910090001', '0', '软管', NULL, NULL, 4.00, 5.00, 20.00, 'ae066250-4ec2-42f7-8875-2593bd47b79a');
INSERT INTO `INSTALL_FEE_DETAIL` VALUES ('1004dccf-684d-4c44-94d3-b526ae4aaffc', 'BZGZ201910090001', '1', '开户费用', NULL, NULL, 1.00, 6500.00, 6500.00, 'JGSZ000001');
INSERT INTO `INSTALL_FEE_DETAIL` VALUES ('205e3e9b-81e5-4eb0-a46d-af55e8545ed2', 'BZGZ201910090001', '1', '开户费用', NULL, NULL, 1.00, 6500.00, 6500.00, 'JGSZ000001');
INSERT INTO `INSTALL_FEE_DETAIL` VALUES ('3f4ac7be-ca4d-442c-873a-4fb2d824505b', 'BZGZ201910090001', '1', '开卡费', NULL, NULL, 1.00, 30.00, 30.00, 'JGSZ000005');
INSERT INTO `INSTALL_FEE_DETAIL` VALUES ('45fc3159-7d35-4c04-be12-39fd452fb8df', 'BZGZ201910090001', '1', '开户费用', NULL, NULL, 1.00, 6500.00, 6500.00, 'JGSZ000001');
INSERT INTO `INSTALL_FEE_DETAIL` VALUES ('74c2e8e5-1da0-4061-a09c-44e7738bed52', 'BZGZ201910090001', '0', '软管', NULL, NULL, 1.00, 5.00, 5.00, 'ae066250-4ec2-42f7-8875-2593bd47b79a');
INSERT INTO `INSTALL_FEE_DETAIL` VALUES ('84a68cad-0f0f-479f-96b9-8231348bd743', 'BZGZ201910090001', '0', '软管', NULL, NULL, 4.00, 5.00, 20.00, 'ae066250-4ec2-42f7-8875-2593bd47b79a');
INSERT INTO `INSTALL_FEE_DETAIL` VALUES ('9b6e3c42-2053-47a7-abc9-becce293e786', 'BZGZ201910090001', '1', '开卡费', NULL, NULL, 1.00, 30.00, 30.00, 'JGSZ000005');
INSERT INTO `INSTALL_FEE_DETAIL` VALUES ('e77df7c7-8aec-4efb-abe5-7d2203797f2d', 'BZGZ201910090001', '0', '软管', NULL, NULL, 1.00, 5.00, 5.00, 'ae066250-4ec2-42f7-8875-2593bd47b79a');

-- ----------------------------
-- Table structure for INSTALL_PROCESS
-- ----------------------------
DROP TABLE IF EXISTS `INSTALL_PROCESS`;
CREATE TABLE `INSTALL_PROCESS`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `PROCESS_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流程编号',
  `INSTALL_TYPE_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报装类型id',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '报装流程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of INSTALL_PROCESS
-- ----------------------------

-- ----------------------------
-- Table structure for INSTALL_PROCESS_VERSION
-- ----------------------------
DROP TABLE IF EXISTS `INSTALL_PROCESS_VERSION`;
CREATE TABLE `INSTALL_PROCESS_VERSION`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `INSTALL_PROCESS_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报装流程ID',
  `INSTALL_TYPE_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报装类型ID',
  `VERSION` decimal(4, 0) NULL DEFAULT NULL COMMENT '版本号',
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `CREATE_BY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `ACT_PROCESS_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统流程ID',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of INSTALL_PROCESS_VERSION
-- ----------------------------

-- ----------------------------
-- Table structure for INSTALL_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `INSTALL_TYPE`;
CREATE TABLE `INSTALL_TYPE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类型编号',
  `TYPE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型名称',
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '报装类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of INSTALL_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for LOGIN_CHECK
-- ----------------------------
DROP TABLE IF EXISTS `LOGIN_CHECK`;
CREATE TABLE `LOGIN_CHECK`  (
  `USERNAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录名',
  `LOGINDATE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录日期',
  `PASSWORDERRORNUM` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码输入错误次数',
  `VERIFYCODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '验证码',
  `VERIFYCODEERRORNUM` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '验证码输入错误次数',
  `VERIFYCODETIME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '验证码生成时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of LOGIN_CHECK
-- ----------------------------
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2019-12-30', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('guoxiaomei', '2019-12-30', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin001', '2019-12-30', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('super', '2019-12-31', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wangxuewen', '2019-12-31', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('guoxiaomei', '2020-01-02', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wangzi', '2020-01-10', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin002', '2020-01-14', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wangzi', '2020-01-15', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('chenyongqin', '2020-01-19', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('chenyongqin', '2020-11-05', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wangzi', '2020-02-07', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('luoqimin', '2020-11-06', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('chenyongqin', '2020-02-11', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-02-24', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wangxuewen', '2020-02-24', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-03-04', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin001', '2020-03-04', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-03-17', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('chenyongqin', '2020-11-24', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-12-04', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wuyun', '2020-12-10', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('chenyongqin', '2020-05-11', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouyuanping', '2020-12-31', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('super', '2020-05-22', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-05-28', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('guoxiaomei', '2020-06-01', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('luoqimin', '2020-07-02', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-07-03', '3', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouyuanping', '2021-01-18', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('super', '2020-08-06', '5', '208438', '1', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-08-17', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-09-02', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-10-10', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('super', '2019-12-23', '3', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('test001', '2020-01-03', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-01-05', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-01-05', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wangzi', '2020-01-06', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-01-07', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('liufang', '2020-01-07', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-01-22', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('chenyongqin', '2020-05-09', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-05-31', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('chenyongqin', '2020-08-04', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wuyun', '2020-10-21', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-11-24', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-09-25', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-11-25', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouyuanping', '2020-11-26', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2019-12-31', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('chenyongqin', '2020-01-02', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouyuanping', '2020-12-08', '4', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouyuanping', '2020-12-27', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wuyun', '2020-12-29', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2021-01-08', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouzhangkui', '2019-12-31', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin001', '2019-12-31', '4', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zenghailong', '2019-12-31', '4', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('leixueqiang', '2020-01-03', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-01-04', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin001', '2020-01-04', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('super', '2020-01-04', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wangzi', '2020-01-04', '3', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-02-10', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-02-10', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-02-12', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('super', '2020-03-06', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-12-03', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-06-21', '3', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('luomb', '2020-08-10', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('tim03', '2020-08-17', '3', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-08-28', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('wuyun', '2020-10-23', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouyuanping', '2020-12-02', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouyuanping', '2020-12-12', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('guoxiaomei', '2020-12-31', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouyuanping', '2021-01-02', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouyuanping', '2021-01-08', '3', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhouyuanping', '2021-01-13', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('luoqimin', '2019-12-25', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2019-12-25', '4', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-01-19', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-02-24', '3', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin001', '2020-03-07', '3', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin002', '2020-03-07', '2', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('leixueqiang', '2019-12-26', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('super', '2020-01-18', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('super', '2020-01-15', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('zhangmeng', '2020-01-15', '3', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('admin003', '2020-06-17', '3', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('chenyongqin', '2020-12-30', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('yuanwei', '2019-12-24', '1', NULL, '0', NULL);
INSERT INTO `LOGIN_CHECK` VALUES ('yuanwei', '2019-12-27', '3', NULL, '0', NULL);

-- ----------------------------
-- Table structure for MAINTENANCE_MANAGEMENT
-- ----------------------------
DROP TABLE IF EXISTS `MAINTENANCE_MANAGEMENT`;
CREATE TABLE `MAINTENANCE_MANAGEMENT`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '申请编号',
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户编号',
  `CURRENT_CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '现客户姓名',
  `CURRENT_PHONE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '现客户联系电话',
  `APPLY_STATUS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '申请状态',
  `MAINTENANCE_CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '申请内容',
  `ENTRY_PERSON` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '录入人',
  `APPLY_DATE` datetime(0) NOT NULL COMMENT '申请时间',
  `MAINTENANCE_COSTS` double NULL DEFAULT NULL COMMENT '维修费用',
  `RECEIVABLE_EXPENSE` double NULL DEFAULT NULL COMMENT '应收费用',
  `REAL_PRICE` double NULL DEFAULT NULL COMMENT '实收费用',
  `PAYMENT_TYPES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付费方式',
  `FEE_EARNERS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费人',
  `CHARGEABLE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '收费时间',
  `ESTIMATED_COMPLETION_TIME` datetime(0) NULL DEFAULT NULL COMMENT '预计完成时间',
  `ACTUAL_FINISH_TIME` datetime(0) NULL DEFAULT NULL COMMENT '实际完成时间',
  `SQUARE_UP` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否结清',
  `TOLL_RECEIVABLE_RECORD_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应收记录编号',
  `WORK_ORDER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单号',
  `MAINTENANCE_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '维修类型',
  `SYS_ORG_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单机构ID',
  `SYS_USER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单人ID',
  `WORK_ORDER_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单类型',
  `TITLE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '维修主题',
  `OTHER_FEE` double NULL DEFAULT NULL COMMENT '其他费用',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '维修管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MAINTENANCE_MANAGEMENT
-- ----------------------------

-- ----------------------------
-- Table structure for MAINTENANCE_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `MAINTENANCE_TYPE`;
CREATE TABLE `MAINTENANCE_TYPE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '维修类型编号',
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '维修类型名称',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '维修类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MAINTENANCE_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_CUSTOMER_BOOKLET
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_CUSTOMER_BOOKLET`;
CREATE TABLE `MEASURING_CUSTOMER_BOOKLET`  (
  `BOOKLET_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表册编号',
  `ADDRESS_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址编号',
  `CUSTOMER_BOOKLET_ORDER` decimal(38, 0) NULL DEFAULT NULL COMMENT '超标顺序',
  `METERING_PERSON_ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表员',
  `CUSTOMER_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户编号',
  `METERING_STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表状态'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_CUSTOMER_BOOKLET
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_GAS_ADDITION
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_GAS_ADDITION`;
CREATE TABLE `MEASURING_GAS_ADDITION`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '追加编号',
  `CUSTOMER_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户编号',
  `METER_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表编号',
  `ADD_GAS` decimal(38, 4) NOT NULL COMMENT '追加气量（方）',
  `ADDITION_MONTH` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '追加月份',
  `OPERATOR_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作人',
  `ADDITION_DATE` datetime(0) NOT NULL COMMENT '追加时间',
  `NOTE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `AUDITOR_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `AUDITING_DATE` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `AUDITING_STATUS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `AUDITING_ADVICE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核意见',
  `CUSTOMER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户姓名',
  `AUDITOR_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人ID',
  `BOOKLET_DATA_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'mdaID'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_GAS_ADDITION
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_GAS_ADJUSTMENT
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_GAS_ADJUSTMENT`;
CREATE TABLE `MEASURING_GAS_ADJUSTMENT`  (
  `ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调整编号',
  `CUSTOMER_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `METER_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表编号',
  `ADJUSTING_MONTH` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调整月份',
  `GASCONSUMPTION_BEFOREADJUSTING` decimal(38, 4) NOT NULL COMMENT '调整前气量',
  `GASCONSUMPTION_AFTERADJUSTING` decimal(38, 4) NOT NULL COMMENT '调整后气量',
  `ADJUSTING_PERSON` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调整人',
  `ADJUSTING_DATE` datetime(0) NOT NULL COMMENT '调整时间',
  `ADJUSTING_CAUSATION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '调整原因',
  `AUDITOR` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '审核人',
  `AUDITING_DATE` datetime(0) NULL DEFAULT NULL COMMENT '审核时间',
  `AUDITING_STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '审核状态',
  `AUDITING_ADVICE` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核意见',
  `CUSTOMER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户姓名',
  `AUDITOR_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核编号',
  `BOOKLET_DATA_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'mdaID',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_GAS_ADJUSTMENT
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_METERGUY_LOCATIONS
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_METERGUY_LOCATIONS`;
CREATE TABLE `MEASURING_METERGUY_LOCATIONS`  (
  `ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '编号',
  `OPERATER_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作员编号',
  `OPERATING_TIME` datetime(0) NOT NULL COMMENT '操作时间',
  `LATITUDE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '纬度',
  `LONGITUDE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '经度'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_METERGUY_LOCATIONS
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_METER_BOOKLET
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_METER_BOOKLET`;
CREATE TABLE `MEASURING_METER_BOOKLET`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '抄表册编号',
  `MANAGEMENT_AREA_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理区域',
  `METERBOOKLET_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '抄表册名称',
  `METERING_PERIOD` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '抄表周期',
  `METERING_PERSON_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '抄表员',
  `METERING_DATE` datetime(0) NOT NULL COMMENT '抄表日期',
  `METERING_WAY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '抄表方式',
  `STATUS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_METER_BOOKLET
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_METER_DATA
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_METER_DATA`;
CREATE TABLE `MEASURING_METER_DATA`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '抄表记录编号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户号',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `BOOKLET_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '气表编号',
  `METERING_PERSON_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表册号',
  `LASTTIME_METERINGDATA` decimal(38, 4) NULL DEFAULT NULL COMMENT '上次抄表读数',
  `THISTIME_METERINGDATA` decimal(38, 4) NULL DEFAULT NULL COMMENT '本次读数',
  `GAS_CONSUMPTION` decimal(38, 4) NULL DEFAULT NULL COMMENT '本次气量',
  `METERING_WAY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '本次抄表性质',
  `METERING_EXCEPTION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表异常',
  `METERING_DATE` datetime(0) NULL DEFAULT NULL COMMENT '实际抄表日期',
  `METERING_RECORDER` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '录入人',
  `RECORDING_DATE` datetime(0) NULL DEFAULT NULL COMMENT '录入时间',
  `AUDITING_STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `AUDITOR` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核人',
  `AUDITING_DATE` datetime(0) NULL DEFAULT NULL COMMENT '审核日期',
  `METERING_MONTH` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表月份',
  `PAYOFF_WHETHER` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '已交金额',
  `PAYMENT` decimal(38, 4) NULL DEFAULT NULL COMMENT '收费',
  `PAYMENT_RECIPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费流水号',
  `GASPAYMENT_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '气费类型',
  `PENALTY` decimal(38, 4) NULL DEFAULT NULL COMMENT '违约金',
  `PENALTY_RELIEF` decimal(38, 4) NULL DEFAULT NULL COMMENT '违约金减免',
  `PROMPT_WHETHER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否催费',
  `PAYMENT_RECIPIENT` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费交接人',
  `DERVERED_GASFEE` decimal(38, 4) NULL DEFAULT NULL COMMENT '应交气费',
  `CUSTOMER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `GAS_ADDITION` decimal(38, 0) NULL DEFAULT NULL COMMENT '追加气量',
  `PROMPT_DATE` datetime(0) NULL DEFAULT NULL,
  `PROMPT_WAY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AFFILIATED_BUSINESS_HALL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业厅',
  `MANAGEMENT_AREA_ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域',
  `GAS_PROPERTY_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气性质ID',
  `COMPANY_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公司编号',
  `PREDEPOSIT_DEDUCTION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预存款扣除',
  `CHARGE_CHANNEL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费渠道',
  `STEPPRICE_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '历史审核阶梯计费的编号',
  `STEPPRICE_ID_SETTED` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_METER_DATA
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_METER_DATA_SUP
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_METER_DATA_SUP`;
CREATE TABLE `MEASURING_METER_DATA_SUP`  (
  `MDAID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '抄表数据ID',
  `FIRST_STEP_GAS` decimal(13, 2) NOT NULL COMMENT '一价用气量',
  `FIRST_STEP_PRICE` decimal(13, 2) NOT NULL COMMENT '一价价格',
  `SECOND_STEP_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '二价用气量',
  `SECOND_STEP_PRICE` decimal(13, 2) NULL DEFAULT NULL COMMENT '二价价格',
  `THIRD_STEP_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '三价用气量',
  `THIRD_STEP_PRICE` decimal(13, 2) NULL DEFAULT NULL COMMENT '三价价格',
  `FOURTH_STEP_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '四价用气量',
  `FOURTH_STEP_PRICE` decimal(13, 2) NULL DEFAULT NULL COMMENT '四价价格',
  `FIFTH_STEP_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '五价用气量',
  `FIFTH_STEP_PRICE` decimal(13, 2) NULL DEFAULT NULL COMMENT '五价价格',
  `HISTORY_GAS` decimal(13, 2) NULL DEFAULT NULL COMMENT '历史用气量',
  `FIRST_STEP_FEE` decimal(38, 0) NULL DEFAULT NULL COMMENT '一价费用',
  `SECOND_STEP_FEE` decimal(38, 0) NULL DEFAULT NULL COMMENT '二价费用',
  `THIRD_STEP_FEE` decimal(38, 0) NULL DEFAULT NULL COMMENT '三价费用',
  `FOURTH_STEP_FEE` decimal(38, 0) NULL DEFAULT NULL COMMENT '四价费用',
  `FIFTH_STEP_FEE` decimal(38, 0) NULL DEFAULT NULL COMMENT '五价费用',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户ID',
  `GAS_PROPERTY_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气性质ID',
  `AUDITING_DATE` datetime(0) NULL DEFAULT NULL COMMENT '审核日期',
  `CUSTOMER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户姓名',
  `GAS_PROPERTY_NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气性质名称',
  `MANAGEMENT_AREA_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域编号',
  `MANAGEMENT_AREA` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域',
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表编号',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `METERING_MONTH` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表月份',
  `GAS_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气地址',
  `AFFILIATED_BUSINESS_HALL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所属营业厅',
  `DERVERED_GASFEE` decimal(13, 2) NULL DEFAULT NULL COMMENT '气费',
  `METERING_DATE` datetime(0) NULL DEFAULT NULL COMMENT '抄表日期',
  `GAS_CONSUMPTION` decimal(13, 2) NULL DEFAULT NULL COMMENT '气量',
  `COMPANY_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分公司编号'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_METER_DATA_SUP
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_METER_FACILITY
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_METER_FACILITY`;
CREATE TABLE `MEASURING_METER_FACILITY`  (
  `ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备编号',
  `FACILITY_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备名称',
  `FACILITY_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备类型',
  `FACILITY_MODEL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设备型号',
  `MANAGEMENT_AREA_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理区域',
  `PRODUCT_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '出厂编号',
  `MANUFACTURED_FACTORY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '生产厂家',
  `NOTE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `RECIPIENCE_STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '领用状态',
  `RECIPIENT` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '领用人',
  `RECIVE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '领用时间',
  `BRINGBACK_TIME` datetime(0) NULL DEFAULT NULL COMMENT '归还时间',
  `BRINGBACK_PERSON` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归还人',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_METER_FACILITY
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_REMOTEMETER
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_REMOTEMETER`;
CREATE TABLE `MEASURING_REMOTEMETER`  (
  `SWITCH_SUPERFLOW_CHECK` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `COVER_PROTECTION` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SWITCH_AGAS_CONSUMPTION` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SWITCH_OVERTIME_PROTECTION` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CONTINUE_TIME_SETTING` datetime(0) NULL DEFAULT NULL,
  `CHARGE_UPPER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ALERT_GAS_CONSUMPTIONMONEY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `OVERUSE_GAS_CONSUMPTIONMONEY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_REMOTEMETER
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_STATISTICS_DATA
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_STATISTICS_DATA`;
CREATE TABLE `MEASURING_STATISTICS_DATA`  (
  `BOOKLET_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '抄表册编号',
  `MANAGEMENT_AREA_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域编号',
  `PLANNED_METERING_PERSON_ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表册上抄表员',
  `PLANNED_METERING_DATE` datetime(0) NULL DEFAULT NULL COMMENT '抄表册上抄表时间',
  `PLANNED_METERING_WAY` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表册上抄表方式',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户编号',
  `CUSTOMER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户名称',
  `GAS_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气地址',
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表编号',
  `PLANNED_METERING_MONTH` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表册所在的月份',
  `GAS_PROPERTY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气性质',
  `METERBOOKLET_NAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表册名称',
  `COMMUNITY_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小区名称',
  `METERING_PERSON_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表员编号',
  `GAS_ADDITION` decimal(38, 0) NULL DEFAULT NULL COMMENT '追加气量',
  `GAS_CONSUMPTION` decimal(38, 0) NULL DEFAULT NULL COMMENT '调整气量',
  `METERING_DATE` datetime(0) NULL DEFAULT NULL COMMENT '抄表日期',
  `GAS_PROPERTY_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气性质编号',
  `THISTIME_METERINGDATA` decimal(38, 0) NULL DEFAULT NULL COMMENT '这次读数',
  `LASTTIME_METERINGDATA` decimal(38, 0) NULL DEFAULT NULL COMMENT '上次读数',
  `MANAGEMENT_AREA` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '机构名称',
  `COMMUNITY_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '小区名称编号',
  `STATUS` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表状态',
  `METERING_WAY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表方式'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_STATISTICS_DATA
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_TEMPORARY_STAUTS
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_TEMPORARY_STAUTS`;
CREATE TABLE `MEASURING_TEMPORARY_STAUTS`  (
  `TEMPORARY_TASK_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '临时任务id',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户id',
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '表具id',
  `METERING_STATUS` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单表临时抄表状态：1未抄2已抄',
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键id',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_TEMPORARY_STAUTS
-- ----------------------------

-- ----------------------------
-- Table structure for MEASURING_TEMPORARY_TASK
-- ----------------------------
DROP TABLE IF EXISTS `MEASURING_TEMPORARY_TASK`;
CREATE TABLE `MEASURING_TEMPORARY_TASK`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '临时任务编号',
  `GAS_ADDRESS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气地址',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `GAS_PROPERTY_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气性质',
  `METERING_DATE` datetime(0) NOT NULL COMMENT '抄表日期',
  `METERING_PERSON_ID` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '抄表员',
  `NOTE` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `EXECUTED_WHETHER` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否执行'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MEASURING_TEMPORARY_TASK
-- ----------------------------

-- ----------------------------
-- Table structure for METER_MANUFACTORY
-- ----------------------------
DROP TABLE IF EXISTS `METER_MANUFACTORY`;
CREATE TABLE `METER_MANUFACTORY`  (
  `ID` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MANUFACTORY_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of METER_MANUFACTORY
-- ----------------------------

-- ----------------------------
-- Table structure for MONITORING_CALLING_RECORDS
-- ----------------------------
DROP TABLE IF EXISTS `MONITORING_CALLING_RECORDS`;
CREATE TABLE `MONITORING_CALLING_RECORDS`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '记录编号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户号',
  `CUSTOMER_NAMES` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户姓名',
  `GAS_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气地址',
  `CONTACT_PHONENUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `CALLING_CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '呼叫内容',
  `CREATED_TIME` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `CORRESPONDING_WORKORDER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应工单号',
  `OPERATOR_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接线员'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MONITORING_CALLING_RECORDS
-- ----------------------------

-- ----------------------------
-- Table structure for MONITORING_KNOWLEDGE
-- ----------------------------
DROP TABLE IF EXISTS `MONITORING_KNOWLEDGE`;
CREATE TABLE `MONITORING_KNOWLEDGE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识编号',
  `KEY_WORDS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '关键词',
  `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `CREATED_PERSON` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `CREATED_TIME` datetime(0) NOT NULL COMMENT '创建时间',
  `CATEGORY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类别',
  `PID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父节点编号'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MONITORING_KNOWLEDGE
-- ----------------------------

-- ----------------------------
-- Table structure for MONITORING_KNOWLEDGE_TYPE
-- ----------------------------
DROP TABLE IF EXISTS `MONITORING_KNOWLEDGE_TYPE`;
CREATE TABLE `MONITORING_KNOWLEDGE_TYPE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MONITORING_KNOWLEDGE_TYPE
-- ----------------------------

-- ----------------------------
-- Table structure for MONITORING_REMOTE_METER
-- ----------------------------
DROP TABLE IF EXISTS `MONITORING_REMOTE_METER`;
CREATE TABLE `MONITORING_REMOTE_METER`  (
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表编号',
  `INSTRUCTION_CATEGORY` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '指令类型',
  `SEND_STATUS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发送状态',
  `SEND_TIME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发送时间',
  `INSTRUCTION_STATUS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '指令状态',
  `FEEDBACK_MOMENT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '反馈时刻',
  `ACCUMULATED_GASCONSUMPTION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '累计用气量',
  `METER_GASLEFTOVER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '气表余额'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of MONITORING_REMOTE_METER
-- ----------------------------

-- ----------------------------
-- Table structure for PLA_TENANT
-- ----------------------------
DROP TABLE IF EXISTS `PLA_TENANT`;
CREATE TABLE `PLA_TENANT`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户公司名称',
  `DBPREFIX` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据库前缀',
  `CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '租户编码',
  `REDIS_IP` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'redis地址',
  `REDIS_PORT` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'redis端口',
  `REDIS_PASSWORD` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'redis密码',
  `REDIS_DB_INDEX` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'redis数据库',
  `SIGN` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '租户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of PLA_TENANT
-- ----------------------------
INSERT INTO `PLA_TENANT` VALUES ('6374ca33-0c68-4088-90b8-cb6a3f898746', '龙双燃气', 'qcdb002', '002', '172.26.159.41', '6379', 'Hqgcis8', '2', 'c19375524d01356ab02888bedba3c0ee');
INSERT INTO `PLA_TENANT` VALUES ('8ecfabd8-0cf0-43e9-a411-7360a2daa591', '叙永县汇升燃气有限公司', 'qcdb003', '003', '172.26.159.41', '6379', 'Hqgcis8', '3', 'ae378b31beacb27206b248a142e63299');
INSERT INTO `PLA_TENANT` VALUES ('b7432783-e7dc-45e8-8f84-c519d747e91b', '成都燃气(公司）', 'qcdb001', '001', '172.26.159.41', '6379', 'Hqgcis8', '1', 'a7f4e7526782d01eab8fe94395b14907');
INSERT INTO `PLA_TENANT` VALUES ('cdeeb780-a165-4dd4-8efb-9965506f531e', '自贡市回龙天然气销售有限公司', 'qcdb004', '004', '172.26.159.41', '6379', 'Hqgcis8', '4', 'a57e4e2bf154c123146b9d760ca923d2');
INSERT INTO `PLA_TENANT` VALUES ('f671d6ea-c7ba-4838-9d7f-44406a30f40b', '秦川燃气公司', 'qcdb005', '005', '172.26.159.41', '6379', 'Hqgcis8', '5', '0e70275726f79e5a94a5e0621c8dcd70');

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BLOB_DATA` longblob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIG_TO_TRIG_FK` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CALENDAR` longblob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIG_TO_TRIG_FK` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_10', 'DEFAULT', '0 30 23 L 1,3,5,7,9,11 ? *', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_11', 'DEFAULT', '0 0 0 L * ? ', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_12', 'DEFAULT', '0/5 * * * * ? ', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_13', 'DEFAULT', '0/5 * * * * ? ', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_14', 'DEFAULT', '0/5 * * * * ? ', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_146', 'DEFAULT', '0 0 0 28 * ?', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_151', 'DEFAULT', '5/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_152', 'DEFAULT', '5/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_158', 'DEFAULT', '0 0 0 18 * ?', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_198', 'DEFAULT', '0 0 0 1 * ?', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_35', 'DEFAULT', '0 0 23/1 * * ?', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_37', 'DEFAULT', '0 0 0 * * ? *', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_7', 'DEFAULT', '0 0 0 1 * ?', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_8', 'DEFAULT', '0 2 5 14,28 * ? *', 'Asia/Shanghai');
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('QciotScheduler', 'TASK_9', 'DEFAULT', '0 0 5 ? * SAT', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `FIRED_TIME` decimal(13, 0) NOT NULL,
  `SCHED_TIME` decimal(13, 0) NOT NULL,
  `PRIORITY` decimal(13, 0) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`INSTANCE_NAME`, `SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`JOB_GROUP`, `SCHED_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`JOB_NAME`, `SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_DATA` longblob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_10', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C707070707070707400186368616E6765426F6F6B6C657454776F4D6F6E74684A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825F2E67874001A30203330203233204C20312C332C352C372C392C3131203F202A7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000A70740005646F4A6F62707070740016E68A84E8A1A8E5868CE8B083E695B42EE58F8CE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_11', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C70707070707070740015636F6D707574654665654D6F6E7468456E644A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825F4BF7874000C3020302030204C202A203F207372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000B70740005646F4A6F62707070740012E68A84E8A1A8E69C88E5BA95E7BB93E7AE97737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_12', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C70707070707070740014637573746F6D6572526564697353796E634A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825F6777874000E302F35202A202A202A202A203F207372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000C70740005646F4A6F627070707400187265646973E5908CE6ADA52EE5AEA2E688B7E6A1A3E6A188737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_13', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C70707070707070740015776F726B4F72646572526564697353796E634A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825F8267874000E302F35202A202A202A202A203F207372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000D70740005646F4A6F627070707400127265646973E5908CE6ADA52EE5B7A5E58D95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_14', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C7070707070707074001777616974696E675461736B526564697353796E634A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825FA1E7874000E302F35202A202A202A202A203F207372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000E70740005646F4A6F6270707074001B7265646973E5908CE6ADA52EE5BE85E5A484E79086E4BBBBE58AA1737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_146', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C707070707070707400177072654465706F7369745265706F7274536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016927CA6CBD7874000C3020302030203238202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000092707400137072654465706F7369745265706F72744170697074000CE7BB9FE8AEA1E58886E69E9070740015E9A284E5AD98E6ACBEE7BB9FE8AEA1E68AA5E8A1A8737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_151', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C707070707070707400197061796D656E744D6F6E74685265706F7274536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016932C49B307874000E352F3130202A202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000097707400146172726561726167654D6F6E74685265706F72747074000CE7BB9FE8AEA1E58886E69E9070740012E6B094E6ACBEE59B9EE694B6E69C88E68AA5737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_152', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C7070707070707074001B6172726561726167654D6F6E74685265706F7274536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016932C56EEE7874000E352F3130202A202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000098707400146172726561726167654D6F6E74685265706F72747074000CE7BB9FE8AEA1E58886E69E9070740012E794A8E6B094E6ACA0E6ACBEE69C88E68AA5737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_158', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074001772656365697661626C655265636F7264536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016B0BBAF8FB7874000C3020302030203138202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000009E7074001372656365697661626C655265636F72644A6F627400074659535A30303174000CE8B4B9E794A8E8AEBEE7BDAE7400104659535A3030312C716364623030312E74001C716364623030312E3AE8B4B9E794A8E8AEBEE7BDAE2EE6AF8FE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_178', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074001772656365697661626C655265636F7264536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016CB2A766587874000C3020302030203230202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000B27074001372656365697661626C655265636F72644A6F627400074659535A30303374000CE8B4B9E794A8E8AEBEE7BDAE7400104659535A3030332C716364623030312E74001C716364623030312E3AE8B4B9E794A8E8AEBEE7BDAE2EE6AF8FE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_198', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074001772656365697661626C655265636F7264536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016D4C78C23A7874000B30203020302031202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000C67074001372656365697661626C655265636F72644A6F627400074659535A30303274000CE8B4B9E794A8E8AEBEE7BDAE7400104659535A3030322C716364623030322E74001C716364623030322E3AE8B4B9E794A8E8AEBEE7BDAE2EE6AF8FE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_35', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C707070707070707400084F766572506C616E7372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000168130358417874000E3020302032332F31202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000237074000E6F766572506C616E536561726368707070740018E8B685E69C9FE5AE89E6A380E58D95EFBC8CE6AF8FE5A4A9737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_37', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C7070707070707074001973746570507269636550726F6772616D6D65536572766963657372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001682B5303F87874000D3020302030202A202A203F202A7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000257074000C70726F6772616D6D654A6F62707070740019E998B6E6A2AFE8AEA1E4BBB7E696B9E6A1885FE6AF8FE5A4A9737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_7', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C707070707070707400156368616E6765426F6F6B6C65744D6F6E74684A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825ED367874000B30203020302031202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000770740005646F4A6F62707070740016E68A84E8A1A8E5868CE8B083E695B42EE6AF8FE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_8', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000573636F7474707400015C707070707070707400196368616E6765426F6F6B6C657468616C664D6F6E74684A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825EF7E7874001130203220352031342C3238202A203F202A7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000870740005646F4A6F62707070740016E68A84E8A1A8E5868CE8B083E695B42EE58D8AE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('QciotScheduler', 'TASK_9', 'DEFAULT', NULL, 'com.qciot.module.schedule.utils.ScheduleJob', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074000E626F6F6B6C6574536572766963657372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825F14E7874000D3020302035203F202A205341547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000097074002F4F726465725765656B426F6F6B6C657442794D65746572696E67506572736F6E416E644D65746572696E6744617465707070740013E68A84E8A1A8E5868CE8B083E695B42EE591A8737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
INSERT INTO `QRTZ_LOCKS` VALUES ('QciotScheduler', 'STATE_ACCESS');
INSERT INTO `QRTZ_LOCKS` VALUES ('QciotScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` decimal(13, 0) NOT NULL,
  `CHECKIN_INTERVAL` decimal(13, 0) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('QciotScheduler', '16ac89dee6031609931052078', 1611280446053, 15000);
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('QciotScheduler', '6fb9c0fa12ec1590919697154', 1611280436496, 15000);

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REPEAT_COUNT` decimal(7, 0) NOT NULL,
  `REPEAT_INTERVAL` decimal(12, 0) NOT NULL,
  `TIMES_TRIGGERED` decimal(10, 0) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIG_TO_TRIG_FK` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `STR_PROP_1` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `STR_PROP_2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `STR_PROP_3` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `INT_PROP_1` decimal(10, 0) NULL DEFAULT NULL,
  `INT_PROP_2` decimal(10, 0) NULL DEFAULT NULL,
  `LONG_PROP_1` decimal(13, 0) NULL DEFAULT NULL,
  `LONG_PROP_2` decimal(13, 0) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIG_TO_TRIG_FK` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` decimal(13, 0) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` decimal(13, 0) NULL DEFAULT NULL,
  `PRIORITY` decimal(13, 0) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `START_TIME` decimal(13, 0) NOT NULL,
  `END_TIME` decimal(13, 0) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` decimal(2, 0) NULL DEFAULT NULL,
  `JOB_DATA` longblob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_GROUP`, `JOB_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`NEXT_FIRE_TIME`, `MISFIRE_INSTR`, `SCHED_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`NEXT_FIRE_TIME`, `TRIGGER_STATE`, `SCHED_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`NEXT_FIRE_TIME`, `MISFIRE_INSTR`, `SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`NEXT_FIRE_TIME`, `MISFIRE_INSTR`, `TRIGGER_STATE`, `TRIGGER_GROUP`, `SCHED_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`TRIGGER_STATE`, `SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `QRTZ_TRIGGER_TO_JOBS_FK`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGER_TO_JOBS_FK` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_10', 'DEFAULT', 'TASK_10', 'DEFAULT', NULL, 1612107000000, -1, 5, 'WAITING', 'CRON', 1558489483000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074000E626F6F6B6C6574536572766963657372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825F2E67874001A30203330203233204C20312C332C352C372C392C3131203F202A7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000A707400344F7264657254776F4D6F6E746873426F6F6B6C657442794D65746572696E67506572736F6E416E644D65746572696E6744617465707070740016E68A84E8A1A8E5868CE8B083E695B42EE58F8CE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_11', 'DEFAULT', 'TASK_11', 'DEFAULT', NULL, 1559232000000, -1, 5, 'PAUSED', 'CRON', 1558489484000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C70707070707070740015636F6D707574654665654D6F6E7468456E644A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825F4BF7874000C3020302030204C202A203F207372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000B70740005646F4A6F62707070740012E68A84E8A1A8E69C88E5BA95E7BB93E7AE97737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_12', 'DEFAULT', 'TASK_12', 'DEFAULT', NULL, 1558489485000, -1, 5, 'PAUSED', 'CRON', 1558489485000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C70707070707070740014637573746F6D6572526564697353796E634A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825F6777874000E302F35202A202A202A202A203F207372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000C70740005646F4A6F627070707400187265646973E5908CE6ADA52EE5AEA2E688B7E6A1A3E6A188737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_13', 'DEFAULT', 'TASK_13', 'DEFAULT', NULL, 1558489490000, -1, 5, 'PAUSED', 'CRON', 1558489486000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C70707070707070740015776F726B4F72646572526564697353796E634A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825F8267874000E302F35202A202A202A202A203F207372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000D70740005646F4A6F627070707400127265646973E5908CE6ADA52EE5B7A5E58D95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_14', 'DEFAULT', 'TASK_14', 'DEFAULT', NULL, 1558489490000, -1, 5, 'PAUSED', 'CRON', 1558489487000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074001777616974696E675461736B526564697353796E634A6F627372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825FA1E7874000E302F35202A202A202A202A203F207372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000E70740005646F4A6F6270707074001B7265646973E5908CE6ADA52EE5BE85E5A484E79086E4BBBBE58AA1737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_146', 'DEFAULT', 'TASK_146', 'DEFAULT', NULL, 1558972800000, -1, 5, 'PAUSED', 'CRON', 1558489490000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C707070707070707400177072654465706F7369745265706F7274536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016927CA6CBD7874000C3020302030203238202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000092707400137072654465706F7369745265706F72744170697074000CE7BB9FE8AEA1E58886E69E9070740015E9A284E5AD98E6ACBEE7BB9FE8AEA1E68AA5E8A1A8737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_151', 'DEFAULT', 'TASK_151', 'DEFAULT', NULL, 1558489495000, -1, 5, 'PAUSED', 'CRON', 1558489491000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C707070707070707400197061796D656E744D6F6E74685265706F7274536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016932C49B307874000E352F3130202A202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000097707400146172726561726167654D6F6E74685265706F72747074000CE7BB9FE8AEA1E58886E69E9070740012E6B094E6ACBEE59B9EE694B6E69C88E68AA5737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_152', 'DEFAULT', 'TASK_152', 'DEFAULT', NULL, 1558489495000, -1, 5, 'PAUSED', 'CRON', 1558489492000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074001B6172726561726167654D6F6E74685265706F7274536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016932C56EEE7874000E352F3130202A202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000098707400146172726561726167654D6F6E74685265706F72747074000CE7BB9FE8AEA1E58886E69E9070740012E794A8E6B094E6ACA0E6ACBEE69C88E68AA5737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_158', 'DEFAULT', 'TASK_158', 'DEFAULT', NULL, 1613577600000, 1610899200000, 5, 'WAITING', 'CRON', 1559269931000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074001772656365697661626C655265636F7264536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016B0BBAF8FB7874000C3020302030203138202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000009E7074001372656365697661626C655265636F72644A6F627400074659535A30303174000CE8B4B9E794A8E8AEBEE7BDAE7400104659535A3030312C716364623030312E74001C716364623030312E3AE8B4B9E794A8E8AEBEE7BDAE2EE6AF8FE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_198', 'DEFAULT', 'TASK_198', 'DEFAULT', NULL, 1612108800000, -1, 5, 'WAITING', 'CRON', 1568946045000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074001772656365697661626C655265636F7264536572766963657372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016D4C78C23A7874000B30203020302031202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000C67074001372656365697661626C655265636F72644A6F627400074659535A30303274000CE8B4B9E794A8E8AEBEE7BDAE7400104659535A3030322C716364623030322E74001C716364623030322E3AE8B4B9E794A8E8AEBEE7BDAE2EE6AF8FE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_35', 'DEFAULT', 'TASK_35', 'DEFAULT', NULL, 1558537200000, -1, 5, 'PAUSED', 'CRON', 1558489488000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C707070707070707400084F766572506C616E7372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000168130358417874000E3020302032332F31202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000237074000E6F766572506C616E536561726368707070740018E8B685E69C9FE5AE89E6A380E58D95EFBC8CE6AF8FE5A4A9737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000017800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_37', 'DEFAULT', 'TASK_37', 'DEFAULT', NULL, 1611331200000, 1611244800000, 5, 'WAITING', 'CRON', 1558489489000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074001973746570507269636550726F6772616D6D65536572766963657372000E6A6176612E7574696C2E44617465686A81014B59741903000078707708000001682B5303F87874000D3020302030202A202A203F202A7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000257074000C70726F6772616D6D654A6F62707070740019E998B6E6A2AFE8AEA1E4BBB7E696B9E6A1885FE6AF8FE5A4A9737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_7', 'DEFAULT', 'TASK_7', 'DEFAULT', NULL, 1612108800000, -1, 5, 'WAITING', 'CRON', 1558489479000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074000E626F6F6B6C6574536572766963657372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825ED367874000B30203020302031202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000007707400304F726465724D6F6E7468426F6F6B6C657442794D65746572696E67506572736F6E416E644D65746572696E6744617465707070740016E68A84E8A1A8E5868CE8B083E695B42EE6AF8FE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_8', 'DEFAULT', 'TASK_8', 'DEFAULT', NULL, 1611781320000, 1610571720000, 5, 'WAITING', 'CRON', 1558489480000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074000E626F6F6B6C6574536572766963657372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825EF7E7874001130203220352031342C3238202A203F202A7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000000000008707400344F7264657248616C664D6F6E7468426F6F6B6C657442794D65746572696E67506572736F6E416E644D65746572696E6744617465707070740016E68A84E8A1A8E5868CE8B083E695B42EE58D8AE69C88737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);
INSERT INTO `QRTZ_TRIGGERS` VALUES ('QciotScheduler', 'TASK_9', 'DEFAULT', 'TASK_9', 'DEFAULT', NULL, 1611349200000, 1610744400000, 5, 'WAITING', 'CRON', 1568617682000, 0, NULL, 2, 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B455973720032636F6D2E7163696F742E6D6F64756C652E7363686564756C652E646F6D61696E2E5363686564756C654A6F62456E74697479000000000000000102000B4C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B5B00066A6F624964737400115B4C6A6176612F6C616E672F4C6F6E673B4C000A6D6574686F644E616D6571007E00094C00086D6F64756C65496471007E00094C000A6D6F64756C654E616D6571007E00094C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E44617461456E7469747900000000000000010200044C000863726561746542797400284C636F6D2F7163696F742F6D6F64756C652F726261632F646F6D61696E2F757365722F557365723B4C000A6372656174654461746571007E000A4C0008757064617465427971007E000F4C000A7570646174654461746571007E000A7872002A636F6D2E7163696F742E696E6672617374727563747572652E656E746974792E42617365456E7469747900000000000000010200085A000A6861735370656369616C5A000B69734E65775265636F72644C0007646241646D696E71007E00094C000664625573657271007E00094C000665736361706571007E00094C0002696471007E00095B00036964737400135B4C6A6176612F6C616E672F537472696E673B4C000673716C4D617071007E00037870000074000553434F5454707400015C7070707070707074000E626F6F6B6C6574536572766963657372000E6A6176612E7574696C2E44617465686A81014B5974190300007870770800000167E825F14E7874000D3020302035203F202A205341547372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B020000787000000000000000097074002F4F726465725765656B426F6F6B6C657442794D65746572696E67506572736F6E416E644D65746572696E6744617465707070740013E68A84E8A1A8E5868CE8B083E695B42EE591A8737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E001A000000007800);

-- ----------------------------
-- Table structure for REMOTE_METER_ALERT
-- ----------------------------
DROP TABLE IF EXISTS `REMOTE_METER_ALERT`;
CREATE TABLE `REMOTE_METER_ALERT`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '报警编号',
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户号',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '客户姓名',
  `GAS_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用气地址',
  `PHONE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表身号',
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表号',
  `ALERT_CAUSATION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报警原因',
  `HANDLED_RESULT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理结果',
  `HANDLING_STATUS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理状态',
  `WORK_ORDER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单号码',
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '报警时间',
  `ESTIMATED_COMPLETION_TIME` datetime(0) NULL DEFAULT NULL COMMENT '预计完成时间',
  `ACTUAL_FINISH_TIME` datetime(0) NULL DEFAULT NULL COMMENT '实际完成时间',
  `SYS_ORG_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单机构ID',
  `SYS_USER_ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '派单人ID',
  `WORK_ORDER_TYPE` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工单类型'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of REMOTE_METER_ALERT
-- ----------------------------

-- ----------------------------
-- Table structure for REMOTE_METER_CONTROLL
-- ----------------------------
DROP TABLE IF EXISTS `REMOTE_METER_CONTROLL`;
CREATE TABLE `REMOTE_METER_CONTROLL`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `METER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '远传表id',
  `SUPER_FLUID` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开关超流检测:10-开,00-关',
  `DISMANTLE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开关拆盖保护:10-开,00-关',
  `TOTAL_DISPLAY` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开关累计用气量显示:10-开,00-关',
  `OVER_TIME` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开关超时保护:10-开,00-关',
  `DURATION_TIME_LH100` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LH100',
  `DURATION_TIME_LH500` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LH500',
  `DURATION_TIME_LH800` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LH800',
  `DURATION_TIME_LH1200` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LH1200',
  `DURATION_TIME_LH1500` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LH1500',
  `DURATION_TIME_LH2000` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LH2000',
  `DURATION_TIME_LH2500` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LH2500',
  `DURATION_TIME_LH3000` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LH3000',
  `DURATION_TIME_LH4000` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LH4000',
  `DURATION_TIME_LH4800` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LH4800',
  `DURATION_TIME_LHFF` decimal(10, 0) NULL DEFAULT NULL COMMENT '持续时间设置LHFF',
  `FLOW_MODE` decimal(2, 0) NULL DEFAULT NULL COMMENT '流量模式：0-自动检测模式,1-固定模式',
  `FLOW_MODE_MAX_USE_FLOW` decimal(10, 0) NULL DEFAULT NULL COMMENT '最大使用流量',
  `FLOW_MODE_MIN_USE_FLOW` decimal(10, 0) NULL DEFAULT NULL COMMENT '最小使用流量',
  `FLOW_MODE_MAX_SUPER_FLUID_FLOW` decimal(10, 0) NULL DEFAULT NULL COMMENT '最大过流保护流量',
  `RECHARGE_LIMIT` decimal(10, 0) NULL DEFAULT NULL COMMENT '充值上限',
  `ALARM1` decimal(10, 0) NULL DEFAULT NULL COMMENT '报警气量/金额:一级报警量',
  `ALARM2` decimal(10, 0) NULL DEFAULT NULL COMMENT '报警气量/金额:二级报警量',
  `OVER_RUN` decimal(10, 0) NULL DEFAULT NULL COMMENT '透支气量/金额',
  `INTERVAL_TIME` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '固定时间上传，取当天的某个时间点。(14:30:00)',
  `INTERVAL_HOURS` decimal(10, 0) NULL DEFAULT NULL COMMENT '时间(取值范围：1~24小时)',
  `VOLTAGE_CONTROL_CODE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '低电压关阀控制码，00：关闭，10：开启',
  `VOLUME_CONTROL_CODE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '零气量关阀控制码，00：关闭，10：开启',
  `MAX_TIME_OFFSET` decimal(10, 0) NULL DEFAULT NULL COMMENT '表端与主站时间最大校时偏差的绝对值',
  `PULSE_INTERVAL1` decimal(11, 2) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率间隔分界点1（2.5m3/h）',
  `PULSE_INTERVAL2` decimal(11, 2) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率间隔分界点2（0.8m3）',
  `PULSE_INTERVAL3` decimal(11, 2) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率间隔分界点3（0.4 m3）',
  `PULSE_INTERVAL4` decimal(11, 2) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率间隔分界点4（0.016 m3/h）',
  `SUPER_LARGE_PULSE_CON_CNT1` decimal(10, 0) NULL DEFAULT NULL COMMENT '超大切断电流',
  `SUPER_LARGE_PULSE_CON_TIME1` decimal(10, 0) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率持续时长',
  `SUPER_LARGE_PULSE_CON_OFF1` decimal(10, 0) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率间隔允差1%-100%',
  `CONSTANT_A_PULSE_CON_CNT2` decimal(10, 0) NULL DEFAULT NULL COMMENT '异常恒流A脉冲或计量分辨率持续个数',
  `CONSTANT_A_PULSE_CON_TIME2` decimal(10, 0) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率持续时长',
  `CONSTANT_A_PULSE_CON_OFF2` decimal(10, 0) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率间隔允差1%-100%',
  `CONSTANT_B_PULSE_CON_CNT1` decimal(10, 0) NULL DEFAULT NULL COMMENT '异常恒流B脉冲或计量分辨率持续个数',
  `CONSTANT_B_PULSE_CON_TIME1` decimal(10, 0) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率持续时长',
  `CONSTANT_B_PULSE_CON_OFF1` decimal(10, 0) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率间隔允差1%-100%',
  `CONSTANT_C_PULSE_CON_CNT1` decimal(10, 0) NULL DEFAULT NULL COMMENT '异常恒流C脉冲或计量分辨率持续个数',
  `CONSTANT_C_PULSE_CON_TIME1` decimal(10, 0) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率持续时长',
  `CONSTANT_C_PULSE_CON_OFF1` decimal(10, 0) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率间隔允差1%-100%',
  `SUPER_MIN_PULSE_CON_CNT1` decimal(10, 0) NULL DEFAULT NULL COMMENT '超小切断电流脉冲或计量分辨率持续个数',
  `SUPER_MIN_PULSE_CON_TIME1` decimal(10, 0) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率持续时长',
  `SUPER_MIN_PULSE_CON_OFF1` decimal(10, 0) NULL DEFAULT NULL COMMENT '脉冲或计量分辨率间隔允差1%-100%',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '远传表控制' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of REMOTE_METER_CONTROLL
-- ----------------------------

-- ----------------------------
-- Table structure for REMOTE_METER_CONTROLL_STATE
-- ----------------------------
DROP TABLE IF EXISTS `REMOTE_METER_CONTROLL_STATE`;
CREATE TABLE `REMOTE_METER_CONTROLL_STATE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CONTROLL_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '控制指令表id',
  `SUPER_FLUID_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '超流检测：0-未发送，1-已发送，2-成功，3-失败',
  `SUPER_FLUID_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '超流检测历史json',
  `DISMANTLE_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拆盖保护：0-未发送，1-已发送，2-成功，3-失败',
  `DISMANTLE_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '拆盖保护历史json',
  `TOTAL_DISPLAY_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '累计用气量显示：0-未发送，1-已发送，2-成功，3-失败',
  `TOTAL_DISPLAY_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '累计用气量显示历史json',
  `OVER_TIME_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '超时保护检测：0-未发送，1-已发送，2-成功，3-失败',
  `OVER_TIME_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '超时保护检测历史json',
  `DURATION_TIME_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '持续时间检测：0-未发送，1-已发送，2-成功，3-失败',
  `DURATION_TIME_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '持续时间检测历史json',
  `FLOW_MODE_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流量模式设置：0-未发送，1-已发送，2-成功，3-失败',
  `FLOW_MODE_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '流量模式设置历史json',
  `RECHARGE_LIMIT_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值上限：0-未发送，1-已发送，2-成功，3-失败',
  `RECHARGE_LIMIT_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '充值上限历史json',
  `ALARM_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报警气量/金额：0-未发送，1-已发送，2-成功，3-失败',
  `ALARM_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '报警气量/金额历史json',
  `OVER_RUN_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '透支气量/金额：0-未发送，1-已发送，2-成功，3-失败',
  `OVER_RUN_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '透支气量/金额历史json',
  `SUPER_FLUID_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '超流检测发送时间',
  `DISMANTLE_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '拆盖保护发送时间',
  `TOTAL_DISPLAY_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '累计用气量发送时间',
  `OVER_TIME_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '超时保护发送时间',
  `DURATION_TIME_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '持续时间检测发送时间',
  `FLOW_MODE_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '流量模式发送时间',
  `RECHARGE_LIMIT_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '充值上限发送时间',
  `ALARM_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '报警气量/金额发送时间',
  `OVER_RUN_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '透支气量/金额发送时间',
  `SUPER_FLUID_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '超流检测发送人id',
  `SUPER_FLUID_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '超流检测发送人',
  `DISMANTLE_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拆盖保护发送人id',
  `DISMANTLE_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拆盖保护发送人',
  `TOTAL_DISPLAY_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '累计用气量发送人id',
  `TOTAL_DISPLAY_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '累计用气量发送人',
  `OVER_TIME_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '超时保护发送人id',
  `OVER_TIME_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '超时保护发送人',
  `DURATION_TIME_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '持续时间发送人id',
  `DURATION_TIME_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '持续时间发送人',
  `FLOW_MODE_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流量模式发送人id',
  `FLOW_MODE_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '流量模式发送人',
  `RECHARGE_LIMIT_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值上限发送人id',
  `RECHARGE_LIMIT_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '充值上限发送人',
  `ALARM_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报警气量/金额发送人id',
  `ALARM_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '报警气量/金额发送人',
  `OVER_RUN_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '透支气量/金额发送人id',
  `OVER_RUN_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '透支气量/金额发送人',
  `SWITCH_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阀门开关设置：0-未发送，1-已发送，2-成功，3-失败',
  `SWITCH_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '阀门开关设置历史json',
  `SWITCH_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '阀门开关发送时间',
  `SWITCH_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阀门开关发送人id',
  `SWITCH_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阀门开关发送人',
  `UPLOAD_INTERVAL_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时间间隔设置：0-未发送，1-已发送，2-成功，3-失败',
  `UPLOAD_INTERVAL_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '时间间隔设置历史json',
  `UPLOAD_INTERVAL_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '时间间隔发送时间',
  `UPLOAD_INTERVAL_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时间间隔发送人id',
  `UPLOAD_INTERVAL_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时间间隔发送人',
  `FUNCTION_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '功能设置：0-未发送，1-已发送，2-成功，3-失败',
  `FUNCTION_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '功能设置历史json',
  `FUNCTION_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '功能发送时间',
  `FUNCTION_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '功能发送人id',
  `FUNCTION_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '功能发送人',
  `CHECK_TIME_OFF_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '校时允差设置：0-未发送，1-已发送，2-成功，3-失败',
  `CHECK_TIME_OFF_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '校时允差设置历史json',
  `CHECK_TIME_OFF_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '校时允差发送时间',
  `CHECK_TIME_OFF_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '校时允差发送人id',
  `CHECK_TIME_OFF_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '校时允差发送人',
  `AB_NORMAL_FLOW_STATE` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '异常流量监控设置：0-未发送，1-已发送，2-成功，3-失败',
  `AB_NORMAL_FLOW_HIS_JSON` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常流量监控历史json',
  `AB_NORMAL_FLOW_HIS_TIME` datetime(0) NULL DEFAULT NULL COMMENT '异常流量监控发送时间',
  `AB_NORMAL_FLOW_HIS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '异常流量监控发送人id',
  `AB_NORMAL_FLOW_HIS_USER_NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '异常流量监控发送人',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '远传表控制状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of REMOTE_METER_CONTROLL_STATE
-- ----------------------------

-- ----------------------------
-- Table structure for REMOTE_METER_STEP_PRICE_METER
-- ----------------------------
DROP TABLE IF EXISTS `REMOTE_METER_STEP_PRICE_METER`;
CREATE TABLE `REMOTE_METER_STEP_PRICE_METER`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `METER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表编号',
  `SEND_STATU` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发送状态，0：发送中，1：发送成功，2：发送失败',
  `SEND_TIME` datetime(0) NULL DEFAULT NULL COMMENT '发送时间',
  `SEND_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发送人',
  `SEND_CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '发送内容',
  `RECEIVE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '响应时间',
  `PLAN_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方案号',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '远传表阶梯计费发送记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of REMOTE_METER_STEP_PRICE_METER
-- ----------------------------

-- ----------------------------
-- Table structure for REMOTE_METER_STEP_PRICE_PLAN
-- ----------------------------
DROP TABLE IF EXISTS `REMOTE_METER_STEP_PRICE_PLAN`;
CREATE TABLE `REMOTE_METER_STEP_PRICE_PLAN`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PLAN_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '阶梯方案id',
  `SEND_STATU` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发送状态，0：发送中，1：发送成功，2：发送失败',
  `SEND_TIME` datetime(0) NULL DEFAULT NULL COMMENT '发送时间',
  `SEND_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发送人',
  `SEND_CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '发送内容',
  `RECEIVE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '响应时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '远传表阶梯计费方案发送记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of REMOTE_METER_STEP_PRICE_PLAN
-- ----------------------------

-- ----------------------------
-- Table structure for SALGRADE
-- ----------------------------
DROP TABLE IF EXISTS `SALGRADE`;
CREATE TABLE `SALGRADE`  (
  `GRADE` decimal(65, 30) NULL DEFAULT NULL,
  `LOSAL` decimal(65, 30) NULL DEFAULT NULL,
  `HISAL` decimal(65, 30) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SALGRADE
-- ----------------------------

-- ----------------------------
-- Table structure for SCHEDULE_JOB
-- ----------------------------
DROP TABLE IF EXISTS `SCHEDULE_JOB`;
CREATE TABLE `SCHEDULE_JOB`  (
  `JOB_ID` decimal(20, 0) NOT NULL,
  `BEAN_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `METHOD_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PARAMS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `CRON_EXPRESSION` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STATUS` decimal(2, 0) NOT NULL,
  `REMARK` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL,
  `MODULE_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `MODULE_ID` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`JOB_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SCHEDULE_JOB
-- ----------------------------
INSERT INTO `SCHEDULE_JOB` VALUES (7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, '0 0 0 1 * ?', 0, '抄表册调整.每月', '2018-12-26 09:34:19', NULL, NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, '0 2 5 14,28 * ? *', 0, '抄表册调整.半月', '2018-12-26 09:34:20', NULL, NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, '0 0 5 ? * SAT', 0, '抄表册调整.周', '2018-12-26 09:34:20', NULL, NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, '0 30 23 L 1,3,5,7,9,11 ? *', 0, '抄表册调整.双月', '2018-12-26 09:34:20', NULL, NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (11, 'computeFeeMonthEndJob', 'doJob', NULL, '0 0 0 L * ? ', 1, '抄表月底结算', '2018-12-26 09:34:21', NULL, NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (12, 'customerRedisSyncJob', 'doJob', NULL, '0/5 * * * * ? ', 1, 'redis同步.客户档案', '2018-12-26 09:34:21', NULL, NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (13, 'workOrderRedisSyncJob', 'doJob', NULL, '0/5 * * * * ? ', 1, 'redis同步.工单', '2018-12-26 09:34:22', NULL, NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (14, 'waitingTaskRedisSyncJob', 'doJob', NULL, '0/5 * * * * ? ', 1, 'redis同步.待处理任务', '2018-12-26 09:34:22', NULL, NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (35, 'OverPlan', 'overPlanSearch', NULL, '0 0 23/1 * * ?', 1, '超期安检单，每天', '2019-01-03 17:20:13', NULL, NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (37, 'stepPriceProgrammeService', 'programmeJob', NULL, '0 0 0 * * ? *', 0, '阶梯计价方案_每天', '2019-01-08 10:38:07', NULL, NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (146, 'preDepositReportService', 'preDepositReportApi', NULL, '0 0 0 28 * ?', 1, '预存款统计报表', '2019-02-26 11:12:51', '统计分析', NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (151, 'paymentMonthReportService', 'arrearageMonthReport', NULL, '5/10 * * * * ?', 1, '气款回收月报', '2019-02-28 14:22:19', '统计分析', NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (152, 'arrearageMonthReportService', 'arrearageMonthReport', NULL, '5/10 * * * * ?', 1, '用气欠款月报', '2019-02-28 14:23:14', '统计分析', NULL);
INSERT INTO `SCHEDULE_JOB` VALUES (158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', '0 0 0 18 * ?', 0, 'qcdb001.:费用设置.每月', '2019-05-31 10:32:11', '费用设置', 'FYSZ001');
INSERT INTO `SCHEDULE_JOB` VALUES (178, 'receivableRecordService', 'receivableRecordJob', 'FYSZ003,qcdb001.', '0 0 0 20 * ?', 0, 'qcdb001.:费用设置.每月', '2019-08-21 13:30:11', '费用设置', 'FYSZ003');
INSERT INTO `SCHEDULE_JOB` VALUES (198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', '0 0 0 1 * ?', 0, 'qcdb002.:费用设置.每月', '2019-09-20 10:20:45', '费用设置', 'FYSZ002');

-- ----------------------------
-- Table structure for SCHEDULE_JOB_LOG
-- ----------------------------
DROP TABLE IF EXISTS `SCHEDULE_JOB_LOG`;
CREATE TABLE `SCHEDULE_JOB_LOG`  (
  `LOG_ID` decimal(20, 0) NOT NULL,
  `JOB_ID` decimal(20, 0) NOT NULL,
  `BEAN_NAME` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `METHOD_NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PARAMS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `STATUS` decimal(2, 0) NOT NULL,
  `ERROR` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `TIMES` decimal(10, 0) NOT NULL,
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`LOG_ID`) USING BTREE,
  INDEX `INDEX_JOB_ID`(`JOB_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SCHEDULE_JOB_LOG
-- ----------------------------
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (281, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 33, '2019-05-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (282, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2019-05-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (283, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-05-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (284, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-05-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (285, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-05-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (286, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-05-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (287, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2019-05-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (288, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-05-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (289, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-05-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (290, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2019-06-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (291, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-06-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (292, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-06-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (293, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2019-06-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (294, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2019-06-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (295, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-06-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (296, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-06-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (301, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 38, '2019-06-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (302, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-06-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (303, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-06-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (304, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-06-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (305, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-06-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (306, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 27, '2019-06-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (307, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 73, '2019-06-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (308, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-06-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (309, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-06-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (310, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-06-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (311, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-06-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (312, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-06-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (313, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-06-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (314, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-06-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (315, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-06-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (321, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2019-06-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (322, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 166, '2019-06-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (323, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-06-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (324, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-06-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (325, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-07-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (326, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (327, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-07-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (328, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (329, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-07-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (330, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (331, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-07-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (332, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2019-07-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (333, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (334, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (335, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-07-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (336, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (337, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (338, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 3, '2019-07-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (339, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-07-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (340, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (341, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (342, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (343, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 67, '2019-07-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (344, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (345, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-07-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (346, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-07-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (347, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (348, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (349, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (350, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (351, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (352, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-07-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (353, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (354, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (355, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-07-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (356, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-07-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (357, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-08-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (358, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-08-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (359, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 3, '2019-08-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (360, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (361, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-08-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (362, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-08-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (363, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 19, '2019-08-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (364, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-08-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (365, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-08-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (366, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (367, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (368, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-08-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (369, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-08-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (370, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (371, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-08-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (372, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-08-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (373, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-08-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (374, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 27, '2019-08-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (375, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 89, '2019-08-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (376, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (377, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-08-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (378, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-08-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (379, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2019-08-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (380, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (381, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-08-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (401, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (402, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (403, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 29, '2019-08-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (404, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (405, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (406, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-08-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (421, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 14, '2019-08-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (422, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-09-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (423, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-09-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (424, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 4, '2019-09-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (425, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 27, '2019-09-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (426, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-09-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (427, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2019-09-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (428, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 38, '2019-09-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (429, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-09-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (430, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-09-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (431, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-09-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (432, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 36, '2019-09-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (433, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2019-09-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (436, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 51, '2019-09-12 17:31:19');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (437, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 51, '2019-09-12 17:31:19');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (440, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 9, '2019-09-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (444, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-09-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (445, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 48, '2019-09-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (446, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 13, '2019-09-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (447, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 43, '2019-09-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (448, 178, 'receivableRecordService', 'receivableRecordJob', 'FYSZ003,qcdb001.', 0, NULL, 48, '2019-09-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (449, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2019-09-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (450, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 182, '2019-09-21 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (453, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2019-09-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (454, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 15, '2019-09-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (455, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-09-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (456, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2019-09-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (457, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2019-09-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (458, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderWeekBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-09-28 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (459, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderHalfMonthBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-09-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (460, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-09-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (461, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-09-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (462, 10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderTwoMonthsBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-09-30 23:30:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (463, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (464, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderMonthBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-10-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (465, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 0, NULL, 272, '2019-10-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (466, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (467, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (468, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-10-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (469, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (470, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderWeekBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-10-05 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (471, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (472, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (473, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (474, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (475, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (476, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderMonthBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-10-10 15:18:12');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (477, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderHalfMonthBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 1, '2019-10-10 15:18:12');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (478, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderWeekBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-10-10 15:18:12');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (479, 10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderTwoMonthsBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-10-10 15:18:12');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (480, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderMonthBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-10-10 15:31:02');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (481, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderHalfMonthBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-10-10 15:31:02');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (482, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderWeekBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-10-10 15:31:02');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (483, 10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, 1, 'java.lang.NoSuchMethodException: com.qciot.module.measure.domain.booklet.BookletService$$EnhancerBySpringCGLIB$$2a7fe1d4.OrderTwoMonthsBookletByMeteringPersonAndMeteringDate()\n	at java.lang.Class.getDeclaredMethod(Class.java:2130)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.<init>(ScheduleRunnable.java:48)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:62)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\n', 0, '2019-10-10 15:31:02');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (484, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 17, '2019-10-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (485, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 102, '2019-10-11 09:31:13');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (486, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 26, '2019-10-11 09:33:16');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (487, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (488, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 49, '2019-10-12 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (489, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (490, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (491, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 8, '2019-10-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (492, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (493, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 14, '2019-10-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (494, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (495, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-17 02:13:08');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (496, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (497, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 95, '2019-10-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (498, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (499, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 103, '2019-10-19 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (500, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (501, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (502, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (503, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-22 16:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (504, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 17, '2019-10-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (505, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 13, '2019-10-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (506, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 25, '2019-10-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (507, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 139, '2019-10-26 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (508, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2019-10-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (509, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (510, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 7, '2019-10-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (511, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (512, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-10-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (513, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-10-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (514, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 27, '2019-11-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (515, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 75, '2019-11-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (516, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 0, NULL, 302, '2019-11-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (517, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-11-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (518, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 81, '2019-11-02 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (519, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-11-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (520, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-11-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (521, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (522, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (523, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (524, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (525, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-11-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (526, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 49, '2019-11-09 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (527, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-11-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (528, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-11-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (529, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (530, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (531, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-11-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (532, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 34, '2019-11-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (533, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-11-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (534, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-11-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (535, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 115, '2019-11-16 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (536, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (537, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 29, '2019-11-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (538, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 64, '2019-11-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (539, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (540, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (541, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (542, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 28, '2019-11-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (543, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (544, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 48, '2019-11-23 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (545, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (546, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-11-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (547, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (548, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (549, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 6, '2019-11-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (550, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-11-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (551, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-11-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (552, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 99, '2019-11-30 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (553, 10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 57, '2019-11-30 23:30:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (554, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 42, '2019-12-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (555, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 28, '2019-12-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (556, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 0, NULL, 292, '2019-12-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (557, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-12-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (558, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-12-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (559, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-12-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (560, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 29, '2019-12-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (561, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-12-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (562, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-12-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (563, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 132, '2019-12-07 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (564, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-12-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (565, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 29, '2019-12-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (566, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-12-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (567, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-12-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (568, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-12-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (569, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-12-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (570, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-12-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (571, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 106, '2019-12-14 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (572, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 4, '2019-12-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (573, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2019-12-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (574, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-12-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (575, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2019-12-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (576, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 27, '2019-12-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (577, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 81, '2019-12-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (578, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-12-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (579, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-12-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (581, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 129, '2019-12-21 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (583, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2019-12-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (584, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-12-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (585, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 29, '2019-12-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (586, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-12-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (587, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-12-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (588, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2019-12-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (589, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 64, '2019-12-28 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (590, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 4, '2019-12-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (591, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2019-12-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (592, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2019-12-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (593, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2019-12-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (594, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 64, '2020-01-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (595, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 0, NULL, 79, '2020-01-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (596, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 156, '2020-01-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (597, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (598, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (599, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 39, '2020-01-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (600, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 95, '2020-01-04 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (601, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 22, '2020-01-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (602, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (603, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 23, '2020-01-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (604, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (605, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (606, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (607, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (608, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 75, '2020-01-11 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (609, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (610, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (611, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (612, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 7, '2020-01-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (614, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-01-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (615, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (616, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (617, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 56, '2020-01-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (618, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 20, '2020-01-18 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (619, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (620, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (621, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (622, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (623, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (624, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-01-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (625, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (626, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 15, '2020-01-25 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (627, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (628, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (629, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (630, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 7, '2020-01-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (631, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (632, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-01-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (633, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-01-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (634, 10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 17, '2020-01-31 23:30:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (635, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 32, '2020-02-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (636, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$6eb81014.receivableRecordJob(<generated>)\n	... 10 more\n', 42, '2020-02-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (637, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 55, '2020-02-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (638, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 13, '2020-02-01 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (639, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (640, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (641, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (642, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (643, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-02-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (644, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-02-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (645, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (646, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 31, '2020-02-08 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (647, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (650, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 23, '2020-02-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (651, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (652, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (653, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 25, '2020-02-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (654, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (655, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 15, '2020-02-15 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (656, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-02-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (657, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (658, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (659, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 53, '2020-02-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (660, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (661, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-02-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (662, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-02-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (663, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 46, '2020-02-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (664, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 106, '2020-02-22 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (665, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 14, '2020-02-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (666, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-02-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (667, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 22, '2020-02-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (668, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-02-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (669, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-02-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (670, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-02-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (671, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 72, '2020-02-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (672, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-02-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (673, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 69, '2020-02-29 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (674, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 30, '2020-03-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (675, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$7f139851.receivableRecordJob(<generated>)\n	... 10 more\n', 26, '2020-03-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (676, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 60, '2020-03-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (677, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (678, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (679, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-03-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (680, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-03-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (681, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (682, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-03-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (683, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 45, '2020-03-07 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (684, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (685, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (686, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (687, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-03-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (688, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (689, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 43, '2020-03-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (690, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-03-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (691, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 109, '2020-03-14 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (692, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 7, '2020-03-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (693, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-03-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (694, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-03-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (695, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (696, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (697, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 66, '2020-03-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (698, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-03-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (699, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-03-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (700, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-03-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (701, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 24, '2020-03-21 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (702, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (703, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (704, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (705, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-03-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (706, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (707, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (709, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 30, '2020-03-28 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (710, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 30, '2020-03-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (711, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 16, '2020-03-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (712, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-03-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (713, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-03-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (714, 10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 23, '2020-03-31 23:30:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (715, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-04-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (716, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$64a149b.receivableRecordJob(<generated>)\n	... 10 more\n', 33, '2020-04-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (717, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 49, '2020-04-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (718, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (719, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (720, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-04-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (721, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 24, '2020-04-04 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (722, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (723, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (724, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (726, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 15, '2020-04-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (729, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 39, '2020-04-11 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (730, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 25, '2020-04-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (731, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (732, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-04-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (733, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 24, '2020-04-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (734, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (735, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (736, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-04-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (737, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-04-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (738, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 47, '2020-04-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (739, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 24, '2020-04-18 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (740, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (741, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-04-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (742, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (743, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-04-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (744, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (745, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (746, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (747, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 33, '2020-04-25 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (748, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (749, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (750, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-04-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (751, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 21, '2020-04-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (752, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (753, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-04-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (754, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-05-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (755, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$64a149b.receivableRecordJob(<generated>)\n	... 10 more\n', 35, '2020-05-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (756, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 79, '2020-05-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (757, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (758, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 34, '2020-05-02 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (759, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-05-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (760, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (761, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (762, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (763, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-05-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (764, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (765, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-05-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (766, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 35, '2020-05-09 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (767, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-05-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (768, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-05-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (770, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (771, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (772, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 23, '2020-05-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (773, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (774, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-05-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (775, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 36, '2020-05-16 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (776, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-05-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (777, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (778, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 53, '2020-05-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (779, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (780, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (781, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-05-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (782, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (783, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (784, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 40, '2020-05-23 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (785, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (786, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (787, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-05-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (788, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (789, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-05-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (790, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 26, '2020-05-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (791, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-05-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (793, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 22, '2020-05-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (794, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 36, '2020-05-30 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (795, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-05-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (796, 10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 352, '2020-05-31 23:30:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (797, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$64a149b.receivableRecordJob(<generated>)\n	... 10 more\n', 14, '2020-06-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (798, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 28, '2020-06-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (799, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 47, '2020-06-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (800, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 12, '2020-06-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (801, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 12, '2020-06-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (802, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-06-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (803, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-06-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (804, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-06-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (805, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 27, '2020-06-06 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (806, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-06-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (807, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-06-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (808, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 12, '2020-06-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (809, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-06-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (810, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-06-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (811, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 12, '2020-06-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (812, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-06-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (813, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 16, '2020-06-13 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (815, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 13, '2020-06-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (816, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-06-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (818, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-06-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (819, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-06-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (820, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 143, '2020-06-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (821, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 11, '2020-06-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (822, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 11, '2020-06-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (823, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 25, '2020-06-20 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (824, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-06-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (825, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 11, '2020-06-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (826, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 11, '2020-06-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (827, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-06-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (829, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-06-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (830, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-06-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (831, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 16, '2020-06-27 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (832, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-06-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (833, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 9, '2020-06-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (834, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-06-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (835, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-06-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (836, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-07-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (837, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$c93f555.receivableRecordJob(<generated>)\n	... 10 more\n', 29, '2020-07-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (838, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 76, '2020-07-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (839, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-07-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (840, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (841, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-07-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (842, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 74, '2020-07-04 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (843, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (844, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-07-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (845, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-07-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (846, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (847, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-07-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (848, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-07-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (849, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-07-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (850, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 20, '2020-07-11 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (851, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (852, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (853, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (854, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 8, '2020-07-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (855, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (856, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-07-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (857, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-07-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (859, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 35, '2020-07-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (860, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 21, '2020-07-18 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (861, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 35, '2020-07-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (862, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-07-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (863, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-07-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (864, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (865, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 35, '2020-07-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (866, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 13, '2020-07-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (867, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 34, '2020-07-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (868, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 17, '2020-07-25 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (869, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-07-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (870, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (871, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (872, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 9, '2020-07-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (873, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-07-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (874, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-07-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (875, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-07-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (876, 10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 21, '2020-07-31 23:30:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (877, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$c93f555.receivableRecordJob(<generated>)\n	... 10 more\n', 15, '2020-08-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (878, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 35, '2020-08-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (879, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 57, '2020-08-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (880, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 20, '2020-08-01 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (882, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (883, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (884, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (885, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (886, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-08-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (888, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 24, '2020-08-08 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (889, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 13, '2020-08-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (890, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 33, '2020-08-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (891, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (892, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-08-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (893, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (894, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (895, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 45, '2020-08-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (896, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 35, '2020-08-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (897, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 23, '2020-08-15 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (898, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (899, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 14, '2020-08-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (900, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (901, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 37, '2020-08-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (902, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-08-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (903, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (904, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-08-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (905, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (906, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 26, '2020-08-22 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (907, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (908, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (909, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-08-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (910, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-08-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (911, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (913, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 22, '2020-08-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (914, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 14, '2020-08-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (915, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 21, '2020-08-29 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (916, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-08-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (917, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 15, '2020-08-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (918, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$6eb81014.receivableRecordJob(<generated>)\n	... 10 more\n', 12, '2020-09-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (919, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 34, '2020-09-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (920, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 34, '2020-09-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (921, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-09-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (922, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (923, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-09-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (924, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-09-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (925, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 43, '2020-09-05 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (926, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (928, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-09-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (929, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (931, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (932, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (933, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 36, '2020-09-12 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (934, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-09-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (935, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-09-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (936, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 26, '2020-09-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (937, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (938, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-09-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (939, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (940, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (941, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 26, '2020-09-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (942, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (943, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 34, '2020-09-19 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (944, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (945, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-09-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (946, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (948, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 25, '2020-09-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (949, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (950, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (951, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 36, '2020-09-26 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (952, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-09-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (953, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 17, '2020-09-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (954, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 23, '2020-09-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (955, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-09-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (956, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-09-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (957, 10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 57, '2020-09-30 23:30:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (958, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 12, '2020-10-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (959, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$c93f555.receivableRecordJob(<generated>)\n	... 10 more\n', 35, '2020-10-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (960, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 56, '2020-10-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (961, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-10-02 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (962, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-10-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (963, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 18, '2020-10-03 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (964, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-10-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (965, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-10-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (967, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-10-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (968, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-10-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (971, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 41, '2020-10-10 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (973, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 26, '2020-10-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (974, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-10-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (975, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2020-10-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (976, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 27, '2020-10-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (979, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 27, '2020-10-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (980, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 45, '2020-10-17 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (981, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 17, '2020-10-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (982, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 32, '2020-10-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (983, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-10-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (985, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-10-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (986, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-10-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (987, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-10-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (989, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 27, '2020-10-24 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (990, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 26, '2020-10-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (991, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-10-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (992, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-10-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (993, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-10-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (994, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 26, '2020-10-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (995, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-10-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (996, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-10-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (997, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-10-31 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (998, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 43, '2020-10-31 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (999, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-11-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1000, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$c93f555.receivableRecordJob(<generated>)\n	... 10 more\n', 13, '2020-11-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1001, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 51, '2020-11-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1003, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-11-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1004, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-11-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1005, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-11-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1007, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-11-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1008, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 41, '2020-11-07 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1009, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-11-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1010, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-11-09 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1012, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-11-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1013, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-11-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1014, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-11-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1015, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-11-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1016, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 34, '2020-11-14 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1017, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 14, '2020-11-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1018, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-11-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1019, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-11-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1020, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-11-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1022, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 30, '2020-11-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1023, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 19, '2020-11-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1024, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2020-11-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1025, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-11-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1026, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 33, '2020-11-21 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1028, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 13, '2020-11-23 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1029, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-11-24 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1031, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 23, '2020-11-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1034, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 65, '2020-11-28 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1035, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 14, '2020-11-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1037, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 23, '2020-11-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1038, 10, 'bookletService', 'OrderTwoMonthsBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 39, '2020-11-30 23:30:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1039, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1040, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$c93f555.receivableRecordJob(<generated>)\n	... 10 more\n', 14, '2020-12-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1041, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 48, '2020-12-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1043, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-03 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1044, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-04 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1045, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-05 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1046, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 33, '2020-12-05 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1047, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-12-06 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1048, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1051, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 15, '2020-12-10 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1052, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2020-12-11 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1054, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 37, '2020-12-12 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1056, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 22, '2020-12-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1057, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 36, '2020-12-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1058, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1059, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-12-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1060, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1062, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 25, '2020-12-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1064, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 37, '2020-12-19 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1065, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 24, '2020-12-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1066, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1067, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-22 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1070, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 22, '2020-12-25 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1071, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-12-26 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1072, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 24, '2020-12-26 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1073, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-27 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1074, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2020-12-28 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1075, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 36, '2020-12-28 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1076, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-29 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1077, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2020-12-30 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1079, 198, 'receivableRecordService', 'receivableRecordJob', 'FYSZ002,qcdb002.', 1, 'java.util.concurrent.ExecutionException: java.lang.RuntimeException: receivableRecordJob\n	at java.util.concurrent.FutureTask.report(FutureTask.java:122)\n	at java.util.concurrent.FutureTask.get(FutureTask.java:192)\n	at com.qciot.module.schedule.utils.ScheduleJob.executeInternal(ScheduleJob.java:64)\n	at org.springframework.scheduling.quartz.QuartzJobBean.execute(QuartzJobBean.java:75)\n	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)\n	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)\nCaused by: java.lang.RuntimeException: receivableRecordJob\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:62)\n	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511)\n	at java.util.concurrent.FutureTask.run(FutureTask.java:266)\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)\n	at java.lang.Thread.run(Thread.java:748)\nCaused by: java.lang.reflect.InvocationTargetException\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\n	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)\n	at java.lang.reflect.Method.invoke(Method.java:498)\n	at com.qciot.module.schedule.utils.ScheduleRunnable.run(ScheduleRunnable.java:57)\n	... 5 more\nCaused by: java.lang.NullPointerException\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecord(ReceivableRecordService.java:132)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService.receivableRecordJob(ReceivableRecordService.java:102)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$FastClassBySpringCGLIB$$35b25101.invoke(<generated>)\n	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:204)\n	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.invokeJoinpoint(CglibAopProxy.java:717)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:157)\n	at org.springframework.transaction.interceptor.TransactionInterceptor$1.proceedWithInvocation(TransactionInterceptor.java:99)\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:281)\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:96)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:168)\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:92)\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:179)\n	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:653)\n	at com.qciot.module.toll.domain.receivableRecord.ReceivableRecordService$$EnhancerBySpringCGLIB$$c93f555.receivableRecordJob(<generated>)\n	... 10 more\n', 10, '2021-01-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1080, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 21, '2021-01-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1081, 7, 'bookletService', 'OrderMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 75, '2021-01-01 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1083, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 36, '2021-01-02 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1088, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 21, '2021-01-07 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1089, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 5, '2021-01-08 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1091, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 37, '2021-01-09 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1094, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 31, '2021-01-12 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1095, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2021-01-13 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1096, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 6, '2021-01-14 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1097, 8, 'bookletService', 'OrderHalfMonthBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 23, '2021-01-14 05:02:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1098, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 9, '2021-01-15 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1099, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 10, '2021-01-16 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1100, 9, 'bookletService', 'OrderWeekBookletByMeteringPersonAndMeteringDate', NULL, 0, NULL, 15, '2021-01-16 05:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1101, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2021-01-17 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1102, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 8, '2021-01-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1103, 158, 'receivableRecordService', 'receivableRecordJob', 'FYSZ001,qcdb001.', 0, NULL, 25, '2021-01-18 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1104, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2021-01-19 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1105, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2021-01-20 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1106, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2021-01-21 00:00:00');
INSERT INTO `SCHEDULE_JOB_LOG` VALUES (1107, 37, 'stepPriceProgrammeService', 'programmeJob', NULL, 0, NULL, 7, '2021-01-22 00:00:00');

-- ----------------------------
-- Table structure for SECURITY_ANNUAL_PLAN
-- ----------------------------
DROP TABLE IF EXISTS `SECURITY_ANNUAL_PLAN`;
CREATE TABLE `SECURITY_ANNUAL_PLAN`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CUSTOMER_NUMBER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `GAS_ADDRESS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_DATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `INSPECTOR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STATE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REVIEWER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REVIEWER_STATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SECURITY_ANNUAL_PLAN
-- ----------------------------

-- ----------------------------
-- Table structure for SECURITY_CHECK_RESULT
-- ----------------------------
DROP TABLE IF EXISTS `SECURITY_CHECK_RESULT`;
CREATE TABLE `SECURITY_CHECK_RESULT`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CUSTOMER_NUMBER` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `GAS_ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PLAN_NUMBER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `INSPECTOR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_DATE` datetime(0) NULL DEFAULT NULL,
  `RESULT` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REMARK` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PROPAGANDA` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REVIEWER_STATE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REVIEWER_PERSON` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REVIEWER_DATE` datetime(0) NULL DEFAULT NULL,
  `CHECK_NUMBER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `HAZARD_CLASSIFICATION` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `HAZARD_LEVEL` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `HAZARD_DESCRIPTION` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `HAZARD_STATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `HAZARD_RESULT` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RECTIFICATION_TIME` datetime(0) NULL DEFAULT NULL,
  `RECTIFICATION_PERSON` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SECURITY_CHECK_RESULT
-- ----------------------------

-- ----------------------------
-- Table structure for STAT_BRANCH_FEE_MONTH
-- ----------------------------
DROP TABLE IF EXISTS `STAT_BRANCH_FEE_MONTH`;
CREATE TABLE `STAT_BRANCH_FEE_MONTH`  (
  `MANAGMENT_AREA_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MANAGMENT_AREA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SOLD_GAS_AMOUNT` decimal(38, 0) NULL DEFAULT NULL,
  `SOLD_GAS_FEE_AMOUNT` decimal(38, 0) NULL DEFAULT NULL,
  `DEBT` decimal(38, 0) NULL DEFAULT NULL,
  `PAYMENT` decimal(38, 0) NULL DEFAULT NULL,
  `METERING_MONTH` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of STAT_BRANCH_FEE_MONTH
-- ----------------------------

-- ----------------------------
-- Table structure for STAT_PROPERTY_MONTH_FEE
-- ----------------------------
DROP TABLE IF EXISTS `STAT_PROPERTY_MONTH_FEE`;
CREATE TABLE `STAT_PROPERTY_MONTH_FEE`  (
  `GAS_PROPERTY_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `THIS_GAS_CONSUMPTION` decimal(38, 0) NULL DEFAULT NULL,
  `THIS_DERSERVED_FEE_AMOUNT` decimal(38, 0) NULL DEFAULT NULL,
  `GAS_PROPERTY_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `THIS_DEBT` decimal(38, 0) NULL DEFAULT NULL,
  `METERING_MONTH` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of STAT_PROPERTY_MONTH_FEE
-- ----------------------------

-- ----------------------------
-- Table structure for STAT_PROPERTY_SALE_MONTH
-- ----------------------------
DROP TABLE IF EXISTS `STAT_PROPERTY_SALE_MONTH`;
CREATE TABLE `STAT_PROPERTY_SALE_MONTH`  (
  `GAS_PROPERTY_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `GAS_PROPERTY_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `METERING_GAS_CONSUMPTION` decimal(38, 0) NULL DEFAULT NULL,
  `INITIAL_OWN_FEE` decimal(38, 0) NULL DEFAULT NULL,
  `THIS_MONTH_DESERVERED_FEE` decimal(38, 0) NULL DEFAULT NULL,
  `ACCUMULATED_DESERVED_FEE` decimal(38, 0) NULL DEFAULT NULL,
  `THIS_MONTH_PAYMENT` decimal(38, 0) NULL DEFAULT NULL,
  `METERING_MONTH` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of STAT_PROPERTY_SALE_MONTH
-- ----------------------------

-- ----------------------------
-- Table structure for STAT_SUB_SALE_MONTH
-- ----------------------------
DROP TABLE IF EXISTS `STAT_SUB_SALE_MONTH`;
CREATE TABLE `STAT_SUB_SALE_MONTH`  (
  `COMPANY_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `MONTH_GAS_CONSUMPTION` decimal(38, 0) NULL DEFAULT NULL,
  `LAST_ACCUM_GAS_CONSUMPTION` decimal(38, 0) NULL DEFAULT NULL,
  `THIS_ACCUM_GAS_CONSUMPTION` decimal(38, 0) NULL DEFAULT NULL,
  `METERING_MONTH` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of STAT_SUB_SALE_MONTH
-- ----------------------------

-- ----------------------------
-- Table structure for STA_ARREARAGE_MONTH_REP
-- ----------------------------
DROP TABLE IF EXISTS `STA_ARREARAGE_MONTH_REP`;
CREATE TABLE `STA_ARREARAGE_MONTH_REP`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `GAS_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `GAS_UNIT_PRICE` decimal(11, 2) NULL DEFAULT NULL,
  `REPORT_MONTH` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `GAS_USE_NUMBER` decimal(11, 2) NULL DEFAULT NULL,
  `PAYABLE_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `UNPAYABLE_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `GAS_USE_TOTAL_NUMBER` decimal(11, 2) NULL DEFAULT NULL,
  `UNPAYABLE_TOTAL_MONEY` decimal(11, 2) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of STA_ARREARAGE_MONTH_REP
-- ----------------------------

-- ----------------------------
-- Table structure for STA_PAYMENT_MONTH_REP
-- ----------------------------
DROP TABLE IF EXISTS `STA_PAYMENT_MONTH_REP`;
CREATE TABLE `STA_PAYMENT_MONTH_REP`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ADMINISTRATIVE_AREA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REPORT_MONTH` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `GAS_USE_NUMBER` decimal(11, 2) NULL DEFAULT NULL,
  `RECEIVABLE_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `UNPAYABLE_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `RETURN_RATE` decimal(11, 4) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of STA_PAYMENT_MONTH_REP
-- ----------------------------

-- ----------------------------
-- Table structure for STA_PRE_DEPOSIT_REP
-- ----------------------------
DROP TABLE IF EXISTS `STA_PRE_DEPOSIT_REP`;
CREATE TABLE `STA_PRE_DEPOSIT_REP`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REPORT_MONTH` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_AREA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_AREA_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BEFORE_PRE_DEPOSIT_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `ADD_PRE_DEPOSIT_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `CORRECT_PRE_DEPOSIT_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `AFTER_PRE_DEPOSIT_MONEY` decimal(11, 2) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of STA_PRE_DEPOSIT_REP
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_BUTTON
-- ----------------------------
DROP TABLE IF EXISTS `SYS_BUTTON`;
CREATE TABLE `SYS_BUTTON`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MODULE_GROUP_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模块组id',
  `MODULE_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模块id',
  `NAME` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `PERM` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统按钮表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_BUTTON
-- ----------------------------
INSERT INTO `SYS_BUTTON` VALUES ('2ad8f816-97f9-4dc1-95d8-b35b2f6e04c6', 'a7c8cbf2-0b3b-4b4b-822e-c037d7442e05', '6ec6d69e-59c3-4398-9d48-811fe082a99e', '审核', 'wxjm:aduit', '2019-04-22 16:38:37');
INSERT INTO `SYS_BUTTON` VALUES ('478eddd8-03a0-4934-859e-b19d77afb130', '90532a41-0fea-406b-b444-67c64a475754', 'e1db7527-81d2-44b2-8a4f-2adb4633754a', '审核', 'bzjm:aduit', '2019-04-23 09:16:40');
INSERT INTO `SYS_BUTTON` VALUES ('9a7e790c-d9db-4c43-a587-63fbefd7349c', '9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '60eee569-3016-4ee0-b2e1-5f22f1780114', '派单', 'send', '2019-04-02 14:16:49');
INSERT INTO `SYS_BUTTON` VALUES ('adf96365-26ac-4ab3-8d42-050bd9496754', '9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '60eee569-3016-4ee0-b2e1-5f22f1780114', '处理', 'handle', '2019-05-13 13:44:29');
INSERT INTO `SYS_BUTTON` VALUES ('d3afdb00-ff90-4fbe-a8ca-53fdae53a4ef', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '793495a2-er0f-43f8-bga9-2agf83e0we8e', '审核', 'tollChargeRemoteCheck', '2019-09-29 09:52:13');
INSERT INTO `SYS_BUTTON` VALUES ('de4fdd8d-21f9-48a6-b2ce-aed2ff85c152', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '4e6a0e5f-51a3-40c7-a54f-97e9840d9eb7', '安检审核', 'anjian/shenhe', '2019-03-15 11:47:52');

-- ----------------------------
-- Table structure for SYS_CONFIG
-- ----------------------------
DROP TABLE IF EXISTS `SYS_CONFIG`;
CREATE TABLE `SYS_CONFIG`  (
  `ID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PARAM_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数名称',
  `PARAM_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数代码',
  `PARAM_VALUE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数值',
  `REMARK` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统参数' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_CONFIG
-- ----------------------------
INSERT INTO `SYS_CONFIG` VALUES ('686a44b1-1d56-449f-b4de-3a436103804f', '附件下载服务器地址', 'attachmentUrl', 'http://39.100.108.130:8866/qciot', NULL);

-- ----------------------------
-- Table structure for SYS_DICTIONARY
-- ----------------------------
DROP TABLE IF EXISTS `SYS_DICTIONARY`;
CREATE TABLE `SYS_DICTIONARY`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `VALUE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_DICTIONARY
-- ----------------------------
INSERT INTO `SYS_DICTIONARY` VALUES ('4b272566-6b64-4df0-afc6-a60d7814651a', 'gasScale_03', '小工商客户', '52252175-a809-45cb-bd68-67bc53da97dd', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('f4185e3b-6eb7-4fe9-b305-c103f76392bb', 'notificationOfArrears', '欠费通知方式', '#', 'notificationOfArrears');
INSERT INTO `SYS_DICTIONARY` VALUES ('3cb0ebcc-4164-4f28-90f8-122d70383202', 'notificationOfArrears_01', '短信', 'f4185e3b-6eb7-4fe9-b305-c103f76392bb', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('aacb723d-82b5-4fc7-8ab6-05c074e6724b', 'notificationOfArrears_02', '电话', 'f4185e3b-6eb7-4fe9-b305-c103f76392bb', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('076d9269-9b8b-448e-ac8a-9905846096ce', 'payWay', '交费方式', '#', 'payWay');
INSERT INTO `SYS_DICTIONARY` VALUES ('e5c34b3b-2036-441c-9e91-807e0025a300', 'payWay_01', '自交', '076d9269-9b8b-448e-ac8a-9905846096ce', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('851f07a3-972b-48f3-82e2-9d2ce355599c', 'payWay_02', '银行代扣', '076d9269-9b8b-448e-ac8a-9905846096ce', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('55353566-f227-47ee-9aeb-22953b6211a4', 'pendingCheck', '待审批', 'ab00ddc4-7e5b-4677-ba4a-2947adfcc6e7', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('cf0ba3ee-92b4-447c-9762-8badc237e7a0', 'refund', '退回', 'ab00ddc4-7e5b-4677-ba4a-2947adfcc6e7', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('6bbb80fb-da9d-463a-9401-64f0a0aec789', 'cycleUnitType', '周期单位', '#', 'cycleUnitType');
INSERT INTO `SYS_DICTIONARY` VALUES ('2958337e-8911-4936-b96f-88cab891f383', 'cycleUnitType_01', '月', '6bbb80fb-da9d-463a-9401-64f0a0aec789', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('c7e9469c-43c8-4c76-ba0b-6099299e6a37', 'cycleUnitType_02', '季', '6bbb80fb-da9d-463a-9401-64f0a0aec789', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('c97590e5-79aa-46c7-80ad-bac7527db8ba', 'cycleUnitType_03', '年', '6bbb80fb-da9d-463a-9401-64f0a0aec789', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('d1f2141e-d10e-499f-b9a2-28a5ec0e145f', 'gasMeterPayType', '付费类型', '#', 'gasMeterPayType');
INSERT INTO `SYS_DICTIONARY` VALUES ('05388692-416b-4ac1-a1a9-fd19f8f051cd', 'gasMeterPayType_01', '量控', 'd1f2141e-d10e-499f-b9a2-28a5ec0e145f', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('02e98523-5f23-4061-b56e-6b08f3c5499d', 'tollChargeCircle', '费用周期', '#', 'tollChargeCircle');
INSERT INTO `SYS_DICTIONARY` VALUES ('ff9d9f83-c6e1-4eea-9717-a1c667c29da7', 'gasMeterPayType_02', '额控', 'd1f2141e-d10e-499f-b9a2-28a5ec0e145f', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('6f826a8a-9370-4c40-bf0a-4020f9afa936', 'securityCheckItemType', '安检项类型', '#', 'securityCheckItemType');
INSERT INTO `SYS_DICTIONARY` VALUES ('cd4e6ae8-b32e-4f15-ae7c-46eda9802000', 'securityCheckItemType_01', '单选框', '6f826a8a-9370-4c40-bf0a-4020f9afa936', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('6e7a8868-5360-4640-a21c-31350745ec3b', 'securityCheckItemType_02', '复选框', '6f826a8a-9370-4c40-bf0a-4020f9afa936', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('3cc7d41d-e331-477b-a075-9911357a4db0', 'securityCheckItemType_03', '文字框', '6f826a8a-9370-4c40-bf0a-4020f9afa936', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('7c9433c9-a9bd-4fa4-832c-58a7a0709274', 'stepModeType', '阶梯方式', '#', 'stepModeType');
INSERT INTO `SYS_DICTIONARY` VALUES ('5df2011a-31ee-4b99-b1ed-af0f56b1ab28', 'stepModeType_01', '分段阶梯', '7c9433c9-a9bd-4fa4-832c-58a7a0709274', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('f686f3df-8a3b-45f7-bf3a-ac706fdce98d', 'stepModeType_02', '实时阶梯', '7c9433c9-a9bd-4fa4-832c-58a7a0709274', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('17084ef2-bc9d-4c55-9bac-63a98b6efd38', 'validType', '有效类型', '#', 'validType');
INSERT INTO `SYS_DICTIONARY` VALUES ('9eee7ecb-be23-42d1-a527-f2a3fefe2c4f', 'validType_01', '无效', '17084ef2-bc9d-4c55-9bac-63a98b6efd38', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('6dedff62-5e6c-4872-a617-4233e4db3b03', 'validType_02', '有效', '17084ef2-bc9d-4c55-9bac-63a98b6efd38', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('c7a833b4-8ff9-48d8-bff3-26d00a422f3c', 'yesNoType', '是否类型', '#', 'yesNoType');
INSERT INTO `SYS_DICTIONARY` VALUES ('6e2df53e-83d9-40fd-9703-072a552fb556', 'yesNoType_01', '是', 'c7a833b4-8ff9-48d8-bff3-26d00a422f3c', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('85d0143e-be98-41b1-bc51-daf5352b7a9c', 'yesNoType_02', '否', 'c7a833b4-8ff9-48d8-bff3-26d00a422f3c', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('0fde139f-9f33-4bb5-b22d-b5ce344320f9', 'meteringWay', '抄表方式', '#', 'meteringWay');
INSERT INTO `SYS_DICTIONARY` VALUES ('8c09a86d-2e21-4db2-8362-b504df5cab0f', 'meteringWay_02', '估抄', '0fde139f-9f33-4bb5-b22d-b5ce344320f9', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('1c51926d-8907-4715-b517-987b446cdf62', 'meteringWay_03', '自报', '0fde139f-9f33-4bb5-b22d-b5ce344320f9', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('c2d3095e-b16a-4963-a069-d19a744dc03c', 'resultState_03', '拒绝安检', '977469af-db93-4354-8c8e-6ed8bdbea72a', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('490a997d-ec22-4477-a48b-f4c4b2c930ce', 'resultState_01', '正常安检', '977469af-db93-4354-8c8e-6ed8bdbea72a', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('e45da1a4-96fb-4835-a7e9-781c617664c5', 'resultState_02', '到访不遇', '977469af-db93-4354-8c8e-6ed8bdbea72a', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('dbffaa2d-9930-4af1-bb00-50a0856a84e3', 'inventoryStatus-01', '出库', 'c0987a6f-7b67-436d-bea6-e1a6d7c5f33b', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('100701d3-5c18-43fe-a59f-3c80ae9056ed', 'preDepositRefund', '预存款退费', '563a1127-473b-4442-a26d-48af2fa29835', '10');
INSERT INTO `SYS_DICTIONARY` VALUES ('9b16acb1-917e-4e0b-b9e1-f574d625141e', 'taskType_12', '请审核短信', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '12');
INSERT INTO `SYS_DICTIONARY` VALUES ('5617f025-93d8-42e3-8148-c9f7e706dc1f', 'heatingPlan', '采暖计划', '#', 'heatingPlan');
INSERT INTO `SYS_DICTIONARY` VALUES ('51f3a71b-b838-4d18-b570-375db27ee368', 'meteringWay_04', '远传', '0fde139f-9f33-4bb5-b22d-b5ce344320f9', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('6601c933-3c19-485e-a27d-a143459935a7', 'status', '抄表册状态', '#', 'status');
INSERT INTO `SYS_DICTIONARY` VALUES ('3c3bfafe-1a1c-4e23-9331-5d9c782c3c76', 'status_01', '在用', '6601c933-3c19-485e-a27d-a143459935a7', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('d18b2462-a9af-4ad3-ae96-b071fcbfd4d2', 'status_02', '注销', '6601c933-3c19-485e-a27d-a143459935a7', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('659f4a8f-5fd5-408e-92ff-58ef4a9ebd24', 'garbage', '垃圾费', '4b8bb71f-c61c-4c36-a49c-9cd41fc08055', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('de06f841-e0a7-4ebb-a01d-765d6c8c86bd', 'meteringStatus_02', '已抄表', '88131e45-74f0-4daf-841b-16c39cc73db1', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('d477826f-3abe-4a50-abaa-99bc5b9157d6', 'meteringStatus_01', '未抄表', '88131e45-74f0-4daf-841b-16c39cc73db1', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('c6cedeea-904d-4c64-8768-1812539e6c2d', 'payoffWhether', '是否结清', '#', 'payoffWhether');
INSERT INTO `SYS_DICTIONARY` VALUES ('1bc28ae5-e648-4f0b-a45e-eba19fc27cad', 'payoffWhether_01', '否', 'c6cedeea-904d-4c64-8768-1812539e6c2d', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('fc457686-f9f9-4f68-85e6-86bac399825e', 'payoffWhether_02', '是', 'c6cedeea-904d-4c64-8768-1812539e6c2d', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('114d901d-e705-4fdc-bdd6-4d18a6f2270e', 'promptWhether', '是否催费', '#', 'promptWhether');
INSERT INTO `SYS_DICTIONARY` VALUES ('082ffd32-5573-431f-8387-b2f5795ea467', 'promptWhether_01', '未催费', '114d901d-e705-4fdc-bdd6-4d18a6f2270e', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('ed69f62c-18c5-421d-b7fd-12a1acc9e481', 'promptWhether_02', '已催费', '114d901d-e705-4fdc-bdd6-4d18a6f2270e', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('4afa8038-b5bd-4a63-a1dd-ac5522b7841d', 'gaspaymentType', '气费类型', '#', 'gaspaymentType');
INSERT INTO `SYS_DICTIONARY` VALUES ('ea0e3bf8-4352-4b6e-afca-495a063c2260', 'gaspaymentType_01', '用气', '4afa8038-b5bd-4a63-a1dd-ac5522b7841d', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('e9a20322-64ea-4f85-9d5a-665fe2ebfea2', 'gaspaymentType_02', '调账', '4afa8038-b5bd-4a63-a1dd-ac5522b7841d', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('151656b7-0d8f-4585-9f0d-de12f8b5fbeb', 'refunding', '退费申请中', '4ec4ad53-f2fd-4760-becf-296ba0900848', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('5612914d-bfb6-428b-aadb-3e9a5a26b498', 'refunded', '退费完成', '4ec4ad53-f2fd-4760-becf-296ba0900848', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('275bc9fc-b07d-43d8-8f81-ffb73966fde4', 'transfering', '调账申请中', '4ec4ad53-f2fd-4760-becf-296ba0900848', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('f5fc8f7c-67d1-4236-9c24-b2c4ea8767e7', 'transfered', '调账完成', '4ec4ad53-f2fd-4760-becf-296ba0900848', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('737dad5a-24f3-4285-bc2a-4e840e476df6', 'charged', '已交接', '4ec4ad53-f2fd-4760-becf-296ba0900848', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('c897b01f-dcee-4c1f-86be-539f3d79d532', 'taskType', '任务类型', '#', 'taskType');
INSERT INTO `SYS_DICTIONARY` VALUES ('e5125474-db93-4ec9-8da8-0934b7daccdc', 'refundManage', '退费申请审批', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('3be13835-0d34-4a34-bac1-ab4911abf42e', 'tollRefundType_1', '现金', 'b74be31e-3b9e-40e6-b7b8-8578df9ba5ef', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('cb008f8d-3a56-4936-b6ed-6b0afa8c7a24', 'tollRefundType_4', '支付宝', 'b74be31e-3b9e-40e6-b7b8-8578df9ba5ef', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('b9affe0b-bddc-4a0b-9a22-1bc92e999082', 'tollRefundType_5', '支票', 'b74be31e-3b9e-40e6-b7b8-8578df9ba5ef', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('c75d5a6f-f30a-492b-b397-045a3fc9512d', 'workorderType_03', '维修', '93602e82-b5ea-4310-9fff-2d833dbf12c5', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('ce187893-e30a-4a0e-8ea5-ac26c5ed125b', 'chargeWay_02', '按比例收取', 'b741fab1-65b0-4645-afad-201b070dd6b9', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('a0d74f2b-c8fc-4bb7-8d33-ace0515db91f', 'chargeWay_03', '不收取', 'b741fab1-65b0-4645-afad-201b070dd6b9', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('a3531410-efa3-4a3d-a046-d03038ec4cba', 'appVersionUpdateSign', 'APP更新标识', '#', 'appVersionUpdateSign');
INSERT INTO `SYS_DICTIONARY` VALUES ('97a7ed26-cc03-48bd-964d-ebd4761d6e63', 'appVersionUpdateSign_0', '没有更新', 'a3531410-efa3-4a3d-a046-d03038ec4cba', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('75e1af86-ffb5-4fb1-98ff-7bd68b866fa0', 'chargeWay_01', '全部收取', 'b741fab1-65b0-4645-afad-201b070dd6b9', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('526dfcfe-61c7-400f-8353-1f12f5a80daf', 'smsSendState', '短信发送状态', '#', 'smsSendState');
INSERT INTO `SYS_DICTIONARY` VALUES ('03905461-3f5e-4ead-9f1a-d331be719577', 'smsSendState_01', '未发送', '526dfcfe-61c7-400f-8353-1f12f5a80daf', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('e61635d3-33ba-427d-a978-e0a9b5d9614e', 'smsSendState_02', '发送中', '526dfcfe-61c7-400f-8353-1f12f5a80daf', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('0149d5b9-7ee3-4cc2-bb29-229a83fbbc9a', 'smsSendState_03', '已发送', '526dfcfe-61c7-400f-8353-1f12f5a80daf', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('a737f7d0-f5bf-4e73-a97f-ab797c3da97b', 'gasMeterStatus', '气表状态', '#', 'gasMeterStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('f0efc7a9-3793-4a6b-bebd-2ab1b3cd0989', 'gasMeterStatus_1', '未启用', 'a737f7d0-f5bf-4e73-a97f-ab797c3da97b', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('5c33af5d-985f-4675-b06f-eb59a829b129', 'gasMeterStatus_2', '启用', 'a737f7d0-f5bf-4e73-a97f-ab797c3da97b', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('984c7b96-e0c0-4d73-9355-9bed9c12720a', 'operatorType', '操作员类型', '#', 'operatorType');
INSERT INTO `SYS_DICTIONARY` VALUES ('19ac4a0c-68a8-4d31-b445-025c9d754257', 'orgType_02', '分公司', 'f5cf5d77-9de6-426c-b989-50106b7a6506', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('36d62fe5-878e-43e8-b190-d684cbedb6d0', 'orgType_01', '公司', 'f5cf5d77-9de6-426c-b989-50106b7a6506', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('f5cf5d77-9de6-426c-b989-50106b7a6506', 'orgType', '机构类型', '#', 'orgType');
INSERT INTO `SYS_DICTIONARY` VALUES ('0eefe313-840b-42ef-847c-488cd0cf5994', 'operatorType_01', '抄表员', '984c7b96-e0c0-4d73-9355-9bed9c12720a', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('f0ba9fbd-dc70-44bf-a8f7-9fb44df06520', 'operatorType_02', '安检员', '984c7b96-e0c0-4d73-9355-9bed9c12720a', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('6ea54efa-4a94-4134-b684-e37070777931', 'NATIVE', 'NATIVE', 'ebdd8f00-61c5-4fc2-8754-0e40c23bddd3', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('8c1e2b60-e3af-45e4-9031-4dbca0907c56', 'icGas', 'IC卡气费', '563a1127-473b-4442-a26d-48af2fa29835', '8');
INSERT INTO `SYS_DICTIONARY` VALUES ('f5727d79-06ad-405c-b44e-3e805bde88fd', 'bailRefund', '保证金退费', '563a1127-473b-4442-a26d-48af2fa29835', '9');
INSERT INTO `SYS_DICTIONARY` VALUES ('3c8084ba-e8ba-45a6-9e8a-d9c5a1af3f8c', 'prePay', '预付款表', '563a1127-473b-4442-a26d-48af2fa29835', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('fe404fb0-ae1f-4f90-bf7d-9789cf163236', 'preDeposit', '预存款', '563a1127-473b-4442-a26d-48af2fa29835', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('ea618303-f818-4e3e-9238-950cfdcc490d', 'state_02', '离职', 'b6c777d5-6cb4-4fef-b41a-fe0180d0923b', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('af2aced6-aacc-46da-9f99-a69e740ad99b', 'inside', '公司内部员工', '#', 'inside');
INSERT INTO `SYS_DICTIONARY` VALUES ('10b90ba3-6b75-43ca-8279-6d8ee1040f25', 'inside_01', '是', 'af2aced6-aacc-46da-9f99-a69e740ad99b', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('1812e05c-9072-4702-a03e-f26ec89e807a', 'recpienceStatus_03', '已归还', '51a85b1b-1db6-4482-94a9-5ef9f5260a10', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('a3b68bf7-92c3-4ffa-a8fc-072cea29ead5', 'tollIsPrint', '票据打印', '#', 'tollIsPrint');
INSERT INTO `SYS_DICTIONARY` VALUES ('e5b253fd-dd66-4ad3-b63b-c3afbd1228ff', 'invoice_is_print', '收据', 'a3b68bf7-92c3-4ffa-a8fc-072cea29ead5', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('1a326371-82ab-475a-ab5c-2c9bea7eef9d', 'receipt_is_print', '电子发票', 'a3b68bf7-92c3-4ffa-a8fc-072cea29ead5', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('ff400f4e-ce7c-4b25-a0fb-b2f8480b34dd', 'auditingStatus_03', '拒绝', 'dadf71ad-adee-4a64-b2c8-36e5cb1a4309', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('e3436e7c-7278-4a7b-8236-bff8affc5e6c', 'inside_02', '否', 'af2aced6-aacc-46da-9f99-a69e740ad99b', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('ece2acc3-0a8c-4b4b-9b90-48a1f9146992', 'smsAuditState', '短信审核状态', '#', 'smsAuditState');
INSERT INTO `SYS_DICTIONARY` VALUES ('6b937602-e00b-4657-a166-d69872264de2', 'smsAuditState_01', '未发起', 'ece2acc3-0a8c-4b4b-9b90-48a1f9146992', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('7c5ca326-973c-43c5-b6f4-5bd495ae5ebd', 'smsAuditState_02', '待审核', 'ece2acc3-0a8c-4b4b-9b90-48a1f9146992', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('c7a89215-a943-42ed-9c6c-a5bc20d00713', 'smsAuditState_03', '已审核', 'ece2acc3-0a8c-4b4b-9b90-48a1f9146992', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('9fd77ea9-8201-489a-98bd-d03ff4c702dc', 'smsAuditState_04', '拒绝', 'ece2acc3-0a8c-4b4b-9b90-48a1f9146992', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('f32783af-e302-49ec-ad8a-13870b65f5c0', 'gender', '性别', '#', 'gender');
INSERT INTO `SYS_DICTIONARY` VALUES ('d74f4e15-543b-4a06-bd30-e6e7e9ed01b5', 'gender-01', '男', 'f32783af-e302-49ec-ad8a-13870b65f5c0', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('7934b5c6-c9cd-4663-a3e2-532c6f0f0d34', 'enabled', '账户可用', '#', 'enabled');
INSERT INTO `SYS_DICTIONARY` VALUES ('35e8ed75-58fb-4aea-8997-fda8995acf2e', 'workorderStatus', '工单状态', '#', 'workorderStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('5599cb79-1322-41e0-a6ee-f8157243704c', 'workorderStatus_01', '未发起', '35e8ed75-58fb-4aea-8997-fda8995acf2e', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('7b9a99ac-860e-46f9-88f8-de33178a159b', 'credentialsExpired-01', '否', '1bd90248-b7d6-4eae-b837-3f5fbd4e0b1d', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('f16095c8-d8d6-466d-918a-2d0caa419af5', 'workorderStatus_02', '未派单', '35e8ed75-58fb-4aea-8997-fda8995acf2e', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('3299eac0-0766-4b15-8be6-d951dec212e2', 'accountLocked-02', '是', 'b1ff370b-5c6a-4646-9562-b7d0a42ef593', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('1996f6f4-7ea6-4427-90c1-93f3c0981fbc', 'codeRule_generateType_02', '每周', '774aaad7-2a90-4608-93d7-9d96451eba46', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('b09fcb3d-e9c5-450f-bc52-ecf0fcd923d5', 'codeRule_generateType_04', '每年', '774aaad7-2a90-4608-93d7-9d96451eba46', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('c750ddce-989b-4101-bb38-3c7f4b1f412a', 'month', '月', '02e98523-5f23-4061-b56e-6b08f3c5499d', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('7caedbad-1783-47e9-8655-8c86e4ca801e', 'year', '年', '02e98523-5f23-4061-b56e-6b08f3c5499d', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('563a1127-473b-4442-a26d-48af2fa29835', 'tollChargeType', '收费性质', '#', 'tollChargeType');
INSERT INTO `SYS_DICTIONARY` VALUES ('e1a64f0e-c99f-4b35-8543-8ae2453cd9a1', 'generalGas', '普表气费', '563a1127-473b-4442-a26d-48af2fa29835', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('82c73d8d-3703-4974-ac0b-1f40b0c76a47', 'business', '业务费', '563a1127-473b-4442-a26d-48af2fa29835', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('84c0feef-17be-4c0f-9b79-a683d8c68773', 'recpienceStatus_01', '没人领用', '51a85b1b-1db6-4482-94a9-5ef9f5260a10', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('bde02005-3539-4ad1-ae8b-d555d13abec5', 'bail', '保证金', '563a1127-473b-4442-a26d-48af2fa29835', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('4b8bb71f-c61c-4c36-a49c-9cd41fc08055', 'tollBusinessChargeType', '业务费类型', '#', 'tollBusinessChargeType');
INSERT INTO `SYS_DICTIONARY` VALUES ('6a53bdec-33e6-41ad-b889-30aa45a4c73d', 'meteringPeriod_02', '半月', '8e6a92da-d1b9-437e-9df9-f024d4eeb404', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('8e6a92da-d1b9-437e-9df9-f024d4eeb404', 'meteringPeriod', '抄表周期', '#', 'meteringPeriod');
INSERT INTO `SYS_DICTIONARY` VALUES ('93ce08c8-4aeb-44ca-a55b-1cfa02ca6b40', 'meteringPeriod_01', '周', '8e6a92da-d1b9-437e-9df9-f024d4eeb404', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('1d742661-f3fb-451f-81d1-fa31ac241478', 'meteringPeriod_03', '月', '8e6a92da-d1b9-437e-9df9-f024d4eeb404', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('1dd0274d-77b1-41fa-917b-e7836189c0e5', 'meteringPeriod_04', '双月', '8e6a92da-d1b9-437e-9df9-f024d4eeb404', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('87e0937f-8fd8-4c7f-9639-846d7c32eb43', 'meteringPeriod_05', '季度', '8e6a92da-d1b9-437e-9df9-f024d4eeb404', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('360ec263-600a-457e-8b24-a0b33f360a5d', 'meteringPeriod_06', '半年', '8e6a92da-d1b9-437e-9df9-f024d4eeb404', '6');
INSERT INTO `SYS_DICTIONARY` VALUES ('6f3f7b50-9690-4433-b95b-cccbaf50d1d5', 'meteringWay_01', '见抄', '0fde139f-9f33-4bb5-b22d-b5ce344320f9', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('5a33b96c-c31f-4f75-80bd-5701b7ca4120', 'complete', '完成', 'ab00ddc4-7e5b-4677-ba4a-2947adfcc6e7', '6');
INSERT INTO `SYS_DICTIONARY` VALUES ('1c8c80ec-f410-4ec7-aad6-fb6402ca41fc', 'tollIsClear', '费用是否结清', '#', 'tollIsClear');
INSERT INTO `SYS_DICTIONARY` VALUES ('e8d002c8-5a60-42a2-87a7-8a31f4ef6988', 'yes', '是', '1c8c80ec-f410-4ec7-aad6-fb6402ca41fc', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('30aa5dfb-1cb3-4705-ac4c-51cdb4a79918', 'no', '否', '1c8c80ec-f410-4ec7-aad6-fb6402ca41fc', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('dadf71ad-adee-4a64-b2c8-36e5cb1a4309', 'auditingStatus', '审核状态', '#', 'auditingStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('124d015d-e95f-4a48-9749-c18331d04148', 'auditingStatus_01', '未审核', 'dadf71ad-adee-4a64-b2c8-36e5cb1a4309', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('1848bfd4-5c15-4fd2-98dd-72a047bc0f0d', 'auditingStatus_02', '同意', 'dadf71ad-adee-4a64-b2c8-36e5cb1a4309', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('6512dc46-c820-4b85-a6d0-032855d3f143', 'tollBankType', '银行类型', '#', 'tollBankType');
INSERT INTO `SYS_DICTIONARY` VALUES ('d72769e5-1874-45bd-aeac-b1338dfa2398', '1', '中国银行', '6512dc46-c820-4b85-a6d0-032855d3f143', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('a8e26934-76bc-4c63-9121-e3155a552047', '2', '成都银行', '6512dc46-c820-4b85-a6d0-032855d3f143', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('51a85b1b-1db6-4482-94a9-5ef9f5260a10', 'recpienceStatus', '领用状态', '#', 'recpienceStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('c260dd72-4e9a-462b-ab09-a7ac29265421', 'recpienceStatus_02', '未归还', '51a85b1b-1db6-4482-94a9-5ef9f5260a10', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('b1ff370b-5c6a-4646-9562-b7d0a42ef593', 'accountLocked', '账户锁定', '#', 'accountLocked');
INSERT INTO `SYS_DICTIONARY` VALUES ('16781ec1-d1d3-4756-b2ad-071589450b52', 'accountLocked-01', '否', 'b1ff370b-5c6a-4646-9562-b7d0a42ef593', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('08396498-a97d-4913-9f36-c8bec4d38c00', 'workorderStatus_04', '已接单', '35e8ed75-58fb-4aea-8997-fda8995acf2e', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('88fa59c6-58a9-440b-bbbb-5515134495d6', 'workorderStatus_03', '待接单', '35e8ed75-58fb-4aea-8997-fda8995acf2e', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('774aaad7-2a90-4608-93d7-9d96451eba46', 'codeRule_generateType', '流水号生成类型', '#', 'generateType');
INSERT INTO `SYS_DICTIONARY` VALUES ('dc86e209-25a1-4f30-ab6c-2b3c3b641f48', 'codeRule_generateType_01', '每天', '774aaad7-2a90-4608-93d7-9d96451eba46', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('19d39ee0-5448-4809-af02-db30f858d520', 'codeRule_generateType_03', '每月', '774aaad7-2a90-4608-93d7-9d96451eba46', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('7377c278-1a35-4015-b861-b100e55faaef', 'isShow-01', '否', 'f526ca93-502f-4b03-9fce-a077d83d8082', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('f526ca93-502f-4b03-9fce-a077d83d8082', 'isShow', '是否按钮', '#', 'isShow');
INSERT INTO `SYS_DICTIONARY` VALUES ('c4bb1441-fcf1-4ac4-b627-2195ef9daf53', 'isShow-02', '是', 'f526ca93-502f-4b03-9fce-a077d83d8082', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('ebdd8f00-61c5-4fc2-8754-0e40c23bddd3', 'financeWechatTradeType', '微信支付类型', '#', 'financeWechatTradeType');
INSERT INTO `SYS_DICTIONARY` VALUES ('7c76fb6a-6396-4a14-acbf-c64f99e1a4cf', 'checked', '已审批', 'ab00ddc4-7e5b-4677-ba4a-2947adfcc6e7', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('8f92dbb7-0db7-42ff-a9ac-7c19375d733c', 'refuse', '拒绝', 'ab00ddc4-7e5b-4677-ba4a-2947adfcc6e7', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('0fd2d7c0-ac67-4a8c-ac45-03c9d872de9c', 'meteringPeriod_07', '年', '8e6a92da-d1b9-437e-9df9-f024d4eeb404', '7');
INSERT INTO `SYS_DICTIONARY` VALUES ('19f3bac1-03e7-4595-a4a9-c899f73f7918', 'combined', '组合收费', '563a1127-473b-4442-a26d-48af2fa29835', '7');
INSERT INTO `SYS_DICTIONARY` VALUES ('254f3bdd-98b2-4157-b264-577b6d256b4d', 'smsbusinessType', '短信业务类型', '#', 'smsbusinessType');
INSERT INTO `SYS_DICTIONARY` VALUES ('5e67563e-f9af-439b-85d1-b9c39af7867f', 'smsbusinessType_01', '通知类', '254f3bdd-98b2-4157-b264-577b6d256b4d', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('dbc36921-d492-45a2-a829-72dc20750f5f', 'service', '服务费', '4b8bb71f-c61c-4c36-a49c-9cd41fc08055', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('88131e45-74f0-4daf-841b-16c39cc73db1', 'meteringStatus', '抄表状态', '#', 'meteringStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('480726e1-4e66-4307-b2f0-ffe9fd5ea223', 'teamGas', '团缴费', '563a1127-473b-4442-a26d-48af2fa29835', '6');
INSERT INTO `SYS_DICTIONARY` VALUES ('b2f9d1d9-5ef5-4630-a63b-2b614311b3fc', 'gender-02', '女', 'f32783af-e302-49ec-ad8a-13870b65f5c0', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('7b003064-172e-4ea1-b524-4c165ad01525', 'enabled-01', '是', '7934b5c6-c9cd-4663-a3e2-532c6f0f0d34', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('49f2aa43-96b4-4065-9083-079c6736b953', 'enabled-02', '否', '7934b5c6-c9cd-4663-a3e2-532c6f0f0d34', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('e780ceb3-5299-4dec-8c52-2ba4d97bd85c', 'accountExpired', '账户过期', '#', 'accountExpired');
INSERT INTO `SYS_DICTIONARY` VALUES ('1bd90248-b7d6-4eae-b837-3f5fbd4e0b1d', 'credentialsExpired', '凭证过期', '#', 'credentialsExpired');
INSERT INTO `SYS_DICTIONARY` VALUES ('72bafbca-ba61-4a6a-be17-8f5c8083b043', 'accountExpired-02', '是', 'e780ceb3-5299-4dec-8c52-2ba4d97bd85c', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('49ddd9e1-09a4-4e58-aee9-51f8457d4bb5', 'accountExpired-01', '否', 'e780ceb3-5299-4dec-8c52-2ba4d97bd85c', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('fa40ffd3-4401-4c82-bc61-ec12b7e50864', 'credentialsExpired-02', '是', '1bd90248-b7d6-4eae-b837-3f5fbd4e0b1d', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('e798f2fa-5304-473b-a58f-adb40cda2d5e', 'workorderStatus_05', '已完成', '35e8ed75-58fb-4aea-8997-fda8995acf2e', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('4b63315c-f4b5-4948-9115-67d8d16f0fb1', 'smsbusinessType_02', '营销类', '254f3bdd-98b2-4157-b264-577b6d256b4d', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('b6c777d5-6cb4-4fef-b41a-fe0180d0923b', 'state', '工作状态', '#', 'state');
INSERT INTO `SYS_DICTIONARY` VALUES ('cf7dd2f4-81bf-4ded-86be-519f50c0077e', 'state_01', '在职', 'b6c777d5-6cb4-4fef-b41a-fe0180d0923b', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('420798cf-a1ca-4d73-9843-7893fa0fe328', 'executedWhether', '是否执行', '#', 'executedWhether');
INSERT INTO `SYS_DICTIONARY` VALUES ('4babdb68-1cc9-46e3-98b5-e1e9bdb480f6', 'executedWhether-01', '否', '420798cf-a1ca-4d73-9843-7893fa0fe328', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('0ed20561-47da-4474-9a9a-ba9e23111b6d', 'executedWhether-02', '是', '420798cf-a1ca-4d73-9843-7893fa0fe328', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('4ec4ad53-f2fd-4760-becf-296ba0900848', 'tollChargeStatus', '收费状态', '#', 'tollChargeStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('4dbc4fb6-bd41-4dba-868c-f8e2f1c752d3', 'correction', '冲正', '4ec4ad53-f2fd-4760-becf-296ba0900848', '-1');
INSERT INTO `SYS_DICTIONARY` VALUES ('1715d279-8424-462e-834b-5314df96ac12', 'counter', '正常收费', '4ec4ad53-f2fd-4760-becf-296ba0900848', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('ab00ddc4-7e5b-4677-ba4a-2947adfcc6e7', 'tollCheckStatus', '收费审核状态', '#', 'tollCheckStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('97d44268-5194-4f03-84fb-faf10a776556', 'installationSite', '安装位置', '#', 'installationSite');
INSERT INTO `SYS_DICTIONARY` VALUES ('682e8e60-b49e-4822-9d51-5156d01228dc', 'installationSite_01', '户内表', '97d44268-5194-4f03-84fb-faf10a776556', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('3e686b8f-5bc7-4c25-9b00-6ba1923fde4b', 'installationSite_02', '户外表', '97d44268-5194-4f03-84fb-faf10a776556', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('51f1372a-4a9f-4d33-a9e7-842b34820a7c', 'payType', '付费类型', '#', 'payType');
INSERT INTO `SYS_DICTIONARY` VALUES ('02d5acd1-8f4b-4af7-a264-d6a9e3c9e984', 'payType_01', '预付', '51f1372a-4a9f-4d33-a9e7-842b34820a7c', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('0101ab9c-e3c8-451e-99d5-f66cf27eedea', 'payType_02', '后付', '51f1372a-4a9f-4d33-a9e7-842b34820a7c', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('e723354c-7a4b-480f-8745-c8b7f7112d83', 'tollTaskDatetime', '一次性收费类型', '#', 'tollTaskDatetime');
INSERT INTO `SYS_DICTIONARY` VALUES ('8968be67-d37e-4526-bd3b-f94763012f31', 'MICROPAY', 'MICROPAY', 'ebdd8f00-61c5-4fc2-8754-0e40c23bddd3', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('84821a64-f598-44f5-9bcf-709b1744501e', 'all', '新开户全收', 'e723354c-7a4b-480f-8745-c8b7f7112d83', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('919879e2-b58a-4589-8fbe-6c9d1b7c7a43', 'per', '新开户按比例收', 'e723354c-7a4b-480f-8745-c8b7f7112d83', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('5ac273a1-6440-4a01-a300-f5718e1e273b', 'not', '新开户当年不收', 'e723354c-7a4b-480f-8745-c8b7f7112d83', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('b741fab1-65b0-4645-afad-201b070dd6b9', 'chargeWay', '新用户开户当年收取方法', '#', 'chargeWay');
INSERT INTO `SYS_DICTIONARY` VALUES ('8b377f32-134c-4e77-96d7-a205fd694817', 'notInitiated', '未发起', 'ab00ddc4-7e5b-4677-ba4a-2947adfcc6e7', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('4ea5a141-fe4c-4b8a-8e84-45f4f5bf5cc5', 'customerStatus', '客户状态', '#', 'customerStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('80fd1eec-b052-406f-a796-267e36e54217', 'customerStatus_01', '有效客户', '4ea5a141-fe4c-4b8a-8e84-45f4f5bf5cc5', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('71e4de8a-b57b-40dd-b86a-338f3aa58b4d', 'customerStatus_02', '无效客户', '4ea5a141-fe4c-4b8a-8e84-45f4f5bf5cc5', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('0dc7470d-9789-4117-97be-f1c4c9cc9030', 'customerStatus_03', '潜在客户', '4ea5a141-fe4c-4b8a-8e84-45f4f5bf5cc5', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('0afa1762-4438-4e99-98c8-75c3ac8c7527', 'credentialsType', '证件类型', '#', 'credentialsType');
INSERT INTO `SYS_DICTIONARY` VALUES ('b6abbe73-c7eb-4798-8af3-c37903f73fcd', 'credentialsType_02', '临时身份证', '0afa1762-4438-4e99-98c8-75c3ac8c7527', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('52252175-a809-45cb-bd68-67bc53da97dd', 'gasScale', '用气规模', '#', 'gasScale');
INSERT INTO `SYS_DICTIONARY` VALUES ('17c4aa37-fcc6-4c0c-8556-889b3b79ea03', 'gasScale_01', '大客户', '52252175-a809-45cb-bd68-67bc53da97dd', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('3479458f-22eb-428b-8b90-9e6d5b1bc814', 'gasScale_02', '民用客户', '52252175-a809-45cb-bd68-67bc53da97dd', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('d9cbe07f-033e-4d36-b3b6-c60c0b728814', 'tollRefundType_3', '微信', 'b74be31e-3b9e-40e6-b7b8-8578df9ba5ef', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('93602e82-b5ea-4310-9fff-2d833dbf12c5', 'workorderType', '工单类型', '#', 'workorderType');
INSERT INTO `SYS_DICTIONARY` VALUES ('0fa19219-9c82-47f9-95fe-489e43d1e00a', 'workorderType_01', '安检', '93602e82-b5ea-4310-9fff-2d833dbf12c5', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('240807f3-5e00-4f14-beb1-754e691769c8', 'workorderType_02', '报装改造', '93602e82-b5ea-4310-9fff-2d833dbf12c5', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('d5c568d1-1de2-4d95-ab03-cea0145f7080', 'financeTicketStatus', '票本状态', '#', 'financeTicketStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('e0959962-0389-4c40-a4d8-b38144d89612', 'in', '入库', 'd5c568d1-1de2-4d95-ab03-cea0145f7080', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('07076fb0-3a96-474d-acd4-d0f800722e80', 'use', '领用', 'd5c568d1-1de2-4d95-ab03-cea0145f7080', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('1d4ca2d6-b219-4cfd-b806-9ca8233419a7', 'financeTransferType', '转款方向', '#', 'financeTransferType');
INSERT INTO `SYS_DICTIONARY` VALUES ('3c492107-801d-41e5-9809-289375f02977', 'transfer_in', '转入', '1d4ca2d6-b219-4cfd-b806-9ca8233419a7', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('7cc75d15-fce7-407b-a5e8-3476ab078e88', 'workorderStatus_06', '归档', '35e8ed75-58fb-4aea-8997-fda8995acf2e', '6');
INSERT INTO `SYS_DICTIONARY` VALUES ('6e9333b9-f028-4b47-878c-ecdf0ae8dbc0', 'isExecuteEnd', '是否执行结束', '#', 'isExecuteEnd');
INSERT INTO `SYS_DICTIONARY` VALUES ('374729ce-4eff-40d5-94e9-11152e8929e8', 'isExecuteEnd_01', '是', '6e9333b9-f028-4b47-878c-ecdf0ae8dbc0', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('2227fe7c-87d2-4edf-a114-bcaf3cd157f3', 'isExecuteEnd_02', '否', '6e9333b9-f028-4b47-878c-ecdf0ae8dbc0', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('c2f4a1fa-d888-4fa5-be39-af3e429eeb2e', 'RSA', 'RSA', '35e7afe7-e8bd-4538-9b01-9f44913a90fc', 'RSA');
INSERT INTO `SYS_DICTIONARY` VALUES ('9e8b18a1-958e-441e-9ff2-a684a0e3e06f', 'RSA2', 'RSA2(推荐)', '35e7afe7-e8bd-4538-9b01-9f44913a90fc', 'RSA2');
INSERT INTO `SYS_DICTIONARY` VALUES ('542bb7cf-d7bd-46ef-a323-925893c214b6', 'customerTansfer', '客户调账审批', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('49ddac3f-df23-4b05-a1a3-bbb8b8587a33', 'penaltyRelief', '滞纳金减免审批', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('d3601020-8d11-49e4-942c-ad8183e8e91a', 'GBK', 'GBK', '36c66d33-e843-4e6a-8095-222904b8bd84', 'GBK');
INSERT INTO `SYS_DICTIONARY` VALUES ('36c66d33-e843-4e6a-8095-222904b8bd84', 'aliPayCharset', '支付宝编码', '#', 'aliPayCharset');
INSERT INTO `SYS_DICTIONARY` VALUES ('9f96e918-ef05-4c08-bb68-58ef8b7009b2', 'UTF-8', 'UTF-8', '36c66d33-e843-4e6a-8095-222904b8bd84', 'UTF-8');
INSERT INTO `SYS_DICTIONARY` VALUES ('6c6f67f2-f8d1-43fb-9052-aef94bb92bdb', 'financeTransferAgentUnit', '代收单位', '#', 'financeTransferAgentUnit');
INSERT INTO `SYS_DICTIONARY` VALUES ('654cc28f-cf38-4965-8a79-b250e938e3cd', 'agentUit_one', '代收单位一', '6c6f67f2-f8d1-43fb-9052-aef94bb92bdb', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('5f7cdd14-6ce5-49a8-9b0c-cb05f51a513c', 'agentUit_two', '代收单位二', '6c6f67f2-f8d1-43fb-9052-aef94bb92bdb', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('554bdbd1-dcd6-4fdd-9f51-e6f8962498d2', 'MWEB', 'MWEB', 'ebdd8f00-61c5-4fc2-8754-0e40c23bddd3', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('435358d8-3e4a-4383-a791-383fc10042d6', 'workOrderDispose', '工单处理', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('6b42e520-10cf-49fd-b706-dd91ca79868c', 'approvalExamine', '用气性质变更申请审批', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('e6258556-4038-483c-81a4-97f7d53c20e7', 'maintenanceRemissionApply', '费用减免审批', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '6');
INSERT INTO `SYS_DICTIONARY` VALUES ('f8a94eb8-007d-423d-be9b-dfd42095870f', 'transfer_out', '转出', '1d4ca2d6-b219-4cfd-b806-9ca8233419a7', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('b7670850-5a86-457c-ba73-ff0b053ca6c7', 'deratePenaltyDayType', '免滞纳金天数方式', '#', 'deratePenaltyDayType');
INSERT INTO `SYS_DICTIONARY` VALUES ('12681cf3-1815-4160-92c1-5fd872cad2bf', 'deratePenaltyDayType_01', '抄表审核日', 'b7670850-5a86-457c-ba73-ff0b053ca6c7', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('62c50cd7-db1a-4f88-bf04-80c95c98cbf2', 'deratePenaltyDayType_02', '下月一日', 'b7670850-5a86-457c-ba73-ff0b053ca6c7', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('8c141914-3488-4d69-af5a-e244f4819719', 'statementType', '结算方式', '#', 'statementType');
INSERT INTO `SYS_DICTIONARY` VALUES ('f44a8264-c817-4500-b2fa-61d806897238', 'paying', '支付中', '4ec4ad53-f2fd-4760-becf-296ba0900848', '6');
INSERT INTO `SYS_DICTIONARY` VALUES ('cb780306-9a6b-4384-b76f-a667e0cfbe88', 'subsidyType', '补贴方式', '#', 'subsidyType');
INSERT INTO `SYS_DICTIONARY` VALUES ('68f80d9b-7a04-4137-b90f-ccf1f40e5a09', 'subsidyType_01', '气量', 'cb780306-9a6b-4384-b76f-a667e0cfbe88', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('e055534e-1f9f-49bb-9534-ab45fa23331a', 'subsidyType_02', '金额', 'cb780306-9a6b-4384-b76f-a667e0cfbe88', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('82efdf60-e63e-4aa5-acc6-c940fd4e50ea', 'dangeState', '安检状态', 'e780ceb3-5299-4dec-8c52-2ba4d97bd85c', 'dangeState');
INSERT INTO `SYS_DICTIONARY` VALUES ('c0987a6f-7b67-436d-bea6-e1a6d7c5f33b', 'inventoryStatus', '库存状态', '#', 'inventoryStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('8f88178c-1871-438a-bfbb-46b4a0603630', 'inventoryStatus-00', '在库', 'c0987a6f-7b67-436d-bea6-e1a6d7c5f33b', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('bec40ab1-dd19-40c4-93cf-4c825748159e', 'inventoryStatus-02', '报装', 'c0987a6f-7b67-436d-bea6-e1a6d7c5f33b', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('b1184e2c-fcad-4546-94f9-b782296f6f1a', 'promptWay_01', '人工催费', '207c71e2-d52c-4b06-9718-f3a0d12a3dc3', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('4adfe8e8-b088-494d-902a-654ad6a59cd8', 'orderStatus', '订单状态', '#', 'orderStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('ef819223-3f4e-4cb7-942e-57ee7ee32c0a', 'orderStatus_1', '未付款', '4adfe8e8-b088-494d-902a-654ad6a59cd8', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('45c4add8-2fb9-46df-96e9-1367a59aeb80', 'orderStatus_2', '已付款', '4adfe8e8-b088-494d-902a-654ad6a59cd8', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('75d19ab2-ee97-4e0a-978e-6dea1a80cf3e', 'orderStatus_3', '待发货', '4adfe8e8-b088-494d-902a-654ad6a59cd8', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('e63c2c2c-6221-4854-9481-13b8fec7041f', 'payAccountAppType', '支付账号应用类型', '#', 'payAccountAppType');
INSERT INTO `SYS_DICTIONARY` VALUES ('6fe04fcf-3372-4abd-9311-90d3c37e9796', 'CIS', 'CIS', 'e63c2c2c-6221-4854-9481-13b8fec7041f', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('2a10008b-87f7-4494-a8d6-e73fadbdacb1', 'gasCustomerApp', '燃气宝', 'e63c2c2c-6221-4854-9481-13b8fec7041f', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('9c08f8b0-54d5-4cc5-9f6c-b347ccc8810b', 'gasBusinessApp', '燃气助', 'e63c2c2c-6221-4854-9481-13b8fec7041f', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('92ae28c4-1e03-49f5-95fe-fbf1f1a2b42b', 'actReFlow', '流程处理', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '7');
INSERT INTO `SYS_DICTIONARY` VALUES ('da6670d1-c573-48aa-a059-ce408f5d50df', 'applicationType', '应用类型', '#', 'applicationType');
INSERT INTO `SYS_DICTIONARY` VALUES ('debeaf95-e44a-48d5-b679-19e55dc95386', 'applicationType_1', '客户APP', 'da6670d1-c573-48aa-a059-ce408f5d50df', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('076e2aa0-470a-4a00-ab13-5cc272a85e45', 'applicationType_2', '业务APP', 'da6670d1-c573-48aa-a059-ce408f5d50df', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('59d87389-dc80-4c31-9c9c-3d64807a9adf', 'orgType_03', '部门', 'f5cf5d77-9de6-426c-b989-50106b7a6506', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('596486c5-2ec6-4f0d-a39b-8ced142f7ca8', 'application-4', '终端系统', 'b0fa5ce4-8d8e-4438-b8be-43ae8317ded3', 'terminal');
INSERT INTO `SYS_DICTIONARY` VALUES ('55585c67-259c-4bee-b0be-50b9b2058fff', 'refunToPreDeposit', '退费转预存', '563a1127-473b-4442-a26d-48af2fa29835', '12');
INSERT INTO `SYS_DICTIONARY` VALUES ('86601510-e1fd-4566-96e4-0f5969a61ef2', 'orderStatus_4', '已出库', '4adfe8e8-b088-494d-902a-654ad6a59cd8', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('d154ecf1-99a3-48c4-814a-de59bc4b9c3d', 'orderStatus_5', '缺货', '4adfe8e8-b088-494d-902a-654ad6a59cd8', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('e91e5b47-7469-494f-be83-3bf51b203449', 'orderStatus_6', '退款', '4adfe8e8-b088-494d-902a-654ad6a59cd8', '6');
INSERT INTO `SYS_DICTIONARY` VALUES ('edc1e762-ba75-4712-8197-4034f6a44835', 'orderStatus_7', '已完成', '4adfe8e8-b088-494d-902a-654ad6a59cd8', '7');
INSERT INTO `SYS_DICTIONARY` VALUES ('277cbb31-270a-447c-aef5-a2159ebaf78d', 'processSmsNotice', '流程短信通知', '#', 'processSmsNotice');
INSERT INTO `SYS_DICTIONARY` VALUES ('49aef036-f125-49d3-a24f-51fe2a53c752', 'processSmsNotice_0', '是', '277cbb31-270a-447c-aef5-a2159ebaf78d', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('1d458b80-d71e-42f3-8c32-1d974f6415ce', 'processSmsNotice_1', '否', '277cbb31-270a-447c-aef5-a2159ebaf78d', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('7b77f6ce-1e65-41f3-8239-aaaf10ea852e', 'stepSendStatu', '阶梯方案发送状态', '#', 'stepSendStatu');
INSERT INTO `SYS_DICTIONARY` VALUES ('62aed3a5-a3a8-473b-adb1-49a4b33383d7', 'noSend', '未发送', '7b77f6ce-1e65-41f3-8239-aaaf10ea852e', '-1');
INSERT INTO `SYS_DICTIONARY` VALUES ('8d243e7e-e4f6-472d-abe5-75534fa958ab', 'sending', '发送中', '7b77f6ce-1e65-41f3-8239-aaaf10ea852e', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('f200a154-dcec-4cc5-bc47-e6560419f27c', 'success', '发送成功', '7b77f6ce-1e65-41f3-8239-aaaf10ea852e', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('930b57db-ede9-4dec-b20e-b66dca3f6b43', 'fail', '发送失败', '7b77f6ce-1e65-41f3-8239-aaaf10ea852e', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('16611e9d-477c-4a91-be10-5470873cc547', 'payFail', '支付失败', '4ec4ad53-f2fd-4760-becf-296ba0900848', '7');
INSERT INTO `SYS_DICTIONARY` VALUES ('d2be77cb-5dbe-49bb-a0e3-61f1dfc6bbe3', 'statementType_01', '系统结算', '8c141914-3488-4d69-af5a-e244f4819719', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('c834c9d2-aff8-4ea6-a355-c7c1ad0ed330', 'statementType_02', '表端结算', '8c141914-3488-4d69-af5a-e244f4819719', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('d97c1e28-8d01-4e1c-b4af-4f7f8f121ead', 'dangeState2', '安检状态', '#', 'dangeState2');
INSERT INTO `SYS_DICTIONARY` VALUES ('50cd5141-0f0a-4a20-8576-a60d8d6bfa73', 'dangeState_01', '未处理', 'd97c1e28-8d01-4e1c-b4af-4f7f8f121ead', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('176a7bf7-a9fb-4ed1-97d7-16ba207bdd36', 'dangeState_02', '已处理', 'd97c1e28-8d01-4e1c-b4af-4f7f8f121ead', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('93260568-9bc5-440d-b64e-2997b4e4148e', 'transferAccountExamine', '过户申请审批', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '8');
INSERT INTO `SYS_DICTIONARY` VALUES ('1172a515-05aa-47b8-8c0d-173c3fbe823a', 'orgType_05', '营业厅', 'f5cf5d77-9de6-426c-b989-50106b7a6506', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('f413891a-91b1-4b40-b198-f4dc952fdfe3', 'remoteMeterWavleState', '远传表阀门状态', '#', 'remoteMeterWavleState');
INSERT INTO `SYS_DICTIONARY` VALUES ('db8af594-41d5-48ca-9bdc-8d01c09315ea', 'close', '普通关阀', 'f413891a-91b1-4b40-b198-f4dc952fdfe3', '01');
INSERT INTO `SYS_DICTIONARY` VALUES ('97ba34f3-28ab-4a59-bb3c-3c1470c3358a', 'remoteMeterType_02', '流量计', '126062a7-82ef-411b-a583-c5ca11960a35', 'FlowMeter');
INSERT INTO `SYS_DICTIONARY` VALUES ('aa7f70eb-18d1-4adb-8d62-5a84f7a33df0', 'dataPermission', '数据权限', '#', 'dataPermission');
INSERT INTO `SYS_DICTIONARY` VALUES ('b9253f23-bb6c-48ce-920c-5fb6a1048303', 'dataPermission_01', '公司', 'aa7f70eb-18d1-4adb-8d62-5a84f7a33df0', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('47779f16-ad1d-4a40-bc82-2f22c36fee8e', 'dataPermission_02', '分公司', 'aa7f70eb-18d1-4adb-8d62-5a84f7a33df0', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('036bfccb-e15d-47d7-a714-583b26a11dda', 'dataPermission_03', '营业厅', 'aa7f70eb-18d1-4adb-8d62-5a84f7a33df0', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('832e565a-2w83-4e45-bc2a-23840ert6dgh', 'dataMigration', '7.0迁移数据', '4ec4ad53-f2fd-4760-becf-296ba0900848', '14');
INSERT INTO `SYS_DICTIONARY` VALUES ('e4aacc5a-4dd1-4690-82d7-26802e757a50', 'valuationObj', '计价对象', '#', 'valuationObj');
INSERT INTO `SYS_DICTIONARY` VALUES ('2c5d8537-474a-4c52-ae83-44f581e64cb0', 'valuationObj_01', '表具', 'e4aacc5a-4dd1-4690-82d7-26802e757a50', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('fea5e270-382f-45a7-a882-ddfea95b6aa6', 'valuationObj_02', '家庭', 'e4aacc5a-4dd1-4690-82d7-26802e757a50', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('16e7ac41-9a3b-4a55-8c20-c1c6e5244616', 'force_close', '强制关阀', 'f413891a-91b1-4b40-b198-f4dc952fdfe3', '00');
INSERT INTO `SYS_DICTIONARY` VALUES ('7257c015-4c75-4bfb-8d4c-93455490ee4f', 'open', '开阀', 'f413891a-91b1-4b40-b198-f4dc952fdfe3', '10');
INSERT INTO `SYS_DICTIONARY` VALUES ('88967f32-df4c-4e77-96d7-a205fd694817', 'payed', '已缴费', 'ab00ddc4-7e5b-4677-ba4a-2947adfcc6e7', '7');
INSERT INTO `SYS_DICTIONARY` VALUES ('s54a8264-cd47-4dv0-442a-61d806df7238', 'payCancel', '支付取消', '4ec4ad53-f2fd-4760-becf-296ba0900848', '15');
INSERT INTO `SYS_DICTIONARY` VALUES ('95c7b51f-21cd-4c63-92df-0c4db9d8d7ea', 'remoteMeterAutoAudit', '审核方法', '#', 'remoteMeterAutoAudit');
INSERT INTO `SYS_DICTIONARY` VALUES ('4ea99143-99e9-4a24-8649-82eaf0bcb68e', 'remoteMeterAutoAudit_01', '抄表不审核', '95c7b51f-21cd-4c63-92df-0c4db9d8d7ea', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('2bba804b-8cfd-4a0f-8260-c0125dd00fe7', 'remoteMeterAutoAudit_02', '抄表立即审核', '95c7b51f-21cd-4c63-92df-0c4db9d8d7ea', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('e780ceb3-5299-4d3gc-4c32-2bagb97bd85c', 'chargeTransferStatus', '收费交接状态', '#', 'chargeTransferStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('e780ceb3-5ee9-4d3gc-4352-2hggb97brt5c', 'normal', '已交接', 'e780ceb3-5299-4d3gc-4c32-2bagb97bd85c', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('e780ceb3-52gc-4ergc-4352-2hggb97brt5c', 'cancel', '反交接', 'e780ceb3-5299-4d3gc-4c32-2bagb97bd85c', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('e780ceb3-52gc-4ermn-43ml2-2hggb97brt5c', 'checking', '审核中', 'e780ceb3-5299-4d3gc-4c32-2bagb97bd85c', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('e780ceb3-5r4c-4bnmn-43ml2-2kugb97brt5c', 'fail', '审核不通过', 'e780ceb3-5299-4d3gc-4c32-2bagb97bd85c', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('cbc4wesf-4b82-3efg-932e-e6e34n2f235d', 'icGasCorrectToDeposit', 'ic卡充失败转预存', '4ec4ad53-f2fd-4760-becf-296ba0900848', '12');
INSERT INTO `SYS_DICTIONARY` VALUES ('wes4wesf-4b67-d7fg-9e2e-e6e34n2nm85', 'refundToDeposit', '退费转预存', '4ec4ad53-f2fd-4760-becf-296ba0900848', '13');
INSERT INTO `SYS_DICTIONARY` VALUES ('f14296f6-bbc4-4c69-bdfd-850c9d069fa2', 'auditDateMeterDate', '计费方案确定时间', '#', 'auditDateMeterDate');
INSERT INTO `SYS_DICTIONARY` VALUES ('7be8a677-f1e6-43ed-a038-ebee98505ea3', 'auditDateMeterDate_01', '抄表时间', 'f14296f6-bbc4-4c69-bdfd-850c9d069fa2', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('da67c922-03e0-4b53-828c-ca426adaa097', 'auditDateMeterDate_02', '审核时间', 'f14296f6-bbc4-4c69-bdfd-850c9d069fa2', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('add0fe2d-f832-49b4-9333-5e464a29c8b2', 'icPayFailToPreDeposit', 'ic卡充失败转预存', '4e4gad53-f5dd-4760-b4cf-296ba0900838', '9');
INSERT INTO `SYS_DICTIONARY` VALUES ('126062a7-82ef-411b-a583-c5ca11960a35', 'remoteMeterType', '气表类别', '#', 'remoteMeterType');
INSERT INTO `SYS_DICTIONARY` VALUES ('fba92f40-3595-4360-87c0-ca2e6b750639', 'remoteMeterType_01', '燃气表', '126062a7-82ef-411b-a583-c5ca11960a35', 'GasMeter');
INSERT INTO `SYS_DICTIONARY` VALUES ('1ca790db-321a-4260-9f15-718a5ee9a8fc', 'inventoryStatus-03', '在用', 'c0987a6f-7b67-436d-bea6-e1a6d7c5f33b', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('7b5b032e-acc5-4b79-a464-bf646a66b9cd', 'inventoryStatus-04', '维修', 'c0987a6f-7b67-436d-bea6-e1a6d7c5f33b', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('31e6aa40-73da-489a-8db0-bcd216a7c1e9', 'inventoryStatus-05', '报废', 'c0987a6f-7b67-436d-bea6-e1a6d7c5f33b', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('a69fa6ad-1aa7-4125-bd2d-5991807001e8', 'dangeState_03', '已关闭', 'd97c1e28-8d01-4e1c-b4af-4f7f8f121ead', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('5bbdd986-6869-403a-8ac9-87f4eab1724d', 'financeNotesStatus', '票据状态', '#', 'financeNotesStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('79dcb91c-c060-4471-b22b-c93415092b13', 'employeeUse', '领用', '5bbdd986-6869-403a-8ac9-87f4eab1724d', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('2a937fd1-ef89-4233-91f8-7e03f52132d2', 'customerUse', '使用', '5bbdd986-6869-403a-8ac9-87f4eab1724d', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('25d55d67-e7b9-4e8b-b4a8-b6ff0a94f8d8', 'employeeAbort', '作废', '5bbdd986-6869-403a-8ac9-87f4eab1724d', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('fd675b14-a934-4cde-a5de-63afa78d721b', 'ClosingAccountExamine', '销户申请审批', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '9');
INSERT INTO `SYS_DICTIONARY` VALUES ('4db13c14-3cf9-45f4-a994-8700e15b4996', 'transferRefund', '调账退费', '4ec4ad53-f2fd-4760-becf-296ba0900848', '10');
INSERT INTO `SYS_DICTIONARY` VALUES ('9ca817c7-2d46-4233-baab-1d4f2c9b3238', 'prePaying', '充值中', '4ec4ad53-f2fd-4760-becf-296ba0900848', '8');
INSERT INTO `SYS_DICTIONARY` VALUES ('add0fe2d-f833-49b4-9133-5e064a29c8b1', 'prePayFailToPreDeposit', '远传表充失败转预存', '4ec4ad53-f2fd-4760-becf-296ba0900848', '9');
INSERT INTO `SYS_DICTIONARY` VALUES ('cbc40dc1-4b82-49c7-932e-e6ed292f235d', 'transferCounter', '调账收费', '4ec4ad53-f2fd-4760-becf-296ba0900848', '11');
INSERT INTO `SYS_DICTIONARY` VALUES ('bed18984-3b51-4cc0-9288-c82a0d671e75', 'imgType', '图片类型', '#', 'imgType');
INSERT INTO `SYS_DICTIONARY` VALUES ('eb290a34-9507-468f-8542-0aedc5cbc115', 'handlingStatus_01', '未处理', '21bddd35-33bd-4f66-a04e-0b7ed17b3230', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('50156f0f-12c4-40a9-89d0-f6f6c5084658', 'imgType_01', 'APP首页轮播', 'bed18984-3b51-4cc0-9288-c82a0d671e75', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('4e5f47ad-74ff-4c33-ab59-0de63bd13ffc', 'handlingStatus_03', '已处理', '21bddd35-33bd-4f66-a04e-0b7ed17b3230', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('c1cd9b51-c328-42bb-b5fe-cbcde047dad4', 'orgType_04', '管理区域', 'f5cf5d77-9de6-426c-b989-50106b7a6506', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('977469af-db93-4354-8c8e-6ed8bdbea72a', 'resultState', '安检结果', '#', 'resultState');
INSERT INTO `SYS_DICTIONARY` VALUES ('d6fdd4e5-d295-48f4-b13c-f306782d264b', 'financeTicketUseStatus', '票本领用状态', '#', 'financeTicketUseStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('f7f5b115-490a-4599-9d29-3a5fd211b7bc', 'use_in', '入库', 'd6fdd4e5-d295-48f4-b13c-f306782d264b', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('e94ad350-53cf-406a-b427-64c72eb66d60', 'use_use', '领用', 'd6fdd4e5-d295-48f4-b13c-f306782d264b', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('44ce3078-4ed1-4568-b8be-cb0b152f66ca', 'use_takeBack', '返还', 'd6fdd4e5-d295-48f4-b13c-f306782d264b', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('98e57c65-ba3a-41f3-aefe-138a909cf8ef', 'addGas', '追加气量审批', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '10');
INSERT INTO `SYS_DICTIONARY` VALUES ('098a40b2-87ee-4c29-a1dc-bf824fdc023f', 'refundRecord', '退费申请', '563a1127-473b-4442-a26d-48af2fa29835', '11');
INSERT INTO `SYS_DICTIONARY` VALUES ('fe297466-6772-439f-91f7-80ed074779f0', 'application-2', '业务app', 'b0fa5ce4-8d8e-4438-b8be-43ae8317ded3', 'bapp');
INSERT INTO `SYS_DICTIONARY` VALUES ('7dc99b05-b632-4460-aa0a-34c46855adf5', 'openGas_02', '是', '3ca99eea-ed09-4fc2-8fad-9f877b76384e', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('3ca99eea-ed09-4fc2-8fad-9f877b76384e', 'openGas', '通气状态', '#', 'openGas');
INSERT INTO `SYS_DICTIONARY` VALUES ('4261b636-1d43-4bd3-bfef-105fdf33310b', 'openGas_01', '否', '3ca99eea-ed09-4fc2-8fad-9f877b76384e', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('0f70894d-e2bf-493f-a0ef-6778c8f0fc09', 'openGas_03', '通气中', '3ca99eea-ed09-4fc2-8fad-9f877b76384e', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('a1246152-d01d-46ae-bbe7-8184ea3fbb25', 'on', '开', '15409478-11fb-4f87-85e1-2caaa1491b23', '10');
INSERT INTO `SYS_DICTIONARY` VALUES ('543d5428-3be7-47e3-a966-0ae7f916bf0b', 'off', '关', '15409478-11fb-4f87-85e1-2caaa1491b23', '00');
INSERT INTO `SYS_DICTIONARY` VALUES ('15409478-11fb-4f87-85e1-2caaa1491b23', 'remoteMeterSwitch', '远传表开关', '#', 'remoteMeterSwitch');
INSERT INTO `SYS_DICTIONARY` VALUES ('3f959ef7-e9df-49ba-b9cb-c9fb403b3d8d', 'remoteMeterFlowMode', '远传表流量模式', '#', 'remoteMeterFlowMode');
INSERT INTO `SYS_DICTIONARY` VALUES ('7964f925-fb71-4127-a84f-19d002a4b914', 'auto', '自动检测模式', '3f959ef7-e9df-49ba-b9cb-c9fb403b3d8d', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('4af184c1-f4fc-48d7-a28c-036dd1626988', 'stable', '固定模式', '3f959ef7-e9df-49ba-b9cb-c9fb403b3d8d', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('9aba887b-7033-4f67-b217-b05033a558cc', 'application-5', '商城', 'b0fa5ce4-8d8e-4438-b8be-43ae8317ded3', 'store');
INSERT INTO `SYS_DICTIONARY` VALUES ('5f7d224c-1d81-4129-b2e3-286a8307deb6', 'airInletDirection', '进气方向', '#', 'airInletDirection');
INSERT INTO `SYS_DICTIONARY` VALUES ('a81dff33-8a42-4ce3-85ee-b4820f2484f1', 'orgType_06', '第三方机构', 'f5cf5d77-9de6-426c-b989-50106b7a6506', '6');
INSERT INTO `SYS_DICTIONARY` VALUES ('207c71e2-d52c-4b06-9718-f3a0d12a3dc3', 'promptWay', '催费方式', '#', 'promptWay');
INSERT INTO `SYS_DICTIONARY` VALUES ('136adfcc-8663-4df8-a07e-4734a522a2db', 'heatingPlan_01', '非采暖计划', '5617f025-93d8-42e3-8148-c9f7e706dc1f', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('edc119be-a170-4201-86eb-be76647656b2', 'heatingPlan_02', '采暖计划', '5617f025-93d8-42e3-8148-c9f7e706dc1f', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('b0fa5ce4-8d8e-4438-b8be-43ae8317ded3', 'attachmentApplication', '附件用途', '#', 'attachmentApplication');
INSERT INTO `SYS_DICTIONARY` VALUES ('a719ed67-27f1-44e3-a237-984086f5f74a', '3', '作废', 'd6fdd4e5-d295-48f4-b13c-f306782d264b', 'abort');
INSERT INTO `SYS_DICTIONARY` VALUES ('16cd5b16-c315-4f68-b37a-a0818bb8d8da', 'inventoryStatus-06', '停用', 'c0987a6f-7b67-436d-bea6-e1a6d7c5f33b', '6');
INSERT INTO `SYS_DICTIONARY` VALUES ('41f96361-fe14-4654-a8cf-12321e347830', 'adjustGas', '调整气量审批', 'c897b01f-dcee-4c1f-86be-539f3d79d532', '11');
INSERT INTO `SYS_DICTIONARY` VALUES ('f22543a4-61b1-49ce-9ac4-3b77955a411f', 'L', '左', '5f7d224c-1d81-4129-b2e3-286a8307deb6', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('0b8672e7-c26f-4808-9a2b-af42d9af4bfc', 'R', '右', '5f7d224c-1d81-4129-b2e3-286a8307deb6', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('42c4581c-9d3f-48e0-ab39-0c0208337736', 'promptWay_02', '短信催费', '207c71e2-d52c-4b06-9718-f3a0d12a3dc3', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('1b8d8992-6cff-485f-8c99-4ed9afb1b128', 'abort', '作废', 'd5c568d1-1de2-4d95-ab03-cea0145f7080', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('bfbe57a1-20f4-47ad-8c93-ebb90a2eb589', 'create_customer_status', '新建客户状态', '#', 'create_customer_status');
INSERT INTO `SYS_DICTIONARY` VALUES ('dde6747a-7c85-49e5-9ab0-98a767f0ae05', 'create_customer_status_1', '有效客户', 'bfbe57a1-20f4-47ad-8c93-ebb90a2eb589', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('2088cc36-d5e1-417f-8154-b4b7dbeba634', 'create_customer_status_3', '潜在客户', 'bfbe57a1-20f4-47ad-8c93-ebb90a2eb589', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('41a47f19-e7fb-4808-9195-1c3e17be63fd', 'application-1', 'cis系统', 'b0fa5ce4-8d8e-4438-b8be-43ae8317ded3', 'cis');
INSERT INTO `SYS_DICTIONARY` VALUES ('5984d5d1-2806-4f8a-a409-257d2f2c0eec', 'application-3', '客户app', 'b0fa5ce4-8d8e-4438-b8be-43ae8317ded3', 'uapp');
INSERT INTO `SYS_DICTIONARY` VALUES ('19e81027-33cd-44f6-b593-9fd4524e6266', 'APP', 'APP', 'ebdd8f00-61c5-4fc2-8754-0e40c23bddd3', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('fcd731a5-3f94-4a82-8d8d-2bc4b42faeac', 'JSAPI', 'JSAPI', 'ebdd8f00-61c5-4fc2-8754-0e40c23bddd3', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('953aea8c-d905-4636-82cf-e0b6fb20eb88', 'appVersionUpdateSign_1', '可选更新', 'a3531410-efa3-4a3d-a046-d03038ec4cba', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('d9ccc90d-d8a6-4fa1-8cbc-b0a67711b500', 'appVersionUpdateSign_2', '强制更新', 'a3531410-efa3-4a3d-a046-d03038ec4cba', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('f843af6f-0108-416c-b94c-9d1401dbf4d7', 'workorderType_05', '拆表', '93602e82-b5ea-4310-9fff-2d833dbf12c5', '5');
INSERT INTO `SYS_DICTIONARY` VALUES ('91cd705b-d997-4655-beab-c75df8378bf6', 'workorderType_06', '换表', '93602e82-b5ea-4310-9fff-2d833dbf12c5', '6');
INSERT INTO `SYS_DICTIONARY` VALUES ('35e7afe7-e8bd-4538-9b01-9f44913a90fc', 'aliPaySignType', '支付宝加密方式', '#', 'aliPaySignType');
INSERT INTO `SYS_DICTIONARY` VALUES ('3c0d9306-db43-47be-bfe4-4513cd88790d', 'handlingStatus_02', '处理中', '21bddd35-33bd-4f66-a04e-0b7ed17b3230', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('d25c421c-53f8-49e1-be11-e5222e94bd8e', 'ticket', '发票', 'e5b253fd-dd66-4ad3-b63b-c3afbd1228ff', 'ticket');
INSERT INTO `SYS_DICTIONARY` VALUES ('6f59c759-1af5-489b-944f-e41d8a95877c', 'ticket_print', '纸质发票', 'a3b68bf7-92c3-4ffa-a8fc-072cea29ead5', '3');
INSERT INTO `SYS_DICTIONARY` VALUES ('3f1a7ca8-5fcd-4046-ae02-7410b3db592c', 'once', '一次性', '02e98523-5f23-4061-b56e-6b08f3c5499d', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('7b304bc4-eb1f-4168-b18b-52e69c266b83', 'workorderType_04', '挂表', '93602e82-b5ea-4310-9fff-2d833dbf12c5', '4');
INSERT INTO `SYS_DICTIONARY` VALUES ('bbed87e4-fb88-47b3-a08c-60a991adb56a', 'timeout', '是否超时', '#', 'timeout');
INSERT INTO `SYS_DICTIONARY` VALUES ('ff9acd88-6d99-46cd-ab57-f005037f4d33', 'timeout_01', '已超时', 'bbed87e4-fb88-47b3-a08c-60a991adb56a', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('f852599e-b45a-4cd3-b5a0-f43b14cf06ff', 'timeout_02', '未超时', 'bbed87e4-fb88-47b3-a08c-60a991adb56a', '2');
INSERT INTO `SYS_DICTIONARY` VALUES ('833d5812-f9c7-4aeb-86d9-c069dcd69a3d', 'workorderType_07', '通气', '93602e82-b5ea-4310-9fff-2d833dbf12c5', '7');
INSERT INTO `SYS_DICTIONARY` VALUES ('21bddd35-33bd-4f66-a04e-0b7ed17b3230', 'handlingStatus', '处理状态', '#', 'handlingStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('4e85fa9e-40d6-4cb5-b1f3-ca9b412b3972', 'appManagerNoticeStatus', '通知状态', '#', 'appManagerNoticeStatus');
INSERT INTO `SYS_DICTIONARY` VALUES ('b170cf97-8f8b-409a-a7d8-f0100df3d53d', 'appManagerNoticeStatus_N', '未发布', '4e85fa9e-40d6-4cb5-b1f3-ca9b412b3972', 'N');
INSERT INTO `SYS_DICTIONARY` VALUES ('577647f0-a4ee-4a5b-acf1-725210a1a349', 'pricingManner', '计价方式', '#', 'pricingManner');
INSERT INTO `SYS_DICTIONARY` VALUES ('4054c355-319e-4ac4-918d-c32118359054', 'appManagerNoticeStatus_0', '停播', '4e85fa9e-40d6-4cb5-b1f3-ca9b412b3972', '0');
INSERT INTO `SYS_DICTIONARY` VALUES ('7eb95df0-71fd-49f3-88fe-2a1422ef2953', 'appManagerNoticeStatus_1', '开播', '4e85fa9e-40d6-4cb5-b1f3-ca9b412b3972', '1');
INSERT INTO `SYS_DICTIONARY` VALUES ('b74be31e-3b9e-40e6-b7b8-8578df9ba5ef', 'tollRefundType', '退费方式', '#', 'tollRefundType');
INSERT INTO `SYS_DICTIONARY` VALUES ('6e77bb4d-624a-4697-ba99-c8da66c1eab4', 'tollRefundType_2', '转账', 'b74be31e-3b9e-40e6-b7b8-8578df9ba5ef', '2');

-- ----------------------------
-- Table structure for SYS_EMPLOYEE
-- ----------------------------
DROP TABLE IF EXISTS `SYS_EMPLOYEE`;
CREATE TABLE `SYS_EMPLOYEE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `GENDER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `MOBILE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `WECHAT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `INSIDE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SYS_ORG_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SYS_POSITION_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_EMPLOYEE
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_IMG
-- ----------------------------
DROP TABLE IF EXISTS `SYS_IMG`;
CREATE TABLE `SYS_IMG`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `URL` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_IMG
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_LOG
-- ----------------------------
DROP TABLE IF EXISTS `SYS_LOG`;
CREATE TABLE `SYS_LOG`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建者',
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `REMOTE_ADDR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip地址',
  `USER_AGENT` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户代理',
  `REQUEST_URI` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求URI',
  `METHOD` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作方式',
  `PARAMS` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求参数',
  `EXCEPTION` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常信息',
  `TYPE` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志类型',
  `LOGIN_TIME` datetime(0) NULL DEFAULT NULL,
  `LAST_SIGN_TIME` datetime(0) NULL DEFAULT NULL,
  `CONTENT_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CONTENT` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_LOG
-- ----------------------------
INSERT INTO `SYS_LOG` VALUES ('129213e4-3b85-40e5-8466-2eca4c6226b1', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '192.168.2.23', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:45:17', '2019-05-22 09:49:18', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('054cc523-db3e-45dd-95d5-165ca31ba6f4', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-06-03 09:41:03', '2019-06-03 09:41:16', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('0c827eeb-9608-4d85-a445-9bcd24d5d287', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.33.102', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-06-04 09:05:23', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('4542351a-dee9-46bd-a181-894e7f26e625', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.33.102', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-06-04 09:08:44', '2019-06-04 09:13:21', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('b2615b7e-5a10-429b-a2a3-eae36d476162', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.207.177', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-06 16:45:37', '2019-08-06 16:46:51', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('ae5b1c12-8f7f-4370-9bb5-e5bc380de9b6', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0', '/qciot_cis_war_exploded/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-03 16:32:03', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('e823a4b0-c36e-4a32-a1b2-265c50dd4339', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0', '/qciot_cis_war_exploded/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-03 16:33:16', '2019-09-03 16:34:01', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('06f97f69-bd4b-4725-9388-8d7c7db7aea5', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.34.19', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-05 09:29:47', '2019-09-05 09:30:09', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('76d3d125-21ca-42d3-8084-98a7b0d097b7', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.34.19', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.100 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-05 10:00:46', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('d097164b-9d2e-4a87-8e0b-c6395ce8d540', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-12 16:44:35', '2019-09-12 16:45:41', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('2e224fbf-c563-4381-bd6a-e9813a7871c0', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.35.225', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-18 15:38:46', '2019-09-18 15:40:59', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('4f98c131-9160-46a8-8e4c-740809b06b19', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.35.225', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-18 15:41:29', '2019-09-18 15:41:52', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('1bacf4f1-4bdd-4a22-89fc-2abef3eba3c4', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.35.225', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-19 16:51:32', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('56172059-09b1-4a5a-a4e7-f83907f42948', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.32.140', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:30:15', '2019-05-22 09:30:27', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('0106aed2-af09-4a47-aa13-c17efd4e39c5', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.32.140', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:36:29', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('3c138d25-10f4-4fd1-a0b7-d10b7b3256ba', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.32.140', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:39:36', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('f59b83f5-e74d-4ad2-959e-7dca96966212', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.32.140', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:39:41', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('8c90e7e3-0d3c-455c-95e4-1febcc49a827', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.32.140', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:40:22', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('361be1ff-5ff3-4220-b70e-38203d21cbd3', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.32.140', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:41:43', '2019-05-22 09:42:16', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('ef2a42d3-7052-4934-9358-5da11061d8e4', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.33.102', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-06-04 09:46:27', '2019-06-04 09:47:34', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('064b0b96-86b8-42ab-b228-bf695054e3a3', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-11 10:13:53', '2019-09-11 10:17:01', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('274066a7-aa30-41a1-b24d-31ff90b8002c', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-11 11:05:56', '2019-09-11 11:06:44', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('8f2f027d-6207-47c7-abfe-8c73245e8f94', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-12 17:31:04', '2019-09-12 17:31:26', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('a08de276-385e-4d78-ae13-c7d4b64bbced', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.35.225', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-18 11:30:15', '2019-09-18 11:32:08', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('acbf4391-fa7d-4c5b-adb0-4816ad07e7da', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.35.225', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-19 12:02:58', '2019-09-19 12:37:17', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('bddd605c-9224-4f6d-a6c9-53ca04d781bc', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.204.47', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-26 17:51:10', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('06f10b92-5822-492a-a9bc-887bfbd8c05f', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.32.140', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:20:18', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('ea03d2c8-4ca6-4315-95e4-d97381331142', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.52.43', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-07-23 13:18:54', '2019-07-23 14:20:37', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('d6e09ee8-04ee-4a6a-9433-ccdefc28279d', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.207.177', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-09 14:19:03', '2019-08-09 14:24:43', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('c3faa955-e631-4e2e-8df1-d137cc2d5df4', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.33.113', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-28 11:01:15', '2019-08-28 11:01:18', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('c4ccf804-0c6b-4243-8366-907fc97d038b', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-10 09:11:54', '2019-09-10 09:12:51', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('715e7d71-0a07-48fa-b9d4-6b77b1da0f1f', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-10 09:15:34', '2019-09-10 09:15:39', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('2713925b-4dba-4bb8-a141-7ddd98a3076b', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-12 17:03:16', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('d8c1247b-cfff-4e6d-b614-67330db7b400', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.204.47', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-27 09:04:38', '2019-09-27 09:15:30', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('7e1b253e-d446-43b1-abf8-a35d5996612d', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.204.47', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-28 09:44:59', '2019-09-28 09:45:50', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('80911f8a-cbef-4dff-ba62-eda2fe7c00cb', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-07 11:03:07', '2019-10-07 11:12:39', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('1a9ff7bc-26a5-46fd-b2b8-29aa90bf5270', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-11 09:27:33', '2019-10-11 09:29:12', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('8d0a1c0f-aa42-48f8-b0ba-4942ae1a31c6', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.78', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-12 07:39:48', '2019-10-12 07:40:18', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('21ea471c-f5e7-42bf-8bb8-6ea5094ce84a', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-14 06:11:39', '2019-10-14 06:16:16', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('f906d1f5-faa3-4a99-81aa-5c72d1e70a33', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.32.140', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:21:35', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('775c3ec6-451e-400f-ba55-502db99ca09d', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.32.140', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:24:24', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('500df48a-d69c-4e59-93d6-be0188eef1ed', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.32.140', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-05-22 09:27:03', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('1ca24eba-365d-4dfe-b1fe-59f74707a2b4', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-06-03 09:47:43', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('d10b956f-26f1-4901-88cc-6930e9b227ed', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.34.102', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-06-03 21:22:18', '2019-06-03 21:22:50', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('e9823ce3-6ae6-429a-850d-bb2ba69e3e13', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-20 11:09:05', '2019-08-20 11:09:47', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('e69a2adc-2f02-4ab8-8370-64bedfb4b5f4', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-20 11:19:35', '2019-08-20 11:26:15', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('b8e50f25-fe5d-4068-82da-674f29a781f9', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-20 11:28:30', '2019-08-20 11:29:18', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('ae4a3416-1005-45cf-bac7-0335456f5215', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.34.19', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-03 16:31:26', '2019-09-03 16:38:56', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('dbe3371a-7a0d-466f-b992-5d43dc4175d4', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-10 15:17:40', '2019-10-10 15:33:20', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('b4a56642-420e-4c1b-98e0-0a7deaae69e4', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-11 09:31:04', '2019-10-11 09:31:21', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('6dc654c4-15ea-482f-9c16-4c51e8ac6fae', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-17 02:12:53', '2019-10-17 02:13:24', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('a9d4f21d-33cd-40e9-81ed-0a57f7660b9e', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-21 02:35:04', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('94545788-28be-4c7d-a49e-245e43db400f', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.205.97', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-06-12 11:45:34', '2019-06-12 11:45:41', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('279215d4-3afa-482a-8514-4091ac74bad8', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.204.233', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.98 Safari/537.36 LBBROWSER', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-07-04 16:01:26', '2019-07-04 16:03:03', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('a894d173-341b-416e-8d35-6deefacced4d', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-20 13:59:20', '2019-08-20 14:00:41', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('a7b0b445-7804-465b-b4be-39710964ac39', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-20 14:04:11', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('cc27b3b8-a4fd-44f0-b1ca-09cd1e2ca6a5', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.207.84', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-21 10:37:57', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('8906b4eb-a5e7-495f-bf4a-6a1a1437abee', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.210.54.190', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-21 10:57:07', '2019-08-21 10:58:13', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('a657121c-54b3-427d-99bb-8f4e2a7ba278', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101 Firefox/68.0', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-08-21 11:01:23', '2019-08-21 11:02:59', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('4cb2d7d6-db93-4f84-b6ab-cad0a12d6dff', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.34.19', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-04 17:52:44', '2019-09-04 18:09:45', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('aedca14f-99e6-48a1-8b34-b5644fb526d8', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.34.19', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-04 18:09:53', '2019-09-04 18:09:58', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('f6fee716-d670-47e2-bdde-a255570c000c', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.34.19', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-04 18:14:21', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('78354917-75a6-4ae6-a53b-71e910397ed5', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.132 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-12 16:44:16', '2019-09-12 16:44:28', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('0a2c58c3-f7dc-475a-9dfc-e8988576a859', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.204.47', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.98 Safari/537.36 LBBROWSER', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-09-28 09:34:30', '2019-09-28 09:35:06', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('a249ea0e-de37-40e6-bfcd-32b1013cf35a', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-11 09:33:09', '2019-10-11 09:33:18', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('e8b43cb4-5aa0-42fb-a684-831a3c6dfed5', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.34.150', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-12-23 15:32:00', '2019-12-23 15:33:26', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('726fd1e3-971b-48f9-9b95-c25288ad93d8', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-03-06 17:06:50', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('835eba32-491f-4be3-83ff-b86532bb2074', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.175', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101 Firefox/73.0', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-03-06 17:08:47', '2020-03-06 17:09:17', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('938bbabf-7b60-4f1a-a571-b7a78ba3e054', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.205.26', 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-12-31 09:25:43', '2019-12-31 09:28:13', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('db658d62-3ae1-4b30-a8d8-d42229471ce5', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-05-22 14:32:39', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('5e1c174e-34c0-4b63-9847-25d7cdd57883', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-05-22 16:08:24', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('6a4e3fe0-9573-4977-b3ad-4d6d6b33ea3b', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.31.157', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-07-24 11:50:10', '2020-07-24 11:50:49', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('ca8825bc-4c5c-494f-9dce-2fb19ee9ef89', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.31.157', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-08-06 10:17:59', '2020-08-06 10:19:04', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('484e0a8a-7f3e-4650-b586-edc698a5f56b', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.31.157', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-08-06 10:19:09', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('0ac0a4eb-f840-44f7-b090-b7dd5079c775', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-08-06 10:27:02', '2020-08-06 10:28:51', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('b25d1e04-21b3-40c8-a494-46c0ee6b5e7b', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.241', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-11-02 14:06:52', '2020-11-02 14:07:31', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('92cc8e26-0c68-4132-8852-918c6bdb4224', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2021-01-22 08:54:13', '2021-01-22 08:54:16', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('6c4770b6-cdd6-4963-9b9d-101b38bcfecb', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-05-26 14:33:04', '2020-05-26 19:23:22', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('9337f028-7beb-4998-8602-1e4d8d129622', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-05-29 09:46:32', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('86693c8b-8b49-42e5-a19b-eed3712378ff', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.31.157', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-08-05 15:08:29', '2020-08-05 15:09:36', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('930e66e9-2b4a-4c22-b520-585c615cac8f', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.153.91', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-09-15 18:40:26', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('e794a917-e714-48ba-b3c9-61e25250723e', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2021-01-05 15:17:35', '2021-01-05 15:33:09', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('e6c8cde2-d8c8-42ec-891e-6c8976e1b6fc', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-21 02:43:48', '2019-10-21 02:43:51', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('2ed20f3f-36a6-4977-b786-0bf741408fd3', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-21 02:47:03', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('4ed6ef77-9000-4645-9de1-112493542c41', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.209.30.78', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2019-10-21 07:33:47', '2019-10-21 07:33:51', NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('1114ffb1-71ba-4270-bca4-fa1119b573b9', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.211.153.91', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2020-09-14 16:09:52', NULL, NULL, NULL);
INSERT INTO `SYS_LOG` VALUES ('322b0e00-63f6-4fa0-8781-75706af3c083', 'f5db85ff-0ef8-451d-b86b-37de2116608f', NULL, '222.212.93.70', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36', '/qciot_cis/login', 'POST', 'username=super&password=', NULL, '1', '2021-01-04 10:06:32', '2021-01-04 10:13:49', NULL, NULL);

-- ----------------------------
-- Table structure for SYS_MANAGEMENTAREA_ORG
-- ----------------------------
DROP TABLE IF EXISTS `SYS_MANAGEMENTAREA_ORG`;
CREATE TABLE `SYS_MANAGEMENTAREA_ORG`  (
  `MID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域id',
  `OID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '机构id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_MANAGEMENTAREA_ORG
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_MANAGEMENT_AREA
-- ----------------------------
DROP TABLE IF EXISTS `SYS_MANAGEMENT_AREA`;
CREATE TABLE `SYS_MANAGEMENT_AREA`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_MANAGEMENT_AREA
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_MODULE
-- ----------------------------
DROP TABLE IF EXISTS `SYS_MODULE`;
CREATE TABLE `SYS_MODULE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `URL` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `GROUPID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PARENT_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `IS_SHOW` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PERMISSION` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_MODULE
-- ----------------------------
INSERT INTO `SYS_MODULE` VALUES ('c40a2dc8-1e16-4412-bd11-b5c814704869', '04071', '微信配置', '/system/finance/wechatPay', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', 'cf4383f4-ccdb-46a4-a4af-98a092ae45d6', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9491d6de-ad5a-448e-8a4c-eb5aa248a7a5', '9813', '特殊客户', NULL, 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e39f3238-3648-49e1-adef-ecf35edc13c0', '98131', '客户类型', '/system/base/specialCustomerType', 'f18cdc62-c467-4574-b16a-6954def4bc27', '9491d6de-ad5a-448e-8a4c-eb5aa248a7a5', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e5d60a02-dd39-4106-925b-7547881c29b7', '98132', '补贴参数', '/system/base/specialCustomerSubsidy', 'f18cdc62-c467-4574-b16a-6954def4bc27', '9491d6de-ad5a-448e-8a4c-eb5aa248a7a5', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b82afda6-9742-4a4c-8066-e5349e2a7baa', '0106', '团缴户管理', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e21ea319-0d55-4586-bff7-0acf2d70221d', '0109', '预存签约', '/system/customer/customer/prestoreContract', 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('2bb7104c-343f-4b33-9243-03da75dbfc91', '01131', '新增申请', '/system/customer/customerAddressVo/customerGasPropertyChange', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'cfaaf107-c23f-4afd-b912-058af7e601ef', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c3fd3926-5161-4185-b8f4-21a2df4cac20', '01051', '新增申请', '/system/customer/customerAddressVo/customerCloseAccount', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'f3e86f4d-d7d1-4b1a-8cb6-2997b211017a', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e0e2a24b-dbdb-427a-8572-53e8d29766d3', '01052', '申请列表', '/system/customer/closeAccount/list', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'f3e86f4d-d7d1-4b1a-8cb6-2997b211017a', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7c40cf26-3424-4844-b5ca-153bc281d26f', '01053', '发起申请', '/system/customer/closeAccount/sendCloseAccount', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'f3e86f4d-d7d1-4b1a-8cb6-2997b211017a', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('a7c1da71-d9b6-48f1-892a-ced547c67b00', '01054', '审批申请', '/system/customer/closeAccount/approvalCloseAccount', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'f3e86f4d-d7d1-4b1a-8cb6-2997b211017a', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('a1c83c70-9ab6-4bc3-879c-8a5d36883f63', '0302', '挂表管理', '/system/measure/installMeter/list', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('032f4c2b-223d-4e27-a6dc-2650f5e68eaf', '0615', '根据小区查询', '/system/check/yearCheckPlan/byVillage', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'cee717c6-c80d-4e47-abd9-fa5603a6385e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d8427b79-1962-4791-a628-a4d8a48bd5a6', '010805', '补气', '/system/business/supplyGas/form', 'a426cc37-99fd-4649-ae22-33db546dbb40', '18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('302bf1a7-a5d6-4e76-b266-65a1b11f808e', '10301', '知识库查询', '/system/monitoring/knowledge', '48028c40-2278-4ce6-ae63-6a0e0a48288d', 'd27e818d-c694-47f6-a98f-cea2c71e7b83', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4e6a0e5f-51a3-40c7-a54f-97e9840d9eb7', '0618', '安检计划查询', '/system/check/planDetail', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '0606294c-daf4-40f6-b5d6-b67ca757f8dc', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('47d2942f-2de4-478e-9350-f900adbd22e4', '01063', '文件信息', '/system/customer/customerAddressVo/customerOtherFile', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'b04ada62-8f41-454a-a86e-11f5444844b4', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d6169156-e753-4d37-914f-ea04eea08e70', '0101', '地址管理', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('10b4a6d9-a423-4da4-b015-8dadcc5ff389', '01023', '批量建档', '/system/customer/exportAddress', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'c6075564-7a82-447e-86ac-73ffc8504f01', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6d0f8092-02ec-448d-a46d-ae5fb3be405f', '01022', '普通建档', '/system/customer/address/commonDocumentCustomer', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'c6075564-7a82-447e-86ac-73ffc8504f01', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c0b175ff-3276-4c83-8d70-dfdd88a26344', '0501', '表具管理', NULL, 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0744b379-80a7-43b4-90ce-1e04331c8d20', '0104', '分户管理', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6aa7c606-5edc-4e2a-9783-e15cbcb0b806', '0111', '银行代扣', '/system/customer/customer/bankWithhold', 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9253b13f-9159-41a3-9a59-98f337a45f5e', '0103', '过户管理', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('2c06b8b3-03f6-453b-8ebb-7ff62ce93e01', '01133', '审批申请', '/system/customer/gasPropertyChange/approvalGasPropertyChange', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'cfaaf107-c23f-4afd-b912-058af7e601ef', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4ab79177-fb55-49e9-8da7-91e9e24ac993', '03042', '申请审批', '/system/toll/refundManage/checkList', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '99706297-27fa-4082-80a7-b00ad03ad389', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('f0bb3dbe-0531-4b42-981f-e181b78a2494', '0205', '追加气量管理', '/system/measure/gasaddition', '075c3787-0535-46bb-b29e-0f09284cab55', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0d8a012e-52b5-4af6-8b71-d27a0cb52165', '04', '岗位管理', '/system/position', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('525bd9cb-6fb5-4cef-90a5-6c2ec3cc523d', '01132', '申请列表', '/system/customer/gasPropertyChange', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'cfaaf107-c23f-4afd-b912-058af7e601ef', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d91253c4-e799-4a97-9b33-70cf0de8abd7', '02012', '分配抄表册', '/system/measure/bookletmanagement/meterbook', '075c3787-0535-46bb-b29e-0f09284cab55', 'e9765f1e-5f18-42ef-95d7-1d3c3eb8932c', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6d88b456-38fc-4034-ac71-2d5f25fde2f8', '011402', '用气性质', '/system/customer/heatingGasProperty', 'a426cc37-99fd-4649-ae22-33db546dbb40', '3bb4b313-67d2-40fd-a4da-35976374e867', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('094cc875-1134-49d2-b114-0c8df00c8fde', '01062', '团缴户成员', '/system/customer/teamPayment/member', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'b82afda6-9742-4a4c-8066-e5349e2a7baa', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6d59eac9-dda2-4da5-bbb4-5e85495ef373', '03041', '申请列表', '/system/toll/refundManage', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '99706297-27fa-4082-80a7-b00ad03ad389', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('aa93e847-f2a5-474f-8184-c6be833b1d20', '09072', '安检子项', '/system/base/securityCheckSubitem', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'c51143b5-b1f3-4616-a1a7-d1ea52a94f39', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d424eb29-c8be-489b-aa7f-e447de617741', '03052', '申请审核', '/system/toll/customerTransfer/checkList', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '4c534c28-3e46-4c7d-b163-b5c9b1c9ead4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9951d363-a62d-4242-8bd8-dc7c24b7e82f', '05', '员工管理', '/system/employee/', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d5dbb11e-c4e2-4825-877f-fa961c865fc7', '09', '日志管理', NULL, '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('fcb7c83c-4e83-403a-9b8d-8c70e4c4b330', '0107', '通气管理', '/system/business/ventilate/list', 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e527ea01-953c-4f8b-8aa6-56cf008ac6fd', '9820', '收费标准设置', '/system/base/priceSettings', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('f39afbbd-897e-407f-9ebd-8ec809c59ee2', '03062', '申请审核', '/system/toll/penaltyRelief/checkList', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '13cf7bcf-cf26-42ec-8ad8-52e843ef1b23', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cd432889-c214-4b24-a24f-7abe93001916', '03061', '申请列表', '/system/toll/penaltyRelief', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '13cf7bcf-cf26-42ec-8ad8-52e843ef1b23', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cfaaf107-c23f-4afd-b912-058af7e601ef', '0113', '用气性质变更', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('1697efae-bd16-41e3-b570-0a19e10d848b', '9801', '编码规则', '/system/base/codeRule', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7b77d066-d6fb-4b62-9b14-66122fd50399', '01034', '审批申请', '/system/customer/transferAccount/approvalTransferAccount', 'a426cc37-99fd-4649-ae22-33db546dbb40', '9253b13f-9159-41a3-9a59-98f337a45f5e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('148763b6-57d0-49aa-9709-806766af3a68', '01061', '团缴户', '/system/customer/teamPayment', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'b82afda6-9742-4a4c-8066-e5349e2a7baa', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cee717c6-c80d-4e47-abd9-fa5603a6385e', '0608', '安检统计查询', NULL, '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ba05a75e-b186-416d-b66a-483104a53a5e', '09033', '部门工单统计', '/system/workOrder/countWorkOrderByDept', '9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '3c8f2ee0-4419-4fa1-8b0b-38a864439f39', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e9765f1e-5f18-42ef-95d7-1d3c3eb8932c', '0201', '抄表册管理', NULL, '075c3787-0535-46bb-b29e-0f09284cab55', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6d04cca9-5d5e-472f-8de6-9ca42c7709b1', '0202', '抄表任务管理', NULL, '075c3787-0535-46bb-b29e-0f09284cab55', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('00c42e24-28b6-47b9-8814-d83ef850bf31', '02022', '临时抄表', '/system/measure/taskadjustment/tlist', '075c3787-0535-46bb-b29e-0f09284cab55', '6d04cca9-5d5e-472f-8de6-9ca42c7709b1', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('a45ff64d-a0e9-4c75-acfe-f97f627e9c7b', '0203', '抄表数据管理', NULL, '075c3787-0535-46bb-b29e-0f09284cab55', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('a05de9a6-7c90-4c84-82d1-30eec58989ef', '09034', '个人工单统计', '/system/workOrder/countWorkOrderByPersonal', '9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '3c8f2ee0-4419-4fa1-8b0b-38a864439f39', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('917d85e6-2055-43ba-b7fa-bd13375f928b', '0609', '制定年度计划', '/system/check/yearCheckPlan', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '0606294c-daf4-40f6-b5d6-b67ca757f8dc', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6a82f7c4-9845-4981-b533-9ce5eb5191d7', '05033', '补卡', '/system/business/supplementCard/list', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '260c1374-4758-4871-b9d9-293711848a58', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('68bf2961-5cf5-4dfb-8ee3-65134593a043', '02072', '设备领用', '/system/measure/meterusage', '075c3787-0535-46bb-b29e-0f09284cab55', '69a508c8-1a6f-4389-b584-53c5879aedbc', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9ab106a5-bb94-478f-89ef-57704f6ce623', '08012', '维修申请查询', '/system/maintenance', 'a7c8cbf2-0b3b-4b4b-822e-c037d7442e05', 'b5162b25-1e87-40ee-9fc8-d485f11ee360', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('3b06bc2c-8108-4824-9677-fde707d1ee74', '07', '角色管理', '/system/role', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6a892869-a8da-428a-a658-10621b88262e', '01', '账套管理', '/system/platform/tenant', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('704e0b46-6b3d-45a4-8d10-7136e27bdf17', '9906', '数据字典', '/module/dictionary/dictionary.jsp', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6ca4a081-d8a4-4987-8889-e5672e389d8c', '06', '操作员管理', '/system/operator', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('65234945-5a1f-4883-aee1-5dfcb76fce21', '0301', '远程抄表', '/module/corporation/corporationList.jsp', 'aed181c4-943e-4b6c-add4-74d0741db174', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('674c0f80-6d43-4519-ba8b-cfb8423e2b3a', '9904', '模块管理', '/system/moduleGroup', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7ee5d663-1d09-467f-b6b0-af9eb28a6159', '02', '机构设置', '/module/org/org.jsp', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('06b4a1bc-d051-4801-bb3e-526749ba08ae', '08', '用户管理', '/system/rbac/user', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9e381a8f-7019-470a-9523-3cb212e85e25', '0201', '工具卡制作', '/module/corporation/corporationList.jsp', '0f0b5019-4caf-4e44-99f5-c0d1ba59c094', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('92613cea-4063-4a64-ac8b-c31ed0becda6', '0501', '过户明细报表', '/module/corporation/corporationList.jsp', '15207471-71e8-4c33-a129-dc6c6f26c292', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('025114a3-a42e-49ae-b85b-1cffce61422d', '03', '管理区域', '/module/rbac/managementArea-org.jsp', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9e987721-09e2-4439-b980-5c18e0aa27ba', '0206', '气量调整管理', '/system/measure/gasadjust', '075c3787-0535-46bb-b29e-0f09284cab55', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('bd35ff23-a223-4a1e-9c8b-9f5339f98b1e', '0501', '票据管理', NULL, 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('67cdac40-a532-40e7-8678-c013bd74ac3f', '05018', '启用表具', '/system/business/meter/enable', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', 'c0b175ff-3276-4c83-8d70-dfdd88a26344', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e3463eb8-3438-4fc7-b6ee-913309eda788', '05017', '停用表具', '/system/business/meter/disable', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', 'c0b175ff-3276-4c83-8d70-dfdd88a26344', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('549a9048-74e2-474d-9eee-c509ac0cb338', '0110', '受限客户', '/system/customer/customerAddressVo/limitCustomer', 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('63f4e7d1-d840-4445-978f-c5b3484ea430', '01021', '客户查询', '/system/customer/customerAddressVo', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'c6075564-7a82-447e-86ac-73ffc8504f01', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c6075564-7a82-447e-86ac-73ffc8504f01', '0102', '开户管理', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b04ada62-8f41-454a-a86e-11f5444844b4', '0106', '客户其他信息', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('712318de-4d4b-4c37-8e21-a65c55f0e0ae', '9806', '阶梯计费', NULL, 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ddaf9d81-f726-4dae-b04d-98a1991914fb', '98061', '阶梯计费方案', '/system/base/stepPriceProgramme', 'f18cdc62-c467-4574-b16a-6954def4bc27', '712318de-4d4b-4c37-8e21-a65c55f0e0ae', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9e051c52-2435-4f3c-9441-6538e731b568', '98062', '阶梯计费参数', '/system/base/stepPriceParam', 'f18cdc62-c467-4574-b16a-6954def4bc27', '712318de-4d4b-4c37-8e21-a65c55f0e0ae', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6ec6d69e-59c3-4398-9d48-811fe082a99e', '0802', '减免申请管理', '/system/maintenance/findRemission', 'a7c8cbf2-0b3b-4b4b-822e-c037d7442e05', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('eacc868c-7488-4ac1-8616-47b3c78a0184', '9808', '业务类型', '/system/base/businessType', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('004d5fb2-cf07-4e50-a30d-935388007cd3', '05038', '特困客户补贴', '/system/business/poorSubsidy', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '260c1374-4758-4871-b9d9-293711848a58', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('760c0499-56c7-48f2-b337-70ca8fc1a095', '9823', '客户类型', '/system/base/customerType', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('f3e86f4d-d7d1-4b1a-8cb6-2997b211017a', '0105', '销户管理', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('3bb4b313-67d2-40fd-a4da-35976374e867', '0114', '采暖期管理', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9d49df2b-20fc-4219-ab39-3f64ddebec40', '011401', '采暖客户', '/system/customer/customerAddressVo/customerHeating', 'a426cc37-99fd-4649-ae22-33db546dbb40', '3bb4b313-67d2-40fd-a4da-35976374e867', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9aaa44e8-64e6-437e-947c-159bc0ee64d5', '011403', '启动采暖期', '/system/customer/heatingGasProperty/findStatus', 'a426cc37-99fd-4649-ae22-33db546dbb40', '3bb4b313-67d2-40fd-a4da-35976374e867', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ca20031d-1728-43df-951d-6a5a0e665d74', '03', '行政区域', '/system/base/administrativeArea', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5428415d-ca2b-436b-a334-ea66de7f8ffb', '9803', '第三方机构', '/system/base/collectionAgency', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e2198d5a-1941-410b-bf72-f5cce60792f3', '9804', '材料设备', NULL, 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('86bf9940-48fe-4fba-8ccc-0fc7cfdeac90', '98041', '材料分类', '/system/base/materialType', 'f18cdc62-c467-4574-b16a-6954def4bc27', 'e2198d5a-1941-410b-bf72-f5cce60792f3', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('dd30be1e-7103-4c69-a137-84b39ffb9070', '98042', '材料', '/system/base/material', 'f18cdc62-c467-4574-b16a-6954def4bc27', 'e2198d5a-1941-410b-bf72-f5cce60792f3', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('524c24cb-eb70-4f64-83a2-98c1a795da15', '9805', '用气性质', '/system/base/gasProperty', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('3d4533fe-4553-4e12-8510-8ae13948c259', '01032', '申请列表', '/system/customer/transferAccount/list', 'a426cc37-99fd-4649-ae22-33db546dbb40', '9253b13f-9159-41a3-9a59-98f337a45f5e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c6cd5b5c-fe5c-456d-9498-b6113daff714', '01033', '发起申请', '/system/customer/transferAccount/sendTransferAccount', 'a426cc37-99fd-4649-ae22-33db546dbb40', '9253b13f-9159-41a3-9a59-98f337a45f5e', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4c534c28-3e46-4c7d-b163-b5c9b1c9ead4', '0305', '客户调账', '/system/toll/customerTransfer', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('95cc6dd4-cc92-4c7a-aea6-7fc291c9fbb2', '9821', '默认设置', '/system/base/defaultSettings', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0d22ba2e-82f7-4896-bd1b-36f20bc7c393', '0904', '工单设置', NULL, '9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cf4383f4-ccdb-46a4-a4af-98a092ae45d6', '0506', '支付管理', NULL, 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('57336fd3-264a-436d-a792-3fb24e59f104', '09374', '安检周期', '/system/base/cycle', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'c51143b5-b1f3-4616-a1a7-d1ea52a94f39', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4b8c3fb0-0bc0-4be4-badc-9e2f98c46196', '11032', '版本列表', '/system/app/release/list', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', '3ea895a2-6fcd-4f82-a367-02a113b8ca40', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9946ff82-aa73-4131-bba9-dd6aa8aed5b2', '02032', '抄表数据审核', '/system/measure/audit/firstlist', '075c3787-0535-46bb-b29e-0f09284cab55', 'a45ff64d-a0e9-4c75-acfe-f97f627e9c7b', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('14e7ea59-e559-4735-91b5-f70305eabd7a', '0204', '抄表设备管理', '/system/measure/metermanage', '075c3787-0535-46bb-b29e-0f09284cab55', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('f2d5203c-0b81-478c-84a9-e7af41adce04', '9815', '表具设置', NULL, '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('137d5bf6-fc5a-445a-a344-e3dc65020550', '9818', '结算方式', '/system/base/payType', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6f20061c-6db8-485c-8bbf-954c19725095', '9819', '营业厅', '/system/base/businessHall', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b8ea1731-4fce-4f56-b86c-46a8140034ac', '02011', '抄表册列表', '/system/measure/bookletmanagement', '075c3787-0535-46bb-b29e-0f09284cab55', 'e9765f1e-5f18-42ef-95d7-1d3c3eb8932c', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('78319444-b04b-40ba-b72d-0743945c94b7', '02013', '抄表册调整', '/system/measure/bookletadjustment', '075c3787-0535-46bb-b29e-0f09284cab55', 'e9765f1e-5f18-42ef-95d7-1d3c3eb8932c', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9c635fdc-c40a-4891-ad9a-bdcb3efe0ac3', '0504', '短信管理', NULL, 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('33a59649-92d4-4cd8-bb47-7b0af4b3f019', '010802', '充值', '/system/business/recharge', 'a426cc37-99fd-4649-ae22-33db546dbb40', '18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d8cd70d1-d151-49f4-ad08-ca2d4d27ff3c', '0502', '通气管理', '/system/business/ventilate/list', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('260c1374-4758-4871-b9d9-293711848a58', '0503', 'IC卡管理', NULL, 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('1474ac7d-4452-4eab-bcc9-7837b02d83da', '0505', '购气管理', '/system/business/buyGas', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('2aaf52c1-a316-4f68-84a6-fe4f13f4a290', '02031', '抄表数据录入', '/system/measure/meterdatarecord/firstlist', '075c3787-0535-46bb-b29e-0f09284cab55', 'a45ff64d-a0e9-4c75-acfe-f97f627e9c7b', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('2572080d-9b16-406a-8b99-0d29ba884ab1', '05016', '换表管理', '/system/business/changeMeter/list', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', 'c0b175ff-3276-4c83-8d70-dfdd88a26344', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('a9ca521b-0b4c-494e-9d80-0db7e47de861', '10', '流程设置', '/system/act', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('68fc29c8-1d2d-4ea0-92d1-8570fc097732', '01121', '新增短信', '/system/business/smsInfo/form', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'e457bba3-b199-411d-9a12-77027a5d3e89', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('45e74412-3c8c-49fd-ab99-9770bcc98438', '9824', '证件类型', '/system/base/credentialsType', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5b5b826e-acc0-4ef6-9e59-bb86d7ccce80', '05012', '挂表管理', '/system/business/installMeter/list', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', 'c0b175ff-3276-4c83-8d70-dfdd88a26344', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('8a13c4b4-9438-4473-a30c-4bb693390b14', '0301', '费用设置', '/system/toll/chargeSetting', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('803c4858-df0f-4e7e-b1df-29d1f0088fc1', '05043', '短信模版', '/system/business/smsTemplate', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '9c635fdc-c40a-4891-ad9a-bdcb3efe0ac3', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('052b0042-01d5-4a3a-a4d9-f3c8e5998dcc', '0619', '安检结果查询', '/system/check/checkResult/searchResult', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'c0f981b8-7e8b-4519-bea4-fd445d6334a1', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0693ee05-963e-46f8-b067-0f9d24e1d3c8', '03044', '退费执行', '/system/toll/refundManage/refundList', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '99706297-27fa-4082-80a7-b00ad03ad389', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('3a35d7cc-4bf0-4162-958b-ae57a08c4217', '03054', '调账执行', '/system/toll/customerTransfer/transferList', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '4c534c28-3e46-4c7d-b163-b5c9b1c9ead4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('424c6e2d-aa9e-45b2-b21d-824cf533d0e0', '04013', '领用列表', '/system/finance/ticketUseRecord/', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', 'bd35ff23-a223-4a1e-9c8b-9f5339f98b1e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d0b7b59e-3e99-45b2-9dc8-ae6b2684b366', '0617', '制定临时计划', '/system/check/tempPlan', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '0606294c-daf4-40f6-b5d6-b67ca757f8dc', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('744fee9f-d159-403f-99ca-3d3f4d89b102', '05031', '开卡', '/system/business/activateCard/list', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '260c1374-4758-4871-b9d9-293711848a58', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e457bba3-b199-411d-9a12-77027a5d3e89', '0112', '短信管理', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('10c3f2a5-354c-453f-894b-d59aaffee439', '99072', '通知列表', '/system/app/notice/list_sys', '69a0b25c-ebe6-4494-a000-6549715ae1da', '64a831b6-20e8-4b77-b9e6-fd758e30185b', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b47db422-30ad-456c-8bff-fb336af89e1f', '0701', '报装改造申请', '/system/install/installapplicationinfo', '90532a41-0fea-406b-b444-67c64a475754', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('17361812-6f23-43df-99d4-c0bcfc0dd96e', '02052', '追加气量审核', '/system/measure/gasaddition/additionauditlist', '075c3787-0535-46bb-b29e-0f09284cab55', 'f0bb3dbe-0531-4b42-981f-e181b78a2494', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4519759e-3649-4387-97f6-7edc562ff80c', '07031', '流程设置', '/system/install/installprocess', '90532a41-0fea-406b-b444-67c64a475754', '158f5799-be7f-44d8-a539-a7e29c4f87ad', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0319768a-65d6-4c96-b5ab-916d43379639', '05053', '远传表控制', '/system/measure/remote/controllList', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', 'd04b9c6f-43cb-4b38-a49b-5930aeb929c7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c64c21f2-6dfb-499d-9c41-06d32dbeb8c5', '0304', '拆表管理', '/system/measure/uninstallMeter/list', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9eacfcc3-a0fb-4fae-a2fd-9fc498cb1808', '03041', '停用表具', '/system/measure/meter/disable', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', '963ecb71-4943-4dfe-9b39-0aba1bbc14f8', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('64a831b6-20e8-4b77-b9e6-fd758e30185b', '9907', '通知管理', NULL, '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('30d67f1f-d0d8-4d06-b8c1-d3963cad9eb3', '07042', '管理区域统计', '/system/install/statistics/areaList', '90532a41-0fea-406b-b444-67c64a475754', '5798944b-ce4a-49f1-86b2-d946cb8e54d0', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('017a3412-d576-4469-942d-9243d1fcc579', '07043', '完成时间统计', '/system/install/statistics/weekList', '90532a41-0fea-406b-b444-67c64a475754', '5798944b-ce4a-49f1-86b2-d946cb8e54d0', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9aa1453f-36ac-467a-9679-b2461afcbed5', '03091', '表具入库', '/system/measure/importMeter/list', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', 'e556e23d-5512-41bc-a7bc-d6b568073067', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('8bd91535-2ac3-4f89-adc0-5f9a4b68dc53', '12051', '统计报表', '/system/statistics/preDeposit/report', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', 'ef247ddf-e6c4-4e83-af43-b0789623dad7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e1db7527-81d2-44b2-8a4f-2adb4633754a', '0702', '报装减免管理', '/system/install/installapplicationinfo/installRemission', '90532a41-0fea-406b-b444-67c64a475754', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('499d7025-ff1d-4884-9c9b-055ed1993f9f', '9826', '注册码设置', '/system/base/sensorNetwork', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('43c3fc68-7485-4e4c-99e3-8c06eb530fc7', '05054', '下发计费方案', '/system/measure/remote/stepPriceMeterList', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', 'd04b9c6f-43cb-4b38-a49b-5930aeb929c7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('77eec69f-aafe-4c08-b2b5-7e4363ee981a', '12052', '明细查询', '/system/statistics/preDeposit/detail', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', 'ef247ddf-e6c4-4e83-af43-b0789623dad7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cb219359-5d67-4926-a2de-921c0390d401', '98151', '厂家设置', '/system/base/factory', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', 'f2d5203c-0b81-478c-84a9-e7af41adce04', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c94e63af-066b-49c0-a803-5da45ee529be', '1107', '图片管理', '/system/rbac/img', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cf4ce12f-4d53-4a85-8eb8-8e5a057921ce', '0312', '充值查询', '/system/toll/chargeMeter', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('8f40b9ac-335b-4753-a37d-0c9f9fe478f2', '03073', '缴费提醒', '/system/toll/pressCharge/receivableList', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', 'd7c706dc-979b-4bb8-9593-8c8c6e40b339', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('8805cdb2-87e9-40aa-81d3-ed05e6765c32', '1206', '销售统计', NULL, 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ba3d1d7e-0659-419c-8473-206ffb20d881', '02034', '阶梯用气详情', '/system/measure/audit/bookletdatadetails', '075c3787-0535-46bb-b29e-0f09284cab55', 'a45ff64d-a0e9-4c75-acfe-f97f627e9c7b', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7de7a719-e623-45d9-8623-65a20cff21c9', '1207', '大数据分析', NULL, 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('941e301e-2647-4d11-ab2a-b247a0737796', '1272', '维修统计分析', '/system/statistics/maintenanceAnalysis/goPie', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '7de7a719-e623-45d9-8623-65a20cff21c9', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('a1c8dfe0-bc05-404c-8ef8-a8489f606a38', '12071', '客户发展分析', '/system/report/customer/growingTrendIndex', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '7de7a719-e623-45d9-8623-65a20cff21c9', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9b58e10c-0db2-4a1e-9631-135894330605', '1271', '隐患趋势分析', '/system/statistics/dange', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '7de7a719-e623-45d9-8623-65a20cff21c9', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('1009e02d-092e-4409-9d0c-b6133fe0d439', '03092', '表具领用', '/system/measure/importMeter/findInStock', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', 'e556e23d-5512-41bc-a7bc-d6b568073067', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('116bb39e-8a47-46c9-b965-e118d9c894c1', '12051', '用气性质月销售报表', '/system/statistics/gasSale/monthlyGasPropertySale', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '8805cdb2-87e9-40aa-81d3-ed05e6765c32', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ba37e462-6d00-42f1-8ac9-2a5544566522', '12053', '用气性质应收气费月报', '/system/statistics/gasSale/monthlyGasPropertyDeservedFee', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '8805cdb2-87e9-40aa-81d3-ed05e6765c32', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('83995672-8211-4458-9774-b5abf36e506b', '12057', '客户应收款明细查询', '/system/statistics/gasSale/customerDeservedFeeDeatils', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '8805cdb2-87e9-40aa-81d3-ed05e6765c32', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c02f8306-6780-4bd7-812f-40aa089c39f5', '12052', '分单位天然气销售月报', '/system/statistics/gasSale/monthlyGasSaleBranch', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '8805cdb2-87e9-40aa-81d3-ed05e6765c32', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5a51cdae-a28f-49f2-a211-0f8b72a5f2dc', '12054', '分区域应收气费月报', '/system/statistics/gasSale/monthlyBranchDerservedFee', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '8805cdb2-87e9-40aa-81d3-ed05e6765c32', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('2bc43975-f80b-4a5e-a0d4-b3d2e9672519', '12057', '天然气按阶梯销售统计', '/system/statistics/gasSale/stepGasSaleStatistic', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '8805cdb2-87e9-40aa-81d3-ed05e6765c32', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('04248033-5d48-4e55-8a2e-b440580b4d7f', '9827', '灶具连接方式', '/system/base/cookerConnectionMode', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('683a16f6-a8be-4c31-b33b-caa1b049c2b1', '9828', '灶具安装方式', '/system/base/cookerInstallationMode', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9485becd-cc47-4e02-83bd-05b7c52b2a24', '05111', '应收气费查询', '/system/statistics/gasCharge/arrearageReport', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', 'cdb707a7-a740-4078-a2c3-ac3d5d53efdc', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('779a395e-fabe-4828-9f74-bc3e62271357', '05112', '应收业务费查询', '/system/toll/receivableRecord', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', 'cdb707a7-a740-4078-a2c3-ac3d5d53efdc', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6506c389-9fce-4ce2-b824-498104830e32', '05113', '应收查询', '/system/toll/receivableRecord/receivableAndGasRecord', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', 'cdb707a7-a740-4078-a2c3-ac3d5d53efdc', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('792295a2-430f-43f8-bba9-2a5f8300we8e', '03091', '当面交接', '/system/toll/chargeTransfer', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '792294a2-930f-43f8-bba9-2a5f8300108e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('793495a2-er0f-43f8-bga9-2agf83e0we8e', '03092', '远程交接', '/system/toll/chargeTransferRemote', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '792294a2-930f-43f8-bba9-2a5f8300108e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('1fe13f00-ca5e-4b81-8a6c-26d724888bd1', '9805', '用气类型', '/system/base/gasType', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4c394394-e803-4cc9-8809-11d6de81137a', '9911', '系统参数', '/system/base/sysConfig', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('f829dad7-7bf9-5308-04ce-f3775e17e9d6', '01042', '分户记录', '/system/customer/meterRecord/list', 'a426cc37-99fd-4649-ae22-33db546dbb40', '0744b379-80a7-43b4-90ce-1e04331c8d20', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('95ea0f81-5c72-4ccc-88b3-29f7225bd92c', '12032', '抄表统计', '/system/measure/statistics', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '6db09e44-cdd0-4571-b72d-311286ee5405', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('272370e3-a0b7-417a-a94e-42b552666d57', '12031', 'IC卡表统计', NULL, 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b9978d89-15ee-40bb-8607-5ad6c030ea74', '0302', '柜台收费', '/system/toll/counterCharge', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6edf13b2-f3dc-4e36-9222-f1d4a4d3e33c', '05032', '充值', '/system/business/recharge', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '260c1374-4758-4871-b9d9-293711848a58', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0606294c-daf4-40f6-b5d6-b67ca757f8dc', '0603', '安检计划管理', NULL, '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('2f946cdb-21bb-45e9-9342-1f2a21c51aad', '05014', '拆表管理', '/system/business/uninstallMeter/list', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', 'c0b175ff-3276-4c83-8d70-dfdd88a26344', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('1cc4f647-593b-4164-bdb2-9f58f0f21d04', '03028', '收费', '/system/toll/counterCharge/combined', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', 'b9978d89-15ee-40bb-8607-5ad6c030ea74', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('48c11726-1bfa-4d42-9ccb-ac63ccbe782d', '04011', '票据分类', '/system/finance/notesType', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', 'bd35ff23-a223-4a1e-9c8b-9f5339f98b1e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('bd47adef-17dc-4f1e-a6c8-da4107c737af', '04014', '发票管理', '/system/finance/notesManage/', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', 'bd35ff23-a223-4a1e-9c8b-9f5339f98b1e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4d200461-f64b-4eaf-af09-808593de2b64', '01031', '新增申请', '/system/customer/customerAddressVo/customerTransferAccount', 'a426cc37-99fd-4649-ae22-33db546dbb40', '9253b13f-9159-41a3-9a59-98f337a45f5e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7610ec27-6fc8-4550-875c-cfba8e5b4322', '05041', '新增短信', '/system/business/smsInfo/form', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '9c635fdc-c40a-4891-ad9a-bdcb3efe0ac3', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('8b3c7507-4e99-4c00-93a6-c3fef42bac89', '12015', '开户汇总报表', '/system/report/summary/customer/create', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', 'b44cbf2b-2c7f-43bf-a210-cc918955a6af', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ba0866ff-eb6a-4db7-84c7-0d556cf545f3', '0903', '操作日志查询', '/system/sysLog/findLogOperation', '69a0b25c-ebe6-4494-a000-6549715ae1da', 'd5dbb11e-c4e2-4825-877f-fa961c865fc7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('132ab6aa-5cd7-4775-90bb-ef972579c26b', '010804', '取消充值', '/system/business/cancelRecharge', 'a426cc37-99fd-4649-ae22-33db546dbb40', '18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('a7264c13-0d39-488a-91ae-0aedcd34cf98', '05042', '短信列表', '/system/business/smsInfo', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '9c635fdc-c40a-4891-ad9a-bdcb3efe0ac3', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('385895e0-190c-4027-8437-2fa6602f2dab', '03051', '申请列表', '/system/toll/customerTransfer', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '4c534c28-3e46-4c7d-b163-b5c9b1c9ead4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('963ecb71-4943-4dfe-9b39-0aba1bbc14f8', '0305', '表具启停', NULL, '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('158f5799-be7f-44d8-a539-a7e29c4f87ad', '0703', '报装改造设置', NULL, '90532a41-0fea-406b-b444-67c64a475754', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b5162b25-1e87-40ee-9fc8-d485f11ee360', '0801', '维修申请管理', NULL, 'a7c8cbf2-0b3b-4b4b-822e-c037d7442e05', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cb56c012-694d-4b78-986e-ea1c08bfff3e', '99071', '新增通知', '/system/app/notice/form_sys', '69a0b25c-ebe6-4494-a000-6549715ae1da', '64a831b6-20e8-4b77-b9e6-fd758e30185b', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ab4cbb6c-592f-4f18-b6b8-0a0edcecf8b8', '02023', '临时任务', '/system/measure/taskadjustment/tasklist', '075c3787-0535-46bb-b29e-0f09284cab55', '6d04cca9-5d5e-472f-8de6-9ca42c7709b1', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('8482bf88-c160-4ba7-a9dd-6a77b238ffef', '0902', '登录日志统计', '/system/sysLog/loginStatistic', '69a0b25c-ebe6-4494-a000-6549715ae1da', 'd5dbb11e-c4e2-4825-877f-fa961c865fc7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('3c8f2ee0-4419-4fa1-8b0b-38a864439f39', '0906', '工单统计', NULL, '9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('60eee569-3016-4ee0-b2e1-5f22f1780114', '0901', '工单管理', '/system/workOrder/queryAllWorkOrder', '9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7e7a080e-e3ac-4df7-b5e4-39782f584c46', '10201', '呼叫记录查询', '/system/monitoring/callingrecords', '48028c40-2278-4ce6-ae63-6a0e0a48288d', '211e5b4d-60f2-4ec7-9552-eb43120d2b61', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('1f754d6f-adab-43d7-8b9f-9f84d7f90e34', '010801', '开卡', '/system/business/activateCard', 'a426cc37-99fd-4649-ae22-33db546dbb40', '18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('07241019-2037-40a5-9c3e-97f8409760b3', '0618', '录入安检结果', '/system/check/checkResult', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'c0f981b8-7e8b-4519-bea4-fd445d6334a1', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c0f981b8-7e8b-4519-bea4-fd445d6334a1', '0605', '安检数据管理', NULL, '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('eb2d907b-a719-4c80-bdf6-5454e1fd73e8', '0606', '超期安检处理', '/system/check/overplan', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('862faab3-9410-43e7-93f7-a4c9ee72f949', '0607', '安检人员轨迹', '/system/check/Locus', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ad520920-e9c8-4ba7-8bbb-d788899b79a4', '09031', '工单查询', '/system/workOrder/queryWorkOrder', '9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '3c8f2ee0-4419-4fa1-8b0b-38a864439f39', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5995631e-6381-45fc-8d52-b61b0ca0f9e3', '0606', '安检隐患管理', '/system/check/checkDange', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('12e73fd0-48eb-459c-97c5-df9df551e7cc', '010803', '补卡', '/system/business/supplementCard', 'a426cc37-99fd-4649-ae22-33db546dbb40', '18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d8e0d408-d341-4352-a83d-68986ad3f301', '02021', '更换抄表员', '/system/measure/taskadjustment', '075c3787-0535-46bb-b29e-0f09284cab55', '6d04cca9-5d5e-472f-8de6-9ca42c7709b1', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('f416193e-d207-4a1a-b082-c906f534123c', '010806', '清卡', '/system/business/clearCard/form', 'a426cc37-99fd-4649-ae22-33db546dbb40', '18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('af943108-a635-4e27-86ff-95e4e20cfde6', '02112', '购气单位设置', '/system/measure/gasPurchaseOrg', '075c3787-0535-46bb-b29e-0f09284cab55', '6ccade4f-0cbb-4124-9176-269504cfb3df', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d04b9c6f-43cb-4b38-a49b-5930aeb929c7', '0305', '远传表管理', NULL, '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('80d98596-5200-4f30-a395-8587701ca63e', '10101', '客户信息查询', '/system/monitoring/centre/entre', '48028c40-2278-4ce6-ae63-6a0e0a48288d', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('1649f287-4836-453f-8f2b-4d6cd3374272', '02053', '追加列表', '/system/measure/gasaddition/additionlist', '075c3787-0535-46bb-b29e-0f09284cab55', 'f0bb3dbe-0531-4b42-981f-e181b78a2494', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('96b50a61-2184-4de4-a676-4b6f5315babf', '02051', '新增追加', '/system/measure/gasaddition', '075c3787-0535-46bb-b29e-0f09284cab55', 'f0bb3dbe-0531-4b42-981f-e181b78a2494', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('27366fd2-1b5c-4778-9f87-f0c548a87cff', '02063', '调整单列表', '/system/measure/gasadjust/adjustlist', '075c3787-0535-46bb-b29e-0f09284cab55', '9e987721-09e2-4439-b980-5c18e0aa27ba', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6ea117ec-5fd1-4579-91c4-8aa33a58bc5c', '02061', '新增调整', '/system/measure/gasadjust', '075c3787-0535-46bb-b29e-0f09284cab55', '9e987721-09e2-4439-b980-5c18e0aa27ba', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4542a5f5-e62c-40ec-89bd-e661564a1a94', '0901', '登录日志查询', '/system/sysLog/queryLogin/', '69a0b25c-ebe6-4494-a000-6549715ae1da', 'd5dbb11e-c4e2-4825-877f-fa961c865fc7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cbdce216-5940-4f3f-a852-787b630ab7ac', '0502', '转账管理', '/system/finance/transferManage/', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('472b4da3-32ff-4633-b7cb-97712468b1c4', '0503', '银行对账', '/system/finance/bankCheck/', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('eeceec47-97e1-476a-8124-81cda0f96806', '0504', '第三方对账', '/system/finance/thirdCheck', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('28b9906a-2e4c-4a0a-bffd-f778085b5f15', '0507', '电子发票', NULL, 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6a57521e-ccfd-46b0-8376-2814d180cbe9', '04012', '票本管理', '/system/finance/ticketManage', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', 'bd35ff23-a223-4a1e-9c8b-9f5339f98b1e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('211e5b4d-60f2-4ec7-9552-eb43120d2b61', '10201', '呼叫记录管理', NULL, '48028c40-2278-4ce6-ae63-6a0e0a48288d', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('99706297-27fa-4082-80a7-b00ad03ad389', '0304', '退费管理', '/system/toll/refundManage', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('f477cdc0-63dc-4191-92d2-d17343393e9e', '0303', '冲正管理', '/system/toll/correctionManage', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('13cf7bcf-cf26-42ec-8ad8-52e843ef1b23', '0306', '违约金减免', '/system/toll/penaltyRelief', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d7c706dc-979b-4bb8-9593-8c8c6e40b339', '0307', '催费管理', NULL, '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c81a5404-212e-479d-a997-c9c03b76fdfe', '0308', '特殊客户补贴', '/system/toll/customerSubsidy', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5dba337f-605a-46c4-9964-9f6cd0d13a59', '0310', '收费解款', '/system/toll/payInBank', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d2628388-d4b7-47bf-b819-f1c4b2bec918', '11', '短信设置', '/system/rbac/smsSettings', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e0199a12-3097-4b31-ab3e-a5005c1c4de7', '14', '定时任务', NULL, '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('3b1e67d8-5aee-4bc6-b962-322cd69ce2ce', '0505', '月结扎帐', NULL, 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '#', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c0e0345b-acf1-459e-9e4b-7127fb5848d6', '11137', '打印内容设置', '/system/app/print', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'cc8b0c20-f114-402b-890b-6dbd3c1191d2', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('032b5e11-acfa-468a-ac69-aadfe155020b', '9998', '网络参数设置', '/system/base/rtsWeb', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e6716b76-d78f-4aa4-a27f-1291347f517b', '12031', '收费员收款方式统计', '/system/statistics/fee/counterTotalPayType', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d639c120-1c9b-4ef0-a9cd-e2519128c23e', '010810', 'IC卡密钥设置', '/system/base/icKey', 'a426cc37-99fd-4649-ae22-33db546dbb40', '18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c6eaf38c-3759-4a0a-b511-aeab3b5ab25a', '12045', '收费员收费汇总报表', '/system/statistics/fee/counterChargeCollect', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('170d490c-8bf3-44cf-906f-50c55f121c45', '13132', '公司收费渠道汇总表', '/system/statistics/fee/counterChargeChannelsTotal', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0f97e275-8f26-4b87-b262-7bda2bdf7c1f', '12048', '营业厅用气性质收费表', '/system/statistics/fee/businessHallReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c46g493a-fe27-444d-arfx-ab36e6786gnb', '12030', '业务费收费统计', '/system/toll/receivableRecord/total', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c469c93a-ff27-444d-a5f6-ab36e3036185', '12030', '收费员收费类型统计', '/system/statistics/fee/counterTotalChargeType', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6952aef0-f468-49a3-b1b6-e22c6ffdb8b6', '13131', '公司收费汇总表', '/system/statistics/fee/companySummary', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b01c8f0f-d5f7-4594-896f-744fae3c10bf', '12044', '收费员收费明细', '/system/statistics/fee/counterDetail', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0afaad81-38f1-4768-81dc-e14b198bad11', '12049', '天然气用气性质销售表', '/system/statistics/fee/gasSaleReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ec37cd25-6a0a-4346-b9da-98ddbdb8c9a9', '12050', '第三方收费日报', '/system/statistics/fee/employeeReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4ace0116-24f5-489b-a2da-a13b9c4f340a', '12130', '第三方收费明细查询', '/system/statistics/fee/employeeDetail', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e671er76-7u8f-4awv-a27f-1291vb4f517b', '12039', '个人收费查询', '/system/statistics/fee/counterTotalPayTypePerson', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e1wler76-7u8f-bnmk-a27f-1291vbsgh17b', '12038', '发票汇总表', '/system/toll/invoice/totalReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d1528edb-d239-4981-a621-dccd6bab237f', '12046', '违约金明细报表', '/system/statistics/penalty', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '40ff307f-99d9-48f2-a57d-64ec96020275', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('629b9d04-6850-4b6d-b3a2-15dcdefa0015', '01014', '楼栋查询(新)', '/system/customer/building/newList', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'd6169156-e753-4d37-914f-ea04eea08e70', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('eca4c40c-24f7-4a80-aa49-b1bd27a9a3b4', '11130', '险情处理', '/system/app/resk', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'b70e15a3-27f4-401e-b09c-771ef026f108', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('8bec3005-35e0-4464-9976-940eeb5fcb0d', '11135', '商品类别', '/system/app/waresType', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'b70e15a3-27f4-401e-b09c-771ef026f108', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('10d82bc4-966e-46cb-a0f7-0a3b80eb8d5c', '12014', '客户明细报表', '/system/report/customer/detail', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', 'b44cbf2b-2c7f-43bf-a210-cc918955a6af', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cd314159-e34e-421b-9bf2-5d7d84cd7abd', '11140', '参数设置', '/system/terminal/param', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'd0d85866-c2d3-4d99-8b63-7021c51471e6', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('31040353-de84-442d-acc4-0bf3eca5f747', '11141', '白名单管理', '/system/terminal/blank', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'd0d85866-c2d3-4d99-8b63-7021c51471e6', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5795748c-ddd1-4da6-a72c-6e88b7ag2d7f', '05073', '发票统计', '/system/toll/invoice/total', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '28b9906a-2e4c-4a0a-bffd-f778085b5f15', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('fb5231d8-dce9-4411-a707-d9e6dd0cefdf', '12083', '补气明细报表', '/system/statistics/ICCard/supplyGasReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '272370e3-a0b7-417a-a94e-42b552666d57', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ded1fb78-b172-4479-b173-2700b3bb2a63', '11145', '版本管理', '/system/terminal/version', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'd0d85866-c2d3-4d99-8b63-7021c51471e6', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5795748c-ddd1-4da6-a72c-7e88b7a12d7f', '05072', '发票列表', '/system/toll/invoice', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '28b9906a-2e4c-4a0a-bffd-f778085b5f15', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('08fcec80-ba55-4f07-b2d3-ac0da94c1e51', '12081', '开卡明细报表', '/system/statistics/ICCard/activateCardReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '272370e3-a0b7-417a-a94e-42b552666d57', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('43455bb5-fb0f-4375-bbda-cba51e55e31c', '05071', '发票设置', '/system/finance/invoiceSetting/detail?id=1', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '28b9906a-2e4c-4a0a-bffd-f778085b5f15', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b7b7ec6f-ea82-4e02-87d2-c334dbae9984', '12031', '抄表数据统计', '/system/measure/statistics/bookletdatadetails', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '6db09e44-cdd0-4571-b72d-311286ee5405', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('df4a6113-2b2c-4ead-a87b-d03a803a4610', '03042', '启用表具', '/system/measure/meter/enable', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', '963ecb71-4943-4dfe-9b39-0aba1bbc14f8', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c399f330-3830-4fc6-b812-174b2fe28e35', '05051', '远传表抄表', '/system/measure/remote/meterList', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', 'd04b9c6f-43cb-4b38-a49b-5930aeb929c7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6fa9a2b9-6238-487c-a468-e46d2989dccd', '08012', '新增维修申请', '/system/maintenance/goForm', 'a7c8cbf2-0b3b-4b4b-822e-c037d7442e05', 'b5162b25-1e87-40ee-9fc8-d485f11ee360', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d9ad5c96-f0cb-4895-b5f6-79190bce6aae', '0611', '根据安检员查询', '/system/check/yearCheckPlan/searchByChecker', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'cee717c6-c80d-4e47-abd9-fa5603a6385e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('69435c36-d376-47a6-9f37-b27a1d03be94', '0613', '根据月份查询', '/system/check/yearCheckPlan/byMonth', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'cee717c6-c80d-4e47-abd9-fa5603a6385e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d27e818d-c694-47f6-a98f-cea2c71e7b83', '10301', '知识库查询', '/system/monitoring/knowledge', '48028c40-2278-4ce6-ae63-6a0e0a48288d', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9e44ea81-ac35-40f1-91d8-590dcf43454e', '09041', '工单类型', '/system/base/workOrderType', '9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '0d22ba2e-82f7-4896-bd1b-36f20bc7c393', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b2977ae3-3b93-4cea-85f9-6eab6496bf78', '09073', '安检内容', '/system/base/securityCheckContent', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'c51143b5-b1f3-4616-a1a7-d1ea52a94f39', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('494ec394-69bc-49fc-9894-39630d1458a8', '03021', '收费列表', '/system/toll/counterCharge', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', 'b9978d89-15ee-40bb-8607-5ad6c030ea74', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('93ebfdbd-885c-40d1-a9f6-963c77ebbf19', '01122', '短信列表', '/system/business/smsInfo', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'e457bba3-b199-411d-9a12-77027a5d3e89', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('fc1756e7-a9b4-4fed-95c0-2c7333f2c32d', '1402', '执行记录', '/system/scheduleLog', '69a0b25c-ebe6-4494-a000-6549715ae1da', 'e0199a12-3097-4b31-ab3e-a5005c1c4de7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('8f53017a-4c68-456e-9a36-dafe0f371cbf', '11031', '版本发布', '/system/app/release/form', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', '3ea895a2-6fcd-4f82-a367-02a113b8ca40', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5fd62254-7d95-4056-b024-08361d748021', '05052', '远传表报警', '/system/measure/remote/alertList', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', 'd04b9c6f-43cb-4b38-a49b-5930aeb929c7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('3ea895a2-6fcd-4f82-a367-02a113b8ca40', '1103', '版本管理', NULL, '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('25316462-759a-4bef-a2c9-490fd7cc5aa4', '03064', '减免执行', '/system/toll/penaltyRelief/reliefList', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '13cf7bcf-cf26-42ec-8ad8-52e843ef1b23', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('bcebc0f5-04dc-4675-a2ab-7c602e3ef35c', '03071', '后付款催费', '/system/toll/pressCharge/gasList', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', 'd7c706dc-979b-4bb8-9593-8c8c6e40b339', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4b4a9ae9-b163-4e58-87b5-6970100a94df', '03072', '预存款催费', '/system/toll/pressCharge/prePayList', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', 'd7c706dc-979b-4bb8-9593-8c8c6e40b339', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('2105f9fd-b5e1-4678-9aa6-02267870afa2', '05034', '取消充值', '/system/business/cancelRecharge/list', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '260c1374-4758-4871-b9d9-293711848a58', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('097f7761-b72a-45c7-a89e-d2f87134133f', '05035', '补气', '/system/business/supplyGas', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '260c1374-4758-4871-b9d9-293711848a58', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b9e5f6aa-a6ce-42be-a9f4-0cd5fde20132', '05036', '清卡', '/system/business/clearCard', 'f6dec355-8ff8-4876-80af-9c672b2c5f91', '260c1374-4758-4871-b9d9-293711848a58', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('792294a2-930f-43f8-bba9-2a5f8300108e', '0309', '收费交接', NULL, '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6ccade4f-0cbb-4124-9176-269504cfb3df', '0211', '购气管理', NULL, '075c3787-0535-46bb-b29e-0f09284cab55', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '0106', 'IC卡管理', NULL, 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('2e2129e6-d82a-4408-8d6a-c068da214d0f', '010807', 'IC卡数据调整', '/system/business/cardAdjust', 'a426cc37-99fd-4649-ae22-33db546dbb40', '18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9a630483-5b88-4a3e-9f1e-3a60b9f74f33', '98153', '气表型号', '/system/base/gasMeterModel', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', 'f2d5203c-0b81-478c-84a9-e7af41adce04', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6a141139-4970-46d5-b438-ed448303c9dd', '0612', '根据年份查询', '/system/check/yearCheckPlan/byYear', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'cee717c6-c80d-4e47-abd9-fa5603a6385e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0692c3bc-d07f-4cd7-8f8b-52bfd0a50098', '0614', '根据管理区域查询', '/system/check/yearCheckPlan/byArea', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'cee717c6-c80d-4e47-abd9-fa5603a6385e', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('a389fdf7-a96b-4f8f-8080-a22ad1d8741f', '14001', '任务列表', '/system/schedule', '69a0b25c-ebe6-4494-a000-6549715ae1da', 'e0199a12-3097-4b31-ab3e-a5005c1c4de7', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('68e65d93-7fa4-472b-8563-d28399f2e2db', '07032', '类型设置', '/system/install/installtype', '90532a41-0fea-406b-b444-67c64a475754', '158f5799-be7f-44d8-a539-a7e29c4f87ad', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9c58a5e3-fbfb-490d-bd45-dbbe27fa2d97', '9822', '审批设置', '/system/base/needSetting/list', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('57b5a47d-91c1-4564-afd8-99f1db851b76', '9999', '隐患级别', '/system/check/dangeLevel', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'c51143b5-b1f3-4616-a1a7-d1ea52a94f39', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d2fd70ae-718c-4ec6-b6a1-5b15accfb2c1', '01123', '短信模板', '/system/business/smsTemplate', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'e457bba3-b199-411d-9a12-77027a5d3e89', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('bc6c0ef9-1fa9-476b-8d44-fe15e6f36afa', '98152', '气表类型', '/system/base/gasMeterType', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', 'f2d5203c-0b81-478c-84a9-e7af41adce04', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7ceabd22-0b1d-45c5-b5ac-dcbc96b38311', '9825', '安装位置', '/system/base/installLocation', 'f18cdc62-c467-4574-b16a-6954def4bc27', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('49407baf-3fe5-400a-8b85-921c4b217438', '0303', '换表管理', '/system/measure/changeMeter/list', '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cd5e1b44-601a-43d5-bba9-c5e51de4f139', '09071', '安检项', '/system/base/securityCheckItem', '9dd8bedf-8ff8-49be-bba7-c23a798238fc', 'c51143b5-b1f3-4616-a1a7-d1ea52a94f39', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cdb707a7-a740-4078-a2c3-ac3d5d53efdc', '03101', '应收费查询', NULL, '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('a2500f4f-fd8b-49bb-b8b1-a8f9f67c8355', '02111', '购气管理', '/system/measure/buyGas', '075c3787-0535-46bb-b29e-0f09284cab55', '6ccade4f-0cbb-4124-9176-269504cfb3df', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4f2bf4aa-2d10-4c04-aac2-8ef95fd49758', '09032', '工单类型统计', '/system/workOrder/countWorkOrderByType', '9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '3c8f2ee0-4419-4fa1-8b0b-38a864439f39', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c51143b5-b1f3-4616-a1a7-d1ea52a94f39', '0607', '安检参数设置', NULL, '9dd8bedf-8ff8-49be-bba7-c23a798238fc', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0b144965-75c4-43de-8aa1-f94c1bb1a0a7', '010808', '特殊客户补贴', '/system/business/poorSubsidy', 'a426cc37-99fd-4649-ae22-33db546dbb40', '18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('1d7bfa2f-0234-44c1-b50c-d8a887bb2373', '10302', '知识库设计', '/system/monitoring/knowledge/typelist', '48028c40-2278-4ce6-ae63-6a0e0a48288d', 'd27e818d-c694-47f6-a98f-cea2c71e7b83', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('a18558b3-c7c7-4640-a10e-895b279c7fe9', '010809', 'IC卡参数设置', '/system/base/icParam', 'a426cc37-99fd-4649-ae22-33db546dbb40', '18d2bb3c-40c4-4c0f-9821-b9e7458fb3f4', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('3be9c6f1-fbfa-4e8e-9720-badf0fa79e7c', '04072', '支付宝配置', '/system/finance/aliPay', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', 'cf4383f4-ccdb-46a4-a4af-98a092ae45d6', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c9748997-5112-4283-859a-f03da48c1184', '02062', '气量调整审核', '/system/measure/gasadjust/adjustauditlist', '075c3787-0535-46bb-b29e-0f09284cab55', '9e987721-09e2-4439-b980-5c18e0aa27ba', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e7c60ed5-7dda-4255-9b08-131e397b52e8', '02033', '抄表数据列表', '/system/measure/meterdatarecord/recorddatalist', '075c3787-0535-46bb-b29e-0f09284cab55', 'a45ff64d-a0e9-4c75-acfe-f97f627e9c7b', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e7284a4a-ad69-4864-97fe-44d6a2c0440e', '08034', '维修类型设置', '/system/base/maintenanceType', 'a7c8cbf2-0b3b-4b4b-822e-c037d7442e05', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e5fa2f6b-cd99-4f47-b66e-5b89d72446b3', '0208', '位置和轨迹', '/system/measure/meteringguylocation', '075c3787-0535-46bb-b29e-0f09284cab55', '#', '1', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e5fa2f6b-cd99-4f47-b66e-5b89d72446b4', '0208', '远传表抄表', '/system/measure/remote/meterList', '075c3787-0535-46bb-b29e-0f09284cab55', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('49gec394-69cc-4rfc-9894-39630d3458a8', '03022', '本人收费列表', '/system/toll/counterCharge/person', '1211bfe3-a4c0-43ce-bb44-94f3de3dc639', 'b9978d89-15ee-40bb-8607-5ad6c030ea74', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('4614ae56-4967-429b-a7a0-e79425245093', '02024', '抄表查询', '/system/measure/statistics/status', '075c3787-0535-46bb-b29e-0f09284cab55', '6d04cca9-5d5e-472f-8de6-9ca42c7709b1', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cc8b0c20-f114-402b-890b-6dbd3c1191d2', '1112', '燃气助', NULL, '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b70e15a3-27f4-401e-b09c-771ef026f108', '1113', '燃气宝', NULL, '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d0d85866-c2d3-4d99-8b63-7021c51471e6', '1114', '自助终端', NULL, '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('10fa18b9-7983-4916-bded-6645ca52a358', '1115', '微信公众号', NULL, '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6380b75c-e90e-49dc-96b2-25023e82fc78', '11131', '参数设置', '/system/app/info', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'b70e15a3-27f4-401e-b09c-771ef026f108', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('891837a8-197b-45fc-bc8b-e56aa834798c', '11121', '新增通知', '/system/app/notice/form', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'cc8b0c20-f114-402b-890b-6dbd3c1191d2', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7aefaca2-43fd-4cac-8cdf-ff82899d1209', '11122', '通知列表', '/system/app/notice/list', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'cc8b0c20-f114-402b-890b-6dbd3c1191d2', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c91c24e6-ed4c-4768-92ad-103a3085be31', '11132', '客户反馈', '/system/app/feedbacks', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'b70e15a3-27f4-401e-b09c-771ef026f108', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5735ce89-02ab-47ef-b1b8-51e2d30f3419', '0120', '限购管理', '/system/customer/meterLimit/limitBatch', 'a426cc37-99fd-4649-ae22-33db546dbb40', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5356ec78-ce12-4218-897a-bb11d292048b', '0508', '票据模板', '/system/finance/ticketTemplate', 'c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('1431d86c-b8cf-4e2f-98b7-fecdddfb9ddc', '1201', '用户表具统计', 'https://www.baidu.com/', '7b6151a2-33ca-462f-9635-00141d0edb2e', '#', NULL, NULL);
INSERT INTO `SYS_MODULE` VALUES ('3fb21a36-77ec-4c7c-8bbc-800a6badbb23', '12011', '用气类型', '/system/report/customer/gasTypeAndMeterType', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', 'b44cbf2b-2c7f-43bf-a210-cc918955a6af', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b44cbf2b-2c7f-43bf-a210-cc918955a6af', '1201', '客户统计', '/system/report/customer/page/list', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('44ad7292-4f70-4ea1-a058-ec4a1b8ad9b8', '12012', '管理区域', '/system/report/customer/areaAndMeterType', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', 'b44cbf2b-2c7f-43bf-a210-cc918955a6af', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('02b051ea-0a52-48e6-b703-b095e3e97c50', '12013', '分公司', '/system/report/customer/orgAndMeterType', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', 'b44cbf2b-2c7f-43bf-a210-cc918955a6af', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('588bd431-7c49-45a8-970b-9e4fbd3629ea', '1202', '表具统计', '/system/report/meter/page/list', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6db09e44-cdd0-4571-b72d-311286ee5405', '1203', '抄表统计', NULL, 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('dbab5438-85bb-4fd5-95e4-17af4881fb99', '01041', '分户', '/module/customer/gasMeterTransfer.jsp', 'a426cc37-99fd-4649-ae22-33db546dbb40', '0744b379-80a7-43b4-90ce-1e04331c8d20', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e556e23d-5512-41bc-a7bc-d6b568073067', '0301', '库存管理', NULL, '93b4a1f0-37f7-421f-9ab2-134ebf406ad6', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('9954375e-7827-4c81-820b-6d4f517d4542', '0803', '维修申请统计', '/system/maintenance/statistics', 'a7c8cbf2-0b3b-4b4b-822e-c037d7442e05', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('40ff307f-99d9-48f2-a57d-64ec96020275', '1100', '收款统计', NULL, 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('cb61904a-cc4f-47ab-827e-1dbfe5ed26a0', '1204', '回款欠款统计', NULL, 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c16acab5-b19e-4519-9215-6acfcfaf5347', '12041', '气款回收月报', '/system/statistics/gasCharge/paymentMonthReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', 'cb61904a-cc4f-47ab-827e-1dbfe5ed26a0', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('8b3ba268-6b14-42a4-b7a5-34a40cabc7ab', '12042', '用气性质欠款月报', '/system/statistics/gasCharge/arrearageMonthReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', 'cb61904a-cc4f-47ab-827e-1dbfe5ed26a0', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('5798944b-ce4a-49f1-86b2-d946cb8e54d0', '0704', '报装改造统计', NULL, '90532a41-0fea-406b-b444-67c64a475754', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('ef247ddf-e6c4-4e83-af43-b0789623dad7', '1205', '预存款统计', NULL, 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('d421f24e-b731-4894-b98c-18e9d1e132eb', '07041', '申请状态统计', '/system/install/statistics/statusList', '90532a41-0fea-406b-b444-67c64a475754', '5798944b-ce4a-49f1-86b2-d946cb8e54d0', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7d19c5ca-e00b-4a9c-9d65-7618298e29b2', '11134', '位置记录', '/system/app/areaList', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'cc8b0c20-f114-402b-890b-6dbd3c1191d2', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('c5762a85-0cf0-44ea-b1f8-91d94cfb834e', '11135', '订单查询', '/system/app/order/list', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'cc8b0c20-f114-402b-890b-6dbd3c1191d2', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('29ca891f-695b-49cd-af37-892a2229afb1', '11136', '订单处理', '/system/app/order/action', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'cc8b0c20-f114-402b-890b-6dbd3c1191d2', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('58fcc0d2-b04d-4c13-8f09-25b4b64bc895', '11135', '用户统计', '/system/app/user/activeForAreas', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'b70e15a3-27f4-401e-b09c-771ef026f108', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('88315ab8-87d7-4ace-bb59-808e05b88435', '12082', '补卡明细报表', '/system/statistics/ICCard/supplementCardReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '272370e3-a0b7-417a-a94e-42b552666d57', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6a4cd60e-e920-4807-85d5-f420f0a3642b', '11133', '客户帮助', '/system/app/helps', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'b70e15a3-27f4-401e-b09c-771ef026f108', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('da42b7e1-6b14-4859-81fb-6d9cb01dc697', '11133', '上传参数设置', '/system/app/areaData', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'cc8b0c20-f114-402b-890b-6dbd3c1191d2', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7017b5b4-8758-40b9-afa2-7df14e2807f0', '11134', '用户查询', '/system/app/user/list', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'b70e15a3-27f4-401e-b09c-771ef026f108', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('6bda8a3a-2613-47fa-9c9f-dda338af6dc6', '11137', '商品设置', '/system/app/wares', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'b70e15a3-27f4-401e-b09c-771ef026f108', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b2508cde-24e2-4e00-8726-a7ff763cb4ad', '11142', '公告管理', '/system/terminal/notice', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'd0d85866-c2d3-4d99-8b63-7021c51471e6', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('b99e1dc2-a678-4c9a-8146-a76683b95b66', '11143', '缴费管理', '/system/terminal/toll', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'd0d85866-c2d3-4d99-8b63-7021c51471e6', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('2aca1b7e-eb71-44a0-9f3b-e80c968fcc9b', '11144', '背景图片管理', '/system/terminal/background', '8ede74b4-6ed2-4ba9-8c32-038d74d158ce', 'd0d85866-c2d3-4d99-8b63-7021c51471e6', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('bada99bc-7a67-4260-a640-547d801b07a0', '9999', '管理员信息', '/system/base/superPhone', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('e63b7aa3-3ae6-41b4-b034-751b285d4360', '15', '数据库清库', '/system/dbClean/dbList', '69a0b25c-ebe6-4494-a000-6549715ae1da', '#', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('fb805c1c-f51e-4e0e-bf1c-b0434f4561e2', '12086', 'IC卡气量报表', '/system/statistics/ICCard', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '272370e3-a0b7-417a-a94e-42b552666d57', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('1c48db59-0d0a-4c3f-b504-7865fe9849fc', '12085', 'IC卡充值售气明细报表', '/system/statistics/ICCard/icDetailReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '272370e3-a0b7-417a-a94e-42b552666d57', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('8494074f-822f-4d2c-9932-e75705710dc2', '12087', 'IC卡客户智能查询', '/system/statistics/ICCard/analyseReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '272370e3-a0b7-417a-a94e-42b552666d57', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('72d0c01a-f3da-11e9-a2b1-0235d2b38928', '01011', '地址列表', '/system/archives/newAddress/list', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'd6169156-e753-4d37-914f-ea04eea08e70', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('7ab5d090-f3da-11e9-a2b1-0235d2b38928', '01012', '普通建址', '/system/archives/newAddress/form', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'd6169156-e753-4d37-914f-ea04eea08e70', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('0f31c25f-8f35-4f65-8d5e-6124b32a5deb', '01013', '批量建址', '/system/customer/building/newForm', 'a426cc37-99fd-4649-ae22-33db546dbb40', 'd6169156-e753-4d37-914f-ea04eea08e70', '0', NULL);
INSERT INTO `SYS_MODULE` VALUES ('3ef05748-54aa-4cdb-a017-e2429a7b2897', '12084', '开卡汇总报表', '/system/statistics/ICCard/activateCardCollectReport', 'e2d5bd9a-857f-4062-832d-70e41eb9c540', '272370e3-a0b7-417a-a94e-42b552666d57', '0', NULL);

-- ----------------------------
-- Table structure for SYS_MODULEGROUP
-- ----------------------------
DROP TABLE IF EXISTS `SYS_MODULEGROUP`;
CREATE TABLE `SYS_MODULEGROUP`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IMG_PATH` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_MODULEGROUP
-- ----------------------------
INSERT INTO `SYS_MODULEGROUP` VALUES ('69a0b25c-ebe6-4494-a000-6549715ae1da', '99', '系统管理', '/lib-internal/frame/images/nav-xitong.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('90532a41-0fea-406b-b444-67c64a475754', '07', '报装改造', '/lib-internal/frame/images/nav-baozhuang.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('f18cdc62-c467-4574-b16a-6954def4bc27', '98', '基础数据', '/lib-internal/frame/images/nav-shuju.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('9dd8bedf-8ff8-49be-bba7-c23a798238fc', '06', '安检管理', '/lib-internal/frame/images/nav-anjian.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('1211bfe3-a4c0-43ce-bb44-94f3de3dc639', '04', '收费管理', '/lib-internal/frame/images/nav-shoufei.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('c27a42af-6fd2-4bc0-b442-b3edc48aab8c', '05', '财务管理', '/lib-internal/frame/images/nav-caiwu.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('a426cc37-99fd-4649-ae22-33db546dbb40', '01', '客户管理', '/lib-internal/frame/images/nav-dangan.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('93b4a1f0-37f7-421f-9ab2-134ebf406ad6', '03', '表具管理', '/lib-internal/frame/images/nav-biaoju.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('075c3787-0535-46bb-b29e-0f09284cab55', '02', '抄表计量', '/lib-internal/frame/images/nav-chaobiao.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('a7c8cbf2-0b3b-4b4b-822e-c037d7442e05', '08', '维修管理', '/lib-internal/frame/images/nav-weixiu.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('9e87f6eb-ecdb-4bb3-8a9b-d7ef01f7d861', '09', '工单管理', '/lib-internal/frame/images/nav-gongdan.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('48028c40-2278-4ce6-ae63-6a0e0a48288d', '10', '呼叫支持', '/lib-internal/frame/images/nav-jiankong.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('8ede74b4-6ed2-4ba9-8c32-038d74d158ce', '11', '终端管理', '/lib-internal/frame/images/nav-kefu.png');
INSERT INTO `SYS_MODULEGROUP` VALUES ('e2d5bd9a-857f-4062-832d-70e41eb9c540', '12', '统计分析', '/lib-internal/frame/images/nav-tongji.png');

-- ----------------------------
-- Table structure for SYS_NOTIFICATION
-- ----------------------------
DROP TABLE IF EXISTS `SYS_NOTIFICATION`;
CREATE TABLE `SYS_NOTIFICATION`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `level` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TEXT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `USERID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `RECEIVEDATE` datetime(0) NOT NULL,
  `READFLAG` decimal(65, 30) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_NOTIFICATION
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_OPERATION
-- ----------------------------
DROP TABLE IF EXISTS `SYS_OPERATION`;
CREATE TABLE `SYS_OPERATION`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_OPERATION
-- ----------------------------
INSERT INTO `SYS_OPERATION` VALUES ('common.write', '公共填写');
INSERT INTO `SYS_OPERATION` VALUES ('common.read', '公共读取');

-- ----------------------------
-- Table structure for SYS_OPERATOR
-- ----------------------------
DROP TABLE IF EXISTS `SYS_OPERATOR`;
CREATE TABLE `SYS_OPERATOR`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NAME` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PHONE` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `WORKTYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STATE` decimal(65, 30) NULL DEFAULT NULL,
  `INSIDE` decimal(65, 30) NULL DEFAULT NULL,
  `HIREDATE` datetime(0) NULL DEFAULT NULL,
  `DEPARTURE_TIME` datetime(0) NULL DEFAULT NULL,
  `CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_OPERATOR
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_ORG
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ORG`;
CREATE TABLE `SYS_ORG`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `SUBTYPEID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PIDS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `CREATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATE_DATE` datetime(0) NULL DEFAULT NULL,
  `UPDATE_BY` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `UPDATE_DATE` datetime(0) NULL DEFAULT NULL,
  `ORG_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `COMPANYID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_ORG
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_PARMA
-- ----------------------------
DROP TABLE IF EXISTS `SYS_PARMA`;
CREATE TABLE `SYS_PARMA`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PARMA_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PARMA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PARMA_VAL` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PARMA_COMMENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_PARMA
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_PHOTO_INFO
-- ----------------------------
DROP TABLE IF EXISTS `SYS_PHOTO_INFO`;
CREATE TABLE `SYS_PHOTO_INFO`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_PHOTO_INFO
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_POSITION
-- ----------------------------
DROP TABLE IF EXISTS `SYS_POSITION`;
CREATE TABLE `SYS_POSITION`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DESCRIPTION` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_POSITION
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_POSITION_USER_MAPPING
-- ----------------------------
DROP TABLE IF EXISTS `SYS_POSITION_USER_MAPPING`;
CREATE TABLE `SYS_POSITION_USER_MAPPING`  (
  `POSITIONID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USERID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_POSITION_USER_MAPPING
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_REQUEST
-- ----------------------------
DROP TABLE IF EXISTS `SYS_REQUEST`;
CREATE TABLE `SYS_REQUEST`  (
  `METHOD` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `URL` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `OPERATIONID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_REQUEST
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_ROLE
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ROLE`;
CREATE TABLE `SYS_ROLE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `NAME` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_ROLE
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_ROLE_BUTTON
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ROLE_BUTTON`;
CREATE TABLE `SYS_ROLE_BUTTON`  (
  `ROLE_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `BUTTON_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_ROLE_BUTTON
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_ROLE_MODULE_MAPPING
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ROLE_MODULE_MAPPING`;
CREATE TABLE `SYS_ROLE_MODULE_MAPPING`  (
  `ROLEID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MODULEID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_ROLE_MODULE_MAPPING
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_ROLE_OPERATION_MAPPING
-- ----------------------------
DROP TABLE IF EXISTS `SYS_ROLE_OPERATION_MAPPING`;
CREATE TABLE `SYS_ROLE_OPERATION_MAPPING`  (
  `ROLEID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `OPERATIONID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_ROLE_OPERATION_MAPPING
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_SHADOW
-- ----------------------------
DROP TABLE IF EXISTS `SYS_SHADOW`;
CREATE TABLE `SYS_SHADOW`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'uuid',
  `TABLE_FROM` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表来源',
  `DATA_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据ID',
  `DATA_ACTION` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据动作:add|update|delete',
  `ACTION_TIME` datetime(0) NULL DEFAULT NULL COMMENT '动作时间',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_SHADOW
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_SMS_SETTINGS
-- ----------------------------
DROP TABLE IF EXISTS `SYS_SMS_SETTINGS`;
CREATE TABLE `SYS_SMS_SETTINGS`  (
  `USERNAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `PASSWORD` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `SIGN` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '短信签名',
  `CODE_GWID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '验证码类网关通道id',
  `NOTICE_GWID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '通知类网关通道id',
  `MARKETING_GWID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营销类网关通道id'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_SMS_SETTINGS
-- ----------------------------
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES ('qciot', 'qciot', '秦川物联', '52472873', '4ae3df51', NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `SYS_SMS_SETTINGS` VALUES (NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for SYS_USER
-- ----------------------------
DROP TABLE IF EXISTS `SYS_USER`;
CREATE TABLE `SYS_USER`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USERNAME` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `PASSWORD` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `ENABLED` decimal(65, 30) NOT NULL COMMENT '启用状态:0-未启用，1-启用',
  `ACCOUNTEXPIRED` decimal(65, 30) NOT NULL COMMENT '账户过期:0-未过期，1-过期',
  `CREDENTIALSEXPIRED` decimal(65, 30) NOT NULL COMMENT '凭证过期:0-未过期，1-过期',
  `ACCOUNTLOCKED` decimal(65, 30) NOT NULL COMMENT '账户锁定:0-未锁定，1-锁定',
  `NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '姓名',
  `GENDER` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '性别',
  `PHONE` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '电话',
  `EMERGENCYPHONE` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '紧急联系号码',
  `BIRTHDAY` datetime(0) NULL DEFAULT NULL COMMENT '出生日期',
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ORGID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `EMPLOYEE_CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '员工编号',
  `MONEY` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '金额上限'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_USER
-- ----------------------------
INSERT INTO `SYS_USER` VALUES ('f5db85ff-0ef8-451d-b86b-37de2116608f', 'super', 'fe0aa018d55ab95ea022403a8abbd9d2556ad5b16030da505318bed62031649274ac8872d3e9f316', 1.000000000000000000000000000000, 0.000000000000000000000000000000, 0.000000000000000000000000000000, 0.000000000000000000000000000000, '系统管理员', '1', '13088012814', '1390909090', NULL, 'yaojm', NULL, 'YGBH0002', NULL);

-- ----------------------------
-- Table structure for SYS_USER_MENU
-- ----------------------------
DROP TABLE IF EXISTS `SYS_USER_MENU`;
CREATE TABLE `SYS_USER_MENU`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `USER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MENU_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MENU_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MENU_URL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_USER_MENU
-- ----------------------------

-- ----------------------------
-- Table structure for SYS_USER_ROLE_MAPPING
-- ----------------------------
DROP TABLE IF EXISTS `SYS_USER_ROLE_MAPPING`;
CREATE TABLE `SYS_USER_ROLE_MAPPING`  (
  `USERID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ROLEID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of SYS_USER_ROLE_MAPPING
-- ----------------------------

-- ----------------------------
-- Table structure for TASK_WAITING_TASK
-- ----------------------------
DROP TABLE IF EXISTS `TASK_WAITING_TASK`;
CREATE TABLE `TASK_WAITING_TASK`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TASK_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务类型,对应字典taskType',
  `TASK_URL` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务对应url',
  `CREATE_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人id',
  `CREATE_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `CREATE_DATETIME` datetime(0) NOT NULL COMMENT '创建时间',
  `HANDLE_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理人id',
  `HANDLE_EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '处理人',
  `IS_TIP` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否提示，0：未提示，1：已经提示',
  `IS_READ` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否查看',
  `READ_DATETIME` datetime(0) NULL DEFAULT NULL COMMENT '查看时间',
  `ORIGIN_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '来源数据ID（如：退费管理某条记录的ID）',
  UNIQUE INDEX `SYS_C0015658`(`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TASK_WAITING_TASK
-- ----------------------------

-- ----------------------------
-- Table structure for TERMINAL_BLANK
-- ----------------------------
DROP TABLE IF EXISTS `TERMINAL_BLANK`;
CREATE TABLE `TERMINAL_BLANK`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IMEI_NO` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'IMEI号',
  `SN_NO` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '读卡器SN',
  `TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '终端类型',
  `ADDRESS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `CREATOR_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `CREATOR_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人编号',
  `CREATE_DATETIME` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `STATUS` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否禁用：0禁用；1启用',
  `REMARK` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `ACCOUNT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'dbUser',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TERMINAL_BLANK
-- ----------------------------

-- ----------------------------
-- Table structure for TERMINAL_NOTICE
-- ----------------------------
DROP TABLE IF EXISTS `TERMINAL_NOTICE`;
CREATE TABLE `TERMINAL_NOTICE`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TITLE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '通知标题',
  `CONTENT` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '通知内容',
  `CREATE_TIME` datetime(0) NULL DEFAULT NULL COMMENT '通知时间',
  `CREATE_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人id',
  `CREATE_ORG_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发布部门id',
  `STATE` decimal(2, 0) NOT NULL COMMENT '通知状态:0-停播，1-开播',
  `CREATE_USER` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '创建人',
  `CREATE_ORG` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '发布部门',
  `PUBLISH_TIME` datetime(0) NULL DEFAULT NULL COMMENT '发布时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TERMINAL_NOTICE
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_CHARGE_METER
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_CHARGE_METER`;
CREATE TABLE `TOLL_CHARGE_METER`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `METER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `METER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHARGE_MONEY` decimal(11, 2) NOT NULL,
  `CHARGE_DATETIME` datetime(0) NOT NULL,
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `COUNTER_CHARGE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHARGE_TIME` decimal(11, 0) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_CHARGE_METER
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_CHARGE_SETTING
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_CHARGE_SETTING`;
CREATE TABLE `TOLL_CHARGE_SETTING`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BUSINESS_CHARGE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MONEY` decimal(38, 2) NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `START_DATE` datetime(0) NOT NULL,
  `END_DATE` datetime(0) NOT NULL,
  `CHARGE_CIRCLE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `SETTING_DATETIME` datetime(0) NOT NULL,
  `REMARK` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TASK_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TASK_DATETIME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `IS_CUSTOMER_CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否为单个客户：0行政区域；1单个客户',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_CHARGE_SETTING
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_CHARGE_TRANSFER
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_CHARGE_TRANSFER`;
CREATE TABLE `TOLL_CHARGE_TRANSFER`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRANSFER_DATETIME` datetime(0) NOT NULL,
  `HANDLER_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `HANDLER_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `RECEIVER_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `RECEIVER_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MONEY` decimal(38, 2) NOT NULL,
  `REMARK` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_CHARGE_TRANSFER
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_CHARGE_TRANSFER_REMOTE
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_CHARGE_TRANSFER_REMOTE`;
CREATE TABLE `TOLL_CHARGE_TRANSFER_REMOTE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `TRANSFER_DATETIME` datetime(0) NOT NULL,
  `HANDLER_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `HANDLER_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `RECEIVER_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `RECEIVER_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MONEY` decimal(38, 2) NOT NULL,
  `REMARK` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_DATETIME` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_CHARGE_TRANSFER_REMOTE
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_CORRECTION_MANAGE
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_CORRECTION_MANAGE`;
CREATE TABLE `TOLL_CORRECTION_MANAGE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PAY_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MONEY` decimal(38, 2) NOT NULL,
  `CORRECTION_DATETIME` datetime(0) NOT NULL,
  `EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHARGE_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_CORRECTION_MANAGE
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_COUNTER_CHARGE
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_COUNTER_CHARGE`;
CREATE TABLE `TOLL_COUNTER_CHARGE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户编号',
  `GAS_TICKET_BOOK` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '气票票本',
  `GAS_TICKET_CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '气票票号',
  `PRESTORE_TICKET_BOOK` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预存票本',
  `PRESTORE_TICKET_CODE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预存票号',
  `IS_PRINT` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '0：未打印；1：打印发票；2：打印收据',
  `CHARGE_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '费用类型',
  `CHARGE_DATETIME` datetime(0) NULL DEFAULT NULL COMMENT '收费日期',
  `EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收费员名称',
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收费员编号',
  `RECEIVABLE_RECORD_CODE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '收费依据编号',
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '-1：当天冲正  0：当天收费    1：退费申请中    2：退费完成   3：调账申请中    4：调账完成   5：已交接',
  `CHARGE_DATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '费用年月',
  `PAY_ORDER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付宝、微信订单号',
  `CHARGE_TRANSFER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交接编号',
  `TOTAL_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '合计金额',
  `PRE_DEPOSIT_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '预存款扣除金额',
  `RECEIVABLE_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '应收金额',
  `PAYABLE_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '实付金额',
  `RETURN_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '找零金额',
  `END_NUMBER` decimal(11, 2) NULL DEFAULT NULL COMMENT '结尾数',
  `UNPAYABLE_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '未付金额',
  `RECEIVED_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '实收金额',
  `GAS_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '气费',
  `BUSINESS_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '业务费',
  `PRE_PAY_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '表具充值金额',
  `ADD_PRE_DEPOSIT_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '预存款',
  `BAIL_MONEY` decimal(11, 2) NULL DEFAULT NULL COMMENT '保证金',
  `PRE_PAY_NO` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表具充值表身号',
  `TICKET_TEMPLATE_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '票据模板编号',
  `ADMINISTRATIVE_AREA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域名称',
  `ADMINISTRATIVE_AREA_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域编号',
  `AFFILIATED_BUSINESS_HALL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业厅名称',
  `AFFILIATED_BUSINESS_HALL_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业厅编号',
  `PAY_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `PAY_TYPE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式编号',
  `GAS_NUM` decimal(11, 2) NULL DEFAULT NULL COMMENT '气量',
  `EMPLOYEE_DEPT_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费员所属部门名称',
  `EMPLOYEE_DEPT_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费员所属部门ID',
  `INVOICE_URL` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '电子发票链接',
  `SERVICE_CHARGE` decimal(11, 2) NULL DEFAULT NULL COMMENT '手续费',
  `PRE_PAY_NUM` decimal(11, 2) NULL DEFAULT NULL COMMENT '表具充值气量',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '      ' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_COUNTER_CHARGE
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_CUSTOMER_SUBSIDY
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_CUSTOMER_SUBSIDY`;
CREATE TABLE `TOLL_CUSTOMER_SUBSIDY`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `SUBSIDY_YEAR` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `SUBSIDY_MONEY` decimal(38, 2) NOT NULL,
  `CREATE_DATETIME` datetime(0) NOT NULL,
  `EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PAY_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_CUSTOMER_SUBSIDY
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_CUSTOMER_TRANSFER
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_CUSTOMER_TRANSFER`;
CREATE TABLE `TOLL_CUSTOMER_TRANSFER`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `APPLICABLE_MONEY` decimal(38, 2) NOT NULL,
  `RELIEF_MONEY` decimal(38, 2) NOT NULL,
  `CHARGE_DATE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `RECEIVABLE_GAS_MONEY` decimal(38, 2) NOT NULL,
  `CREATE_DATETIME` datetime(0) NOT NULL,
  `CREATE_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_DATETIME` datetime(0) NULL DEFAULT NULL,
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REFUND_MANAGE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PAY_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHARGE_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_CUSTOMER_TRANSFER
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_INVOICE
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_INVOICE`;
CREATE TABLE `TOLL_INVOICE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户Code',
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户名称',
  `TAXPAYER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收款方纳税人税号',
  `TAXPAYER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收款方纳税人名称',
  `DOWNLOAD_URL` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '载XML格式文件便于导入电商平台或财务系统中',
  `VIEW_URL` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '查看URL',
  `PDF_UNSIGNED_URL` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '未签名PDF下载URL',
  `DRAWER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '开票人',
  `FISCAL_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '税控码',
  `GENERATE_TIME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '开票时间',
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发票状态',
  `NO_TAX_AMOUNT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '不含税金额',
  `TAX_AMOUNT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '税额',
  `AMOUNT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发票总金额',
  `VALID_REASON` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作废/红冲原因',
  `VALID_TIME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作废/红冲时间',
  `RELATED_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联发票编号',
  `REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收费员Code',
  `EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '收费员名字',
  `GAS_ADDRESS` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用气地址',
  `EMPLOYEE_DEPT_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费员所属部门名称',
  `EMPLOYEE_DEPT_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费员所属部门ID',
  `AFFILIATED_BUSINESS_HALL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业厅名称',
  `AFFILIATED_BUSINESS_HALL_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业厅编号',
  `ADMINISTRATIVE_AREA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域名称',
  `ADMINISTRATIVE_AREA_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域编号',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_INVOICE
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_PAY_IN_BANK
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_PAY_IN_BANK`;
CREATE TABLE `TOLL_PAY_IN_BANK`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `MONEY` decimal(38, 2) NOT NULL,
  `PAY_IN_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BANK_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BANK_ACCOUNT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHARGE_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `RECEIPT_NUMBER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_DATETIME` datetime(0) NOT NULL,
  `REMARK` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PAY_IN_DATE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_PAY_IN_BANK
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_PENALTY_RELIEF
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_PENALTY_RELIEF`;
CREATE TABLE `TOLL_PENALTY_RELIEF`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `RELIEF_MONEY` decimal(38, 2) NOT NULL COMMENT '减免金额',
  `FILE_PATH` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATE_DATETIME` datetime(0) NOT NULL,
  `CREATE_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHECK_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_DATETIME` datetime(0) NULL DEFAULT NULL,
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PENALTY_MONEY` decimal(38, 2) NULL DEFAULT NULL COMMENT '违约金额',
  `METER_DATA_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_PENALTY_RELIEF
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_PRE_DEPOSIT_RECORD
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_PRE_DEPOSIT_RECORD`;
CREATE TABLE `TOLL_PRE_DEPOSIT_RECORD`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BEFORE_PRE_DEPOSIT_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `CHANGE_PRE_DEPOSIT_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `AFTER_PRE_DEPOSIT_MONEY` decimal(11, 2) NULL DEFAULT NULL,
  `CREATE_DATETIME` datetime(0) NULL DEFAULT NULL,
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `EMPLOYEE_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `AFFILIATED_BUSINESS_HALL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHARGE_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '费用类型',
  `STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ORIGIN_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收费编号',
  `CHARGE_DATE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '费用年月',
  `ADMINISTRATIVE_AREA_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域名称',
  `ADMINISTRATIVE_AREA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域编号'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_PRE_DEPOSIT_RECORD
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_RECEIVABLE_RECORD
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_RECEIVABLE_RECORD`;
CREATE TABLE `TOLL_RECEIVABLE_RECORD`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `BUSINESS_CHARGE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `RECEIVABLE_MONEY` decimal(38, 2) NOT NULL,
  `PAYABLE_MONEY` decimal(38, 2) NOT NULL,
  `UNPAYABLE_MONEY` decimal(38, 2) NOT NULL,
  `RECEIVABLE_DATETIME` datetime(0) NULL DEFAULT NULL,
  `EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `IS_CLEAR` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CHARGE_SETTING_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHARGE_DATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATE_DATE` datetime(0) NOT NULL,
  `CHARGE_SETTING_URL` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ADMINISTRATIVE_AREA_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域名称',
  `ADMINISTRATIVE_AREA_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理区域编号',
  `PAY_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付类型',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_RECEIVABLE_RECORD
-- ----------------------------

-- ----------------------------
-- Table structure for TOLL_REFUND_MANAGE
-- ----------------------------
DROP TABLE IF EXISTS `TOLL_REFUND_MANAGE`;
CREATE TABLE `TOLL_REFUND_MANAGE`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PAY_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `PAYABLE_MONEY` decimal(38, 2) NOT NULL,
  `REFUND_MONEY` decimal(38, 2) NOT NULL,
  `CREATE_DATETIME` datetime(0) NOT NULL,
  `OPERATE_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `OPERATE_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_EMPLOYEE_NAME` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_EMPLOYEE_CODE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_REMARK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_DATETIME` datetime(0) NULL DEFAULT NULL,
  `STATUS` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `REFUND_TYPE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of TOLL_REFUND_MANAGE
-- ----------------------------

-- ----------------------------
-- Table structure for WORK_ORDER
-- ----------------------------
DROP TABLE IF EXISTS `WORK_ORDER`;
CREATE TABLE `WORK_ORDER`  (
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WORK_ORDER_TYPE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `CREATED_TIME` datetime(0) NULL DEFAULT NULL,
  `PREDICT_COMPLETE_TIME` datetime(0) NULL DEFAULT NULL,
  `SYS_USER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ORDER_TIME` datetime(0) NULL DEFAULT NULL,
  `FINISH_TIME` datetime(0) NULL DEFAULT NULL,
  `TIMEOUT` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RESULT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `STATE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `REMARK` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `RELATED_LINK` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SYS_ORG_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CUSTOMER_ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SYS_USER_ID1` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SYS_USER_ID2` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SEND_TIME` datetime(0) NULL DEFAULT NULL,
  `LINKMAN` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `LINK_PHONE` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SYS_ORG_ID1` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RELATED_CODE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `TITLE` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of WORK_ORDER
-- ----------------------------

-- ----------------------------
-- Table structure for WORK_ORDER_REPLY
-- ----------------------------
DROP TABLE IF EXISTS `WORK_ORDER_REPLY`;
CREATE TABLE `WORK_ORDER_REPLY`  (
  `REPLY_TIME` datetime(0) NULL DEFAULT NULL,
  `REPLY_PERSON` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `WORK_ORDER_CODE` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ID` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of WORK_ORDER_REPLY
-- ----------------------------

-- ----------------------------
-- Table structure for WORK_RESCHEDULE
-- ----------------------------
DROP TABLE IF EXISTS `WORK_RESCHEDULE`;
CREATE TABLE `WORK_RESCHEDULE`  (
  `WORK_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WORKORDER_TYPE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CUSTOMER_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `LINKMAN_NAME` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `GAS_ADDRESS` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `LINKMAN_PHONE` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WORKORDER_CONTENT` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `CREATED_TIME` datetime(0) NULL DEFAULT NULL,
  `FINISHED_TIME` datetime(0) NULL DEFAULT NULL,
  `CREATED_PERSON` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `WORKORDER_DISPATCHER` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `RECIVED_TIME` datetime(0) NULL DEFAULT NULL,
  `ACTUAL_FINISHED_TIME` datetime(0) NOT NULL,
  `HADNLED_RESULT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `WORKORDER_STATUS` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `NOTE` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `WHETHER_OVERDUE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `HANDLE_DEPARTMENT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `HANDLE_PERSON` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of WORK_RESCHEDULE
-- ----------------------------

-- ----------------------------
-- Table structure for YEAR_CHECK_PLAN
-- ----------------------------
DROP TABLE IF EXISTS `YEAR_CHECK_PLAN`;
CREATE TABLE `YEAR_CHECK_PLAN`  (
  `ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHECK_YEAR` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREATER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREAT_DATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `PLAN_STATE` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `OWNER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of YEAR_CHECK_PLAN
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
