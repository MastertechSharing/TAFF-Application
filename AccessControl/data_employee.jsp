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
	session.setAttribute("subtitle", "employee");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
	
	String getaction = "";
	if(request.getParameter("action") != null){
		getaction = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_employee.jsp?action="+getaction+"&");
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
						"sAjaxSource": "data_employee_server_side.jsp?view_data="+data,
						"drawCallback": function( settings ) {
							document.getElementById("caretinfo").style.WebkitTransform = "none";
							document.getElementById("caretview").style.WebkitTransform = "none";
							var api = new $.fn.dataTable.Api( settings );
							if( api.rows().data()[0] !== undefined ){
								if( api.rows().data()[0][0] == ' '){
									window.location.href = 'login.jsp';
								}
								if( api.rows().data()[1] === undefined ){
									document.getElementById("caretinfo").style.WebkitTransform = "rotate(180deg)";
									document.getElementById("caretview").style.WebkitTransform = "rotate(180deg)";
								}
							}else{
								document.getElementById("caretinfo").style.WebkitTransform = "rotate(180deg)";
								document.getElementById("caretview").style.WebkitTransform = "rotate(180deg)";
							}
						},
					
						"aoColumnDefs": [
					<%	if(checkPermission(ses_per, "0135")){	%>	
							{ "bSortable": false, "aTargets": [ 0, 1, 2, 9 ] }
					<%	}else{	%>
							//{ "bSortable": false, "aTargets": [ 3, 4 ] }
					<%	}	%>
						],
						"aaSorting": [
					<%	if(checkPermission(ses_per, "0135")){	%>	
							[ 5, "asc" ], [ 6, "asc" ], [ 7, "asc" ], [ 8, "asc" ]
					<%	}else{	%>
							[ 0, "asc" ], [ 1, "asc" ], [ 2, "asc" ], [ 3, "asc", [ 4, "asc"  ]
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
					$("#liinfo").addClass('bottom-30');
					$("#liinfo").removeClass('bottom-0');
				}else{
					$("#liinfo").addClass('bottom-0');
					$("#liinfo").removeClass('bottom-30');
				}
			}
			
			function setClassView(){
				var position = $("#btnview").offset();
				if(Number(position.top) < 230){
					$("#liview").addClass('bottom-30');
					$("#liview").removeClass('bottom-0');
				}else{
					$("#liview").addClass('bottom-0');
					$("#liview").removeClass('bottom-30');
				}
			}
			
			function ModalConfirm(sCode, sType, sText, modal_class, glyphicon_class, color_class, btn_class, th_name, en_name){
				if(sType == 'clear'){
					document.getElementById("text_confirm").innerHTML = sText+" "+sCode+" ?";
				}else{
					document.getElementById("text_confirm").innerHTML = sText;
				}
				
				if(sType == 'delete'){
					document.getElementById("display_name").style.display = '';
					document.getElementById("text_idcard").innerHTML = sCode;
					document.getElementById("text_th_name").innerHTML = th_name;
					document.getElementById("text_en_name").innerHTML = en_name;
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
					location.href = 'module/act_employee.jsp?action=del&idcard='+document.getElementById('sCode').value;
				}else if(document.getElementById('sType').value == 'clear'){
					location.href = 'module/act_employee.jsp?action=clear&idcard='+document.getElementById('sCode').value;
				}else if(document.getElementById('sType').value == 'clearall'){
					location.href = 'module/act_employee.jsp?action=clearall';
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
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
							<%	}	%>
									<td width="13%" align="center"> <b> <%= lb_empcode %> <b> </td>
									<td width="18%" align="center"> <b> <%= lb_thname_sname %><b> </td>
									<td width="18%" align="center"> <b> <%= lb_enname_sname %><b> </td>
									<td width="20%" align="center"> <b> <%= lb_section %> <b> </td>
									<td width="17%" align="center"> <b> <%= lb_dateupdate %> <b> </td>
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
								<ul class="dropdown-menu bottom-30" id="liinfo" style="width: 200px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
									<li> <img src="images/edit.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_editdata %> <p> </li>
									<li> <img src="images/delete.png" width="22" height="22" align="absmiddle" style="margin-left: 10px"> &nbsp; <%= lb_deletedata %> <p> </li>
									<li> <img src="images/refresh.png" width="18" height="18" align="absmiddle" style="margin-left: 14px"> &nbsp; <%= lb_clear_pw %> <p> </li>
									<li> <img src="images/camera.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_take_photo %> <p> </li>
									<li> <img src="images/finger_tab.png" width="22" height="22" align="absmiddle" style="margin-left: 10px"> &nbsp; <%= lb_enrollfp %> </li>
								</ul>
							</div>
						<%	if(checkPermission(ses_per, "0135")){	%>	
							<button type="button" class="btn btn-primary btn-sm" onClick="Add_Data('edit_employee.jsp?action=add');"> 
								<i class="glyphicon glyphicon-plus"> </i> &nbsp; <%= lb_adddata %> &nbsp; 
							</button>
						<%	if(checkPermission(ses_per, "0")){	%>
							<button type="button" class="btn btn-primary btn-sm" onClick="ModalConfirm('','clearall','<%= msg_confirmclearall %>','alert-message-warning', 'glyphicon-repeat','alert-message-warning', 'btn-warning', '', '');"> 
								<i class="glyphicon glyphicon-repeat"> </i> &nbsp; <%= lb_clear_pw %> &nbsp; 
							</button>
						<%	}}	%>
						</div>
						&nbsp;
						<div class="btn-group">
							<div class="btn-group dropup">
								<div class="input-group-addon" style="width: 20px !important; background-color: #FFF;"> <img id="img_icon" src="images/view_all.png" style="margin-left: -4px; cursor: default;" align="absmiddle" width="16" height="16" border="0"> </div>
								<button type="button" id="btnview" class="btn btn-info btn-sm dropdown-toggle" style="margin-top: -30px; margin-left: 32px;" onClick="setClassView();" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span id="text_view"> <%= lb_all_emp %> </span> &nbsp; 
									<span id="caretview" class="caret"></span>
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<ul class="dropdown-menu bottom-30" id="liview" style="width: 280px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
									<li onClick="chkView('0');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/view_all.png" width="20" height="20" align="absmiddle" style="margin-left: -12px"> &nbsp; <%= lb_all_emp %> </a> <p> </li>
									<li onClick="chkView('1');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/camera.png" width="20" height="20" align="absmiddle" style="margin-left: -12px"> &nbsp; <%= lb_emp_have_photo %>  </a> <p> </li>
									<li onClick="chkView('2');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/camera_bw.png" width="20" height="20" align="absmiddle" style="margin-left: -12px"> &nbsp; <%= lb_emp_dhave_photo %>  </a> <p> </li>
									<li onClick="chkView('3');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/finger_tab.png" width="20" height="20" align="absmiddle" style="margin-left: -14px"> &nbsp; <%= lb_emp_have_template %>  </a> <p> </li>
									<li onClick="chkView('4');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/finger_tab_bw.png" width="20" height="20" align="absmiddle" style="margin-left: -14px"> &nbsp; <%= lb_emp_dhave_template %>  </a> </li>
								</ul>
							</div>
						<%	if(checkPermission(ses_per, "0135")){	%>	
							<button type="button" class="btn btn-primary btn-sm" onClick="checkFile();"> 
								<i class="glyphicon glyphicon-edit"> </i> &nbsp; <%= lb_check_jpg_tpl %> &nbsp; 
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
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px; display: none;" id="display_name">
								<strong>
									<div class="alert alert-warning" role="alert" style="min-width: 50px;">
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_empcode %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_idcard"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_thname_sname %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_th_name"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_enname_sname %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_en_name"> </p> </div>
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
		
		<div class="modal fade bs-example-modal-lg" id="myModalCapture" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" onClick="setblankCap();">&times;</button>
						<h4 class="modal-title"> <span id="text_camera"> </span> <%= lb_empcode %> : <span id="text_camera"> </span> <span id="text_camera_id"> </span> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="" id="camera_capture" name="camera_capture" frameborder="0" height="430px" style="min-width: 850px;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-md-8 col-xs-8" align="left">
							<button type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" onClick="btnCap('<%= lb_take_photo %>');"> &nbsp; <%= lb_take_photo %> &nbsp; </button> &nbsp;
							<button type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" onClick="btnSendPic('<%= lb_cmd63 %>');"> &nbsp; <%= lb_cmd63 %> &nbsp; </button>
						</div>
						<div class="col-md-4 col-xs-4">
							<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal" onClick="setblankCap();"> <%= btn_close %> </button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalFinger" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog modal-lg" style="min-width: 1000px;" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" onClick="setblankFin();">&times;</button>
						<h4 class="modal-title"> <span id="text_finger"> </span> <%= lb_empcode %> : <span id="text_finger_id"> </span> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="" id="register_finger" name="register_finger" frameborder="0" height="410px" style="min-width: 950px;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-md-8 col-xs-8" align="left">
							<button type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" onClick="btnRegis('<%= lb_enrollfp %>');"> &nbsp; <%= lb_enrollfp %> &nbsp; </button> &nbsp;
							<button type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" onClick="btnSend('<%= lb_cmd80_44 %>');"> &nbsp; <%= lb_cmd80_44 %> &nbsp; </button>
						</div>
						<div class="col-md-4 col-xs-4">
							<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal" onClick="setblankFin();"> <%= btn_close %> </button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalCheckFile" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_confirm" class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; " border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_confirm" class="glyphicon glyphicon-edit alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <%= msg_confirmcheck_jpg_tpl %> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="Confirm_Check();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: $('#myModalCheckFile').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
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
		function show_section(seccode){
			view_detail_140px.location = 'view_section.jsp?action=view&sec_code='+seccode;
			$('#myModalViewDetail140px').modal('show');
		}
		
		var data_view = '0';
		function chkView(data){
			var sText = "";
			var icon = "";
			data_view = data;
			if(data == "0"){
				sText = "<%= lb_all_emp %>";
				icon = "view_all.png";
			}else if(data == "1"){
				sText = "<%= lb_emp_have_photo %>";
				icon = "camera.png";
			}else if(data == "2"){
				sText = "<%= lb_emp_dhave_photo %>";
				icon = "camera_bw.png";
			}else if(data == "3"){
				sText = "<%= lb_emp_have_template %>";
				icon = "finger_tab.png";
			}else if(data == "4"){
				sText = "<%= lb_emp_dhave_template %>";
				icon = "finger_tab_bw.png";
			}
			
			var myobj = document.getElementById("img_icon");				
			var oImg = new Image();	
			oImg.src = "images/"+icon;
			oImg.onload = function(){
				myobj.src = oImg.src;
			}
			
			document.getElementById("text_view").innerHTML = sText;
		//	$('#data_table').DataTable().destroy();
		//	Load_DataTable(data);
			$('#data_table').DataTable().ajax.url('data_employee_server_side.jsp?view_data='+data_view).load();
		}
		
		function loadView(){
		//	$('#data_table').DataTable().destroy();
		//	Load_DataTable(data_view);
			$('#data_table').DataTable().ajax.url('data_employee_server_side.jsp?view_data='+data_view).load();
		}
		
		function setblankCap(){
			camera_capture.location = '_blank';
		}
		
		function setblankFin(){
			register_finger.location = '_blank';
		}
		
		var idcard_select = '';
		
		function cameraCapture(sText, idcard){
			idcard_select = idcard;
			document.getElementById("text_camera").innerHTML = sText;
			document.getElementById("text_camera_id").innerHTML = idcard;
			camera_capture.location = 'camera_capture.jsp?action=edit&idcard='+idcard;
			$('#myModalCapture').modal('show');
		}
		function btnCap(sText){
			document.getElementById("text_camera").innerHTML = sText;
			camera_capture.location = 'camera_capture.jsp?action=edit&idcard='+idcard_select;
		}
		function btnSendPic(sText){
			document.getElementById("text_camera").innerHTML = sText;
			camera_capture.location = 'cmd_set_picture_emp.jsp?idcard='+idcard_select;
		}
		
		function registerFinger(sText, idcard){
			idcard_select = idcard;
			document.getElementById("text_finger").innerHTML = sText;
			document.getElementById("text_finger_id").innerHTML = idcard;
			register_finger.location = 'cmd_enroll_finger_emp.jsp?idcard='+idcard;
			$('#myModalFinger').modal('show');
		}
		function btnRegis(sText){
			document.getElementById("text_finger").innerHTML = sText;
			register_finger.location = 'cmd_enroll_finger_emp.jsp?idcard='+idcard_select;
		}
		function btnSend(sText){
			document.getElementById("text_finger").innerHTML = sText;
			register_finger.location = 'cmd_set_idtable_emp.jsp?idcard='+idcard_select;
		}
		
		function checkFile(){
			$('#myModalCheckFile').modal('show');
		}
		
		function Confirm_Check(){
			location.href = 'module/act_employee.jsp?action=check_file';
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