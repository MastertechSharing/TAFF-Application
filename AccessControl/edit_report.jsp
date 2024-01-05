<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<% 
	session.setAttribute("page_g", "setting");
	session.setAttribute("subpage", "config");
	session.setAttribute("subtitle", "report");
	String action = "";
	if(request.getParameter("action") != null){
		action = request.getParameter("action");
	}else{
		response.sendRedirect("data_report.jsp");
	}
	session.setAttribute("action", "edit_report.jsp?"+"&action="+action+"&rep_code="+request.getParameter("rep_code")+"&");	
	session.setAttribute("act", action);
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/check_key.js"></script> 
		<script language="javascript" src="js/alert_box.js"></script>
		
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
		
		<script language="javascript">
			document.onkeydown = searchKeyPress;
		 	
			function change_class(field_name){
				if(field_name == 'rep_code'){
					if(document.form1.rep_code.value != ""){
						document.getElementById("textbox_rep_code").className = "form-group has-success has-feedback";
						document.getElementById("icon_rep_code").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_rep_code").className = "form-group has-error has-feedback";
						document.getElementById("icon_rep_code").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}
			}
		</script>	
	</head>
	<!--onLoad="removeScrollBars();"-->
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<div class="body-display">
			<div class="container">				
			<form id="form1" name="form1" method="post">
			
				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info"> 
				<% 
					if (action.equals("edit")) {
						String rep_code = request.getParameter("rep_code"); 
						try{			
							ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbreport WHERE (rep_code = "+rep_code+")");
							while(rs.next()){
				%>				
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_repcode %> : </label>
							<div class="col-md-4">
								<div class="form-group has-success has-feedback" id="textbox_rep_code" style="margin-bottom: 0px">
									<input type="text" class="form-control" id="rep_code" name="rep_code" value="<%= rep_code %>" maxlength="6" placeholder="<%= rep_code %>" readonly>
									<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_rep_code" aria-hidden="true"> </span>
									<input type="hidden" name="rep_code2" id="rep_code2" value="<%= rep_code %>">
								</div>
							</div>
							<div class="col-md-6" style="margin-top: 6px;"> </div>
						</div>
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_thdesc %> : </label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="th_desc" name="th_desc" value="<%= rs.getString("th_desc") %>" maxlength="50" placeholder="<%= lb_thdesc %>">
							</div>
							<div class="col-md-6"> </div>
						</div> 
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_endesc %> : </label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="en_desc" name="en_desc" value="<%= rs.getString("en_desc") %>" maxlength="50" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
							</div>
							<div class="col-md-6"> </div>
						</div> 
						<div class="row form-group" style="margin-bottom: 0px;">
							<div class="col-md-12" align="center">
								<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return Confirm_add_edit(document.form1.rep_code, '<%= msg_confirmedit %>', '<%= msg_input_rep%>', 'module/act_report.jsp?action=edit', 'edit');"> &nbsp; 
								<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_report.jsp'">
							</div>
						</div> 
				<%	
							}	rs.close();
						}catch(SQLException e){	
							out.println("<span class='err_exp'> SQL Exception :"+e.getMessage()+"</span>");		
						}				
					}
				%>
					</div>
				</div>
			</form> 	
			
			</div>
		</div>
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-floppy-saved alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_report.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> 
									<input type="hidden" id="text_url" name="text_url" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script>
			function ConfirmEdit(obj,msg1,msg2,url,act){
				if(obj.value == ""){
					ModalWarning_ObjectName(msg2, obj);
					return false;
				}
				if(act == 'edit'){
					if (confirm(msg1)){	
						document.form1.action = url;	
						document.form1.submit();		
					}else{
						 history.back();
					}	
				}				
			}		
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>    