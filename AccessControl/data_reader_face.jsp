<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 	
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "aboutsystem");
	session.setAttribute("subtitle", "reader_face");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
		
	String getaction = "";
	if(request.getParameter("action") != null){
		getaction = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_reader_face.jsp?action="+getaction+"&");
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
	
	boolean mode_ip = false;
	String view_data = "all";			//	all = All, 0 = Unqiue IP , 1 = Duplicate IP 
	if(network_feature.equals("1")){
		if(request.getParameter("ip") != null){
			view_data = "1";
			mode_ip = true;
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
						"sAjaxSource": "data_reader_face_server_side.jsp?view_data="+data,
						"drawCallback": function( settings ) {
							var api = new $.fn.dataTable.Api( settings );
							if( api.rows().data()[0] !== undefined ){	
								if( api.rows().data()[0][0] == ' '){
									window.location.href = 'login.jsp';
								}
							}
						},
						
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
			
			function ModalConfirm(sCode, sText, ip, th_name, en_name, loc_code){
				document.getElementById("text_confirm").innerHTML = sText;
				document.getElementById("text_code").innerHTML = sCode;
				document.getElementById("text_ip").innerHTML = ip;
				document.getElementById("text_th_name").innerHTML = th_name;
				document.getElementById("text_en_name").innerHTML = en_name;
				document.getElementById("text_locatecode").innerHTML = loc_code;
				document.getElementById("sCode").value = sCode;
				
				$('#myModalConfirm').modal('show');
			}
			
			function Confirm_Button(){ 
				location.href = 'module/act_reader_face.jsp?action=del&door_id='+document.getElementById('sCode').value;
			}
			
			function Add_Data(pageAdd){ 
				location.href = pageAdd;
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Clear_Session_Table('<%= clear_session %>', 'DataTables_data_table_<%= request.getRequestURI() %>'); Load_DataTable('<%= view_data %>');">

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
				
						<table style="min-width: 1080px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
							<%	if(checkPermission(ses_per, "0")){	%>	
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
							<%	}	%>
									<td width="13%" align="center"> <%= lb_doorcode %> </td>
									<td width="15%" align="center"> IP ADDRESS </td>
									<td width="22%" align="center"> <%= lb_thdesc %> </td>
									<td width="22%" align="center"> <%= lb_endesc %> </td>
									<td width="22%" align="center"> <%= lb_locatecode %> </td>
								</tr>
							</thead>
						</table>
					</div>
					
					<div class="col-xs-12" align="left" style="margin-left: -15px; min-width: 500px;">
						<div class="btn-group">
							<%@ include file="tools/toggle_dropdown.jsp"%>
							<%	if(checkPermission(ses_per, "0")){	%>	
							<button type="button" class="btn btn-primary btn-sm" onClick="Add_Data('edit_reader_face.jsp?action=add');"> 
								<i class="glyphicon glyphicon-plus"> </i> &nbsp; <%= lb_adddata %> &nbsp; 
							</button>
							<%	}	%>
						</div>
					<%	if(network_feature.equals("1")){	%>
						&nbsp;
						<div class="btn-group">
							<div class="btn-group dropup">
								<div class="input-group-addon" style="width: 20px !important; background-color: #FFF;"> <img id="img_icon" src="images/<% if(mode_ip){ %>ip_duplicate.png<% }else{ %>view_all.png<% } %>" style="margin-left: -4px; cursor: default;" align="absmiddle" width="16" height="16" border="0"> </div>
								<button type="button" id="btnview" class="btn btn-info btn-sm dropdown-toggle" style="margin-top: -30px; margin-left: 32px;" onClick="setClassView();" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<span id="text_view"> <% if(mode_ip){ out.println(lb_duplicate_ip); }else{ out.println(lb_all_ip); } %> </span> &nbsp; 
									<span id="caretview" class="caret"></span>
									<span class="sr-only">Toggle Dropdown</span>
								</button>
								<ul class="dropdown-menu bottom-30" id="liview" style="width: 280px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
									<li onClick="chkView('all');" style="margin-top: 0px; margin-bottom: -5px;"> <a href="#"> <img src="images/view_all.png" width="20" height="20" align="absmiddle" style="margin-left: -12px;"> &nbsp; <%= lb_all_ip %>  </a> <p> </li>
									<li onClick="chkView('0');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/ip_unique.png" width="20" height="20" align="absmiddle" style="margin-left: -12px; margin-top: -4px;"> &nbsp; <%= lb_unique_ip %> </a> <p> </li>
									<li onClick="chkView('1');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/ip_duplicate.png" width="20" height="20" align="absmiddle" style="margin-left: -12px; margin-top: -4px;"> &nbsp; <%= lb_duplicate_ip %>  </a> <p> </li>
								</ul>
							</div>
						</div>
					<%	}	%>
					</div>
				</div>
			
			</div>
		</div>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>
		
		<!--viewdoor & viewlocation -->
		<%@ include file="../tools/modal_view_door_location.jsp"%>
		
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
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_doorcode %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_code"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_hostip %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_ip"> </p> </div>
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
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_locatecode %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_locatecode"> </p> </div>
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
		
		function show_detail(door_id){
			view_door.location = 'view_reader_face.jsp?action=view&door_id='+door_id;
			$('#myModalViewDoor').modal('show');
		}	
		function show_location(locate_code){
			view_detail_260px.location = 'view_location.jsp?action=view&locate_code='+locate_code;
			$('#myModalViewDetail260px').modal('show');
		}
		
		var data_view = 'all';
		function chkView(data){
			var sText = "";
			var icon = "";
			data_view = data;
			if(data == "all"){
				sText = "<%= lb_all_ip %>";
				icon = "view_all.png";
			}else if(data == "0"){
				sText = "<%= lb_unique_ip %>";
				icon = "ip_unique.png";
			}else if(data == "1"){
				sText = "<%= lb_duplicate_ip %>";
				icon = "ip_duplicate.png";
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
			$('#data_table').DataTable().ajax.url('data_reader_face_server_side.jsp?view_data='+data_view).load();
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
						}, 3000);
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