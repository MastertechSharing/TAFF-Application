<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>

<% 
	session.setAttribute("action", "close_server.jsp?");
	
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
			
			function checkInput(sText1, sText2){
				if(form1.username.value == ''){
					ModalWarning_TextName(sText1, "username"); 
					return false;
				}else if (form1.password.value == ''){
					ModalWarning_TextName(sText2, "password");
					return false;
				}else{
					document.form1.submit();
				}
			}
			
			function ModalAlertSystem(status){
				if(status == 'close'){
					$('#myModalCloseSystem').modal('show');
				}else if(status == 'open'){
					$('#myModalOpenSystem').modal('show');
				}
			}
			
			function close_server(){
				document.location = 'close_server_image.jsp';
			}
			
			function open_server(){
				document.location = 'login.jsp';
			}
		</script>
	</head>
		
	<body style="background-color: #F0F0F0;" onLoad="form1.username.focus();" class="tone-background">
	
		<div class="modal fade" id="myModalOpenSystem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-ok-circle alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p> <%= msg_opensys %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="open_server();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> 
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalCloseSystem" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-ban-circle alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p> <%= msg_closesys %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="close_server();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> 
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
<%	
	if (request.getParameter("action") == "admin") {
		out.println("<script> location.href='login.jsp'; </script>");
	}

	File tmp_file = new File("C:/", "close.txt");
	String msg = "";
	String lb_text = "";
	
	//	ไฟล์อินพูตมีอยู่จริงหรือป่าว
	if (!tmp_file.exists()) {
		lb_text = lb_closesys;
	} else {
		lb_text = lb_opensys;
	}

	if ((request.getParameter("username") != null) && (request.getParameter("password") != null)) {
		String username = request.getParameter("username");
		String password1 = request.getParameter("password");
		String us = "";
		String ps = "";
		String ex = "";
		String sql = "";
		String user_right = "";		
		try{
			String user_password = getPassword(password1,stmtQry,mode);
			
			sql = "SELECT ex_date, user_name, pass_word, user_right FROM dbusers WHERE (user_name='"
					+ username + "') AND (pass_word = '" + user_password + "') ";
			ResultSet rs = stmtQry.executeQuery(sql);
			while (rs.next()) {
				us = rs.getString("user_name");
				ps = rs.getString("pass_word");
				ex = rs.getString("ex_date");
				user_right = rs.getString("user_right");
			}

			//	check user_name,pass_word
			if (!(us.equals("") && (ps.equals("")))) { 				
				if ((user_right.equals("0"))) {		//	check user_right = admin
					String date_str = getCurrentDateyyyyMMdd();
					int flg = date_str.compareTo(ex);
					if (flg <= 0) {
						try{
							//	ถ้าไม่มีไฟล์ close.txt จริง
							if (!tmp_file.exists()) { 								
								tmp_file.createNewFile();	//	สร้างไฟล์ใหม่
								out.println("<script> ModalAlertSystem('close'); </script>");
							} else {
								tmp_file.delete();
								out.println("<script> ModalAlertSystem('open'); </script>");
							}
						}catch (Exception e){
							out.println(e.getMessage());
						}
					} else {
						msg = msg_unpw_expire;
					}
				} else {
					msg = msg_userright;
				}
			} else {
				msg = msg_unpw_incorrect;
			}
			rs.close();
		}catch (SQLException sqle){
			out.println(sqle.getMessage());
		}
		//	Set Alert Box
		type_alert = "danger";
		type_glyphicon = "remove-circle";
		text_result = msg;
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
						<img src="images/close.png" border="0" align="absmiddle" width="24" height="32">
						<%= lb_text %> 
					</h2>
					<h5 class="form-signin-heading" align="left"> <%= msg %> </h5>
					<label class="sr-only"> <%= lb_username %> </label>
					<input type="text" id="username" name="username" class="form-control" maxlength="16" placeholder="<%= lb_username %>" onKeyPress="IsValidCharacter()">
					
					<div style="height: 10px;"></div>
					<label for="inputPassword" class="sr-only"> <%= lb_password %> </label>
					<input type="password" id="password" name="password" class="form-control" maxlength="16" placeholder="<%= lb_password %>">
					
					<div style="height: 10px;"></div>
					<button type="button" class="btn btn-md btn-primary btn-block button-shadow1 button-shadow2" id="btnok" onClick="checkInput('<%= msg_userlogin %>','<%= msg_pwlogin %>')"> <%= lb_text %> </button>
					
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
					setTimeout(function(){
						document.form1.username.value = '';
						document.form1.password.value = '';
					}, 30);
					
				<%	if(!text_result.equals("")){	
						session.setAttribute("session_alert", null);
				%>
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
<%@ include file="../function/disconnect.jsp"%>