<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 	
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "download");
	session.setAttribute("subtitle", "download_from_trans");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
		
	String getaction = "";
	if(request.getParameter("action") != null){
		getaction = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "gen_data_idtables.jsp?action="+getaction+"&");
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
		<script language="javascript" src="js/alert_box.js"></script>
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		
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
						
						"bServerSide": true,
						"bProcessing": true,
						"sAjaxSource": "gen_data_idtables_trans_server_side.jsp",
						"drawCallback": function( settings ) {
							var api = new $.fn.dataTable.Api( settings );
							if( api.rows().data()[0] !== undefined ){	
								if( api.rows().data()[0][0] == ' '){
									window.location.href = 'login.jsp';
								}
							}
						},
						
						"aoColumnDefs": [
					<%	if(checkPermission(ses_per, "0")){	%>	
							{ "bSortable": false, "aTargets": [ 0, 1, 2, 3 ] }
					<%	}	%>
						],
						"aaSorting": [
					<%	if(checkPermission(ses_per, "0")){	%>	
							[ 4, "asc" ]
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
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Clear_Session_Table('<%= clear_session %>', 'DataTables_data_table_<%= request.getRequestURI() %>'); Load_DataTable();">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display" style="margin-bottom: -30px;">
			<div class="container">
			
				<div class="table-responsive" style="border: 0px !important;" border="0">
					<div style="min-width: 1080px;" class="table" border="0">	
				
						<table style="min-width: 1080px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
							<%	if(checkPermission(ses_per, "0")){	%>	
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
							<%	}	%>
									<td width="12%" align="center"> <%= lb_readerno %> </td>
									<td width="18%" align="center"> <%= lb_thdesc %> </td>
									<td width="18%" align="center"> <%= lb_endesc %> </td>
									<td width="20%" align="center"> <%= lb_doorcode %> </td>
									<td width="20%" align="center"> <%= lb_locatecode %> </td>
								</tr>
							</thead>
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
								<ul class="dropdown-menu" style="width: 220px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
									<li> <img src="images/group.png" width="22" height="22" align="absmiddle" style="margin-left: 10px"> &nbsp; <%= lb_view_list_employee %> <p> </li>
									<li> <img src="images/ids.png" width="24" height="24" align="absmiddle" style="margin-left: 10px;"> &nbsp; <%= lb_download_file %> <strong>.IDS</strong> <p> </li>
									<li> <img src="images/xml.png" width="24" height="24" align="absmiddle" style="margin-left: 10px"> &nbsp; <%= lb_download_file %> <strong>.XML</strong> <p> </li>
									<li> <img src="images/csv.png" width="24" height="24" align="absmiddle" style="margin-left: 10px"> &nbsp; <%= lb_download_file %> <strong>.CSV</strong> </li>
								</ul>
							</div>
							
						</div>
					</div>
				</div>
			
			</div>
		</div>
		
		<iframe src="" id="iframe_gendata" name="iframe_gendata" frameborder="0" width="0px" height="0px"></iframe>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>		
		
		<div class="modal fade" id="myModalProcess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-notice">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <img src="images/loading2.gif" width="48" height="48" align="absmiddle"> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom:  0px;"> <h4> <p> <%= lb_please_wait %> </p> </h4> </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<script>
		function show_detail(reader_no, data){
			if(data != ''){
				view_detail.location = 'view_gen_data_idtables.jsp?action=view&reader_no='+reader_no+'&type_data='+data;
				$('#myModalViewDetail').modal('show');
			}else{
				view_detail.location = 'view_reader.jsp?action=view&reader_no='+reader_no;
				$('#myModalViewDetail').modal('show');
			}
		}	
		
		function show_detail2(door_id){
			view_detail.location = 'view_door.jsp?action=view&door_id='+door_id;
			$('#myModalViewDetail').modal('show');
		}
		
		function show_detail3(locate_code){
			view_detail.location = 'view_location.jsp?action=view&locate_code='+locate_code;
			$('#myModalViewDetail').modal('show');
		}
		
		function show_employee(reader_no){
			view_reader.location = 'view_reader.jsp?action=view&reader_no='+reader_no;
			$('#myModalViewDoor').modal('show');
		}
			
		function downloadFile(reader_no, type_file){
			$('#myModalProcess').modal('show');
			setTimeout(function(){ 
				$('#myModalProcess').modal('hide');
			}, 2000);	// 2 sec
			
			frames['iframe_gendata'].location.href = 'gen_data_idtables_file.jsp?reader_no='+reader_no+'&type_file='+type_file+'&type_data=transaction';
		}
		
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				setTimeout(function(){
					$('body').addClass('loaded');
				}, 500);
			}
		}
		</script>
		
		<script src="js/dropdown-menu.animated.js"></script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>