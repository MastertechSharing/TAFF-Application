<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "personnel");
	session.setAttribute("subtitle", "blacklist");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
	
	String getaction = "";
	if(request.getParameter("action") != null){
		getaction = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_blacklist.jsp?action="+getaction+"&");
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
			.bottom-95 {
				margin-bottom: -95px !important;
			}
			.bottom-124 {
				margin-bottom: -124px !important;
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
						"sAjaxSource": "data_blacklist_server_side.jsp?view_data="+data,
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
					<%	if(checkPermission(ses_per, "03")){	%>	
							{ "bSortable": false, "aTargets": [ 0, 1 ] }
					<%	}else{	%>
							{ "bSortable": false, "aTargets": [ 0 ] }
					<%	}	%>
						],
						"aaSorting": [
					<%	if(checkPermission(ses_per, "03")){	%>	
							[ 6, "desc" ]
					<%	}else{	%>
							[ 5, "desc" ]
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
					$("#liinfo").addClass('bottom-95');
					$("#liinfo").removeClass('bottom-0');
				}else{
					$("#liinfo").addClass('bottom-0');
					$("#liinfo").removeClass('bottom-95');
				}
			}
			
			function setClassView(){
				var position = $("#btnview").offset();
				if(Number(position.top) < 230){
					$("#liview").addClass('bottom-124');
					$("#liview").removeClass('bottom-0');
				}else{
					$("#liview").addClass('bottom-0');
					$("#liview").removeClass('bottom-124');
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
		
		<%	if(!checkPermission(ses_per, "03")){	%>
		
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
									<td width="3%" align="center"> </td>
							<%	if(checkPermission(ses_per, "03")){	%>
									<td width="3%" align="center"> </td>
							<%	}	%>
									<td width="12%" align="center"> <b> <%= lb_empcode %> <b> </td>
									<td width="15%" align="center"> <b> <%= lb_names %> <b> </td>
									<td width="15%" align="center"> <b> <%= lb_thsec %> <b> </td>
									<td width="20%" align="center"> <b> <%= lb_blacklist_detail %> <b> </td>
									<td width="12%" align="center"> <b> <%= lb_blacklist_date %> <b> </td>
									<td width="12%" align="center"> <b> <%= lb_blacklist_by %> <b> </td>
									<td width="8%" align="center"> <b> <%= lb_reportstatus %> <b> </td>
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
								<ul class="dropdown-menu bottom-95" id="liinfo" style="width: 200px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
									<li> <img src="images/view.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_viewdata %> <p> </li>
									<li> <img src="images/edit.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_editblacklist %> </li>
								</ul>
							</div>
						<%	if(checkPermission(ses_per, "03")){	%>	
							<button type="button" class="btn btn-primary btn-sm" onClick="Add_Data('edit_blacklist.jsp?action=add');"> 
								<i class="glyphicon glyphicon-plus"> </i> &nbsp; <%= lb_addblacklist %> &nbsp; 
							</button>
						<%	}	%>
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
								<ul class="dropdown-menu bottom-124" id="liview" style="width: 280px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
									<li onClick="chkView('0');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/view_all.png" width="20" height="20" align="absmiddle" style="margin-left: -12px"> &nbsp; <%= lb_all_emp %> </a> <p> </li>
									<li onClick="chkView('1');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/ban_circle.png" width="20" height="20" align="absmiddle" style="margin-left: -12px"> &nbsp; <%= lb_view_emp_blacklist %> </a> <p> </li>
									<li onClick="chkView('2');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/ok_circle.png" width="20" height="20" align="absmiddle" style="margin-left: -12px"> &nbsp; <%= lb_view_emp_canceled %> </a> </li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			
			</div>
		</div>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>
		
		<%@ include file="tools/modal_result.jsp"%>
		
		<%	}	%>
		
		<script>
		function show_detail(idcard, record_date){
			view_detail_450px.location = 'view_blacklist.jsp?action=view&idcard='+idcard+'&record_date='+record_date;
			$('#myModalViewDetail450px').modal('show');
		}
		
		function show_detail2(idcard){
			view_detail_450px.location = 'view_employee.jsp?action=view&idcard='+idcard;
			$('#myModalViewDetail450px').modal('show');
		}
		
		function show_detail3(sec_code){
			view_detail_140px.location = 'view_section.jsp?action=view&sec_code='+sec_code;
			$('#myModalViewDetail140px').modal('show');
		}
		
		function show_detail4(user_name){
			view_detail_220px.location = 'view_user.jsp?action=view&user_name='+user_name;
			$('#myModalViewDetail220px').modal('show');
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
				sText = "<%= lb_view_emp_blacklist %>";
				icon = "ban_circle.png";
			}else if(data == "2"){
				sText = "<%= lb_view_emp_canceled %>";
				icon = "ok_circle.png";
			}
			
			var myobj = document.getElementById("img_icon");				
			var oImg = new Image();	
			oImg.src = "images/"+icon;
			oImg.onload = function(){
				myobj.src = oImg.src;
			}
			
			document.getElementById("text_view").innerHTML = sText;
			$('#data_table').DataTable().destroy();
			Load_DataTable(data);
		}
		
		function loadView(){
			$('#data_table').DataTable().destroy();
			Load_DataTable(data_view);
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