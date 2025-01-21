<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="server.process.ConvertData"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>

<% 	
	//	page user online
	session.setAttribute("page_jsp", request.getRequestURI().split("/")[2]);
	
	String ses_user = "", monitor_data = "";
	int ses_per = 0;
	try{
		if (session.getAttribute("ses_permission") == null) {
			response.sendRedirect("login.jsp");
		}else{
			ses_user = (String)session.getAttribute("ses_username");
		}
		if (session.getAttribute("ses_permission") == null) {
			response.sendRedirect("login.jsp");
		}else{
			ses_per = ((Integer)session.getAttribute("ses_permission")).intValue();
		}
		if (session.getAttribute("ses_permission") == null) {
			response.sendRedirect("login.jsp");
		}else{
			monitor_data = (String)session.getAttribute("ses_monitor_data");
		}
	}catch(Exception e){
		response.sendRedirect("login.jsp");
	}
	
	String act = "";
	if (session.getAttribute("act") != null) {
		act = (String)session.getAttribute("act");
	}
	if(act.equals("view")){
		act = " ["+lb_viewdata+"]";
	}else if(act.equals("add")){
		act = " ["+lb_adddata+"]";
	}else if(act.equals("edit")){
		act = " ["+lb_editdata+"]";
	}else{
		act = "";
	}
	
	Calendar cal = Calendar.getInstance(Locale.US);
	int day = cal.get(Calendar.DATE);
	int month = cal.get(Calendar.MONTH) + 1; 
	int year = cal.get(Calendar.YEAR);
	
	boolean chkformat_txt = false;
	ConvertData convData = new ConvertData();
	if(convData.GetFormatFile() != null){
		chkformat_txt = true;
	}	
