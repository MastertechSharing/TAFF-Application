<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/connect.jsp"%>
<% 	
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	
	session.setAttribute("action", "login.jsp?");
	
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
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title><%= sw_title %></title>
		
		<script src="js/check_key.js"></script>
		<script language="javascript" src="js/alert_box.js"></script> 
		
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
		<%= font_face %>
		
		<script language="javascript">
			document.onkeydown = searchKeyPress;
			function searchKeyPress(e){
				//	look for window.event in case event isn't passed in
				if(window.event){
					e = window.event;
				}
				if(e.keyCode == 13){
					document.getElementById('btnok').click();
				}
			}
			
			function checkInput(sText1, sText2){
				document.getElementById('img_loading_login').style.display = '';
				document.getElementById('msg_loading_login').style.display = '';
				document.getElementById('glyphicon_loading_login').style.display = 'none';
				document.getElementById('div_close').style.display = 'none';
				
				var key = event.keyCode;
				if(document.form1.username.value == ''){
					ModalWarning_TextName(sText1, "username");
					return false;
				}else if (document.form1.password.value == ''){
					ModalWarning_TextName(sText2, "password");
					return false;
				}else{
					checkLogin();
				//	document.form1.action = 'module/check_login.jsp?';				
				//	document.form1.submit();
				}
			}
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</head>
		
	<body style="background-color: #F0F0F0; overflow-y: hidden;" onLoad="form1.username.focus();" class="tone-background">
	
<%  	
		String msg_error = "";
		if(request.getParameter("msg") == null){
			msg_error = "";
		}else if(request.getParameter("msg").equals("6")){	//	logout session
			//	Set Alert Box
			type_alert = "success";
			type_glyphicon = "ok-circle";
			text_result = msg_logoutcomplete;
		}else{
			if((request.getParameter("msg").equals("1"))){ 
				msg_error = msg_un_inuse;
			}else if(request.getParameter("msg").equals("2")){
				msg_error = msg_unpw_incorrect;
			}else if(request.getParameter("msg").equals("3")){
				msg_error = msg_unpw_expire;
			}else if(request.getParameter("msg").equals("4")){
				msg_error = msg_unpw_duplicate;
			}else if(request.getParameter("msg").equals("5")){
				msg_error = msg_unpw_duplicate2;
			}
			//	Set Alert Box
			type_alert = "danger";
			type_glyphicon = "remove-circle";
			text_result = msg_error;
		}
		
		String set_size = "font-size: 14px;";
		if(lang.equals("en")){
			set_size = "font-size: 12px;";
		}
