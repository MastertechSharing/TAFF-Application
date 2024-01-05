<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="../css/taff.css" type="text/css">
		<!-- Bootstrap -->
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		<link href="../css/alert-messages.css" rel="stylesheet">
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="../js/jquery.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
		<script language="javascript" src="../js/alert_box.js"></script> 
		
	</head>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<%@ include file="../tools/modal_danger.jsp"%>
		
		<form id="form1" name="form1" method="post">
		<div class="modal fade" id="myModalConfirmBlacklist" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-danger">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 20px;"> <span id="glyphicon_save" class="glyphicon glyphicon-ban-circle alert-message-danger" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 20px;"> <h4> <p id="text_confirm_add"> </p> </h4> </div>
							
							<div class="col-xs-12 col-md-12" style="margin-bottom: 0px;">
								<strong>
									<div class="alert alert-warning" role="alert" style="min-width: 50px;">
										<div class="row">
											<div class="col-xs-12 col-md-12" align="left"> <%= lb_blacklist_detail2 %> : <span id="text_detail"> </span> </div>
										</div>
										<div class="row" id="more250" style="display: none;">
											<br/>
											<div class="col-xs-12 col-md-12" align="right"> <font style="color: #C53430;"> * <%= alert_detail_over250 %> </font> </div>
										</div>
									</div>
								</strong>
							</div>
							
							<div class="col-xs-12 col-md-12" id="old_detail" style="margin-bottom: 0px; display: none;">
								<strong>
									<div class="alert alert-warning" role="alert" style="min-width: 50px;">
										<div class="row">
											<div class="col-xs-12 col-md-12" align="left"> <%= lb_blacklist_detail_cancel %> : <span id="text_detail_cancel"> </span> </div>
										</div>
										<div class="row">
											<br/>
											<div class="col-xs-12 col-md-12" align="right"> <font style="color: #C53430;"> * <%= lb_blacklist_detail_cancel_clear %> </font> </div>
										</div>
									</div>
								</strong>
							</div>
							
							<div class="col-xs-12 col-md-12" style="margin-bottom: 10px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_ok" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_cancel" onClick="javascript: $('#myModalConfirmBlacklist').modal('hide'); location.href = '../data_blacklist.jsp'" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> 
									<input type="hidden" id="action" name="action" value="add_more" readonly>
									<input type="hidden" id="emp_id" name="emp_id" readonly>
									<input type="hidden" id="record_detail" name="record_detail" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</form>
		
		<script>
			function Confirm_Button(){
				$('#myModalConfirmBlacklist').modal('hide');
				document.form1.action = "act_blacklist.jsp?action=add_more";
				document.getElementById("form1").submit();
			}
		</script>
		
	</body>
