<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>

<%	
	String ses_user = (String)session.getAttribute("ses_username");
	String ses_user_id = (String)session.getAttribute("ses_user_id");
	String page_jsp = (String)session.getAttribute("page_jsp");
	
	boolean update_page = false;
	
//	Home	=======================================================================================
		if(page_jsp.equals("monitor_door.jsp"))									update_page = true;
		if(page_jsp.equals("monitor_map.jsp"))									update_page = true;
		if(page_jsp.equals("monitor_row.jsp"))									update_page = true;

		if(page_jsp.equals("report_105_user_pdf.jsp"))							update_page = true;

//	File	=======================================================================================
	//	Data System
		if(page_jsp.equals("data_server.jsp"))									update_page = true;
		if(page_jsp.equals("data_location.jsp"))								update_page = true;
		if(page_jsp.equals("data_door.jsp"))									update_page = true;
		if(page_jsp.equals("data_reader.jsp"))									update_page = true;
		if(page_jsp.equals("data_event.jsp"))									update_page = true;
		if(page_jsp.equals("data_mapserial.jsp"))								update_page = true;
		if(page_jsp.equals("data_mapduty.jsp"))									update_page = true;
		
	//	Data Date/Time
		if(page_jsp.equals("data_holiday.jsp"))									update_page = true;
		if(page_jsp.equals("data_workcode.jsp"))								update_page = true;
		if(page_jsp.equals("data_timedesc.jsp"))								update_page = true;
		if(page_jsp.equals("data_timezone.jsp"))								update_page = true;
		if(page_jsp.equals("data_unlock.jsp"))									update_page = true;
		if(page_jsp.equals("data_lock.jsp"))									update_page = true;
		if(page_jsp.equals("data_timeonoutput4.jsp"))							update_page = true;
		
	//	Data Person
		if(page_jsp.equals("data_depart.jsp"))									update_page = true;
		if(page_jsp.equals("data_section.jsp"))									update_page = true;
		if(page_jsp.equals("data_position.jsp"))								update_page = true;
		if(page_jsp.equals("data_type.jsp"))									update_page = true;
		if(page_jsp.equals("data_group.jsp"))									update_page = true;
		if(page_jsp.equals("data_employee.jsp"))								update_page = true;
		if(page_jsp.equals("data_blacklist.jsp"))								update_page = true;
		if(page_jsp.equals("data_message.jsp"))									update_page = true;

//	Report	=======================================================================================
	//	Report Data Transaction
		if(page_jsp.equals("report_101.jsp"))									update_page = true;
		if(page_jsp.equals("report_102.jsp"))									update_page = true;
		if(page_jsp.equals("report_103.jsp"))									update_page = true;
		if(page_jsp.equals("report_104.jsp"))									update_page = true;
		if(page_jsp.equals("report_105.jsp"))									update_page = true;
		if(page_jsp.equals("report_106.jsp"))									update_page = true;
		if(page_jsp.equals("report_107.jsp"))									update_page = true;
		if(page_jsp.equals("report_108.jsp"))									update_page = true;
		if(page_jsp.equals("report_109.jsp"))									update_page = true;
		if(page_jsp.equals("report_110.jsp"))									update_page = true;
		if(page_jsp.equals("report_111.jsp"))									update_page = true;
		if(page_jsp.equals("report_112.jsp"))									update_page = true;
		if(page_jsp.equals("report_113.jsp"))									update_page = true;
		if(page_jsp.equals("report_114.jsp"))									update_page = true;
		if(page_jsp.equals("report_151.jsp"))									update_page = true;
	
	//	Report Data Transaction [Infer]		
		if(page_jsp.equals("report_201.jsp"))									update_page = true;
		if(page_jsp.equals("report_202.jsp"))									update_page = true;
		if(page_jsp.equals("report_203.jsp"))									update_page = true;
		if(page_jsp.equals("report_204.jsp"))									update_page = true;
		if(page_jsp.equals("report_205.jsp"))									update_page = true;
		if(page_jsp.equals("report_206.jsp"))									update_page = true;
		if(page_jsp.equals("report_207.jsp"))									update_page = true;
		
	//	Report Data Event
		if(page_jsp.equals("report_301.jsp"))									update_page = true;
		if(page_jsp.equals("report_302.jsp"))									update_page = true;
		if(page_jsp.equals("report_303.jsp"))									update_page = true;
	
	//	Report Data Right of In-Out		
		if(page_jsp.equals("report_401_pdf.jsp"))								update_page = true;
		if(page_jsp.equals("report_402_pdf.jsp"))								update_page = true;
		if(page_jsp.equals("report_403_pdf.jsp"))								update_page = true;
		if(page_jsp.equals("report_404_pdf.jsp"))								update_page = true;
		
	//	Report Data	& Employee Conditions
		if(page_jsp.equals("report_data1_pdf.jsp"))								update_page = true;
		if(page_jsp.equals("report_employee_detail.jsp"))						update_page = true;
		if(page_jsp.equals("report_blacklist.jsp"))								update_page = true;
		
		
