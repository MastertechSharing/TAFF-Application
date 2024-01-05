<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	String post_file = (String)session.getAttribute("action");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script language="javascript" src="js/select_ajax.js"></script>
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/check_key.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script language="javascript">
			document.onkeydown = searchKeyPress;
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})

			function changeIframe3(x){
				var section_code  = x.value;
				location.href = 'iframe_employee.jsp?section_code='+section_code;
			}

			function onSubmit(){
				window.document.form1.submit();
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -60px;">
		
		<form id="form1" name="form1" method="post">
		<%	String keyword = "";
			if((request.getParameter("keyword") != null) && (request.getParameter("keyword") != "")){
				keyword = new String (request.getParameter("keyword").getBytes("ISO8859_1"),"TIS-620").trim();
			}
			
			String section_code = "";				
			if(request.getParameter("section_code") != null  || request.getParameter("section_code") != ""){  
				section_code = request.getParameter("section_code");
			}
		%>
			<div class="table-responsive" style="border: 0px !important; margin-bottom: -10px; margin-bottom: -15px;" border="0">
				<div style="min-width: 800px;" class="table" border="0">
					<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;"> 
						<div class="row">
						<%	if(checkPermission(ses_per, "01234")){	%>
							<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 6px;"> <div align="right"> <b> <%= lb_select %> : </b> </div> </h5>
							<div class="modal-title col-xs-8 col-md-8"> 
								<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="section_code" id="section_code" onchange="changeIframe3(document.form1.section_code);">
							<%	try{
									String sql = "SELECT sec.sec_code, ";	
									if(lang.equals("th")){
										sql += "sec.th_desc ";
									}else{
										sql += "sec.en_desc AS th_desc ";
									}
									sql += "FROM dbsection sec ";
									if(checkPermission(ses_per, "12")){
										sql += "LEFT JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) "
											+ "LEFT JOIN dbusers u ON (u.dep_code = dep.dep_code) "
											+ "WHERE (u.user_name = '"+ses_user+"') ";	
									}
									sql += "ORDER BY sec.sec_code";	
									ResultSet rs = stmtQry.executeQuery(sql);
							%>			<option value="0" > <%= lb_sel_sec %> </option>
							<%		while(rs.next()){	%>
										<option value="<%= rs.getString("sec_code") %>" <%= checkDataSelected(rs.getString("sec_code"), section_code) %>><%= rs.getString("sec_code") %> - <%= rs.getString("th_desc") %></option>
							<% 		} 
									rs.close();	
								}catch(SQLException e){		
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
								}				
							%>	</select>
							</div>
						<%	}else{	%>
							<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 6px;"> <div align="right"> <b> <%= lb_sect %> : </b> </div> </h5>
							<div class="modal-title col-xs-8 col-md-8" style="margin-top: 6px;"> 
							<%	try{
									String sql = "SELECT sec.sec_code, ";	
									if(lang.equals("th")){
										sql += "sec.th_desc AS sec_desc ";
									}else{
										sql += "sec.en_desc AS sec_desc ";
									}
									sql += "FROM dbsection sec "
										+ "LEFT JOIN dbusers u ON (u.sec_code = sec.sec_code) "
										+ "WHERE (u.user_name = '"+ses_user+"') ";	
									
									ResultSet rs = stmtQry.executeQuery(sql);
									if(rs.next()){
										out.println(rs.getString("sec_code")+"  "+rs.getString("sec_desc"));
									}	rs.close();
								}catch(SQLException e){
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
								}
							%>
							</div>
						<%	}	%>
						</div>
						<p>
						<div class="row">
							<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 6px;"> <div align="right"> <b> <%= lb_finddata %> : </b> </div> </h5>
							<div class="modal-title col-xs-8 col-md-8"> 
								<input type="text" id="keyword" name="keyword" class="form-control" value="<%= keyword %>" onKeyPress="IsValidCharThEn_keyword()">
							</div>
							<div class="modal-title col-xs-2 col-md-2"> 
								<input type="button" id="btnok" class="btn btn-primary btn-sm button-shadow1 button-shadow2" onclick="return onSubmit();" value=" &nbsp; <%= btn_ok %> &nbsp; " onmouseover="this.style.cursor='hand';" />
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="table-responsive" style="border: 0px !important; margin-bottom: -50px;" border="0">
				<div style="min-width: 800px;" class="table" border="0">

					<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;"> 
						<div class="row">
							<div class="modal-title col-xs-12 col-md-12"> 
								<table style="min-width: 760px; margin-bottom: -5px;" class="table table-bordered table-hover" align="center" border="0">
									<thead>
										<tr class="active">
											<td width="25%" align="center"> <b> <%= lb_empcode %> </b> </td>
											<td width="30%" align="center"> <b> <%= lb_names %> </b> </td>
											<td width="35%" align="center"> <b> <%= lb_thsec %> </b> </td>
											<td width="10%" align="center"> <b> <%= lb_select %> </b> </td>
										</tr>
									</thead>
					<%		
							try{
								int count = 0;				
								String idcard = "", emp_name = "", sec_desc = "";								
								
								String sql = "SELECT emp.idcard AS id, emp.sec_code, sec.th_desc, sec.en_desc, ";
								if(lang.equals("th")){
									sql += "emp.th_fname AS fname, emp.th_sname AS sname, sec.th_desc AS sec_name ";	
								}else{
									sql += "emp.en_fname AS fname, emp.en_sname AS sname, sec.en_desc AS sec_name ";	
								}
								sql += "FROM dbemployee emp "
									+ " LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) ";
								if(checkPermission(ses_per, "034")){
									
									sql += "WHERE NOT EXISTS (SELECT bl.idcard, bl.cancel_status FROM dbblacklist bl WHERE emp.idcard = bl.idcard AND bl.cancel_status = '0')";
									
									if((request.getParameter("keyword") != null) && (request.getParameter("keyword") != "")){										
										sql += "AND ((emp.idcard like '%"+keyword+"%') ";
										if(lang.equals("th")){							
											sql += "OR (emp.th_fname like '%"+keyword+"%') OR (emp.th_sname like '%"+keyword+"%')) ";											
										}else{										 
											sql += "OR (emp.en_fname like '%"+keyword+"%') OR (emp.en_sname like '%"+keyword+"%')) ";											
										}												
										if(!(request.getParameter("section_code").equals("0") || request.getParameter("section_code").equals("null"))){				
											sql += "AND (emp.sec_code = '"+section_code+"') ";											
										}
									}else{	
										sql += "AND (emp.sec_code = '"+section_code+"') ";			 				
									}		
								}else{
									if(checkPermission(ses_per, "56")){
										sql += "LEFT OUTER JOIN dbusers users ON (users.sec_code = sec.sec_code) ";
									}else{
										sql += "LEFT OUTER JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
											+ "LEFT OUTER JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
									}
									
									sql += "WHERE NOT EXISTS (SELECT bl.idcard, bl.cancel_status FROM dbblacklist bl WHERE emp.idcard = bl.idcard AND bl.cancel_status = '0')";
									sql += "AND (users.user_name = '"+ses_user+"')";
									
									if((request.getParameter("keyword") != null) && (request.getParameter("keyword") != "")){		  
										sql += "AND ((emp.idcard like '%"+keyword+"%') ";
										if(lang.equals("th")){							
											sql += "OR (emp.th_fname like '%"+keyword+"%') OR (emp.th_sname like '%"+keyword+"%')) ";
										}else{										 
											sql += "OR (emp.en_fname like '%"+keyword+"%') OR (emp.en_sname like '%"+keyword+"%')) ";
										}
										if(checkPermission(ses_per, "12")){
											if(!(request.getParameter("section_code").equals("0") || request.getParameter("section_code").equals("null"))){				
												sql += "AND (emp.sec_code = '"+section_code+"') ";											
											}
										}
									}else{	
										sql += "AND (emp.sec_code = '"+section_code+"') ";		 				
									}
								}
								sql += " ORDER BY emp.idcard";
								
								ResultSet rs = stmtUp.executeQuery(sql);
								while(rs.next()){	
									idcard = rs.getString("id");																		
									emp_name = rs.getString("fname")+"  "+rs.getString("sname");
									sec_desc = rs.getString("sec_name");
					%>
									<tr>
										<td class="pad-left-10"> <%= idcard %> </td>
										<td class="pad-left-10"> <div class="ellipsis_string" style="width: 95%"> <%= emp_name %> </div> </td>
										<td class="pad-left-10"> <div class="ellipsis_string" style="width: 95%"> <%= sec_desc %> </div> </td>
										<td align="center">
											<img src="images/complete.gif" width="20" height="20" border="0" align="absmiddle" onMouseOver="this.style.cursor='hand';" onclick="add_value_selectEmpID('<%= idcard %>', '<%= emp_name %>', '<%= post_file %>');" data-toggle="tooltip" data-placement="left" title="<%= lb_select %>">
										</td>
									</tr>
					<% 			} 
								rs.close();	
							}catch(SQLException e){		
								out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
							}				
					%>
								</table>
								
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</form> 
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>