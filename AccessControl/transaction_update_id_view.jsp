<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<% 
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "others");
	session.setAttribute("subtitle", "trans_updateid_view");
	
	String param_door = "";	
	if(!(request.getParameter("check_door")== null || request.getParameter("check_door").equals("")
		|| request.getParameter("check_door").equals("null"))){		
		param_door = checkValuesList(request.getParameterValues("check_door"));
	}
	session.setAttribute("action", "transaction_update_id_view.jsp?st_date="+request.getParameter("st_date")+"&st_date2="+request.getParameter("st_date2")+"&check_door="+param_door+"&");
%>
<span/>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<script language="javascript" src="js/alert_box.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet"> 	

		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script language="javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script>
			$(document).ready(function() {
				$('#data_reader').dataTable( {
					"aoColumnDefs": [
						{ "orderable": false }
					],
					"aaSorting": [],
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
		</script>
		
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<%@ include file="../tools/modal_danger.jsp"%>		
		
		<div class="body-display">
			<div class="container">
				
				<table style="min-width: 1000px;" id="data_reader" class="table table-striped table-bordered" align="center" id="table1" border="0">
					<thead>
						<tr>
							<td width="10%" align="center"> <b> <%= lb_code %> </b> </td>
							<td width="22%" align="center"> <b> <%= lb_names %> </b> </td>
							<td width="8%" align="center"> <b> <%= lb_date %> </b> </td>
							<td width="8%" align="center"> <b> <%= lb_time %> </b> </td>
							<td width="10%" align="center"> <b> <%= lb_readers %> </b> </td>
							<td width="14%" align="center"> <b> <%= lb_mu_status %> </b> </td>
							<td width="14%" align="center"> <b> <%= lb_cru1_status %> </b> </td>
							<td width="14%" align="center"> <b> <%= lb_cru2_status %> </b> </td>
						</tr>   
					</thead>
					<tbody>
			
<%  
	String stdate = dateToYMD(request.getParameter("st_date"));
	String stdate2 = dateToYMD(request.getParameter("st_date2"));	
	if(stdate.compareTo(stdate2) > 0){
		out.println("<script>alert('"+msg_date_notvalid+"'); history.back();</script>");
	}
	
	String emp_id = "";
	if(!(request.getParameter("emp_id") == null || request.getParameter("emp_id").equals("")
		|| request.getParameter("emp_id").equals("null"))){
		emp_id = request.getParameter("emp_id"); 	
	}	
	
	String check_door = "";
	String[] check_door_id = null;
	if(request.getParameterValues("check_door") != null){
		check_door_id = request.getParameterValues("check_door");
		if((check_door_id.length-1) == 0){
			String chk_door = request.getParameter("check_door");
			chk_door = chk_door.replace("$",",");
			check_door_id = chk_door.split(",");
		} 
		
		for(int i = 0; i <= check_door_id.length-1; i++){
			if(i != check_door_id.length-1){
				check_door = check_door+check_door_id[i] +"$";
			}else{
				check_door = check_door+check_door_id[i];
			}	   
		}
	}
		
	//	Check Employee By User	========================================================================
	boolean check_employee = true;
	if(checkPermission(ses_per, "1256") && (!(emp_id.equals("")))){
		String sql_check = "";
		if(checkPermission(ses_per, "12")){
			sql_check = selectCheckEmployeesOfUserManager(ses_user, emp_id);
		}else if(checkPermission(ses_per, "56")){
			sql_check = selectCheckEmployeesOfUserSupervisor(ses_user, emp_id);
		}
		ResultSet rs_check = stmtQry.executeQuery(sql_check);
		while(rs_check.next()){
			if(rs_check.getInt("c_idcard") == 0){
				out.println("<script> ModalDanger_10Second('"+lb_empcode+" "+emp_id+" "+msg_employee_notvalid+"'); </script>");
				check_employee = false;
			}
		}	rs_check.close();
	}
	
	if(check_employee){
	
		String sql = "SELECT tev.idcard, tev.date_event, tev.time_event, tev.reader_no, tev.data_blank, "
				+ "SUBSTRING(tev.data_blank,1,1) AS mu, SUBSTRING(tev.data_blank,2,1) AS cru1, SUBSTRING(tev.data_blank,3,1) AS cru2, ";
		if(lang.equals("th")){
			sql = sql + "emp.th_fname AS emp_fname, emp.th_sname AS emp_sname ";
		}else{
			sql = sql + "emp.en_fname AS emp_fname, emp.en_sname AS emp_sname ";
		}
		sql = sql + "FROM dbtransaction_ev tev "
				+ "LEFT OUTER JOIN dbemployee emp ON (emp.idcard = tev.idcard) "
				+ "WHERE (event_code = '47') AND (date_event >= '"+stdate+"' AND date_event <= '"+stdate2+"') ";						
		if(!(emp_id == null || emp_id.equals("") || emp_id.equals("null"))){
			sql = sql + "AND (tev.idcard = '"+emp_id+"') ";
		}					
		for(int i = 0; i <= check_door_id.length-1; i++){
			if(i==0){
				sql = sql + "AND (";
			}
			if(i != check_door_id.length-1){
				sql = sql +"(reader_no = '"+check_door_id[i]+"') OR ";
			}else{
				sql = sql +"(reader_no = '"+check_door_id[i]+"')) ";
			}
		}
		sql = sql + "ORDER BY tev.idcard, tev.date_event, tev.time_event, tev.reader_no";
		String idcard = "";	
		String reader_no = "";
		int count_rec = 0;
		try{
			ResultSet rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				if(bgc.equals(rowstyle1)){
					bgc = rowstyle2;
				}else if (bgc.equals(rowstyle2)){
					bgc = rowstyle1;
				}			
				if(!(rs.getString("idcard").equals("") || rs.getString("idcard") == null)){
					idcard = "<b> <span onClick='show_detail1(\""+rs.getString("idcard")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'> "+rs.getString("idcard")+" </span> </b> ";
				}
				if(!(rs.getString("reader_no").equals("") || rs.getString("reader_no") == null)){
					reader_no = "<b> <span onClick='show_detail2(\""+rs.getString("reader_no")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'> "+rs.getString("reader_no")+" </span> </b> ";
				}
				String emp_name = "";
				if(rs.getString("emp_fname") != null){
					emp_name += rs.getString("emp_fname") + " ";
				}
				if(rs.getString("emp_sname") != null){
					emp_name += rs.getString("emp_sname");
				}
%>		
						<tr>
							<td class="pad-left-10"> <%= idcard %> </td>
							<td class="pad-left-10"> <%= emp_name %> </td>
							<td align="center"> <%= YMDTodate(rs.getString("date_event")) %> </td>
							<td align="center"> <%= rs.getString("time_event") %> </td>
							<td align="center"> <%= reader_no %> </td>
							<td class="pad-left-10"> <%= showTransBlank3(rs.getString("mu")) %> </td>
							<td class="pad-left-10"> <%= showTransBlank3(rs.getString("cru1")) %> </td>
							<td class="pad-left-10"> <%= showTransBlank3(rs.getString("cru2")) %> </td>
						</tr>
<% 
			}
			rs.close();		
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
		}
	}
%>
					</tbody>
				</table>
				
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_detail" name="view_detail" frameborder="0" height="400px" style="min-width: 100%;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>	
		
		<script>
		function show_detail1(idcard){
			view_detail.location = 'view_employee.jsp?action=view&idcard='+idcard;
			$('#myModalViewDetail').modal('show');
		}
		
		function show_detail2(reader_no){
			view_detail.location = 'view_reader.jsp?action=view&reader_no='+reader_no;
			$('#myModalViewDetail').modal('show');
		}
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>