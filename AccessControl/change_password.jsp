<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/language.jsp"%>

<% 
	session.setAttribute("action", "change_password.jsp?");
	
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
					
		function checkInput(str1, str2, lang){
			var str3, str4, str5, str6, str7 = "";
			if(lang == "th"){
				str3 = "กรุณากรอกรหัสผ่านใหม";
				str4 = "Password ต้องมีตั้งแต่ 4 ตัวขึ้นไป<br/><br/>กรุณากรอก Password ใหม่อีกครั้ง";
				str5 = "กรุณายืนยันรหัสผ่านใหม่";
				str6 = "ยืนยันรหัสผ่านใหม่ของคุณไม่ถูกต้อง";
				str7 = "รหัสผ่านใหม่ต้องไม่ซ้ำกับรหัสผ่านเก่า";
			}else{
				str3 = "Please input newpassword";
				str4 = "Valid entries are begin 4 characters.<br/><br/>Please verify your input and submit again.";
				str5 = "Please confirm input newpassword";
				str6 = "Confirm new password is incorrect";
				str7 = "New password not duplicate Old password";
			}
			
			
			if(form1.username.value == ''){
				ModalWarning_TextName(str1, "username");
				return false;		
			}else if (form1.password.value == ''){
				ModalWarning_TextName(str2, "password");
				return false;		
			}else if (form1.password1.value == ''){		
				ModalWarning_TextName(str3, "password1");
				return false;		
			}else if (form1.password1.value.length < 4 ){
				ModalWarning_TextName(str4, "password1");
				return false;		
			}else if (form1.password2.value == ''){ 
				ModalWarning_TextName(str5, "password2");
				return false;		
			}else if (form1.password2.value.length < 4){
				ModalWarning_TextName(str4, "password2");
				return false;		
			}else if (form1.password2.value != form1.password1.value){
				ModalWarning_TextName(str6, "password2");
				return false;
			}else{
				document.form1.action = 'module/change_password.jsp';
				document.form1.submit();
			}
		}
		</script>
	</head>
		
	<body style="background-color: #F0F0F0;" onLoad="form1.username.focus();" class="tone-background">

<% 	
		String alert_mess = "";
		if((request.getParameter("mes") != "" ) && (request.getParameter("mes") != null)){
			alert_mess = msg_unpwerror;				
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
						<img src="images/dialog-pass.png" border="0" align="absmiddle" width="32" height="32">
						<%= lb_changpassword %> 
					</h2>
					<h5 class="form-signin-heading" align="left"> <font style="color: #E22C31;"> <strong> <%= alert_mess %> </strong> </font> </h5>
					<label class="sr-only"> <%= lb_username %> </label>
					<input type="text" id="username" name="username" class="form-control" maxlength="16" placeholder="<%= lb_username %>" onKeyPress="IsValidCharacter()" autofocus="">
					
					<div style="height: 10px;"></div>
					<label for="inputPassword" class="sr-only"> <%= lb_password %> </label>
					<input type="password" id="password" name="password" class="form-control" maxlength="16" placeholder="<%= lb_password %>">
					
					<div style="height: 10px;"></div>
					<label for="inputPassword" class="sr-only"> <%= lb_password %> </label>
					<input type="password" id="password1" name="password1" class="form-control" maxlength="16" placeholder="<%= lb_newpw %>">
					
					<div style="height: 10px;"></div>
					<label for="inputPassword" class="sr-only"> <%= lb_password %> </label>
					<input type="password" id="password2" name="password2" class="form-control" maxlength="16" placeholder="<%= lb_confirmpw %>">
					
					<div style="height: 10px;"></div>
					<button type="button" class="btn btn-md btn-primary btn-block button-shadow1 button-shadow2" id="btnok" onClick="checkInput('<%= msg_userlogin %>', '<%= msg_pwlogin %>', '<%= lang %>');"> <%= btn_ok %> </button>
					
					<div style="height: 10px;"></div> 
					<button type="button" class="btn btn-md btn-default btn-block button-shadow1 button-shadow2" onClick="location.href='login.jsp'" > <%= btn_cancel %> </button>
					<br/>
					
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
		
		<script>
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
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