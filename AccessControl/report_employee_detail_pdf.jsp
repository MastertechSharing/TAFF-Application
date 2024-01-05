<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/displaydata.jsp"%>

<% 
	session.setAttribute("page_g", "report"); 
	session.setAttribute("action", "report_employee_detail_pdf.jsp?");
	
	boolean menu_sidebar = false;
	String selectpicker = "";
	String width_align = "style='width: 92%; min-width: 800px; max-width: 1200px; text-align: left;'";
	if( getBrowserInfo(request.getHeader("User-Agent")).contains("Internet Explorer") == false ){
		selectpicker = "selectpicker";
		width_align = "style='min-width: 1050px; text-align: left;'";
	}else{
		menu_sidebar = true;
	}
%>

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
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<link href="css/simple-sidebar.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script>
			function onLoad(){
				document.form1.action = "ReportEmployee.do";
				document.getElementById("form1").submit();
			}
			
			function orderByGroup(val){
				if(val == '1'){
					document.form1.action = "ReportEmployee.do";
					document.getElementById("form1").submit();
				}else{
					//
				}
			}
		</script>		
	</head>	
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="onLoad();" <% if(menu_sidebar == true){ %> style="margin-top: -50px;" <% } %>>
	
	<%	if(menu_sidebar == true){	%>
		
		<jsp:include page="left_menu.jsp?report=data" flush="true"/>
		
	<%	}	%>	
	
		<%@ include file="../tools/modal_danger.jsp"%>
				
		<div class="body-display">
			<div class="container">
				
				<form name="form1" id="form1" action="ReportEmployee.do" target="show_body" method="post">
				
			<%	
				//	Check File TPL & JPG	============================================================================
				//	ReCheck File Exists == false
				String idcard = "";
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
							}catch(SQLException e){
								out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
							}
							
						}
					}
				}
				//	End Check File TPL & JPG	========================================================================	
				
				String emp_id = "";				
				if(!( request.getParameter("emp_id") == null || request.getParameter("emp_id").equals("") )){  
					emp_id = request.getParameter("emp_id"); 
				}
				String bio = request.getParameter("bio");
				String mapcard = request.getParameter("mapcard");
				String pincode = request.getParameter("pincode");
				String finger = request.getParameter("finger");
				String photo = request.getParameter("photo");
				String issue = "";		
				if(!( request.getParameter("issue") == null )){
					issue = request.getParameter("issue");		
				} 			
				
				String chk_sdate = request.getParameter("chk_sdate"); // เลือกวันที่เริ่มต้นของบัตร
				String chk_edate = request.getParameter("chk_edate"); // เลือกวันที่สิ้นสุดของบัตร
				String chk_dateup = request.getParameter("chk_dateup"); // เลือกวันที่แก้ไขข้อมูลพนักงาน
				
				String date1 = request.getParameter("st_date");
				String date2 = request.getParameter("ex_date");
				String exdate1 = request.getParameter("st_exdate");
				String exdate2 = request.getParameter("ex_exdate");
				String dateup1 = request.getParameter("st_date_update");
				String dateup2 = request.getParameter("ex_date_update");
				
				String select_group = "", group_code = "";
				String select_sec = "", sec_code = "";
				String check_group = "";
				String check_sec = "";
				
				if(!( request.getParameter("check_group") == null || request.getParameter("check_group").equals("") )){
					check_group = request.getParameter("check_group"); // ค่าที่เลือก all หรือ รหัส
				}
				if(!( request.getParameter("check_sec") == null || request.getParameter("check_sec").equals("") )){			
					check_sec = request.getParameter("check_sec"); // ค่าที่เลือก all หรือ รหัส
				}
				
				if(!( request.getParameter("select_group") == null || request.getParameter("select_group").equals("") )){
					select_group = request.getParameter("select_group");  // ประตูที่เลือกมาจากหน้าแรกทั้งหมด
				}
				if(!( request.getParameter("select_sec") == null || request.getParameter("select_sec").equals("") )){
					select_sec = request.getParameter("select_sec"); // แผนกที่เลือกมาจากหน้าแรกทั้งหมด
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
				
					String sql = "", group_desc = "", sec_desc = "";				
			%>		
					<input type="hidden" name="emp_id" value="<%= emp_id %>">		
					<input type="hidden" name="bio" value="<%= bio %>">
					<input type="hidden" name="mapcard" value="<%= mapcard %>">
					<input type="hidden" name="finger" value="<%= finger %>">
					<input type="hidden" name="photo" value="<%= photo %>">
					<input type="hidden" name="pincode" value="<%= pincode %>">
					<input type="hidden" name="issue" value="<%= issue %>">
					
					<input type="hidden" name="chk_stdate" value="<%= chk_sdate %>">
					<input type="hidden" name="chk_exdate" value="<%= chk_edate %>">
					<input type="hidden" name="chk_dateup" value="<%= chk_dateup %>">
					
					<input type="hidden" name="st_date" value="<%= date1 %>">
					<input type="hidden" name="st_date2" value="<%= date2 %>">
					<input type="hidden" name="ex_date" value="<%= exdate1 %>">
					<input type="hidden" name="ex_date2" value="<%= exdate2 %>">
					<input type="hidden" name="st_date_update" value="<%= dateup1 %>">
					<input type="hidden" name="ex_date_update" value="<%= dateup2 %>">
					
					<input type="hidden" name="paramName_group" value="<%= check_group %>">
					<input type="hidden" name="paramName_sec" value="<%= check_sec %>">
					<input type="hidden" name="lang" value="<%= lang %>">
					
					<div class="table-responsive" align="center" style="border: 0px !important; margin: <% if(menu_sidebar == true){ %> 0px <% }else{ %> -45px <% } %> -15px -15px -15px;">
						<div <%= width_align %> class="table" border="0">
					
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="col-xs-6 col-md-6 control-label" style="margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <a href="report_employee_detail.jsp"> <%= lb_report_employee2 %> </a> </label>
										</div>
										
									<%	if(!(check_group.equals("") && check_group == null)){	%>
										<p>
										<div class="row">
											<label class="col-xs-2 col-md-2 label-text-1 control-label" style="margin-top: 5px;"> <%= lb_groupemp %> </label>
											<div class="col-xs-8 col-md-8"> 
										<%	
												String[] param_value = check_group.split(","); 
												sql = "SELECT * FROM dbgroup WHERE ";
												for(int g = 0; g < param_value.length; g++){
													sql += " (group_code = '"+param_value[g]+"') ";	
													if(g != param_value.length - 1){
														sql += " OR ";
													}													  
												}
												sql += "ORDER BY group_code ASC ";
												try{										
													ResultSet rs_group = stmtQry.executeQuery(sql);
										%>
												<select class="form-control <%= selectpicker %>" data-live-search="true" data-width="100%" data-size="15" data-container="body" name="select_group" style="max-height: 28px !important; font-size: 12px !important;" onChange="orderByGroup('1')">
													<option value="all" <% if(select_group.equals("all")){ %> selected <% } %>> <%= lb_all %> </option>
										<%			while(rs_group.next()){
														group_code = rs_group.getString("group_code");
														if(lang.equals("th"))
															group_desc = rs_group.getString("th_desc");
														else
															group_desc = rs_group.getString("en_desc");
															
										%>			<option value="<%= rs_group.getString("group_code") %>" <% if(rs_group.getString("group_code").equals(select_group)){ %> selected <% } %>> <% out.print(rs_group.getString("group_code")+" : "+group_desc); %> </option>
										<%		
													}
													rs_group.close();
												}catch(SQLException e){							
													out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
												}
										%>
												</select>
											</div>
										</div>
									<%	}	%>
									
									<%	if(!(check_sec.equals("") && check_sec == null)){	%>
										<p>
										<div class="row">
											<label class="col-xs-2 col-md-2 label-text-1 control-label" style="margin-top: 5px;"> <%= lb_sect %> </label>
											<div class="col-xs-8 col-md-8"> 
										<%	
												String[] param_value = check_sec.split(","); 
												sql = "SELECT * FROM dbsection WHERE ";
												for(int g = 0; g < param_value.length; g++){
													sql += " (sec_code = '"+param_value[g]+"') ";	
													if(g != param_value.length - 1){
														sql += " OR ";
													}													  
												}
												sql += "ORDER BY sec_code ASC ";
												try{										
													ResultSet rs_sec = stmtQry.executeQuery(sql);
										%>
												<select class="form-control <%= selectpicker %>" data-live-search="true" data-width="100%" data-size="15" data-container="body" name="select_sec" style="max-height: 28px !important; font-size: 12px !important;" onChange="orderByGroup('1')">
													<option value="all" <% if(select_sec.equals("all")){ %> selected <% } %>> <%= lb_all %> </option>
										<%			while(rs_sec.next()){
														sec_code = rs_sec.getString("sec_code");
														if(lang.equals("th"))
															sec_desc = rs_sec.getString("th_desc");
														else
															sec_desc = rs_sec.getString("en_desc");
															
										%>			<option value="<%= rs_sec.getString("sec_code") %>" <% if(rs_sec.getString("sec_code").equals(select_sec)){ %> selected <% } %>> <% out.print(rs_sec.getString("sec_code")+" : "+sec_desc); %> </option>
										<%		
													}
													rs_sec.close();
												}catch(SQLException e){							
													out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
												}
										%>
												</select>
											</div>
										</div>
									<%	}	%>
									
									</div>	
									
								</div>
							</div>	
							
						</div>
					</div>
					
					<div class="table-responsive" align="center" style="border: 0px !important; margin: -25px -15px -75px -15px;">
						<div <%= width_align %> class="table" border="0">
						
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">	
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row" align="center">
										<!--	<iframe name="show_bodyz" width="97%" height="700" src="ReportEmployee.do?emp_id=<%= emp_id %>&bio=<%= bio %>&mapcard=<%= mapcard %>&pincode=<%= pincode %>&issue=<%= issue %>&finger=<%= finger %>&photo=<%= photo %>&chk_stdate=<%= chk_sdate %>&chk_exdate=<%= chk_edate %>&chk_dateup=<%= chk_dateup %>&st_date=<%= date1 %>&st_date2=<%= date2 %>&ex_date=<%= exdate1 %>&ex_date2=<%= exdate2 %>&st_date_update=<%= dateup1 %>&ex_date_update=<%= dateup2 %>&paramName_group=<%= check_group %>&paramName_sec=<%= check_sec %>&select_group=<%= select_group %>&select_sec=<%= select_sec %>&lang=<%= lang %>" frameborder="0" scrolling="yes"></iframe>	-->
											<iframe name="show_body" width="97%" height="700" src="" frameborder="0" scrolling="yes"></iframe>
										</div>
									</div>
								
								</div>
							</div>
						
						</div>
					</div>
					
				</form>
				
			<%	}	%>
			
			</div>
		</div>
		
	<%	if(menu_sidebar == true){	%>
		</div>
	<%	}	%>	
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>