</html>
<% 
	String action = request.getParameter("action");
	String idcard = request.getParameter("emp_id");
	
	if (action.equals("del")) {
	/* 	try{
			resultQry = stmtUp.executeUpdate(deleteTable("dbblacklist", "idcard", idcard, "record_date", record_date));
			if (resultQry != 0) {
				session.setAttribute("session_alert", msg_delsuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Delete blacklist idcard : " + idcard + " [dbblacklist]");
				out.println("<script> document.location='../data_blacklist.jsp'; </script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	 */
	} else if (action.equals("clear")) {
		
		String date_data = request.getParameter("date_data");
		String record_date = request.getParameter("record_date");
		try{
			String sql = " UPDATE dbblacklist SET cancel_date = NULL, cancel_by = '', cancel_detail = '', cancel_status = '0' "
					+ " WHERE (idcard = '" + idcard + "' AND record_date = '" + record_date + "')";
			resultQry = stmtUp.executeUpdate(sql);
			if (resultQry != 0) {
				stmtUp.executeUpdate(" UPDATE dbemployee SET group_code = 'groupblacklist' WHERE idcard = '" + idcard + "' ");
				
				rc.WriteDataLogFile("[" + ses_user + "] Delete cancel blacklist idcard : " + idcard + " [dbblacklist]");
				out.println("<script> document.location='../edit_blacklist.jsp?action=edit&idcard="+idcard+"&record_date="+record_date+"'; </script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		
		String sql = "";
		if (action.equals("add")) {
			
			String record_date = getCurrentDateyyyyMMdd();
			String record_detail = new String(request.getParameter("record_detail").getBytes("ISO8859_1"), "tis-620");
			String fullname = new String(request.getParameter("emp_name").getBytes("ISO8859_1"), "tis-620");
			try{
				if (getCountRecord("dbblacklist", "idcard", idcard, "record_date", record_date, stmtQry) == 0) {
					
					String card_id = "";
					ResultSet rs_cardid = stmtQry.executeQuery(" SELECT card_id FROM dbemployee WHERE idcard = '"+idcard+"' ");
					if (rs_cardid.next()) {
						card_id = rs_cardid.getString("card_id");
					}	rs_cardid.close();
					
					sql = " INSERT INTO dbblacklist(idcard, record_date, record_by, record_detail, card_id) "
						+ " VALUES ('" + idcard + "', '" + record_date + "', '" + ses_user + "', '" + record_detail + "', '" + card_id + "')";
					resultQry = stmtUp.executeUpdate(sql);
					if (resultQry != 0) {
						stmtUp.executeUpdate(" UPDATE dbemployee SET group_code = 'groupblacklist' WHERE idcard = '" + idcard + "' ");
						
						//	Update fullname in dbblacklist
						ResultSet rs = stmtQry.executeQuery("SELECT th_fname, th_sname, en_fname, en_sname FROM dbemployee WHERE (idcard = '" + idcard + "') ");
						if (rs.next()) {
							if(!(rs.getString("th_fname").equals(""))){
								fullname = rs.getString("th_fname")+" "+rs.getString("th_sname");
							}else{
								fullname = rs.getString("en_fname")+" "+rs.getString("en_sname");
							}
							stmtUp.executeUpdate(" UPDATE dbblacklist SET fullname = '"+fullname+"' WHERE idcard = '" + idcard + "' AND record_date = '" + record_date + "' ");
						}else{
							stmtUp.executeUpdate(" UPDATE dbblacklist SET fullname = '"+fullname+"' WHERE idcard = '" + idcard + "' AND record_date = '" + record_date + "' ");
						}
						
						rc.WriteDataLogFile("[" + ses_user + "] Blacklist idcard : " + idcard + " [dbblacklist]");
						out.println("<script> document.location='../edit_blacklist.jsp?action=add'; </script>");
					}
				} else {
				//	out.println("<script> ModalDanger_NoTimeout('" + msg_dupblacklist1 +" "+ idcard +" "+ msg_dupblacklist2 + "'); </script>");
					
					String cancel_date = "", cancel_detail = "", more250 = "", old_detail = "", old_detail_text = "";
					sql = " SELECT record_detail, cancel_date, cancel_detail FROM dbblacklist bl WHERE (bl.idcard = '"+idcard+"' AND record_date = '"+record_date+"') ";	
					ResultSet rs2 = stmtQry.executeQuery(sql);
					if(rs2.next()){
						record_detail = rs2.getString("record_detail") + " " + record_detail ;
						cancel_date = rs2.getString("cancel_date");
						cancel_detail = rs2.getString("cancel_detail");
					}	rs2.close();
					
					if(record_detail.length() > 250){
						record_detail = record_detail.substring(0, 250);
						more250 = "$('#more250').show();";
					}
					
					if(cancel_date != null){
						old_detail = "$('#old_detail').show();";
						old_detail_text = "$('#text_detail_cancel').text('"+cancel_detail+"');";
					}
					out.println("<script> $('#myModalConfirmBlacklist').modal('show'); "
							+ " $('#emp_id').val('"+idcard+"'); "
							+ " $('#record_detail').val('"+record_detail+"'); "
							+ " $('#text_confirm_add').text('"+msg_confirmsave_blacklist2+"'); "
							+ " $('#text_detail').text('"+record_detail+"'); "
							+   more250 + old_detail + old_detail_text + " </script>");
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("add_more")) {
			
			String record_date = getCurrentDateyyyyMMdd();
			String record_detail = new String(request.getParameter("record_detail").getBytes("ISO8859_1"), "tis-620");
			try{
				
				sql = " UPDATE dbblacklist SET record_by='"+ses_user+"', record_detail='"+record_detail+"', "
					+ " cancel_date = NULL, cancel_by = '', cancel_detail = '', cancel_status = '0' "
					+ " WHERE (idcard = '" + idcard + "' AND record_date = '" + record_date + "')";
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					stmtUp.executeUpdate(" UPDATE dbemployee SET group_code = 'groupblacklist' WHERE idcard = '" + idcard + "' ");
					
					rc.WriteDataLogFile("[" + ses_user + "] Update blacklist idcard : " + idcard + " [dbblacklist]");
					out.println("<script> document.location='../edit_blacklist.jsp?action=add'; </script>");
				}
				
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
			
		}else if (action.equals("edit")) {
			String record_date = request.getParameter("record_date");
			String cancel_date = getCurrentDateyyyyMMdd();
			String cancel_detail = new String(request.getParameter("cancel_detail").getBytes("ISO8859_1"), "tis-620");
			String group_code = request.getParameter("group_code");
			try{
				sql = " UPDATE dbblacklist SET cancel_date = '" + cancel_date + "', cancel_by = '" + ses_user + "' "
					+ " , cancel_detail = '" + cancel_detail + "', cancel_status = '1' "
					+ " WHERE (idcard = '" + idcard + "' AND record_date = '" + record_date + "')";
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					if(!group_code.equals("99")){
						stmtUp.executeUpdate(" UPDATE dbemployee SET group_code = '"+group_code+"' WHERE idcard = '" + idcard + "' ");
						
						session.setAttribute("session_alert", msg_cancel_success);
						rc.WriteDataLogFile("[" + ses_user + "] Cancel blacklist idcard : " + idcard + " [dbblacklist]");
						out.println("<script>document.location='../data_blacklist.jsp';</script>");
					}else{
						String groupCodeAdd = padKeyLeft(idcard, 13, "0");
						stmtUp.executeUpdate(" UPDATE dbemployee SET group_code = '"+groupCodeAdd+"' WHERE idcard = '" + idcard + "' ");
						
						sql = " INSERT INTO dbgroup (group_code, th_desc, en_desc) "
							+ " VALUES ('"+ groupCodeAdd + "','กลุ่มที่กำหนดเฉพาะแต่ละบุคคล','Specifically defined group') ";
						resultQry = stmtUp.executeUpdate(sql);
						response.sendRedirect("../edit_zonegroup.jsp?action=add&group_code=" + groupCodeAdd);
					}
				}
			}catch (SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		}
	}
%>

<%@ include file="../function/disconnect.jsp"%>	