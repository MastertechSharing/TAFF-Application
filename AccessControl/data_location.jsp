<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 	
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "aboutsystem");
	session.setAttribute("subtitle", "location");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
		
	String getaction = "";
	if(request.getParameter("action") != null){
		getaction = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_location.jsp?action="+getaction+"&");
	session.setAttribute("act", getaction);	
	
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
		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		<script src="js/alert_box.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script language="javascript">
			function Clear_Session_Table(clear_ses, key){ 
				if(clear_ses == 'true'){
					localStorage.removeItem(key);
				}
			}
		
			function Load_DataTable(){
				$(document).ready(function() {
					$('#data_table').dataTable( {
						"stateSave": true,
					<%	if(checkPermission(ses_per, "0")){	%>	
						"aoColumnDefs": [
							{ "bSortable": false, "aTargets": [ 0, 1 ] }
						],
					<%	}	%>
						"aaSorting": [
					<%	if(checkPermission(ses_per, "0")){	%>	
							[ 2, "asc" ]
					<%	}else{	%>
							[ 0, "asc" ]
					<%	}	%>
						],
						"dom": "<fl<t>ip>",	//	<lf<t>ip>
						
					<%	if(lang.equals("en")){	%>	
						"lengthMenu": [ [ 15, 50, 100, -1 ], [ 15, 50, 100, "All" ] ]
					<%	}else if(lang.equals("th")){	%>	
						"lengthMenu": [ [ 15, 50, 100, -1 ], [ 15, 50, 100, "ทั้งหมด" ] ],
						"oLanguage": {
							"sProcessing":   "กำลังดำเนินการ...",
							"sLengthMenu":   "แสดง _MENU_ รายการ",
							"sZeroRecords":  "ไม่พบข้อมูล",
							"sInfo":         "แสดง _START_ ถึง _END_ จาก _TOTAL_ รายการ",
							"sInfoEmpty":    "แสดง 0 ถึง 0 จาก 0 รายการ",
							"sInfoFiltered": "(กรองข้อมูลทั้งหมด จาก _MAX_ รายการ)",
							"sInfoPostFix":  "",
							"sSearch":       "ค้นหา: ",
							"sUrl":          "",
							"oPaginate": {
								"sFirst":    "หน้าแรก",
								"sPrevious": "ก่อนหน้า",
								"sNext":     "ถัดไป",
								"sLast":     "หน้าสุดท้าย"
							}
						}
					<%	}	%>
					});
					$('.dataTables_filter').addClass('pull-left');
					$('.dataTables_length').addClass('pull-right');
					$('.dataTables_info').addClass('pull-left');
					$('.dataTables_paginate').addClass('pull-right');
					
					$('.data_table_filter, input').addClass('max-height-24');
					$('.dataTables_length, select').addClass('max-height-24');
					$('.dataTables_length, select').addClass('min-width-80');
					$('.dataTables_paginate ul').addClass('pagination-sm');
				});
			}
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
			function ModalConfirm(sCode, sText, th_name, en_name, ip, g_lock, g_unlock, g_alarm){
				document.getElementById("text_confirm").innerHTML = sText;
				document.getElementById("text_code").innerHTML = sCode;
				document.getElementById("text_th_name").innerHTML = th_name;
				document.getElementById("text_en_name").innerHTML = en_name;
				document.getElementById("text_server_ip").innerHTML = ip;
				document.getElementById("text_group_lock").innerHTML = g_lock;
				document.getElementById("text_group_unlock").innerHTML = g_unlock;
				document.getElementById("text_group_alarm").innerHTML = g_alarm;
				document.getElementById("sCode").value = sCode;
				
				$('#myModalConfirm').modal('show');
			}
						
			function Confirm_Button(){
				location.href = 'module/act_location.jsp?action=del&locate_code='+document.getElementById('sCode').value;
			}
			
			function Add_Data(pageAdd){ 
				location.href = pageAdd;
			}
		</script>	
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Clear_Session_Table('<%= clear_session %>', 'DataTables_data_table_<%= request.getRequestURI() %>'); Load_DataTable();">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<%	if(!checkPermission(ses_per, "0")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> setTimeout(function(){ ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); }, 500); </script>
		
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">
			
				<div class="table-responsive" style="border: 0px !important;" border="0">
						
					<div style="min-width: 800px;" class="table" border="0">	
				
						<table style="min-width: 1000px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
							<%	if(checkPermission(ses_per, "0")){	%>	
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
							<%	}	%>
									<td width="12%" align="center" ><%= lb_locatecode %></td>
									<td width="20%" align="center" ><%= lb_thdesc %></td>
									<td width="20%" align="center" ><%= lb_endesc %></td>
									<td width="15%" align="center" ><%= lb_hostip %></td>
									<td width="9%" align="center" ><%= lb_group_lock %></td>
									<td width="9%" align="center" ><%= lb_group_unlock %></td>
									<td width="9%" align="center" ><%= lb_group_alarm %></td>
								</tr>
							</thead>
							<tbody>
							<%	
								try{
									String sql = " SELECT locate.*, serve.server_ip FROM dblocation locate "
											+ " LEFT OUTER JOIN dbserver_config serve ON locate.server_code = serve.server_code "
											+ " ORDER BY locate_code ASC "; 
									ResultSet rs = stmtQry.executeQuery(sql);
									while(rs.next()){
										String locate_code = rs.getString("locate_code");
										String server_code = rs.getString("server_code");
										String server_ip = "";
										if(rs.getString("server_ip") != null){
											server_ip = " - " + rs.getString("server_ip");
										}
							%>
								<tr>
							<%	if(checkPermission(ses_per, "0")){	%>			
									<td align="center"> 
										<a href="edit_location.jsp?action=edit&locate_code=<%= locate_code %>"> <img src="images/edit.png" width="18" height="18" border="0" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_editdata %>"> </a>
									</td>
									<td align="center"> 
										<img src="images/delete.png" width="20" height="20" border="0" align="absmiddle" onClick="ModalConfirm('<%= locate_code %>', '<%= msg_confirmdel %>', '<%= rs.getString("th_desc") %>', '<%= rs.getString("en_desc") %>', '<%= server_code %> <%= server_ip %>', '<%= rs.getString("group_lock") %>', '<%= rs.getString("group_unlock") %>', '<%= rs.getString("group_alarm") %>');" data-toggle="tooltip" data-placement="right" title="<%= lb_deletedata %>">
									</td>
							<%	}	%>
									<td align="center"> <b> <a href="#" onClick="show_detail('<%= locate_code %>');" data-toggle="tooltip" data-placement="right" data-html="true" title="<%= lb_viewdata %>"> <%= locate_code %> </a> </b> </td>
									<td class="pad-left-10"> <div class="ellipsis_string" style="width: 200px"> <%= rs.getString("th_desc") %> </div> </td>
									<td class="pad-left-10"> <div class="ellipsis_string" style="width: 200px"> <%= rs.getString("en_desc") %> </div> </td>
									<td class="pad-left-10"> <b> <a href="#" onClick="show_detail2('<%= server_code %>');" data-toggle="tooltip" data-placement="right" data-html="true" title="<%= lb_viewdata %>"> <%= server_code %> </a> </b> <%= server_ip %> </td>
									<td align="center"> <%= rs.getString("group_lock") %> </td>
									<td align="center"> <%= rs.getString("group_unlock") %> </td>
									<td align="center"> <%= rs.getString("group_alarm") %> </td>
								</tr>
							<%	
									}
									rs.close();
								}catch(SQLException e){		
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
								}
							%>
							</tbody>
						</table>
					</div>
					
					<div class="col-xs-12" align="left" style="margin-left: -15px; min-width: 500px;">
						<div class="btn-group">						
							<%@ include file="tools/toggle_dropdown.jsp"%>
							<%	if(checkPermission(ses_per, "0")){	%>	
							<button type="button" class="btn btn-primary btn-sm" onClick="Add_Data('edit_location.jsp?action=add');"> 
								<i class="glyphicon glyphicon-plus"> </i> &nbsp; <%= lb_adddata %> &nbsp; 
							</button>
							<%	}	%>
						</div>
					</div>
				</div>			
			</div>
		</div>

		<%@ include file="tools/modal_viewdetail.jsp"%>
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_confirm" class="modal-content alert-message alert-message-danger">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; " border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_confirm" class="glyphicon glyphicon-trash alert-message-danger" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;">
								<strong>
									<div class="alert alert-warning" role="alert" style="min-width: 50px;">
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_locatecode %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_code"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_thdesc %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_th_name"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_endesc %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_en_name"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_hostip %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_server_ip"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_group_lock %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_group_lock"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_group_unlock %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_group_unlock"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_group_alarm %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_group_alarm"> </p> </div>
										</div>
									</div>
								</strong>
							</div>
							<%@ include file="tools/modal_confirm.jsp"%>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="tools/modal_result.jsp"%>

		<%	}	%>
		
		<script>
		function show_detail(locate_code){
			view_detail_260px.location = 'view_location.jsp?action=view&locate_code='+locate_code;
			$('#myModalViewDetail260px').modal('show');
		}	
		
		function show_detail2(server_code){
			view_detail_100px.location = 'view_server.jsp?action=view&server_code='+server_code;
			$('#myModalViewDetail100px').modal('show');
		}	
		
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				$('body').addClass('loaded');
				
				<%	if(!text_result.equals("")){	%>
				setTimeout(function(){
					$('#myModalResult').modal('show');
					setTimeout(function(){
						$('#myModalResult').modal('hide');
					}, 3000);
				}, 500);
				<%	}	%>
			}
		}
		</script>
		
		<script src="js/dropdown-menu.animated.js"></script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>