//	Connect HW	===================================================================================
	//	Define
		if(page_jsp.equals("cmd_get_datetime.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_muid.jsp"))									update_page = true;
		if(page_jsp.equals("cmd_get_version.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_infor.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_network.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_typecru.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_datetime.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_muid.jsp"))									update_page = true;
		if(page_jsp.equals("cmd_set_actionevent.jsp"))							update_page = true;
	
	//	Set Property
		if(page_jsp.equals("cmd_set_config.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_config2.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_event.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_holiday.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_workcode.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_timezone.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_unlock.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_lock.jsp"))									update_page = true;
		if(page_jsp.equals("cmd_set_timeonoutput4.jsp"))						update_page = true;
		if(page_jsp.equals("cmd_set_firmware.jsp"))								update_page = true;
	
	//	Get Property
		if(page_jsp.equals("cmd_get_config.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_config2.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_event.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_holiday.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_workcode.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_timezone.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_unlock.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_lock.jsp"))									update_page = true;
		if(page_jsp.equals("cmd_get_timeonoutput4.jsp"))						update_page = true;
		if(page_jsp.equals("cmd_get_logfile.jsp"))								update_page = true;
	
	//	Employee Data
		if(page_jsp.equals("cmd_get_numidtable.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_set_idtables.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_idtables.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_idtable.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_idtable.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_del_idtable.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_clear_idtable.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_get_numtemplate.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_get_template.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_clear_template.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_set_picture.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_picture.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_del_picture.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_admin.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_listadmin.jsp"))							update_page = true;
	
	//	Data Card
		if(page_jsp.equals("cmd_read_typecard.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_read_card.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_read_transcard.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_read_serialcard.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_enroll_finger.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_write_card.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_write_card_mas.jsp"))							update_page = true;
	
	//	Data Transaction
		if(page_jsp.equals("cmd_get_transaction.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_dump_transaction.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_dump_transbydatetime.jsp"))						update_page = true;
		if(page_jsp.equals("cmd_get_capture.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_del_capture.jsp"))								update_page = true;
	
	//	Picture&Multimedia
		if(page_jsp.equals("cmd_set_screen.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_video.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_slide.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_set_sound.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_del_screen.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_del_video.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_del_slide.jsp"))								update_page = true;
		if(page_jsp.equals("cmd_get_listvideo.jsp"))							update_page = true;
		if(page_jsp.equals("cmd_get_listslide.jsp"))							update_page = true;

//	System Info	===================================================================================
		if(page_jsp.equals("view_configcompany.jsp"))							update_page = true;
		if(page_jsp.equals("view_configcorp.jsp"))								update_page = true;
		if(page_jsp.equals("data_user.jsp"))									update_page = true;
		if(page_jsp.equals("data_report.jsp"))									update_page = true;

//	Tools	=======================================================================================
	//	Import Data [TXT]
		if(page_jsp.equals("file_upload_depart.jsp"))							update_page = true;
		if(page_jsp.equals("file_upload_section.jsp"))							update_page = true;
		if(page_jsp.equals("file_upload_position.jsp"))							update_page = true;
		if(page_jsp.equals("file_upload_type.jsp"))								update_page = true;
		if(page_jsp.equals("file_upload_group.jsp"))							update_page = true;
		if(page_jsp.equals("file_upload_employee.jsp"))							update_page = true;
		if(page_jsp.equals("file_upload_employee2.jsp"))						update_page = true;
		if(page_jsp.equals("file_upload_blacklist.jsp"))						update_page = true;
		if(page_jsp.equals("file_upload_message.jsp"))							update_page = true;
		if(page_jsp.equals("file_upload_auto_idtable.jsp"))						update_page = true;
	
	//	Export Data [TXT]
		if(page_jsp.equals("depart"))											update_page = true;
		if(page_jsp.equals("section"))											update_page = true;
		if(page_jsp.equals("position"))											update_page = true;
		if(page_jsp.equals("type"))												update_page = true;
		if(page_jsp.equals("group"))											update_page = true;
		if(page_jsp.equals("employee"))											update_page = true;
		if(page_jsp.equals("employee2"))										update_page = true;
	
	//	Process Files
		if(page_jsp.equals("file_upload_taff.jsp"))								update_page = true;
		if(page_jsp.equals("file_upload_text.jsp"))								update_page = true;
		if(page_jsp.equals("file_upload_trans.jsp"))							update_page = true;
	
	//	Download Data
		if(page_jsp.equals("file_download_taff.jsp"))							update_page = true;
		if(page_jsp.equals("file_download_txt.jsp"))							update_page = true;
		if(page_jsp.equals("file_download_txt_conditions.jsp"))					update_page = true;
		if(page_jsp.equals("gen_data_idtables.jsp"))							update_page = true;
		if(page_jsp.equals("gen_data_idtables_trans.jsp"))						update_page = true;
		
	//	Delete Data
		if(page_jsp.equals("delete_transaction.jsp"))							update_page = true;
		if(page_jsp.equals("delete_employee.jsp"))								update_page = true;
	
	//	Another
		if(page_jsp.equals("view_logdata.jsp"))									update_page = true;
		if(page_jsp.equals("data_user_online.jsp"))								update_page = true;
		if(page_jsp.equals("transaction_inout.jsp"))							update_page = true;
		if(page_jsp.equals("data_maintenance.jsp"))								update_page = true;
		if(page_jsp.equals("transaction_update_id.jsp"))						update_page = true;
		if(page_jsp.equals("clear_antipassback.jsp"))							update_page = true;
		
	if(update_page){
		String browser_info = getBrowserInfo(request.getHeader("User-Agent"));
		String ip_address = request.getRemoteAddr();
		
		stmtUp.executeUpdate("UPDATE dbsession SET page_jsp = '" + page_jsp 
				+ "', browser_info = '" + browser_info + "', ip_address = '"+ip_address
				+ "' WHERE (ses_user_id = '" + ses_user_id + "') AND (ses_user_name = '" + ses_user + "') ");
	}
%>