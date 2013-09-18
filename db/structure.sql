CREATE TABLE `absences` (
  `person_id` int(11) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `returned_to_work_date` datetime DEFAULT NULL,
  `sick_days` float DEFAULT NULL,
  `work_related_absence` char(1) DEFAULT NULL,
  `accident_report_completed` char(1) DEFAULT NULL,
  `discomfort_report_completed` char(1) DEFAULT NULL,
  `tickbox_neither` char(1) DEFAULT NULL,
  `department_code` varchar(20) DEFAULT NULL,
  `main_diagnosis_code` varchar(12) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(8) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `diary_id` int(11) NOT NULL,
  `person_id` int(11) NOT NULL,
  `from_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `note` text,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `case_nature` text,
  `case_reference_number` varchar(255) DEFAULT NULL,
  `attendance_id` int(11) DEFAULT NULL,
  `referral_id` int(11) DEFAULT NULL,
  `referrer_full_name` varchar(255) DEFAULT NULL,
  `referrer_phone` varchar(255) DEFAULT NULL,
  `referrer_email` varchar(255) DEFAULT NULL,
  `referral_reason_id` int(11) NOT NULL,
  `diagnosis_id` int(11) DEFAULT NULL,
  `state` varchar(16) NOT NULL DEFAULT 'new',
  `in_collision` tinyint(1) NOT NULL DEFAULT '0',
  `new_or_review` varchar(10) DEFAULT NULL,
  `referrer_type_id` int(11) DEFAULT NULL,
  `referrer_name` varchar(100) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  `deleted_on` datetime DEFAULT NULL,
  `deleted_reason` varchar(255) DEFAULT NULL,
  `blocked` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_appointments_on_referral_id` (`referral_id`),
  KEY `index_appointments_on_person_id` (`person_id`),
  KEY `index_appointments_on_referral_reason_id` (`referral_reason_id`),
  KEY `index_appointments_on_diary_id` (`diary_id`),
  KEY `index_appointments_on_attendance_id` (`attendance_id`),
  KEY `diary_id_to_date_from_date_index` (`from_date`,`to_date`,`diary_id`)
) ENGINE=MyISAM AUTO_INCREMENT=342 DEFAULT CHARSET=latin1;

CREATE TABLE `attendance_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attendance_id` int(11) DEFAULT NULL,
  `report` text,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_attendance_feedback_on_attendance_id` (`attendance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;

CREATE TABLE `attendance_outcomes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

CREATE TABLE `attendance_reasons` (
  `code` varchar(8) NOT NULL,
  `description` varchar(100) NOT NULL,
  `diary_reason` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `attendance_results` (
  `code` varchar(8) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `attendancediagnosis` (
  `DiagnosisCode` varchar(12) DEFAULT NULL,
  `AttendanceID` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`AttendanceID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `attendances` (
  `person_id` int(11) DEFAULT NULL,
  `attendance_date_time` datetime DEFAULT NULL,
  `clinic_id` int(11) DEFAULT NULL,
  `attendance_reason_code` varchar(8) DEFAULT NULL,
  `attendance_result_code` varchar(8) DEFAULT NULL,
  `comments` tinytext,
  `clinic_staff_id` int(11) DEFAULT NULL,
  `seen_at_time` datetime DEFAULT NULL,
  `diary_entry_id` int(11) DEFAULT NULL,
  `work_related_absence` varchar(1) DEFAULT 'N',
  `review_attendance` varchar(1) DEFAULT 'N',
  `transport_type_code` varchar(8) DEFAULT NULL,
  `work_discomfort` varchar(1) DEFAULT 'N',
  `accident_report_complete` varchar(1) DEFAULT 'N',
  `contact_id` float DEFAULT NULL,
  `attendance_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis_id` varchar(16) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `recall_event_id` int(11) DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `no_work_contact` varchar(1) DEFAULT 'N',
  `restrictions_applied` tinyint(1) DEFAULT '0',
  `is_discharged` tinyint(1) DEFAULT '0',
  `outcome_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_attendances_on_attendance_reason_code` (`attendance_reason_code`),
  KEY `index_attendances_on_attendance_result_code` (`attendance_result_code`)
) ENGINE=MyISAM AUTO_INCREMENT=127 DEFAULT CHARSET=latin1;

