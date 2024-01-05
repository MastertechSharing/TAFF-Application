<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 	
	session.setAttribute("action", "monitor_map_detail.jsp?door_id="+request.getParameter("door_id")+"&");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
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
		
		<script language="javascript">
			$(document).ready(function() {
				$('#data_table').dataTable( {
					"aaSorting": [
						[ 2, "desc" ], [ 0, "asc" ]
					],
					"dom": "<fl<t>ip>",	//	<lf<t>ip>
					
					"lengthMenu": [ [ 12, 50, 100, 1000 ], [ 12, 50, 100, 1000 ] ]
					
				<%	if(lang.equals("th")){	%>	
					,"oLanguage": {
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
		</script>
		
	</head>
<% 	
	String door_id = "";	
	if(!request.getParameter("door_id").equals("")){
		door_id = request.getParameter("door_id");
	}
	String doordesc = "";	
	ResultSet rs = null;	
	rs = stmtQry.executeQuery("SELECT * FROM dbdoor WHERE (door_id = '"+door_id+"')");	
	while(rs.next()){	
		if(lang.equals("th")){
			doordesc = rs.getString("th_desc");
		}else{
			doordesc = rs.getString("en_desc");
		}		
	}
	rs.close();
%>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px; padding-bottom: 0cm;">
		
		<div class="row" style="margin-left: 0px; margin-right: 0px;">
			
			<form id="form1" name="form1" method="post">
			
				<table style="min-width: 800px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
					<thead>
						<tr>
							<td width="18%" align="center"> <%= lb_empcode %> </td>
							<td width="23%" align="center"> <%= lb_names %> </td>
							<td width="22%" align="center"> <%= lb_date %> - <%= lb_time %> </td>
							<td width="7%" align="center"> <%= lb_reportstatus %> </td>		
							<td width="30%" align="center"> <%= lb_eventdoor %> </td>
						</tr>
					</thead>
					<tbody>
					<%	
						String sql = "";
						if(mode == 0){
							sql = sql + " SELECT t.idcard, date_event, time_event,t.reader_no,t.event_code, ";
							sql = sql + " CONCAT(e.th_fname,' ',e.th_sname) AS th_name,"
								+ " CONCAT(e.en_fname,' ',e.en_sname) AS en_name,";										   
						}else{
							sql = sql + " SELECT TOP 1000 t.idcard, date_event, time_event,t.reader_no,t.event_code, ";
							sql = sql + " (e.th_fname+' '+e.th_sname) AS th_name,"
								+ " (e.en_fname+' '+e.en_sname) AS en_name,";				
						}			
						sql = sql + "ev.th_desc AS ev_thdesc,ev.en_desc AS ev_endesc "
								+ "FROM view_transaction t "
								+ "LEFT JOIN dbemployee e on (e.idcard = t.idcard) "
								+ "LEFT JOIN dbevent ev on (ev.event_code = t.event_code) "
								+ "WHERE (SUBSTRING(t.reader_no,1,4) = '"+door_id+"') "
								+ "ORDER BY t.workday desc, t.idcard " ;
						if(mode == 0){
							sql = sql + " LIMIT 1000 ";
						}
						
						String id = "";
						String name = "";
						String evt_desc = "";
						String status = "";
						try{
							rs = stmtQry.executeQuery(sql);			
							while(rs.next()){
								String idcard = rs.getString("t.idcard");	
								String event_door = rs.getString("event_code"); 								
								if(lang.equals("th")){
									if(rs.getString("th_name")!= null){
										name = rs.getString("th_name");
									}else{
										name = "&nbsp;";
									}							
									if(rs.getString("ev_thdesc")!= null){
										evt_desc = event_door+" : "+rs.getString("ev_thdesc");
									}else{
										evt_desc = "&nbsp;";
									}
								}else{					
									if(rs.getString("en_name") != null){
										name = rs.getString("en_name");
									}else{
										name = "&nbsp;";
									}					
									if(rs.getString("ev_endesc")!= null){
										evt_desc = event_door+" : "+rs.getString("ev_endesc");
									}else{
										evt_desc = "&nbsp;";
									}
								} 
								String datetime = YMDTodate(rs.getString("date_event"))+" "+rs.getString("time_event");				
								String reader = rs.getString("reader_no");
								if(reader.substring(4,5).equals("0")){
									if(lang.equals("th")){
										status = "ออก";
									}else{
										status = "Out";
									}
								}else{
									if(lang.equals("th")){
										status = "เข้า";
									}else{
										status = "In";
									}
								}		
					%>  	
						<tr>
						<%	if(!idcard.equals(id)){	%>	
							<td class="pad-left-10"> <%= idcard %> </td>
							<td class="pad-left-10"> <%= name %> </td>
						<%	}else{	%>		
							<td> </td>
							<td> </td>
						<%	} %>
							<td align="center"> <%= datetime %> </td>
							<td align="center"> <%= status %> </td>		
							<td class="pad-left-10"> <%= evt_desc %> </td>
						</tr>	
					<%	
								id = idcard;
							}	rs.close();		  
						}catch(SQLException e){
							out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
						}
					%>		
					</tbody>	
				</table>
				
			</form>
			
		</div>
		
	</body>	
</html>

<%@ include file="../function/disconnect.jsp"%>