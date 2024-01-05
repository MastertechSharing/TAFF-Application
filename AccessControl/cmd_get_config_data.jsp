<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<%	
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "getproperty");
	session.setAttribute("subtitle", "getconfig");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "cmd_get_config_data.jsp?ip="+ip+"&door_id="+door_id+"&");	
%>
<span/>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">
<%	
	String sql = "", desc = "";
	try{
		sql = " SELECT door_id, th_desc, en_desc FROM dbdoor ";
		if(!ip.equals("")){
			sql += " WHERE ip_address = '"+ip+"' ";
		}else{
			sql += " WHERE door_id = '"+door_id+"' ";
		}
		ResultSet rs = stmtQry.executeQuery(sql);
		while(rs.next()){
			door_id = rs.getString("door_id");
			if(lang.equals("th")){
				desc = rs.getString("th_desc");
			}else{
				desc = rs.getString("en_desc");
			}
		}
		rs.close();
		
		String pathfile = "";
		if(!ip.equals("")){
			pathfile = path_data+ip+"\\MURD67.CFG";
		}else{
			pathfile = path_data+door_id+"\\MURD67.CFG";
		}
		File f = new File(pathfile);
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("	<span class='alert-link'> "+msg_not_file_upload+" "+lb_getconfig+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
			String col1 = "col-xs-3 col-md-3";
			String col2 = "col-xs-3 col-md-3";
			String col_line = "col-xs-12 col-md-12";
			String set_hr = " <div class='row' class='"+col_line+"' > <hr style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
			String set_hr2 = " <div class='row' class='"+col_line+"' > <hr style='height: 6px; margin-top: 8px; margin-bottom: 4px; width: 98%;' /> </div> ";
			
			BufferedReader in = new BufferedReader(new FileReader(pathfile));
			String textStr = "";
			String saveDigit = "", master1 = "", master2 = "", master3 = "", master4 = "", master5 = "", compareMode = "", doorLock = "",
					alarmDoor = "", alarmTime = "", pattern = "", display = "", customer = "", startDigit = "", issueDigit = "", 
					dupTime = "", writeCard = "", keyPad = "", keyDuty = "", duty = "", d1time1 = "", d1time2 = "", d1time3 = "", 
					d1time4 = "", d1time5 = "", d2time1 = "", d2time2 = "", d2time3 = "", d2time4 = "", d2time5 = "", d3time1 = "", 
					d3time2 = "", d3time3 = "", d3time4 = "", d3time5 = "", d4time1 = "", d4time2 = "", d4time3 = "", d4time4 = "", 
					d4time5 = "", fingerIden = "", langRD = "", keyBeep = "", bright = "", volume = "", timeOffDisplay = "", gprs = "", 
					alarmMode = "", accessMode = "", timeOffOut2 = "", timeOffOut3 = "", timeOffOut4 = "", keyCard2 = "", blockID = "", 
					colorNormal = "", colorUnlock = "", colorAlarm = "", timeAuto = "", readSerial = "", outOfService = "", 
					timeOffOut1E37 = "", timeOffOut2E37 = "", timeOffOut1E39 = "", timeOffOut2E39 = "";
			int Dec = 0;
			while((textStr = in.readLine()) != null){
				if(textStr.length() == 350){
					saveDigit = textStr.substring(0, 16);
					master1 = textStr.substring(16, 32);
					master2 = textStr.substring(32, 48);
					master3 = textStr.substring(48, 64);
					master4 = textStr.substring(64, 80);
					master5 = textStr.substring(80, 96);
					compareMode = textStr.substring(96, 97);
					doorLock = textStr.substring(97, 99);
					alarmDoor = textStr.substring(99, 101);
					alarmTime = textStr.substring(101, 103);
					pattern = textStr.substring(103, 119);
					display = textStr.substring(119, 135);
					customer = textStr.substring(135, 138);
					startDigit = textStr.substring(138, 140);
					issueDigit = textStr.substring(140, 142);
					dupTime = textStr.substring(142, 144);
					writeCard = textStr.substring(144, 145);
					keyPad = textStr.substring(145, 146);
					keyDuty = textStr.substring(146, 147);
					duty = textStr.substring(147, 151);
				
					d1time1 = textStr.substring(151, 159);
					d1time2 = textStr.substring(159, 167);
					d1time3 = textStr.substring(167, 175);
					d1time4 = textStr.substring(175, 183);
					d1time5 = textStr.substring(183, 191);
					d2time1 = textStr.substring(191, 199);
					d2time2 = textStr.substring(199, 207);
					d2time3 = textStr.substring(207, 215);
					d2time4 = textStr.substring(215, 223);
					d2time5 = textStr.substring(223, 231);
					d3time1 = textStr.substring(231, 239);
					d3time2 = textStr.substring(239, 247);
					d3time3 = textStr.substring(247, 255);
					d3time4 = textStr.substring(255, 263);
					d3time5 = textStr.substring(263, 271);
					d4time1 = textStr.substring(271, 279);
					d4time2 = textStr.substring(279, 287);
					d4time3 = textStr.substring(287, 295);
					d4time4 = textStr.substring(295, 303);
					d4time5 = textStr.substring(303, 311);
					fingerIden = textStr.substring(311, 312);
					langRD = textStr.substring(312, 313);
					keyBeep = textStr.substring(313, 314);
					bright = textStr.substring(314, 316);
					volume = textStr.substring(316, 318);
					timeOffDisplay = textStr.substring(318, 320);
					gprs = textStr.substring(320, 321);
					alarmMode = textStr.substring(321, 322);
					accessMode = textStr.substring(322, 323);				
					timeOffOut2 = textStr.substring(323, 325);
					timeOffOut3 = textStr.substring(325, 327);
					timeOffOut4 = textStr.substring(327, 329);				
					keyCard2 = textStr.substring(329, 335);
					blockID = textStr.substring(335, 336);
					colorNormal = textStr.substring(336, 337);
					colorUnlock = textStr.substring(337, 338);
					colorAlarm = textStr.substring(338, 339);
					
					timeAuto = textStr.substring(339, 340);
					readSerial = textStr.substring(340, 341);
					outOfService = textStr.substring(341, 342);
					timeOffOut1E37 = textStr.substring(342, 344);
					timeOffOut2E37 = textStr.substring(344, 346);
					timeOffOut1E39 = textStr.substring(346, 348);
					timeOffOut2E39 = textStr.substring(348, 350);
					
					if(!(keyCard2.equals(""))){
						keyCard2 = "************";
					}
					try{
						Dec = Integer.parseInt(convertStringToHex(blockID), 16);
					}catch(Exception ex){
					
					}					
%>			
				<div class="alert alert-info" role="alert">
					<span class="alert-link"> <%= lb_getconfig %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </span>
				</div>
				
				<div class="table-responsive" style="border: 0px !important; margin-left: -5px; margin-right: -29px; margin-top: -15px;" border="0">
					
					<div style="min-width: 1000px; max-width: 98%; margin-left: 0px; margin-right: -30px;" class="table" border="0">	
					
						<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px; margin-bottom: 10px;"> 
							<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <%= lb_configcorp %> </label>
							</div>
							<div class="row" style="margin-bottom: -25px;">
								<table style="min-width: 780px; max-width: 98%;" align="center" id="data_table" class="table" cellspacing="0" >
									<tr style="height: 36px !important;">
										<td width="20%" align="center"> </td>
										<%	for(int i = 1; i <= 16; i++){	%>
										<td width="5%" align="center"> <label class="control-label" style="margin-top: 6px;"> <%= i %> </label> </td>
										<%	}	%>
									</tr>
									<tr style="height: 36px !important;">
										<td width="20%" align="left"> <label class="control-label" style="margin-top: 6px;"> <%= lb_cardpattern %> </label> </td>
										<%	for(int i = 0; i <= 15; i++){	%>
										<td width="5%" align="center"> <%= subStringCharAt(pattern, i) %> </td>
										<%	}	%>
									</tr>
									<tr style="height: 36px !important;">
										<td width="20%" align="left"> <label class="control-label" style="margin-top: 6px;"> <%= lb_disdigit %> </label> </td>
										<%	for(int i = 0; i <= 15; i++){	%>
										<td width="5%" align="center"> <%= checkImgAtPosY(display, i) %> </td>
										<%	}	%>
									</tr>
									<tr style="height: 36px !important;">
										<td width="20%" align="left"> <label class="control-label" style="margin-top: 6px;"> <%= lb_savedigit %> </label> </td>
										<%	for(int i = 0; i <= 15; i++){	%>
										<td width="5%" align="center"> <%= checkImgAtPosY(saveDigit, i) %> </td>
										<%	}	%>										
									</tr>
								</table>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_customercode %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= customer %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_stdigit %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= startDigit %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_mastercard %> 1 </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= master1 %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_issuedigit %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= issueDigit %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_mastercard %> 2 </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= master2 %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_duplicatetime %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= dupTime %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_mastercard %> 3 </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= master3 %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_block_id %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= Dec %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_mastercard %> 4 </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= master4 %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_key_card2 %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= keyCard2 %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_mastercard %> 5 </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= master5 %> </h5>
							</div>
						</div>
						
						<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px; margin-top: 20px; margin-bottom: 0px;"> 
							<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <%= lb_door %> </label>
							</div>
							
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_comparemode %> </label> </h5>
								<h5 class="modal-title col-xs-3 col-md-3" > <%= displayCompareMode(compareMode) %> </h5>
								<h5 class="modal-title col-xs-6 col-md-6" > <%= checkImgAtPos(readSerial, 0) %> <%= lb_read_serialcard %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_doorrelease %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= doorLock %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_timeoffout1e37 %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= timeOffOut1E37 %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_alarmafter %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= alarmDoor %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_timeoffout2e37 %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= timeOffOut2E37 %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_alarmduration %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= alarmTime %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_timeoffout1e39 %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= timeOffOut1E39 %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_timeoffout2 %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= timeOffOut2 %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_timeoffout2e39 %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= timeOffOut2E39 %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_timeoffout3 %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= timeOffOut3 %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_auto_settime %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= checkImgAtPos(timeAuto, 0) %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_timeoffout4 %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= timeOffOut4 %> </h5>
								<h5 class="modal-title col-xs-6 col-md-6" align="right"> <label class="control-label col-md-12" style="font-size: 12px;font-style: normal;color: #F95450;"> ** <%= lb_comment %> : ( 00 = <%= lb_notwork %>, 99 = <%= lb_alwaywork %> ) </label> </h5>
							</div>
						</div>
						
						<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px; margin-top: 20px; margin-bottom: 0px;"> 
							<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <%= lb_reader %> </label>
							</div>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_language %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= displayLanguage(langRD, lang) %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_actkeypad %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= displayActiveKeyPad(keyPad,lang) %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_displaybright %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= bright %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_actkeyduty %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= displayActiveKeyDuty(keyDuty,lang) %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_volume %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= volume %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_enablediden %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= checkImgAtPos(fingerIden, 0) %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_time_off_display %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= timeOffDisplay %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_keybeep %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= checkImgAtPos(keyBeep, 0) %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_writecard %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= displayWriteOnCard(writeCard,lang) %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_outoffservice %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= checkImgAtPos(outOfService, 0) %> </h5>
							</div>
							<%= set_hr2 %>
							
							<div class="table-responsive" style="border: 0px !important; margin-top: -10px; margin-bottom: -20px; margin-right: -16px;" border="0">
								<div style="min-width: 1000px;" class="table" border="0">
									<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;">  
										<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-time"> </i> &nbsp; <%= lb_statustaff %> </label>
										</div>
										<div class="row">
											<h5 class="modal-title col-xs-1 col-md-1" > </h5>
											<h5 class="modal-title col-xs-1 col-md-1" > <div align="center"> <b> <%= lb_duty %> </b> </div> </h5>
											<%	for(int i = 1; i <= 5; i++){	%>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <b> <%= lb_timezone %> <%= i %> </b> </div> </h5>
											<%	}	%>											
										</div>
										<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
										<div class="row">
											<h5 class="modal-title col-xs-1 col-md-1" > <div align="right"> <b> IN &nbsp; </b> </div> </h5>
											<h5 class="modal-title col-xs-1 col-md-1" > <div align="center"> <b> <%= subStringCharAt(duty, 0) %> </b> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d1time1) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d1time2) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d1time3) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d1time4) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d1time5) %> </div> </h5>
										</div>
										<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
										<div class="row">
											<h5 class="modal-title col-xs-1 col-md-1" > <div align="right"> <b> OUT &nbsp; </b> </div> </h5>
											<h5 class="modal-title col-xs-1 col-md-1" > <div align="center"> <b> <%= subStringCharAt(duty, 1) %> </b> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d2time1) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d2time2) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d2time3) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d2time4) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d2time5) %> </div> </h5>
										</div>
										<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
										<div class="row">
											<h5 class="modal-title col-xs-1 col-md-1" > <div align="right"> <b> OT IN </b> </div> </h5>
											<h5 class="modal-title col-xs-1 col-md-1" > <div align="center"> <b> <%= subStringCharAt(duty, 2) %> </b> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d3time1) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d3time2) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d3time3) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d3time4) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d3time5) %> </div> </h5>
										</div>
										<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
										<div class="row">
											<h5 class="modal-title col-xs-1 col-md-1" > <div align="right"> <b> OT OUT </b> </div> </h5>
											<h5 class="modal-title col-xs-1 col-md-1" > <div align="center"> <b> <%= subStringCharAt(duty, 3) %> </b> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d4time1) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d4time2) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d4time3) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d4time4) %> </div> </h5>
											<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(d4time5) %> </div> </h5>
										</div>
									</div>
								</div>
							</div>	
							
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_clock_color %> ( <%= lb_normal %> ) </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= displayColorStr(colorNormal, lang) %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_alarm_mode %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= displayAlarmMode(alarmMode) %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_clock_color %> ( <%= lb_rdunlock %> ) </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= displayColorStr(colorUnlock, lang) %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_access_mode %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= displayAccessMode(accessMode) %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_clock_color %> ( <%= lb_alarm %> ) </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= displayColorStr(colorAlarm, lang) %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_config_gprs %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= displayConfigGPRS(gprs) %> </h5>
							</div>
						</div>						
					</div>
				</div>				
<%	
				}
			}
			in.close();
		}
	}catch(SQLException e){
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
	}
%>
			</div>
		</div>

		<script>
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				$('body').addClass('loaded');
			}
		}
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>