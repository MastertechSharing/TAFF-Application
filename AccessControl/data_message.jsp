<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "personnel");
	session.setAttribute("subtitle", "message");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
	
	String getaction = "";
	if(request.getParameter("action") != null){
		getaction = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_message.jsp?action="+getaction+"&");
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
		
		<style>
			.bottom-0 {
				margin-bottom: 0px !important;
			}
			.bottom-100 {
				margin-bottom: -100px !important;
			}
		</style>
		
		<script>
			function Clear_Session_Table(clear_ses, key){ 
				if(clear_ses == 'true'){
					localStorage.removeItem(key);
				}
			}
		
			function Load_DataTable(data){
				$(document).ready(function() {
					$('#data_table').dataTable( {
						"stateSave": true,
					
						"bServerSide": true,
						"bProcessing": true,
						"sAjaxSource": "data_message_server_side.jsp",
						"drawCallback": function( settings ) {
							document.getElementById("caretinfo").style.WebkitTransform = "none";
							var api = new $.fn.dataTable.Api( settings );
							if( api.rows().data()[0] !== undefined ){
								if( api.rows().data()[0][0] == ' '){
									window.location.href = 'login.jsp';
								}
								if( api.rows().data()[1] === undefined ){
									document.getElementById("caretinfo").style.WebkitTransform = "rotate(180deg)";
								}
							}else{
								document.getElementById("caretinfo").style.WebkitTransform = "rotate(180deg)";
							}
						},
						
						"aoColumnDefs": [
					<%	if(checkPermission(ses_per, "0135")){	%>	
							{ "bSortable": false, "aTargets": [ 0, 1 ] }
					<%	}else{	%>
							//	{ "bSortable": false, "aTargets": [ ] }	
					<%	}	%>
						],
						"aaSorting": [
					<%	if(checkPermission(ses_per, "0135")){	%>	
							[ 6, "desc" ]
					<%	}else{	%>
							[ 4, "desc" ]
					<%	}	%>
						],
						"dom": "<fl<t>ip>",	//	<lf<t>ip>
						
						"aLengthMenu": [ [ 15, 50, 100, 1000 ], [ 15, 50, 100, 1000 ] ],
					<%	if(lang.equals("th")){	%>
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
			
			function setClassInfo(){
				var position = $("#btninfo").offset();
				if(Number(position.top) < 230){
					$("#liinfo").addClass('bottom-100');
					$("#liinfo").removeClass('bottom-0');
				}else{
					$("#liinfo").addClass('bottom-0');
					$("#liinfo").removeClass('bottom-100');
				}
			}
			
			function Add_Data(pageAdd){ 
				location.href = pageAdd;
			}
		</script>		
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Clear_Session_Table('<%= clear_session %>', 'DataTables_data_table_<%= request.getRequestURI() %>'); Load_DataTable('0');">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<%	if(!checkPermission(ses_per, "0123456")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> setTimeout(function(){ ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); }, 500); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">
			
				<div class="table-responsive" style="border: 0px !important; min-height: 350px;" border="0">
					<div style="min-width: 1080px;" class="table" border="0">	

						<table style="min-width: 1080px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
							<%	if(checkPermission(ses_per, "0135")){	%>
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
							<%	}	%>
									<td width="12%" align="center"> <b> <%= lb_empcode %> <b> </td>
									<td width="15%" align="center"> <b> <%= lb_names %> <b> </td>
									<td width="20%" align="center"> <b> <%= lb_thsec %> <b> </td>
									<td width="35%" align="center"> <b> <%= lb_message_detail %> <b> </td>
									<td width="12%" align="center"> <b> <%= lb_message_date %> <b> </td>
								</tr>
							</thead>
						</table>
					</div>
					
					<div class="col-xs-12" align="left" style="margin-left: -15px; min-width: 720px;">
						<div class="btn-group">
							<div class="btn-group dropup">
								<button type="button" id="btninfo" class="btn btn-info btn-sm dropdown-toggle" onClick="setClassInfo();" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<i class="glyphicon glyphicon-info-sign"> </i> &nbsp; <%= lb_information %> &nbsp; 
									<span id="caretinfo" class="caret"></span>
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<ul class="dropdown-menu bottom-100" id="liinfo" style="width: 200px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
									<li> <img src="images/edit.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_editdata %> <p> </li>
									<li> <img src="images/delete.png" width="22" height="22" align="absmiddle" style="margin-left: 10px"> &nbsp; <%= lb_deletedata %> </li>
								</ul>
							</div>
						<%	if(checkPermission(ses_per, "0135")){	%>	
							<button type="button" class="btn btn-primary btn-sm" onClick="Add_Data('edit_message.jsp?action=add');"> 
								<i class="glyphicon glyphicon-floppy-disk"> </i> &nbsp; <%= lb_save_message %> &nbsp; 
							</button>
							<button type="button" class="btn btn-primary btn-sm" onClick="javascript: $('#myModalConfirmDelAll').modal('show');"> 
								<i class="glyphicon glyphicon-trash"> </i> &nbsp; <%= lb_delall_message %> &nbsp; 
							</button>
						<%	}	%>
						</div>
					</div>
				</div>
			
			</div>
		</div>		
		<%@ include file="tools/modal_viewdetail.jsp"%>
		
		<%@ include file="tools/modal_result.jsp"%>
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_confirm" class="modal-content alert-message alert-message-danger">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; " border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_confirm" class="glyphicon glyphicon-trash alert-message-danger" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> <%= msg_confirmdel %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;">
								<strong>
									<div class="alert alert-warning" role="alert" style="min-width: 50px;">
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_idcard_name %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_idcard_name"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_message_detail %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <div class="ellipsis_string" style="max-width: 250px;"> <p id="message"> </p> </div> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_message_date %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="message_date"> </p> </div>
										</div>
									</div>
								</strong>
							</div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_confirm_del" onClick="javascript: location.href = 'module/act_message.jsp?action=del&emp_id='+document.getElementById('emp_id').value;" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: $('#myModalConfirm').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> <input type="hidden" id="emp_id" name="emp_id" maxlength="16" readonly="readonly"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalConfirmDelAll" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_confirm" class="modal-content alert-message alert-message-danger">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; " border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_confirm" class="glyphicon glyphicon-trash alert-message-danger" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <%= msg_confirmdelall_messages %> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_confirm_delall" onClick="javascript: location.href = 'module/act_message.jsp?action=delall';" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: $('#myModalConfirmDelAll').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%	}	%>
		
		<script>
		function show_detail(idcard){
			view_detail_450px.location = 'view_employee.jsp?action=view&idcard='+idcard;			
			$('#myModalViewDetail450px').modal('show');
		}
		
		function show_detail2(sec_code){			
			view_detail_140px.location = 'view_section.jsp?action=view&sec_code='+sec_code;			
			$('#myModalViewDetail140px').modal('show');			
		}
		
		function ModalConfirm(sCode, fullname, message, message_date){
			document.getElementById("text_idcard_name").innerHTML = sCode+' - '+fullname;
			document.getElementById("message").innerHTML = message;
			document.getElementById("message_date").innerHTML = message_date;
			document.getElementById("emp_id").value = sCode;
			$('#myModalConfirm').modal('show');
		}
		
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				setTimeout(function(){
					$('body').addClass('loaded');
				
					<%	if(!text_result.equals("")){	%>
					setTimeout(function(){
						$('#myModalResult').modal('show');
						setTimeout(function(){
							$('#myModalResult').modal('hide');
						}, 10000);
					}, 500);
					<%	}	%>
					
				}, 500);
			}
		}
		</script>
		
		<script src="js/dropdown-menu.animated.js"></script>		
		<jsp:include page="footer.jsp" flush="true"/>		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>