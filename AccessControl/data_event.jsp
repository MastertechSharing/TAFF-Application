<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage","aboutsystem");		
	session.setAttribute("subtitle", "event");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
		
	String getaction = "";
	if(request.getParameter("action") != null){
		getaction = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_event.jsp?action="+getaction+"&");
	session.setAttribute("act", getaction);	
	
	// show modal alert success
	String text_result = "", type_alert = "success", type_glyphicon = "ok-circle", set_timeout = "3000";
	if(session.getAttribute("session_alert") != null){
		text_result = (String)session.getAttribute("session_alert");
		session.setAttribute("session_alert", null);
		if(session.getAttribute("set_timeout") != null){
			set_timeout = "10000";
			session.setAttribute("set_timeout", null);
		}		
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
						"aoColumnDefs": [
					<%	if(checkPermission(ses_per, "0")){	%>	
							{ "bSortable": false, "aTargets": [ 0, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ] }
					<%	}else{	%>
							{ "bSortable": false, "aTargets": [ 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ] }
					<%	}	%>
						],
						"aaSorting": [
					<%	if(checkPermission(ses_per, "0")){	%>	
							[ 1, "asc" ]
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
			
			function ModalConfirm(sText, act){ 
				document.getElementById("text_confirm").innerHTML = sText;
				document.getElementById("sType").value = act;
				
				if(act == 'update_access'){		
					document.getElementById("type_update").innerHTML = "Access Default";
				}else if(act == 'update_ta'){		
					document.getElementById("type_update").innerHTML = "TA Default";
				}else if(act == 'update_acta'){		
					document.getElementById("type_update").innerHTML = "Access For TA";
				}
				
				$('#myModalConfirm').modal('show');
			}
			
			function Confirm_Button(){
				var sType = document.getElementById('sType').value;
				if(sType == 'update_access'){		
					location.href = 'module/act_event.jsp?action='+sType;			
				}else if(sType == 'update_ta'){		
					location.href = 'module/act_event.jsp?action='+sType;		
				}else if(sType == 'update_acta'){		
					location.href = 'module/act_event.jsp?action='+sType;		
				}
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
						
					<div style="min-width: 1080px;" class="table" border="0">	
				
						<table style="min-width: 1080px; max-width: 1140px !important;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
							<%	if(checkPermission(ses_per, "0")){	%>	
									<td width="3%" align="center"> </td>
							<%	}	%>
									<td width="10%" align="center"> <%= lb_eventcode %> </td>
									<td width="22%" align="center"> <%= lb_thdesc %> </td>
									<td width="20%" align="center"> <%= lb_endesc %> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="UnLock"> HW 1 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="Alarm"> HW 2 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="Bell"> HW 3 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="OUT4"> HW 4 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="Write Transaction"> HW 5 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="All Lock"> HW 6 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="All UnLock"> HW 7 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="All Alarm"> HW 8 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="Capture"> HW 9 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="Write Transaction"> SW 6 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="Send TCP/IP Socket"> SW 7 </div> </td>
									<td width="4%" align="center"> <div data-toggle="tooltip" data-placement="left" title="Send API 3rd Party"> SW 8 </div> </td>
								</tr>
							</thead>
							<tbody>
							<%	
								try{
									ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbevent ORDER BY event_code ASC ");
									while(rs.next()){
										String event_code = rs.getString("event_code");
										String event_act = rs.getString("event_act");
										String softw_act = rs.getString("software_act");
							%>
								<tr>
							<%	if(checkPermission(ses_per, "0")){	%>			
									<td align="center"> 
										<a href="edit_event.jsp?action=edit&event_code=<%= event_code %>"> <img src="images/edit.png" width="18" height="18" border="0" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_editdata %>"> </a>
									</td>
							<%	}	%>
									<td align="center"> <b> <a href="#" onClick="show_detail('<%= event_code %>');" data-toggle="tooltip" data-placement="right" data-html="true" title="<%= lb_viewdata %>"> <%= event_code %> </a> </b> </td>
									<td class="pad-left-10"> <div class="ellipsis_string" style="width: 95%"> <%= rs.getString("th_desc") %> </div> </td>
									<td class="pad-left-10"> <div class="ellipsis_string" style="width: 95%"> <%= rs.getString("en_desc") %> </div> </td>
									<td align="center"> <%= checkImgAtPos(event_act, 0) %> </td>
									<td align="center"> <%= checkImgAtPos(event_act, 1) %> </td>
									<td align="center"> <%= checkImgAtPos(event_act, 2) %> </td>
									<td align="center"> <%= checkImgAtPos(event_act, 3) %> </td>
									<td align="center"> <%= checkImgAtPos(event_act, 4) %> </td>
									<td align="center"> <%= checkImgAtPos(event_act, 5) %> </td>
									<td align="center"> <%= checkImgAtPos(event_act, 6) %> </td>
									<td align="center"> <%= checkImgAtPos(event_act, 7) %> </td>
									<td align="center"> <%= checkImgAtPos(event_act, 8) %> </td>
									<td align="center"> <%= checkImgAtPos(softw_act, 5) %> </td>
									<td align="center"> <%= checkImgAtPos(softw_act, 6) %> </td>
									<td align="center"> <%= checkImgAtPos(softw_act, 7) %> </td>
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
					
					<div class="col-xs-12" align="left" style="margin-left: -15px; min-width: 800px;">
						<div class="btn-group">
						
							<div class="btn-group dropup">
								<button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<i class="glyphicon glyphicon-info-sign"> </i> &nbsp; <%= lb_information %> &nbsp; 
									<span class="caret"></span>
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<ul class="dropdown-menu" style="width: 200px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
									<li> <img src="images/edit.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_editdata %> </li>
								</ul>
							</div>
							<%	if(checkPermission(ses_per, "0")){	%>	
							<button type="button" class="btn btn-primary btn-sm" onClick="ModalConfirm('<%= msg_confirmedit %>', 'update_access');"> 
								<i class="glyphicon glyphicon-floppy-open"> </i> &nbsp; Access Default &nbsp; 
							</button>	
							<button type="button" class="btn btn-primary btn-sm" onClick="ModalConfirm('<%= msg_confirmedit %>', 'update_ta');"> 
								<i class="glyphicon glyphicon-floppy-open"> </i> &nbsp; TA  Default &nbsp; 
							</button>	
							<button type="button" class="btn btn-primary btn-sm" onClick="ModalConfirm('<%= msg_confirmedit %>', 'update_acta');"> 
								<i class="glyphicon glyphicon-floppy-open"> </i> &nbsp; Access For TA &nbsp; 
							</button>
							<%	}	%>
						</div>
					</div>
					
				</div>
				
				<div class="table-responsive" style="border: 0px !important;" border="0">
					<div style="min-width: 1080px; margin-top: 10px;">
						<label class="control-label col-md-12" style="font-family:Tahoma;font-size: 10px;font-style: normal;color: #FF0000;"> ** <%= lb_comment %> : HW1=UnLock, HW2=Alarm, HW3=Bell, HW4=OUT4, HW5=Write Transaction, HW6=All Lock, HW7=All UnLock, HW8=All Alarm, HW9=Capture, SW6=Write Transaction, SW7=Send TCP/IP Socket, SW8=Send API 3rd Party </label>
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
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_confirm" class="glyphicon glyphicon-floppy-open alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;">
								<strong>
									<div class="alert alert-warning" role="alert" style="min-width: 50px;">
										<div class="row">
											<div class="col-xs-12 col-md-12" align="center"> <p id="type_update"> </p> </div>
										</div>
									</div>
								</strong>
							</div>
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
		function show_detail(event_code){
			view_detail.location = 'view_event.jsp?action=view&event_code='+event_code;
			$('#myModalViewDetail').modal('show');
		}
		
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				$('body').addClass('loaded');				
			}
			
			<%	if(!text_result.equals("")){	%>
					setTimeout(function(){
						$('#myModalResult').modal('show');
						setTimeout(function(){
							$('#myModalResult').modal('hide');
						}, <%= set_timeout %>);
					}, 500);
			<%	}	%>
		}
		</script>
		
		<script src="js/dropdown-menu.animated.js"></script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>