CREATE DATABASE `powerauth`;

CREATE USER 'powerauth'@'%';

GRANT ALL PRIVILEGES ON powerauth.* TO 'powerauth'@'%';

FLUSH PRIVILEGES;

USE powerauth;

CREATE TABLE `push_app_credentials` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_id` bigint(20) NOT NULL,
  `ios_private_key` blob DEFAULT NULL,
  `ios_team_id` varchar(255) DEFAULT NULL,
  `ios_key_id` varchar(255) DEFAULT NULL,
  `ios_bundle` varchar(255) DEFAULT NULL,
  `android_private_key` blob DEFAULT NULL,
  `android_project_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE `push_device_registration` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `activation_id` varchar(37) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `app_id` bigint(20) NOT NULL,
  `platform` varchar(20) NOT NULL,
  `push_token` varchar(255) NOT NULL,
  `timestamp_last_registered` DATETIME NOT NULL,
  `is_active` int(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE `push_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `device_registration_id` bigint(20) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `activation_id` varchar(37) DEFAULT NULL,
  `is_silent` int(1) DEFAULT 0,
  `is_personal` int(1) DEFAULT 0,
  `message_body` text NOT NULL,
  `timestamp_created` DATETIME NOT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE push_campaign (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app_id` bigint(20) NOT NULL,
  `message` text NOT NULL,
  `is_sent` int(1) DEFAULT 0,
  `timestamp_created` DATETIME NOT NULL,
  `timestamp_sent` DATETIME DEFAULT NULL,
  `timestamp_completed` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE push_campaign_user (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint(20) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `timestamp_created` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

--
-- Indexes for better performance.
--

CREATE UNIQUE INDEX PUSH_APP_CRED_APP ON PUSH_APP_CREDENTIALS(APP_ID);

CREATE INDEX PUSH_DEVICE_APP_TOKEN ON PUSH_DEVICE_REGISTRATION(APP_ID, PUSH_TOKEN);
CREATE INDEX PUSH_DEVICE_USER_APP ON PUSH_DEVICE_REGISTRATION(USER_ID, APP_ID);
CREATE INDEX PUSH_DEVICE_ACTIVATION ON PUSH_DEVICE_REGISTRATION(ACTIVATION_ID);

CREATE INDEX PUSH_MESSAGE_STATUS ON PUSH_MESSAGE(STATUS);

CREATE INDEX PUSH_CAMPAIGN_SENT ON PUSH_CAMPAIGN(IS_SENT);

CREATE INDEX PUSH_CAMPAIGN_USER_CAMPAIGN ON PUSH_CAMPAIGN_USER(CAMPAIGN_ID, USER_ID);
CREATE INDEX PUSH_CAMPAIGN_USER_DETAIL ON PUSH_CAMPAIGN_USER(USER_ID);
