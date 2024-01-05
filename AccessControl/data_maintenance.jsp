<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "others");
	session.setAttribute("subtitle", "maintenance");
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
		
	String getaction = "";
	if(request.getParameter("action") != null){
		getaction = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_maintenance.jsp?action="+getaction+"&");
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
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

		<script language="javascript">
			function Clear_Session_Table(clear_ses, key){ 
				if(clear_ses == 'true'){
					localStorage.removeItem(key);
				}
			}
		
			$(document).ready(function() {
				$('#data_table').dataTable( {
					"aoColumnDefs": [
						{ "bSortable": false, "aTargets": [ 0, 1 ] }
					],
					"aaSorting": [
						[ 2, "desc" ]
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
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
			function Add_Data(pageAdd){ 
				location.href = pageAdd;
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Clear_Session_Table('<%= clear_session %>', 'DataTables_data_table_<%= request.getRequestURI() %>'); Load_DataTable();">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">
			
				<div class="table-responsive" style="border: 0px !important;" border="0">
						
					<div style="min-width: 1080px;" class="table" border="0">	
					
						<table style="min-width: 1080px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
							<%	if((ses_per == 0) || (ses_per == 1)){	%>	
									<td width="3%" align="center" rowspan="2"> </td>
							<%	}	%>
									<td width="12%" align="center" rowspan="2"> <p><p> <%= lb_date %> </td>
									<td width="35%" align="center" rowspan="2"> <p><p> <%= lb_description %> </td>
									<td width="25%" align="center" colspan="2"> <%= lb_adddata %> </td>
									<td width="25%" align="center" colspan="2"> <%= lb_editdata %> </td>
								</tr>
								<tr>
									<td width="11%" align="center"> <%= lb_username %> </td>
									<td width="14%" align="center"> <%= lb_date %> - <%= lb_time %> </td>
									<td width="11%" align="center"> <%= lb_username %> </td>
									<td width="14%" align="center"> <%= lb_date %> - <%= lb_time %> </td>
								</tr>
							</thead>
							<tbody>
							<%	
								try{
									String sql = "SELECT * from dbnote ORDER BY datetime_note desc ";  
									ResultSet rs = stmtQry.executeQuery(sql);
										while(rs.next()){
											String dt_note = rs.getString("datetime_note").substring(0, 19);
											String th_desc = rs.getString("desc_note");
											String user_add = rs.getString("user_add");
											String dt_add = rs.getString("datetime_add").substring(0,19);
											String user_edit = rs.getString("user_edit");
											String dt_edit = rs.getString("datetime_edit").substring(0,19);			
											String substrdt = dt_note.substring(0, 10);	//	YMDTodate(dt_note.substring(0, 10));
											String substrdtu1 = dt_add;
											String substrdtu2 = dt_edit;
											
							%>
								<tr>
							<%	if((ses_per == 0) || (ses_per == 1)){	%>
									<td align="center"> 
										<a href="edit_maintenance.jsp?action=edit&StheDate=<%= dt_note %>"> <img src="images/edit.png" width="18" height="18" border="0" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_editdata %>"> </a>
									</td>
							<%	}	%>
									<td align="center"> <b> <a href="#" onClick="show_detail('<%= dt_note %>');" data-toggle="tooltip" data-placement="right" data-html="true" title="<%= lb_viewdata %>"> <%= substrdt %> </a> </b> </td>
									<td class="pad-left-10"> <div class="ellipsis_string" style="width: 330px;" data-toggle="tooltip" data-placement="right" title="<%= th_desc %>"> <%= th_desc %> </div> </td>
									<td class="pad-left-10"> 
										<b> <span onClick="show_detail2('<%= user_add %>');" style="color: #337AB7; cursor: pointer; cursor: hand;" data-toggle="tooltip" data-placement="right" title="<%= lb_viewdata %>">
											<%= user_add %> 
										</span> </b>
									</td>
									<td align="center"> <%= substrdtu1 %> </td>
									<td class="pad-left-10"> 
										<b> <span onClick="show_detail2('<%= user_edit %>');" style="color: #337AB7; cursor: pointer; cursor: hand;" data-toggle="tooltip" data-placement="right" title="<%= lb_viewdata %>">
											<%= user_edit %> 
										</span> </b>
									</td>
									<td align="center"> <%= substrdtu2 %> </td>
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
						<%	if((ses_per == 0) || (ses_per == 1)){	%>	
							<button type="button" class="btn btn-primary btn-sm" onClick="Add_Data('edit_maintenance.jsp?action=add');"> 
								<i class="glyphicon glyphicon-plus"> </i> &nbsp; <%= lb_adddata %> &nbsp; 
							</button>
						<%	}	%>
							<button type="button" class="btn btn-primary btn-sm" onClick="Add_Data('report_maintenance.jsp');"> 
								<i class="glyphicon glyphicon-file"> </i> &nbsp; <%= lb_reportname %> &nbsp; 
							</button>
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
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;">
								<strong>
									<div class="alert alert-warning" role="alert" style="min-width: 50px;">
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_departcode %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_code"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_thdesc %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_th_name"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_endesc %> :  </div>
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

		<script>
		function show_detail(StheDate){
			view_detail_220px.location = 'view_maintenance.jsp?action=view&StheDate='+StheDate;
			$('#myModalViewDetail220px').modal('show');
		}
		
		function show_detail2(username){
			view_detail_220px.location = 'view_user.jsp?action=view&user_name='+username;
			$('#myModalViewDetail220px').modal('show');
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