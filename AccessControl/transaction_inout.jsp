<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "others");
	session.setAttribute("subtitle", "trans_inout");
	session.setAttribute("action", "transaction_inout.jsp?");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
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
		
		<script>		
			function Load_DataTable(){
				$(document).ready(function() {
					$('#data_table').dataTable( {
						"aaSorting": [
							[ 3, "desc" ]
						],
						"dom": "<fl<t>ip>",	//	<lf<t>ip>
						
						"lengthMenu": [ [ 15, 50, 100, 1000 ], [ 15, 50, 100, 1000 ] ]
					<%	if(lang.equals("th")){	%>	
						,
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

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Load_DataTable();">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">
				
				<table style="min-width: 1000px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
					<thead>	
						<tr class="active">
							<td width="12%" align="center"> <b> <%= lb_empcode %> </b> </td>
							<td width="18%" align="center"> <b> <%= lb_names %> </b> </td>
							<td width="8%" align="center"> <b> <%= lb_date %> </b> </td>
							<td width="8%" align="center"> <b> <%= lb_time %> </b> </td>
							<td width="20%" align="center"> <b> <%= lb_doors %> </b> </td>
							<td width="7%" align="center"> <b> <%= lb_readers %> </b> </td>
							<td width="7%" align="center"> <b> <%= lb_reportstatus %> </b> </td>
							<td width="20%" align="center"> <b> <%= lb_action %> </b> </td>
						</tr>   
					</thead>
					<tbody>
			<% 	String fn_limit = "", fn_top = "";
				if(mode == 0){
					fn_limit = " LIMIT 1000 ";
				}else if(mode == 1){
					fn_top = " TOP 1000 ";
				}
				String sql = " SELECT " + fn_top + " date_event, trans.workday, trans.idcard, trans.time_event, trans.event_code, "
					+ "substring(trans.reader_no,5,1) AS t_reader_duty, trans.duty, "
					+ "emp.th_fname, emp.th_sname,emp.en_fname, emp.en_sname, "
					+ "substring(trans.reader_no,1,4) AS door_id, "
					+ "door.th_desc AS d_th_desc, door.en_desc AS d_en_desc, "
					+ "eve.th_desc AS e_th_desc, eve.en_desc AS e_en_desc "
					+ "FROM view_transaction trans "
					+ "LEFT OUTER JOIN dbemployee emp ON (trans.idcard = emp.idcard) "
					+ "LEFT OUTER JOIN dbdoor door ON (substring(trans.reader_no,1,4) = door.door_id) "
					+ "LEFT OUTER JOIN dbevent eve ON (trans.event_code = eve.event_code) ";
				if(checkPermission(ses_per, "12")){
					sql = sql + "LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) "
						+ "LEFT OUTER JOIN dbusers users ON (sec.dep_code = users.dep_code) "
						+ "WHERE user_name = '"+ses_user+"' ";
				}else if(checkPermission(ses_per, "56")){
					sql = sql + "LEFT OUTER JOIN dbusers users ON (emp.sec_code = users.sec_code) "
						+ "WHERE user_name = '"+ses_user+"' ";
				}	
				sql = sql + "ORDER BY trans.workday DESC " + fn_limit;
				
				String idcard = "", emp_name = "", date_event = "", time_event = "";
				String door_desc = "", reader_duty = "", duty = "", event_desc = "";
				try{	
					ResultSet rs = stmtQry.executeQuery(sql);
					while(rs.next()){
						
						if(!(rs.getString("idcard").equals("") || rs.getString("idcard") == null)){
							idcard = "<b> <span onClick='show_detail1(\""+rs.getString("idcard")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'> "+rs.getString("idcard")+" </span> </b> ";
						
							if(!(rs.getString("th_fname") == null && rs.getString("en_fname") == null )){
								if(lang.equals("th")){
									emp_name = rs.getString("th_fname") + " " + rs.getString("th_sname");
								}else{
									emp_name = rs.getString("en_fname") + " " + rs.getString("en_sname");
								}								
							}else{
								emp_name = "&nbsp;";
							}
						}else{
							idcard = "&nbsp;";
						}

						date_event = YMDTodate(rs.getString("date_event"));
						time_event = rs.getString("time_event");
						
						door_desc = " <b> <span onClick='show_detail2(\""+rs.getString("door_id")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'> "+rs.getString("door_id")+" </span> </b> ";
						
						if(!(rs.getString("door_id") == null)){
							if(lang.equals("th")){
								if(rs.getString("d_th_desc") != null){
									door_desc += " <b> : </b> "+rs.getString("d_th_desc");
								}
							}else{
								if(rs.getString("d_en_desc") != null){
									door_desc += " <b> : </b> "+rs.getString("d_en_desc");
								}
							}	
						}else{
							door_desc = "&nbsp;";
						}
						
						if(rs.getString("t_reader_duty") != null){
							if(rs.getString("t_reader_duty").equals("1")){
								reader_duty = lb_statusin;
							}else{
								reader_duty = lb_statusout;
							}
						}else{
							reader_duty = "---";
						}
						duty = rs.getString("duty");						
						
						event_desc = " <b> <span onClick='show_detail3(\""+rs.getString("event_code")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'> "+rs.getString("event_code")+" </span> </b> ";
						if(!(rs.getString("event_code") == null)){
							if(lang.equals("th")){
								if(rs.getString("e_th_desc") != null){
									event_desc += " <b> : </b> "+rs.getString("e_th_desc");
								}
							}else{
								if(rs.getString("e_en_desc") != null){
									event_desc += " <b> : </b> "+rs.getString("e_en_desc");
								}
							}	
						}else{
							event_desc = "&nbsp;";
						}
						
			%> 					
						<tr>
							<td class="pad-left-10"> <%= idcard %> </td>
							<td class="pad-left-10"> <%= emp_name %> </td>
							<td align="center"> <%= date_event %> </td>
							<td align="center"> <%= time_event %> </td>
							<td class="pad-left-10"> <div class="ellipsis_string" style="width: 200px;"> <%= door_desc %> </div> </td>
							<td align="center"> <%= reader_duty %> </td>
							<td align="center"> <%= duty %> </td>
							<td class="pad-left-10"> <div class="ellipsis_string" style="width: 200px;"> <%= event_desc %> </div> </td>
						</tr>
			<%	
					}	rs.close(); 
				}catch(SQLException e){							
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
				}
			%>    		
					</tbody>
				</table>
				
			</div>
		</div>
		<%@ include file="tools/modal_viewdetail.jsp"%>
		
		<script>
		function show_detail1(idcard){
			view_detail.location = 'view_employee.jsp?action=view&idcard='+idcard;
			$('#myModalViewDetail').modal('show');
		}
		
		function show_detail2(door_id){
			view_detail.location = 'view_door.jsp?action=view&door_id='+door_id;
			$('#myModalViewDetail').modal('show');
		}
		
		function show_detail3(event_code){
			view_detail.location = 'view_event.jsp?action=view&event_code='+event_code;
			$('#myModalViewDetail').modal('show');
		}
		</script>
	
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>