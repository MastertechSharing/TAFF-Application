<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.io.FileUtils"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<%	
	String idcard = "";
	if(request.getParameter("idcard") != null && request.getParameter("idcard") != ""){
		idcard = request.getParameter("idcard").toUpperCase();
	}
%>
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
		
		<script language="javascript">
			function Confirm_Button(){
				location.href = "../cmd_set_idtable.jsp?idcard=<%= request.getParameter("idcard") %>";
			}
			function Confirm_Cancel(){
			<%	if(request.getParameter("action").equals("add")){	%>
				location.href = "../edit_employee.jsp?action=add";
			<%	}else{	%>
				location.href = "../data_employee.jsp";
			<%	}	%>
			}
		</script>
	</head>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<%@ include file="../tools/modal_danger.jsp"%>
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_save" class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <%= lb_to_page_cmd80_44 %> <br/> <br/> [ <%= lb_menu %> ] <%= lb_config %> / <%= lb_empdata %> / <%= lb_cmd80_44 %> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_ok" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_cancel" onClick="Confirm_Cancel();" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> 
									<input type="hidden" id="text_label" name="text_label" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalConfirmDelBlacklist" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_confirm" class="modal-content alert-message alert-message-danger">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; " border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_confirm" class="glyphicon glyphicon-trash alert-message-danger" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> <%= msg_confirmdel %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px; display: ;" id="display_name">
								<strong>
									<div class="alert alert-warning" role="alert" style="min-width: 50px;">
										<div class="row">
											<div class="col-xs-12 col-md-12" align="center">
												<span style="font-color: #C53430; font-size: 16px;">
													<span style="font-size: 24px;"> <i class="glyphicon glyphicon-warning-sign"> </i> </span> 
													&nbsp; <%= lb_blacklist_employee %> 
												</span>
											</div>
										</div>
									</div>
								</strong>
							</div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_delbl" onClick="javascript: document.location='act_employee.jsp?action=delblacklist&idcard=<%= idcard %>';" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_cancelbl" onClick="javascript: document.location='../data_employee.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> 
									<input type="hidden" id="text_label" name="text_label" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</body>
