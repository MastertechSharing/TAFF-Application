<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "setting");
	session.setAttribute("subpage", "config");
	session.setAttribute("subtitle", "user");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
	
	String action = "";
	if(request.getParameter("action") != null){
		action = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_user.jsp?action="+action+"&");
	session.setAttribute("act", action);
	
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
		
		<script type="text/javascript">
		function Clear_Session_Table(clear_ses, key){ 
				if(clear_ses == 'true'){
					localStorage.removeItem(key);
				}
			}
		
			function Load_DataTable(){
				$(document).ready(function() {
					$('#data_table').dataTable( {
						"stateSave": true,
						"aoColumnDefs": [
							{ "bSortable": false, "aTargets": [ 0, 1, 2, 8, 9 ] }
						],
						"aaSorting": [
							[ 3, "asc" ]
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
			
			function ModalConfirm(sCode, sType, sText, modal_class, glyphicon_class, color_class, btn_class, permiss, depart,std,exp){
				if(sType == 'clear'){
					document.getElementById("text_confirm").innerHTML = sText+" "+sCode+" ?";
				}else{
					document.getElementById("text_confirm").innerHTML = sText;
				}
				
				if(sType == 'delete'){
					document.getElementById("display_name").style.display = '';
					document.getElementById("text_user").innerHTML = sCode;
					document.getElementById("text_permiss").innerHTML = permiss;
					document.getElementById("text_depart").innerHTML = depart;
					document.getElementById("text_std").innerHTML = std;
					document.getElementById("text_exp").innerHTML = exp;
					document.getElementById("sCode").value = sCode;
				}else{
					document.getElementById("display_name").style.display = 'none';
				}
				
				document.getElementById("sCode").value = sCode;
				document.getElementById("sType").value = sType;
				$('#myModalConfirm').modal('show');
				
				document.getElementById("modal_confirm").classList.remove("alert-message-danger"); 
				document.getElementById("modal_confirm").classList.remove("alert-message-warning"); 
				document.getElementById("modal_confirm").classList.add(modal_class); 
				
				document.getElementById("glyphicon_confirm").classList.remove("glyphicon-trash"); 
				document.getElementById("glyphicon_confirm").classList.remove("alert-message-danger"); 
				document.getElementById("glyphicon_confirm").classList.remove("glyphicon-repeat"); 
				document.getElementById("glyphicon_confirm").classList.remove("alert-message-warning"); 
				document.getElementById("glyphicon_confirm").classList.add(glyphicon_class); 
				document.getElementById("glyphicon_confirm").classList.add(color_class); 
				
				document.getElementById("btn_confirm").classList.remove("btn-danger"); 
				document.getElementById("btn_confirm").classList.remove("btn-warning"); 
				document.getElementById("btn_confirm").classList.add(btn_class); 
			}
			
			function Confirm_Button(){
				if(document.getElementById('sType').value == 'delete'){
					location.href = 'module/act_user.jsp?action=del&user_name='+document.getElementById('sCode').value;
				}else if(document.getElementById('sType').value == 'clear'){
					location.href = 'module/act_user.jsp?action=clear&user_name='+document.getElementById('sCode').value;
				}else if(document.getElementById('sType').value == 'clearall'){
					location.href = 'module/act_user.jsp?action=clearall';
				}
			}
				
			function Add_Data(pageAdd){ 
				location.href = pageAdd;
			}		
		</script>
	</head>
	
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Clear_Session_Table('<%= clear_session %>', 'DataTables_data_table_<%= request.getRequestURI() %>'); Load_DataTable();">

	<%	if(!checkPermission(ses_per, "0")){	%>
	
		<%@ include file="../tools/modal_danger.jsp"%>
		
		<script> setTimeout(function(){ ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); }, 500); </script>
		
	<%	}else{	%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
	
		<div class="body-display">
			<div class="container">			
				<div class="table-responsive" style="border: 0px !important;" border="0">						
					<div style="min-width: 800px;" class="table" border="0">				
						<table style="min-width: 800px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
									<td width="13%" align="center"> <%= lb_username %> </td>
									<td width="13%" align="center"> <%= lb_permission %> </td>
									<td width="23%" align="center"> <%= lb_departcode %> </td>
									<td width="12%" align="center"> <%= lb_group_rights_assign %> </td>
									<td width="10%" align="center"> <%= lb_amount_reader %> </td>
									<td width="11%" align="center"> <%= lb_std %> </td>
									<td width="11%" align="center"> <%= lb_exd %> </td>
								</tr>
							</thead>
							<tbody>
							<% 	
							String sql = "SELECT users.*,";		
								if(lang.equals("th")){				  
									sql += "users.dep_code, dep.th_desc AS depart_desc,";
								}else{
									sql += "users.dep_code, dep.en_desc AS depart_desc,";
								}	
								if(mode == 0){
									sql += "DATE_FORMAT(st_date,'%d/%m/%Y') AS stdate_show,"
											+ "DATE_FORMAT(ex_date,'%d/%m/%Y') AS exdate_show,";
								}else if(mode == 1){
									sql += "CONVERT(varchar(10),users.st_date,103) AS stdate_show,"
										 +"CONVERT(varchar(10),users.ex_date,103) AS exdate_show, ";		
								}								
								sql += "users.user_right, dep.dep_code AS depart_code, users.st_date,"
									 +"users.ex_date FROM dbusers users "
									 +"LEFT OUTER JOIN dbdepart dep ON (dep.dep_code = users.dep_code) "
									 +"WHERE (user_admin != 1)";
							
							try{		
								ResultSet rs = stmtQry.executeQuery(sql);	
								while(rs.next()){	
									String depart_desc = "";									
									String depart_desc_link = "";
									String user_name = rs.getString("user_name");				
									String st_date = rs.getString("stdate_show");
									String ex_date = rs.getString("exdate_show");
									String user_right = rs.getString("user_right");
									user_right = displayUser(user_right);			
									if((rs.getString("dep_code") == (null)) || (rs.getString("dep_code").equals("null"))){
										depart_desc = "&nbsp;";
									}else{
										if(rs.getString("depart_desc") == (null)){
											depart_desc = "";
										}else{
											depart_desc = rs.getString("dep_code")+" : "+rs.getString("depart_desc");
											depart_desc_link = "<b> <span onClick='show_detail2(\""+rs.getString("dep_code")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='left' title='"+lb_viewdata+"'>" + rs.getString("dep_code") + "</span>" + " : </b> " + rs.getString("depart_desc");
										}
									}
				
									String ur = rs.getString("user_right");
									String group_user = "";
									String[] control_reader = new String[0];
									String amount_reader = "";
									if(ur.equals("1") || ur.equals("2") || ur.equals("5") || ur.equals("6")){
										group_user = rs.getString("group_user");
										control_reader = rs.getString("control_reader").split(",");
										
										if(control_reader[0].length() == 0){
											amount_reader = "0";
										}else{
											amount_reader = Integer.toString(control_reader.length);
										}
										if(group_user.equals("")){
											group_user = "-";
											amount_reader = "-";
										}
									}
									
							%>
								<tr>
									<td align="center">
										<a href="edit_user.jsp?action=edit&user_name=<%= user_name %>">
										<img src="images/edit.png" width="18" height="18" border="0" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_editdata %>"> </a>
									</td>							
									<td align="center">
										<img src="images/delete.png" width="20" height="20" border="0" align="absmiddle" onClick="ModalConfirm('<%= user_name %>','delete', '<%= msg_confirmdel %>','alert-message-danger', 'glyphicon-trash','alert-message-danger', 'btn-danger','<%=user_right%>','<%=depart_desc%>','<%=st_date%>','<%=ex_date%>');" data-toggle="tooltip" data-placement="right" title="<%= lb_deletedata %>">
									</td>
									<td align="center">
										<img src="images/refresh.png" width="16" height="16" border="0" align="absmiddle" onClick="ModalConfirm('<%= user_name %>','clear', '<%= msg_confirmClear %>','alert-message-warning', 'glyphicon-repeat','alert-message-warning', 'btn-warning','','','','');" data-toggle="tooltip" data-placement="right" title="<%= lb_clear_pw%>">
									</td>
									<td class="pad-left-10"> <b> <a href="#" onClick="show_detail('<%= user_name %>', '<%= ur %>');" data-toggle="tooltip" data-placement="right" data-html="true" title="<%= lb_viewdata %>"> <%= user_name %> </a> </b> </td>
									<td class="pad-left-10"> <%= user_right %> </td>
									<td class="pad-left-10"> <div class="ellipsis_string" style="width: 95%"> <%= depart_desc_link %> </div> </td>
									<td align="center"> <%= group_user %> </td>
									<td align="center"> <%= amount_reader %> </td>
									<td align="center"> <%= st_date %> </td>
									<td align="center"> <%= ex_date %> </td>
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
							<div class="btn-group dropup">
								<button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<i class="glyphicon glyphicon-info-sign"> </i> &nbsp; <%= lb_information %> &nbsp; 
									<span class="caret"></span>
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<ul class="dropdown-menu" style="width: 200px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
									<li> <img src="images/edit.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_editdata %> <p> </li>
									<li> <img src="images/delete.png" width="22" height="22" align="absmiddle" style="margin-left: 10px"> &nbsp; <%= lb_deletedata %> <p> </li>
									<li> <img src="images/refresh.png" width="18" height="18" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_clear_pw %> </li>
								</ul>
							</div>
						<%	if((ses_per == 0)){	%>
							<button type="button" class="btn btn-primary btn-sm" onClick="Add_Data('edit_user.jsp?action=add&user_right=');"> 
								<i class="glyphicon glyphicon-plus"> </i> &nbsp; <%= lb_adddata %> &nbsp; 
							</button>
							<button type="button" class="btn btn-primary btn-sm" onClick="ModalConfirm('','clearall','<%= msg_confirmclearallaccount %>','alert-message-warning', 'glyphicon-repeat','alert-message-warning', 'btn-warning', '', '', '', '');"> 
								<i class="glyphicon glyphicon-repeat"> </i> &nbsp; <%= lb_clear_pw %> &nbsp; 
							</button>
						<%	}	%>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_detail2" name="view_detail2" frameborder="0" height="100px" style="min-width: 850px;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_confirm" class="modal-content alert-message alert-message-danger">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; " border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_confirm" class="glyphicon glyphicon-trash alert-message-danger" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px; display: none;" id="display_name">
								<strong>
									<div class="alert alert-warning" role="alert" style="min-width: 50px;">
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_username %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_user"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_permission %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_permiss"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_departcode %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_depart"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_std %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_std"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_exd %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_exp"> </p> </div>
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
			function show_detail(user_name, ur){
				if(Number(ur) == 1 || Number(ur) == 2 || Number(ur) == 5 || Number(ur) == 6){
					view_detail_480px.location = 'view_user.jsp?action=view&user_name='+user_name;
					$('#myModalViewDetail480px').modal('show');
				}else{
					view_detail_220px.location = 'view_user.jsp?action=view&user_name='+user_name;
					$('#myModalViewDetail220px').modal('show');
				}
			}
		
			function show_detail2(dep_code){
				view_detail_100px.location = 'view_depart.jsp?action=view&dep_code='+dep_code;
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