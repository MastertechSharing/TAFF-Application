<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>

<% 
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "others");
	session.setAttribute("subtitle", "user_online");
	
	String action = "";
	if(request.getParameter("action") != null){
		action = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_user_online.jsp?");
	session.setAttribute("act", action);
	
	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
%>
<span/>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet"> 		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script type="text/javascript">
			function Load_DataTable(){
				$(document).ready(function() {
					$('#data_table').dataTable( {
						"aoColumnDefs": [
							{ "bSortable": false, "aTargets": [ 0, 4 ] }
						],
						"aaSorting": [
							[ 2, "desc" ]
						],
						"dom": "<fl<t>ip>",	//	<lf<t>ip>						
						
					<%	if(lang.equals("en")){	%>	
						"lengthMenu": [ [ 15, 50, 100, -1 ], [ 15, 50, 100, "All" ] ]
					<%	}else if(lang.equals("th")){	%>	
						"lengthMenu": [ [ 15, 50, 100, -1 ], [ 15, 50, 100, "ทั้งหมด" ] ],
						"oLanguage": {
							"sProcessing":   "กำลังดำเนินการ...",
							"sLengthMenu":   "แสดง _MENU_ รายการ",
							"sZeroRecords":  "ไม่พบข้อมูล",
							"sInfo":         "แสดง _START_ ถึง _END_ จาก _TOTAL_ รายการ",
							"sInfoEmpty":    "แสดง 0 ถึง 0 จาก 0 รายการ",
							"sInfoFiltered": "(กรองข้อมูลทั้งหมด จาก _MAX_ รายการ)",
							"sInfoPostFix":  "",
							"sSearch":       "ค้นหา: ",
							"sUrl":          "",
							"oPaginate": {
								"sFirst":    "หน้าแรก",
								"sPrevious": "ก่อนหน้า",
								"sNext":     "ถัดไป",
								"sLast":     "หน้าสุดท้าย"
							}
						}
					<%	}	%>	
					});
					$('.dataTables_filter').addClass('pull-left');
					$('.dataTables_length').addClass('pull-right');
					$('.dataTables_info').addClass('pull-left');
					$('.dataTables_paginate').addClass('pull-right');
					
					$('.data_table_filter, input').addClass('max-height-24');
					$('.dataTables_length, select').addClass('max-height-24');
					$('.dataTables_length, select').addClass('min-width-80');
					$('.dataTables_paginate ul').addClass('pagination-sm');
				});
			}
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Load_DataTable();">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">			
				<div class="table-responsive" style="border: 0px !important;" border="0">						
					<div style="min-width: 800px;" class="table" border="0">				
						<table style="min-width: 800px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
									<td width="3%" align="center"> </td>	
									<td width="12%" align="center"> <%= lb_username %> </td>		
									<td width="10%" align="center"> <%= lb_time %> </td>
									<td width="30%" align="center"> <%= lb_menu %> </td>
									<td width="10%" align="center"> Session ID </td>
									<td width="25%" align="center"> Browser </td>
									<td width="10%" align="center"> IP Address </td>
								</tr>
							</thead>
							<tbody>
							<%	
							String get_ses_user_id = (String)session.getAttribute("ses_user_id");
							String sql = "SELECT ses.*, u.user_name FROM dbsession ses "
									+ "LEFT OUTER JOIN dbusers u ON (ses.ses_user_name = u.user_name) "
									+ "ORDER BY ses_time DESC ";
							try{		
								ResultSet rs = stmtQry.executeQuery(sql);	
								while(rs.next()){	
								
									String ses_user_id = rs.getString("ses_user_id");
									String ses_user_name = rs.getString("ses_user_name");
									String user_name = rs.getString("user_name");
									String ses_time = sdf.format(new Date(Long.parseLong(rs.getString("ses_time"))));	
									String page_jsp = rs.getString("page_jsp");
									String browser_info = rs.getString("browser_info");
									String ip_address = rs.getString("ip_address");
									if(ip_address.equals("0:0:0:0:0:0:0:1")){
										ip_address = "127.0.0.1";
									}
									
								//	Home	========================================================================================================================================================================
										if(page_jsp.equals("monitor_door.jsp"))									page_jsp = "["+lb_home+"] "+lb_showmonitor+" ["+lb_viewdoor+"]";
										if(page_jsp.equals("monitor_map.jsp"))									page_jsp = "["+lb_home+"] "+lb_showmonitor+" ["+lb_viewmap+"]";
										if(page_jsp.equals("monitor_row.jsp"))									page_jsp = "["+lb_home+"] "+lb_showmonitor+" ["+lb_viewrow+"]";

										if(page_jsp.equals("report_105_user_pdf.jsp"))							page_jsp = "["+lb_home+"] "+lb_showmonitor;

								//	File	========================================================================================================================================================================
									//	Data System
										if(page_jsp.equals("data_server.jsp"))									page_jsp = "["+lb_database+"] "+lb_server;
										if(page_jsp.equals("data_location.jsp"))								page_jsp = "["+lb_database+"] "+lb_location;
										if(page_jsp.equals("data_door.jsp"))									page_jsp = "["+lb_database+"] "+lb_door;
										if(page_jsp.equals("data_reader.jsp"))									page_jsp = "["+lb_database+"] "+lb_reader;
										if(page_jsp.equals("data_event.jsp"))									page_jsp = "["+lb_database+"] "+lb_event;
										
									//	Data Date/Time
										if(page_jsp.equals("data_holiday.jsp"))									page_jsp = "["+lb_database+"] "+lb_holiday;
										if(page_jsp.equals("data_workcode.jsp"))								page_jsp = "["+lb_database+"] "+lb_workcode;
										if(page_jsp.equals("data_timedesc.jsp"))								page_jsp = "["+lb_database+"] "+lb_timedesc;
										if(page_jsp.equals("data_timezone.jsp"))								page_jsp = "["+lb_database+"] "+lb_time_zone;
										if(page_jsp.equals("data_unlock.jsp"))									page_jsp = "["+lb_database+"] "+lb_unlock;
										if(page_jsp.equals("data_lock.jsp"))									page_jsp = "["+lb_database+"] "+lb_lock;
										if(page_jsp.equals("data_timeonoutput4.jsp"))							page_jsp = "["+lb_database+"] "+lb_timeonoutput4;
										
									//	Data Person
										if(page_jsp.equals("data_depart.jsp"))									page_jsp = "["+lb_database+"] "+lb_depart;
										if(page_jsp.equals("data_section.jsp"))									page_jsp = "["+lb_database+"] "+lb_section;
										if(page_jsp.equals("data_position.jsp"))								page_jsp = "["+lb_database+"] "+lb_position;
										if(page_jsp.equals("data_type.jsp"))									page_jsp = "["+lb_database+"] "+lb_typeemp;
										if(page_jsp.equals("data_group.jsp"))									page_jsp = "["+lb_database+"] "+lb_group;
										if(page_jsp.equals("data_employee.jsp"))								page_jsp = "["+lb_database+"] "+lb_employee;
										if(page_jsp.equals("data_blacklist.jsp"))								page_jsp = "["+lb_database+"] "+lb_blacklist;
										if(page_jsp.equals("data_message.jsp"))									page_jsp = "["+lb_database+"] "+lb_message;

								//	Report	========================================================================================================================================================================
									//	Report Data Transaction
										if(page_jsp.equals("report_101.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_101;
										if(page_jsp.equals("report_102.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_102;
										if(page_jsp.equals("report_103.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_103;
										if(page_jsp.equals("report_104.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_104;
										if(page_jsp.equals("report_105.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_105;
										if(page_jsp.equals("report_106.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_106;
										if(page_jsp.equals("report_107.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_107;
										if(page_jsp.equals("report_108.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_108;
										if(page_jsp.equals("report_109.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_109;
										if(page_jsp.equals("report_110.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_110;
										if(page_jsp.equals("report_111.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_111;
										if(page_jsp.equals("report_112.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_112;
										if(page_jsp.equals("report_113.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_113;
										if(page_jsp.equals("report_114.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_114;
										if(page_jsp.equals("report_115.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_115;
										if(page_jsp.equals("report_151.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_151;
									
									//	Report Data Transaction [Infer]		
										if(page_jsp.equals("report_201.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_201;
										if(page_jsp.equals("report_202.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_202;
										if(page_jsp.equals("report_203.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_203;
										if(page_jsp.equals("report_204.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_204;
										if(page_jsp.equals("report_205.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_205;
										if(page_jsp.equals("report_206.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_206;
										if(page_jsp.equals("report_207.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_207;
										
									//	Report Data Event
										if(page_jsp.equals("report_301.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_301;
										if(page_jsp.equals("report_302.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_302;
										if(page_jsp.equals("report_303.jsp"))									page_jsp = "["+lb_reportname+"] "+lb_report_303;
									
									//	Report Data Right of In-Out		
										if(page_jsp.equals("report_401_pdf.jsp"))								page_jsp = "["+lb_reportname+"] "+lb_righofdoor;
										if(page_jsp.equals("report_402_pdf.jsp"))								page_jsp = "["+lb_reportname+"] "+lb_righofdoor_q;
										if(page_jsp.equals("report_403_pdf.jsp"))								page_jsp = "["+lb_reportname+"] "+lb_righofemp;
										if(page_jsp.equals("report_404_pdf.jsp"))								page_jsp = "["+lb_reportname+"] "+lb_righofemp_q;
										
									//	Report Data	& Employee Conditions
										if(page_jsp.equals("report_data1_pdf.jsp"))								page_jsp = "["+lb_reportname+"] "+lb_database;
										if(page_jsp.equals("report_employee_detail.jsp"))						page_jsp = "["+lb_reportname+"] "+lb_report_employee2;
										if(page_jsp.equals("report_blacklist.jsp"))								page_jsp = "["+lb_reportname+"] "+lb_blacklist;
										
										
								//	Connect HW	====================================================================================================================================================================
									//	Define
										if(page_jsp.equals("cmd_get_datetime.jsp"))								page_jsp = "["+lb_config+"] "+lb_getdatetime;
										if(page_jsp.equals("cmd_get_muid.jsp"))									page_jsp = "["+lb_config+"] "+lb_getdoorid;
										if(page_jsp.equals("cmd_get_version.jsp"))								page_jsp = "["+lb_config+"] "+lb_getfirmware;
										if(page_jsp.equals("cmd_get_infor.jsp"))								page_jsp = "["+lb_config+"] "+lb_getinfo;
										if(page_jsp.equals("cmd_get_network.jsp"))								page_jsp = "["+lb_config+"] "+lb_getnetwork;
										if(page_jsp.equals("cmd_get_typecru.jsp"))								page_jsp = "["+lb_config+"] "+lb_gettype;
										if(page_jsp.equals("cmd_set_datetime.jsp"))								page_jsp = "["+lb_config+"] "+lb_setdatetime;
										if(page_jsp.equals("cmd_set_muid.jsp"))									page_jsp = "["+lb_config+"] "+lb_setdoorid;
										if(page_jsp.equals("cmd_set_actionevent.jsp"))							page_jsp = "["+lb_config+"] "+lb_setactionevent;
									
									//	Set Property
										if(page_jsp.equals("cmd_set_config.jsp"))								page_jsp = "["+lb_config+"] "+lb_setconfig+" ["+lb_setproperty2+"]";
										if(page_jsp.equals("cmd_set_config2.jsp"))								page_jsp = "["+lb_config+"] "+lb_setconfig2+" ["+lb_setproperty2+"]";
										if(page_jsp.equals("cmd_set_event.jsp"))								page_jsp = "["+lb_config+"] "+lb_setevent+" ["+lb_setproperty2+"]";
										if(page_jsp.equals("cmd_set_holiday.jsp"))								page_jsp = "["+lb_config+"] "+lb_setholiday+" ["+lb_setproperty2+"]";
										if(page_jsp.equals("cmd_set_workcode.jsp"))								page_jsp = "["+lb_config+"] "+lb_setworkcode+" ["+lb_setproperty2+"]";
										if(page_jsp.equals("cmd_set_timezone.jsp"))								page_jsp = "["+lb_config+"] "+lb_settimezone+" ["+lb_setproperty2+"]";
										if(page_jsp.equals("cmd_set_unlock.jsp"))								page_jsp = "["+lb_config+"] "+lb_setunlock+" ["+lb_setproperty2+"]";
										if(page_jsp.equals("cmd_set_lock.jsp"))									page_jsp = "["+lb_config+"] "+lb_setlock+" ["+lb_setproperty2+"]";
										if(page_jsp.equals("cmd_set_timeonoutput4.jsp"))						page_jsp = "["+lb_config+"] "+lb_settimeonout4+" ["+lb_setproperty2+"]";
										if(page_jsp.equals("cmd_set_firmware.jsp"))								page_jsp = "["+lb_config+"] "+lb_setfirmware+" ["+lb_setproperty2+"]";
									
									//	Get Property
										if(page_jsp.equals("cmd_get_config.jsp"))								page_jsp = "["+lb_config+"] "+lb_getconfig+" ["+lb_getproperty2+"]";
										if(page_jsp.equals("cmd_get_config2.jsp"))								page_jsp = "["+lb_config+"] "+lb_getconfig2+" ["+lb_getproperty2+"]";
										if(page_jsp.equals("cmd_get_event.jsp"))								page_jsp = "["+lb_config+"] "+lb_getevent+" ["+lb_getproperty2+"]";
										if(page_jsp.equals("cmd_get_holiday.jsp"))								page_jsp = "["+lb_config+"] "+lb_getholiday+" ["+lb_getproperty2+"]";
										if(page_jsp.equals("cmd_get_workcode.jsp"))								page_jsp = "["+lb_config+"] "+lb_getworkcode+" ["+lb_getproperty2+"]";
										if(page_jsp.equals("cmd_get_timezone.jsp"))								page_jsp = "["+lb_config+"] "+lb_gettimezone+" ["+lb_getproperty2+"]";
										if(page_jsp.equals("cmd_get_unlock.jsp"))								page_jsp = "["+lb_config+"] "+lb_getunlock+" ["+lb_getproperty2+"]";
										if(page_jsp.equals("cmd_get_lock.jsp"))									page_jsp = "["+lb_config+"] "+lb_getlock+" ["+lb_getproperty2+"]";
										if(page_jsp.equals("cmd_get_timeonoutput4.jsp"))						page_jsp = "["+lb_config+"] "+lb_gettimeonoutput4+" ["+lb_getproperty2+"]";
										if(page_jsp.equals("cmd_get_logfile.jsp"))								page_jsp = "["+lb_config+"] "+lb_getlogfile+" ["+lb_getproperty2+"]";
									
									//	Employee Data
										if(page_jsp.equals("cmd_get_numidtable.jsp"))							page_jsp = "["+lb_config+"] "+lb_getnumid;
										if(page_jsp.equals("cmd_set_idtables.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmdA0_47;
										if(page_jsp.equals("cmd_get_idtables.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmdA1_48;
										if(page_jsp.equals("cmd_set_idtable.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd80_44;
										if(page_jsp.equals("cmd_get_idtable.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd81_45;
										if(page_jsp.equals("cmd_del_idtable.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd79;
										if(page_jsp.equals("cmd_clear_idtable.jsp"))							page_jsp = "["+lb_config+"] "+lb_cmd78;
										if(page_jsp.equals("cmd_set_idtables_blacklist.jsp"))					page_jsp = "["+lb_config+"] "+lb_cmdA0_47_blacklist;
										if(page_jsp.equals("cmd_get_numtemplate.jsp"))							page_jsp = "["+lb_config+"] "+lb_getnumtemplate;
										if(page_jsp.equals("cmd_get_template.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd21_40;
										if(page_jsp.equals("cmd_clear_template.jsp"))							page_jsp = "["+lb_config+"] "+lb_cmd23;
										if(page_jsp.equals("cmd_set_picture.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd63;
										if(page_jsp.equals("cmd_get_picture.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd11;
										if(page_jsp.equals("cmd_del_picture.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmdD1;
									
									//	Data Card
										if(page_jsp.equals("cmd_read_typecard.jsp"))							page_jsp = "["+lb_config+"] "+lb_readtypecard;
										if(page_jsp.equals("cmd_read_card.jsp"))								page_jsp = "["+lb_config+"] "+lb_readcard;
										if(page_jsp.equals("cmd_read_transcard.jsp"))							page_jsp = "["+lb_config+"] "+lb_readtrancard;
										if(page_jsp.equals("cmd_read_serialcard.jsp"))							page_jsp = "["+lb_config+"] "+lb_readserialcard;
										if(page_jsp.equals("cmd_enroll_finger.jsp"))							page_jsp = "["+lb_config+"] "+lb_enrollfp;
										if(page_jsp.equals("cmd_write_card.jsp"))								page_jsp = "["+lb_config+"] "+lb_writecard_other;
										if(page_jsp.equals("cmd_write_card_mas.jsp"))							page_jsp = "["+lb_config+"] "+lb_writecardmas;
									
									//	Data Transaction
										if(page_jsp.equals("cmd_get_transaction.jsp"))							page_jsp = "["+lb_config+"] "+lb_cmd56;
										if(page_jsp.equals("cmd_dump_transaction.jsp"))							page_jsp = "["+lb_config+"] "+lb_cmd57;
										if(page_jsp.equals("cmd_dump_transbydatetime.jsp"))						page_jsp = "["+lb_config+"] "+lb_cmd69;
										if(page_jsp.equals("cmd_get_capture.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd10;
										if(page_jsp.equals("cmd_del_capture.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmdD0;
									
									//	Picture&Multimedia
										if(page_jsp.equals("cmd_set_screen.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd62;
										if(page_jsp.equals("cmd_set_video.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd64;
										if(page_jsp.equals("cmd_set_slide.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd65;
										if(page_jsp.equals("cmd_set_sound.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd66;
										if(page_jsp.equals("cmd_del_screen.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmd62_del;
										if(page_jsp.equals("cmd_del_video.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmdD2;
										if(page_jsp.equals("cmd_del_slide.jsp"))								page_jsp = "["+lb_config+"] "+lb_cmdD3;
										if(page_jsp.equals("cmd_get_listvideo.jsp"))							page_jsp = "["+lb_config+"] "+lb_cmd12;
										if(page_jsp.equals("cmd_get_listslide.jsp"))							page_jsp = "["+lb_config+"] "+lb_cmd13;
									
									//  Face
										if(page_jsp.equals("cmd_face_set_datetime.jsp"))						page_jsp = "["+lb_config+"] "+lb_face_setdatetime;
										if(page_jsp.equals("cmd_face_get_infor.jsp"))							page_jsp = "["+lb_config+"] "+lb_face_getinfo;
										if(page_jsp.equals("cmd_face_set_infor.jsp"))							page_jsp = "["+lb_config+"] "+lb_face_setinfo;
										if(page_jsp.equals("cmd_face_get_employee_list.jsp"))					page_jsp = "["+lb_config+"] "+lb_face_getemployeelist;
										if(page_jsp.equals("cmd_face_get_employee.jsp"))						page_jsp = "["+lb_config+"] "+lb_face_getemployee;
										if(page_jsp.equals("cmd_face_set_employee.jsp"))						page_jsp = "["+lb_config+"] "+lb_face_setemployee;
										if(page_jsp.equals("cmd_face_del_employee.jsp"))						page_jsp = "["+lb_config+"] "+lb_face_delemployee;
										if(page_jsp.equals("cmd_face_set_employees.jsp"))						page_jsp = "["+lb_config+"] "+lb_face_setemployees;
										if(page_jsp.equals("cmd_face_get_transaction.jsp"))						page_jsp = "["+lb_config+"] "+lb_face_gettransaction;

								//	System Info	====================================================================================================================================================================
										if(page_jsp.equals("view_configcompany.jsp"))							page_jsp = "["+lb_systeminfo+"] "+lb_configcom;
										if(page_jsp.equals("view_configcorp.jsp"))								page_jsp = "["+lb_systeminfo+"] "+lb_configcorp;
										if(page_jsp.equals("data_user.jsp"))									page_jsp = "["+lb_systeminfo+"] "+lb_setuser;
										if(page_jsp.equals("data_report.jsp"))									page_jsp = "["+lb_systeminfo+"] "+lb_edit_reportname;

								//	Tools	========================================================================================================================================================================
									//	Import Data [TXT]
										if(page_jsp.equals("file_upload_depart.jsp"))							page_jsp = "["+lb_special+"] "+lb_depart+" ["+lb_import+"]";
										if(page_jsp.equals("file_upload_section.jsp"))							page_jsp = "["+lb_special+"] "+lb_section+" ["+lb_import+"]";
										if(page_jsp.equals("file_upload_position.jsp"))							page_jsp = "["+lb_special+"] "+lb_position+" ["+lb_import+"]";
										if(page_jsp.equals("file_upload_type.jsp"))								page_jsp = "["+lb_special+"] "+lb_typeemp+" ["+lb_import+"]";
										if(page_jsp.equals("file_upload_group.jsp"))							page_jsp = "["+lb_special+"] "+lb_group+" ["+lb_import+"]";
										if(page_jsp.equals("file_upload_employee.jsp"))							page_jsp = "["+lb_special+"] "+lb_employee+" ["+lb_import+"]";
										if(page_jsp.equals("file_upload_employee2.jsp"))						page_jsp = "["+lb_special+"] "+lb_employee+" ["+lb_master_data+"] ["+lb_import+"]";
										if(page_jsp.equals("file_upload_blacklist.jsp"))						page_jsp = "["+lb_special+"] "+lb_blacklist+" ["+lb_import+"]";
										if(page_jsp.equals("file_upload_message.jsp"))							page_jsp = "["+lb_special+"] "+lb_message+" ["+lb_import+"]";
										if(page_jsp.equals("file_upload_auto_idtable.jsp"))						page_jsp = "["+lb_special+"] "+lb_auto_idtable+" ["+lb_import+"]";
									
									//	Export Data [TXT]
										if(page_jsp.equals("depart"))											page_jsp = "["+lb_special+"] "+lb_depart+" ["+lb_export+"]";
										if(page_jsp.equals("section"))											page_jsp = "["+lb_special+"] "+lb_section+" ["+lb_export+"]";
										if(page_jsp.equals("position"))											page_jsp = "["+lb_special+"] "+lb_position+" ["+lb_export+"]";
										if(page_jsp.equals("type"))												page_jsp = "["+lb_special+"] "+lb_typeemp+" ["+lb_export+"]";
										if(page_jsp.equals("group"))											page_jsp = "["+lb_special+"] "+lb_group+" ["+lb_export+"]";
										if(page_jsp.equals("employee"))											page_jsp = "["+lb_special+"] "+lb_employee+" ["+lb_export+"]";
										if(page_jsp.equals("employee2"))										page_jsp = "["+lb_special+"] "+lb_employee+" ["+lb_master_data+"] ["+lb_export+"]";
									
									//	Process Files
										if(page_jsp.equals("file_upload_taff.jsp"))								page_jsp = "["+lb_special+"] "+lb_import_data_taff;
										if(page_jsp.equals("file_upload_text.jsp"))								page_jsp = "["+lb_special+"] "+lb_import_data_text;
										if(page_jsp.equals("file_upload_trans.jsp"))							page_jsp = "["+lb_special+"] "+lb_transaction_file;
									
									//	Delete Data
										if(page_jsp.equals("delete_transaction.jsp"))							page_jsp = "["+lb_special+"] "+lb_del_trans;
										if(page_jsp.equals("delete_employee.jsp"))								page_jsp = "["+lb_special+"] "+lb_del_emp_conditions;
									
									//	Another
										if(page_jsp.equals("file_download_taff.jsp"))							page_jsp = "["+lb_special+"] "+lb_downloaddata;
										if(page_jsp.equals("file_download_txt.jsp"))							page_jsp = "["+lb_special+"] "+lb_downloaddata2;
										if(page_jsp.equals("file_download_txt_conditions.jsp"))					page_jsp = "["+lb_special+"] "+lb_downloaddata_conditions;
										if(page_jsp.equals("gen_data_idtables.jsp"))							page_jsp = "["+lb_special+"] "+lb_download_from_employee;
										if(page_jsp.equals("gen_data_idtables_trans.jsp"))						page_jsp = "["+lb_special+"] "+lb_download_from_transaction;
										if(page_jsp.equals("view_logdata.jsp"))									page_jsp = "["+lb_special+"] "+lb_viewlogfile;
										if(page_jsp.equals("data_maintenance.jsp"))								page_jsp = "["+lb_special+"] "+lb_maintenance;
										if(page_jsp.equals("clear_antipassback.jsp"))							page_jsp = "["+lb_special+"] "+lb_clear_antipassback;
										if(page_jsp.equals("transaction_inout.jsp"))							page_jsp = "["+lb_special+"] "+lb_report_inout;
										if(page_jsp.equals("transaction_update_id.jsp"))						page_jsp = "["+lb_special+"] "+lb_update_idtable;
										if(page_jsp.equals("data_user_online.jsp"))								page_jsp = "["+lb_special+"] "+lb_user_online;
										
										String font_bold = "";
										if(get_ses_user_id.equals(ses_user_id)){
											font_bold = "style='font-weight: bold;'";
											if(request.getRequestURI().split("/")[2].equals("data_user_online.jsp")){
												page_jsp = "["+lb_special+"] "+lb_user_online;
											}
										}
										
							%>
								<tr>
									<td align="center">
									<%	if(user_name != null){	%>
										<img src="images/dialog-pass.png" width="20" height="20" border="0" align="absmiddle" style="cursor:default" data-toggle="tooltip" data-placement="right" title="<%= lb_log_userid %>">
									<%	}else{	%>
										<img src="images/user.png" width="20" height="20" border="0" align="absmiddle" style="cursor:default" data-toggle="tooltip" data-placement="right" title="<%= lb_log_empid %>">
									<%	}	%>
									</td>
									<td class="pad-left-10" <%= font_bold %>> <a href="#" onClick="show_detail('<%= ses_user_name %>');" data-toggle="tooltip" data-placement="right" data-html="true" title="<%= lb_viewdata %>"> <%= ses_user_name %> </a> </td>
									<td align="center" <%= font_bold %>> <%= ses_time %> </td>
									<td class="pad-left-10" <%= font_bold %>> <%= page_jsp %> </td>
									<td align="center" <%= font_bold %>> <%= ses_user_id.substring(0, 4) %>****<%= ses_user_id.substring(28) %> </td>
									<td class="pad-left-10" <%= font_bold %>> <%= browser_info %> </td>
									<td class="pad-left-10" <%= font_bold %>> <%= ip_address %> </td>
							  </tr>
							<%
									}		
									rs.close();					
								}catch(SQLException e){	
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
								}
								
							%>
							</tbody>
						</table>
					</div>
		
					<div class="col-xs-12" align="left" style="margin-left: -15px; min-width: 500px;">
						<div class="btn-group">			
							<div class="btn-group dropup">
								<button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<i class="glyphicon glyphicon-info-sign"> </i> &nbsp; <%= lb_information %> &nbsp; 
									<span class="caret"></span>
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<ul class="dropdown-menu" style="width: 220px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
									<li> <img src="images/dialog-pass.png" width="22" height="22" align="absmiddle" style="margin-left: 10px"> &nbsp; <%= lb_log_userid %> <p> </li>
									<li> <img src="images/user.png" width="22" height="22" align="absmiddle" style="margin-left: 10px"> &nbsp; <%= lb_log_empid %> </li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>
		
		<script>
			function show_detail(user_name){
				view_detail_220px.location = 'view_user.jsp?action=view&user_name='+user_name;
				$('#myModalViewDetail220px').modal('show');
			}	
			
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
					$('body').addClass('loaded');
				}
			}
		</script>		
		
		<script src="js/dropdown-menu.animated.js"></script>		
		<jsp:include page="footer.jsp" flush="true"/>		
		
	</body>
</html>
<%@ include file="../function/disconnect.jsp"%>