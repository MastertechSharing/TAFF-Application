<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%	
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "personnel");
	session.setAttribute("subtitle", "getpicture");
	session.setAttribute("action", "cmd_get_picture_report.jsp?");
	
	String countip = "";
	if (session.getAttribute("ipcount") != null) { 
		countip = Integer.toString((Integer)session.getAttribute("ipcount"));
	}
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script type="text/javascript" src="js/ajax_report.js" ></script>

		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
		<link href="css/alert-messages.css" rel="stylesheet" type="text/css">

		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script language="javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px; padding-right: 0px !important; overflow-y: scroll;" onLoad="sendRequest(); ShowCurrentTime(); updateClock();">
		
		<div class="table-responsive" style="border: 0px !important;" border="0">
			<table style="min-width: 550px;" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="100%" align="left" height="20" colspan="5" >
						<span style="font-family:Tahoma; color:Green;"><%= lb_total %>  <%= countip %> <%= lb_matchin %> &nbsp; <%= lb_start_time %> <span id="clock"> </span> <%= lb_min %> <%= lb_to_time %> <span id="lblTime"> </span> <%= lb_min %><span id="load"></span> </span>
					</td>
				</tr>  
			</table>
		
			<form action="#">
				<input name="command" id="command" type="hidden" value="<%= session.getAttribute("command") %>"/>
				<input name="refcode" id="refcode" type="hidden" value="<%= session.getAttribute("refcode") %>" />
				<input name="process_count" id="process_count" type="hidden" value="0" />
				<input name="lang" id="lang" type="hidden" value="<%= lang %>" />
			</form>	
		
			<table style="min-width: 550px; margin-bottom: 0px;" class="table table-hover" align="center" id="table1" border="0">
				<thead>
					<td width="5%" align="center"> <b> <%= lb_no %> </b> </td>
					<td width="20%" align="center"> <b> <%= lb_doorcode %> </b> </td>
					<td width="40%" align="center"> <b> <%= lb_description %> </b> </td>
					<td width="15%" align="center"> <b> <%= lb_result %> </b> </td>
					<td width="5%" align="center"> <b> </b> </td>
					<td width="15%" align="center"> <b> <%= lb_save_topath_photos %> </b> </td>
				</thead>
			</table>
		</div>
		
		<div class="modal fade" id="myModalPicture" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="false" data-keyboard="false">
			<div class="modal-dialog" role="document" style="max-width: 485px;">
				<div class="modal-content">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-top: -10px;"> 
								<iframe id="view_picture" name="view_picture" src="" width="434" height="328" frameborder="0" scrolling="yes"></iframe>
							</div>
							<div class="col-xs-12 col-md-12" style="margin-top: -30px; margin-bottom: 0px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btn_save" onClick="javascript: $('#myModalPicture').modal('hide'); saveFilePopup();" style="width: 100%; margin-left: 10px;"> <%= lb_save_topath_photos %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_close" onClick="javascript: $('#myModalPicture').modal('hide');" style="width: 100%;"> <%= btn_close %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalResult" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="false" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-ok-circle alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p> <%= msg_save_photos_success %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_save" onClick="javascript: $('#myModalResult').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> <input type="hidden" id="datetime_result" name="datetime_result" readonly> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<iframe id="save_picture" name="save_picture" src="" width="0px" height="0px" frameborder="0" scrolling="yes"></iframe>
		
		<script>
			var tmpip = "";
			var tmpdoor_id = "";
			
			function showPicture(ip, door_id){
				tmpip = ip;
				tmpdoor_id = door_id;
				view_picture.location.href = 'cmd_get_picture_save.jsp?ip='+ip+'&door_id='+door_id+'&idcard='+parent.document.getElementById("emp_id").value+'&type_data=view';
				$('#myModalPicture').modal('show');
			}
			
			function saveFile(ip, door_id){
				tmpip = ip;
				tmpdoor_id = door_id;
				save_picture.location.href = 'cmd_get_picture_save.jsp?ip='+ip+'&door_id='+door_id+'&idcard='+parent.document.getElementById("emp_id").value+'&type_data=save';
				
				setTimeout(function(){
					var date = new Date().getTime();
					$('#myModalResult').modal('show');
					document.getElementById("datetime_result").value = date;
					setTimeout(function(){
						if ((!$('#myModalResult').is(':hidden')) && date == document.getElementById("datetime_result").value) {
							$('#myModalResult').modal('hide');
						}
					}, 3000);
				}, 100);
			}
			
			function saveFilePopup(){
				save_picture.location.href = 'cmd_get_picture_save.jsp?ip='+tmpip+'&door_id='+tmpdoor_id+'&idcard='+parent.document.getElementById("emp_id").value+'&type_data=save';
				
				setTimeout(function(){
					var date = new Date().getTime();
					$('#myModalResult').modal('show');
					document.getElementById("datetime_result").value = date;
					setTimeout(function(){
						if ((!$('#myModalResult').is(':hidden')) && date == document.getElementById("datetime_result").value) {
							$('#myModalResult').modal('hide');
						}
					}, 3000);
				}, 500);
			}
		</script>
		
	</body>
	
</html>

<%@ include file="../function/disconnect.jsp"%>