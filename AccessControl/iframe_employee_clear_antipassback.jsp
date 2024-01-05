<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	String post_file = "clear_antipassback.jsp";	%>
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
				location.href = 'iframe_employee_clear_antipassback.jsp?section_code='+section_code;
			}

			function onSubmit(){
				window.document.form1.submit();
			}
			
			var req;
			function Inint_AJAX() {
				try { return new ActiveXObject("Msxml2.XMLHTTP");  } catch(e) {} //IE
				try { return new ActiveXObject("Microsoft.XMLHTTP"); } catch(e) {} //IE
				try { return new XMLHttpRequest(); } catch(e) {} //Native Javascript
				alert("XMLHttpRequest not supported");
				return null;
			}

			function selectEmpAntiPassback(idcard, fullname, reader_no, reader_name, current_level, current_io, current_rd, group_rd, msg_no_antipassback, post_file) {
				var req = Inint_AJAX();	
				req.onreadystatechange = function () {
					if (req.readyState == 4) {
						if (req.status == 200) {
							var ret = req.responseText;
							if(ret != null){
								parent.window.document.getElementById("idcard").value = idcard;
								parent.window.document.getElementById("fullname").value = fullname;
								parent.window.document.getElementById("reader_no").value = reader_no;
								parent.window.document.getElementById("reader_name").value = reader_name;
								parent.window.document.getElementById("io").value = current_io;
								parent.window.document.getElementById("current_level").value = current_level;
								parent.window.document.getElementById("current_io").value = current_io;
								parent.window.document.getElementById("current_rd").value = current_rd;
								parent.window.document.getElementById("group_rd").value = group_rd;
								parent.window.top.$("#myModalViewDetail").modal('hide');
								
								parent.window.top.checkText();
								if(Number(current_level) == 0){
									parent.window.top.cancelButton2();
									parent.window.top.$('#btn_clear').attr('disabled', 'disabled');
									parent.window.top.$('#btn_clearall').attr('disabled', 'disabled');
									parent.window.$('#text_warning').html(msg_no_antipassback);
									parent.window.$('#myModalWarning').modal('show');
								}
							}
						}
					}  
				};
				
				req.open("POST", post_file);
				req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620");
				req.send("idcard="+idcard+"&fullname="+fullname+"&reader_no="+reader_no+"&reader_name="+reader_name+"&io="+current_io+"&current_level="+current_level+"&current_io="+current_io+"&current_rd="+current_rd+"&group_rd="+group_rd);
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
									String sql = "SELECT sec.sec_code, sec."+lang+"_desc AS sec_desc FROM dbsection sec ";
									if(checkPermission(ses_per, "12")){
										sql += "LEFT JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) "
											+ "LEFT JOIN dbusers u ON (u.dep_code = dep.dep_code) "
											+ "WHERE (u.user_name = '"+ses_user+"') ";	
									}
									sql += "ORDER BY sec.sec_code";	
									ResultSet rs = stmtQry.executeQuery(sql);
							%>			<option value="0" > <%= lb_sel_sec %> </option>
							<%		while(rs.next()){	%>
										<option value="<%= rs.getString("sec_code") %>" <%= checkDataSelected(rs.getString("sec_code"), section_code) %>><%= rs.getString("sec_code") %> - <%= rs.getString("sec_desc") %></option>
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
									String sql = " SELECT sec.sec_code, sec."+lang+"_desc AS sec_desc "
										+ " FROM dbsection sec "
										+ " LEFT JOIN dbusers u ON (u.sec_code = sec.sec_code) "
										+ " WHERE (u.user_name = '"+ses_user+"') ";	
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
											<td width="20%" align="center"> <b> <%= lb_empcode %> </b> </td>
											<td width="35%" align="center"> <b> <%= lb_names %> </b> </td>
											<td width="35%" align="center"> <b> <%= lb_thsec %> </b> </td>
											<td width="10%" align="center"> <b> <%= lb_select %> </b> </td>
										</tr>
									</thead>
					<%		
							try{
								String idcard = "", fullname = "", sec_desc = "", reader_no = "", reader_name = "";								
								String current_level = "", current_io = "", current_rd = "", group_rd = "";
								
								String sql = "SELECT emp.idcard, emp.sec_code, current_level, current_io, current_rd, group_rd, "
										+ " emp."+lang+"_fname AS fname, emp."+lang+"_sname AS sname, sec."+lang+"_desc AS sec_name, rd."+lang+"_desc AS reader_name "
										+ " FROM dbemployee emp "
										+ " LEFT OUTER JOIN dbsection sec ON (emp.sec_code = sec.sec_code) "
										+ " LEFT OUTER JOIN dbreader rd ON (emp.current_rd = rd.reader_no) ";
								if(checkPermission(ses_per, "034")){
									if((request.getParameter("keyword") != null) && (request.getParameter("keyword") != "")){										
										sql += "WHERE ((emp.idcard like '%"+keyword+"%') ";
										sql += "OR (emp."+lang+"_fname like '%"+keyword+"%') OR (emp."+lang+"_sname like '%"+keyword+"%')) ";											
										if(!(request.getParameter("section_code").equals("0") || request.getParameter("section_code").equals("null"))){				
											sql += "AND (emp.sec_code = '"+section_code+"') ";											
										}
									}else{	
										sql += "WHERE (emp.sec_code = '"+section_code+"') ";			 				
									}		
								}else{
									if(checkPermission(ses_per, "56")){
										sql += "LEFT OUTER JOIN dbusers users ON (users.sec_code = sec.sec_code) "					
											+ "WHERE (users.user_name = '"+ses_user+"') ";
									}else{
										sql += "LEFT OUTER JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
											+ "LEFT OUTER JOIN dbusers users ON (users.dep_code = dep.dep_code) "					
											+ "WHERE (users.user_name = '"+ses_user+"') ";
									}
									if((request.getParameter("keyword") != null) && (request.getParameter("keyword") != "")){		  
										sql += "AND ((emp.idcard like '%"+keyword+"%') ";
										sql += "OR (emp."+lang+"_fname like '%"+keyword+"%') OR (emp."+lang+"_sname like '%"+keyword+"%')) ";
										if(checkPermission(ses_per, "12")){
											if(!(request.getParameter("section_code").equals("0") || request.getParameter("section_code").equals("null"))){				
												sql += "AND (emp.sec_code = '"+section_code+"') ";											
											}
										}
									}else{	
										sql += "AND (emp.sec_code = '"+section_code+"') ";		 				
									}
								}
								sql += " ORDER BY emp.idcard ASC ";
								
								ResultSet rs = stmtUp.executeQuery(sql);
								while(rs.next()){	
									idcard = rs.getString("emp.idcard");																		
									fullname = rs.getString("fname")+"  "+rs.getString("sname");
									sec_desc = rs.getString("emp.sec_code");
									if(rs.getString("sec_name") != null){
										sec_desc += " - " + rs.getString("sec_name");
									}else{
										sec_desc += "";
									}
									
									reader_no = rs.getString("emp.current_rd");
									if(rs.getString("reader_name") != null){
										reader_name += rs.getString("reader_name");
									}else{
										reader_name += "";
									}
									
									current_level = rs.getString("emp.current_level");
									current_io = rs.getString("emp.current_io");
									current_rd = rs.getString("emp.current_rd");
									group_rd = rs.getString("emp.group_rd");
									
					%>
									<tr>
										<td class="pad-left-10"> <center> <%= idcard %> </center> </td>
										<td class="pad-left-10"> <div class="ellipsis_string" style="width: 250px"> <%= fullname %> </div> </td>
										<td class="pad-left-10"> <div class="ellipsis_string" style="width: 250px"> <%= sec_desc %> </div> </td>
										<td align="center">
											<img src="images/complete.gif" width="20" height="20" border="0" align="absmiddle" onMouseOver="this.style.cursor='hand';" onclick="selectEmpAntiPassback('<%= idcard %>', '<%= fullname %>', '<%= reader_no %>', '<%= reader_name %>', '<%= current_level %>', '<%= current_io %>', '<%= current_rd %>', '<%= group_rd %>', '<%= msg_no_antipassback %>', '<%= post_file %>');" data-toggle="tooltip" data-placement="left" title="<%= lb_select %>">
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