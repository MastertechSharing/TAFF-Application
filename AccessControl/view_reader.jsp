<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			.bs-callout-info {
				border-left-color: #1b809e;
			}
			.bs-callout {
				padding: 10px;
				margin: 10px 0;
				border: 1px solid #1b809e;
				border-left-width: 5px;
				border-radius: 3px;
			}
			
			.nav-tabs > li a {
				border: 1px solid #EEEEEE;
				background-color: #DEDEDE;
				color: #2870A0;
			}
			.li-white {
				background-color: #FFFFFF !important;
				color: #333333 !important;
			}		</style>
		
		<script language="javascript">
		
		</script>
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
<% 
	String action = request.getParameter("action");
	if(action.equals("view")){
		String reader_no = request.getParameter("reader_no");
		String col1 = "col-xs-4 col-md-4";
		String col2 = "col-xs-2 col-md-2";
		String col3 = "col-xs-3 col-md-3";
		String col4 = "col-xs-3 col-md-3";
		String col1h = "col-xs-7 col-md-7";
		String col2h = "col-xs-5 col-md-5";
		String col_line = "col-xs-12";
		String col_line_h = "col-xs-10";
		String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
		String set_hr_h = " <div class='row'> <hr class='"+col_line_h+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
		
		try{
			ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbreader WHERE (reader_no = '"+reader_no+"') ");
			if(rs.next()){
				String door_id = rs.getString("door_id");
				String readerfunc = displayReaderFunc(rs.getString("reader_func"));
				String readertype = displayReaderType(rs.getString("reader_type"));
				String readersecur = displaySecurity(rs.getString("security_online"),lang);				
				String write_oncard = displayWriteOnCard(rs.getString("write_oncard"),lang);
				String active_keypad = displayActiveKeyPad(rs.getString("active_keypad"),lang);
				String active_keyduty = displayActiveKeyDuty(rs.getString("active_keyduty"),lang);
				String write_transloop = displayWriteTransLoop(rs.getString("writetransloop"),lang);
				String tzunlock = displayTZ0Unlock(rs.getString("timezone0_unlock"),lang);
				String usecardantipb = getUseOrNotUse(rs.getString("usecardantipassback"),lang);
				String proximity = displayProx(rs.getString("prox_format"),lang);
				//	CRU71
				String rd2enable = displayRd2Mode(rs.getString("rd2mode"),lang);
				String scr_server = displayActive(rs.getString("screen_server"),lang);
				String camera = displayActive(rs.getString("camera"),lang);
				String capt_preview = displayActive(rs.getString("capt_preview"),lang);
				String disabletaff = displayActive(rs.getString("mifare_std"),lang);
				String disablemifare = displayActive(rs.getString("mifare_uid"),lang);
				
%>
		<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto;">
			
			<ul class="nav nav-tabs">
				<li id="li_first" class="active" style="max-height: 28px;"> <a href="#1" style="max-height: 28px;" data-toggle="tab"> <div style="margin-top: -7px;"> &nbsp; <b><%= lb_reader %></b> &nbsp; </div> </a> </li>
				<li id="li_second" style="max-height: 28px;"> <a href="#2" style="max-height: 28px;" data-toggle="tab"> <div style="margin-top: -7px;"> &nbsp; <b><%= lb_add_config %></b> &nbsp; </div> </a> </li>
			</ul>

			<div class="tab-content">
				<div class="tab-pane active" id="1">
				
					<div class="row" style="margin-top: 20px">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_doorcode %> : </b> </div> </h5>
						<h5 class="modal-title col-xs-8 col-md-8" > 
					<%  
						String door_desc = "";
						try{ 
							ResultSet rs_door = stmtUp.executeQuery("SELECT * FROM dbdoor WHERE (door_id = "+door_id+") ");
							while(rs_door.next()){ 
								if(lang.equals("th")){
									door_desc = rs_door.getString("th_desc");
								}else{
									door_desc = rs_door.getString("th_desc");
								}					     
							}	rs_door.close();
						} catch (SQLException e) {
							out.println("<div class='alert alert-danger' role='alert'> SQL Exception :" + e.getMessage()
									+ "</div>");
						}
						out.println(door_id+" - "+door_desc);
					/*	
						String reader_in = reader_no.substring(4, 5);
						if((reader_in.equals("1"))){
							out.println("&nbsp; <b>"+lb_in+"</b>");
						}else if((reader_in.equals("2"))){
							out.println("&nbsp; <b>"+lb_out+"</b>");		 
						}
					*/
					%>
						</h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_readerno %> : </b> </div> </h5>
						<h5 class="modal-title col-xs-8 col-md-8" > <%= reader_no %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_thdesc %> : </b> </div> </h5>
						<h5 class="modal-title col-xs-8 col-md-8" > <%= rs.getString("th_desc") %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_endesc %> : </b> </div> </h5>
						<h5 class="modal-title col-xs-8 col-md-8" > <%= rs.getString("en_desc") %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_readerfunc %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= readerfunc %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_readertype %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= readertype %> </h5>						
					</div>
					
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_security %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= readersecur %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > </h5></div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_language %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= displayLanguage(rs.getString("language"), lang) %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_actkeypad %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= active_keypad %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_displaybright %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= rs.getString("display_bright") %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_actkeyduty %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= active_keyduty %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_volume %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= rs.getString("volume") %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_enablediden %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= checkImgAtPos(rs.getString("finger_identify"), 0) %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right" style="margin-left: -25px;"> <b> <%= lb_time_off_display %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= rs.getString("time_off_display") %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_keybeep %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= checkImgAtPos(rs.getString("key_beep"), 0) %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_writecard %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= write_oncard %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_outoffservice %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= checkImgAtPos(rs.getString("out_of_service"), 0) %> </h5>
					</div>
					<%= set_hr %>
					
					<div class="bs-callout bs-callout-info" style="margin-top: 0px; margin-bottom: 0px;">
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-time" > </i> &nbsp; <b> <%= lb_statustaff %> </b> </label>
						</div>					
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="right"> <b> <%= lb_duty %> </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <b> <%= lb_timezone %> 1 </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <b> <%= lb_timezone %> 2 </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <b> <%= lb_timezone %> 3 </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <b> <%= lb_timezone %> 4 </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <b> <%= lb_timezone %> 5 </b> </div> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="left"> <b> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; IN &nbsp;&nbsp; &nbsp; &nbsp; <% if(rs.getString("display_duty1").equals("")){ out.print("&nbsp;&nbsp;"); }else{ out.print(subStringCharAt(rs.getString("display_duty1"), 0)); } %> </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty1_time1")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty1_time2")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty1_time3")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty1_time4")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty1_time5")) %> </div> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="left"> <b> &nbsp; &nbsp; &nbsp; &nbsp; OUT &nbsp; &nbsp; &nbsp; <% if(rs.getString("display_duty2").equals("")){ out.print("&nbsp;&nbsp;"); }else{ out.print(subStringCharAt(rs.getString("display_duty2"), 0)); } %> </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty2_time1")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty2_time2")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty2_time3")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty2_time4")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty2_time5")) %> </div> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="left"> <b> &nbsp; &nbsp; &nbsp; &nbsp; OT IN &nbsp; &nbsp; <% if(rs.getString("display_duty3").equals("")){ out.print("&nbsp;&nbsp;"); }else{ out.print(subStringCharAt(rs.getString("display_duty3"), 0)); } %> </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty3_time1")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty3_time2")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty3_time3")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty3_time4")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty3_time5")) %> </div> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 95%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="left"> <b> &nbsp; &nbsp; OT OUT &nbsp; &nbsp; <% if(rs.getString("display_duty4").equals("")){ out.print("&nbsp;&nbsp;"); }else{ out.print(subStringCharAt(rs.getString("display_duty4"), 0)); } %> </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty4_time1")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty4_time2")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty4_time3")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty4_time4")) %> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2" > <div align="center"> <%= changeTime(rs.getString("duty4_time5")) %> </div> </h5>
						</div>
					</div>
					
					<%= set_hr %>
					<div class="row col-md-7 col-xs-7" style="margin-top: 0px; margin-left: 0px; margin-right: -20px">
						<div class="row">
							<h5 class="modal-title <%= col1h %>" > <div align="right"> <b> <%= lb_clock_color %> (<%= lb_normal %>) : </b> </div> </h5>
							<h5 class="modal-title <%= col2h %>" > <%= displayColorStr(rs.getString("clock_color_normal"), lang) %> </h5>
						</div>
						<%= set_hr_h %>
						<div class="row">
							<h5 class="modal-title <%= col1h %>" > <div align="right"> <b> <%= lb_clock_color %> (<%= lb_rdunlock %>) : </b> </div> </h5>
							<h5 class="modal-title <%= col2h %>" > <%= displayColorStr(rs.getString("clock_color_unlock"), lang) %> </h5>
						</div>
						<%= set_hr_h %>
						<div class="row">
							<h5 class="modal-title <%= col1h %>" > <div align="right"> <b> <%= lb_clock_color %> (<%= lb_alarm %>) : </b> </div> </h5>
							<h5 class="modal-title <%= col2h %>" > <%= displayColorStr(rs.getString("clock_color_alarm"), lang) %> </h5>
						</div>
						<%= set_hr_h %>
						<div class="row">
							<h5 class="modal-title <%= col1h %>" > <div align="right" style="margin-left: -15px;"> <b> <%= lb_alarm_mode %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2h %>" > <%= displayAlarmMode(rs.getString("alarm_mode")) %> </h5>
						</div>
						<%= set_hr_h %>
						<div class="row">
							<h5 class="modal-title <%= col1h %>" > <div align="right" style="margin-left: -15px;"> <b> <%= lb_access_mode %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2h %>" > <%= displayAccessMode(rs.getString("access_mode")) %> </h5>
						</div>
						<%= set_hr_h %>
						<div class="row">
							<h5 class="modal-title <%= col1h %>" > <div align="right" style="margin-left: -15px;"> <b> <%= lb_config_gprs %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2h %>" > <%= displayConfigGPRS(rs.getString("config_gprs")) %> </h5>
						</div>
					</div>
					
					<div class="row col-md-5 col-xs-5" style="margin-top: 0px; margin-left: 0px; margin-right: -20px">
						<div class="row" style="margin-top: -10px; margin-left: -15px; margin-right: -34px;">
							<div class="bs-callout bs-callout-info"> 
								<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
									<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-edit" > </i> &nbsp; <b> Anti-Passback </b> </label>
								</div>
								<div class="row">
									<h5 class="modal-title col-xs-7 col-md-7" > <div align="right"> <b> <%= lb_status_io %> : </b> </div> </h5>
									<h5 class="modal-title col-xs-5 col-md-5" > <%= displayStatusIO(rs.getString("status_io"), lang) %> </h5>
								</div>
								<div class="row"> <hr class="col-xs-10" style="height: 6px; margin-top: 8px; margin-bottom: 4px; margin-left: 15px;" /> </div>
								<div class="row">
									<h5 class="modal-title col-xs-7 col-md-7" > <div align="right"> <b> <%= lb_antilevel %> : </b> </div> </h5>
									<h5 class="modal-title col-xs-5 col-md-5" > <%= rs.getString("level_no") %> </h5>
								</div>
								<div class="row" style="margin-top: 8px; margin-bottom: 0px;">
									<table class="table table-bordered">
										<tr>
											<td width="45%" class="pad-left-10"> <b> <%= lb_levelno %> </b> </td>
											<td width="11%" align="center"> <b> 1 </b> </td>
											<td width="11%" align="center"> <b> 2 </b> </td>
											<td width="11%" align="center"> <b> 3 </b> </td>
											<td width="11%" align="center"> <b> 4 </b> </td>
											<td width="11%" align="center"> <b> 5 </b> </td>
										</tr>
										<tr>
											<td class="pad-left-10"> <b> <%= lb_clearanti %> </b> </td>
											<td align="center"> <%= checkImgAtPos(rs.getString("clear_l1"), 0) %> </td>
											<td align="center"> <%= checkImgAtPos(rs.getString("clear_l2"), 0) %> </td>
											<td align="center"> <%= checkImgAtPos(rs.getString("clear_l3"), 0) %> </td>
											<td align="center"> <%= checkImgAtPos(rs.getString("clear_l4"), 0) %> </td>
											<td align="center"> <%= checkImgAtPos(rs.getString("clear_l5"), 0) %> </td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="tab-pane fade" id="2">
					<div class="row" style="margin-top: 20px">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_tshow_message %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= rs.getString("timeshowmess") %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_rdenable %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= rd2enable %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_ton_pic %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= rs.getString("timeonpicture") %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_rd_duty %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= rs.getString("rd2duty") %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_vdo_volume %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= rs.getString("vdo_volume") %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_timezone0_unlock %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= tzunlock %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_scr_serv %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= scr_server %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_wtransloop %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= write_transloop %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_camera %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= camera %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_card_antipassback %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= usecardantipb %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_cap_preview %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= capt_preview %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_proximity %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= proximity %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_disable_taff %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= disabletaff %> </h5>
						<h5 class="modal-title <%= col3 %>" > <div align="right" style="margin-left: -30px;"> <b> <%= lb_fingsecur %> : </b> </div> </h5>
						<h5 class="modal-title <%= col4 %>" > <%= rs.getString("fing_security") %> </h5>
					</div>
					<%= set_hr %>
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_disable_mifare %> : </b> </div> </h5>
						<h5 class="modal-title <%= col2 %>" > <%= disablemifare %> </h5>
						<h5 class="modal-title <%= col3 %>" > &nbsp; </h5>
						<h5 class="modal-title <%= col4 %>" > &nbsp; </h5>
					</div>
					<%= set_hr %>					
					<div class="row">
						<h5 class="modal-title <%= col1 %>" > &nbsp; </h5>
						<h5 class="modal-title <%= col2 %>" > &nbsp; </h5>
					</div>
				</div>
			</div>
			
		</div>
<%			}else{	%>
		<div class="alert alert-warning" role="alert">
			<center> <strong> <%= lb_nodata %> <%= lb_readerno %> <%= reader_no %> </strong> </center>
		</div>
<%	
			}
			rs.close();
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	}
%>
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>