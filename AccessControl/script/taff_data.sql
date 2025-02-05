##TAFF_DATA DATABASE FOR ACCESSCONTROL (Update 11/06/2015)
USE taff_data;

## 1 CREATE TABLE ON TAFF_DATA (Update 11/06/2015)
##DROP TABLE IF EXISTS taff_data.dbcompany;
CREATE TABLE  taff_data.dbcompany (
  com_code VARCHAR(1) NOT NULL,
  th_desc VARCHAR(100) DEFAULT '',
  en_desc VARCHAR(100) DEFAULT '',
  th_addr VARCHAR(250) DEFAULT '',
  en_addr VARCHAR(250) DEFAULT '',
  com_email VARCHAR(50) DEFAULT '',
  com_www VARCHAR(50) DEFAULT '',
  time_in VARCHAR(5) NOT NULL DEFAULT '00:00',
  time_out VARCHAR(5) NOT NULL DEFAULT '23:59',
  hour_day VARCHAR(5) NOT NULL DEFAULT '24:00',
  ver_soft VARCHAR(1) NOT NULL DEFAULT '0',
  mail_smtp VARCHAR(50) DEFAULT '',
  sms_host VARCHAR(30) DEFAULT '',
  sms_port VARCHAR(5) DEFAULT '',
  sms_user VARCHAR(20) DEFAULT '',
  sms_pass VARCHAR(20) DEFAULT '',
  mail_user VARCHAR(50) DEFAULT '',
  mail_pass VARCHAR(20) DEFAULT '',
  mail_type VARCHAR(1) DEFAULT '0',
  mail_port INT(11) DEFAULT '26',
  readerf INT(1) DEFAULT '2',
  keepdays VARCHAR(3) DEFAULT '365',
  PRIMARY KEY (com_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbconfigcorp;
CREATE TABLE  taff_data.dbconfigcorp (
  config_code VARCHAR(1) NOT NULL,
  card_pattern VARCHAR(16) DEFAULT '????????????????',
  display_digit VARCHAR(16) DEFAULT 'YYYYYYYYYYYYYYYY',
  save_digit VARCHAR(16) DEFAULT 'YYYYYYYYYYYYYYYY',
  master_card1 VARCHAR(16) DEFAULT '1234567890',
  master_card2 VARCHAR(16) DEFAULT '',
  master_card3 VARCHAR(16) DEFAULT '',
  master_card4 VARCHAR(16) DEFAULT '',
  master_card5 VARCHAR(16) DEFAULT '',
  customer_code VARCHAR(3) DEFAULT 'MAS',
  duplicate_time VARCHAR(2) DEFAULT '00',
  start_digit VARCHAR(2) DEFAULT '01',
  issue_digit VARCHAR(2) DEFAULT '01',
  key_card2 VARCHAR(12) DEFAULT '',
  block_id INT(11) DEFAULT '-1',
  modulef INT(11) DEFAULT '1',
  PRIMARY KEY (config_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dblocation;
CREATE TABLE  taff_data.dblocation (
  locate_code VARCHAR(6) NOT NULL,
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  server_code VARCHAR(6) NOT NULL DEFAULT '',
  group_lock VARCHAR(1) DEFAULT '',
  group_unlock VARCHAR(1) DEFAULT '',
  group_alarm VARCHAR(1) DEFAULT '',
  PRIMARY KEY (locate_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbdoor;
CREATE TABLE  taff_data.dbdoor (
  door_id VARCHAR(4) NOT NULL,
  ip_address VARCHAR(15) NOT NULL,
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  locate_code VARCHAR(6) DEFAULT '',
  compare_mode VARCHAR(1) DEFAULT '0',
  door_lock VARCHAR(2) DEFAULT '05',
  alarm_door VARCHAR(2) DEFAULT '15',
  alarm_time VARCHAR(2) DEFAULT '99',
  auto_time VARCHAR(1) DEFAULT '1',
  read_serial VARCHAR(1) DEFAULT '0',
  pos_x INT(11) DEFAULT '100',
  pos_y INT(11) DEFAULT '250',
  time_off_out2 VARCHAR(2) DEFAULT '05',
  time_off_out3 VARCHAR(2) DEFAULT '05',
  time_off_out4 VARCHAR(2) DEFAULT '05',
  time_off_out1_e37 VARCHAR(2) DEFAULT '05',
  time_off_out2_e37 VARCHAR(2) DEFAULT '05',
  time_off_out1_e39 VARCHAR(2) DEFAULT '05',
  time_off_out2_e39 VARCHAR(2) DEFAULT '05',
  group_door VARCHAR(2) DEFAULT '',
  print_event INT(11) unsigned DEFAULT '1',
  door_type VARCHAR(1) DEFAULT '0',
  duplicate_ip VARCHAR(1) DEFAULT '0',
  PRIMARY KEY (door_id)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbreader;
CREATE TABLE  taff_data.dbreader (
  reader_no VARCHAR(5) NOT NULL,
  door_id VARCHAR(4) NOT NULL,
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  reader_type INT(10) unsigned DEFAULT '0',
  reader_func INT(10) unsigned DEFAULT '0',
  level_no INT(10) unsigned DEFAULT '0',
  clear_l1 VARCHAR(1) DEFAULT '0',
  clear_l2 VARCHAR(1) DEFAULT '0',
  clear_l3 VARCHAR(1) DEFAULT '0',
  clear_l4 VARCHAR(1) DEFAULT '0',
  clear_l5 VARCHAR(1) DEFAULT '0',
  display_bright VARCHAR(2) DEFAULT '08',
  language VARCHAR(1) DEFAULT '0',
  finger_identify VARCHAR(1) DEFAULT '1',
  key_beep VARCHAR(1) DEFAULT '1',
  write_oncard VARCHAR(1) DEFAULT '1',
  active_keypad VARCHAR(1) DEFAULT '1',
  active_keyduty VARCHAR(1) DEFAULT '1',
  display_duty1 VARCHAR(1) DEFAULT '',
  display_duty2 VARCHAR(1) DEFAULT '',
  display_duty3 VARCHAR(1) DEFAULT '',
  display_duty4 VARCHAR(1) DEFAULT '',
  duty1_time1 VARCHAR(8) DEFAULT '',
  duty1_time2 VARCHAR(8) DEFAULT '',
  duty1_time3 VARCHAR(8) DEFAULT '',
  duty1_time4 VARCHAR(8) DEFAULT '',
  duty1_time5 VARCHAR(8) DEFAULT '',
  duty2_time1 VARCHAR(8) DEFAULT '',
  duty2_time2 VARCHAR(8) DEFAULT '',
  duty2_time3 VARCHAR(8) DEFAULT '',
  duty2_time4 VARCHAR(8) DEFAULT '',
  duty2_time5 VARCHAR(8) DEFAULT '',
  duty3_time1 VARCHAR(8) DEFAULT '',
  duty3_time2 VARCHAR(8) DEFAULT '',
  duty3_time3 VARCHAR(8) DEFAULT '',
  duty3_time4 VARCHAR(8) DEFAULT '',
  duty3_time5 VARCHAR(8) DEFAULT '',
  duty4_time1 VARCHAR(8) DEFAULT '',
  duty4_time2 VARCHAR(8) DEFAULT '',
  duty4_time3 VARCHAR(8) DEFAULT '',
  duty4_time4 VARCHAR(8) DEFAULT '',
  duty4_time5 VARCHAR(8) DEFAULT '', 
  security_online INT(10) unsigned DEFAULT '1',
  volume VARCHAR(2) DEFAULT '08',
  time_off_display VARCHAR(2) DEFAULT '05',
  config_gprs VARCHAR(1) DEFAULT '0',
  alarm_mode VARCHAR(1) DEFAULT '0',
  access_mode VARCHAR(1) DEFAULT '0',
  clock_color_normal VARCHAR(1) DEFAULT '0',
  clock_color_unlock VARCHAR(1) DEFAULT '2',
  clock_color_alarm VARCHAR(1) DEFAULT '1',
  out_of_service VARCHAR(1) DEFAULT '0',
  timeshowmess VARCHAR(1) DEFAULT '5',
  timeonpicture VARCHAR(3) DEFAULT '010',
  writetransloop VARCHAR(1) DEFAULT '0',
  timezone0_unlock VARCHAR(1) DEFAULT '0',
  usecardantipassback VARCHAR(1) DEFAULT '0',
  prox_format VARCHAR(1) DEFAULT '0',  
  fing_security VARCHAR(1) DEFAULT '6',
  rd2mode VARCHAR(1) DEFAULT '0',
  rd2duty VARCHAR(1) DEFAULT 'O',
  vdo_volume VARCHAR(1) DEFAULT '5',
  screen_server VARCHAR(1) DEFAULT '1',
  camera VARCHAR(1) DEFAULT '1',
  capt_preview VARCHAR(1) DEFAULT '1',
  mifare_std VARCHAR(1) DEFAULT '0',
  mifare_uid VARCHAR(1) DEFAULT '0',
  status_io VARCHAR(1) DEFAULT 'I',
  PRIMARY KEY (reader_no)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbevent;
CREATE TABLE  taff_data.dbevent (
  event_code VARCHAR(2) NOT NULL,
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  event_act VARCHAR(10) DEFAULT '0000000000',
  software_act VARCHAR(10) DEFAULT '0000000000',
  th_msg VARCHAR(50) DEFAULT '',
  en_msg VARCHAR(50) DEFAULT '',
  sound_file VARCHAR(50) DEFAULT '',
  email1 VARCHAR(50) DEFAULT '',
  email2 VARCHAR(50) DEFAULT '',
  email3 VARCHAR(50) DEFAULT '',
  email4 VARCHAR(50) DEFAULT '',
  email5 VARCHAR(50) DEFAULT '',
  phone1 VARCHAR(50) DEFAULT '',
  phone2 VARCHAR(50) DEFAULT '',
  phone3 VARCHAR(50) DEFAULT '',
  phone4 VARCHAR(50) DEFAULT '',
  phone5 VARCHAR(50) DEFAULT '',
  bg_color VARCHAR(10) DEFAULT '',
  font_color VARCHAR(10) DEFAULT '',
  font_size INT(10) unsigned DEFAULT '10',
  font_style VARCHAR(2) DEFAULT '',
  group_img INT(1) DEFAULT '0',
  PRIMARY KEY (event_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbholiday;
CREATE TABLE  taff_data.dbholiday (
  holi_date DATE NOT NULL,
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  PRIMARY KEY (holi_date)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbtimedesc;
CREATE TABLE  taff_data.dbtimedesc (
  time_id VARCHAR(2) NOT NULL,
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  time1 VARCHAR(8) DEFAULT '',
  pin_flag1 VARCHAR(1) DEFAULT '',
  fp_flag1 VARCHAR(1) DEFAULT '',
  time2 VARCHAR(8) DEFAULT '',
  pin_flag2 VARCHAR(1) DEFAULT '',
  fp_flag2 VARCHAR(1) DEFAULT '',
  time3 VARCHAR(8) DEFAULT '',
  pin_flag3 VARCHAR(1) DEFAULT '',
  fp_flag3 VARCHAR(1) DEFAULT '',
  time4 VARCHAR(8) DEFAULT '',
  pin_flag4 VARCHAR(1) DEFAULT '',
  fp_flag4 VARCHAR(1) DEFAULT '',
  time5 VARCHAR(8) DEFAULT '',
  pin_flag5 VARCHAR(1) DEFAULT '',
  fp_flag5 VARCHAR(1) DEFAULT '',
  PRIMARY KEY (time_id)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbtimezone;
CREATE TABLE  taff_data.dbtimezone (
  time_code VARCHAR(2) NOT NULL,
  day_type VARCHAR(1) NOT NULL,
  time_id VARCHAR(2) DEFAULT '',
  PRIMARY KEY (time_code,day_type)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbtimezonedesc;
CREATE TABLE  taff_data.dbtimezonedesc (
  time_code VARCHAR(2) NOT NULL,
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  PRIMARY KEY (time_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbunlock;
CREATE TABLE  taff_data.dbunlock (
  day_type VARCHAR(1) NOT NULL,
  time1 VARCHAR(8) DEFAULT '',
  time2 VARCHAR(8) DEFAULT '',
  time3 VARCHAR(8) DEFAULT '',
  time4 VARCHAR(8) DEFAULT '',
  time5 VARCHAR(8) DEFAULT '',
  group1 VARCHAR(1) DEFAULT '0',
  group2 VARCHAR(1) DEFAULT '0',
  PRIMARY KEY (day_type)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dblock;
CREATE TABLE  taff_data.dblock (
  day_type VARCHAR(1) NOT NULL,
  time1 VARCHAR(8) DEFAULT '',
  time2 VARCHAR(8) DEFAULT '',
  time3 VARCHAR(8) DEFAULT '',
  time4 VARCHAR(8) DEFAULT '',
  time5 VARCHAR(8) DEFAULT '',
  PRIMARY KEY (day_type)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbtimeon_out4;
CREATE TABLE  taff_data.dbtimeon_out4 (
  day_type VARCHAR(1) NOT NULL,
  time1 VARCHAR(13) DEFAULT '',
  time2 VARCHAR(13) DEFAULT '',
  time3 VARCHAR(13) DEFAULT '',
  time4 VARCHAR(13) DEFAULT '',
  time5 VARCHAR(13) DEFAULT '',
  time6 VARCHAR(13) DEFAULT '',
  time7 VARCHAR(13) DEFAULT '',
  time8 VARCHAR(13) DEFAULT '',
  time9 VARCHAR(13) DEFAULT '',
  time10 VARCHAR(13) DEFAULT '',
  time11 VARCHAR(13) DEFAULT '',
  time12 VARCHAR(13) DEFAULT '',
  time13 VARCHAR(13) DEFAULT '',
  time14 VARCHAR(13) DEFAULT '',
  time15 VARCHAR(13) DEFAULT '',
  time16 VARCHAR(13) DEFAULT '',
  time17 VARCHAR(13) DEFAULT '',
  time18 VARCHAR(13) DEFAULT '',
  time19 VARCHAR(13) DEFAULT '',
  time20 VARCHAR(13) DEFAULT '',
  time21 VARCHAR(13) DEFAULT '',
  time22 VARCHAR(13) DEFAULT '',
  time23 VARCHAR(13) DEFAULT '',
  time24 VARCHAR(13) DEFAULT '',
  time25 VARCHAR(13) DEFAULT '',
  time26 VARCHAR(13) DEFAULT '',
  time27 VARCHAR(13) DEFAULT '',
  time28 VARCHAR(13) DEFAULT '',
  time29 VARCHAR(13) DEFAULT '',
  time30 VARCHAR(13) DEFAULT '',
  PRIMARY KEY (day_type)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbdepart;
CREATE TABLE  taff_data.dbdepart (
  dep_code VARCHAR(6) NOT NULL,
  th_desc VARCHAR(100) DEFAULT '',
  en_desc VARCHAR(100) DEFAULT '',
  PRIMARY KEY (dep_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbsection;
CREATE TABLE  taff_data.dbsection (
  sec_code VARCHAR(6) NOT NULL,
  th_desc VARCHAR(100) DEFAULT '',
  en_desc VARCHAR(100) DEFAULT '',
  dep_code VARCHAR(6) DEFAULT '',
  PRIMARY KEY (sec_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbposition;
CREATE TABLE  taff_data.dbposition (
  pos_code VARCHAR(6) NOT NULL,
  th_desc VARCHAR(100) DEFAULT '',
  en_desc VARCHAR(100) DEFAULT '',
  PRIMARY KEY (pos_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbtype;
CREATE TABLE  taff_data.dbtype (
  type_code VARCHAR(6) NOT NULL,
  th_desc VARCHAR(100) DEFAULT '',
  en_desc VARCHAR(100) DEFAULT '',
  PRIMARY KEY (type_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbgroup;
CREATE TABLE  taff_data.dbgroup (
  group_code VARCHAR(16) NOT NULL,
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  group_user VARCHAR(3) DEFAULT '',
  PRIMARY KEY (group_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbzone_group;
CREATE TABLE  taff_data.dbzone_group (
  group_code VARCHAR(16) NOT NULL,
  reader_no VARCHAR(5) NOT NULL,
  time_code VARCHAR(2) DEFAULT '',
  PRIMARY KEY (group_code,reader_no) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbemployee;
CREATE TABLE  taff_data.dbemployee (
  idcard VARCHAR(16) NOT NULL,
  sex INT(10) unsigned DEFAULT '0',
  prefix INT(10) unsigned DEFAULT '0',
  th_fname VARCHAR(30) DEFAULT '',
  th_sname VARCHAR(45) DEFAULT '',
  en_fname VARCHAR(30) DEFAULT '',
  en_sname VARCHAR(45) DEFAULT '',
  issue VARCHAR(2) NOT NULL,
  pincode VARCHAR(4) DEFAULT '',
  st_date DATE NOT NULL,
  ex_date DATE NOT NULL,
  sec_code VARCHAR(6) NOT NULL,
  pos_code VARCHAR(6) NOT NULL,
  group_code VARCHAR(16) NOT NULL,
  date_data DATETIME NOT NULL,
  level1 VARCHAR(1) DEFAULT '0',
  level2 VARCHAR(1) DEFAULT '0',
  level3 VARCHAR(1) DEFAULT '0',
  level4 VARCHAR(1) DEFAULT '0',
  level5 VARCHAR(1) DEFAULT '0',
  use_finger VARCHAR(1) DEFAULT '1',
  st_time VARCHAR(5) DEFAULT '00:00',
  ex_time VARCHAR(5) DEFAULT '23:59',
  pass_word VARCHAR(45) DEFAULT NULL,
  emp_card VARCHAR(16) DEFAULT '',
  card_id VARCHAR(13) DEFAULT '',
  use_map_card VARCHAR(1) DEFAULT '0',
  sn_card VARCHAR(14) DEFAULT '',
  type_code VARCHAR(6) NOT NULL,
  nationality VARCHAR(20) DEFAULT '',
  phone_no VARCHAR(15) DEFAULT '',
  email VARCHAR(50) DEFAULT '',
  template VARCHAR(1) DEFAULT '0',
  photo VARCHAR(1) DEFAULT '0',
  message VARCHAR(40) DEFAULT '',
  message_date DATE DEFAULT NULL,
  current_level VARCHAR(1) DEFAULT '0',
  current_io VARCHAR(1) DEFAULT 'O',
  current_rd VARCHAR(5) DEFAULT '',
  group_rd VARCHAR(2) DEFAULT '',
  PRIMARY KEY (idcard)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbusers;
CREATE TABLE  taff_data.dbusers (
  user_name VARCHAR(15) NOT NULL,
  pass_word VARCHAR(45) NOT NULL,
  user_right INT(10) unsigned NOT NULL DEFAULT '0',
  st_date DATE DEFAULT NULL,
  ex_date DATE DEFAULT NULL,
  user_status INT(10) unsigned DEFAULT NULL,
  user_admin VARCHAR(1) DEFAULT '0',
  dep_code VARCHAR(6) NOT NULL,
  sec_code VARCHAR(6) DEFAULT '',
  group_user VARCHAR(3) DEFAULT '',
  control_reader TEXT NOT NULL,
  monitor_location TEXT NOT NULL,
  monitor_data VARCHAR(1) DEFAULT '0',  
  PRIMARY KEY (user_name)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbreport;
CREATE TABLE  taff_data.dbreport (
  rep_code VARCHAR(6) NOT NULL,
  th_desc VARCHAR(100) DEFAULT '',
  en_desc VARCHAR(100) DEFAULT '',
  PRIMARY KEY (rep_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbresult;
CREATE TABLE  taff_data.dbresult (
  running_code VARCHAR(27) NOT NULL,
  door_id VARCHAR(4) NOT NULL DEFAULT '',
  ip_address VARCHAR(15) DEFAULT '',
  act_request VARCHAR(2) DEFAULT '',
  act_response VARCHAR(2) DEFAULT '',
  data_request VARCHAR(50) DEFAULT '',
  data_response VARCHAR(140) DEFAULT '',
  datetime_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (running_code,ip_address)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbserver;
CREATE TABLE  taff_data.dbserver (
  server_host VARCHAR(15) NOT NULL,
  time_opensw VARCHAR(20) DEFAULT '',
  time_closesw VARCHAR(20) DEFAULT '',
  status_sw VARCHAR(1) DEFAULT '0',
  time_openp1 VARCHAR(20) DEFAULT '',
  time_closep1 VARCHAR(20) DEFAULT '',
  status_p1 VARCHAR(1) DEFAULT '0',
  time_openp2 VARCHAR(20) DEFAULT '',
  time_closep2 VARCHAR(20) DEFAULT '',
  status_p2 VARCHAR(1) DEFAULT '0',
  time_openp3 VARCHAR(20) DEFAULT '',
  time_closep3 VARCHAR(20) DEFAULT '',
  status_p3 VARCHAR(1) DEFAULT '0',
  time_openp4 VARCHAR(20) DEFAULT '',
  time_closep4 VARCHAR(20) DEFAULT '',
  status_p4 VARCHAR(1) DEFAULT '0',
  PRIMARY KEY (server_host)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbserver_config;
CREATE TABLE taff_data.dbserver_config (
  server_code VARCHAR(6) NOT NULL,
  server_ip VARCHAR(15) NOT NULL,
  path_output TEXT NOT NULL,
  reader_no VARCHAR(5) DEFAULT '',
  event_code VARCHAR(2) DEFAULT '',
  access_token VARCHAR(1000) DEFAULT '',
  company_uuid VARCHAR(32) DEFAULT '',
  start_trans_id INT DEFAULT '0',
  PRIMARY KEY (server_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbsession;
CREATE TABLE  taff_data.dbsession (
  ses_user_id VARCHAR(40) NOT NULL,
  ses_time BIGINT(20) DEFAULT NULL,
  ses_user_name VARCHAR(15) DEFAULT '',
  page_jsp VARCHAR(50) DEFAULT '',
  browser_info VARCHAR(50) DEFAULT '',
  ip_address VARCHAR(15) DEFAULT '',
  PRIMARY KEY (ses_user_id)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbstatus_door;
CREATE TABLE  taff_data.dbstatus_door (
  door_id VARCHAR(4) NOT NULL,
  comm_code VARCHAR(2) DEFAULT '',
  ip_address VARCHAR(45) NOT NULL,
  status_no VARCHAR(1) DEFAULT '',
  date_time VARCHAR(19) DEFAULT'',
  PRIMARY KEY (door_id,comm_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbqprocess;
CREATE TABLE  taff_data.dbqprocess (
  door_id VARCHAR(4) NOT NULL,
  act_request VARCHAR(1) NOT NULL,
  act_time VARCHAR(17) DEFAULT '',
  act_running VARCHAR(1) DEFAULT '',
  ip_address VARCHAR(15) DEFAULT '',
  PRIMARY KEY (door_id,act_request) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbtrans_event;
CREATE TABLE  taff_data.dbtrans_event (
  date_event DATE NOT NULL,
  time_event VARCHAR(8) NOT NULL,
  reader_no VARCHAR(5) NOT NULL,
  event_code VARCHAR(2) NOT NULL,
  workday DATETIME NOT NULL,
  ip_address VARCHAR(15) DEFAULT '',
  duty VARCHAR(1) DEFAULT '',
  data_seq VARCHAR(4) DEFAULT '',
  data_blank VARCHAR(6) DEFAULT '',
  work_code VARCHAR(2) DEFAULT '',
  datetime_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (date_event,time_event,reader_no,event_code) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbtransaction;
CREATE TABLE  taff_data.dbtransaction (
  date_event DATE NOT NULL,
  time_event VARCHAR(8) NOT NULL,
  reader_no VARCHAR(5) NOT NULL,
  event_code VARCHAR(2) NOT NULL,
  idcard VARCHAR(16) NOT NULL,
  workday DATETIME  NOT NULL,
  ip_address VARCHAR(15) DEFAULT '',
  duty VARCHAR(1) DEFAULT '',
  data_seq VARCHAR(4) DEFAULT '',
  data_blank VARCHAR(6) DEFAULT '',
  work_code VARCHAR(2) DEFAULT '',
  datetime_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
  PRIMARY KEY (date_event,time_event,reader_no,event_code,idcard) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbtransaction_ev;
CREATE TABLE  taff_data.dbtransaction_ev (
  date_event DATE NOT NULL,
  time_event VARCHAR(8) NOT NULL,
  reader_no VARCHAR(5) NOT NULL,
  event_code VARCHAR(2) NOT NULL,
  idcard VARCHAR(16) NOT NULL, 
  workday DATETIME NOT NULL,
  ip_address VARCHAR(15) DEFAULT '',
  duty VARCHAR(1) DEFAULT '',
  data_seq VARCHAR(4) DEFAULT '',
  data_blank VARCHAR(6) DEFAULT '',
  work_code VARCHAR(2) DEFAULT '',
  datetime_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (date_event,time_event,reader_no,event_code,idcard) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

##DROP TABLE IF EXISTS taff_data.dbnote;
CREATE TABLE  taff_data.dbnote (
  datetime_note DATETIME NOT NULL,
  desc_note VARCHAR(100) DEFAULT '',
  user_add VARCHAR(16) DEFAULT '',
  datetime_add DATETIME NOT NULL,
  user_edit VARCHAR(16) DEFAULT '',
  datetime_edit DATETIME NOT NULL,  
  PRIMARY KEY (datetime_note)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

## 2 INSERT AND UPDATE DATA INTO TABLE (Update 11/06/2015)
INSERT INTO taff_data.dbcompany (com_code) VALUES('0');
INSERT INTO taff_data.dbconfigcorp (config_code) VALUES('0');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('01', 'ผ่านโดยการวางบัตร', 'Success by card', '1000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('02', 'ผ่านโดยการวางนิ้ว', 'Success by finger', '1000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('03', 'ผ่านโดยการกดรหัส', 'Success by keyboard', '1000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('04', 'ผ่านโดยการวางบัตร + นิ้วมือ', 'Success by card + finger', '1000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('05', 'ผ่านโดยการกดรหัส + นิ้วมือ', 'Success by keyboard + finger', '1000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('06', 'ติดบัญชีดำ', 'Error blacklist', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('07', 'ผ่านโดยบาร์โค้ด', 'Success by barcode', '1000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('08', '', '', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('09', 'ใช้บัตร Master Card', 'Master Card', '1000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('10', 'ตรวจพบรหัส', 'Detect ID', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('11', 'รูปแบบของรหัสบัตร ไม่ตรงกับที่กำหนดในระบบ', 'Card pattern mismatch', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('12', 'บัตรหมดอายุ ไม่สามารถใช้งานได้', 'Card expire DATE', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('13', 'บัตรยังไม่ถึงวันเริ่มใช้งาน', 'Card start DATE', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('14', 'ลำดับการออกบัตร ไม่ตรงกับที่กำหนดในระบบ', 'Card issue error', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('15', 'ระบบงานที่กำหนดไว้ในบัตร ไม่ตรงกับใน Reader', 'Card application mismatch', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('16', 'รหัสบริษัทที่กำหนดในบัตร ไม่ตรงกับใน Reader', 'Card customer mismatch', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('17', 'ระบบอ่านข้อมูลบัตรยังไม่สมบูรณ์', 'Card remove before end process', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('18', 'วางบัตร แต่ไม่ได้วางนิ้ว', 'Pass card not press finger', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('19', 'วางบัตร แต่ไม่ได้กดรหัสผ่าน', 'Pass card not press pincode', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('20', 'กดรหัสผ่านไม่ถูกต้อง', 'Pincode error', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('21', 'ไม่ได้กำหนดรหัสนี้ไว้ในตารางข้อมูล', 'ID. table mismatch', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('22', 'ช่วงเวลาที่กำหนดไม่อนุญาติให้ผ่าน', 'Timezone mismatch', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('23', 'ลายนิ้วมือไม่ถูกต้อง', 'Finger-print mismatch', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('24', 'ระบบ Anti-Passback ไม่ถูกต้อง ไม่สามารถผ่านได้', 'Anti-passback error', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('25', 'MU ติดต่อกับ CRU1 ไม่ได้', 'CRU1 disconnect', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('26', 'MU ติดต่อกับ CRU1 ได้ตามปกติ', 'CRU1 connect', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('27', 'MU ติดต่อกับ CRU2 ไม่ได้', 'CRU2 disconnect', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('28', 'MU ติดต่อกับ CRU2 ได้ตามปกติ', 'CRU2 connect', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('29', 'ปุ่มเปิดประตูถูกกด', 'Switch press (Input#1)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('30', 'ปุ่มเปิดประตูถูกปล่อย', 'Switch release (Input#1)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('31', 'ประตูเปิด', 'Door open (Input#2)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('32', 'ประตูปิด', 'Door close (Input#2)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('33', 'ชุดล็อคประตูไฟฟ้าทำงาน', 'Bolt lock (Output#1)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('34', 'ชุดล็อคประตูไฟฟ้าถูกปลด', 'Bolt unlock (Output#1)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('35', 'สัญญาณเตือนที่ประตูดัง', 'Alarm buzzer on (Output#2)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('36', 'สัญญาณเตือนที่ประตูเงียบ', 'Alarm buzzer off (Output#2)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('37', 'ระบบ Fire alarm ตึก ส่งสัญญาณเข้า', 'Fire alarm on (Input#3)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('38', 'ระบบ Fire alarm ตึก หยุดส่งสัญญาณเข้า', 'Fire alarm off (Input#3)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('39', 'On (Input#4)', 'On (Input#4)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('40', 'Off (Input#4)', 'Off (Input#4)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('41', 'ระบบไฟฟ้าทำงานตามปกติ', 'Power on', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('42', 'ระบบไฟฟ้าหยุดทำงาน', 'Power off', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('43', 'ระบบสั่งกระดิ่งดัง', 'Bell on (Output#3)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('44', 'ระบบสั่งกระดิ่งหยุดดัง', 'Bell off (Output#3)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('45', 'On (Output#4)', 'On (Output#4)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('46', 'Off (Output#4)', 'Off (Output#4)', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('47', 'เพิ่มรหัสพนักงานที่หัวอ่าน', 'Upload ID Table', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('48', 'ปุ่ม Door Bell บน Reader ถูกกด', 'Door bell button press', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('49', 'ปุ่มฉุกเฉิน บน Reader ถูกกด', 'Emergency button press', '0000100000');
INSERT INTO taff_data.dbevent (event_code, th_desc, en_desc, event_act) VALUES ('50', 'เครื่องถูกถอดออกจากที่ติดตั้ง', 'Tamper switch on', '0000100000');
UPDATE taff_data.dbevent SET software_act = '0000011000' WHERE (event_code <= '08') AND (software_act = '0000000000');
UPDATE taff_data.dbevent SET software_act = '0000001000' WHERE (event_code = '06' || event_code > '08') AND (software_act = '0000000000');
INSERT INTO taff_data.dbdepart (dep_code, th_desc, en_desc) VALUES('000001', 'ค่าเริ่มต้น', 'Default');
INSERT INTO taff_data.dbsection (sec_code, th_desc, en_desc, dep_code) VALUES('000001', 'ค่าเริ่มต้น', 'Default', '000001');
INSERT INTO taff_data.dbposition (pos_code, th_desc, en_desc) VALUES('000001', 'พนักงาน', 'Employee');
INSERT INTO taff_data.dbtype (type_code, th_desc, en_desc) VALUES('000001', 'พนักงานประจำ', 'Full Time');
INSERT INTO taff_data.dbgroup (group_code, th_desc, en_desc) VALUES('000000', 'ไม่มีสิทธิ์เข้า', 'No Access');
INSERT INTO taff_data.dbgroup (group_code, th_desc, en_desc) VALUES('000001', 'มีสิทธิ์เข้าได้ทุกประตู ตลอด 24 ชั่วโมง', '24 Hours All Access');
INSERT INTO taff_data.dbtimedesc (time_id, th_desc, en_desc, time1, pin_flag1, fp_flag1) VALUES('01', '24 ชั่วโมง', '24 Hours', '00002359', '1', '1');
INSERT INTO taff_data.dbtimezonedesc (time_code, th_desc, en_desc) VALUES('01', 'มีสิทธิ์เข้าได้ทุกประตู ตลอด 24 ชั่วโมง', '24 Hours All Access');
INSERT INTO taff_data.dbtimezone (time_code, day_type, time_id) VALUES('01', '1', '01');
INSERT INTO taff_data.dbtimezone (time_code, day_type, time_id) VALUES('01', '2', '01');
INSERT INTO taff_data.dbtimezone (time_code, day_type, time_id) VALUES('01', '3', '01');
INSERT INTO taff_data.dbtimezone (time_code, day_type, time_id) VALUES('01', '4', '01');
INSERT INTO taff_data.dbtimezone (time_code, day_type, time_id) VALUES('01', '5', '01');
INSERT INTO taff_data.dbtimezone (time_code, day_type, time_id) VALUES('01', '6', '01');
INSERT INTO taff_data.dbtimezone (time_code, day_type, time_id) VALUES('01', '7', '01');
INSERT INTO taff_data.dbtimezone (time_code, day_type, time_id) VALUES('01', '8', '01');
INSERT INTO taff_data.dblock (day_type) VALUES('1');
INSERT INTO taff_data.dblock (day_type) VALUES('2');
INSERT INTO taff_data.dblock (day_type) VALUES('3');
INSERT INTO taff_data.dblock (day_type) VALUES('4');
INSERT INTO taff_data.dblock (day_type) VALUES('5');
INSERT INTO taff_data.dblock (day_type) VALUES('6');
INSERT INTO taff_data.dblock (day_type) VALUES('7');
INSERT INTO taff_data.dblock (day_type) VALUES('8');
INSERT INTO taff_data.dbunlock (day_type) VALUES('1');
INSERT INTO taff_data.dbunlock (day_type) VALUES('2');
INSERT INTO taff_data.dbunlock (day_type) VALUES('3');
INSERT INTO taff_data.dbunlock (day_type) VALUES('4');
INSERT INTO taff_data.dbunlock (day_type) VALUES('5');
INSERT INTO taff_data.dbunlock (day_type) VALUES('6');
INSERT INTO taff_data.dbunlock (day_type) VALUES('7');
INSERT INTO taff_data.dbunlock (day_type) VALUES('8');
INSERT INTO taff_data.dbtimeon_out4 (day_type) VALUES('1');
INSERT INTO taff_data.dbtimeon_out4 (day_type) VALUES('2');
INSERT INTO taff_data.dbtimeon_out4 (day_type) VALUES('3');
INSERT INTO taff_data.dbtimeon_out4 (day_type) VALUES('4');
INSERT INTO taff_data.dbtimeon_out4 (day_type) VALUES('5');
INSERT INTO taff_data.dbtimeon_out4 (day_type) VALUES('6');
INSERT INTO taff_data.dbtimeon_out4 (day_type) VALUES('7');
INSERT INTO taff_data.dbtimeon_out4 (day_type) VALUES('8');
INSERT INTO taff_data.dbusers (user_name,pass_word,user_right,st_date,ex_date,user_status,user_admin,dep_code,sec_code,group_user,control_reader,monitor_location,monitor_data)  
VALUES ('admin',PASSWORD('admin'),'0',CURRENT_DATE(),CURRENT_DATE()+INTERVAL 1 YEAR,'0','1','','','','','','0');

## 3 ALTER TABLE ON TAFF_DATA (Update 17/05/2016)
ALTER TABLE taff_data.dbemployee MODIFY sn_card VARCHAR(14) DEFAULT '';

## 4 ALTER TABLE ON TAFF_DATA (Update 14/07/2016)
ALTER TABLE taff_data.dbreader ADD fing_security VARCHAR(1) DEFAULT '6';
ALTER TABLE taff_data.dbreader ADD rd2mode VARCHAR(1) DEFAULT '0';
ALTER TABLE taff_data.dbreader ADD rd2duty VARCHAR(1) DEFAULT 'O';
ALTER TABLE taff_data.dbreader ADD vdo_volume VARCHAR(1) DEFAULT '5';
ALTER TABLE taff_data.dbreader ADD screen_server VARCHAR(1) DEFAULT '1';
ALTER TABLE taff_data.dbreader ADD camera VARCHAR(1) DEFAULT '1';
ALTER TABLE taff_data.dbreader ADD capt_preview VARCHAR(1) DEFAULT '1';

## 5 ALTER TABLE ON TAFF_DATA (Update 02/02/2017)
ALTER TABLE taff_data.dbevent ADD group_img INT(1) DEFAULT '0';
UPDATE taff_data.dbevent SET group_img = '0' WHERE (event_code <= '05' || event_code = '07' || event_code = '26' || event_code = '28' || event_code = '30' || event_code = '32' 
    || event_code = '33' || event_code = '36' || event_code = '38' || event_code = '40' || event_code = '41' || event_code = '44' || event_code = '46' || event_code = '47');
UPDATE taff_data.dbevent SET group_img = '1' WHERE (event_code = '31' || event_code = '34');	
UPDATE taff_data.dbevent SET group_img = '2' WHERE (event_code = '35' || event_code = '37' || event_code = '39' || event_code = '43' || event_code = '45');	
UPDATE taff_data.dbevent SET group_img = '3' WHERE (event_code = '06' || (event_code >= '08' AND event_code <= '24'));
UPDATE taff_data.dbevent SET group_img = '4' WHERE (event_code = '25' || event_code = '27');
UPDATE taff_data.dbevent SET group_img = '5' WHERE (event_code = '29' || event_code = '48' || event_code = '49');
UPDATE taff_data.dbevent SET group_img = '6' WHERE (event_code = '42');
UPDATE taff_data.dbevent SET group_img = '7' WHERE (event_code = '50');

## 6 ALTER TABLE ON TAFF_DATA (Update 03/02/2017)
ALTER TABLE taff_data.dbreader ADD mifare_std VARCHAR(1) DEFAULT '0';
ALTER TABLE taff_data.dbreader ADD mifare_uid VARCHAR(1) DEFAULT '0';

## 7 ALTER TABLE ON TAFF_DATA (Update 2/05/2017)
ALTER TABLE taff_data.dblocation ADD group_lock VARCHAR(1) DEFAULT '';
ALTER TABLE taff_data.dblocation ADD group_unlock VARCHAR(1) DEFAULT '';
ALTER TABLE taff_data.dblocation ADD group_alarm VARCHAR(1) DEFAULT '';

## 8 ALTER TABLE ON TAFF_DATA (Update 31/05/2017)
ALTER TABLE taff_data.dbusers ADD monitor_location TEXT NOT NULL;

## 9 ALTER TABLE ON TAFF_DATA (Update 25/08/2017)
ALTER TABLE taff_data.dbusers ADD sec_code VARCHAR(6) DEFAULT '';

## 10 ALTER TABLE ON TAFF_DATA (Update 31/10/2017)
ALTER TABLE taff_data.dbdoor ADD door_type VARCHAR(1) DEFAULT '0';

##DROP TABLE IF EXISTS taff_data.proc_auto_idtables;
CREATE TABLE  taff_data.proc_auto_idtables (
  idcard VARCHAR(16) NOT NULL,
  status_no VARCHAR(1) NOT NULL,
  auto_date DATE NOT NULL,
  PRIMARY KEY (idcard,status_no,auto_date)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

## 11 ALTER TABLE ON TAFF_DATA (Update 1/11/2017)
ALTER TABLE taff_data.dbsession ADD page_jsp VARCHAR(50) DEFAULT '';
ALTER TABLE taff_data.dbsession ADD browser_info VARCHAR(50) DEFAULT '';
ALTER TABLE taff_data.dbsession ADD ip_address VARCHAR(15) DEFAULT '';

## 12 ALTER TABLE ON TAFF_DATA (Update 1/12/2017)
ALTER TABLE taff_data.dbemployee ADD template VARCHAR(1) DEFAULT '0';
ALTER TABLE taff_data.dbemployee ADD photo VARCHAR(1) DEFAULT '0';

## 13 ALTER TABLE ON TAFF_DATA (Update 24/01/2018)
##DROP TABLE IF EXISTS taff_data.dbblacklist;
CREATE TABLE  taff_data.dbblacklist (
  idcard VARCHAR(16) NOT NULL,
  record_date DATE NOT NULL,
  record_by VARCHAR(16) DEFAULT '',
  record_detail VARCHAR(250) DEFAULT '',
  cancel_date DATE DEFAULT NULL,
  cancel_by VARCHAR(16) DEFAULT '',
  cancel_detail VARCHAR(250) DEFAULT '',	
  cancel_status VARCHAR(1) DEFAULT '0',
  fullname VARCHAR(80) DEFAULT '',
  card_id VARCHAR(13) DEFAULT '',
  PRIMARY KEY (idcard,record_date)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

## 14 ALTER TABLE ON TAFF_DATA (Update 21/02/2018)
UPDATE taff_data.dbevent SET th_desc = 'ติดบัญชีดำ', en_desc = 'Error blacklist' WHERE (event_code = '06');
UPDATE taff_data.dbevent SET th_desc = 'ผ่านโดยบาร์โค้ด', en_desc = 'Success by barcode', event_act = '1000100000' WHERE (event_code = '07');
UPDATE taff_data.dbevent SET th_desc = '', en_desc = '', event_act = '0000100000' WHERE (event_code = '08');
ALTER TABLE taff_data.dbemployee ADD message VARCHAR(40) DEFAULT '';
ALTER TABLE taff_data.dbemployee ADD message_date DATE DEFAULT NULL;
ALTER TABLE taff_data.dbblacklist ADD fullname VARCHAR(80) DEFAULT '';
ALTER TABLE taff_data.dbblacklist ADD card_id VARCHAR(13) DEFAULT '';

## 15 ALTER TABLE ON TAFF_DATA (Update 05/11/2018)
ALTER TABLE taff_data.dbemployee MODIFY group_code VARCHAR(16);
ALTER TABLE taff_data.dbgroup MODIFY group_code VARCHAR(16);
ALTER TABLE taff_data.dbzone_group MODIFY group_code VARCHAR(16);

## 16 DROP AND CREATE TABLE ON TAFF_DATA (Update 27/12/2018)
DROP TABLE IF EXISTS taff_data.dbresult;
CREATE TABLE  taff_data.dbresult (
  running_code VARCHAR(27) NOT NULL,
  door_id VARCHAR(4) NOT NULL DEFAULT '',
  ip_address VARCHAR(15) DEFAULT '',
  act_request VARCHAR(2) DEFAULT '',
  act_response VARCHAR(2) DEFAULT '',
  data_request VARCHAR(50) DEFAULT '',
  data_response VARCHAR(140) DEFAULT '',
  datetime_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (running_code,door_id)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

## 17 ALTER TABLE ON TAFF_DATA (Update 17/01/2019)
ALTER TABLE taff_data.dbusers ADD monitor_data VARCHAR(1) DEFAULT '0';
UPDATE taff_data.dbusers SET monitor_data = '1' WHERE user_name = 'admin';

## 18 ALTER TABLE ON TAFF_DATA (Update 12/02/2019)
ALTER TABLE taff_data.dbreader ADD status_io VARCHAR(1) DEFAULT 'I';
ALTER TABLE taff_data.dbemployee ADD current_level VARCHAR(1) DEFAULT '0';
ALTER TABLE taff_data.dbemployee ADD current_io VARCHAR(1) DEFAULT 'O';
ALTER TABLE taff_data.dbemployee ADD current_rd VARCHAR(5) DEFAULT '';
ALTER TABLE taff_data.dbemployee ADD group_rd VARCHAR(2) DEFAULT '';

## 19 INSERT INTO TABLE ON TAFF_DATA DEFAULT VALUES (Update 08/05/2019)
INSERT INTO taff_data.dbgroup (group_code, th_desc, en_desc) VALUES('groupblacklist', 'พนักงานติดบัญชีดำ', 'Employee Blacklisted');

## 20 ALTER TABLE AND ON TAFF_DATA (Update 16/05/2019)
ALTER TABLE taff_data.dblocation ADD server_code VARCHAR(6) NOT NULL DEFAULT '';

##DROP TABLE IF EXISTS taff_data.dbserver_config;
CREATE TABLE taff_data.dbserver_config (
  server_code VARCHAR(6) NOT NULL,
  server_ip VARCHAR(15) NOT NULL,
  path_output TEXT NOT NULL,
  reader_no VARCHAR(5) DEFAULT '',
  event_code VARCHAR(2) DEFAULT '',
  access_token VARCHAR(1000) DEFAULT '',
  company_uuid VARCHAR(32) DEFAULT '',
  start_trans_id INT DEFAULT '0',
  PRIMARY KEY (server_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

## 21 ALTER TABLE ON TAFF_DATA (Update 10/06/2019)
ALTER TABLE taff_data.dbdoor ADD duplicate_ip VARCHAR(1) DEFAULT '0';

## 22 ALTER TABLE ON TAFF_DATA (Update 05/07/2019)
ALTER TABLE taff_data.dbtransaction ENGINE = InnoDB;
ALTER TABLE taff_data.dbtransaction_ev ENGINE = InnoDB;
ALTER TABLE taff_data.dbtrans_event ENGINE = InnoDB;

DROP TABLE IF EXISTS taff_data.dbqprocess;
CREATE TABLE  taff_data.dbqprocess (
  door_id VARCHAR(4) NOT NULL,
  act_request VARCHAR(1) NOT NULL,
  act_time VARCHAR(17) DEFAULT '',
  act_running VARCHAR(1) DEFAULT '',
  ip_address VARCHAR(15) DEFAULT '',
  PRIMARY KEY (door_id,act_request) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

## 23 ALTER TABLE ON TAFF_DATA (Update 22/07/2019)
ALTER TABLE taff_data.dbusers ADD group_user VARCHAR(3) DEFAULT '';
ALTER TABLE taff_data.dbusers ADD control_reader TEXT NOT NULL;
ALTER TABLE taff_data.dbgroup ADD group_user VARCHAR(3) DEFAULT '';

## 24 ALTER TABLE ON TAFF_DATA (Update 24/04/2020)
ALTER TABLE taff_data.dbserver_config ADD reader_no VARCHAR(5) DEFAULT '';
ALTER TABLE taff_data.dbserver_config ADD event_code VARCHAR(2) DEFAULT '';

## 25 ALTER TABLE ON TAFF_DATA (Update 01/10/2020)
ALTER TABLE taff_data.dbserver_config ADD access_token VARCHAR(1000) DEFAULT '';
ALTER TABLE taff_data.dbserver_config ADD company_uuid VARCHAR(32) DEFAULT '';
ALTER TABLE taff_data.dbserver_config ADD start_trans_id INT(10) unsigned DEFAULT '0';

DROP TABLE IF EXISTS taff_data.dbworkcode;
CREATE TABLE  taff_data.dbworkcode (
  work_code VARCHAR(2) NOT NULL,
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  PRIMARY KEY (work_code)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

ALTER TABLE taff_data.dbtransaction ADD work_code VARCHAR(2) DEFAULT '';
ALTER TABLE taff_data.dbtransaction_ev ADD work_code VARCHAR(2) DEFAULT '';

## 26 ALTER TABLE ON TAFF_DATA (Update 26/04/2021)
ALTER TABLE taff_data.dbtransaction ADD temperature VARCHAR(4) DEFAULT '';
ALTER TABLE taff_data.dbtransaction_ev ADD temperature VARCHAR(4) DEFAULT '';

## 27 ALTER TABLE ON TAFF_DATA (Update 09/08/2021)
ALTER TABLE taff_data.dbtransaction ADD wearmask VARCHAR(1) DEFAULT '';
ALTER TABLE taff_data.dbtransaction_ev ADD wearmask VARCHAR(1) DEFAULT '';
ALTER TABLE taff_data.dbserver_config ADD path_output_std TEXT NOT NULL;

##DROP TABLE IF EXISTS taff_data.dbmapserial;
CREATE TABLE  taff_data.dbmapserial (
  serial_no VARCHAR(20) NOT NULL,
  taff_id VARCHAR(4) NOT NULL,
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  PRIMARY KEY (serial_no)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

## 28 ALTER TABLE ON TAFF_DATA (Update 14/10/2021)
ALTER TABLE taff_data.dbserver_config ADD taff_id VARCHAR(4) DEFAULT '';
ALTER TABLE taff_data.dbserver_config ADD start_trans_id_temp INT(10) unsigned DEFAULT '0';

##DROP TABLE IF EXISTS taff_data.dbmapduty;
CREATE TABLE  taff_data.dbmapduty (
  duty_in VARCHAR(1) NOT NULL,
  duty_out VARCHAR(1) DEFAULT '',
  th_desc VARCHAR(50) DEFAULT '',
  en_desc VARCHAR(50) DEFAULT '',
  PRIMARY KEY (duty_in)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;

## 29 ALTER TABLE ON TAFF_DATA (Update 01/11/2021)
ALTER TABLE taff_data.dbdoor ADD serial_no VARCHAR(20) DEFAULT '';

## 30 ALTER TABLE ON TAFF_DATA (Update 22/12/2021)
ALTER TABLE taff_data.dbworkcode ADD map_output VARCHAR(3) DEFAULT '';

## 31 ALTER TABLE ON TAFF_DATA (Update 30/09/2022)
ALTER TABLE taff_data.dbdoor ADD time_increased_text INT(10) DEFAULT '0';

## 32 ALTER TABLE ON TAFF_DATA (Update 24/11/2023)
ALTER TABLE taff_data.dbserver_config ADD branch_code VARCHAR(6) DEFAULT '';

## 33 ALTER TABLE ON TAFF_DATA (Update 10/01/2025)
ALTER TABLE taff_data.dbdoor ADD hardware_model VARCHAR(20) DEFAULT '';
ALTER TABLE taff_data.dbemployee ADD face_sn_card VARCHAR(20) DEFAULT '';
ALTER TABLE taff_data.dbemployee ADD face_pincode VARCHAR(6) DEFAULT '';
ALTER TABLE taff_data.dbemployee ADD face_identify_mode VARCHAR(1) DEFAULT '0';
ALTER TABLE taff_data.dbemployee ADD face_date_data DATETIME;
ALTER TABLE taff_data.dbresult DROP COLUMN data_response;
ALTER TABLE taff_data.dbresult ADD data_response TEXT;
