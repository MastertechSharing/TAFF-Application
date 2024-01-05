<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "abouttime");
	session.setAttribute("subtitle", "unlock");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
		
	String getaction = "";
	if(request.getParameter("action") != null){
		getaction = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_unlock.jsp?action="+getaction+"&");
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
						"bSort": false,
						"dom": "<fl<t>ip>",	//	<lf<t>ip>
						"paging": false,
						
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
			
			function ModalConfirm(sCode, sText, sText2){ 
				document.getElementById("text_confirm").innerHTML = sText+" "+sText2;
				document.getElementById("sCode").value = sCode;
				
				$('#myModalConfirm').modal('show');
			}
			
			function Confirm_Button(){
				location.href = 'module/act_unlock.jsp?action=clear&day_type='+document.getElementById('sCode').value;
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Clear_Session_Table('<%= clear_session %>', 'DataTables_data_table_<%= request.getRequestURI() %>'); Load_DataTable();">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<%	if(!checkPermission(ses_per, "012")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> setTimeout(function(){ ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); }, 500); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">
			
				<div class="table-responsive" style="border: 0px !important;" border="0">
						
					<div style="min-width: 800px;" class="table" border="0">	
				
						<table style="min-width: 800px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
							<%	if(checkPermission(ses_per, "01")){	%>	
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
							<%	}	%>
									<td width="14%" align="center"> <%= lb_day %> </td>
									<td width="5%" align="center"> MG 1 </td>
									<td width="5%" align="center"> MG 2 </td>
									<td width="14%" align="center"> <%= lb_timezone %> 1 </td>
									<td width="14%" align="center"> <%= lb_timezone %> 2 </td>
									<td width="14%" align="center"> <%= lb_timezone %> 3 </td>
									<td width="14%" align="center"> <%= lb_timezone %> 4 </td>
									<td width="14%" align="center"> <%= lb_timezone %> 5 </td>
								</tr>
							</thead>	
							<tbody>
							<%	
								try{									
									String group1 = "",  group2 = "";
									ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbunlock ORDER BY day_type ASC");
									while(rs.next()){
										String day_type = rs.getString("day_type");
										String time1 = rs.getString("time1");
										String time2 = rs.getString("time2");
										String time3 = rs.getString("time3");
										String time4 = rs.getString("time4");
										String time5 = rs.getString("time5");
										String day_chang = getLongDay(Integer.parseInt(day_type), lang);
										
										if(rs.getString("group1") == null){
											group1 = "";
										}else{
											group1 = rs.getString("group1");
										}
										if( rs.getString("group2") == null){
											group2 = "";
										}else{
											group2 = rs.getString("group2");					
										} 
							%>
								<tr>
							<%	if(checkPermission(ses_per, "01")){	%>			
									<td align="center"> 
										<a href="edit_unlock.jsp?action=edit&day_type=<%= day_type %>"> <img src="images/edit.png" width="18" height="18" border="0" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_editdata %>"> </a>
									</td>
									<td align="center"> 
										<img src="images/refresh.png" width="16" height="16" border="0" align="absmiddle" onClick="ModalConfirm('<%= day_type %>', '<%= msg_confrimClearTimes %>', '<%= day_chang %>');" data-toggle="tooltip" data-placement="right" title="<%= lb_cleartime %>">
									</td>
							<%	}	%>
									<td class="pad-left-10"> <b> <a href="#" onClick="show_detail('<%= day_type %>');" data-toggle="tooltip" data-placement="right" data-html="true" title="<%= lb_viewdata %>"> <%= day_chang %> </a> </b> </td>
									<td align="center">
									<%	if(group1.equals("1")){	%>
										<img src="images/checkbox_ch.png" width="18" height="18" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_mgroup1 %>">
									<%	}else{	%>
										<img src="images/checkbox_un.png" width="18" height="18" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_mgroup1 %>">
									<%	}	%>
									</td>
									<td align="center">
									<%	if(group2.equals("1")){	%>
										<img src="images/checkbox_ch.png" width="18" height="18" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_mgroup2 %>">
									<%	}else{	%>
										<img src="images/checkbox_un.png" width="18" height="18" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_mgroup2 %>">
									<%	}	%>
									</td>
									<td align="center"> <%= changeTime(time1) %> </td>
									<td align="center"> <%= changeTime(time2) %> </td>
									<td align="center"> <%= changeTime(time3) %> </td>
									<td align="center"> <%= changeTime(time4) %> </td>
									<td align="center"> <%= changeTime(time5) %> </td>
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
									<li> <img src="images/refresh.png" width="18" height="18" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_cleartime %> </li>
								</ul>
							</div>
						</div>
					</div>
				</div>			
			</div>
		</div>		
		<%@ include file="tools/modal_viewdetail.jsp"%>		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_confirm" class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; " border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_confirm" class="glyphicon glyphicon-repeat alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: $('#myModalConfirm').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> 
									<input type="hidden" id="sCode" name="sCode" readonly>
									<input type="hidden" id="sCode2" name="sCode2" readonly>
									<input type="hidden" id="sType" name="sType" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="tools/modal_result.jsp"%>

		<%	}	%>
		
		<script>
		function show_detail(day_type){
			view_detail_300px.location = 'view_unlock.jsp?action=view&day_type='+day_type;
			$('#myModalViewDetail300px').modal('show');
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