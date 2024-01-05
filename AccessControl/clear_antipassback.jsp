<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.util.Vector" %>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "special"); 
	session.setAttribute("subpage", "others");
	session.setAttribute("subtitle", "clear_antipassback");	
	session.setAttribute("action", "clear_antipassback.jsp?");
	String text_result = "", type_alert = "success", type_glyphicon = "ok-circle";
	
	String action = "";
	if(request.getParameter("action") != null){
		action = request.getParameter("action");
	}
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script language="javascript" src="js/check_key.js"></script>
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/alert_box.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/alert_box.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style type="text/css">
			body {
				overflow-y:hidden;
			}
		</style>
		
		<script type="text/javascript">
		//	document.onkeydown = searchKeyPress_tool;
			
			function checkText(){
				if($('#idcard').val().length != 0){
					$('#btn_clear').removeAttr('disabled');
					$('#btn_clearall').removeAttr('disabled');
				}else{
					$('#btn_clear').attr('disabled', 'disabled');
					$('#btn_clearall').attr('disabled', 'disabled');
				}
			}
		</script>
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

	<%	if(!checkPermission(ses_per, "0135")){	%>
	
		<%@ include file="../tools/modal_danger.jsp"%>
		
		<script> setTimeout(function(){ ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); }, 500); </script>
		
	<%	}else{	%>
		
	<%	if(action.equals("clear")){
			
			String idcard = request.getParameter("idcard");
			
			if ((idcard != null) && (!idcard.trim().equals(""))) {
			
				Vector<Integer> vecIndex = new Vector<Integer>();
				int level_no = 0;
				
				String current_level = request.getParameter("current_level");
				String current_io = request.getParameter("current_io");
				String current_rd = request.getParameter("current_rd");
				String group_rd = request.getParameter("group_rd");
				
				String reader_no = "", status_io = "", new_level = current_level;
				String sql = " SELECT rd.reader_no, rd.level_no, rd.status_io, rd.clear_l1, rd.clear_l2, rd.clear_l3, rd.clear_l4, rd.clear_l5, d.group_door  "
						+ " FROM dbreader rd "
						+ " LEFT OUTER JOIN dbdoor d ON rd.door_id = d.door_id "
						+ " WHERE d.group_door = '"+group_rd+"' AND rd.level_no != '0' AND (rd.status_io != '"+current_io+"' AND rd.status_io != '') ";
				ResultSet rs = stmtQry.executeQuery(sql);
				while (rs.next()) {
					reader_no = rs.getString("rd.reader_no");
					level_no = Integer.parseInt(rs.getString("rd.level_no"));
					status_io = rs.getString("rd.status_io");
					group_rd = rs.getString("d.group_door");
					if ((level_no >= 1) && (level_no <= 5)) {
						if (rs.getString("rd.clear_l1").equals("1")) {
							vecIndex.add(1);
						}
						if (rs.getString("rd.clear_l2").equals("1")) {
							vecIndex.add(2);
						}
						if (rs.getString("rd.clear_l3").equals("1")) {
							vecIndex.add(3);
						}
						if (rs.getString("rd.clear_l4").equals("1")) {
							vecIndex.add(4);
						}
						if (rs.getString("rd.clear_l5").equals("1")) {
							vecIndex.add(5);
						}
					}
					
					new_level = Integer.toString(level_no);
					if(current_level.equals(new_level)){
						break;
					}
					
				}	rs.close();
			
				if (vecIndex.size() > 0) {
					new_level = Integer.toString(vecIndex.get(0));
				}
			
				try {
					sql = " UPDATE dbemployee SET current_rd = '" + reader_no + "', current_level = '" + new_level + "', "
						+ " current_io = '" + status_io + "', group_rd = '" + group_rd + "' "
						+ " WHERE idcard = '" + idcard.trim() + "' ";
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						rc.WriteDataLogFile("[" + ses_user + "] Clear Anti-Passback [1 Level] idcard : " + idcard.trim() + " at "
								+ " current_rd : " + current_rd + " to reader_no : " + reader_no + " and "
								+ " current_io : " + current_io + " to current_io : " + status_io + " [dbemployee]");
						out.println("<script> "
							+ " parent.window.$('#myModalWarningClear1Level').modal('hide'); "
							+ " parent.window.$('#myModalResultClear').modal('show'); "
							+ " setTimeout(function(){ "
							+ " 	parent.window.$('#myModalResultClear').modal('hide'); "
							+ " }, 3500); "
							+ " parent.window.cancelButton() "
							+ " </script>");
					}else{
						//
					}
				} catch (Exception e) {
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
			}else{
				//
			}
		
		}else if(action.equals("clearall")){
			
			String idcard = request.getParameter("idcard");
			
			if ((idcard != null) && (!idcard.trim().equals(""))) {
					
				try {
					String sql = " UPDATE dbemployee SET current_rd = '', current_level = '0', "
						+ " current_io = 'O', group_rd = '' "
						+ " WHERE idcard = '" + idcard.trim() + "' ";
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						rc.WriteDataLogFile("[" + ses_user + "] Clear Anti-Passback [All] idcard : " + idcard.trim() + " [dbemployee]");
						out.println("<script> "
							+ " parent.window.$('#myModalWarningClearAll').modal('hide'); "
							+ " parent.window.$('#myModalResultClear').modal('show'); "
							+ " setTimeout(function(){ "
							+ " 	parent.window.$('#myModalResultClear').modal('hide'); "
							+ " }, 3500); "
							+ " parent.window.cancelButton() "
							+ " </script>");
					}else{
						//
					}
				} catch (Exception e) {
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
			}else{
				//
			}
			
		}else if(action.equals("findemp")){
			
			if ((request.getParameter("idcard") != null) && (!request.getParameter("idcard").trim().equals(""))) {
				
				String idcard = request.getParameter("idcard");
				String fullname = "", sec_desc = "", reader_no = "", reader_name = "";								
				String current_level = "", current_io = "", current_rd = "", group_rd = "";
				
				String sql = "SELECT emp.idcard, current_level, current_io, current_rd, group_rd, "
						+ " emp."+lang+"_fname AS fname, emp."+lang+"_sname AS sname, rd."+lang+"_desc AS reader_name "
						+ " FROM dbemployee emp "
						+ " LEFT OUTER JOIN dbreader rd ON (emp.current_rd = rd.reader_no) "
						+ " LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) ";
				if(checkPermission(ses_per, "1256")){
					sql += " LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
						+ " LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
				}
				
				sql += " WHERE emp.idcard = '"+idcard+"' ";
				if(checkPermission(ses_per, "1256")){
					sql += " AND (users.user_name = '"+ses_user+"') ";
					if(checkPermission(ses_per, "56")){
						sql += " AND (sec.sec_code = users.sec_code) ";
					}
				}						
				sql += " ORDER BY emp.idcard ASC ";
				
				ResultSet rs = stmtUp.executeQuery(sql);
				if(rs.next()){
					idcard = rs.getString("emp.idcard");																		
					fullname = rs.getString("fname")+"  "+rs.getString("sname");
					
					reader_no = rs.getString("emp.current_rd");
					if(rs.getString("reader_name") != null){
						reader_name += rs.getString("reader_name");
					}else{
						reader_name += "";
					}
					
					current_level = rs.getString("emp.current_level");
					current_io = rs.getString("emp.current_io");
					current_rd = rs.getString("emp.current_rd");
					group_rd = rs.getString("emp.group_rd");
					
				}	rs.close();
				
				if(!current_level.equals("0")){
					if(!current_rd.equals("")){
						out.println("<script> "
								+ " parent.window.document.getElementById('idcard').value = '"+idcard+"'; " 
								+ " parent.window.document.getElementById('fullname').value = '"+fullname+"'; "
								+ " parent.window.document.getElementById('reader_no').value = '"+reader_no+"'; "
								+ " parent.window.document.getElementById('reader_name').value = '"+reader_name+"'; "
								+ " parent.window.document.getElementById('io').value = '"+current_io+"'; "
								+ " parent.window.document.getElementById('current_level').value = '"+current_level+"'; "
								+ " parent.window.document.getElementById('current_io').value = '"+current_io+"'; "
								+ " parent.window.document.getElementById('current_rd').value = '"+current_rd+"'; "
								+ " parent.window.document.getElementById('group_rd').value = '"+group_rd+"'; "
								+ " $('#btn_clear').removeAttr('disabled'); "
								+ " $('#btn_clearall').removeAttr('disabled'); "
								+ "</script>");
					}else{
						out.println("<script> "
								+ " parent.window.top.cancelButton2(); "
								+ " parent.window.document.getElementById('idcard').value = '"+idcard+"'; " 
								+ " parent.window.document.getElementById('fullname').value = '"+fullname+"'; "
								+ " parent.window.top.$('#btn_clear').attr('disabled', 'disabled'); "
								+ " parent.window.top.$('#btn_clearall').attr('disabled', 'disabled'); "
								+ "</script>");
					}
				}else{
					out.println("<script> "
							+ " parent.window.top.cancelButton2(); "
							+ " parent.window.document.getElementById('idcard').value = '"+idcard+"'; " 
							+ " parent.window.document.getElementById('fullname').value = '"+fullname+"'; "
							+ " parent.window.top.$('#btn_clear').attr('disabled', 'disabled'); "
							+ " parent.window.top.$('#btn_clearall').attr('disabled', 'disabled'); "
							+ " parent.window.$('#text_warning').html('"+msg_no_antipassback+"'); "
							+ " parent.window.$('#myModalWarning').modal('show'); "
							+ "</script>");
				}
			}
		
		}else{
	
	%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container" style="margin-top: 15px;">
			
				<div class="col-md-1"> </div>
				<div class="col-md-10">
					<div class="panel panel-primary"> 
						<div class="panel-heading">
							<h3 class="panel-title"> <b> <%= lb_clear_antipassback %> </b> </h3> 
						</div> 
						<div class="panel-body">
						<form id="form_clear" name="form_clear" method="post">
			
							<div class="table-responsive" style="border: 0px !important;" border="0">
								<div style="min-width: 500px; max-width: 100%; margin-left: 15px; margin-right: 15px; margin-bottom: 15px;" border="0">
									<div class="row" style="margin-top: 15px; margin-bottom: -15px;">
										<label class="col-ls-2 col-md-2" style="margin-top: 6px;"> <div align="right"> <b> <%= lb_empcode %> : </b> </div> </label>
										<div class="col-ls-3 col-md-3"> 
											<input type="text" class="form-control" id="idcard" name="idcard" maxlength="16" style="min-height: 32px !important; text-transform: uppercase;" onKeyPress="IsValidCharacters();" onBlur="checkText(); findEmployee();">
										</div>
										<div class="col-ls-1 col-md-1">
											<img  src="images/view.png" width="28" height="28" border="0" align="absmiddle" onClick="show_detail();" data-toggle="tooltip" data-placement="right" title="<%= lb_search %>"/>
										</div>
										<label class="col-ls-2 col-md-2" style="margin-top: 6px; min-width: 155px;"> <div align="right"> <b> <%= lb_names %> : </b> </div> </label>
										<div class="col-ls-3 col-md-3">
											<input type="text" class="form-control" id="fullname" name="fullname" style="min-height: 32px !important; background-color:#F0F0F0" readonly="readonly"/>										
										</div>
										<div class="col-ls-1 col-md-1"> &nbsp; </div> 
									</div>
									<div class="row" style="margin-top: 15px; margin-bottom: -15px;">
										<label class="col-ls-2 col-md-2" style="margin-top: 6px;"> <div align="right"> <b> <%= lb_readers %> : </b> </div> </label>
										<div class="col-ls-3 col-md-3"> 
											<input type="text" class="form-control" id="reader_no" name="reader_no" maxlength="5" style="min-height: 32px !important;" onKeyPress="IsValidNumber()" readonly="readonly"/>
										</div>
										<div class="col-ls-1 col-md-1"> &nbsp; </div> 
										<label class="col-ls-2 col-md-2" style="margin-top: 6px; min-width: 155px;"> <div align="right"> <b> <%= lb_reader_name %> : </b> </div> </label>
										<div class="col-ls-3 col-md-3">
											<input type="text" class="form-control" id="reader_name" name="reader_name" style="min-height: 32px !important; background-color:#F0F0F0" readonly="readonly"/>	
										</div>
										<div class="col-ls-1 col-md-1"> &nbsp; </div> 
									</div>
									<div class="row" style="margin-top: 15px;">
										<label class="col-ls-2 col-md-2" style="margin-top: 6px;"> <div align="right"> <b> <%= lb_status_io2 %> : </b> </div> </label>
										<div class="col-ls-3 col-md-3"> 
											<input type="text" class="form-control" id="io" name="io" maxlength="1" style="min-height: 32px !important;" readonly="readonly"/>
										</div>
										<div class="col-ls-1 col-md-1"> &nbsp; </div> 
										<div class="col-ls-1 col-md-6"> &nbsp; </div> 
									</div>
									<div class="row" style="margin-top: 25px; margin-bottom: 0px;">
										<div class="col-ls-3 col-md-3"> 
											<input type="hidden" class="form-control" id="current_level" name="current_level" readonly />
											<input type="hidden" class="form-control" id="current_io" name="current_io" readonly />
											<input type="hidden" class="form-control" id="current_rd" name="current_rd" readonly />
											<input type="hidden" class="form-control" id="group_rd" name="group_rd" readonly />
										</div>
										<div class="col-ls-6 col-md-6" style="text-align: center;"> 
											<button type="button" name="btn_clear" id="btn_clear" class="btn btn-primary btn-sm button-shadow1 button-shadow2" onclick="javascript: $('#myModalWarningClear1Level').modal('show');" disabled> &nbsp; &nbsp; &nbsp; <%= lb_clear_antipassback_lv %> &nbsp; &nbsp; &nbsp; </button> &nbsp; 
											<button type="button" name="btn_clearall" id="btn_clearall" class="btn btn-primary btn-sm button-shadow1 button-shadow2" onclick="javascript: $('#myModalWarningClearAll').modal('show');" disabled> &nbsp; &nbsp; &nbsp; <%= lb_clear_antipassback_all %> &nbsp; &nbsp; &nbsp; </button> &nbsp; 
											<button type="button" name="btn_cancel" id="btn_cancel" class="btn btn-primary btn-sm button-shadow1 button-shadow2" onclick="cancelButton();"> &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; </button>
										</div>
										<div class="col-ls-3 col-md-3"> &nbsp; </div>
									</div>
								</div>
							</div>
						
						</form>
						</div> 
					</div>
				</div>
				<div class="col-md-1"> </div>
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
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_warning" onClick="javascript: $('#myModalWarning').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalWarningClear1Level" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_warning" class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_warning" class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_warning_clear1level"> <%= msg_clear_antipassback_lv %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_warning" onClick="clearButton();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: $('#myModalWarningClear1Level').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalWarningClearAll" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_warning" class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_warning" class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_warning_clearall"> <%= msg_clear_antipassback_all %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_warning" onClick="clearAllButton();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: $('#myModalWarningClearAll').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="myModalResultClear" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-ok-circle alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p> <%= lb_clear_anti_success %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="javascript: $('#myModalResultClear').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> 
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<iframe src="" id="iframe_clear" name="iframe_clear" frameborder="0" height="0px" width="0px"> </iframe>
		
		<%@ include file="../tools/modal_viewdetail.jsp"%>	
		
		<script>
			function show_detail(){
				view_detail.location = 'iframe_employee_clear_antipassback.jsp';
				$('#myModalViewDetail').modal('show');
			}
			
			function clearButton(){
				$('#form_clear').attr('action', 'clear_antipassback.jsp?action=clear&idcard='+$('#idcard').val()+'&current_level='+$('#current_level').val()+'&current_io='+$('#current_io').val()+'&current_rd='+$('#current_rd').val()+'&group_rd='+$('#group_rd').val());
				$('#form_clear').attr('target', 'iframe_clear');
				$('#form_clear').submit();
				
				$('#myModalWarning').modal('hide');
			}
			
			function clearAllButton(){
				$('#form_clear').attr('action', 'clear_antipassback.jsp?action=clearall&idcard='+$('#idcard').val());
				$('#form_clear').attr('target', 'iframe_clear');
				$('#form_clear').submit();
				
				$('#myModalWarning').modal('hide');
			}
			
			function cancelButton(){
				$('#idcard').val('');			$('#fullname').val('');
				$('#reader_no').val('');		$('#reader_name').val('');		$('#io').val('');
				$('#current_level').val('');
				$('#current_io').val('');
				$('#current_rd').val('');
				$('#group_rd').val('');
				checkText();
			}
			
			function cancelButton2(){
				$('#reader_no').val('');		$('#reader_name').val('');		$('#io').val('');
				$('#current_level').val('');
				$('#current_io').val('');
				$('#current_rd').val('');
				$('#group_rd').val('');
			}
			
			function findEmployee(){
				$('#form_clear').attr('action', 'clear_antipassback.jsp?action=findemp&idcard='+$('#idcard').val());
				$('#form_clear').attr('target', 'iframe_clear');
				$('#form_clear').submit();
			}
			
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
					$('#iframe_clear').contents().find('html').html(''); 
				}
			}
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
	
	<%	}	%>
	
	<%	}	%>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>