%>		
		<center>
		<form name="form1" id="form1" method="post" autocomplete="off">
			<div class="form-login form-raduis-10 form-transparent-7">
				<div class="container" style="width: 390px;">
					<h2 align="right" style="margin-top: -20px; margin-bottom: -20px;"> 
						<div style="display: inline-block; font-size: 14px; color: #14639F;"> <b> <%= lb_language2 %> : </b> </div>
						<a href="<%= (String)session.getAttribute("action") %>lang=th"><img src="images/thland.png" align="absmiddle" style="margin-top: 5px;" width="24" height="18" border="0" data-toggle="tooltip" data-placement="top" title="<%= lb_thai %>"></a> 
						<a href="<%= (String)session.getAttribute("action") %>lang=en"><img src="images/enland.png" align="absmiddle" style="margin-top: 5px;" width="24" height="18" border="0" data-toggle="tooltip" data-placement="top" title="<%= lb_eng %>"></a>
					</h2>
					<h2 class="form-signin-heading" align="left"> 
						<img src="images/lock.png" border="0" align="absmiddle" width="32" height="32">
						<%= lb_login %> &nbsp;
					</h2>
				<!--	<h5 class="form-signin-heading" align="left"> <font style="color: #E22C31;"> <strong> <%= msg_error %> </strong> </font> </h5>	-->
					<h5 class="form-signin-heading" align="left"> <font style="color: #E22C31;"> <strong> <p id="msg"> </p> </strong> </font> </h5>
					<label class="sr-only"> <%= lb_username %> </label>
					<input type="text" id="username" name="username" class="form-control" maxlength="16" placeholder="<%= lb_username %>" onKeyPress="IsValidCharacter()">
					
					<div style="height: 10px;"></div>
					<label for="inputPassword" class="sr-only"> <%= lb_password %> </label>
					<input type="password" id="password" name="password" class="form-control" maxlength="16" placeholder="<%= lb_password %>">
					
					<div style="height: 10px;"></div>
					<button class="btn btn-md btn-primary btn-block button-shadow1 button-shadow2" type="button" id="btnok" onClick="checkInput('<%= msg_userlogin %>', '<%= msg_pwlogin %>')"> <%= btn_ok %> </button>
					
					<div align="center"> 
						<label class="control-label" style="height: 35px; padding-top: 10px; padding-bottom: 40px;">
							<a href="change_password.jsp"><img src="images/dialog-pass.png" border="0" align="absmiddle" width="24" height="24"></a> <a href="change_password.jsp" style="<%= set_size %>"> <%= lb_changpassword %> </a>
							&nbsp;|&nbsp;
							<a href="close_server.jsp"><img src="images/close.png" border="0" align="absmiddle" width="20" height="24"></a> <a href="close_server.jsp" style="<%= set_size %>"> <%= lb_closesys %> </a>
							&nbsp;|&nbsp;
							<a href="logout.jsp"><img src="images/logout.png" border="0" align="absmiddle" width="24" height="24"></a> <a href="logout.jsp" style="<%= set_size %>"> <%= lb_logoutsys %> </a>
						</label>
					</div>
				</div>
			</div>
		</form>
		</center>
		
		<div class="modal fade" id="myModalWarning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_warning" class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_warning" class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_warning"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_warning" onClick="javascript: $('#myModalWarning').modal('hide'); javascript: document.getElementById($('#object_warning').val()).focus(); " style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> 
									<input type="hidden" id="object_warning" name="object_warning" readonly>
									<input type="hidden" id="datetime_warning" name="datetime_warning" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="tools/modal_result.jsp"%>

		<iframe src="" id="iframe_login" name="iframe_login" frameborder="0" height="0px" width="0px"> </iframe>
		
		<div class="modal fade" id="myModalProcess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-notice">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> 
								<img src="images/loading2.gif" name="img_loading_login" id="img_loading_login" width="48" height="48" align="absmiddle"> 
								<i class="glyphicon glyphicon-warning-sign" name="glyphicon_loading_login" id="glyphicon_loading_login" style="display: none; font-size: 46px; color: #B8B72C; margin-top: -2px;" align="absmiddle"> </i>
							</div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<h4> <p name="msg_loading_login" id="msg_loading_login"> <%= lb_please_wait %> </p> </h4> 
							</div>
							<div class="col-xs-12 col-md-12" id="div_close" style="margin-top: 15px; margin-bottom: 15px; display: none;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_close" onClick="$('#myModalProcess').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="myModalDangerNoReturn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-danger">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-remove-circle alert-message-danger" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_danger_noreturn"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_danger" onClick="$('#myModalDangerNoReturn').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="myModalDuplicateIP" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <%= msg_duplicate_ip %> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" onClick="javascript: window.top.location.href = 'data_door.jsp?ip=1'" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="document.getElementById('iframe_login').contentWindow.Homepage();" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_confirm" class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; " border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_confirm" class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> <%= msg_alert_expire1 %> <span id="date_expire"></span><br/><br/><%= msg_alert_expire2 %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" onClick="document.getElementById('iframe_login').contentWindow.Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="document.getElementById('iframe_login').contentWindow.Homepage();" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalSuccessRenew" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_success" class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_success" class="glyphicon glyphicon-ok-circle alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_sucess"> <%= msg_alert_renew_expire1 %><br/><br/><%= msg_alert_renew_expire2 %><span id="new_date_expire"></span> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_success" onClick="document.getElementById('iframe_login').contentWindow.OK_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script>
			function checkLogin(){
				$('#form1').attr('action', 'module/check_login.jsp?action=setmsg');
				$('#form1').attr('target', 'iframe_login');
				$('#form1').submit();
				
				$('#myModalProcess').modal('show');
			}
			
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
					setTimeout(function(){
						document.form1.username.value = '';
						document.form1.password.value = '';
					}, 30);
					
				<%	if(!text_result.equals("")){	%>
					$('#myModalResult').modal('show');
					setTimeout(function(){
						$('#myModalResult').modal('hide');
					}, 3000);
				<%	}	%>
				}
			}
		</script>
		
	</body>
</html>