<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "special"); 
	session.setAttribute("subpage", "exportfile");
	String file = request.getParameter("file");
	session.setAttribute("subtitle", file);	
	session.setAttribute("action", "file_export_data.jsp?file="+file+"&");	
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
 
		<script>
			function openDialog(filename){ 
				document.execCommand("SaveAs", true, filename);
			} 
		</script>
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<br/>
		<div class="body-display">
			<div class="container" style="margin-top: -20px;">
			
				<div class="col-md-1"> </div>
				<div class="col-md-10">
					<form name="form1" id="form1">
						<div class="panel panel-primary"> 
							<div class="panel-heading">
								<h3 class="panel-title"> <b>
						<% 			
									if(file.equals("depart")){ 
										out.print(lb_depart);
									}else if(file.equals("section")){
										out.print(lb_section);
									}else if(file.equals("position")){
										out.print(lb_position);
									}else if(file.equals("type")){
										out.print(lb_typeemp);
									}else if(file.equals("group")){
										out.print(lb_group);
									}else if(file.equals("employee")){
										out.print(lb_employee);
									}else if(file.equals("employee2")){
										out.print(lb_employee+" ["+lb_master_data+"]");
									}else if(file.equals("holiday")){
										out.print(lb_holiday);
									}
						%>
								</b> </h3> 
							</div> 
							<div class="panel-body"> 
								<div class="row">
									<label class="col-md-8"> 
										<span class="glyphicon glyphicon-paste" style="font-size: 18px;"> </span> &nbsp; 
										
						<%										
									int count_rec = 0;									
									if(file.equals("depart") || file.equals("section") || file.equals("position") 
										|| file.equals("type") || file.equals("group") || file.equals("employee") || file.equals("holiday")){ 
										count_rec = getCountRecord("db"+file,stmtQry);	
										out.println(lb_datasuccess+" "+count_rec+" "+lb_record+"<br/>");										
									}
									if(file.equals("employee2")){ 
										count_rec = getCountRecord("dbemployee",stmtQry);	
										out.println(lb_datasuccess+" "+count_rec+" "+lb_record+"<br/>");	
									}
									
									FileOutputStream fos = null;
									FileInputStream input = null;
									ServletOutputStream myOut = null; 
									PrintWriter pw = null;	 									
									String fileName = "";
									String StrText = "";
									ResultSet rs = null;														
									if(file.equals("depart")){
										//	page user online
										session.setAttribute("page_jsp", "depart");
										
										fileName = "depart.txt";		
										try{								
											fos = new FileOutputStream(fileName);
											pw = new PrintWriter(fos);	
											
											StrText = lb_departcode+","+lb_thdesc+","+lb_endesc;		
											pw.println(new String(StrText.getBytes("tis-620")));		
											
											rs = stmtQry.executeQuery("SELECT * FROM dbdepart ORDER BY dep_code asc");		
											while(rs.next()){			
												StrText = rs.getString("dep_code")+","+rs.getString("th_desc")+","+rs.getString("en_desc");
												pw.println(new String(StrText.getBytes("tis-620")));			
											}
											
											pw.close();
											fos.close();
										
										}catch (Exception e) {		
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
										}
										
									}else if(file.equals("section")){
										//	page user online
										session.setAttribute("page_jsp", "section");
										
										fileName = "section.txt";		
										try{		
											fos = new FileOutputStream(fileName);
											pw = new PrintWriter(fos);		
											
											StrText = lb_seccode+","+lb_thdesc+","+lb_endesc+","+lb_departcode;		
											pw.println(new String(StrText.getBytes("tis-620")));	
											
											rs = stmtQry.executeQuery("SELECT * FROM dbsection ORDER BY sec_code, dep_code asc");
											while(rs.next()){												
												StrText = rs.getString("sec_code")+","+rs.getString("th_desc")+","+rs.getString("en_desc")+","
														+rs.getString("dep_code");
												pw.println(new String(StrText.getBytes("tis-620")));												
											}
											
											pw.close();
											fos.close();
											
										}catch (Exception e) {		
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
										}
										
									}else if(file.equals("position")){
										//	page user online
										session.setAttribute("page_jsp", "position");
										
										fileName = "position.txt";
										try{		
											fos = new FileOutputStream(fileName);
											pw = new PrintWriter(fos);	
											
											StrText = lb_poscode+","+lb_thdesc+","+lb_endesc;		
											pw.println(new String(StrText.getBytes("tis-620")));	
											
											rs = stmtQry.executeQuery("SELECT * FROM dbposition ORDER BY pos_code asc");
											while(rs.next()){
												StrText = rs.getString("pos_code")+","+rs.getString("th_desc")+","+rs.getString("en_desc");
												pw.println(new String(StrText.getBytes("tis-620")));												
											}
											
											pw.close();
											fos.close();
											
										}catch (Exception e) {		
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
										}
										
									}else if(file.equals("type")){
										//	page user online
										session.setAttribute("page_jsp", "type");
										
										fileName = "type.txt";
										try{		
											fos = new FileOutputStream(fileName);
											pw = new PrintWriter(fos);	
											
											StrText = lb_typecode+","+lb_thdesc+","+lb_endesc;		
											pw.println(new String(StrText.getBytes("tis-620")));		 
											
											rs = stmtQry.executeQuery("SELECT * FROM dbtype ORDER BY type_code asc");
											while(rs.next()){									
												StrText = rs.getString("type_code")+","+rs.getString("th_desc")+","+rs.getString("en_desc");
												pw.println(new String(StrText.getBytes("tis-620")));	
											}
											
											pw.close();
											fos.close();
											
										}catch (Exception e) {		
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
										}
										
									}else if(file.equals("group")){
										//	page user online
										session.setAttribute("page_jsp", "group");
										
										fileName = "group.txt";		
										try{								
											fos = new FileOutputStream(fileName);
											pw = new PrintWriter(fos);	
											
											StrText = lb_groupcode+","+lb_thdesc+","+lb_endesc;		
											pw.println(new String(StrText.getBytes("tis-620")));		
											
											rs = stmtQry.executeQuery("SELECT * FROM dbgroup ORDER BY group_code asc");		
											while(rs.next()){			
												StrText = rs.getString("group_code")+","+rs.getString("th_desc")+","+rs.getString("en_desc");
												pw.println(new String(StrText.getBytes("tis-620")));			
											}
											
											pw.close();
											fos.close();
											
										}catch (Exception e) {		
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
										}
										
									}else if(file.equals("employee")){
										//	page user online
										session.setAttribute("page_jsp", "employee");
										
										fileName = "employee.txt";
										try{		
											fos = new FileOutputStream(fileName);
											pw = new PrintWriter(fos);	
											
											StrText = lb_empcode+","+lb_sex+","+lb_prefix+","+lb_thname+","+lb_thsname+","+
													  lb_enname+","+lb_ensname+","+lb_issue+","+lb_pincode+","+lb_startdate+","+
													  lb_expiredate+","+lb_seccode+","+lb_poscode+","+lb_groupcode+","+
													  lb_typecode+","+lb_empcard+","+lb_serial_card+","+lb_use_mapcard+","+
													  lb_nationality+","+lb_cardid+","+lb_phoneno+","+lb_email+","+lb_usebio+","+
													  lb_starttime+","+lb_expiretime+",Face "+lb_serial_card+",Face "+lb_pincode+",Face Identify Mode";		
											pw.println(new String(StrText.getBytes("tis-620")));
											
											rs = stmtQry.executeQuery("SELECT * FROM dbemployee ORDER BY idcard ASC");
											while(rs.next()){										
												StrText = rs.getString("idcard")+","+rs.getString("sex")+","+rs.getString("prefix")+","+
														  rs.getString("th_fname")+","+rs.getString("th_sname")+","+rs.getString("en_fname")+","+
														  rs.getString("en_sname")+","+rs.getString("issue")+","+rs.getString("pincode")+","+
														  YMDTodate(rs.getString("st_date"))+","+YMDTodate(rs.getString("ex_date"))+","+
														  rs.getString("sec_code")+","+rs.getString("pos_code")+","+rs.getString("group_code")+","+
														  rs.getString("type_code")+","+rs.getString("emp_card")+","+rs.getString("sn_card")+","+
														  rs.getString("use_map_card")+","+rs.getString("nationality")+","+rs.getString("card_id")+","+
														  rs.getString("phone_no")+","+rs.getString("email")+","+rs.getString("use_finger")+","+
														  rs.getString("st_time")+","+rs.getString("ex_time")
														  +","+rs.getString("face_sn_card")+","+rs.getString("face_pincode")+","+rs.getString("face_identify_mode");
												pw.println(new String(StrText.getBytes("tis-620")));
											}
											
											pw.close();
											fos.close();
											
										}catch (Exception e) {		
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
										}
									}else if(file.equals("employee2")){
										//	page user online
										session.setAttribute("page_jsp", "employee2");
										
										fileName = "employee_masterdata.txt";
										try{		
											fos = new FileOutputStream(fileName);
											pw = new PrintWriter(fos);	
											
											StrText = lb_empcode+","+lb_fname+","+lb_sname+","+lb_usebio+","+
													  lb_serial_card+","+lb_use_mapcard+","+lb_issue+","+
													  lb_pincode+","+lb_startdate+","+lb_expiredate+","+
													  lb_starttime+","+lb_expiretime+","+lb_groupcode+","+
													  lb_seccode+","+lb_poscode+","+lb_typecode+","+lb_cardid+
													  ",Face "+lb_serial_card+",Face "+lb_pincode+",Face Identify Mode";
											pw.println(new String(StrText.getBytes("tis-620")));
											
											String fname = "", sname = "";
											rs = stmtQry.executeQuery("SELECT * FROM dbemployee ORDER BY idcard ASC");
											while(rs.next()){	
												
												if(!(rs.getString("th_fname").equals(""))){
													fname = rs.getString("th_fname");
													sname = rs.getString("th_sname");
												}else{
													fname = rs.getString("en_fname");
													sname = rs.getString("en_sname");
												}
												
												StrText = rs.getString("idcard")+","+fname+","+sname+","+rs.getString("use_finger")+","+
														  rs.getString("sn_card")+","+rs.getString("use_map_card")+","+rs.getString("issue")+","+
														  rs.getString("pincode")+","+YMDTodate(rs.getString("st_date"))+","+YMDTodate(rs.getString("ex_date"))+","+
														  rs.getString("st_time")+","+rs.getString("ex_time")+","+rs.getString("group_code")+","+
														  rs.getString("sec_code")+","+rs.getString("pos_code")+","+ rs.getString("type_code")+","+ rs.getString("card_id")
														  +","+rs.getString("face_sn_card")+","+rs.getString("face_pincode")+","+rs.getString("face_identify_mode");
												pw.println(new String(StrText.getBytes("tis-620")));
											}
											
											pw.close();
											fos.close();
											
										}catch (Exception e) {		
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
										}
									}else if(file.equals("holiday")){
										//	page user online
										session.setAttribute("page_jsp", "holiday");
										
										fileName = "holiday.txt";
										try{		
											fos = new FileOutputStream(fileName);
											pw = new PrintWriter(fos);	
											
											StrText = lb_holiday+","+lb_thdesc+","+lb_endesc;		
											pw.println(new String(StrText.getBytes("tis-620")));	
											String sql = "";
											if(mode == 0){
												sql = "SELECT DATE_FORMAT(holi_date,'%d/%m/%Y') AS holi_date ";
											}else{
												sql = "SELECT CONVERT(varchar(10), holi_date, 103) AS holi_date ";
											}
											sql += ", th_desc, en_desc FROM dbholiday ORDER BY holi_date asc";
											rs = stmtQry.executeQuery(sql);
											while(rs.next()){
												StrText = rs.getString("holi_date")+","+rs.getString("th_desc")+","+rs.getString("en_desc");
												pw.println(new String(StrText.getBytes("tis-620")));												
											}
											
											pw.close();
											fos.close();
											
										}catch (Exception e) {		
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
										}
										
									}
						%>
									</label> 
								</div>
								<div class="row">
									<div class="col-md-8"> </div> 
									<div class="col-md-4" align="right"> 
										<input type="button" id="htmlBtn" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_open_saveas %> &nbsp; &nbsp; &nbsp; " onClick="location.href='module/download_file.jsp?files=<%= fileName %>'">
									</div> 
								</div>
							</div> 
						</div>
					</form>
				</div>
				<div class="col-md-1"> </div>
				
			</div>
		</div> 
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>