CREATE TABLE `client` (
  `ClientID` int(11) NOT NULL DEFAULT '0',
  `ClientName` varchar(40) DEFAULT NULL,
  `BillingAddressLine1` varchar(40) DEFAULT NULL,
  `BillingAddressLine2` varchar(40) DEFAULT NULL,
  `BillingAddressLine3` varchar(40) DEFAULT NULL,
  `BillingCounty` varchar(40) DEFAULT NULL,
  `BillingPostCode` varchar(16) DEFAULT NULL,
  `WorkDaysPerWeek` int(11) DEFAULT NULL,
  PRIMARY KEY (`ClientID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `client_employee` (
  `person_id` int(11) NOT NULL,
  `salary_number` int(11) DEFAULT NULL,
  `sap_number` int(11) DEFAULT NULL,
  `Supervisor` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `employment_start_date` datetime DEFAULT NULL,
  `employment_end_date` datetime DEFAULT NULL,
  `current_department_code` varchar(32) NOT NULL,
  PRIMARY KEY (`person_id`),
  KEY `salary_number` (`salary_number`),
  KEY `Supervisor` (`Supervisor`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `clinic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clinic_name` varchar(80) DEFAULT NULL,
  `physical_line1` varchar(40) DEFAULT NULL,
  `physical_line2` varchar(40) DEFAULT NULL,
  `physical_line3` varchar(40) DEFAULT NULL,
  `physical_county` varchar(40) DEFAULT NULL,
  `physical_post_code` varchar(16) DEFAULT NULL,
  `postal_line1` varchar(40) DEFAULT NULL,
  `postal_line2` varchar(40) DEFAULT NULL,
  `postal_line3` varchar(40) DEFAULT NULL,
  `postal_county` varchar(40) DEFAULT NULL,
  `postal_post_code` varchar(16) DEFAULT NULL,
  `area_code` varchar(12) DEFAULT NULL,
  `telephone_number` varchar(22) DEFAULT NULL,
  `ExtensionNumber` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `clinic_staff_member` (
  `id` int(11) NOT NULL,
  `diary_id` int(11) DEFAULT NULL,
  `security_id` int(11) DEFAULT NULL,
  `clinic_department_id` float DEFAULT NULL,
  `clinic_id` int(11) DEFAULT NULL,
  `sec_status_code` varchar(2) DEFAULT NULL,
  `sec_password` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `declinations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referral_id` int(11) NOT NULL,
  `reason` text NOT NULL,
  `created` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_declinations_on_referral_id` (`referral_id`),
  KEY `index_declinations_on_created_by` (`created_by`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

CREATE TABLE `departments` (
  `ClientID` int(11) DEFAULT NULL,
  `DepartmentCode` varchar(32) NOT NULL,
  `DepartmentDescription` varchar(100) DEFAULT NULL,
  `RecallAbsenceDayQuantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`DepartmentCode`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `diagnoses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `_id` varchar(12) NOT NULL,
  `_parent_id` varchar(12) NOT NULL,
  `description` varchar(150) NOT NULL,
  `is_obsolete` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=213 DEFAULT CHARSET=latin1;

CREATE TABLE `diagnoses_sicknotes` (
  `sicknote_id` int(11) NOT NULL,
  `diagnosis_code` varchar(12) NOT NULL,
  KEY `sicknote_id` (`sicknote_id`),
  KEY `diagnosis_code` (`diagnosis_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `diaries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `color_id` int(11) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `appointment_length` int(11) NOT NULL,
  `available_days` smallint(6) NOT NULL,
  `default_appointment_type` varchar(8) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

CREATE TABLE `diary_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diary_id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `from_time` time NOT NULL DEFAULT '00:00:00',
  `to_time` time NOT NULL DEFAULT '23:59:59',
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `week_day` tinyint(4) NOT NULL DEFAULT '0',
  `month_day` int(11) NOT NULL DEFAULT '0',
  `month` smallint(6) NOT NULL DEFAULT '0',
  `order_no` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=103 DEFAULT CHARSET=latin1;

CREATE TABLE `documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attachable_id` int(11) DEFAULT NULL,
  `attachable_type` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `document_file_name` varchar(255) DEFAULT NULL,
  `document_content_type` varchar(255) DEFAULT NULL,
  `document_file_size` int(11) DEFAULT NULL,
  `document_updated_at` datetime DEFAULT NULL,
  `document_fingerprint` varchar(255) DEFAULT NULL,
  `origin` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_documents_on_attachable_id_and_attachable_type` (`attachable_id`,`attachable_type`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1;

CREATE TABLE `employee_department` (
  `person_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `department_code` varchar(32) DEFAULT NULL,
  `from_date` datetime DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `employee_job_class` (
  `person_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `job_class_code` varchar(8) DEFAULT NULL,
  `from_date` datetime DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `followups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attendance_id` int(11) NOT NULL,
  `result_attendance_id` int(11) DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  `type` varchar(8) NOT NULL,
  `date` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `job_classes` (
  `ClientID` int(11) DEFAULT NULL,
  `JobClassCode` varchar(8) NOT NULL DEFAULT '',
  `JobClassDescription` varchar(100) DEFAULT NULL,
  `IOHJobClassCode` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`JobClassCode`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `nemployees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `salary_number` int(11) DEFAULT NULL,
  `sap_number` int(11) DEFAULT NULL,
  `supervisor_id` int(11) DEFAULT NULL,
  `sup_salary_number` int(11) DEFAULT NULL,
  `sup_sap_number` int(11) DEFAULT NULL,
  `employment_start_date` date DEFAULT NULL,
  `employment_end_date` date DEFAULT NULL,
  `department_id` varchar(32) NOT NULL,
  `current_department_code` varchar(32) DEFAULT NULL,
  `job_class_id` varchar(8) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `is_obsolete` tinyint(1) NOT NULL DEFAULT '0',
  `import_id` int(11) DEFAULT NULL,
  `work_schedule_rule` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `person_id` (`person_id`),
  KEY `salary_number` (`salary_number`),
  KEY `sap_number` (`sap_number`),
  KEY `sup_salary_number` (`sup_salary_number`),
  KEY `sup_sap_number` (`sup_sap_number`),
  KEY `sup_sap_number_2` (`sup_sap_number`),
  KEY `index_nemployees_on_client_id` (`client_id`),
  KEY `index_nemployees_on_department_id` (`department_id`),
  KEY `index_nemployees_on_job_class_id` (`job_class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=162121 DEFAULT CHARSET=latin1;

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `notifier_model` varchar(255) DEFAULT NULL,
  `notifier_id` int(11) DEFAULT NULL,
  `target_model` varchar(255) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `email_sent` tinyint(1) DEFAULT '0',
  `email_sent_date` datetime DEFAULT NULL,
  `read` tinyint(1) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `read_date` datetime DEFAULT NULL,
  `problems` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `target_id_target_model_index` (`target_id`,`target_model`),
  KEY `read_target_id_index` (`target_id`,`read`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE `operational_priorities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operational_priority` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE `organisations` (
  `OrganisationID` int(11) NOT NULL AUTO_INCREMENT,
  `OrganisationName` varchar(80) DEFAULT NULL,
  `PhysicalAddressLine1` varchar(40) DEFAULT NULL,
  `PhysicalAddressLine2` varchar(40) DEFAULT NULL,
  `PhysicalAddressLine3` varchar(40) DEFAULT NULL,
  `PhysicalCounty` varchar(40) DEFAULT NULL,
  `PhysicalPostCode` varchar(16) DEFAULT NULL,
  `IsClient` char(1) DEFAULT NULL,
  PRIMARY KEY (`OrganisationID`)
) ENGINE=MyISAM AUTO_INCREMENT=170 DEFAULT CHARSET=latin1;

CREATE TABLE `patient_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

CREATE TABLE `patients` (
  `PersonID` int(11) NOT NULL DEFAULT '0',
  `IsEmployee` char(1) DEFAULT NULL,
  `ResponsibleOrganisationID` int(11) NOT NULL DEFAULT '0',
  `CLIENT_CONTACT_PERSON_ID` int(11) DEFAULT NULL,
  `referrer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`PersonID`),
  KEY `index_patients_on_ResponsibleOrganisationID` (`ResponsibleOrganisationID`),
  KEY `index_patients_on_PersonID` (`PersonID`),
  KEY `index_patients_on_referrer_id` (`referrer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(60) DEFAULT NULL,
  `last_name` varchar(40) DEFAULT NULL,
  `middle_name` varchar(10) DEFAULT NULL,
  `title` varchar(12) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `address1` varchar(100) DEFAULT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `address3` varchar(100) DEFAULT NULL,
  `county` varchar(100) DEFAULT NULL,
  `post_code` varchar(20) DEFAULT NULL,
  `area_code` varchar(20) DEFAULT NULL,
  `telephone_number` varchar(40) DEFAULT NULL,
  `extension` varchar(10) DEFAULT NULL,
  `gender` varchar(2) DEFAULT NULL,
  `email_address` varchar(100) DEFAULT NULL,
  `added_by_referrer` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_person_on_first_name` (`first_name`),
  KEY `index_person_on_last_name` (`last_name`),
  KEY `index_person_on_first_name_and_last_name` (`first_name`,`last_name`)
) ENGINE=MyISAM AUTO_INCREMENT=32212 DEFAULT CHARSET=latin1;

CREATE TABLE `recall_list_item_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recall_list_item_id` int(11) NOT NULL,
  `due_date` date DEFAULT NULL,
  `recall_date` date DEFAULT NULL,
  `call_no` int(11) NOT NULL DEFAULT '1',
  `attended_date` datetime DEFAULT NULL,
  `attendance_id` int(11) DEFAULT NULL,
  `note` text,
  `created` datetime DEFAULT NULL,
  `contact_type` varchar(64) DEFAULT 'Advised by OH Staff',
  `created_by` int(11) NOT NULL,
  `invite_date` date NOT NULL,
  `comments` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;

CREATE TABLE `recall_list_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recall_list_id` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  `last_attended_date` datetime DEFAULT NULL,
  `last_invite_id` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recall_list_id` (`recall_list_id`),
  KEY `employee_id` (`employee_id`),
  KEY `recall_list_id_2` (`recall_list_id`,`person_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

CREATE TABLE `recall_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `recall_list_item_count` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `referral_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

CREATE TABLE `referrals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `patient_status_id` int(11) DEFAULT NULL,
  `case_nature` text,
  `job_information` text,
  `history` text,
  `referral_reason_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `case_reference_number` varchar(255) DEFAULT NULL,
  `referrer_id` int(11) DEFAULT NULL,
  `state` varchar(16) NOT NULL DEFAULT 'new',
  `sickness_started` date DEFAULT NULL,
  `sicknote_expires` date DEFAULT NULL,
  `operational_priority_id` varchar(255) DEFAULT NULL,
  `person_department_name` varchar(100) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `private` tinyint(1) DEFAULT '0',
  `canceled_on` datetime DEFAULT NULL,
  `canceled_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  KEY `created_at` (`created_at`),
  KEY `state` (`state`(1)),
  KEY `index_referrals_on_referrer_id` (`referrer_id`),
  KEY `index_referrals_on_person_id` (`person_id`),
  KEY `index_referrals_on_patient_status_id` (`patient_status_id`),
  KEY `index_referrals_on_referral_reason_id` (`referral_reason_id`),
  KEY `index_referrals_on_operational_priority_id` (`operational_priority_id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=latin1;

CREATE TABLE `referrals_followers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `referral_id` int(11) DEFAULT NULL,
  `referrer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_referrals_followers_on_referrer_id` (`referrer_id`),
  KEY `index_referrals_followers_on_referral_id` (`referral_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;

CREATE TABLE `referrer_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

CREATE TABLE `referrers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `encrypted_password` varchar(128) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `person_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `track_referrals` varchar(255) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `referrer_type_id` int(11) DEFAULT NULL,
  `read_only_access` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_referrers_on_email` (`email`),
  UNIQUE KEY `index_referrers_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_referrers_on_username` (`username`),
  KEY `index_referrers_on_person_id` (`person_id`),
  KEY `index_referrers_on_client_id` (`client_id`),
  KEY `index_referrers_on_referrer_type_id` (`referrer_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `sec_category` (
  `id` int(11) NOT NULL DEFAULT '0',
  `category_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `sec_function` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `function_name` varchar(100) NOT NULL,
  `status_code` varchar(2) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;

CREATE TABLE `sec_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(100) NOT NULL,
  `status_code` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

CREATE TABLE `sec_group_function` (
  `group_id` int(11) NOT NULL,
  `function_id` int(11) NOT NULL,
  PRIMARY KEY (`group_id`,`function_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `sec_status` (
  `status_code` varchar(2) NOT NULL DEFAULT '',
  `status_description` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`status_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `sec_user_function` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `function_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`function_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `sec_user_group` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`,`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `sicknote_types` (
  `code` varchar(8) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `sicknotes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_code` varchar(8) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `symptoms_description` tinytext,
  `comments` tinytext,
  `created` datetime DEFAULT NULL,
  `absence_id` int(11) NOT NULL,
  `sick_days` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `AbsenceID` (`absence_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20110826151510');

INSERT INTO schema_migrations (version) VALUES ('20110826202429');

INSERT INTO schema_migrations (version) VALUES ('20110831125841');

INSERT INTO schema_migrations (version) VALUES ('20110901101452');

INSERT INTO schema_migrations (version) VALUES ('20110903105240');

INSERT INTO schema_migrations (version) VALUES ('20110903110107');

INSERT INTO schema_migrations (version) VALUES ('20110913134713');

INSERT INTO schema_migrations (version) VALUES ('20110913152746');

INSERT INTO schema_migrations (version) VALUES ('20111013150210');

INSERT INTO schema_migrations (version) VALUES ('20111014112238');

INSERT INTO schema_migrations (version) VALUES ('20111014114908');

INSERT INTO schema_migrations (version) VALUES ('20111016101505');

INSERT INTO schema_migrations (version) VALUES ('20111018045237');

INSERT INTO schema_migrations (version) VALUES ('20111018074734');

INSERT INTO schema_migrations (version) VALUES ('20111018134316');

INSERT INTO schema_migrations (version) VALUES ('20111025154158');

INSERT INTO schema_migrations (version) VALUES ('20111027081101');

INSERT INTO schema_migrations (version) VALUES ('20111027162913');

INSERT INTO schema_migrations (version) VALUES ('20111027164308');

INSERT INTO schema_migrations (version) VALUES ('20111028173640');

INSERT INTO schema_migrations (version) VALUES ('20111030104101');

INSERT INTO schema_migrations (version) VALUES ('20111206105912');

INSERT INTO schema_migrations (version) VALUES ('20111206113104');

INSERT INTO schema_migrations (version) VALUES ('20111206143333');

INSERT INTO schema_migrations (version) VALUES ('20111206150229');

INSERT INTO schema_migrations (version) VALUES ('20111206161408');

INSERT INTO schema_migrations (version) VALUES ('20120201200856');

INSERT INTO schema_migrations (version) VALUES ('20120201202645');

INSERT INTO schema_migrations (version) VALUES ('20120202205118');

INSERT INTO schema_migrations (version) VALUES ('20120206083656');

INSERT INTO schema_migrations (version) VALUES ('20120213081722');

INSERT INTO schema_migrations (version) VALUES ('20120224183341');

INSERT INTO schema_migrations (version) VALUES ('20120225104319');

INSERT INTO schema_migrations (version) VALUES ('20120228110815');

INSERT INTO schema_migrations (version) VALUES ('20120315063605');

INSERT INTO schema_migrations (version) VALUES ('20120315112747');

INSERT INTO schema_migrations (version) VALUES ('20120315115154');

INSERT INTO schema_migrations (version) VALUES ('20120315121842');

INSERT INTO schema_migrations (version) VALUES ('20120320064354');

INSERT INTO schema_migrations (version) VALUES ('20120320115906');

INSERT INTO schema_migrations (version) VALUES ('20120611092320');

INSERT INTO schema_migrations (version) VALUES ('20120622090331');

INSERT INTO schema_migrations (version) VALUES ('20120622124359');

INSERT INTO schema_migrations (version) VALUES ('20120627060350');

INSERT INTO schema_migrations (version) VALUES ('20120627075902');

INSERT INTO schema_migrations (version) VALUES ('20120627150250');

INSERT INTO schema_migrations (version) VALUES ('20120628095648');

INSERT INTO schema_migrations (version) VALUES ('20120702112105');

INSERT INTO schema_migrations (version) VALUES ('20120702154903');

INSERT INTO schema_migrations (version) VALUES ('20120704133736');

INSERT INTO schema_migrations (version) VALUES ('20120919174718');

INSERT INTO schema_migrations (version) VALUES ('20120920103107');

INSERT INTO schema_migrations (version) VALUES ('20130723071736');

INSERT INTO schema_migrations (version) VALUES ('20130730074842');