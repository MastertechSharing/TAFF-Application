<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<% 
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "transaction");
	session.setAttribute("subtitle", "getcapture");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	String format_type = "";
	if(request.getParameter("format_type") != null){
		format_type = request.getParameter("format_type");
	}
	session.setAttribute("action", "cmd_get_capture_data.jsp?ip="+ip+"&door_id="+door_id+"&format_type="+format_type+"&");
	
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
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
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
			
			.bs-callout-info-border {
			  border-left-color: #d9534f;
			}
			.bs-callout-border {
			  padding: 10px;
			  margin: 10px 0;
			  border: 1px solid #d9534f;
			  border-left-width: 5px;
			  border-radius: 3px;
			}
		</style>
		
		<script>
			function reIframePass(ip, door_id){
				document.form_pass.action = "cmd_get_capture_iframe.jsp?iframe_pass=1&ip="+ip+"&door_id="+door_id+"&";
				document.getElementById("form_pass").submit();
			}
			
			function reIframeNotPass(ip, door_id){
				document.form_notpass.action = "cmd_get_capture_iframe.jsp?iframe_notpass=1&ip="+ip+"&door_id="+door_id+"&";
				document.getElementById("form_notpass").submit();
			}
		</script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container" style="margin-bottom: -35px;">
			
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
		
		String tmp_idcard = "";
		ResultSet rs_employee = null;
		
		String pathfile = "";
		if(!ip.equals("")){
			pathfile = path_data + ip + "\\CAPTURE_PICTURES\\FileCapture\\";
		}else{
			pathfile = path_data + door_id + "\\CAPTURE_PICTURES\\FileCapture\\";
		}
		File aDirectory = new File(pathfile);
		String[] filesInDir = aDirectory.list();
		if(!aDirectory.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("	<span class='alert-link'> "+msg_not_file_upload+" "+lb_cmd10+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
		
%>
				<div class="alert alert-info" role="alert" style="min-height: 50px;">
					<span class="modal-title col-xs-8 col-md-8">
						<span class="alert-link"> <%= lb_cmd10 %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </span>
					</span>
					<span class="modal-title col-xs-4 col-md-4" style="text-align: right;">
						<span class="alert-link"> <%// lb_viewdata %> </span> &nbsp;
						<div class="btn-group">
							<button class="btn btn-<% if(format_type.equals("pass")){ out.println("primary"); }else{ out.println("default"); } %> btn-xs button-shadow1 button-shadow2" id="Original" <% if(!format_type.equals("pass")){ %> onClick="location.href='cmd_get_capture_data.jsp?ip=<%= ip %>&door_id=<%= door_id %>&format_type=pass&';" <% } %> onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; &nbsp; <%= lb_transaction_pass %> &nbsp; &nbsp; &nbsp; </button>
							<button class="btn btn-<% if(format_type.equals("notpass")){ out.println("danger"); }else{ out.println("default"); } %> btn-xs button-shadow1 button-shadow2" id="Format" <% if(!format_type.equals("notpass")){ %> onClick="location.href='cmd_get_capture_data.jsp?ip=<%= ip %>&door_id=<%= door_id %>&format_type=notpass&';" <% } %> onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; &nbsp; <%= lb_transaction_notpass %> &nbsp; &nbsp; &nbsp; </button>
						</div>
					</span>
				</div>
				
				<div class="row" style="margin-top: -10px">
				
				<%	if(format_type.equals("pass")){	%>
				
					<form name="form_pass" id="form_pass" action="cmd_get_capture_iframe.jsp?view=iframe_pass" target="iframe_pass" method="post">
					
						<div class="col-md-12" style="height: 570px; border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
							<div class="bs-callout bs-callout-info" style="height: 570px;"> 
								<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
									<label class="control-label" style="margin-left: 3%; margin-top: 5px;"> <i class="glyphicon glyphicon-ok-circle" > </i> &nbsp; <b> <%= lb_transaction_pass %> </b> </label>
								</div>
								
								<div class="row form-group" style="margin-bottom: 5px;">
									<label class="control-label label-text-1 col-md-2"> <%= lb_eventcode %> : </label>
									<div class="col-md-4">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" style="max-height: 24px !important;" name="event_pass" id="event_pass" onChange="reIframePass('<%= ip %>', '<%= door_id %>');">
							<%				String sql_event_pass = " SELECT event_code, ";
											if(lang.equals("th")){
												sql_event_pass += " th_desc AS event_desc ";
											}else{
												sql_event_pass += " en_desc AS event_desc ";
											}
											sql_event_pass += " FROM dbevent WHERE event_code between '01' AND '05' ";
											
											ResultSet rs_event_pass = stmtUp.executeQuery(sql_event_pass);
							%>
											<option name="event_pass" value="00" selected> <%= lb_eventall %> </option>
							<%				while(rs_event_pass.next()){	%>
											<option name="event_pass" value="<%= rs_event_pass.getString("event_code") %>"> <%= rs_event_pass.getString("event_code") %> - <%= rs_event_pass.getString("event_desc") %> </option>
							<%  			}	rs_event_pass.close();	%>
										</select>
									</div>
									
									<label class="control-label label-text-1 col-md-2"> <%= lb_employeeall %> : </label>
									<div class="col-md-3">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" style="max-height: 24px !important;" name="idcard_pass" id="idcard_pass" onChange="reIframePass('<%= ip %>, '<%= door_id %>');">
											<option name="idcard_pass" value="NoID" selected> <%= lb_employeeall %> </option>
									<%	
										for(int i = 0; i < filesInDir.length; i++){
											
											String filename = filesInDir[i].substring(0, (filesInDir[i].length() -4));
											String[] data = filename.split("_");
											String idcard_pass = data[0];
											String event_pass = data[1];
											if(Integer.parseInt(event_pass) <= 5){
												if(!idcard_pass.equals(tmp_idcard)){
													tmp_idcard = idcard_pass;
													
													String fullname = "";
													String sql_employee = " SELECT ";
													if(lang.equals("th")){
														sql_employee += " th_fname AS fname, th_sname AS sname ";
													}else{
														sql_employee += " en_fname AS fname, en_sname AS sname ";
													}
													sql_employee += " FROM dbemployee WHERE idcard = '"+idcard_pass+"' ";
													rs_employee = stmtQry.executeQuery(sql_employee);
													while(rs_employee.next()){
														fullname = rs_employee.getString("fname")+" "+rs_employee.getString("sname");
													}
													rs_employee.close();
									%>
											<option name="idcard_pass" value="<%= idcard_pass %>"> <%= idcard_pass %> - <%= fullname %> </option>
									<%			}
											}
										}	
									%>
										</select>
									</div>
								</div>
								<div class="row form-group" style="margin-bottom: -5px;">
									<div class="col-md-12">
										<iframe id="iframe_pass" name="iframe_pass" src="cmd_get_capture_iframe.jsp?iframe_pass=1&ip=<%= ip %>&door_id=<%= door_id %>" style="margin-bottom: -20px;" width="100%" height="480px" frameborder="0" scrolling="yes"></iframe>
									</div>
								</div>
							</div>
						</div>
						
					</form>
					
				<%	}else if(format_type.equals("notpass")){	%>
				
					<form name="form_notpass" id="form_notpass" action="cmd_get_capture_iframe.jsp?view=iframe_notpass" target="iframe_notpass" method="post">
					
						<div class="col-md-12" style="height: 570px; border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
							<div class="bs-callout-border bs-callout-info-border" style="height: 570px;"> 
								<div class="row alert-message-danger" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
									<label class="control-label" style="margin-left: 3%; margin-top: 5px;"> <i class="glyphicon glyphicon-remove-circle" > </i> &nbsp; <b> <%= lb_transaction_notpass %> </b> </label>
								</div>
							
								<div class="row form-group" style="margin-bottom: 5px;">
									<label class="control-label label-text-1 col-md-2"> <%= lb_eventcode %> : </label>
									<div class="col-md-4">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" style="max-height: 24px !important;" name="event_notpass" id="event_notpass" onChange="reIframeNotPass('<%= ip %>', '<%= door_id %>');">
							<%				String sql_event_notpass = " SELECT event_code, ";
											if(lang.equals("th")){
												sql_event_notpass += " th_desc AS event_desc ";
											}else{
												sql_event_notpass += " en_desc AS event_desc ";
											}
											sql_event_notpass += " FROM dbevent WHERE event_code = '06' OR (event_code between '09' AND '23') ";
											
											ResultSet rs_event_notpass = stmtUp.executeQuery(sql_event_notpass);
							%>
											<option name="event_notpass" value="00" selected> <%= lb_eventall %> </option>
							<%				while(rs_event_notpass.next()){	%>
											<option name="event_notpass" value="<%= rs_event_notpass.getString("event_code") %>"> <%= rs_event_notpass.getString("event_code") %> - <%= rs_event_notpass.getString("event_desc") %> </option>
							<%  			}	rs_event_notpass.close();	%>
										</select>
									</div>
									
									<label class="control-label label-text-1 col-md-2"> <%= lb_employeeall %> : </label>
									<div class="col-md-3">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" style="max-height: 24px !important;" name="idcard_notpass" id="idcard_notpass" onChange="reIframeNotPass('<%= ip %>', '<%= door_id %>');">
											<option name="idcard_notpass" value="NoID" selected> <%= lb_employeeall %> </option>
									<%	
										tmp_idcard = "";
										for(int i = 0; i < filesInDir.length; i++){
											
											String filename = filesInDir[i].substring(0, (filesInDir[i].length() -4));
											String[] data = filename.split("_");
											String idcard_notpass = data[0];
											String event_notpass = data[1];
											if(Integer.parseInt(event_notpass) == 6 || (Integer.parseInt(event_notpass) >= 9 && Integer.parseInt(event_notpass) <= 23)){
												if(!idcard_notpass.equals(tmp_idcard)){
													tmp_idcard = idcard_notpass;
													
													String fullname = "";
													String sql_employee = " SELECT ";
													if(lang.equals("th")){
														sql_employee += " th_fname AS fname, th_sname AS sname ";
													}else{
														sql_employee += " en_fname AS fname, en_sname AS sname ";
													}
													sql_employee += " FROM dbemployee WHERE idcard = '"+idcard_notpass+"' ";
													rs_employee = stmtQry.executeQuery(sql_employee);
													while(rs_employee.next()){
														fullname = rs_employee.getString("fname")+" "+rs_employee.getString("sname");
													}
													rs_employee.close();
									%>
											<option name="idcard_notpass" value="<%= idcard_notpass %>"> <%= idcard_notpass %> - <%= fullname %> </option>
									<%			}
											}
										}	
									%>
										</select>
									</div>
								</div>
								<div class="row form-group" style="margin-bottom: -5px;">
									<div class="col-md-12">
										<iframe id="iframe_notpass" name="iframe_notpass" src="cmd_get_capture_iframe.jsp?iframe_notpass=1&ip=<%= ip %>&door_id=<%= door_id %>" style="margin-bottom: -20px;" width="100%" height="480px" frameborder="0" scrolling="yes"></iframe>
									</div>
								</div>
							</div>
						</div>
						
					</form>
					
				<%	}	%>
					
				</div>
				
<%	
		}
	}catch(SQLException e){
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
	}	
%>  
			</div>
		</div>
		
		<div class="modal fade" id="myModalViewCapture" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="" id="view_capture" name="view_capture" frameborder="0" height="470px" style="min-width: 530px;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>
		
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