<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%
	session.setAttribute("page_g", "setting");
	session.setAttribute("subpage", "config");
	session.setAttribute("subtitle", "report");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
	
	String action = "";
	if(request.getParameter("action") != null){
		action = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_report.jsp?action="+action+"&");
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
	
	<link href="css/preloader.css" rel="stylesheet">
	<script src="js/preloader.js"></script>
	
	<link rel="stylesheet" href="css/taff.css" type="text/css"> 
	
	<!-- Bootstrap -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/dataTables.bootstrap.min.css" rel="stylesheet"> 
	
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.dataTables.min.js"></script>
	<script src="js/dataTables.bootstrap.min.js"></script>
	
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
				<%	if((ses_per == 0) || (ses_per == 1)){	%>	
						{ "bSortable": false, "aTargets": [ 0, 1 ] }
				<%	}else{	%>
						{ "bSortable": false, "aTargets": [ 0 ] }
				<%	}	%>
					],
					"aaSorting": [
				<%	if((ses_per == 0) || (ses_per == 1)){	%>	
						[ 2, "asc" ]
				<%	}else{	%>
						[ 1, "asc" ]
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
							"sLASt":     "หน้าสุดท้าย"
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
<!--onLoad="removeScrollBars();"-->
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Clear_Session_Table('<%= clear_session %>', 'DataTables_data_table_<%= request.getRequestURI() %>'); Load_DataTable();">
<!-- INCLUDE HEADER & MENU-->
	<jsp:include page="header.jsp" flush="true"/>
	
	<div class="body-display">
		<div class="container">
			<div class="table-responsive" style="border: 0px !important;" border="0">
				<div style="min-width: 800px;" class="table" border="0">	
					<table style="min-width: 800px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
						<thead>
							<tr>
						<%	if((ses_per != 9)){	%>			
								<td width="3%" align="center"></td>
						<%	}	%>	
								<td width="19%" align="center"> <%= lb_repcode %> </td>
								<td width="32%" align="center"> <%= lb_thdesc %> </td>
								<td width="32%" align="center"> <%= lb_endesc %> </td>            
							</tr>
						</thead>
						<tbody>
				<%	try{
						ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbreport ORDER BY rep_code");
						while(rs.next()){			
							String rep_code = rs.getString("rep_code");
							String th_desc = rs.getString("th_desc");
							String en_desc = rs.getString("en_desc");
				%>
							<tr>
						<%	if((ses_per != 9)){	%>			
								<td align="center"> 
									<a href="edit_report.jsp?action=edit&rep_code=<%= rep_code %>"><img src="images/edit.png" width="18" height="18" border="0" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_editdata %>"></a>
								</td>
						<%	}	%>
								<td align="center"> <b> <a href="#" onClick="show_detail('<%= rep_code %>');" data-toggle="tooltip" data-placement="right" data-html="true" title="<%= lb_viewdata %>"> <%= rep_code %> </a> </b> </td>
								<td class="pad-left-10"><%= th_desc %></td>
								<td class="pad-left-10"><%= en_desc %></td>
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
								<li> <img src="images/edit.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_editdata %> </li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>

		<script>
		function show_detail(rep_code){
			view_detail_100px.location = 'view_report.jsp?action=view&rep_code='+rep_code;
			$('#myModalViewDetail100px').modal('show');
		}	
		
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				$('body').addClass('loaded');
			}
		}
		</script>
		
		<script src="js/dropdown-menu.animated.js"></script>
	
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>

		