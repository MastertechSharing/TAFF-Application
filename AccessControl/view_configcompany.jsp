<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<% 
	session.setAttribute("page_g", "setting");
	session.setAttribute("subpage", "config");
	session.setAttribute("subtitle", "configcompany");
	session.setAttribute("action", "view_configcompany.jsp?");
	session.setAttribute("act", "");

	// show modal alert success
	String text_result = "", type_alert = "success", type_glyphicon = "ok-circle";
	if(session.getAttribute("session_alert") != null){
		text_result = (String)session.getAttribute("session_alert");
		session.setAttribute("session_alert", null);
		if(session.getAttribute("type_alert") != null){
			type_alert = (String)session.getAttribute("type_alert");
			type_glyphicon = "remove-circle";
			session.setAttribute("type_alert", null);
		}
	}
%>
<span/>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

	</head> 
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">		
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>		
		
		<div class="body-display">
			<div class="container">			
		<%	String mail_user = "", mail_pass = "", mailport = "", readerf = "", smspass = "";
			try{
				ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbcompany");
				while(rs.next()){ 					
					mail_user = rs.getString("mail_user");
					mail_pass = rs.getString("mail_pass");					
					mailport = rs.getString("mail_port");
					smspass = rs.getString("sms_pass");
					 
					if(rs.getInt("readerf") == 0){
						readerf = "Access";
					}else if(rs.getInt("readerf") == 1){
						readerf = "Time Attendance";
					}else if(rs.getInt("readerf") == 2){
						readerf = "Access & Time Attendance";
					}
					
					if(!(mail_user == null || mail_user.equals("null") || mail_user.equals(""))){
						if(!(mail_pass == null || mail_pass.equals("null") || mail_pass.equals(""))){
							mail_user = rs.getString("mail_user");
							mail_pass = rs.getString("mail_pass");
							if(!(mail_pass.equals(""))){
								mail_pass = "**********";
							}
						}
					}else{
						mail_user = "&nbsp;";
						mail_pass = "&nbsp;";
					}
					
					if(!(smspass.equals("") || smspass.equals("null") || smspass == null)){
						smspass = "**********";
					}				
		%>	
				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info"> 
						<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
							<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <%= lb_configcom %> </label>
						</div>
						<div class="row form-group col-md-12">
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_thcompany %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= rs.getString("th_desc") %> </label>
							</div>
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-6"> <%= lb_encompany %> : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= rs.getString("en_desc") %> </label>
							</div>
						</div>
						<div class="row form-group col-md-12">
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_thaddress %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= rs.getString("th_addr") %> </label>
							</div>
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-6"> <%= lb_enaddress %> : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= rs.getString("en_addr") %> </label>
							</div>
						</div>
						<div class="row form-group col-md-12">
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_www %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= rs.getString("com_www") %> </label>
							</div>
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-6"> <%= lb_typeofsys %> : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= readerf %> </label>
							</div>
						</div>
						<div class="row form-group col-md-12">
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_timein %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= rs.getString("time_in") %> </label>
							</div>
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-6"> <%= lb_timeout %> : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= rs.getString("time_out") %> </label>
							</div>
						</div>
						<div class="row form-group col-md-12">
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_hourday %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= rs.getString("hour_day") %> </label>
							</div>
							<div class="col-md-6" style="margin-left: -5px;">
								<label class="control-label label-text-1 col-md-6"> <%= lb_numoftrans %> : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= rs.getString("keepdays") %> </label>
							</div>
						</div>
						<div class="row form-group" style="margin-bottom: -10px;"> </div>
					</div> 
				</div> 
				
				<div class="row" style="margin-bottom: -5px;"> &nbsp; </div>
			
				<div class="row">				
					<div class="col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-envelope"> </i> &nbsp; Mail </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_email %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= rs.getString("com_email") %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mail_user %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= mail_user %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mail_pass %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= mail_pass %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mailsmtp %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%=  rs.getString("mail_smtp") %> </label>
							</div>
							<div class="row form-group" style="margin-bottom: 5px;">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mailport %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= mailport %> </label>
							</div>
						</div> 
					</div>
				
					<div class="col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-envelope"> </i> &nbsp; SMS </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_smshost %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= rs.getString("sms_host") %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_smsport %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= rs.getString("sms_port") %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mail_user %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= rs.getString("sms_user") %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-5"> <%= lb_mail_pass %> : </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> <%= smspass %> </label>
							</div>
							<div class="row form-group" style="margin-bottom: 5px;">
								<label class="control-label label-text-1 col-md-5"> &nbsp; </label>
								<label class="control-label col-md-7" style="margin-top: 6px;"> &nbsp; </label>
							</div>
						</div> 
					</div> 					
				</div> 
				
			<%	if(ses_per == 0){	%>
				<div class="row" style="border: 0px !important; margin-top: -15px; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
						<center>
							<input name="Submit2" type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_edit %> &nbsp; &nbsp; &nbsp; " onClick="location.href='edit_configcompany.jsp'"> &nbsp; 
						</center>
					</div>
				</div>	
	<%
				}	
			}
			rs.close();
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	%>
		
		<%@ include file="tools/modal_result.jsp"%>
		
		<script>
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				$('body').addClass('loaded');
				
				<%	if(!text_result.equals("")){	%>
				$('#myModalResult').modal('show');
				setTimeout(function(){
					$('#myModalResult').modal('hide');
				}, 3000);
				<%	}	%>
			}
		}
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>