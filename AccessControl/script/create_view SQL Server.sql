USE taff_data;

-- 1 view_transaction CONVERT(VARCHAR(26), GETDATE(), 23) (Update 07/10/2016)
GO
IF OBJECT_ID('view_transaction', 'V') IS NOT NULL DROP VIEW view_transaction;
GO
CREATE VIEW view_transaction AS
SELECT dbtransaction.date_event AS date_event,
dbtransaction.time_event AS time_event,
dbtransaction.reader_no AS reader_no,
dbtransaction.event_code AS event_code,
dbtransaction.idcard AS idcard,
dbtransaction.workday AS workday,
dbtransaction.ip_address AS ip_address,
dbtransaction.duty AS duty,
dbtransaction.datetime_update AS datetime_update,
dbtransaction.data_seq AS data_seq,
dbtransaction.data_blank AS data_blank
FROM dbtransaction
WHERE (dbtransaction.date_event = CONVERT(VARCHAR(26), GETDATE(), 23));

-- (Update 22/05/2017)
-- 2 view_trans_event = dbtrans_event union dbtransaction_ev
GO
IF OBJECT_ID('view_trans_event', 'V') IS NOT NULL DROP VIEW view_trans_event;
GO
CREATE VIEW view_trans_event AS 
(SELECT SUBSTRING (dbtrans_event.reader_no, 1, 4) AS door_id, 
MAX(CONVERT(VARCHAR(22), dbtrans_event.workday, 20) + ',' + dbtrans_event.event_code) AS dt_event
FROM dbtrans_event
WHERE (dbtrans_event.reader_no != '') 
GROUP BY dbtrans_event.reader_no)
UNION
(SELECT SUBSTRING (dbtransaction_ev.reader_no, 1, 4) AS door_id,
MAX(CONVERT(VARCHAR(22), dbtransaction_ev.workday, 20) + ',' + dbtransaction_ev.event_code) AS dt_event 
FROM dbtransaction_ev 
WHERE (dbtransaction_ev.reader_no != '')
GROUP BY dbtransaction_ev.reader_no);

-- (Update 22/05/2017)
-- 3 view_trans_monitor display door
GO
IF OBJECT_ID('view_trans_monitor', 'V') IS NOT NULL DROP VIEW view_trans_monitor;
GO
CREATE VIEW view_trans_monitor AS
SELECT vte.dt_event AS dt_event, 
SUBSTRING(vte.dt_event, 1, 19) AS workday,
SUBSTRING(vte.dt_event, 1, 10) AS date_event,
SUBSTRING(vte.dt_event, 12, 8) AS time_event,
SUBSTRING(vte.dt_event, 21, 2) AS event_code,
ev.group_img AS group_img,
ev.th_desc AS ev_th_desc,
ev.en_desc AS ev_en_desc,
d.door_id AS door_id,
d.th_desc AS th_desc,
d.en_desc AS en_desc,
d.locate_code AS locate_code,
lo.th_desc AS lo_th_desc, 
lo.en_desc AS lo_en_desc,
serve.server_ip AS server_ip
FROM view_trans_event vte
LEFT JOIN dbevent ev ON (ev.event_code = SUBSTRING(vte.dt_event, 21, 2))
RIGHT JOIN dbdoor d ON (d.door_id = vte.door_id)
LEFT JOIN dblocation lo ON (lo.locate_code = d.locate_code)
LEFT JOIN dbserver_config serve ON (serve.server_code = lo.server_code);

