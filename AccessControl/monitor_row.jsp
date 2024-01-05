<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>

<%	
	session.setAttribute("page_g", "index"); 
	session.setAttribute("subpage", "home");
	session.setAttribute("subtitle", "row");
	session.setAttribute("action", "monitor_row.jsp?");
	
	String[] locate_select = new String[0];
	if(request.getParameter("action") != null && request.getParameter("action").equals("save")){
		String location_set = "";
		if(request.getParameterValues("locate_select") != null){			
			locate_select = request.getParameterValues("locate_select");
			if(!locate_select[0].equals("")){
				for(int i = 0; i < locate_select.length; i++){
					location_set += locate_select[i]+",";
				}
				location_set = location_set.substring(0, (location_set.length() -1));
			}
		}
		stmtQry.executeUpdate("UPDATE dbusers SET monitor_location = '"+location_set+"' WHERE (user_name = '"+ses_user+"') ");		
		//	Remove sessionStorage [ Key ] > li_location & locate_code
		out.println("<script> sessionStorage.removeItem('li_location'); sessionStorage.removeItem('locate_code'); </script>");
		out.println("<script> document.location='monitor_row.jsp'; </script>");
	}else{
		try{
			ResultSet rs_location = stmtQry.executeQuery("SELECT monitor_location FROM dbusers WHERE (user_name = '"+ses_user+"') ");
			if(rs_location.next()){
				locate_select = rs_location.getString("monitor_location").split(",");				
			}
			rs_location.close();
		}catch(Exception e){ }
	}
	
	String locate_box = "";
	try{
		if(!locate_select[0].equals(""))
			locate_box = locate_select[0];
	}catch(Exception e){ }
	
	String lb_view = lb_viewdata;
	if(lang.equals("en")) lb_view = "View";
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/ajax_datamonitor.js"></script>
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			.bs-callout-info-border {
			  border-left-color: #d9534f;
			}
			.bs-callout-border {
			  padding: 10px;
			  margin: 10px 0;
			  border: 1px solid #d9534f;
			  border-left-width: 5px;
			  border-radius: 3px;
			}
			
			.slide_text {
			  display: inline-block; 
			  text-align: left; 
			  width: 50px;
			  transition: all 0.5s;
			  cursor: pointer;
			  margin: 5px;
			}
			.slide_text span {
			  cursor: pointer;
			  display: inline-block;
			  position: relative;
			  width: 60px;
			  transition: 0.5s;
			}
			.slide_text span:after {
			  content: '<%= lb_view %>';
			  position: absolute;
			  font-weight: bold;
			  opacity: 0;
			  top: 0;
			  right: -15px;
			  transition: 0.5s;
			}
			.slide_text:hover span {
			  // padding-right: 50px;
			}
			.slide_text:hover span:after {
			  opacity: 1;
			  right: 0;
			}
		</style>
		
		<script>
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
			function view_select(){
				document.form_select.action = "monitor_row.jsp?action=save";
				document.getElementById("form_select").submit();
			}
		</script>
	</head>
	

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
		<input type="hidden" name="hidden" id="data_page" value="map">
		<input type="hidden" name="hidden" id="lang" value="<%= lang %>">
		<input type="hidden" name="hidden" id="data_host" value="<%= hostIPAddr %>">
		<input type="hidden" name="hidden" id="data_port" value="<%= port4 %>">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>

		<div class="body-display">
			<div class="container">
				
			<%	//	if(!locate_box.equals("")){	%>
		<!--		<div style="max-height: 0px !important; text-align: center;">
					<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="FlexClient" width="0" height="0" codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
						<param name="movie" value="ClientReciveFlex.swf" />
						<param name="quality" value="high" />
						<param name="bgcolor" value="#FFFFFF" />
						<param name="allowScriptAccess" value="sameDomain" />
						<embed src="flash/ClientReciveFlex.swf" quality="high" bgcolor="#FFFFFF"  width="482" height="348" name="FlexClient" align="middle" style="max-height: 0px !important;"
							play="true" loop="false" quality="high" allowScriptAccess="sameDomain" type="application/x-shockwave-flash"
							pluginspage="http://www.adobe.com/go/getflashplayer">
						</embed>
					</object>
				</div>	-->
			<%	//	}	%>
				
				<form id="form_select" name="form_select" method="post" action="monitor_row.jsp?action=save">
					
					<div class="table-responsive" style="border: 0px !important;" border="0">
						<div class="table" style="min-width: 1000px; min-height: 30px;" align="left" border="0">
							<div class="col-xs-2" style="margin-left: -15px;">
								<label style="margin-left: 50px; margin-top: 6px;"> <i class="glyphicon glyphicon-th-large"> </i> <%= lb_location %> </label>
							</div>
							<div class="col-xs-6">
								<select id="locate_select" name="locate_select" class="selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" multiple data-actions-box="true" onChange="change_select();">
							<%	try{									
									String sql = selectDbLocationByHost();
									ResultSet rsLoc = stmtQry.executeQuery(sql);
									while(rsLoc.next()){
							%>			<option value="<%= rsLoc.getString("locate_code") %>" <%= checkSelectQryDataList(rsLoc.getString("locate_code"), locate_select) %> > <%= rsLoc.getString("locate_code") %> <% if(lang.equals("th")){ out.println(rsLoc.getString("th_desc")); }else{  out.println(rsLoc.getString("en_desc")); } %> </option>
							<%		}
									rsLoc.close();
								}catch(SQLException e){							
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
								}
							%>	</select>
							</div>
							<div class="col-xs-1" align="left"> 
								<input type="button" id="btn1" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="view_select();" />
							</div>
							<div class="col-xs-3" align="right">
								<div style="margin-right: -30px">
									<input name="pop_view" type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="pop_view" value=" &nbsp; <%= lb_viewmap %> &nbsp; " onClick="ShowPreViewMap('1')" onMouseOver="this.style.cursor='hand'"> &nbsp;
									<input name="pop_view" type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="pop_view" value=" &nbsp; <%= lb_viewdoor %> &nbsp; " onClick="ShowPreViewMap('2')" onMouseOver="this.style.cursor='hand'">
								</div>
							</div>
						</div>
					</div>
				</form>
		
			</div>
		</div>
		
		<center>
		<div class="table-responsive" style="border: 0px !important; min-width: 320px; max-width: 1330px; margin-top: -15px;" border="0">
			<div style="min-width: 670px; max-width: 1330px;" class="table" align="center" border="0">	
				
			<%	
					if(!(locate_box.equals("")) ){						
						for(int i = 0; i < locate_select.length; i++){
							locate_box = locate_select[i];							
							String locate_desc = "";
							ResultSet rs_locate_desc = stmtQry.executeQuery("SELECT * FROM dblocation WHERE (locate_code = '"+locate_box+"') ");
							while(rs_locate_desc.next()){
								if(lang.equals("th")){
									locate_desc = rs_locate_desc.getString("th_desc");
								}else{
									locate_desc = rs_locate_desc.getString("en_desc");
								}
							}
							rs_locate_desc.close();
							
							String set_col_md = "col-md-6", set_div_col_md = "col-md-12";
							ResultSet rs_count_door = stmtQry.executeQuery("SELECT COUNT(door_id) AS d_door_id FROM dbdoor WHERE (locate_code = '"+locate_box+"') ");
							if(rs_count_door.next()){
								if(rs_count_door.getInt("d_door_id") > 1){
									set_col_md = "col-md-12";
									set_div_col_md = "col-md-6";
								}
							}
			%>
				<div class="<%= set_col_md %>" style="margin-left: 0px; margin-right: 0px;">
					
					<div style="border: 0px !important; margin-bottom: 10px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout-border bs-callout-info-border"> 
							<div class="row alert-message-danger" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
								<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-map-marker"> </i> &nbsp; <strong> <span onClick="show_detail3('<%= locate_box %>');" style="color: #337AB7; cursor: pointer; cursor: hand;" data-toggle="tooltip" data-placement="left" title="<%= lb_viewdata %>"> <%= locate_box %> </span> : <%= locate_desc %> </strong> </label>
							</div>
							<div class="row" align="center" style="border: 0px !important; margin-bottom: -5px; margin-left: -10px; margin-right: 0px;">
			<%		
							String sql = "SELECT d.* FROM dbdoor d "
								+ "LEFT OUTER JOIN dblocation l on (d.locate_code = l.locate_code) "
								+ "WHERE (d.locate_code = '"+locate_box+"') "
								+ "ORDER BY d.door_id asc ";
							String door_id = "", ip_address = "", th_desc = "";		
							int numtaff = 0;
							try{
								ResultSet rs = stmtQry.executeQuery(sql);
								while(rs.next()){ 
									door_id = rs.getString("door_id");
									ip_address = rs.getString("ip_address");	
									if(lang.equals("th")){
										if((rs.getString("th_desc") != null) && (!rs.getString("th_desc").equals(""))){
											th_desc = rs.getString("th_desc");						
										}
									}else{
										if((rs.getString("en_desc") != null) && (!rs.getString("en_desc").equals(""))){
											th_desc = rs.getString("en_desc");						
										}
									}	
			%>	
			
								<div class="<%= set_div_col_md %>" style="height: 110px; margin-bottom: 20px;">
									<table width="600px" height="120px" border="0" cellspacing="0" cellpadding="0" background="images/pp-4.gif" style="background-repeat: no-repeat; margin-bottom: 20px;">
										<tr id="door_<%= door_id %>">
											<td>
												<table width="610" border="0" cellspacing="0" cellpadding="0" style="margin-top: -10px;">
													<tr>
														<td width="95"> 
														<!--	<span class="glyphicon glyphicon-search" onClick="show_detail_tran('<%= door_id %>', '<%= th_desc %>');" style="cursor: pointer; cursor: hand; margin-top: 5px;" data-toggle="tooltip" data-placement="left" title="<%= lb_detailcardmas %>"> </span> &nbsp; 	-->
														<a herf="#" class="slide_text"> <span class="glyphicon glyphicon-info-sign" style="vertical-align: absmiddle; cursor: pointer; cursor: hand; margin-top: 5px; font-size: 12px;" onClick="show_detail_tran('<%= door_id %>', '<%= th_desc %>');" data-toggle="tooltip" data-placement="left" title="<%= lb_detailcardmas %>"> </span> </a>
														<!--	<label> <%= lb_viewdata %> </label>		-->
														</td>
														<td width="320" class="pad-left-10"> 
															<div class="ellipsis_string" style="width: 300px;"> &nbsp; &nbsp; 
																<label> <span onClick="show_detail2('<%= door_id %>', 'door_detail');" style="color: #337AB7; cursor: pointer; cursor: hand;" data-toggle="tooltip" data-placement="left" title="<%= lb_viewdata %>"> <%= door_id %> </span> : </label> <%= th_desc %> 
															</div> 
														</td>
														<td width="185" class="pad-left-10" colspan="2"> 
															<label> <%= lb_date %> : </label> <span id="date_<%= door_id %>"> </span> 
														</td>
													</tr>
													<tr>
														<td colspan="3">
															<table id="tb_door_event_<%= door_id %>" width="505" border="0" cellspacing="0" cellpadding="0" style="margin-left: 0px; margin-top: -10px;">
																<tr>
																	<td width="90" align="center" id="imgdoor_<%= door_id %>"> <img src="images/close_door.gif" width="24" height="24" border="1" style="cursor: default; margin-top: 3px;" align="absmiddle"> </td>
																	<td width="120" align="left" class="pad-left-10"> <label> <%= lb_eventdoor %> </label> </td>
																	<td width="290" align="left" class="pad-left-10"> <div class="ellipsis_string" style="max-width: 270px;"> <label data-toggle="tooltip" data-placement="left" title="<%= lb_viewdata %>"> <span id="door_event_<%= door_id %>"> </span> </label> </div> </td>
																</tr>
																<tr>
																	<td align="center"> <label> <span id="door_duty<%= door_id %>"></span> </label> </td>
																	<td align="left" class="pad-left-10"> <label> <%= lb_empcode %> </label> </td>
																	<td align="left" class="pad-left-10"> <label data-toggle="tooltip" data-placement="left" title="<%= lb_viewdata %>"> <span id="tb_emp_<%= door_id %>"> </span> </label> </td>
																</tr>
																<tr>
																	<td> &nbsp; </td>
																	<td align="left" class="pad-left-10"> <label> <%= lb_names %> </label> </td>
																	<td align="left" class="pad-left-10"> <span id="tb_names_<%= door_id %>"></span> </td>
																</tr>
															</table>
														</td>
														<td width="100">
															<table id="tb_pic_<%= door_id %>" width="100%" height="100%" align="center" border="0" cellpadding="0" cellspacing="0" style="margin-top: -15px;">
																<tr>
																	<td>
																		<img src="photos/person.png" style="cursor: default;" width="75" height="75" align="center" id="img_emp_<%= door_id %>">
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</div>
			<% 
									numtaff++;
								}	rs.close();
							}catch(SQLException e){							
								out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
							}	
			%>
							</div>
						</div>
					</div>
				</div>
			<%	
						}
					}
			%>		
		
			</div>
		</div>
		</center>
		
		<form name="form1" id="form" method="post" >
			<input type="hidden" name="server_port" value="<%= port3 %>">
		</form>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; height: 450px;" border="0">
							<iframe src="" id="view_detail2" name="view_detail2" frameborder="0" width="850px" height="440px" ></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; height: 265px;" border="0">
							<iframe src="" id="view_detail3" name="view_detail3" frameborder="0" width="850px" height="255px" ></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetailTran" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_door %> <span id="text_head"> </span> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; height: 430px;" border="0">
							<iframe src="" id="view_detail_tran" name="view_detail_tran" frameborder="0" width="850px" height="420px"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-md-6 col-xs-6" align="left">
							<input type="button" name="Button" id="pdf" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_report_pdf %> &nbsp; &nbsp; &nbsp; " onClick="Javascript:fncSubmit_Page('pdf', '<%= lang %>');" onMouseOver="this.style.cursor='hand';" > &nbsp;
							<input type="button" name="Button" id="excel" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_report_excel %> &nbsp; &nbsp; &nbsp; " onClick="Javascript:fncSubmit_Page('excel', '<%= lang %>');" onMouseOver="this.style.cursor='hand';" >
						</div>
						<div class="col-md-6 col-xs-6">
							<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="../tools/modal_fix_flash.jsp"%>
		
		<script type="text/javascript" language="javascript">
			function ShowPreViewMap(data){
				if(data == '1'){
					location.href = "monitor_map.jsp?";
				}else if(data == '2'){
					location.href = "monitor_door.jsp?";
				}
			}
			
			function show_detail2(sCode, type){
				if(type == 'door_detail'){
					parent.view_detail2.location = 'view_door.jsp?action=view&door_id='+sCode;
				}else if(type == 'event_detail'){
					parent.view_detail2.location = 'view_event.jsp?action=view&event_code='+sCode;
				}else if(type == 'employee_detail'){
					parent.view_detail2.location = 'view_employee.jsp?action=view&idcard='+sCode;
				}
				$('#myModalViewDetail2').modal('show');
			}
			
			function show_detail3(locate_code){
				parent.view_detail3.location = 'view_location.jsp?action=view&locate_code='+locate_code;
				$('#myModalViewDetail3').modal('show');
			}
			
			var door_id = "";
			var door_desc = "";
			function show_detail_tran(sCode, sText){
				document.getElementById("text_head").innerHTML = sCode +" : "+ sText;
				parent.view_detail_tran.location = 'monitor_map_detail.jsp?door_id='+sCode;
				$('#myModalViewDetailTran').modal('show');
				
				door_id = sCode;
				door_desc = sText;
			}
			
			function fncSubmit_Page(strPage, lang){	
				if(strPage == "pdf"){		
					document.form1.action = "report_monitor_detail_pdf.jsp?door_id="+door_id+"&door_desc="+door_desc+"&lang="+lang+"&rep_id=_monitor";
					form1.target = "_blank";
				}else if(strPage == "excel"){
					document.form1.action = "report_monitor_detail_excel.jsp?door_id="+door_id+"&door_desc="+door_desc;
				}
				document.form1.submit();
			}
			
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
					$('body').addClass('loaded');
					setTimeout(function(){
						
						const host = $('#data_host').val();
						const port4 = $('#data_port').val();
						const source = new EventSource('http://'+host+':'+port4+'/sse');
						source.onmessage = (ev) => {
						//	console.log(ev.data);
							var d = JSON.parse(ev.data); 
							var data = {id:d.idcard, data_date:d.data_date, data_time:d.data_time, readerid:d.readerid, event_code:d.event_code};
							
							get_datatransaction(data);	
							displaydata(data);
						}
					
					/*
						//	Check Flash On/Off
						checkFlash();
						//	Check browser show fix problems with Flash.
						checkBrowserFixFlash();
					*/
					}, 300);
				}
			}
		</script>

		<jsp:include page="footer.jsp" flush="true"/>

	</body>
</html>
<%@ include file="../function/disconnect.jsp"%>