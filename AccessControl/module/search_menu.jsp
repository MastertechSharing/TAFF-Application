<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.Calendar"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>

<% 
	Calendar cal = Calendar.getInstance(Locale.US);
	int day = cal.get(Calendar.DATE);
	int month = cal.get(Calendar.MONTH) + 1;
	int year = cal.get(Calendar.YEAR);
	
	String ses_user = (String)session.getAttribute("ses_username");
	int ses_per = ((Integer)session.getAttribute("ses_permission")).intValue();
	String data = new String(request.getParameter("search_menu").getBytes("ISO8859_1"), "tis-620");
	
	//	Home	========================================================================================================================================================================
	if(checkPermissionNot(ses_per, 9)){
			if(data.equals("["+lb_home+"] "+lb_showmonitor+" ["+lb_viewdoor+"]"))						out.println(" <script> window.parent.location.href = '../monitor_door.jsp'; </script> ");
			if(data.equals("["+lb_home+"] "+lb_showmonitor+" ["+lb_viewmap+"]"))						out.println(" <script> window.parent.location.href = '../monitor_map.jsp'; </script> ");
			if(data.equals("["+lb_home+"] "+lb_showmonitor+" ["+lb_viewrow+"]"))	 					out.println(" <script> window.parent.location.href = '../monitor_row.jsp'; </script> ");
	}else{
			if(data.equals("["+lb_home+"] "+lb_showmonitor))											out.println(" <script> window.parent.location.href = '../report_105_user_pdf.jsp?month="+month+"&today="+day+"&year="+year+"&reader=all&username="+ses_user+"&'; </script> ");
	}
	
	//	File	========================================================================================================================================================================
	if(checkPermissionNot(ses_per, 9)){
		//	Data System
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_database+"] "+lb_server))												out.println(" <script> window.parent.location.href = '../data_server.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_location))											out.println(" <script> window.parent.location.href = '../data_location.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_door))												out.println(" <script> window.parent.location.href = '../data_door.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_reader))	 											out.println(" <script> window.parent.location.href = '../data_reader.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_event))												out.println(" <script> window.parent.location.href = '../data_event.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_mapserial))											out.println(" <script> window.parent.location.href = '../data_mapserial.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_mapduty))											out.println(" <script> window.parent.location.href = '../data_mapduty.jsp'; </script> ");
		}
		//	Data Date/Time
		if(checkPermission(ses_per, "01234")){
			if(data.equals("["+lb_database+"] "+lb_holiday))											out.println(" <script> window.parent.location.href = '../data_holiday.jsp'; </script> ");
		if(checkPermission(ses_per, "012")){
			if(data.equals("["+lb_database+"] "+lb_workcode))											out.println(" <script> window.parent.location.href = '../data_workcode.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_timedesc))											out.println(" <script> window.parent.location.href = '../data_timedesc.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_time_zone))	 										out.println(" <script> window.parent.location.href = '../data_timezone.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_unlock))												out.println(" <script> window.parent.location.href = '../data_unlock.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_lock))	 											out.println(" <script> window.parent.location.href = '../data_lock.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_timeonoutput4))										out.println(" <script> window.parent.location.href = '../data_timeonoutput4.jsp'; </script> ");
		}}
		//	Data Person
		if(checkPermission(ses_per, "01234")){
			if(data.equals("["+lb_database+"] "+lb_depart))												out.println(" <script> window.parent.location.href = '../data_depart.jsp'; </script> ");
		}
			if(data.equals("["+lb_database+"] "+lb_section))											out.println(" <script> window.parent.location.href = '../data_section.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_position))	 										out.println(" <script> window.parent.location.href = '../data_position.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_typeemp))											out.println(" <script> window.parent.location.href = '../data_type.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_group))	 											out.println(" <script> window.parent.location.href = '../data_group.jsp'; </script> ");
			if(data.equals("["+lb_database+"] "+lb_employee))											out.println(" <script> window.parent.location.href = '../data_employee.jsp'; </script> ");
		if(checkPermission(ses_per, "03")){
			if(data.equals("["+lb_database+"] "+lb_blacklist))											out.println(" <script> window.parent.location.href = '../data_blacklist.jsp'; </script> ");
		}
			if(data.equals("["+lb_database+"] "+lb_message))											out.println(" <script> window.parent.location.href = '../data_message.jsp'; </script> ");
	}		
	
	//	Report	========================================================================================================================================================================
		//	Report Data Transaction
			if(data.equals("["+lb_reportname+"] "+lb_report_101))										out.println(" <script> window.parent.location.href = '../report_101.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_102))										out.println(" <script> window.parent.location.href = '../report_102.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_103))										out.println(" <script> window.parent.location.href = '../report_103.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_104))										out.println(" <script> window.parent.location.href = '../report_104.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_105))										out.println(" <script> window.parent.location.href = '../report_105.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_106))										out.println(" <script> window.parent.location.href = '../report_106.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_107))										out.println(" <script> window.parent.location.href = '../report_107.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_108))										out.println(" <script> window.parent.location.href = '../report_108.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_109))										out.println(" <script> window.parent.location.href = '../report_109.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_110))										out.println(" <script> window.parent.location.href = '../report_110.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_111))										out.println(" <script> window.parent.location.href = '../report_111.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_112))										out.println(" <script> window.parent.location.href = '../report_112.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_113))										out.println(" <script> window.parent.location.href = '../report_113.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_114))										out.println(" <script> window.parent.location.href = '../report_114.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_151))										out.println(" <script> window.parent.location.href = '../report_151.jsp'; </script> ");
		
		//	Report Data Transaction [Infer]		
			if(data.equals("["+lb_reportname+"] "+lb_report_201))										out.println(" <script> window.parent.location.href = '../report_201.jsp'; </script> ");
		if(checkPermission(ses_per, "01234")){
			if(data.equals("["+lb_reportname+"] "+lb_report_202))										out.println(" <script> window.parent.location.href = '../report_202.jsp'; </script> ");
		}
			if(data.equals("["+lb_reportname+"] "+lb_report_203))										out.println(" <script> window.parent.location.href = '../report_203.jsp'; </script> ");
		if(checkPermission(ses_per, "01234")){	
			if(data.equals("["+lb_reportname+"] "+lb_report_204))										out.println(" <script> window.parent.location.href = '../report_204.jsp'; </script> ");
		}
			if(data.equals("["+lb_reportname+"] "+lb_report_205))										out.println(" <script> window.parent.location.href = '../report_205.jsp'; </script> ");
		if(checkPermission(ses_per, "01234")){
			if(data.equals("["+lb_reportname+"] "+lb_report_206))										out.println(" <script> window.parent.location.href = '../report_206.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_207))										out.println(" <script> window.parent.location.href = '../report_207.jsp'; </script> ");
		}
		
		//	Report Data Event
			if(data.equals("["+lb_reportname+"] "+lb_report_301))										out.println(" <script> window.parent.location.href = '../report_301.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_302))										out.println(" <script> window.parent.location.href = '../report_302.jsp'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_303))										out.println(" <script> window.parent.location.href = '../report_303.jsp'; </script> ");
		
		//	Report Data Right of In-Out		
		if(checkPermissionNot(ses_per, 9)){
			if(data.equals("["+lb_reportname+"] "+lb_righofdoor))										out.println(" <script> window.parent.location.href = '../report_401_pdf.jsp?file=InOutByDoor'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_righofdoor_q))										out.println(" <script> window.parent.location.href = '../report_402_pdf.jsp?file=InOutByDoorQuick'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_righofemp))										out.println(" <script> window.parent.location.href = '../report_403_pdf.jsp?file=InOutByPerson'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_righofemp_q))										out.println(" <script> window.parent.location.href = '../report_404_pdf.jsp?file=InOutByPersonQuick'; </script> ");
		}
		
	if(checkPermissionNot(ses_per, 9)){
		//	Report Data System
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_reportname+"] "+lb_location))											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=location'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_door))												out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=door'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_reader))	 										out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=reader'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_event))											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=event'; </script> ");
		}
		//	Report Data Date/Time
		if(checkPermission(ses_per, "01234")){
			if(data.equals("["+lb_reportname+"] "+lb_holiday))											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=holiday'; </script> ");
		if(checkPermission(ses_per, "012")){
			if(data.equals("["+lb_reportname+"] "+lb_workcode))											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=workcode'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_timedesc))											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=timedesc'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_time_zone))	 									out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=timezone'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_unlock))											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=unlock'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_lock))	 											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=lock'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_timeonoutput4))									out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=timeonoutput4'; </script> ");
		}}
		
		//	Report Data Person
		if(checkPermission(ses_per, "01234")){
			if(data.equals("["+lb_reportname+"] "+lb_depart))											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=depart'; </script> ");
		}
			if(data.equals("["+lb_reportname+"] "+lb_section))											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=section'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_position))	 										out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=position'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_typeemp))											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=type_employee'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_group))	 										out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=group'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_employee))											out.println(" <script> window.parent.location.href = '../report_data1_pdf.jsp?file=employee'; </script> ");
			if(data.equals("["+lb_reportname+"] "+lb_report_employee2))									out.println(" <script> window.parent.location.href = '../report_employee_detail.jsp?file=employee2'; </script> ");
	}
	
	//	Connect HW	====================================================================================================================================================================
	if(checkPermissionNot(ses_per, 9)){
		//	Define
			if(data.equals("["+lb_config+"] "+lb_getdatetime))											out.println(" <script> window.parent.location.href = '../cmd_get_datetime.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getdoorid))											out.println(" <script> window.parent.location.href = '../cmd_get_muid.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getfirmware))											out.println(" <script> window.parent.location.href = '../cmd_get_version.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getinfo))												out.println(" <script> window.parent.location.href = '../cmd_get_infor.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getnetwork))											out.println(" <script> window.parent.location.href = '../cmd_get_network.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_gettype))												out.println(" <script> window.parent.location.href = '../cmd_get_typecru.jsp'; </script> ");
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_config+"] "+lb_setdatetime))											out.println(" <script> window.parent.location.href = '../cmd_set_datetime.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_setdoorid))											out.println(" <script> window.parent.location.href = '../cmd_set_muid.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_setactionevent))										out.println(" <script> window.parent.location.href = '../cmd_set_actionevent.jsp'; </script> ");
		}
		
		//	Set Property
		if(checkPermission(ses_per, "03")){
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_config+"] "+lb_setconfig+" ["+lb_setproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_set_config.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_setconfig2+" ["+lb_setproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_set_config2.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_setevent+" ["+lb_setproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_set_event.jsp'; </script> ");
		}
			if(data.equals("["+lb_config+"] "+lb_setholiday+" ["+lb_setproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_set_holiday.jsp'; </script> ");
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_config+"] "+lb_setworkcode+" ["+lb_setproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_set_workcode.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_settimezone+" ["+lb_setproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_set_timezone.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_setunlock+" ["+lb_setproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_set_unlock.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_setlock+" ["+lb_setproperty2+"]"))						out.println(" <script> window.parent.location.href = '../cmd_set_lock.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_settimeonout4+" ["+lb_setproperty2+"]"))				out.println(" <script> window.parent.location.href = '../cmd_set_timeonoutput4.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_setfirmware+" ["+lb_setproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_set_firmware.jsp'; </script> ");
		}}
		
		//	Get Property
			if(data.equals("["+lb_config+"] "+lb_getconfig+" ["+lb_getproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_get_config.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getconfig2+" ["+lb_getproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_get_config2.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getevent+" ["+lb_getproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_get_event.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getholiday+" ["+lb_getproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_get_holiday.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getworkcode+" ["+lb_getproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_get_workcode.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_gettimezone+" ["+lb_getproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_get_timezone.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getunlock+" ["+lb_getproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_get_unlock.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getlock+" ["+lb_getproperty2+"]"))						out.println(" <script> window.parent.location.href = '../cmd_get_lock.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_gettimeonoutput4+" ["+lb_getproperty2+"]"))			out.println(" <script> window.parent.location.href = '../cmd_get_timeonoutput4.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_getlogfile+" ["+lb_getproperty2+"]"))					out.println(" <script> window.parent.location.href = '../cmd_get_logfile.jsp'; </script> ");
		
		//	Employee Data
			if(data.equals("["+lb_config+"] "+lb_getnumid))												out.println(" <script> window.parent.location.href = '../cmd_get_numidtable.jsp'; </script> ");
		if(checkPermission(ses_per, "0135")){
			if(data.equals("["+lb_config+"] "+lb_cmdA0_47))												out.println(" <script> window.parent.location.href = '../cmd_set_idtables.jsp'; </script> ");
		}
			if(data.equals("["+lb_config+"] "+lb_cmdA1_48))												out.println(" <script> window.parent.location.href = '../cmd_get_idtables.jsp'; </script> ");
		if(checkPermission(ses_per, "0135")){
			if(data.equals("["+lb_config+"] "+lb_cmd80_44))												out.println(" <script> window.parent.location.href = '../cmd_set_idtable.jsp'; </script> ");
		}
			if(data.equals("["+lb_config+"] "+lb_cmd81_45))												out.println(" <script> window.parent.location.href = '../cmd_get_idtable.jsp'; </script> ");
		if(checkPermission(ses_per, "0135")){
			if(data.equals("["+lb_config+"] "+lb_cmd79))												out.println(" <script> window.parent.location.href = '../cmd_del_idtable.jsp'; </script> ");
		}
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_config+"] "+lb_cmd78))												out.println(" <script> window.parent.location.href = '../cmd_clear_idtable.jsp'; </script> ");
		}
			if(data.equals("["+lb_config+"] "+lb_getnumtemplate))										out.println(" <script> window.parent.location.href = '../cmd_get_numtemplate.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_cmd21_40))												out.println(" <script> window.parent.location.href = '../cmd_get_template.jsp'; </script> ");
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_config+"] "+lb_cmd23))												out.println(" <script> window.parent.location.href = '../cmd_clear_template.jsp'; </script> ");
		}
		if(checkPermission(ses_per, "0135")){
			if(data.equals("["+lb_config+"] "+lb_cmd63))												out.println(" <script> window.parent.location.href = '../cmd_set_picture.jsp'; </script> ");
		}
			if(data.equals("["+lb_config+"] "+lb_cmd11))												out.println(" <script> window.parent.location.href = '../cmd_get_picture.jsp'; </script> ");
		if(checkPermission(ses_per, "0135")){
			if(data.equals("["+lb_config+"] "+lb_cmdD1))												out.println(" <script> window.parent.location.href = '../cmd_del_picture.jsp'; </script> ");
		}
		if(checkPermission(ses_per, "0")){
		//	if(data.equals("["+lb_config+"] "+lb_cmd87))												out.println(" <script> window.parent.location.href = '../cmd_set_admin.jsp'; </script> ");
		//	if(data.equals("["+lb_config+"] "+lb_cmd88))												out.println(" <script> window.parent.location.href = '../cmd_get_listadmin.jsp'; </script> ");
		}
		
		//	Data Card
			if(data.equals("["+lb_config+"] "+lb_readtypecard))											out.println(" <script> window.parent.location.href = '../cmd_read_typecard.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_readcard))												out.println(" <script> window.parent.location.href = '../cmd_read_card.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_readtrancard))											out.println(" <script> window.parent.location.href = '../cmd_read_transcard.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_readserialcard))										out.println(" <script> window.parent.location.href = '../cmd_read_serialcard.jsp'; </script> ");
		if(checkPermission(ses_per, "0135")){
			if(data.equals("["+lb_config+"] "+lb_enrollfp))												out.println(" <script> window.parent.location.href = '../cmd_enroll_finger.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_writecard_other))										out.println(" <script> window.parent.location.href = '../cmd_write_card.jsp'; </script> ");
		}
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_config+"] "+lb_writecardmas))											out.println(" <script> window.parent.location.href = '../cmd_write_card_mas.jsp'; </script> ");
		}
		
		//	Data Transaction
			if(data.equals("["+lb_config+"] "+lb_cmd56))												out.println(" <script> window.parent.location.href = '../cmd_get_transaction.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_cmd57))												out.println(" <script> window.parent.location.href = '../cmd_dump_transaction.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_cmd69))												out.println(" <script> window.parent.location.href = '../cmd_dump_transbydatetime.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_cmd10))												out.println(" <script> window.parent.location.href = '../cmd_get_capture.jsp'; </script> ");
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_config+"] "+lb_cmdD0))												out.println(" <script> window.parent.location.href = '../cmd_del_capture.jsp'; </script> ");
		}
		
		//	Picture&Multimedia
		if(checkPermission(ses_per, "03")){
			if(data.equals("["+lb_config+"] "+lb_cmd62))												out.println(" <script> window.parent.location.href = '../cmd_set_screen.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_cmd64))												out.println(" <script> window.parent.location.href = '../cmd_set_video.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_cmd65))												out.println(" <script> window.parent.location.href = '../cmd_set_slide.jsp'; </script> ");
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_config+"] "+lb_cmd66))												out.println(" <script> window.parent.location.href = '../cmd_set_sound.jsp'; </script> ");
		}
			if(data.equals("["+lb_config+"] "+lb_cmd62_del))											out.println(" <script> window.parent.location.href = '../cmd_del_screen.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_cmdD2))												out.println(" <script> window.parent.location.href = '../cmd_del_video.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_cmdD3))												out.println(" <script> window.parent.location.href = '../cmd_del_slide.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_cmd12))												out.println(" <script> window.parent.location.href = '../cmd_get_listvideo.jsp'; </script> ");
			if(data.equals("["+lb_config+"] "+lb_cmd13))												out.println(" <script> window.parent.location.href = '../cmd_get_listslide.jsp'; </script> ");
		}
	
	//	System Info	====================================================================================================================================================================
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_systeminfo+"] "+lb_configcom))										out.println(" <script> window.parent.location.href = '../view_configcompany.jsp'; </script> ");
			if(data.equals("["+lb_systeminfo+"] "+lb_configcorp))										out.println(" <script> window.parent.location.href = '../view_configcorp.jsp'; </script> ");
			if(data.equals("["+lb_systeminfo+"] "+lb_setuser))											out.println(" <script> window.parent.location.href = '../data_user.jsp'; </script> ");
		}
			if(data.equals("["+lb_systeminfo+"] "+lb_edit_reportname))									out.println(" <script> window.parent.location.href = '../data_report.jsp'; </script> ");
	
	//	Tools	========================================================================================================================================================================
		//	Import Data [TXT]
		if(checkPermission(ses_per, "0135")){
		if(checkPermission(ses_per, "03")){
			if(data.equals("["+lb_special+"] "+lb_depart+" ["+lb_import+"]"))							out.println(" <script> window.parent.location.href = '../file_upload_depart.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_section+" ["+lb_import+"]"))							out.println(" <script> window.parent.location.href = '../file_upload_section.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_position+" ["+lb_import+"]"))							out.println(" <script> window.parent.location.href = '../file_upload_position.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_typeemp+" ["+lb_import+"]"))							out.println(" <script> window.parent.location.href = '../file_upload_type.jsp'; </script> ");
		}
			if(data.equals("["+lb_special+"] "+lb_group+" ["+lb_import+"]"))							out.println(" <script> window.parent.location.href = '../file_upload_group.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_employee+" ["+lb_import+"]"))							out.println(" <script> window.parent.location.href = '../file_upload_employee.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_employee+" ["+lb_master_data+"] ["+lb_import+"]"))	out.println(" <script> window.parent.location.href = '../file_upload_employee2.jsp'; </script> ");
		if(checkPermission(ses_per, "03")){
			if(data.equals("["+lb_special+"] "+lb_blacklist+" ["+lb_import+"]"))						out.println(" <script> window.parent.location.href = '../file_upload_blacklist.jsp'; </script> ");
		}
			if(data.equals("["+lb_special+"] "+lb_message+" ["+lb_import+"]"))							out.println(" <script> window.parent.location.href = '../file_upload_message.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_auto_idtable+" ["+lb_import+"]"))						out.println(" <script> window.parent.location.href = '../file_upload_auto_idtable.jsp'; </script> ");
		
		//	Export Data [TXT]
		if(checkPermission(ses_per, "03")){
			if(data.equals("["+lb_special+"] "+lb_depart+" ["+lb_export+"]"))							out.println(" <script> window.parent.location.href = '../file_export_data.jsp?file=depart'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_section+" ["+lb_export+"]"))							out.println(" <script> window.parent.location.href = '../file_export_data.jsp?file=section'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_position+" ["+lb_export+"]"))							out.println(" <script> window.parent.location.href = '../file_export_data.jsp?file=position'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_typeemp+" ["+lb_export+"]"))							out.println(" <script> window.parent.location.href = '../file_export_data.jsp?file=type'; </script> ");
		}
			if(data.equals("["+lb_special+"] "+lb_group+" ["+lb_export+"]"))							out.println(" <script> window.parent.location.href = '../file_export_data.jsp?file=group'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_employee+" ["+lb_export+"]"))							out.println(" <script> window.parent.location.href = '../file_export_data.jsp?file=employee'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_employee+" ["+lb_master_data+"] ["+lb_export+"]"))	out.println(" <script> window.parent.location.href = '../file_export_data.jsp?file=employee2'; </script> ");
		}
		
		//	Process Files
		if(checkPermission(ses_per, "03")){
			if(data.equals("["+lb_special+"] "+lb_import_data_taff))									out.println(" <script> window.parent.location.href = '../file_upload_taff.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_import_data_text))									out.println(" <script> window.parent.location.href = '../file_upload_text.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_transaction_file))									out.println(" <script> window.parent.location.href = '../file_upload_trans.jsp'; </script> ");
		}
		
		//	Download Data
			if(data.equals("["+lb_special+"] "+lb_downloaddata))										out.println(" <script> window.parent.location.href = '../file_download_taff.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_downloaddata2))										out.println(" <script> window.parent.location.href = '../file_download_txt.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_downloaddata_conditions))								out.println(" <script> window.parent.location.href = '../file_download_txt_conditions.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_download_from_employee))								out.println(" <script> window.parent.location.href = '../gen_data_idtables.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_download_from_transaction))							out.println(" <script> window.parent.location.href = '../gen_data_idtables_trans.jsp'; </script> ");
			
		//	Delete Data
		if(checkPermission(ses_per, "013")){
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_special+"] "+lb_del_trans))											out.println(" <script> window.parent.location.href = '../delete_transaction.jsp'; </script> ");
		}
			if(data.equals("["+lb_special+"] "+lb_del_emp_conditions))									out.println(" <script> window.parent.location.href = '../delete_employee.jsp'; </script> ");
		}
		
		//	Another
			if(data.equals("["+lb_special+"] "+lb_viewlogfile))											out.println(" <script> window.parent.location.href = '../view_logdata.jsp'; </script> ");
		if(checkPermission(ses_per, "0")){
			if(data.equals("["+lb_special+"] "+lb_user_online))											out.println(" <script> window.parent.location.href = '../data_user_online.jsp'; </script> ");
		}
			if(data.equals("["+lb_special+"] "+lb_report_inout))										out.println(" <script> window.parent.location.href = '../transaction_inout.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_maintenance))											out.println(" <script> window.parent.location.href = '../data_maintenance.jsp'; </script> ");
			if(data.equals("["+lb_special+"] "+lb_update_idtable))										out.println(" <script> window.parent.location.href = '../transaction_update_id.jsp'; </script> ");
		if(checkPermission(ses_per, "0135")){
			if(data.equals("["+lb_special+"] "+lb_clear_antipassback))									out.println(" <script> window.parent.location.href = '../clear_antipassback.jsp'; </script> ");
		}
		
	}
	
%>