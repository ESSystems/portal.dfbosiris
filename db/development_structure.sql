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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
  `attendance_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

CREATE TABLE `attendance_reasons` (
  `code` varchar(8) NOT NULL,
  `description` varchar(100) NOT NULL,
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
  `work_related_absence` enum('N','Y') DEFAULT 'N',
  `review_attendance` enum('N','Y') DEFAULT 'N',
  `transport_type_code` varchar(8) DEFAULT NULL,
  `work_discomfort` enum('N','Y') DEFAULT 'N',
  `accident_report_complete` enum('N','Y') DEFAULT 'N',
  `contact_id` float DEFAULT NULL,
  `attendance_time` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diagnosis_id` varchar(16) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `recall_event_id` int(11) DEFAULT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `no_work_contact` enum('N','Y') DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

CREATE TABLE `diary_restrictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diary_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `from_time` time NOT NULL DEFAULT '00:00:00',
  `to_time` time NOT NULL DEFAULT '23:59:59',
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `week_day` tinyint(4) NOT NULL DEFAULT '0',
  `month_day` int(11) NOT NULL DEFAULT '0',
  `month` smallint(6) NOT NULL DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

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
  `type` enum('on','before','after') NOT NULL,
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
  KEY `sup_sap_number_2` (`sup_sap_number`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `patients` (
  `PersonID` int(11) NOT NULL DEFAULT '0',
  `IsEmployee` char(1) DEFAULT NULL,
  `ResponsibleOrganisationID` int(11) NOT NULL DEFAULT '0',
  `CLIENT_CONTACT_PERSON_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`PersonID`)
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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23968 DEFAULT CHARSET=latin1;

CREATE TABLE `recall_list_item_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recall_list_item_id` int(11) NOT NULL,
  `due_date` datetime DEFAULT NULL,
  `call_no` int(11) NOT NULL DEFAULT '1',
  `attended_date` datetime DEFAULT NULL,
  `attendance_id` int(11) DEFAULT NULL,
  `note` text,
  `created` datetime DEFAULT NULL,
  `contact_type` enum('Email 1','Email 2','Email 3','Informed HR','Informed HandS','Appointment Made','Creating List','Advised by OH Staff') DEFAULT 'Advised by OH Staff',
  `created_by` int(11) NOT NULL,
  `invite_date` date NOT NULL,
  `comments` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `recall_list_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recall_list_id` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `person_id` int(11) NOT NULL,
  `last_attended_date` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recall_list_id` (`recall_list_id`),
  KEY `employee_id` (`employee_id`),
  KEY `recall_list_id_2` (`recall_list_id`,`person_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `recall_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `recall_list_item_count` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `referral_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `referrals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `person_id` int(11) DEFAULT NULL,
  `patient_status_id` int(11) DEFAULT NULL,
  `case_nature` text,
  `specific_requirements` text,
  `advice` text,
  `referral_reason_id` int(11) DEFAULT NULL,
  `preferred_date` datetime DEFAULT NULL,
  `patient_consent` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `case_reference_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO schema_migrations (version) VALUES ('20110826151510');

INSERT INTO schema_migrations (version) VALUES ('20110826202429');

INSERT INTO schema_migrations (version) VALUES ('20110831125841');

INSERT INTO schema_migrations (version) VALUES ('20110901101452');

INSERT INTO schema_migrations (version) VALUES ('20110903105240');

INSERT INTO schema_migrations (version) VALUES ('20110903110107');

INSERT INTO schema_migrations (version) VALUES ('20110913134713');

INSERT INTO schema_migrations (version) VALUES ('20110913152746');