%>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><%= sw_title %></title>
		<link href="css/animate.min.css" rel="stylesheet"> 
		<link href="css/dropdown-menu.animated.css" rel="stylesheet">	
		
		<script src="js/typeahead.bundle.js"></script>
		
		<%= font_face %>
		
		<style>
			.navbar { min-height: 35px; }
			.navbar .navbar-brand { padding: 0 12px;font-size: 16px;line-height: 38px;height: 38px; }
			.navbar .navbar-nav > li > a {  padding-top: 0px; padding-bottom: 0px; line-height: 38px; }
			.navbar .navbar-toggle {  margin-top: 3px; margin-bottom: 0px; padding: 8px 9px; }
			.navbar .navbar-form { margin-top: 2px; margin-bottom: 0px } 
		 
			.txt-shadow { text-shadow: 0px 1px 3px rgba(0, 0, 1, .3); }
			.marginBottom-0 { margin-bottom: 0; }
			.dropdown-submenu { position: relative; }
			.dropdown-submenu > .dropdown-menu { top: 0; left: 100%; margin-top: -6px; margin-left: -1px; -webkit-border-radius: 0 5px 5px 5px; -moz-border-radius:0 5px 5px 5px; border-radius: 0 5px 5px 5px; }
			.dropdown-submenu > a:after { display: block; content: " "; float: right; width: 0; height: 0; border-color: transparent; border-style: solid; border-width: 5px 0 5px 5px; border-left-color: #cccccc; margin-top: 5px; margin-right: -10px; }
			.dropdown-submenu:hover > a:after { border-left-color: #555; }
			.dropdown-submenu.pull-left { float: none; } 
			.dropdown-submenu.pull-left > .dropdown-menu { left: -100%; margin-left: 10px; -webkit-border-radius: 5px 0 5px 5px; -moz-border-radius: 5px 0 5px 5px; border-radius: 5px 0 5px 5px; }
		</style>
		
		<style type="text/css">
		.typeahead, .tt-query, .tt-hint { }
		.typeahead {
			background-color: #FFFFFF;
		}
		.typeahead:focus {
			border: 1px solid #1B809E;
		}
		.tt-query {
			box-shadow: 0 1px 1px rgba(0, 0, 0, 0.075) inset;
		}
		.tt-hint {
			color: #999999;
		}
		.tt-menu {
			background-color: #FFFFFF;
			border: 1px solid rgba(0, 0, 0, 0.2);
			border-radius: 5px;
			box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
			margin-top: 12px;
			margin-left: -203px;
			padding: 8px 0;
			width: 400px;
		}
		.tt-open {
			max-height: 535px;
			overflow-y: auto;
		}
		.tt-suggestion {
			font-size: 14px;
			padding: 3px 10px;
		}
		.tt-suggestion:hover {
			cursor: pointer;
			background-color: #1B809E;
			color: #FFFFFF;
		}
		.tt-suggestion p {
			margin: 0;
		}
		</style>
		
		<script type="text/javascript">
			var substringMatcher = function(strs) {
				return function findMatches(q, cb) {
					var matches = [];
					var substrRegex = new RegExp(q, 'i');
					$.each(strs, function(i, str) {
						if (substrRegex.test(str)) {
							matches.push(str);
						}
					});
					cb(matches);
				};
			};
			
			$(document).ready(function(){
				var menus = [
				<!--	Home	-->
				<%	if(checkPermissionNot(ses_per, 9)){	%>
					<%	if(monitor_data.equals("1")){	%>
					'[<%= lb_home %>] <%= lb_showmonitor %> [<%= lb_viewdoor %>]',
					'[<%= lb_home %>] <%= lb_showmonitor %> [<%= lb_viewmap %>]',
					'[<%= lb_home %>] <%= lb_showmonitor %> [<%= lb_viewrow %>]',
					<%	}	%>
				<%	}else{	%>
					'[<%= lb_home %>] <%= lb_showmonitor %>',
				<%	}	%>
				
				<%	if(checkPermission(ses_per, "0123456")){	%>
				<!--	File	-->
				<%	if(checkPermissionNot(ses_per, 9)){	%>
					<%	if(checkPermission(ses_per, "0")){	%>
					<!--	Data System	-->
					'[<%= lb_database %>] <%= lb_server %>',
					'[<%= lb_database %>] <%= lb_location %>',
					'[<%= lb_database %>] <%= lb_door %>',
					'[<%= lb_database %>] <%= lb_reader %>',
					'[<%= lb_database %>] <%= lb_event %>',
					//'[<%= lb_database %>] <%= lb_mapserial %>',
					'[<%= lb_database %>] <%= lb_mapduty %>',
					<%	}	%>
					<%	if(checkPermission(ses_per, "01234")){	%>
					<!--	Data Date/Time	-->
					'[<%= lb_database %>] <%= lb_holiday %>',
					<%	if(checkPermission(ses_per, "012")){	%>
					'[<%= lb_database %>] <%= lb_workcode %>',
					'[<%= lb_database %>] <%= lb_timedesc %>',
					'[<%= lb_database %>] <%= lb_time_zone %>',
					'[<%= lb_database %>] <%= lb_unlock %>',
					'[<%= lb_database %>] <%= lb_lock %>',
					'[<%= lb_database %>] <%= lb_timeonoutput4 %>',
					<%	}}	%>
					<!--	Data Person	-->
					<%	if(checkPermission(ses_per, "01234")){	%>
					'[<%= lb_database %>] <%= lb_depart %>',
					<%	}	%>
					'[<%= lb_database %>] <%= lb_section %>',
					'[<%= lb_database %>] <%= lb_position %>',
					'[<%= lb_database %>] <%= lb_typeemp %>',
					'[<%= lb_database %>] <%= lb_group %>',
					'[<%= lb_database %>] <%= lb_employee %>',
					<%	if(checkPermission(ses_per, "03")){	%>
					'[<%= lb_database %>] <%= lb_blacklist %>',
					<%	}	%>
					'[<%= lb_database %>] <%= lb_message %>',
				<%	}	%>
				
				<!--	Report	-->
					<!--	Report Data Transaction	-->
					'[<%= lb_reportname %>] <%= lb_report_101 %>',
					'[<%= lb_reportname %>] <%= lb_report_102 %>',
					'[<%= lb_reportname %>] <%= lb_report_103 %>',
					'[<%= lb_reportname %>] <%= lb_report_104 %>',
					'[<%= lb_reportname %>] <%= lb_report_105 %>',
					'[<%= lb_reportname %>] <%= lb_report_106 %>',
					'[<%= lb_reportname %>] <%= lb_report_107 %>',
					'[<%= lb_reportname %>] <%= lb_report_108 %>',
					'[<%= lb_reportname %>] <%= lb_report_109 %>',
					'[<%= lb_reportname %>] <%= lb_report_110 %>',
			<!--	'[<%= lb_reportname %>] <%= lb_report_111 %>',	-->
					'[<%= lb_reportname %>] <%= lb_report_112 %>',
					'[<%= lb_reportname %>] <%= lb_report_113 %>',
					'[<%= lb_reportname %>] <%= lb_report_114 %>',
					'[<%= lb_reportname %>] <%= lb_report_115 %>',
			<!--	'[<%= lb_reportname %>] <%= lb_report_151 %>',	-->
					
					<!--	Report Data Transaction [Infer]	-->
					'[<%= lb_reportname %>] <%= lb_report_201 %>',
					<%	if(checkPermission(ses_per, "01234")){	%>
					'[<%= lb_reportname %>] <%= lb_report_202 %>',
					<%	}	%>
					'[<%= lb_reportname %>] <%= lb_report_203 %>',
					<%	if(checkPermission(ses_per, "01234")){	%>
					'[<%= lb_reportname %>] <%= lb_report_204 %>',
					<%	}	%>
					'[<%= lb_reportname %>] <%= lb_report_205 %>',
					<%	if(checkPermission(ses_per, "01234")){	%>
			<!--	'[<%= lb_reportname %>] <%= lb_report_206 %>',	-->
			<!--	'[<%= lb_reportname %>] <%= lb_report_207 %>',	-->
					<%	}	%>
					
					<!--	Report Data Event	-->
					'[<%= lb_reportname %>] <%= lb_report_301 %>',
					'[<%= lb_reportname %>] <%= lb_report_302 %>',
					'[<%= lb_reportname %>] <%= lb_report_303 %>',
					
					<%	if(checkPermissionNot(ses_per, 9)){	%>
					<!--	Report Data Right of In-Out	-->
					'[<%= lb_reportname %>] <%= lb_righofdoor %>',
					'[<%= lb_reportname %>] <%= lb_righofdoor_q %>',
					'[<%= lb_reportname %>] <%= lb_righofemp %>',
					'[<%= lb_reportname %>] <%= lb_righofemp_q %>',
					<%	}	%>
					
				<%	if(checkPermissionNot(ses_per, 9)){	%>
					<%	if(checkPermission(ses_per, "0")){	%>
					<!--	Report Data System	-->
					'[<%= lb_reportname %>] <%= lb_server %>',
					'[<%= lb_reportname %>] <%= lb_location %>',
					'[<%= lb_reportname %>] <%= lb_door %>',
					'[<%= lb_reportname %>] <%= lb_reader %>',
					'[<%= lb_reportname %>] <%= lb_event %>',
					<%	}	%>
					
					<%	if(checkPermission(ses_per, "01234")){	%>
					<!--	Report Data Date/Time	-->
					'[<%= lb_reportname %>] <%= lb_holiday %>',
					<%	if(checkPermission(ses_per, "012")){	%>
					'[<%= lb_reportname %>] <%= lb_workcode %>',
					'[<%= lb_reportname %>] <%= lb_timedesc %>',
					'[<%= lb_reportname %>] <%= lb_time_zone %>',
					'[<%= lb_reportname %>] <%= lb_unlock %>',
					'[<%= lb_reportname %>] <%= lb_lock %>',
					'[<%= lb_reportname %>] <%= lb_timeonoutput4 %>',
					<%	}}	%>
					
					<!--	Report Data Person	-->
					<%	if(checkPermission(ses_per, "01234")){	%>
					'[<%= lb_reportname %>] <%= lb_depart %>',
					<%	}	%>
					'[<%= lb_reportname %>] <%= lb_section %>',
					'[<%= lb_reportname %>] <%= lb_position %>',
					'[<%= lb_reportname %>] <%= lb_typeemp %>',
					'[<%= lb_reportname %>] <%= lb_group %>',
					'[<%= lb_reportname %>] <%= lb_employee %>',
					'[<%= lb_reportname %>] <%= lb_report_employee2 %>',
				<%	}	%>
				
				<%	if(checkPermissionNot(ses_per, 9)){	%>
				<!--	Connect HW	-->	
					<!--	Define	-->
					'[<%= lb_config %>] <%= lb_getdatetime %>',
					'[<%= lb_config %>] <%= lb_getdoorid %>',
					'[<%= lb_config %>] <%= lb_getfirmware %>',
					'[<%= lb_config %>] <%= lb_getinfo %>',
					'[<%= lb_config %>] <%= lb_getnetwork %>',
					'[<%= lb_config %>] <%= lb_gettype %>',
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_config %>] <%= lb_setdatetime %>',
					'[<%= lb_config %>] <%= lb_setdoorid %>',
					'[<%= lb_config %>] <%= lb_setactionevent %>',
					<%	}	%>
					
					<%	if(checkPermission(ses_per, "03")){	%>
					<!--	Set Property	-->
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_config %>] <%= lb_setconfig %> [<%= lb_setproperty2 %>]',
					'[<%= lb_config %>] <%= lb_setconfig2 %> [<%= lb_setproperty2 %>]',
					'[<%= lb_config %>] <%= lb_setevent %> [<%= lb_setproperty2 %>]',
					<%	}	%>
					'[<%= lb_config %>] <%= lb_setholiday %> [<%= lb_setproperty2 %>]',
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_config %>] <%= lb_setworkcode %> [<%= lb_setproperty2 %>]',
					'[<%= lb_config %>] <%= lb_settimezone %> [<%= lb_setproperty2 %>]',
					'[<%= lb_config %>] <%= lb_setunlock %> [<%= lb_setproperty2 %>]',
					'[<%= lb_config %>] <%= lb_setlock %> [<%= lb_setproperty2 %>]',
					'[<%= lb_config %>] <%= lb_settimeonout4 %> [<%= lb_setproperty2 %>]',
					'[<%= lb_config %>] <%= lb_setfirmware %> [<%= lb_setproperty2 %>]',
					<%	}}	%>
					
					<!--	Get Property	-->
					'[<%= lb_config %>] <%= lb_getconfig %> [<%= lb_getproperty2 %>]',
					'[<%= lb_config %>] <%= lb_getconfig2 %> [<%= lb_getproperty2 %>]',
					'[<%= lb_config %>] <%= lb_getevent %> [<%= lb_getproperty2 %>]',
					'[<%= lb_config %>] <%= lb_getholiday %> [<%= lb_getproperty2 %>]',
					'[<%= lb_config %>] <%= lb_getworkcode %> [<%= lb_getproperty2 %>]',
					'[<%= lb_config %>] <%= lb_gettimezone %> [<%= lb_getproperty2 %>]',
					'[<%= lb_config %>] <%= lb_getunlock %> [<%= lb_getproperty2 %>]',
					'[<%= lb_config %>] <%= lb_getlock %> [<%= lb_getproperty2 %>]',
					'[<%= lb_config %>] <%= lb_gettimeonoutput4 %> [<%= lb_getproperty2 %>]',
					'[<%= lb_config %>] <%= lb_getlogfile %> [<%= lb_getproperty2 %>]',
					
					<!--	Employee Data	-->
					'[<%= lb_config %>] <%= lb_getnumid %>',
					<%	if(checkPermission(ses_per, "0135")){	%>
					'[<%= lb_config %>] <%= lb_cmdA0_47 %>',
					<%	}	%>
					'[<%= lb_config %>] <%= lb_cmdA1_48 %>',
					<%	if(checkPermission(ses_per, "0135")){	%>
					'[<%= lb_config %>] <%= lb_cmd80_44 %>',
					<%	}	%>
					'[<%= lb_config %>] <%= lb_cmd81_45 %>',
					<%	if(checkPermission(ses_per, "0135")){	%>
					'[<%= lb_config %>] <%= lb_cmd79 %>',
					<%	}	%>
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_config %>] <%= lb_cmd78 %>',
					<%	}	%>
					<%	if(checkPermission(ses_per, "0135")){	%>
					'[<%= lb_config %>] <%= lb_cmdA0_47_blacklist %>',
					<%	}	%>
					'[<%= lb_config %>] <%= lb_getnumtemplate %>',
					'[<%= lb_config %>] <%= lb_cmd21_40 %>',
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_config %>] <%= lb_cmd23 %>',
					<%	}	%>
					<%	if(checkPermission(ses_per, "0135")){	%>
					'[<%= lb_config %>] <%= lb_cmd63 %>',
					<%	}	%>
					'[<%= lb_config %>] <%= lb_cmd11 %>',
					<%	if(checkPermission(ses_per, "0135")){	%>
					'[<%= lb_config %>] <%= lb_cmdD1 %>',
					<%	}	%>
					<%	if(checkPermission(ses_per, "0")){	%>
				<!--	'[<%= lb_config %>] <%= lb_cmd87 %>',	-->
				<!--	'[<%= lb_config %>] <%= lb_cmd88 %>',	-->
					<%	}	%>
					
					<!--	Data Card	-->
					'[<%= lb_config %>] <%= lb_readtypecard %>',
					'[<%= lb_config %>] <%= lb_readcard %>',
					'[<%= lb_config %>] <%= lb_readtrancard %>',
					'[<%= lb_config %>] <%= lb_readserialcard %>',
					<%	if(checkPermission(ses_per, "0135")){	%>	
					'[<%= lb_config %>] <%= lb_enrollfp %>',
					'[<%= lb_config %>] <%= lb_writecard_other %>',
					<%	}	%>
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_config %>] <%= lb_writecardmas %>',
					<%	}	%>
					
					<%	if(checkPermission(ses_per, "03")){	%>
					<!--	Data Transaction	-->
					'[<%= lb_config %>] <%= lb_cmd56 %>',
					'[<%= lb_config %>] <%= lb_cmd57 %>',
					'[<%= lb_config %>] <%= lb_cmd69 %>',
					'[<%= lb_config %>] <%= lb_cmd10 %>',
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_config %>] <%= lb_cmdD0 %>',
					<%	}}	%>
					
					<%	if(checkPermission(ses_per, "03")){	%>
					<!--	Picture&Multimedia	-->
					'[<%= lb_config %>] <%= lb_cmd62 %>',
					'[<%= lb_config %>] <%= lb_cmd64 %>',
					'[<%= lb_config %>] <%= lb_cmd65 %>',
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_config %>] <%= lb_cmd66 %>',
					<%	}	%>
					'[<%= lb_config %>] <%= lb_cmd62_del %>',
					'[<%= lb_config %>] <%= lb_cmdD2 %>',
					'[<%= lb_config %>] <%= lb_cmdD3 %>',
					'[<%= lb_config %>] <%= lb_cmd12 %>',
					'[<%= lb_config %>] <%= lb_cmd13 %>',					
					<%	}	%>					
					'[<%= lb_config %>] <%= lb_getinfo %>',

				<!--	System Info	-->
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_systeminfo %>] <%= lb_configcom %>',
					'[<%= lb_systeminfo %>] <%= lb_configcorp %>',
					'[<%= lb_systeminfo %>] <%= lb_setuser %>',
					<%	}	%>
					'[<%= lb_systeminfo %>] <%= lb_edit_reportname %>',
					
				<!--	Tools	-->
					<%	if(checkPermission(ses_per, "0135")){	%>
					<!--	Import Data [TXT]	-->
					<%	if(checkPermission(ses_per, "03")){	%>
					'[<%= lb_special %>] <%= lb_depart %> [<%= lb_import %>]',
					'[<%= lb_special %>] <%= lb_section %> [<%= lb_import %>]',
					'[<%= lb_special %>] <%= lb_position %> [<%= lb_import %>]',
					'[<%= lb_special %>] <%= lb_typeemp %> [<%= lb_import %>]',
					'[<%= lb_special %>] <%= lb_holiday %> [<%= lb_import %>]',
					<%	}	%>
					'[<%= lb_special %>] <%= lb_group %> [<%= lb_import %>]',
					'[<%= lb_special %>] <%= lb_employee %> [<%= lb_import %>]',
					'[<%= lb_special %>] <%= lb_employee %> [<%= lb_master_data %>] [<%= lb_import %>]',
					<%	if(checkPermission(ses_per, "03")){	%>
					'[<%= lb_special %>] <%= lb_blacklist %> [<%= lb_import %>]',
					<%	}	%>
					'[<%= lb_special %>] <%= lb_message %> [<%= lb_import %>]',
			<!--	'[<%= lb_special %>] <%= lb_auto_idtable %> [<%= lb_import %>]',	-->
					
					<!--	Export Data [TXT]	-->
					<%	if(checkPermission(ses_per, "03")){	%>
					'[<%= lb_special %>] <%= lb_depart %> [<%= lb_export %>]',
					'[<%= lb_special %>] <%= lb_section %> [<%= lb_export %>]',
					'[<%= lb_special %>] <%= lb_position %> [<%= lb_export %>]',
					'[<%= lb_special %>] <%= lb_typeemp %> [<%= lb_export %>]',
					'[<%= lb_special %>] <%= lb_holiday %> [<%= lb_export %>]',
					<%	}	%>
					'[<%= lb_special %>] <%= lb_group %> [<%= lb_export %>]',
					'[<%= lb_special %>] <%= lb_employee %> [<%= lb_export %>]',
					'[<%= lb_special %>] <%= lb_employee %> [<%= lb_master_data %>] [<%= lb_export %>]',
					<%	}	%>
					
					<%	if(checkPermission(ses_per, "03")){	%>
					<!--	Process Files	-->
					'[<%= lb_special %>] <%= lb_import_data_taff %>',
					'[<%= lb_special %>] <%= lb_import_data_text %>',
					'[<%= lb_special %>] <%= lb_transaction_file %>',
					<%	}	%>
					
					<!--	Download Data	-->
					'[<%= lb_special %>] <%= lb_downloaddata %>',
					'[<%= lb_special %>] <%= lb_downloaddata2 %>',
					<%	if(chkformat_txt){	%>
					'[<%= lb_special %>] <%= lb_downloaddata_conditions %>',
					<%	}	%>
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_special %>] <%= lb_download_from_employee %>',
					'[<%= lb_special %>] <%= lb_download_from_transaction %>',
					<%	}	%>
					
					<%	if(checkPermission(ses_per, "013")){	%>
					<!--	Delete Data	-->
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_special %>] <%= lb_del_trans %>',
					<%	}	%>
					'[<%= lb_special %>] <%= lb_del_emp_conditions %>',
					<%	}	%>
					
					<!--	Another	-->
					'[<%= lb_special %>] <%= lb_viewlogfile %>',
					<%	if(checkPermission(ses_per, "0")){	%>
					'[<%= lb_special %>] <%= lb_user_online %>',
					<%	}	%>
					'[<%= lb_special %>] <%= lb_report_inout %>',
					'[<%= lb_special %>] <%= lb_maintenance %>',
					'[<%= lb_special %>] <%= lb_update_idtable %>',
					<%	if(checkPermission(ses_per, "0135")){	%>
					'[<%= lb_special %>] <%= lb_clear_antipassback %>',
					<%	}	%>
				<%	}	%>
				<%	}	%>
					''
				
				];
				
				$('.typeahead').typeahead({
					hint: true,
					highlight: true,
					minLength: 1
				}, {
					name: 'menus',
					source: substringMatcher(menus)
				});
			});
			
			function searchMenu(){
			//	var data = document.form_search.search_menu.value;
			//	frames['iframe_search'].location.href = 'module/search_menu.jsp?data='+data;
				document.form_search.action = 'module/search_menu.jsp?';
				document.form_search.target = 'iframe_search';
				document.form_search.submit();
			}
			
			(function($){
				$(document).ready(function(){
					$('ul.dropdown-menu [data-toggle=dropdown]').on('click', function(event) {
						event.preventDefault(); 
						event.stopPropagation(); 
						$(this).parent().siblings().removeClass('open');
						$(this).parent().toggleClass('open');
					});
				});
			})(jQuery);
		</script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"> 
		<!-- Navigation bar -->
		<nav class="navbar navbar-inverse navbar-fixed-top marginBottom-0" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
						<span class="sr-only"> <b> <i> TAFF </i> </b> </span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button> 
					<%	if(checkPermissionNot(ses_per, 9)){	%>
						<%	if(monitor_data.equals("0")){	%>
						<a class="navbar-brand" href="home.jsp?"> <b> <i> <font color="white"> TAFF </i> </b> </font> </a>
						<%	}else if(monitor_data.equals("1")){	%>
						<a class="navbar-brand" href="monitor_door.jsp?"> <b> <i> <font color="white"> TAFF </i> </b> </font> </a>
						<%	}	%>
					<%	}else{	%>
						<a class="navbar-brand" href="report_105_user_pdf.jsp?month=<%= month %>&today=<%= day %>&year=<%= year %>&reader=all&username=<%= ses_user %>&"> <b> <i> <font color="white"> TAFF </i> </b> </font> </a>
					<%	}	%>
				</div>
				
				<div id="navbar" class="collapse navbar-collapse">
					<ul class="nav navbar-nav">	
					<%	if(checkPermission(ses_per, "7")){	%>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <font color="white" style="font-size: 15px;"> <b> Monitor Data </b> <span class="caret"></span> </font> </a>
							<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInDown" data-dropdown-out="fadeOutUp">
								<li> <a href="monitor_door.jsp?"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_showmonitor %> [<%= lb_viewdoor %>] </a> </li>
								<li> <a href="monitor_map.jsp?"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_showmonitor %> [<%= lb_viewmap %>] </a> </li>
								<li> <a href="monitor_row.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_showmonitor %> [<%= lb_viewrow %>] </a> </li>
							</ul>
						</li>
					<%	}else if(checkPermission(ses_per, "01234569")){	%>
						<!--	File	-->
					<%	if(checkPermissionNot(ses_per, 9)){	%>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <font color="white" style="font-size: 15px;"> <b> <%= lb_database %> </b> <span class="caret"></span> </font> </a>
							<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInDown" data-dropdown-out="fadeOutUp">
								<!--	Data System	-->
							<%	if(checkPermission(ses_per, "0")){	%>
								<li class="dropdown dropdown-submenu">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_configdata %> </label> </a>
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="data_server.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_server %> </a> </li>
										<li> <a href="data_location.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_location %> </a> </li>
										<li class="divider"> </li>
										<li> <a href="data_door.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_door %> </a> </li> 
										<li> <a href="data_reader.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_reader %> </a> </li> 
										<li> <a href="data_reader_face.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_reader %> [<%= lb_face %>] </a> </li>
										<li> <a href="data_event.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_event %> </a> </li>
									<!--	<li> <a href="data_mapserial.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_mapserial %> </a> </li> -->
										<li> <a href="data_mapduty.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_mapduty %> </a> </li>										
									<!--	<li class="divider"> </li>
											-->
									</ul>
								</li> 
							<%	}	%>
								<!--	Data Date/Time	-->
							<%	if(checkPermission(ses_per, "01234")){	%>
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_abouttime %> </label> </a>
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="data_holiday.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_holiday %> </a> </li>
									<%	if(checkPermission(ses_per, "012")){	%>
										<li> <a href="data_workcode.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_workcode %> </a> </li>
										<li> <a href="data_timedesc.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_timedesc %> </a> </li>
										<li> <a href="data_timezone.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_time_zone %> </a> </li>
										<li> <a href="data_unlock.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_unlock %> </a> </li>
										<li> <a href="data_lock.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_lock %> </a> </li>
										<li> <a href="data_timeonoutput4.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_timeonoutput4 %> </a> </li>
									<%	}	%>
									</ul>
								</li>
							<%	}	%>
								<!--	Data Person	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_person %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
									<%	if(checkPermission(ses_per, "01234")){	%>
										<li> <a href="data_depart.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_depart %> </a> </li>
									<%	}	%>
										<li> <a href="data_section.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_section %> </a> </li>
										<li> <a href="data_position.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_position %> </a> </li>
										<li> <a href="data_type.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_typeemp %> </a> </li>
										<li> <a href="data_group.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_group %> </a> </li>
										<li> <a href="data_employee.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_employee %> </a> </li>
										<li class="divider"> </li>
									<%	if(checkPermission(ses_per, "03")){	%>
										<li> <a href="data_blacklist.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_blacklist %> </a> </li>
									<%	}	%>
										<li> <a href="data_message.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_message %> </a> </li>
									</ul>
								</li>
							</ul> 
						</li> 
					<%	}	%>
						
						<!--	Report	-->
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <font color="white" style="font-size: 15px;"> <b> <%= lb_reportname %> </b> <span class="caret"></span> </font> </a>
							<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInDown" data-dropdown-out="fadeOutUp">
								<!--	Report Data Transaction	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_report100 %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="report_101.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_101 %> </a> </li>
										<li> <a href="report_102.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_102 %> </a> </li>
										<li> <a href="report_103.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_103 %> </a> </li>
										<li> <a href="report_104.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_104 %> </a> </li>
										<li> <a href="report_105.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_105 %> </a> </li>
										<li> <a href="report_106.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_106 %> </a> </li>
										<li> <a href="report_107.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_107 %> </a> </li>
										<li> <a href="report_108.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_108 %> </a> </li>
										<li> <a href="report_109.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_109 %> </a> </li>
										<li> <a href="report_110.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_110 %> </a> </li>
										<!--	<li> <a href="report_111.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_111 %> </a> </li>	-->
										<li> <a href="report_112.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_112 %> </a> </li>
										<li> <a href="report_113.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_113 %> </a> </li>
										<li> <a href="report_114.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_114 %> </a> </li>
										<li> <a href="report_115.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_115 %> </a> </li>
										<!--	<li> <a href="report_151.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_151 %> </a> </li>	-->
									</ul>
								</li> 
								<!--	Report Data Transaction [Infer]	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_report200 %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="report_201.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_201 %> </a> </li>
									<%	if(checkPermission(ses_per, "01234")){	%>
										<li> <a href="report_202.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_202 %> </a> </li>
									<%	}	%>
										<li> <a href="report_203.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_203 %> </a> </li>
									<%	if(checkPermission(ses_per, "01234")){	%>
										<li> <a href="report_204.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_204 %> </a> </li>
									<%	}	%>
										<li> <a href="report_205.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_205 %> </a> </li>
									</ul>
								</li> 
								<!--	Report Data Event	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_rep_dataevent %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="report_301.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_301 %> </a> </li>
										<li> <a href="report_302.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_302 %> </a> </li>
										<li> <a href="report_303.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_303 %> </a> </li>
									</ul>
								</li> 
							<%	if(checkPermissionNot(ses_per, 9)){	%>
								<!--	Report Data Right of In-Out	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_rigthuser %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="report_401_pdf.jsp?file=InOutByDoor"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_righofdoor %> </a> </li>
										<li> <a href="report_402_pdf.jsp?file=InOutByDoorQuick"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_righofdoor_q %> </a> </li>
										<li> <a href="report_403_pdf.jsp?file=InOutByPerson"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_righofemp %> </a> </li>
										<li> <a href="report_404_pdf.jsp?file=InOutByPersonQuick"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_righofemp_q %> </a> </li>
									</ul>
								</li> 
							<%	}	%>
							<%	if(checkPermissionNot(ses_per, 9)){	%>
								<li class="divider"> </li>
								<!--	Report Data System	-->
							<%	if(checkPermission(ses_per, "0")){	%>
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_configdata %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="report_data1_pdf.jsp?file=server"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_server %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=location"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_location %> </a> </li>
										<li class="divider"> </li>
										<li> <a href="report_data1_pdf.jsp?file=door"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_door %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=reader"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_reader %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=event"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_event %> </a> </li>
									</ul>
								</li>
							<%	}	%>
								<!--	Report Data Date/Time	-->
							<%	if(checkPermission(ses_per, "01234")){	%>
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_abouttime  %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="report_data1_pdf.jsp?file=holiday"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_holiday %> </a> </li>
									<%	if(checkPermission(ses_per, "012")){	%>
										<li> <a href="report_data1_pdf.jsp?file=workcode"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_workcode %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=timedesc"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_timedesc %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=timezone"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_time_zone %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=unlock"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_unlock %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=lock"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_lock %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=timeonoutput4"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_timeonoutput4 %> </a> </li>
									<%	}	%>
									</ul>
								</li>
							<%	}	%>
								<!--	Report Data Person	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_person %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
									<%	if(checkPermission(ses_per, "01234")){	%>
										<li> <a href="report_data1_pdf.jsp?file=depart"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_depart %> </a> </li>
									<%	}	%>
										<li> <a href="report_data1_pdf.jsp?file=section"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_section %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=position"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_position %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=type_employee"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_typeemp %> </a> </li>
										<li> <a href="report_data1_pdf.jsp?file=group"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_group %> </a> </li>
										<li> <a href="report_data2_pdf.jsp?file=employee"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_employee %> </a> </li>
										<li> <a href="report_employee_detail.jsp?file=employee2"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_employee2 %> </a> </li>
										<li class="divider"> </li>
										<li> <a href="report_blacklist.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_blacklist %> </a> </li>
									</ul>
								</li>
							<%	}	%>
							</ul>
						</li> 
						<!--	Connect HW	-->
					<%	if(checkPermissionNot(ses_per, 9)){	%>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <font color="white" style="font-size: 15px;"> <b> <%= lb_config %> </b> <span class="caret"></span> </font> </a>
							<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInDown" data-dropdown-out="fadeOutUp">
								<!--	Define	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_define %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="cmd_get_datetime.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getdatetime %> </a> </li>
										<li> <a href="cmd_get_muid.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getdoorid %> </a> </li>
										<li> <a href="cmd_get_version.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getfirmware %> </a> </li>
										<li> <a href="cmd_get_infor.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getinfo %> </a> </li>
										<li> <a href="cmd_get_network.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getnetwork %> </a> </li>
										<li> <a href="cmd_get_typecru.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_gettype %> </a> </li>
									<%	if(checkPermission(ses_per, "0")){	%>
										<li class="divider"> </li>
										<li> <a href="cmd_set_datetime.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setdatetime %> </a> </li>
										<li> <a href="cmd_set_muid.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setdoorid %> </a> </li>
										<li> <a href="cmd_set_actionevent.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setactionevent %> </a> </li>
									<%	}	%>
									</ul>
								</li> 
								<!--	Set Property	-->
							<%	if(checkPermission(ses_per, "03")){	%>
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_setproperty %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
									<%	if(checkPermission(ses_per, "0")){	%>
										<li> <a href="cmd_set_config.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setconfig %> </a> </li>
										<li> <a href="cmd_set_config2.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setconfig2 %> </a> </li>
										<li class="divider"> </li>
										<li> <a href="cmd_set_event.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setevent %> </a> </li>
									<%	}	%>
										<li> <a href="cmd_set_holiday.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setholiday %> </a> </li>
									<%	if(checkPermission(ses_per, "0")){	%>
										<li> <a href="cmd_set_workcode.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setworkcode %> </a> </li>
										<li> <a href="cmd_set_timezone.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_settimezone %> </a> </li>
										<li> <a href="cmd_set_unlock.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setunlock %> </a> </li>
										<li> <a href="cmd_set_lock.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setlock %> </a> </li>
										<li> <a href="cmd_set_timeonoutput4.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_settimeonout4 %> </a> </li>
										<li class="divider"> </li>
										<li> <a href="cmd_set_firmware.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setfirmware %> </a> </li>
									<%	}	%>
									</ul>
								</li>
							<%	}	%>
								<!--	Get Property	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_getproperty %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="cmd_get_config.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getconfig %> </a> </li>
										<li> <a href="cmd_get_config2.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getconfig2 %> </a> </li>
										<li class="divider"> </li>
										<li> <a href="cmd_get_event.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getevent %> </a> </li>
										<li> <a href="cmd_get_holiday.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getholiday %> </a> </li>
										<li> <a href="cmd_get_workcode.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getworkcode %> </a> </li>
										<li> <a href="cmd_get_timezone.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_gettimezone %> </a> </li>
										<li> <a href="cmd_get_unlock.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getunlock %> </a> </li>
										<li> <a href="cmd_get_lock.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getlock %> </a> </li>
										<li> <a href="cmd_get_timeonoutput4.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_gettimeonoutput4 %> </a> </li>
										<li class="divider"> </li>
										<li> <a href="cmd_get_logfile.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getlogfile %> </a> </li>
									</ul>
								</li>
								<!--	Employee Data	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow">  <%=lb_empdata %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="cmd_get_numidtable.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getnumid %> </a> </li>
									<%	if(checkPermission(ses_per, "0135")){	%>
										<li> <a href="cmd_set_idtables.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmdA0_47 %> </a> </li>	
									<%	}	%>
										<li> <a href="cmd_get_idtables.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmdA1_48 %> </a> </li>
									<%	if(checkPermission(ses_per, "0135")){	%>
										<li> <a href="cmd_set_idtable.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd80_44 %> </a> </li>	
									<%	}	%>
										<li> <a href="cmd_get_idtable.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd81_45 %> </a> </li>
									<%	if(checkPermission(ses_per, "0135")){	%>										
										<li> <a href="cmd_del_idtable.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd79 %> </a> </li>
									<%	}	%>
									<%	if(checkPermission(ses_per, "0")){	%>	
										<li> <a href="cmd_clear_idtable.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd78 %> </a> </li>
									<%	}	%>
									<%	if(checkPermission(ses_per, "0135")){	%>	
										<li> <a href="cmd_set_idtables_blacklist.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmdA0_47_blacklist %> </a> </li>
									<%	}	%>
										<li class="divider"> </li>
										<li> <a href="cmd_get_numtemplate.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_getnumtemplate %> </a> </li>
										<li> <a href="cmd_get_template.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd21_40 %> </a> </li>
									<%	if(checkPermission(ses_per, "0")){	%>
										<li> <a href="cmd_clear_template.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd23 %> </a> </li>
									<%	}	%>
										<li class="divider"> </li>
									<%	if(checkPermission(ses_per, "0135")){	%>	
										<li> <a href="cmd_set_picture.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd63 %> </a> </li>	
									<%	}	%>
										<li> <a href="cmd_get_picture.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd11 %> </a> </li>
									<%	if(checkPermission(ses_per, "0135")){	%>	
										<li> <a href="cmd_del_picture.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmdD1 %> </a> </li>
									<%	}	%>
									<%	if(checkPermission(ses_per, "0")){	%>
									<!--	<li class="divider"> </li>
										<li> <a href="cmd_set_admin.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd87 %> </a> </li>
										<li> <a href="cmd_get_listadmin.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd88 %> </a> </li>	-->
									<%	}	%>
									</ul>
								</li>
								<!--	Data Card	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_datacard %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="cmd_read_typecard.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_readtypecard %> </a> </li>
										<li> <a href="cmd_read_card.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_readcard %> </a> </li>
										<li> <a href="cmd_read_transcard.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_readtrancard %> </a> </li>
										<li> <a href="cmd_read_serialcard.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_readserialcard %> </a> </li>
									<%	if(checkPermission(ses_per, "0135")){	%>	
										<li class="divider"> </li>
										<li> <a href="cmd_enroll_finger.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_enrollfp %> </a> </li>
										<li> <a href="cmd_write_card.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_writecard_other %> </a> </li>
									<%	}	%>
									<%	if(checkPermission(ses_per, "0")){	%>	
										<li> <a href="cmd_write_card_mas.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_writecardmas %> </a> </li>
									<%	}	%>
									</ul>
								</li>
								<!--	Data Transaction	-->
							<%	if(checkPermission(ses_per, "03")){	%>
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_datatransaction %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="cmd_get_transaction.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd56 %> </a> </li>
										<li> <a href="cmd_dump_transaction.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd57 %> </a> </li>
										<li> <a href="cmd_dump_transbydatetime.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd69 %> </a> </li>
										<li class="divider"> </li>
										<li> <a href="cmd_get_capture.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd10 %> </a> </li>
									<%	if(checkPermission(ses_per, "0")){	%>	
										<li> <a href="cmd_del_capture.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmdD0 %> </a> </li>
									<%	}	%>
									</ul>
								</li>
							<%	}	%>
							<%	if(checkPermission(ses_per, "03")){	%>
								<!--	Picture&Multimedia	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_picmulti %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="cmd_set_screen.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd62 %> </a> </li>
										<li> <a href="cmd_set_video.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd64 %> </a> </li>
										<li> <a href="cmd_set_slide.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd65 %> </a> </li>
									<%	if(checkPermission(ses_per, "0")){	%>
										<li> <a href="cmd_set_sound.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd66 %> </a> </li>
									<%	}	%>
										<li class="divider"> </li>
										<li> <a href="cmd_del_screen.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd62_del %> </a> </li>
										<li> <a href="cmd_del_video.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmdD2 %> </a> </li>
										<li> <a href="cmd_del_slide.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmdD3 %> </a> </li>
										<li class="divider"> </li>
										<li> <a href="cmd_get_listvideo.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd12 %> </a> </li>
										<li> <a href="cmd_get_listslide.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_cmd13 %> </a> </li>
									</ul>
								</li>
							<%	}	%>

								<!--	Face	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_face %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="cmd_face_set_datetime.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_face_setdatetime %> </a> </li>
										<li> <a href="cmd_face_get_infor.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_face_getinfo %> </a> </li>
										<!--<li> <a href="cmd_face_set_infor.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_face_setinfo %> </a> </li>-->
										<li> <a href="cmd_face_get_employee_list.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_face_getemployeelist %> </a> </li>
										<li> <a href="cmd_face_get_employee.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_face_getemployee %> </a> </li>
										<li> <a href="cmd_face_set_employee.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_face_setemployee %> </a> </li>
										<li> <a href="cmd_face_del_employee.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_face_delemployee %> </a> </li>
										<!--<li> <a href="cmd_face_get_transaction.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_face_gettransaction %> </a> </li>-->
									</ul>
								</li>

							</ul>
						</li>
						<!--	System Info	-->
						<li class="dropdown">							
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <font color="white" style="font-size: 15px;"> <b> <%= lb_systeminfo %> </b> <span class="caret"></span> </font> </a>
							<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInDown" data-dropdown-out="fadeOutUp">
							<%	if(checkPermission(ses_per, "0")){	%>
								<li> <a href="view_configcompany.jsp?action=data"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_configcom %> </a> </li>
								<li> <a href="view_configcorp.jsp?action=data"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_configcorp %> </a> </li>
								<li> <a href="data_user.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_setuser %> </a> </li>
							<%	}	%>
								<li> <a href="data_report.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_edit_reportname %> </a> </li>
							</ul>
						</li> 
						<!--	Tools	-->
						<li class="dropdown">							
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <font color="white" style="font-size: 15px;"> <b> <%= lb_special %> </b> <span class="caret"></span> </font> </a>
							<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInDown" data-dropdown-out="fadeOutUp">
								<!--	Import Data [TXT]	-->
							<%	if(checkPermission(ses_per, "0135")){	%>
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%=lb_import_data %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
									<%	if(checkPermission(ses_per, "03")){	%>
										<li> <a href="file_upload_depart.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_depart %> </a> </li>
										<li> <a href="file_upload_section.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_section %> </a> </li>
										<li> <a href="file_upload_position.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_position %> </a> </li>
										<li> <a href="file_upload_type.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_typeemp %> </a> </li>
										<li> <a href="file_upload_holiday.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_holiday %> </a> </li>
									<%	}	%>
										<li> <a href="file_upload_group.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_group %> </a> </li>
										<li> <a href="file_upload_employee.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_employee %> </a> </li>
										<li> <a href="file_upload_employee2.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_employee %> [<%= lb_master_data %>] </a> </li>
										<li class="divider"> </li>
									<%	if(checkPermission(ses_per, "03")){	%>
										<li> <a href="file_upload_blacklist.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_blacklist %> </a> </li>
									<%	}	%>
										<li> <a href="file_upload_message.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_message %> </a> </li>
										<!--	<li> <a href="file_upload_auto_idtable.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_auto_idtable %> </a> </li>	-->
									</ul>
								</li>
								<!--	Export Data [TXT]	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%=lb_export_data %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
									<%	if(checkPermission(ses_per, "03")){	%>
										<li> <a href="file_export_data.jsp?file=depart"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_depart %> </a> </li>
										<li> <a href="file_export_data.jsp?file=section"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_section %> </a> </li>
										<li> <a href="file_export_data.jsp?file=position"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_position %> </a> </li>
										<li> <a href="file_export_data.jsp?file=type"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_typeemp %> </a> </li>
										<li> <a href="file_export_data.jsp?file=holiday"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_holiday %> </a> </li>
									<%	}	%>
										<li> <a href="file_export_data.jsp?file=group"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_group %> </a> </li>
										<li> <a href="file_export_data.jsp?file=employee"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_employee %> </a> </li>
										<li> <a href="file_export_data.jsp?file=employee2"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_employee %> [<%= lb_master_data %>] </a> </li>
									</ul>
								</li> 
							<%	}	%>
								<!--	Process Files	-->
							<%	if(checkPermission(ses_per, "03")){	%>
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_process_files %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="file_upload_taff.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_import_data_taff %> </a> </li>
										<li> <a href="file_upload_text.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_import_data_text %> </a> </li>
										<li class="divider"> </li>
										<li> <a href="file_upload_trans.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_transaction_file %> </a> </li>
									</ul>
								</li> 
							<%	}	%>
								<!--	Download	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_download_data %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="file_download_taff.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_downloaddata %> </a> </li>
										<li> <a href="file_download_txt.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_downloaddata2 %> </a> </li>
										<%	if(chkformat_txt){	%>
										<li> <a href="file_download_txt_conditions.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_downloaddata_conditions %> </a> </li>
										<%	}	%>
									<%	if(checkPermission(ses_per, "0")){	%>
										<li class="divider"> </li>
										<li> <a href="gen_data_idtables.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_download_from_employee %> </a> </li>
										<li> <a href="gen_data_idtables_trans.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_download_from_transaction %> </a> </li>
									<%	}	%>
									</ul>
								</li>
								<!--	Delete Data	-->
							<%	if(checkPermission(ses_per, "013")){	%>
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_deletedata %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
									<%	if(checkPermission(ses_per, "0")){	%>
										<li> <a href="delete_transaction.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_del_trans %> </a> </li>
									<%	}	%>
										<li> <a href="delete_employee.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_del_emp_conditions %> </a> </li>
									</ul>
								</li> 
							<%	}	%>
								<!--	Another	-->
								<li class="dropdown dropdown-submenu"> 
									<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <label class="txt-shadow"> <%= lb_another_data %> </label> </a>	
									<ul class="dropdown-menu" style="min-width: 250px;" data-dropdown-in="fadeInLeft" data-dropdown-out="fadeOutRight">
										<li> <a href="view_logdata.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_viewlogfile %> </a> </li>
									<%	if(checkPermission(ses_per, "0")){	%>
										<li> <a href="data_user_online.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_user_online %> </a> </li>
									<%	}	%>
										<li> <a href="transaction_inout.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_inout %> </a> </li>
									<%	if(checkPermission(ses_per, "0")){	%>
										<li> <a href="data_maintenance.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_maintenance %> </a> </li>
									<%	}	%>
										<li class="divider"> </li>
										<li> <a href="transaction_update_id.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_update_idtable %> </a> </li>
									<%	if(checkPermission(ses_per, "0135")){	%>
										<li class="divider"> </li>
										<li> <a href="clear_antipassback.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_clear_antipassback %> </a> </li>
									<%	}	%>
									</ul>
								</li> 
							</ul>
						</li> 
					<%	}	%>
						<!--	Help	-->
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> <font color="white" style="font-size: 15px;"> <b> <%= lb_help %> </b> <span class="caret"></span> </font> </a>
							<ul class="dropdown-menu" style="min-width: 250px; " data-dropdown-in="fadeInDown" data-dropdown-out="fadeOutUp">
								<li> <a href="javascript: show_about('1', '<%= lb_help %>');"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_help %> </a> </li>
								<li> <a href="javascript: show_about('2', '<%= lb_about %>');"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_about %> </a> </li>
							</ul>
						</li>
					<%	}	%>
						<!--	Log out	-->
						<li class=""> <a href="module/logout_session.jsp?lang=<%= lang %>"> <font color="white" style="font-size: 15px;"> <b> <%= lb_logoutsys%> </b> </font> </a> </li>
					</ul>
					
					<form class="navbar-form navbar-right pull-right" id="form_search" name="form_search" method="post">
						<div class="form-inline">
							<div class="form-group" style="margin-top: 6px; margin-right: -6px;" onClick="searchMenu();">
								<input type="text" id="search_menu" name="search_menu" class="form-control typeahead tt-query" onBlur="searchMenu();" autocomplete="off" spellcheck="false" style="max-height: 24px;" placeholder="<%= lb_search_menu %>">
								<iframe src="" id="iframe_search" name="iframe_search" frameborder="0" width="0px" height="0px"></iframe>
							</div>
						</div>
					</form>
					
				</div>			
			</div>
		</nav>
