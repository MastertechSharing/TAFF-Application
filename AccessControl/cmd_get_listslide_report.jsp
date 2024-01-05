<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%	
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "multimedia");
	session.setAttribute("subtitle", "getlistslide");
	session.setAttribute("action", "cmd_get_listslide_report.jsp?");
	
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

		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script language="javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px;" onLoad="sendRequest(); ShowCurrentTime(); updateClock();">
		
		<div class="table-responsive" style="border: 0px !important; margin-bottom: -55px;" border="0">
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
					<td width="60%" align="center"> <b> <%= lb_description %> </b> </td>
					<td width="15%" align="center"> <b> <%= lb_result %> </b> </td>
				</thead>
			</table>
		</div>
		
		<div class="modal fade" id="myModalList" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="false" data-keyboard="false">
			<div class="modal-dialog" role="document" style="min-width: 485px; margin-top: 10px; margin-bottom: -35px;">
				<div class="modal-content">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-top: -10px;"> 
								<iframe id="show_listslide" name="show_listslide" src="" width="545px" height="335px" frameborder="0" scrolling="yes"></iframe>
							</div>
							<div class="col-xs-12 col-md-12" style="margin-top: 10px; margin-bottom: 0px;"> 
								<div class="col-xs-9 col-md-9"> </div>
								<div class="col-xs-3 col-md-3"> 
									<button type="button" class="btn btn-default btn-xs button-shadow1 button-shadow2" id="btn_close" onClick="javascript: $('#myModalList').modal('hide');" style="width: 100%;"> <%= btn_close %> </button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script>
			var tmpip = "";
			var tmpdoor_id = "";
			
			function showList(ip, door_id){
				tmpip = ip;
				tmpdoor_id = door_id;
				show_listslide.location.href = 'cmd_get_listslide_report_data.jsp?ip='+ip+'&door_id='+door_id;
				$('#myModalList').modal('show');
			}
		</script>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>