</html>
<%	
	String username = (String) session.getAttribute("ses_username");
	String action = request.getParameter("action");
	
	String sql = "";
	if (action.equals("clearall")) {
		try {
			String convert_pass = convertPassField("idcard", mode);
			if (ses_per == 1) {
				if (mode == 0) {
					sql = "UPDATE dbemployee emp " 
							+ "INNER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
							+ "INNER JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
							+ "INNER JOIN dbusers users ON (users.dep_code = dep.dep_code) "
							+ "SET emp.pass_word = " + convert_pass + " "
							+ "WHERE (users.user_name = '" + ses_user + "') ";
				} else {
					sql = "UPDATE dbemployee SET pass_word = " + convert_pass + " "
							+ "FROM dbemployee emp "
							+ "INNER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
							+ "INNER JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
							+ "INNER JOIN dbusers users ON (users.dep_code = dep.dep_code) "
							+ "WHERE (users.user_name = '" + ses_user + "') ";
				}
			} else if (ses_per == 0) {
				sql = "UPDATE dbemployee SET pass_word = " + convert_pass;
			}
			resultQry = stmtUp.executeUpdate(sql);
			if (resultQry != 0) {
				session.setAttribute("session_alert", msg_clearAllComp);
				rc.WriteDataLogFile("[" + ses_user + "] Clear all password idcard [dbemployee]");
				out.println("<script> document.location='../data_employee.jsp';</script>");
			}
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else if (action.equals("clear")) {
		try {
			sql = "UPDATE dbemployee SET pass_word = "+convertPassValue(idcard, mode)+" WHERE (idcard = '" + idcard + "')";
			resultQry = stmtUp.executeUpdate(sql);
			if (resultQry != 0) {
				session.setAttribute("session_alert", msg_clearPwSuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Clear password idcard : " + idcard + " [dbemployee]");
				out.println("<script> document.location='../data_employee.jsp';</script>");
			}
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}	
	} else if (action.equals("dels")) {	//	เมนูงานพิเศษ/ลบข้อมูล/ข้อมูลพนักงาน [มีเงื่อนไข]
		String grp_code = request.getParameter("groupCode");
		String sect_code = request.getParameter("secCode");
		String st_date1 = request.getParameter("stdate");
		String st_date2 = request.getParameter("stdate2");
		String ex_date1 = request.getParameter("exdate");
		String ex_date2 = request.getParameter("exdate2");
		String valuechk = request.getParameter("valuechk");
		String emp_id = request.getParameter("emp_id");
		
		String check_CodeEmp = "";
		String[] check_emp_id = null;
		String[] param_value_emp;
		if (request.getParameterValues("idcard") != null) {
			check_emp_id = request.getParameterValues("idcard");
			for (int i = 0; i <= check_emp_id.length - 1; i++) {
				if (i != check_emp_id.length - 1) {
					check_CodeEmp = check_CodeEmp + check_emp_id[i] + ",";
				} else {
					check_CodeEmp = check_CodeEmp + check_emp_id[i];
				}
			}
		}
		
		if (!(check_CodeEmp == null || check_CodeEmp.equals(""))) {
			sql = " WHERE (";
			param_value_emp = check_CodeEmp.split(",");
			for (int i = 0; i < param_value_emp.length; i++) {
				sql = sql + " (idcard = '" + param_value_emp[i] + "') ";
				if (i != param_value_emp.length - 1) {
					sql = sql + "OR";
				}
			}
			sql = sql + ")";
		}
		try {
			resultQry = stmtUp.executeUpdate("DELETE FROM dbemployee "+sql);
			if (resultQry != 0) { 
				resultQry = stmtUp.executeUpdate("DELETE FROM dbtransaction "+sql);
				resultQry = stmtUp.executeUpdate("DELETE FROM dbtransaction_ev "+sql);
				
				session.setAttribute("session_alert", msg_delsuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Delete idcard : " + idcard
						+ " [dbemployee],[dbtransaction],[dbtransaction_ev]");
				out.println("<script>document.location='../delete_employee_view.jsp?groupCode=" + grp_code + "&secCode="
						+ sect_code + "&emp_id=" + emp_id + "&stdate=" + st_date1 + "&stdate2=" + st_date2 + "&exdate="
						+ ex_date1 + "&exdate2=" + ex_date2 + "&valuechk=" + valuechk + "&';</script>");
			}
		} catch (SQLException e) {
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else if (action.equals("del")) {
		
		try {
			sql = " SELECT COUNT(idcard) AS count_id FROM dbblacklist WHERE idcard = '"+idcard+"' AND cancel_status = '0' ";
			ResultSet rs = stmtTmp.executeQuery(sql);
			while (rs.next()) {
				if(rs.getString("count_id").equals("0")){
					
					String group_get = "";
					ResultSet rs_chk = stmtQry.executeQuery("SELECT group_code FROM dbemployee WHERE (idcard = '" + idcard + "') ");
					while (rs_chk.next()) {
						group_get = rs_chk.getString("group_code");
					}	rs_chk.close();
					
					if (group_get.length() == 13) {
						stmtUp.executeUpdate(deleteTable("dbgroup","group_code",group_get));
						stmtUp.executeUpdate(deleteTable("dbzone_group","group_code",group_get));
					}
					// count idcard FROM dbtransaction and dbtransactio _ev
					if (getCountRecord("dbtransaction","idcard",idcard,stmtQry) == 0) {
						if (getCountRecord("dbtransaction_ev","idcard",idcard,stmtQry) == 0) {
							resultQry = stmtUp.executeUpdate(deleteTable("dbemployee","idcard",idcard));
							if (resultQry != 0) {
								session.setAttribute("session_alert", msg_delsuccess);
								rc.WriteDataLogFile("[" + ses_user + "] Delete idcard : " + idcard + " [dbemployee]");
								out.println("<script>document.location='../data_employee.jsp';</script>");
							}
						} else {
							out.println("<script>ModalDanger_NoTimeout_Link('" + msg_emp_trans_ev +"', '../data_employee.jsp');</script>");
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout_Link('" + msg_emp_trans +"', '../data_employee.jsp');</script>");
					}
				 
				}else{
				//	out.println("<script>ModalDanger_NoTimeout_Link('" + lb_empcode+" "+idcard+" "+lb_emp_blacklist+"<br/><br/>"+lb_cannot_delemployee +"', '../data_employee.jsp');</script>");
					out.println("<script> $('#myModalConfirmDelBlacklist').modal('show'); </script> ");
				}
			}	rs.close();
			
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		
	} else if (action.equals("delblacklist")) {
		
		try {
			String group_get = "";
			ResultSet rs_chk = stmtQry.executeQuery("SELECT group_code FROM dbemployee WHERE (idcard = '" + idcard + "') ");
			while (rs_chk.next()) {
				group_get = rs_chk.getString("group_code");
			}	rs_chk.close();
			
			if (group_get.length() == 13) {
				stmtUp.executeUpdate(deleteTable("dbgroup","group_code",group_get));
				stmtUp.executeUpdate(deleteTable("dbzone_group","group_code",group_get));
			}
			// count idcard FROM dbtransaction and dbtransactio _ev
			if (getCountRecord("dbtransaction","idcard",idcard,stmtQry) == 0) {
				if (getCountRecord("dbtransaction_ev","idcard",idcard,stmtQry) == 0) {
					resultQry = stmtUp.executeUpdate(deleteTable("dbemployee","idcard",idcard));
					if (resultQry != 0) {
						session.setAttribute("session_alert", msg_delsuccess);
						rc.WriteDataLogFile("[" + ses_user + "] Delete idcard : " + idcard + " [dbemployee]");
						out.println("<script>document.location='../data_employee.jsp';</script>");
					}
				} else {
					out.println("<script>ModalDanger_NoTimeout_Link('" + msg_emp_trans_ev +"', '../data_employee.jsp');</script>");
				}
			} else {
				out.println("<script>ModalDanger_NoTimeout_Link('" + msg_emp_trans +"', '../data_employee.jsp');</script>");
			}
			
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		
	} else if (action.equals("check_file")) {
		
		int sum_photo = 0, sum_template = 0;
		
		//	ReCheck File Exists == false
		ResultSet rs = stmtQry.executeQuery(" SELECT idcard, photo, template FROM dbemployee WHERE photo = '1' OR template = '1' ");
		while (rs.next()) {
			idcard = rs.getString("idcard");
			if(rs.getString("photo").equals("1")){
				if((new File(path_EmpPic + idcard + ".jpg").exists() == false)){
					stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '0' WHERE idcard = '"+idcard+"' ");
				}
			}
			if(rs.getString("template").equals("1")){
				if(new File(path_tpl + idcard + ".DAT").exists() == false){
					stmtUp.executeUpdate(" UPDATE dbemployee SET template = '0' WHERE idcard = '"+idcard+"' ");
				}
			}
		}	rs.close();
		
		//	Check File Photo
		File[] list_photo = new File(path_EmpPic).listFiles();
		for(int i = 0; i < list_photo.length; i++){
			if(list_photo[i].isFile()){
				String files = list_photo[i].getName();
				if (files.endsWith(".jpg") || files.endsWith(".JPG")) {
					try{
						resultQry = stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '1' WHERE idcard = '"+files.substring(0, files.lastIndexOf("."))+"' ");
						if(resultQry != 0)
							sum_photo++;
						
					}catch(SQLException e){
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
					}
					
				}
			}
		}
		
		//	Check File TPL
		File[] list_tpl = new File(path_tpl).listFiles();
		for(int i = 0; i < list_tpl.length; i++){
			if(list_tpl[i].isFile()){
				String files = list_tpl[i].getName();
				if (files.endsWith(".dat") || files.endsWith(".DAT")) {
					try{
						resultQry = stmtUp.executeUpdate(" UPDATE dbemployee SET template = '1' WHERE idcard = '"+files.substring(0, files.lastIndexOf("."))+"' ");
						if(resultQry != 0)
							sum_template++;
						
					}catch(SQLException e){
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
					}
					
				}
			}
		}
		
		session.setAttribute("session_alert", " "+lb_res_jpg_tpl+" <br/><br/> "+lb_found_jpg+" "+sum_photo+" "+lb_person2+" <br/><br/> "+lb_found_tpl+" "+sum_template+" "+lb_person2+" ");
		out.println("<script>document.location='../data_employee.jsp';</script>");
		
	} else if (action.equals("copy_file")) {
	
		//	Copy file from photos/tmpCapture to photos/ && delete file tmp
		try {
			File tmpFile = new File(getServletContext().getRealPath("/") + "photos\\tmpCapture\\CaptureBy-"+username+".jpg");
			File newFile = new File(getServletContext().getRealPath("/") + "photos\\"+idcard+".jpg");
			FileUtils.copyFile(tmpFile, newFile);
			//	delete file tmpCapture
			new File(getServletContext().getRealPath("/") + "photos\\tmpCapture\\CaptureBy-"+username+".jpg").delete();
			
			if((new File(getServletContext().getRealPath("/")+"photos/" + idcard + ".jpg").exists() == true)){
				stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '1' WHERE idcard = '"+idcard+"' ");
			}
		} catch (Exception ef) { }
			
	} else {
		//face
		String face_sncard = request.getParameter("face_sncard").toUpperCase();
		String face_pincode = request.getParameter("face_pincode");
		String face_identifymode = request.getParameter("face_identifymode");
		/////////
		
		int sex = Integer.parseInt(request.getParameter("sex"));
		int prefix = Integer.parseInt(request.getParameter("prefix"));
		String th_fname = new String(request.getParameter("th_fname").getBytes("ISO8859_1"), "tis-620");
		String th_sname = new String(request.getParameter("th_sname").getBytes("ISO8859_1"), "tis-620");
		String en_fname = new String(request.getParameter("en_fname").getBytes("ISO8859_1"), "tis-620");
		String en_sname = new String(request.getParameter("en_sname").getBytes("ISO8859_1"), "tis-620");
		String nationality = new String(request.getParameter("nationality").getBytes("ISO8859_1"), "tis-620");
		String emp_card = request.getParameter("emp_card");
		String sncard = request.getParameter("sn_card").toUpperCase();
		String card_id = request.getParameter("card_id");
		String phoneno = request.getParameter("phone_no");
		String email = request.getParameter("email");
		String issue = request.getParameter("issue");
		String pincode = request.getParameter("pincode");
		String st_date = request.getParameter("st_date");
		String ex_date = request.getParameter("ex_date");
		String hh1 = request.getParameter("hh1");
		String mm1 = request.getParameter("mm1");
		String hh2 = request.getParameter("hh2");
		String mm2 = request.getParameter("mm2");
		String sec_code = request.getParameter("sec_code");
		String pos_code = request.getParameter("pos_code");
		String type_code = request.getParameter("type_code");
		String group_code = request.getParameter("group_code");
		String use_finger = "0";
		if (request.getParameter("use_finger") != null) { use_finger = "1"; }
		String usemapcard = "0";
		if (request.getParameter("use_map_card") != null) { usemapcard = "1"; }
		String user_password = getPassword(idcard,stmtQry,mode);
		String date_updates = "";
		if (mode == 0) {
			date_updates = "'" + getCurrentDateTime() + "'";
		} else {
			date_updates = "CONVERT(datetime,'" + getCurrentDateTime() + "',120)";
		}
		String date_current = getCurrentDateyyyyMMdd();
		// check input format data
		// card id x-xxxx-xxxxx-xx-x
		String chk_cardid = card_id;
		if (!(card_id.equals("") || card_id.equals("null") || (card_id.length() == 13))) {
			card_id = subStrPublicID(card_id);
			chk_cardid = card_id;
		}else{
			if(chk_cardid.equals("")){
				chk_cardid = "****";
			}
		}
		// phoneno xxx-xxx-xxxx
		if (!(phoneno.equals("") || phoneno.equals("null") || (phoneno.length() == 10))) {
			phoneno = subStrPhone(phoneno);
		}
		String stdate = dateToYMD(st_date);
		String exdate = dateToYMD(ex_date);
		String st_time = padKeyLeft(hh1, 2, "0") + ":" + padKeyLeft(mm1, 2, "0");
		String ex_time = padKeyLeft(hh2, 2, "0") + ":" + padKeyLeft(mm2, 2, "0");
		
		boolean dup_sncard = false;
		boolean dup_cardid = false;		
		if (action.equals("add")) {
			try {
				
				sql = " SELECT COUNT(idcard) AS count_id FROM dbblacklist WHERE (card_id = '"+chk_cardid+"' AND cancel_status = '0') ";
				ResultSet rs = stmtTmp.executeQuery(sql);
				while (rs.next()) {
					if(rs.getString("count_id").equals("0")){
				
						sql = " SELECT COUNT(idcard) AS count_id FROM dbblacklist WHERE (idcard = '"+idcard+"' AND cancel_status = '0')";
						ResultSet rs2 = stmtSes.executeQuery(sql);
						while (rs2.next()) {
							if(rs2.getString("count_id").equals("0")){
								
								if (getCountRecord("dbemployee","idcard",idcard,stmtQry) == 0) {
									
									//	Check Duplicate sn_card
									if(!sncard.equals("")){
										if (getSerialCountRecord(sncard,date_current,stmtQry) != 0) {																										
											dup_sncard = true;
										}
									}
									
									//	Check Duplicate card_id
									if(!card_id.equals("")){
										if (getCountRecord("dbemployee","card_id",card_id,stmtQry) != 0) {
											dup_cardid = true;
										}
									}
											
									if(dup_cardid == false && dup_sncard == false){											
										String groupCodeAdd = group_code;
										if(groupCodeAdd.equals("99")){
											groupCodeAdd = padKeyLeft(idcard, 13, "0");	
										}
								
										sql = "INSERT INTO dbemployee (idcard, sex, prefix, th_fname, th_sname, en_fname, en_sname, "
												+ "issue, pincode, st_date, ex_date, sec_code, pos_code, group_code, type_code, "
												+ "use_finger, st_time, ex_time, use_map_card, sn_card, emp_card, card_id, "
												+ "nationality, phone_no, email, pass_word, date_data, "
												+ "face_sn_card, face_pincode, face_identify_mode, face_date_data) VALUES ('" 
												+ idcard + "','" + sex + "','" + prefix + "','" + th_fname + "','" + th_sname + "','" + en_fname + "','" + en_sname + "','" 
												+ issue + "','" + pincode + "','" + stdate + "','" + exdate + "','" + sec_code + "','" + pos_code + "','" + groupCodeAdd + "','" + type_code + "','" 
												+ use_finger + "','" + st_time + "','" + ex_time + "','" + usemapcard + "','" + sncard + "','" + emp_card + "','" + card_id + "','" 
												+ nationality + "','" + phoneno + "','" + email + "','" + user_password + "'," + date_updates + ",'" 
												+ face_sncard + "','" + face_pincode + "','" + face_identifymode + "'," + date_updates + ")";
											
										resultQry = stmtUp.executeUpdate(sql);
										if (resultQry != 0) {
									
											//	Copy file from photos/tmpCapture to photos/ && delete file tmp
											try {
												File tmpFile = new File(getServletContext().getRealPath("/") + "photos\\tmpCapture\\CaptureBy-"+username+".jpg");
												File newFile = new File(getServletContext().getRealPath("/") + "photos\\"+idcard+".jpg");
												FileUtils.copyFile(tmpFile, newFile);
												//	delete file tmpCapture
												new File(getServletContext().getRealPath("/") + "photos\\tmpCapture\\CaptureBy-"+username+".jpg").delete();
											} catch (Exception ef) { }
									
											//	Check File Photo & Template
											if((new File(getServletContext().getRealPath("/")+"photos/" + idcard + ".jpg").exists() == true)){
												stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '1' WHERE idcard = '"+idcard+"' ");
											}
											if(new File(path_tpl + idcard + ".DAT").exists() == true){
												stmtUp.executeUpdate(" UPDATE dbemployee SET template = '1' WHERE idcard = '"+idcard+"' ");
											}
									
											rc.WriteDataLogFile("[" + ses_user + "] Add idcard : " + idcard + " [dbemployee]");
											if (group_code.equals("99")) {
												sql = " INSERT INTO dbgroup (group_code, th_desc, en_desc) "
													+ " VALUES ('" + groupCodeAdd + "', 'กลุ่มที่กำหนดเฉพาะแต่ละบุคคล', 'Specifically defined group')";
												resultQry = stmtUp.executeUpdate(sql);
												//	response.sendRedirect("../edit_zonegroup.jsp?action=add&group_code=" + groupCodeAdd);
												out.println(" <script> document.location='../edit_zonegroup.jsp?action=add&group_code=" + groupCodeAdd + "'; </script>");
											} else {
											//	out.println("<script> $('#myModalConfirm').modal('show'); </script> ");
												out.println("<script> document.location='../edit_employee.jsp?action=add'; </script>");
											}
										}										
									} else {
										if(dup_sncard){
											out.println("<script>ModalDanger_NoTimeout('" + msg_dupserial + "');</script>");
										}else if(dup_cardid){
											out.println("<script>ModalDanger_NoTimeout('" + msg_dupcardid + "');</script>");						
										}										
									}
								} else {
									out.println("<script>ModalDanger_NoTimeout('" + msg_dupemp + "');</script>");
								}
							} else {
								out.println("<script>ModalDanger_NoTimeout('"+lb_empcode+" "+idcard+" "+lb_emp_blacklist+"<br/><br/>"+lb_cannot_addemployee+"');</script>");
							}
						}	rs2.close();
					} else {
						out.println("<script>ModalDanger_NoTimeout('"+lb_cardid+" "+card_id+" "+lb_emp_blacklist+"<br/><br/>"+lb_cannot_addemployee+"');</script>");
					}
				}	rs.close();
				
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} else if (action.equals("edit") || action.equals("edit2")) {
			String idcard2 = request.getParameter("idcard2").toUpperCase();
			String txissue = request.getParameter("txissue");
			String txpin_code = request.getParameter("txpin_code");
			String txst_date = request.getParameter("txst_date");
			String txex_date = request.getParameter("txex_date");
			String txgroup_code = request.getParameter("txgroup_code");
			String txserailcard = request.getParameter("txserailcard");
			String txmapcard = request.getParameter("txmapcard");
			String use_fingerold = request.getParameter("use_fingerold");
			String txst_hh1 = request.getParameter("txst_hh1");
			String txst_hh2 = request.getParameter("txst_hh2");
			String txst_mm1 = request.getParameter("txst_mm1");
			String txst_mm2 = request.getParameter("txst_mm2");
			String txtthfname = new String(request.getParameter("txtthfname").getBytes("ISO8859_1"), "tis-620");
			String txtthsname = new String(request.getParameter("txtthsname").getBytes("ISO8859_1"), "tis-620");
			String txtenfname = new String(request.getParameter("txtenfname").getBytes("ISO8859_1"), "tis-620");
			String txtensname = new String(request.getParameter("txtensname").getBytes("ISO8859_1"), "tis-620");
			
			String txtface_sncard = request.getParameter("txtface_sncard");
			String txtface_pincode = request.getParameter("txtface_pincode");
			String txtface_identifymode = request.getParameter("txtface_identifymode");			
			
			String txtcard_id = request.getParameter("txtcardid");
			if (!(txtcard_id.equals("") || txtcard_id.equals("null") || (txtcard_id.length() == 13))) {
				txtcard_id = subStrPublicID(txtcard_id);
			}
			
			if (!(group_code.equals(txgroup_code))) {
				if (txgroup_code.length() == 13) {
					try{
						stmtUp.executeUpdate(deleteTable("dbgroup","group_code",txgroup_code));
						stmtUp.executeUpdate(deleteTable("dbzone_group","group_code",txgroup_code));
					}catch(SQLException e){
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
					}
				}
			}
			
			//	Check Duplicate sn_card
			if(!sncard.equals("")){
				try {
					String sql_sncard = " SELECT COUNT(*) AS count_rec FROM dbemployee "
						+ " WHERE (idcard != '"+idcard+"') AND (sn_card = '"+sncard+"') AND (ex_date >= '"+date_current+"')";
					ResultSet rs = stmtQry.executeQuery(sql_sncard);
					if (rs.next()) {
						if(rs.getInt("count_rec") == 1){
							dup_sncard = true;
						}
					}	rs.close();
				}catch(SQLException e){ }
			}
						
			//	Check Duplicate card_id
			if(!card_id.equals("")){
				try {
					String sql_cardid = " SELECT COUNT(*) AS count_rec FROM dbemployee "
						+ " WHERE (idcard != '"+idcard+"') AND (card_id = '"+card_id+"') ";
					ResultSet rs = stmtQry.executeQuery(sql_cardid);
					if (rs.next()) {
						if(rs.getInt("count_rec") == 1){
							dup_cardid = true;
						}
					}	rs.close();
				}catch(SQLException e){ }
			}
			
			String groupCodeAdd = group_code;
			if(groupCodeAdd.equals("99")){
				groupCodeAdd = padKeyLeft(idcard, 13, "0");	
			}
			
			sql = "UPDATE dbemployee SET idcard='" + idcard + "', sex='" + sex + "', prefix='" + prefix 
					+ "', th_fname='" + th_fname + "', th_sname='" + th_sname + "', en_fname='" + en_fname 
					+ "', en_sname='" + en_sname + "', issue='" + issue + "', pincode='" + pincode 
					+ "', st_date='" + stdate + "', ex_date='" + exdate + "', sec_code='" + sec_code 
					+ "', pos_code='" + pos_code + "', group_code='" + groupCodeAdd + "', type_code='" + type_code 
					+ "', use_finger='" + use_finger+ "', st_time='" + st_time + "', ex_time='" + ex_time 
					+ "', use_map_card='" + usemapcard + "', sn_card='" + sncard + "', emp_card='" + emp_card 
					+ "', card_id='" + card_id+ "', nationality='" + nationality + "', phone_no='" + phoneno 
					+ "', email='" + email + "', face_sn_card='" + face_sncard + "', face_pincode='" + face_pincode 
					+ "', face_identify_mode='" + face_identifymode + "' ";
			try {
				if (idcard.equals(idcard2)) {
					if(dup_cardid == false && dup_sncard == false){
						if ((!txpin_code.equals(pincode)) || (!txmapcard.equals(usemapcard))
								|| (!txst_date.equals(st_date)) || (!txex_date.equals(ex_date))
								|| (!txgroup_code.equals(groupCodeAdd)) || (!txissue.equals(issue))
								|| (!use_finger.equals(use_fingerold)) || (!txserailcard.equals(sncard))
								|| (!txtthfname.equals(th_fname)) || (!txtthsname.equals(th_sname))
								|| (!txtenfname.equals(en_fname)) || (!txtensname.equals(en_sname))
								|| (!txst_hh1.equals(hh1)) || (!txst_mm1.equals(mm1)) || (!txst_hh2.equals(hh2))
								|| (!txst_mm2.equals(mm2)) || (!txtcard_id.equals(card_id))) {
							// data modify update datetime to date_data
							sql += ", date_data=" + date_updates;
						}		
			
						if ((!txtface_sncard.equals(face_sncard)) || (!txtface_pincode.equals(face_pincode))
								|| (!txtface_identifymode.equals(face_identifymode))
								|| (!txtthfname.equals(th_fname)) || (!txtthsname.equals(th_sname))
								|| (!txtenfname.equals(en_fname)) || (!txtensname.equals(en_sname))) {
							// data modify update datetime to face_date_data
							sql += ", face_date_data=" + date_updates;
						}					
												
						sql += " WHERE (idcard = '" + idcard2 + "')";
						resultQry = stmtUp.executeUpdate(sql);
						if (resultQry != 0) {
							rc.WriteDataLogFile("[" + ses_user + "] Edit idcard : " + idcard2 + " [dbemployee]");
							
							//	Check File Photo & Template
							if((new File(getServletContext().getRealPath("/")+"photos/" + idcard + ".jpg").exists() == true)){
								stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '1' WHERE idcard = '"+idcard+"' ");
							}else{
								stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '0' WHERE idcard = '"+idcard+"' ");
							}
							if(new File(path_tpl + idcard + ".DAT").exists() == true){
								stmtUp.executeUpdate(" UPDATE dbemployee SET template = '1' WHERE idcard = '"+idcard+"' ");
							}else{
								stmtUp.executeUpdate(" UPDATE dbemployee SET template = '0' WHERE idcard = '"+idcard+"' ");
							}
							stmtUp.executeUpdate(" UPDATE dbblacklist SET card_id = '"+card_id+"' WHERE idcard = '"+idcard+"' ");
							
							if (group_code.equals("99")) {
								try{
									sql = " INSERT INTO dbgroup (group_code, th_desc, en_desc) "
										+ " VALUES ('" + groupCodeAdd + "', 'กลุ่มที่กำหนดเฉพาะแต่ละบุคคล', 'Specifically defined group')";
									resultQry = stmtUp.executeUpdate(sql);
								}catch(SQLException e){
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
								}
							//	response.sendRedirect("../edit_zonegroup.jsp?action=add&group_code=" + groupCodeAdd);
								out.println(" <script> document.location='../edit_zonegroup.jsp?action=add&group_code=" + groupCodeAdd + "'; </script>");
							} else {
								if (action.equals("edit")) {
									session.setAttribute("session_alert", msg_editsuccess);
								//	out.println("<script> $('#myModalConfirm').modal('show'); </script> ");
									out.println("<script> document.location='../data_employee.jsp'; </script>");
								} else if (action.equals("edit2")) {
								//	response.sendRedirect("../edit_zonegroup.jsp?action=add&group_code=" + group_code);
									out.println(" <script> document.location='../edit_zonegroup.jsp?action=add&group_code=" + group_code + "'; </script>");
								}
							}
						}
					} else {
						if(dup_sncard){
							out.println("<script>ModalDanger_NoTimeout('" + msg_dupserial + "');</script>");
						}else if(dup_cardid){
							out.println("<script>ModalDanger_NoTimeout('" + msg_dupcardid + "');</script>");						
						}
					}
				} else {
					if (getCountRecord("dbemployee","idcard",idcard,stmtQry) == 0) {
						if(dup_cardid == false && dup_sncard == false){
							sql += ", date_data=" + date_updates + " WHERE (idcard = '" + idcard2 + "')";
							resultQry = stmtUp.executeUpdate(sql);
							if (resultQry != 0) {
								
								//	Check File Photo & Template
								if((new File(getServletContext().getRealPath("/")+"photos/" + idcard + ".jpg").exists() == true)){
									stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '1' WHERE idcard = '"+idcard+"' ");
								}else{
									stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '0' WHERE idcard = '"+idcard+"' ");
								}
								if(new File(path_tpl + idcard + ".DAT").exists() == true){
									stmtUp.executeUpdate(" UPDATE dbemployee SET template = '1' WHERE idcard = '"+idcard+"' ");
								}else{
									stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '0' WHERE idcard = '"+idcard+"' ");
								}
								
								//	Rename file .jpg
								try{
									File f = new File(getServletContext().getRealPath("/") + "photos\\"+idcard2+".jpg");
									f.renameTo(new File(getServletContext().getRealPath("/") + "photos\\"+idcard+".jpg"));
								}catch(Exception ef){ }
								
								stmtUp.executeUpdate(updateTable("dbtransaction","idcard",idcard,idcard2));
								stmtUp.executeUpdate(updateTable("dbtransaction_ev","idcard",idcard,idcard2));
								stmtUp.executeUpdate(updateTable("dbblacklist","idcard",idcard,idcard2));
								stmtUp.executeUpdate(" UPDATE dbblacklist SET card_id = '"+card_id+"' WHERE idcard = '"+idcard2+"' ");
								
								rc.WriteDataLogFile("[" + ses_user + "] Edit idcard : " + idcard2
										+ " to idcard : " + idcard + " [dbemployee]");
								if (group_code.equals("99")) {
									try{
										resultQry = stmtUp.executeUpdate(insertDbGroup(groupCodeAdd));
									}catch(SQLException e1){
										out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e1.getMessage()+"</div>");
									}
								//	response.sendRedirect("../edit_zonegroup.jsp?action=add&group_code=" + groupCodeAdd + "");
									out.println(" <script> document.location='../edit_zonegroup.jsp?action=add&group_code=" + groupCodeAdd + "'; </script>");
								} else {
									if (action.equals("edit")) {
										session.setAttribute("session_alert", msg_editsuccess);
									//	out.println("<script> $('#myModalConfirm').modal('show'); </script> ");
										out.println("<script>document.location='../data_employee.jsp';</script>");
									} else if (action.equals("edit2")) {
									//	response.sendRedirect("../edit_zonegroup.jsp?action=add&group_code=" + group_code + "");
										out.println(" <script> document.location='../edit_zonegroup.jsp?action=add&group_code=" + group_code + "'; </script>");
									}
								}
							}
						} else {
							if(dup_sncard){
								out.println("<script>ModalDanger_NoTimeout('" + msg_dupserial + "');</script>");
							}else if(dup_cardid){
								out.println("<script>ModalDanger_NoTimeout('" + msg_dupcardid + "');</script>");						
							}
						}
					} else {
						out.println("<script>ModalDanger_NoTimeout('" + msg_dupemp + "');</script>");
					}
				}
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		} 
	}
%>

<%@ include file="../function/disconnect.jsp"%>	