<!-- End Navigation bar  -->

<% 	
	String title_sub_menu = "";
	String title_menu = "";
	String display_menu = ""; 

	if(page_g.equals("index")){
		if(subpage.equals("home")){
			title_sub_menu = lb_home;
			if(subtitle.equals("door")){
				title_menu = " ["+lb_viewdoor+"]";
			}else if(subtitle.equals("map")){
				title_menu = " ["+lb_viewmap+"]";
			}else if(subtitle.equals("row")){
				title_menu = " ["+lb_viewrow+"]";
			}
		}
		display_menu = "<i class='glyphicon glyphicon-home'></i> &nbsp; "+title_sub_menu+
						" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+lb_showmonitor+title_menu;	
	}else if(page_g.equals("database")){
		if(subpage.equals("aboutsystem")){
			title_sub_menu = lb_configdata;
			if(subtitle.equals("server")){
				title_menu = lb_server;
			}else if(subtitle.equals("location")){
				title_menu = lb_location;
			}else if(subtitle.equals("door")){
				title_menu = lb_door;
			}else if(subtitle.equals("reader")){
				title_menu = lb_reader;
			}else if(subtitle.equals("event")){
				title_menu = lb_event;
			}else if(subtitle.equals("mapserial")){
				title_menu = lb_mapserial;
			}else if(subtitle.equals("mapduty")){
				title_menu = lb_mapduty;
			}
		}else if(subpage.equals("abouttime")){
			title_sub_menu = lb_abouttime;
			if(subtitle.equals("holiday")){
				title_menu = lb_holiday;
			}else if(subtitle.equals("workcode")){
				title_menu = lb_workcode;
			}else if(subtitle.equals("timedesc")){
				title_menu = lb_timedesc;
			}else if(subtitle.equals("timezone")){
				title_menu = lb_time_zone;
			}else if(subtitle.equals("unlock")){
				title_menu = lb_unlock;
			}else if(subtitle.equals("lock")){
				title_menu = lb_lock;
			}else if(subtitle.equals("timeonoutput4")){
				title_menu = lb_timeonoutput4;
			}
		}else if(subpage.equals("personnel")){
			title_sub_menu = lb_person;
			if(subtitle.equals("depart")){
				title_menu = lb_depart;
			}else if(subtitle.equals("section")){
				title_menu = lb_section;
			}else if(subtitle.equals("position")){
				title_menu = lb_position;
			}else if(subtitle.equals("type")){
				title_menu = lb_typeemp;
			}else if(subtitle.equals("group")){
				title_menu = lb_group;
			}else if(subtitle.equals("zonegroup")){
				title_menu = lb_zonegroup;
			}else if(subtitle.equals("employee")){
				title_menu = lb_employee;
			}else if(subtitle.equals("blacklist")){
				title_menu = lb_blacklist;
			}else if(subtitle.equals("message")){
				title_menu = lb_message;
			}
		}
		if(!(subtitle.equals("zonegroup"))){
			display_menu = "<i class='glyphicon glyphicon-folder-open'></i> &nbsp; "+lb_database+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_sub_menu+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_menu+act;
		}else{
			display_menu = "<i class='glyphicon glyphicon-folder-open'></i> &nbsp; "+lb_database+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_sub_menu+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> <a href='data_group.jsp'>"+lb_group+
							"</a> <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_menu+act;
		}
	}else if(page_g.equals("report")){
		if(subpage.equals("transaction")){
			title_sub_menu = lb_report100;
			if(subtitle.equals("report_101")){
				title_menu = lb_report_101;
			}else if(subtitle.equals("report_102")){
				title_menu = lb_report_102;
			}else if(subtitle.equals("report_103")){
				title_menu = lb_report_103;
			}else if(subtitle.equals("report_104")){
				title_menu = lb_report_104;
			}else if(subtitle.equals("report_105")){
				title_menu = lb_report_105;
			}else if(subtitle.equals("report_106")){
				title_menu = lb_report_106;
			}else if(subtitle.equals("report_107")){
				title_menu = lb_report_107;
			}else if(subtitle.equals("report_108")){
				title_menu = lb_report_108;
			}else if(subtitle.equals("report_109")){
				title_menu = lb_report_109;
			}else if(subtitle.equals("report_110")){
				title_menu = lb_report_110;
			}else if(subtitle.equals("report_111")){
				title_menu = lb_report_111;
			}else if(subtitle.equals("report_112")){
				title_menu = lb_report_112;
			}else if(subtitle.equals("report_113")){
				title_menu = lb_report_113;
			}else if(subtitle.equals("report_114")){
				title_menu = lb_report_114;
			}else if(subtitle.equals("report_115")){
				title_menu = lb_report_115;
			}else if(subtitle.equals("report_151")){
				title_menu = lb_report_151;
			}
		}else if(subpage.equals("transaction_total")){
			title_sub_menu = lb_report200;
			if(subtitle.equals("report_201")){
				title_menu = lb_report_201;
			}else if(subtitle.equals("report_202")){
				title_menu = lb_report_202;
			}else if(subtitle.equals("report_203")){
				title_menu = lb_report_203;
			}else if(subtitle.equals("report_204")){
				title_menu = lb_report_204;
			}else if(subtitle.equals("report_205")){
				title_menu = lb_report_205;
			}else if(subtitle.equals("report_206")){
				title_menu = lb_report_206;
			}else if(subtitle.equals("report_207")){
				title_menu = lb_report_207;
			}
		}else if(subpage.equals("transaction_event")){
			title_sub_menu = lb_rep_dataevent;
			if(subtitle.equals("report_301")){
				title_menu = lb_report_301;
			}else if(subtitle.equals("report_302")){
				title_menu = lb_report_302;
			}else if(subtitle.equals("report_303")){
				title_menu = lb_report_303;
			}
		}else if(subpage.equals("right_inout")){
			title_sub_menu = lb_rigthuser;
			if(subtitle.equals("report_401")){
				title_menu = lb_righofdoor;
			}else if(subtitle.equals("report_402")){
				title_menu = lb_righofdoor_q;
			}else if(subtitle.equals("report_403")){
				title_menu = lb_righofemp;
			}else if(subtitle.equals("report_404")){
				title_menu = lb_righofemp_q;
			}
		}else if(subpage.equals("database")){
			title_sub_menu = lb_rep_datafile;		
			if(subtitle.equals("server")){
				title_menu = lb_server;
			}else if(subtitle.equals("location")){
				title_menu = lb_location;
			}else if(subtitle.equals("door")){
				title_menu = lb_door;
			}else if(subtitle.equals("reader")){
				title_menu = lb_reader;
			}else if(subtitle.equals("event")){
				title_menu = lb_event;
			}else if(subtitle.equals("holiday")){
				title_menu = lb_holiday;
			}else if(subtitle.equals("workcode")){
				title_menu = lb_workcode;
			}else if(subtitle.equals("timedesc")){
				title_menu = lb_timedesc;
			}else if(subtitle.equals("timezone")){
				title_menu = lb_time_zone;
			}else if(subtitle.equals("unlock")){
				title_menu = lb_unlock;
			}else if(subtitle.equals("lock")){
				title_menu = lb_lock;
			}else if(subtitle.equals("timeonoutput4")){
				title_menu = lb_timeonoutput4;
			}else if(subtitle.equals("depart")){
				title_menu = lb_depart;
			}else if(subtitle.equals("section")){
				title_menu = lb_section;
			}else if(subtitle.equals("position")){
				title_menu = lb_position;
			}else if(subtitle.equals("type")){
				title_menu = lb_typeemp;
			}else if(subtitle.equals("group")){
				title_menu = lb_group;
			}else if(subtitle.equals("zonegroup")){
				title_menu = lb_zonegroup;
			}else if (subtitle.equals("employee")){
				title_menu = lb_employee;
			}else if(subtitle.equals("employee_detail")){
				title_menu = lb_report_employee2;
			}else if(subtitle.equals("report_blacklist")){
				title_menu = lb_blacklist;
			}
		}
		display_menu = "<i class='glyphicon glyphicon-file'></i> &nbsp; "+lb_reportname+
						" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_sub_menu+
						" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_menu;
	}else if(page_g.equals("tool")){
		if(subpage.equals("general")){
			title_sub_menu = lb_define;
			if(subtitle.equals("getdatetime")){
				title_menu = lb_getdatetime;
			}else if(subtitle.equals("getmuid")){
				title_menu = lb_getdoorid;
			}else if(subtitle.equals("getversion")){
				title_menu = lb_getfirmware;
			}else if(subtitle.equals("getinfor")){
				title_menu = lb_getinfo;
			}else if(subtitle.equals("getnetwork")){
				title_menu = lb_getnetwork;
			}else if(subtitle.equals("gettypecru")){
				title_menu = lb_gettype;
			}else if(subtitle.equals("setdatetime")){
				title_menu = lb_setdatetime;
			}else if(subtitle.equals("setmuid")){
				title_menu = lb_setdoorid;
			}else if(subtitle.equals("setactionevent")){
				title_menu = lb_setactionevent;
			}
		}else if(subpage.equals("setproperty")){
			title_sub_menu = lb_setproperty;
			if(subtitle.equals("setconfig")){
				title_menu = lb_setconfig;
			}else if(subtitle.equals("setconfig2")){
				title_menu = lb_setconfig2;
			}else if(subtitle.equals("setevent")){
				title_menu = lb_setevent;
			}else if(subtitle.equals("setholiday")){
				title_menu = lb_setholiday;
			}else if(subtitle.equals("setworkcode")){
				title_menu = lb_setworkcode;
			}else if(subtitle.equals("settimezone")){
				title_menu = lb_settimezone;
			}else if(subtitle.equals("setlock")){
				title_menu = lb_setlock;
			}else if(subtitle.equals("setunlock")){
				title_menu = lb_setunlock;
			}else if(subtitle.equals("settimeonoutput4")){
				title_menu = lb_settimeonout4;
			}else if(subtitle.equals("setfirmware")){
				title_menu = lb_setfirmware;
			}
		}else if(subpage.equals("getproperty")){
			title_sub_menu = lb_getproperty;
			if(subtitle.equals("getconfig")){
				title_menu = lb_getconfig;
			}else if(subtitle.equals("getconfig2")){
				title_menu = lb_getconfig2;
			}else if(subtitle.equals("getevent")){
				title_menu = lb_getevent;
			}else if(subtitle.equals("getholiday")){
				title_menu = lb_getholiday;
			}else if(subtitle.equals("getworkcode")){
				title_menu = lb_getworkcode;
			}else if(subtitle.equals("gettimezone")){
				title_menu = lb_gettimezone;
			}else if(subtitle.equals("getlock")){
				title_menu = lb_getlock;
			}else if(subtitle.equals("getunlock")){
				title_menu = lb_getunlock;
			}else if(subtitle.equals("gettimeonoutput4")){
				title_menu = lb_gettimeonoutput4;
			}else if(subtitle.equals("getlogfile")){
				title_menu = lb_getlogfile;
			}
		}else if(subpage.equals("personnel")){
			title_sub_menu = lb_empdata;
			if(subtitle.equals("getnumidtable")){
				title_menu = lb_getnumid;
			}else if(subtitle.equals("setidtables")){
				title_menu = lb_cmdA0_47;
			}else if(subtitle.equals("getidtables")){
				title_menu = lb_cmdA1_48;
			}else if(subtitle.equals("setidtable")){
				title_menu = lb_cmd80_44;
			}else if(subtitle.equals("getidtable")){
				title_menu = lb_cmd81_45;
			}else if(subtitle.equals("delidtable")){
				title_menu = lb_cmd79;
			}else if(subtitle.equals("clearidtable")){
				title_menu = lb_cmd78;
			}else if(subtitle.equals("setidtables_blacklist")){
				title_menu = lb_cmdA0_47_blacklist;
			}else if(subtitle.equals("getnumtemplate")){
				title_menu = lb_getnumtemplate;
			}else if(subtitle.equals("gettemplate")){
				title_menu = lb_cmd21_40;
			}else if(subtitle.equals("cleartemplate")){
				title_menu = lb_cmd23;
			}else if(subtitle.equals("setpicture")){
				title_menu = lb_cmd63;
			}else if(subtitle.equals("getpicture")){
				title_menu = lb_cmd11;
			}else if(subtitle.equals("delpicture")){
				title_menu = lb_cmdD1;
			}else if(subtitle.equals("setadmin")){
				title_menu = lb_cmd87;
			}else if(subtitle.equals("getlistadmin")){
				title_menu = lb_cmd88;
			}
		}else if(subpage.equals("aboutcard")){
			title_sub_menu = lb_datacard;
			if(subtitle.equals("readtypecard")){
				title_menu = lb_readtypecard;
			}else if(subtitle.equals("readcard")){
				title_menu = lb_readcard;
			}else if(subtitle.equals("readtranscard")){
				title_menu = lb_readtrancard;
			}else if(subtitle.equals("readserialcard")){
				title_menu = lb_readserialcard;
			}else if(subtitle.equals("enrollfinger")){
				title_menu = lb_enrollfp;
			}else if(subtitle.equals("writecard")){
				title_menu = lb_writecard_other;
			}else if(subtitle.equals("writecardmas")){
				title_menu = lb_writecardmas;
			}
		}else if(subpage.equals("transaction")){
			title_sub_menu = lb_datatransaction;
			if(subtitle.equals("gettransaction")){
				title_menu = lb_cmd56;
			}else if(subtitle.equals("dumptransaction")){
				title_menu = lb_cmd57;
			}else if(subtitle.equals("dumptransbydatetime")){
				title_menu = lb_cmd69;
			}else if(subtitle.equals("getcapture")){
				title_menu = lb_cmd10;
			}else if(subtitle.equals("delcapture")){
				title_menu = lb_cmdD0;
			}
		}else if(subpage.equals("multimedia")){
			title_sub_menu = lb_picmulti;
			if(subtitle.equals("setscreen")){
				title_menu = lb_cmd62;
			}else if(subtitle.equals("setvideo")){
				title_menu = lb_cmd64;
			}else if(subtitle.equals("setslide")){
				title_menu = lb_cmd65;
			}else if(subtitle.equals("setsound")){
				title_menu = lb_cmd66;
			}else if(subtitle.equals("delscreen")){
				title_menu = lb_cmd62_del;
			}else if(subtitle.equals("delvideo")){
				title_menu = lb_cmdD2;
			}else if(subtitle.equals("delslide")){
				title_menu = lb_cmdD3;
			}else if(subtitle.equals("getlistvideo")){
				title_menu = lb_cmd12;
			}else if(subtitle.equals("getlistslide")){
				title_menu = lb_cmd13;
			}										
		}else if(subpage.equals("face")){
			title_sub_menu = lb_face;
			if(subtitle.equals("facesetdatetime")){
				title_menu = lb_face_setdatetime;
			}else if(subtitle.equals("facegetinfor")){
				title_menu = lb_face_getinfo;
			}else if(subtitle.equals("facesetinfor")){
				title_menu = lb_face_setinfo;
			}else if(subtitle.equals("facegetemployeelist")){
				title_menu = lb_face_getemployeelist;
			}else if(subtitle.equals("facegetemployee")){
				title_menu = lb_face_getemployee;
			}else if(subtitle.equals("facesetemployee")){
				title_menu = lb_face_setemployee;
			}else if(subtitle.equals("facedelemployee")){
				title_menu = lb_face_delemployee;			
			}else if(subtitle.equals("facegettransaction")){
				title_menu = lb_face_gettransaction;			
			}
		}
		display_menu = "<i class='glyphicon glyphicon-wrench'></i> &nbsp; "+lb_config+
						" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_sub_menu+
						" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_menu;	
	}else if(page_g.equals("setting")){
		if(subpage.equals("config")){
			if(subtitle.equals("configcorp")){
				title_menu = lb_configcorp;
			}else if(subtitle.equals("configcompany")){
				title_menu = lb_configcom;
			}else if(subtitle.equals("user")){
				title_menu = lb_setuser;
			}else if(subtitle.equals("report")){
				title_menu = lb_edit_reportname;
			}
			display_menu = "<i class='glyphicon glyphicon-wrench'></i> &nbsp; "+lb_systeminfo+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_menu+act;
		}
	}else if(page_g.equals("special")){
		if(subpage.equals("importfile")){
			title_sub_menu = lb_import_data;
			if(subtitle.equals("depart")){
				title_menu = lb_depart;
			}else if(subtitle.equals("section")){
				title_menu = lb_section;
			}else if(subtitle.equals("position")){
				title_menu = lb_position;
			}else if(subtitle.equals("type")){
				title_menu = lb_typeemp;
			}else if(subtitle.equals("group")){
				title_menu = lb_group;
			}else if(subtitle.equals("employee")){
				title_menu = lb_employee;
			}else if(subtitle.equals("employee2")){
				title_menu = lb_employee+" ["+lb_master_data+"]";
			}else if(subtitle.equals("blacklist")){
				title_menu = lb_blacklist;
			}else if(subtitle.equals("message")){
				title_menu = lb_message;
			}else if(subtitle.equals("autoidtable")){
				title_menu = lb_auto_idtable;
			}
		}else if(subpage.equals("exportfile")){
			title_sub_menu = lb_export_data;
			if(subtitle.equals("depart")){
				title_menu = lb_depart;
			}else if(subtitle.equals("section")){
				title_menu = lb_section;
			}else if(subtitle.equals("position")){
				title_menu = lb_position;
			}else if(subtitle.equals("type")){
				title_menu = lb_typeemp;
			}else if(subtitle.equals("group")){
				title_menu = lb_group;
			}else if(subtitle.equals("employee")){
				title_menu = lb_employee;
			}else if(subtitle.equals("employee2")){
				title_menu = lb_employee+" ["+lb_master_data+"]";
			}
		}else if(subpage.equals("processfile")){
			title_sub_menu = lb_process_files;
			if(subtitle.equals("filetaf")){
				title_menu = lb_import_data_taff;		
			}else if(subtitle.equals("fileraw")){
				title_menu = lb_import_data_text;		
			}else if(subtitle.equals("filetrans")){
				title_menu = lb_transaction_file;		
			}
		}else if(subpage.equals("download")){
			title_sub_menu = lb_download_data;
			if(subtitle.equals("downloadtaff")){
				title_menu = lb_downloaddata;
			}else if(subtitle.equals("downloadtxt")){
				title_menu = lb_downloaddata2;
			}else if(subtitle.equals("downloadtxt_con")){
				title_menu = lb_downloaddata_conditions;
			}else if(subtitle.equals("download_from_emp")){
				title_menu = lb_download_from_employee;
			}else if(subtitle.equals("download_from_trans")){
				title_menu = lb_download_from_transaction;
			}
		}else if(subpage.equals("deletedata")){
			title_sub_menu = lb_deletedata;
			if(subtitle.equals("transaction")){
				title_menu = lb_del_trans;		
			}else if(subtitle.equals("employee") || subtitle.equals("employee_view")){
				title_menu = lb_del_emp_conditions;		
			}
		}else if(subpage.equals("others")){
			title_sub_menu = lb_another_data;
			if(subtitle.equals("logdata")){
				title_menu = lb_viewlogfile;		
			}else if(subtitle.equals("user_online")){
				title_menu = lb_user_online;
			}else if(subtitle.equals("trans_inout")){
				title_menu = lb_report_inout;
			}else if(subtitle.equals("maintenance")){
				title_menu = lb_maintenance+act;
			}else if(subtitle.equals("trans_updateid") || subtitle.equals("trans_updateid_view")){
				title_menu = lb_update_idtable;
			}else if(subtitle.equals("clear_antipassback")){
				title_menu = lb_clear_antipassback;
			}
		}
		
		if(subtitle.equals("employee_view")){
			display_menu = "<i class='glyphicon glyphicon-list-alt'></i> &nbsp; "+lb_special+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_sub_menu+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_menu+
							" &nbsp; <i>[ <a href='delete_employee.jsp'> <span class='glyphicon glyphicon-share-alt'></span> "+lb_back+" </a> ]</i> ";	
		}else if(subtitle.equals("trans_updateid_view")){
			display_menu = "<i class='glyphicon glyphicon-file'></i> &nbsp; "+lb_special+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_sub_menu+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_menu+
							" &nbsp; <i>[ <a href='transaction_update_id.jsp'> <span class='glyphicon glyphicon-share-alt'></span> "+lb_back+" </a> ]</i> ";	
		}else{
			display_menu = "<i class='glyphicon glyphicon-list-alt'></i> &nbsp; "+lb_special+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_sub_menu+
							" <span style='padding-left: 5px; padding-right: 5px;'> <i> / </i> </span> "+title_menu;
		}		
	}
