<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	
	String reader_no = request.getParameter("reader_no");
	String type_data = request.getParameter("type_data");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
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
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script>
			$(document).ready(function() {
				$('#data_table').dataTable( {
					"bServerSide": true,
					"bProcessing": true,
					"sAjaxSource": "view_gen_data_idtables_server_side.jsp?reader_no=<%= reader_no %>&type_data=<%= type_data %>",
					"drawCallback": function( settings ) {
						var api = new $.fn.dataTable.Api( settings );
						if( api.rows().data()[0] !== undefined ){	
							if( api.rows().data()[0][0] == ' '){
								window.top.location.href = 'login.jsp';
							}
						}
					},
					
					"aaSorting": [
						[ 0, "asc" ]
					],
					"dom": "<fl<t>ip>",	//	<lf<t>ip>
					
					"aLengthMenu": [ [ 12, 50, 100, 1000 ], [ 12, 50, 100, 1000 ] ],
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
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>		
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px; margin-bottom: -50px;">
		
		<div class="table-responsive" style="border: 0px !important; margin-bottom: -50px;" border="0">
			<div style="min-width: 800px;" class="table" border="0">	

				<table style="min-width: 1080px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
					<thead>
						<tr>
							<td width="15%" align="center"> <b> <%= lb_empcode %> <b> </td>
							<td width="20%" align="center"> <b> <%= lb_thname_sname %><b> </td>
							<td width="20%" align="center"> <b> <%= lb_enname_sname %><b> </td>
							<td width="30%" align="center"> <b> <%= lb_section %> <b> </td>
							<td width="15%" align="center"> <b> <%= lb_dateupdate %> <b> </td>
						</tr>
					</thead>
				</table>
				
			</div>
		</div>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>