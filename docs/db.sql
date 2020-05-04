CREATE TABLE `tbl_file` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `file_sha1` CHAR(40) NOT NULL DEFAULT '' COMMENT '文件hash',
    `file_name` VARCHAR(256) NOT NULL DEFAULT '' COMMENT '文件名',
    `file_size` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '文件大小',
    `file_addr` VARCHAR(1024) NOT NULL DEFAULT '' COMMENT '文件存储位置',
    `create_at` DATETIME DEFAULT NOW() COMMENT '创建日期',
    `update_at` DATETIME DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP() COMMENT '更新日期',
    `status` TINYINT NOT NULL DEFAULT 0 COMMENT '状态(可用/禁用/已删除等)',
    `ext1` INT(11) NOT NULL DEFAULT 0 COMMENT '备用字段1',
    `ext2` TEXT COMMENT '备用字段2',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_file_hash` (`file_sha1`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `username` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
    `password` varchar(256) NOT NULL DEFAULT '' COMMENT '用户encoded密码',
    `email` varchar(64) DEFAULT '' COMMENT '邮箱',
    `phone` varchar(128) DEFAULT '' COMMENT '手机号',
    `email_validated` tinyint(1) DEFAULT 0 COMMENT '邮箱是否已验证',
    `phone_validated` tinyint(1) DEFAULT 0 COMMENT '手机号是否已验证',
    `signup_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '注册日期',
    `last_active` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后活跃时间戳',
    `profile` text COMMENT '用户属性',
    `status` int(11) NOT NULL DEFAULT '0' COMMENT '账户状态(启用/禁用/锁定/标记删除等)',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tbl_user_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
  `user_token` char(40) NOT NULL DEFAULT '' COMMENT '用户登录token',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;