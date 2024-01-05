<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<%	
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "getproperty");
	session.setAttribute("subtitle", "getconfig2");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "cmd_get_config2_data.jsp?ip="+ip+"&door_id="+door_id+"&");	
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
			pathfile = path_data+ip+"\\MURD67_2.CFG";
		}else{
			pathfile = path_data+door_id+"\\MURD67_2.CFG";
		}
		File f = new File(pathfile);	
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("	<span class='alert-link'> "+msg_not_file_upload+" "+lb_getconfig2+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
			String col1 = "col-xs-3 col-md-3";
			String col2 = "col-xs-3 col-md-3";
			String col_line = "col-xs-12 col-md-12";
			String set_hr = " <div class='row' class='"+col_line+"' > <hr style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
			String set_hr2 = " <div class='row' class='"+col_line+"' > <hr style='height: 6px; margin-top: 8px; margin-bottom: 4px; width: 98%;' /> </div> ";
			
			BufferedReader in = new BufferedReader(new FileReader(pathfile));
			String textStr = "";
			String timeShowMsg = "", timeOnPic = "", transLoop = "", tz0Unlock = "", antipassback = "", proximity = "", 
					fingerSecure = "", rd2Mode = "", rdDuty = "", vdoVolume = "", screenServer = "", camera = "", 
					capturePreview = "", disableTaff = "", disableMifare = "";
			while((textStr = in.readLine()) != null){
				if(textStr.length() == 150){
					timeShowMsg = textStr.substring(0,1);
					timeOnPic = textStr.substring(1,4);
					transLoop = displayWriteTransLoop(textStr.substring(4,5),lang);
					tz0Unlock = displayTZ0Unlock(textStr.substring(5,6),lang);
					antipassback = getUseOrNotUse(textStr.substring(6,7),lang);
					proximity = displayProx(textStr.substring(7,8),lang);
					fingerSecure = textStr.substring(8,9);
					rd2Mode = displayRd2Mode(textStr.substring(9,10),lang);
					rdDuty = textStr.substring(10,11);
					vdoVolume = textStr.substring(11,12);
					screenServer = displayActive(textStr.substring(12,13),lang);
					camera = displayActive(textStr.substring(13,14),lang);
					capturePreview = displayActive(textStr.substring(14,15),lang);
					disableTaff = displayActive(textStr.substring(15,16),lang);
					disableMifare = displayActive(textStr.substring(16,17),lang);
%>			
				<div class="alert alert-info" role="alert">
					<span class="alert-link"> <%= lb_getconfig2 %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </span>
				</div>
				
				<div class="table-responsive" style="border: 0px !important; margin-left: -5px; margin-right: -29px; margin-top: -15px;" border="0">
					
					<div style="min-width: 1000px; max-width: 98%; margin-left: 0px; margin-right: -30px;" class="table" border="0">	
					
						<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px; margin-bottom: 10px;"> 
							<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <%= lb_reader %> [<%= lb_add_config %>] </label>
							</div>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_tshow_message %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= timeShowMsg %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_rdenable %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= rd2Mode %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_ton_pic %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= timeOnPic %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_rd_duty %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= rdDuty %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_vdo_volume %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= vdoVolume %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_timezone0_unlock %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= tz0Unlock %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_scr_serv %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= screenServer %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_wtransloop %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= transLoop %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_camera %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= camera %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_card_antipassback %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= antipassback %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_cap_preview %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= capturePreview %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_proximity%> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= proximity %> </h5>
							</div>					
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_disable_taff %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= disableTaff %> </h5>
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <%= lb_fingsecur %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= fingerSecure %> </h5>
							</div>
							<%= set_hr2 %>
							<div class="row">
								<h5 class="modal-title <%= col1 %>" > <label class="control-label"> <b> <%= lb_disable_mifare %> </label> </h5>
								<h5 class="modal-title <%= col2 %>" > <%= disableMifare %> </h5>
								<h5 class="modal-title <%= col1 %>" > &nbsp; </h5>
								<h5 class="modal-title <%= col2 %>" > &nbsp; </h5>
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