-- (Update 10/02/2017)
-- 4 view_report_ta
GO
IF OBJECT_ID('view_report_ta', 'V') IS NOT NULL DROP VIEW view_report_ta;
GO
CREATE VIEW view_report_ta AS
SELECT tr.date_event AS date_event,
LTRIM(RTRIM(tr.idcard)) AS idcard,
tr.duty AS duty,
SUBSTRING(CAST(tr.date_event AS VARCHAR(10)), 1, 4) AS YYYY,
SUBSTRING(CAST(tr.date_event AS VARCHAR(10)), 3, 2) AS YY,
SUBSTRING(CAST(tr.date_event AS VARCHAR(10)), 6, 2) AS MM,
SUBSTRING(CAST(tr.date_event AS VARCHAR(10)), 9, 2) AS DD,
SUBSTRING(tr.time_event, 1, 2) AS HH,
SUBSTRING(tr.time_event, 4, 2) AS MN,
SUBSTRING(tr.reader_no, 1, 4) AS taff
FROM dbtransaction tr
LEFT JOIN dbreader rd on (rd.reader_no = tr.reader_no)
WHERE (LEN(LTRIM(RTRIM(tr.idcard))) <= '7') AND (rd.reader_func = '1');

-- (Update 17/10/2017)
-- 5 view_trans_last_idcard
GO
IF OBJECT_ID('view_trans_last_idcard', 'V') IS NOT NULL DROP VIEW view_trans_last_idcard;
GO
CREATE VIEW view_trans_last_idcard AS
SELECT dbtransaction.idcard AS idcard,
MAX(dbtransaction.date_event) AS date_event,
MAX(dbtransaction.time_event) AS date_time
FROM dbtransaction 
GROUP BY dbtransaction.idcard;

-- (Update 02/06/2022)
-- 6 view_trans_event = dbtrans_event union dbtransaction_ev
GO
IF OBJECT_ID('view_trans_event', 'V') IS NOT NULL DROP VIEW view_trans_event;
GO
CREATE VIEW view_trans_event AS 
(SELECT SUBSTRING (dbtrans_event.reader_no, 1, 4) AS door_id, 
MAX(CONVERT(VARCHAR(22), dbtrans_event.workday, 20) + ',' + dbtrans_event.event_code + ',') AS dt_event
FROM dbtrans_event
WHERE (dbtrans_event.reader_no != '') 
GROUP BY dbtrans_event.reader_no)
UNION
(SELECT SUBSTRING (dbtransaction_ev.reader_no, 1, 4) AS door_id,
MAX(CONVERT(VARCHAR(22), dbtransaction_ev.workday, 20) + ',' + dbtransaction_ev.event_code + ',' + dbtransaction_ev.idcard) AS dt_event 
FROM dbtransaction_ev 
WHERE (dbtransaction_ev.reader_no != '')
GROUP BY dbtransaction_ev.reader_no);

-- (Update 02/06/2022)
-- 7 view_trans_monitor display door
GO
IF OBJECT_ID('view_trans_monitor', 'V') IS NOT NULL DROP VIEW view_trans_monitor;
GO
CREATE VIEW view_trans_monitor AS
SELECT vte.dt_event AS dt_event, 
SUBSTRING(vte.dt_event, 1, 19) AS workday,
SUBSTRING(vte.dt_event, 1, 10) AS date_event,
SUBSTRING(vte.dt_event, 12, 8) AS time_event,
SUBSTRING(vte.dt_event, 21, 2) AS event_code,
SUBSTRING(vte.dt_event, 24,16) AS idcard,
ev.group_img AS group_img,
ev.th_desc AS ev_th_desc,
ev.en_desc AS ev_en_desc,
d.door_id AS door_id,
d.th_desc AS th_desc,
d.en_desc AS en_desc,
d.locate_code AS locate_code,
lo.th_desc AS lo_th_desc, 
lo.en_desc AS lo_en_desc,
serve.server_ip AS server_ip,
emp.th_fname AS th_fname,
emp.th_sname AS th_sname,
emp.en_fname AS en_fname,
emp.en_sname AS en_sname
FROM view_trans_event vte
LEFT JOIN dbevent ev ON (ev.event_code = SUBSTRING(vte.dt_event, 21, 2))
RIGHT JOIN dbdoor d ON (d.door_id = vte.door_id)
LEFT JOIN dblocation lo ON (lo.locate_code = d.locate_code)
LEFT JOIN dbserver_config serve ON (serve.server_code = lo.server_code)
LEFT JOIN dbemployee emp ON (emp.idcard = SUBSTRING(vte.dt_event,24,16));
