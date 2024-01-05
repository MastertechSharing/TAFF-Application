<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "report"); 	
	session.setAttribute("subpage", "database");		
	session.setAttribute("subtitle", "employee");
	session.setAttribute("action", "report_data2_pdf.jsp?file="+request.getParameter("file")+"&");
	
	boolean menu_sidebar = false;
	String width_align = "style='width: 92%; min-width: 800px; max-width: 1200px; text-align: left;'";
	String selectpicker = "";
	if( getBrowserInfo(request.getHeader("User-Agent")).contains("Internet Explorer") == false ){
		width_align = "style='min-width: 1050px; text-align: left;'";
		selectpicker = "selectpicker";
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
		
		<script type="text/javascript" src="js/check_key.js"></script>
		<script language="javascript" src="js/select_ajax.js"></script>
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
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
			function onSubmit(){		
				location.href ='report_data2_pdf.jsp?file=employee&select_section='+document.form1.select_section.value
						  +'&id1='+form1.id1.value+'&id2='+form1.id2.value+'&';
				document.form1.submit();
			}
			
			function orderBy(){				
				location.href ='report_data2_pdf.jsp?file=employee&select_section='+document.form1.select_section.value+'&';
			}		
		</script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" <% if(menu_sidebar == true){ %> style="margin-top: -50px;" <% } %> >
	
	<%	if(menu_sidebar == false){	%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
	
	<%	}else if(menu_sidebar == true){	%>
		
		<jsp:include page="left_menu.jsp?report=data" flush="true"/>
		
	<%	}	%>	
	
		<%@ include file="../tools/modal_danger.jsp"%>
		
		<div class="body-display">
			<div class="container">				
				<form id="form1" name="form1" method="post">				
			<%	
				String id1 = "";
				String id2 = "";
				String file = "";
				String section = "";
				if(request.getParameter("id1") != null){
					id1 = request.getParameter("id1");	
				}
				if(request.getParameter("id2") != null){
					id2 = request.getParameter("id2");
				}
				if(request.getParameter("file") != null){
					file = request.getParameter("file");
				}
				
				if(file.equals("employee")){
					String report_id = "tpl";
					String TempName = "tmp"+report_id+"_"+getIP(request.getRemoteAddr());
					try{
						stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
						stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,report_id,mode));
					}catch(SQLException e){
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
					}
					
					File path_file = new File(path_tpl);
					File[] listfiles = path_file.listFiles();
					String files = "";
					String fileName = "";
					int num = 0;
					if(!path_file.exists()){
						out.println("");
					}else{
						for (int i = 0; i < listfiles.length; i++) {
							if (listfiles[i].isFile()) {
								files = listfiles[i].getName();
								if (files.endsWith(".dat") || files.endsWith(".DAT")) {
									num++;
									fileName = files.substring(0,files.lastIndexOf(".",files.length()));
									
									String sql = "INSERT INTO "+TempName+"(id,idcard) VALUES('"+num+"','"+fileName+"');";
									try{
										stmtUp.executeUpdate(sql);
									}catch(SQLException e){
									//	out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
									}
								}
							}
						}
					}
				
					if(!(request.getParameter("select_section") == null || request.getParameter("select_section").equals("")
						|| request.getParameter("select_section").equals("null"))){
						section = request.getParameter("select_section"); 
					}
			%>
					<div class="table-responsive" align="center" style="border: 0px !important; margin: <% if(menu_sidebar == false){ %> -15px <% }else if(menu_sidebar == true){ %> 0px <% } %> -15px -15px -15px;">
						<div <%= width_align %> class="table" border="0">
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">								
									<div class="bs-callout bs-callout-info">										
										<p>										
										<div class="row">
											<label class="col-xs-2 col-md-2" style="margin-top: 6px; text-align: right;"> <%= lb_sect %> </label>
											<div class="col-xs-7 col-md-7"> 
											<% 	
											String sec_desc = "";
											String sql_sec = "SELECT sec.sec_code, ";	
											if(lang.equals("th")){
												sql_sec += "sec.th_desc AS sec_desc ";
											}else{
												sql_sec += "sec.en_desc AS sec_desc ";
											}
												
											if(checkPermission(ses_per, "034")){
												sql_sec += "FROM dbsection sec ORDER BY sec.sec_code";	
											}else if(checkPermission(ses_per, "12")){
												sql_sec += "FROM dbsection sec ";
												sql_sec += "LEFT JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) ";
												sql_sec += "LEFT JOIN dbusers u ON (u.dep_code = dep.dep_code) ";
												sql_sec += "WHERE (u.user_name = '"+ses_user+"') AND u.dep_code = dep.dep_code ";
												sql_sec += "ORDER BY sec.sec_code ";	
											}else if(checkPermission(ses_per, "56")){
												sql_sec += "FROM dbsection sec ";
												sql_sec += "LEFT JOIN dbusers u ON (u.sec_code = sec.sec_code) ";
												sql_sec += "WHERE (u.user_name = '"+ses_user+"') ";
												sql_sec += "AND u.sec_code = sec.sec_code ";
												sql_sec += "ORDER BY sec.sec_code ";	
											}											
											%>	
												<select name="select_section" id="select_section" onChange="orderBy();" class="form-control <%= selectpicker %>" data-live-search="true" data-width="100%" data-size="12" data-container="body" >
											<% 
											try{
												String sec_code = "";
												if(section == null) { 
													section = "";
												}
												ResultSet rs1 = stmtUp.executeQuery(sql_sec);
												while(rs1.next()){
													sec_code = rs1.getString("sec_code");														
													sec_desc = rs1.getString("sec_desc");
													if(request.getParameter("select_section") == null){
														if(section.equals("")){
															section = sec_code;
														}
													}
											%>			
													<option value ="<%= sec_code %>" <% if(section.equals(sec_code)){ %> selected <% } %>> <%= sec_code %> - <%= sec_desc %> </option>
											<%	}	
												rs1.close(); 	
											%>	
												</select>
											<%	
											}catch(SQLException e){
												out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
											}
											%>	
											</div>
											<div class="col-xs-3 col-md-3" style="margin-top: 0px; text-align: right;">
											</div>
										</div>
										<p>
										<div class="row">
											<label class="col-xs-2 col-md-2" style="margin-top: 6px; text-align: right;"> <%= lb_code %> </label>
											<div class="col-xs-2 col-md-2"> 
												<input type="text" class="form-control" name="id1" id="id1" size="12" maxlength="16" onKeyPress="IsValidCharacters()"/> 
											</div>
											<div class="col-xs-1 col-md-1"> 
												<img src="images/view.png" style="margin-left: -6px;" width="28" height="28" border="0" align="absmiddle" onClick="show_detail('iframe_data.jsp?ac=employee&sec_code=<%= section %>&mode=1&');" data-toggle="tooltip" data-placement="right" data-container="body" title="<%= lb_finddata %>"/>
											</div>
											<label class="col-xs-1 col-md-1" style="margin-top: 6px; text-align: right;"> <%= lb_to_code %> </label>
											<div class="col-xs-2 col-md-2"> 
												<input type="text" class="form-control" name="id2" id="id2" size="12" maxlength="16" onKeyPress="IsValidCharacters()"/>
											</div>
											<div class="col-xs-1 col-md-1">
												<img src="images/view.png" style="margin-left: -6px;" width="28" height="28" border="0" align="absmiddle" onClick="show_detail('iframe_data.jsp?ac=employee&sec_code=<%= section %>&mode=2&');" data-toggle="tooltip" data-placement="right" data-container="body" title="<%= lb_finddata %>"/>
											</div>
											<div class="col-xs-1 col-md-1"> &nbsp; </div>
											<div class="col-xs-2 col-md-2" style="margin-top: 0px; text-align: right;"> 
												<input type="button" class="btn btn-primary button-shadow1 button-shadow2" name="look23" onClick="onSubmit()" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onMouseOver="this.style.cursor='hand';"> &nbsp;												
											</div>
										</div>
									</div>
								</div>
							</div>			
						</div>
					</div>	
				<%	}	%>
				
				</form>
				
				<div class="table-responsive" align="center" style="border: 0px !important; margin: -25px -15px -55px -15px;">
					<div <%= width_align %> class="table" border="0">
						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">							
								<div class="bs-callout bs-callout-info"> 
									<div class="row" align="center">								
										<iframe name="show_body" width="97%" height="700" src="ReportData2.do?lang=<%= lang %>&id1=<%= id1 %>&id2=<%= id2 %>&file=employee&select_section=<%= section %>&username=<%= ses_user %>&sesper=<%= ses_per %>&" frameborder="0" scrolling="yes"></iframe>
									</div>
								</div>							
							</div>
						</div>					
					</div>
				</div>
			
				<%@	include file="../tools/modal_viewdetail.jsp"%>	
			</div>
		</div>
	
	<%	if(menu_sidebar == true){	%>
		</div>
	<%	}	%>	
	
		<script>
		function show_detail(show_page){
			view_detail.location = show_page;
			$('#myModalViewDetail').modal('show');
		}
		
		//	Menu Sidebar for IE
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
		</script>
		
		<%	session.setAttribute("page_jsp", "report_data1_pdf.jsp");	%>
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@	include file="../function/disconnect.jsp"%>