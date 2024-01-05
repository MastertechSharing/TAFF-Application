## For Smarttac Only
## 1
## DROP AND CREATE TABLE ON TAFF_DATA DATABASE FOR ACCESSCONTROL (Update 30/03/2012) 
DROP TABLE IF EXISTS taff_data.dbsession;
CREATE TABLE  taff_data.dbsession (
  ses_user_id VARCHAR(40) NOT NULL,
  ses_time BIGINT(20) DEFAULT NULL,
  ses_user_name VARCHAR(15) NOT NULL,
  PRIMARY KEY (ses_user_id,ses_user_name)
) ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;