%>
	
	<div class="head-display" style="padding-top: 0px; padding-buttom: 0px; margin-top: -10px; margin-buttom: 12px;">	
		<div class="container">
			<div class="table-responsive" style="border: 0px !important; margin-bottom: 0px;" border="0">
				<div style="min-width: 850px;" class="table" align="center" border="0">				
					<div class="col-xs-9" align="left" style="margin-left: -15px; margin-top: 2px; height: 24px;"> <b> <%= display_menu %> </b> </div>
					<div class="col-xs-3" align="right" style="margin-top: 2px; height: 24px;">
						<div style="margin-right: -30px;">
							<b> <% out.println(displayUser(Integer.toString(ses_per))); %> </b> &nbsp;
							<a href="<%= (String)session.getAttribute("action") %>lang=th"><img src="images/thland.png" alt="<%= lb_thai %>" width="24" height="18" border="0" align="absmiddle"></a> 
							<a href="<%= (String)session.getAttribute("action") %>lang=en"><img src="images/enland.png" alt="<%= lb_eng %>" width="24" height="18" border="0" align="absmiddle"></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade bs-example-modal-lg" id="myModalViewAbout" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"> <label id="topic"> </label> </h4>
				</div>
				<div class="modal-body" align="center">
					<div class="table-responsive" style="border: 0px !important;" border="0">
						<iframe src="" id="view_about" name="view_about" frameborder="0" height="417px" style="min-width: 845px;"></iframe>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close%> </button>
				</div>
			</div>
		</div>
	</div>
	<p>	
</body>
<script>
	function show_about(type, topic){
		if(type == '1'){
			view_about.location = 'help.jsp?n=1';
		}else if(type == '2'){
			view_about.location = 'about.jsp';
		}
		document.getElementById("topic").innerHTML = topic;
		$('#myModalViewAbout').modal('show');
	}	
</script>
<script src="js/dropdown-menu.animated.js"></script>
</html>