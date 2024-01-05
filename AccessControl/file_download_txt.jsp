<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "download");
	session.setAttribute("subtitle", "downloadtxt");       
	session.setAttribute("action", "file_download_txt.jsp?");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
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
		
		<script>
			function change_class(field_name){
				if(field_name == 'server_code'){
					document.getElementById("select_"+field_name).className = "input-group has-success has-feedback";
					document.getElementById("icon_"+field_name).className = "glyphicon glyphicon-ok form-control-feedback";
				}
			}	
		</script>	
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="overflow-y: hidden;">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">
			
			<%	
				String server_code = "", has = "has-error", glyphicon = "glyphicon-star", file_type = "";
				if(request.getParameter("server_code") != null && request.getParameter("server_code") != ""){
					server_code = request.getParameter("server_code");
					has = "has-success";
					glyphicon = "glyphicon-ok";
				}
				if(request.getParameter("file_type") != null){
					file_type = request.getParameter("file_type");
				}
				
			%>
	  
				<div class="table-responsive" style="border: 0px !important; margin-bottom: -25px; margin-left: -15px; margin-right: -15px;" border="0">
					<div style="min-width: 550px;" class="table" border="0">

						<form id="form1" name="form1" method="post">	
						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">
								
								<div class="bs-callout bs-callout-info"> 
									<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
										<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-calendar"> </i> &nbsp; <%= lb_downloaddata2 %> </label>
									</div>
									<p>
									<div class="row">
										<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 8px;"> <div align="right"> <b> <%= lb_servercode %> : </b> </div> </h5>
										<div class="modal-title col-xs-4 col-md-4"> 
											<div class="input-group <%= has %> has-feedback" id="select_server_code">
												<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="10" data-container="body" name="server_code" id="server_code" onChange="change_class('server_code');">
													<option name="server_code" value="a" disabled selected> <%= lb_select_servercode %> </option>
										<% 		ResultSet rs = stmtQry.executeQuery(" SELECT * FROM dbserver_config ORDER BY server_code ASC ");	%>
										<%		while(rs.next()){	%> 
													<option name="server_code" value="<%= rs.getString("server_code") %>" <%= checkDataSelected(rs.getString("server_code"), server_code) %>> <%= rs.getString("server_code") %> - <%= rs.getString("server_ip") %> </option>
										<%  	}	rs.close();		%>
												</select>
												<span class="input-group-addon" style="background-color: #ffffff;">
													<span class="glyphicon <%= glyphicon %> form-control-feedback" id="icon_server_code" aria-hidden="true"> </span> &nbsp; &nbsp;
												</span> 
											</div>
										</div>
										<div class="modal-title col-xs-6 col-md-6"> </div>
									</div>
									<p>
									<div class="row">
										<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 8px;"> <div align="right"> <b> <%= lb_type_file %> : </b> </div> </h5>
										<div class="modal-title col-xs-4 col-md-4">
											<select class="form-control selectpicker" data-width="100%" data-size="10" data-container="body" name="file_type" id="file_type">
												<option value="TXT" <%= checkDataSelected("TXT", file_type) %>> TXT </option>
												<option value="STD" <%= checkDataSelected("STD", file_type) %>> STD </option>
												<option value="TA" <%= checkDataSelected("TA", file_type) %>> TA </option>
											</select>
										</div>
										<div class="modal-title col-xs-1 col-md-1"> </div> 
										<div class="modal-title col-xs-4 col-md-4" align="left"> 
											<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= lb_viewdata %> &nbsp; &nbsp; &nbsp; " onClick="listDownload('<%= lb_select_servercode %>');"> &nbsp; 
										</div>
										<div class="modal-title col-xs-1 col-md-1"> </div> 
									</div>
								</div>
							</div>
						</div>
						</form>
					
					</div>
				</div>
				
			</div>
		</div>

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
		
		<div class="modal fade" id="myModalViewDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document" style="min-width: 850px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_detail" name="view_detail" frameborder="0" height="480px" style="min-width: 810px; overflow: hidden;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<div class="row">
							<div class="col-xs-3 col-md-3" style="text-align: left;">
								<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" onClick="viewData('backup');"> <i class="glyphicon glyphicon-inbox"> </i> &nbsp; <%= lb_backup_txt %> </button>
							</div>
							<div class="col-xs-7 col-md-7"> 
							<!--
								<div style="text-align: left; margin-top: 6px; margin-left: -35px; margin-right: -35px;">
									<span class="has-error"> <label class="control-label"> <%= lb_when_download_txt %> </label> </span>
								</div>
							-->
							</div>
							<div class="col-xs-2 col-md-2">
								<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalViewBackup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document" style="min-width: 850px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_backup_txt %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_backup" name="view_backup" frameborder="0" height="480px" style="min-width: 810px; overflow: hidden;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<div class="row">
							<div class="col-xs-3 col-md-3" style="text-align: left;">
								<button type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" onClick="viewData('original');"> <i class="glyphicon glyphicon-file"> </i> <%= lb_original_txt %> </button>
							</div>
							<div class="col-xs-7 col-md-7"> &nbsp; </div>
							<div class="col-xs-2 col-md-2">
								<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
		<script>
			function listDownload(sText){
				if($("#server_code").val() != null){
					view_detail.location = 'file_download_txt_iframe.jsp?server_code='+$("#server_code").val()+'&file_type='+$("#file_type").val()+'&';
					$('#myModalViewDetail').modal('show');
				}else{
					ModalWarning_TextName(sText, '');
					return false;
				}
			}
			
			function viewData(view){
				if(view == 'backup'){
					$('#myModalViewDetail').modal('hide');
					
					setTimeout(function(){
						$('#myModalViewBackup').modal('show');
						setTimeout(function(){
							view_backup.location = 'file_download_txt_iframe_backup.jsp?server_code='+$("#server_code").val()+'&file_type='+$("#file_type").val()+'&';
						}, 150);
					}, 200);
				}else if(view == 'original'){
					$('#myModalViewBackup').modal('hide');
					
					setTimeout(function(){
						$('#myModalViewDetail').modal('show');
						setTimeout(function(){
							view_detail.location = 'file_download_txt_iframe.jsp?server_code='+$("#server_code").val()+'&file_type='+$("#file_type").val()+'&';
						}, 150);
					}, 200);
				}
			}
		</script>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>