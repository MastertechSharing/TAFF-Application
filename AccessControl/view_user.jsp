<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
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
		
		<style>		
			.ellipsis_string {
			  white-space: nowrap;
			  overflow: hidden;
			  text-overflow: ellipsis;
			}
			
			table, tr, td {
			  padding: 3px !important;
			  padding-bottom: 2px !important;
			}
		
			.pad-left-10 { padding-left: 10px !important; }
			
			.pull-right { float: right; }
			.pull-left { float: left; }

			.max-height-24 { max-height: 24px; }
			.min-width-80 { min-width: 80px; }
		</style>
		
		<script language="javascript">
			function Load_DataTable(){
				$(document).ready(function() {
					$('#data_table').dataTable( {
						"aoColumnDefs": [
							{ "bSortable": false, "aTargets": [ ] }
						],
						"aaSorting": [
							[ 0, "asc" ]
						],
						"dom": "<fl<t>ip>",	//	<lf<t>ip>						
							
					<%	if(lang.equals("en")){	%>	
							"lengthMenu": [ [ 5, 50, 100, -1 ], [ 5, 50, 100, "All" ] ]
					<%	}else if(lang.equals("th")){	%>	
							"lengthMenu": [ [ 5, 50, 100, -1 ], [ 5, 50, 100, "ทั้งหมด" ] ],
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
		</script>
		
	</head>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
<% 	
	boolean chk_dbusers = false;
	String action = request.getParameter("action");
	String user_name = request.getParameter("user_name");
	String ur = "";
	if (action.equals("view")){
		
		String col1 = "col-xs-3 col-md-3";
		String col2 = "col-xs-4 col-md-4";
		String col3 = "col-xs-2 col-md-2";
		String col4 = "col-xs-3 col-md-3";
		String col_line = "col-xs-12";
		String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
		
		String sql = "";
		if(mode == 0){
			sql = "SELECT DATE_FORMAT(st_date,'%d/%m/%Y') AS stdate_show, "
					+ "DATE_FORMAT(ex_date,'%d/%m/%Y') AS exdate_show, ";
		}else if(mode == 1){
			sql = "SELECT CONVERT(varchar(10),st_date,103) AS stdate_show, "
					+ "CONVERT(varchar(10),ex_date,103) AS exdate_show, ";
		}
		if(lang.equals("th")){
			sql += "dep.th_desc AS dep_desc, sec.th_desc AS sec_desc, ";
		}else{
			sql += "dep.en_desc AS dep_desc, sec.en_desc AS sec_desc, ";
		}
		sql = sql + " u.* "
				+ "FROM dbusers u "
				+ "LEFT OUTER JOIN dbdepart dep ON (dep.dep_code = u.dep_code) "
				+ "LEFT OUTER JOIN dbsection sec ON (sec.sec_code = u.sec_code) "
				+ "WHERE (u.user_name = '"+user_name+"') ";
				
		try{
			ResultSet rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				chk_dbusers = true;
				user_name = rs.getString("user_name");
				String user_right = displayUser(rs.getString("user_right"));
				String st_date = rs.getString("stdate_show");
				String ex_date = rs.getString("exdate_show");
				String dep_code = rs.getString("dep_code");
				String sec_code = ""; 
				String dep_code_desc = "-";
				String sec_code_desc = "-";
				String monitor_data = rs.getString("monitor_data");
				String monitor_data_img = "checkbox_un";
				if(monitor_data.equals("1")){
					monitor_data_img = "checkbox_ch";
				}
				
				if(!(dep_code.equals("0") || dep_code.equals("") || dep_code.equals("null"))){
					if(rs.getString("dep_desc") != null)
						dep_code_desc = dep_code+" : "+rs.getString("dep_desc");
				}
				
				if(rs.getString("sec_code") != null){
					sec_code = rs.getString("sec_code");
					if(!(sec_code.equals("0") || sec_code.equals("") || sec_code.equals("null"))){
						if(rs.getString("sec_desc") != null)
							sec_code_desc = sec_code+" : "+rs.getString("sec_desc");
					}
				}
				
				ur = rs.getString("user_right");
				String group_user = "-";
				String[] control_reader = new String[0];
				String amount_reader = "-", display_amount_reader = "-";
				if(ur.equals("1") || ur.equals("2") || ur.equals("5") || ur.equals("6")){
					group_user = rs.getString("group_user");
					control_reader = rs.getString("control_reader").split(",");
					
					if(control_reader[0].length() == 0){
						amount_reader = "0";
						display_amount_reader = "0";
					}else{
						amount_reader = Integer.toString(control_reader.length);
						display_amount_reader = Integer.toString(control_reader.length);
					}
					if(group_user.equals("")){
						group_user = "-";
						display_amount_reader = "-";
					}
				}
				
%>
	<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto;">
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_username %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= user_name %> </h5>
				<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_std %> : </b> </div> </h5>
				<h5 class="modal-title <%= col4 %>" > <%= st_date %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_permission %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= user_right %> </h5>
				<h5 class="modal-title <%= col3 %>" > <div align="right"> <b> <%= lb_exd %> : </b> </div> </h5>
				<h5 class="modal-title <%= col4 %>" > <%= ex_date %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_departcode %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-6 col-md-6" > <div class="ellipsis_string" style="width: 95%"> <%= dep_code_desc %> </div> </h5>
				<h5 class="modal-title <%= col4 %>" > 
					<img src="images/<%= monitor_data_img %>.png" width="16" height="16" align="absmiddle" style="margin-top: -8px;"> &nbsp;
					<label> Monitor Data </label> 
				</h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_seccode %> : </b> </div> </h5>
				<h5 class="modal-title col-xs-9 col-md-9" > <div class="ellipsis_string" style="width: 95%"> <%= sec_code_desc %> </div> </h5>
			</div>
			<%= set_hr %>
			<div class="row" style="margin-top: -4px;">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_group_rights_assign %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= group_user %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_amount_reader %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= display_amount_reader %> </h5>
			</div>
			
		<%	if(!amount_reader.equals("-")){	%>
		
			<%= set_hr %>
			<div class="row">
				<div class="modal-title col-xs-12 col-md-12">
					<center>
					<div class="table-responsive" style="border: 0px !important; max-width: 97%;"  border="0">
						<div style="min-width: 800px;" class="table" border="0">	
							<table style="min-width: 800px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
								<thead>
									<tr>
										<td width="20" align="center"> <%= lb_readerno %> </td>
										<td width="40%" align="center"> <%= lb_description %> </td>
										<td width="40%" align="center"> <%= lb_doorcode %> </td>
									</tr>
								</thead>
								<tbody>
							<%	if(!amount_reader.equals("0")){
									try{
										String where_reader_list = "";
										for(int i = 0; i < control_reader.length; i++){
											where_reader_list += " reader_no = '" + control_reader[i] +"' " ;
											if(i < (control_reader.length -1)){
												where_reader_list += " OR ";
											}
										}

										sql = " SELECT rd.reader_no, rd."+lang+"_desc AS reader_desc, rd.door_id, door."+lang+"_desc AS door_desc "
											+ " FROM dbreader rd LEFT JOIN dbdoor door ON (door.door_id = rd.door_id) "
											+ " WHERE " + where_reader_list ;
										ResultSet rs_rd = stmtTmp.executeQuery(sql);
										while (rs_rd.next()) {
											String reader_no = rs_rd.getString("reader_no");
											String reader_desc = rs_rd.getString("reader_desc");	
											String door_id = rs_rd.getString("door_id");
											String door_desc = "";	
											if(rs_rd.getString("door_desc") != null){
												door_desc = " - " + rs_rd.getString("door_desc");
											}
							%>		<tr>
										<td> <center> <b> <%= reader_no %> </b> </center> </td>
										<td> <div class="ellipsis_string" style="max-width: 280px;"> <span class="pad-left-10"> <%= reader_desc %> </span> </div> </td>
										<td> <div class="ellipsis_string" style="max-width: 280px;"> <span class="pad-left-10"> <b> <%= door_id %> </b> <%= door_desc %> </span> </div> </td>
									</tr>
							<%			}	rs_rd.close();
									}catch (Exception e){ }
								}
							%>
								</tbody>
							</table>
						</div>
					</div>
					</center>
				</div>
			</div>
			
		<%	}	%>
		
		</div>
<%	
			}
			rs.close();
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	}
	
	if(chk_dbusers == false){
		out.println("<script> location.href = 'view_employee.jsp?action=view&idcard="+user_name+"'; </script>");
	}
%>
	</body>
	
	<script>
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				<%	if(ur.equals("1") || ur.equals("5")){	%>
					Load_DataTable();
				<%	}	%>
			}
		}
	</script>
</html>

<%@ include file="../function/disconnect.jsp"%>