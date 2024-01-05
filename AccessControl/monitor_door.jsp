<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>

<%	
	session.setAttribute("page_g", "index"); 
	session.setAttribute("subpage", "home");
	session.setAttribute("subtitle", "door");
	session.setAttribute("action", "monitor_door.jsp?");
	
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
		out.println("<script> document.location='monitor_door.jsp'; </script>");
	}else{
		try{
			ResultSet rs_location = stmtQry.executeQuery("SELECT monitor_location FROM dbusers WHERE (user_name = '"+ses_user+"') ");
			if(rs_location.next()){
				locate_select = rs_location.getString("monitor_location").split(",");
			}
			rs_location.close();
		}catch(Exception e){ }
	}	
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->	
		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
			
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>	
			
		<style>
			.button-hover span {
				font-family: 'tahoma', 'Glyphicons Halflings';
				cursor: pointer;
				display: inline-block;
				position: relative;
				transition: 0.5s;
			}
			.button-hovershow span:after {
				content: '\e079';
				position: absolute;
				opacity: 0;
				top: 0;
				left: -10px;
				transition: 0.5s;
			}
			.button-hoverhide span:after {
				content: '\e080';
				position: absolute;
				opacity: 0;
				top: 0;
				left: -10px;
				transition: 0.5s;
			}
			.button-hover:hover span { padding-left: 15px; }
			.button-hover:hover span:after { opacity: 1;  left: 0; }
		</style>		
		
		<script>
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
			function hide_status_error(){
				$("#subtable_right").fadeOut(700);
				setTimeout(function(){
					$("#table_left").animate({"width" : "100%"}, 1000);
					$("#table_right").toggle("slide", {direction: 'right'}, 1000);
				}, 700);
				
				$("#hide_err").fadeOut(300);
				setTimeout(function(){
					$("#show_err").fadeIn(500);
					document.getElementById('MyiFrame2').src = "about: blank";
				}, 1500);
			}
			
			function show_status_error(){
				document.getElementById('MyiFrame2').src = "monitor_door_right.jsp?";
			
				$("#table_left").animate({"width" : "73%"}, 1000);
				$("#table_right").toggle("slide", {direction: 'right'}, 1000);
				setTimeout(function(){
					$("#subtable_right").fadeIn(700);
				}, 1000);
				
				$("#show_err").fadeOut(300);
				setTimeout(function(){
					$("#hide_err").fadeIn(500);
				}, 1200);
			}
			
			function hide_table_right(){
				$("#table_right").toggle("slide", {direction: 'right'}, 1000);
			}
		</script>
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="hide_table_right();">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">	
				
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
									<input name="pop_view" type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="pop_view" value=" &nbsp; <%= lb_viewrow %> &nbsp; " onClick="ShowPreViewMap('2')" onMouseOver="this.style.cursor='hand'">
								</div>
							</div>
						</div>
					</div>
				</form>
				
				<form name="form1" id="form" method="post"> </form>
				
			</div>
		</div>
		
		<div class="table-responsive" style="border: 0px !important; min-width: 320px; max-width: 100%; min-height: 510px; margin-top: -10px;" border="0">
			<div style="min-width: 1345px; max-width: 100%;" class="table" align="center" border="0">
				<table style="width: 100%;" align="left" id="table_left" border="0">
					<tr>
						<td>
							<table width="100%" class="table" align="center" border="0" style="margin-bottom: -15px">
								<tr>
									<td width="9%" height="28px" align="center"> <label> <%= lb_location %> </label> </td>
									<td width="3%" height="28px" align="left"> 
										<i class="glyphicon glyphicon-search" onClick="show_detail('<%= lb_detail_doorcolor %>');" style="cursor: pointer; cursor: hand;" data-toggle="tooltip" data-placement="right" title="<%= lb_detail_doorcolor %>"> </i> 
									</td>
									<td width="63%" align="center"> <label> <%= lb_door %> </label> </td>
									<td width="23%" align="right">
										<button class="btn btn-primary btn-xs button-shadow1 button-shadow2 button-hover button-hoverhide" id="hide_err" onClick="hide_status_error();" style="cursor: pointer; cursor: hand; display: none;">
											<span>&nbsp;<%= lb_hide %> <%= lb_trans_err %>&nbsp;</span>
										</button>
										<button class="btn btn-primary btn-xs button-shadow1 button-shadow2 button-hover button-hovershow" id="show_err" onClick="show_status_error();" style="cursor: pointer; cursor: hand;">
											<span>&nbsp;<%= lb_show %> <%= lb_trans_err %>&nbsp;</span>
										</button>
									</td>
									<td width="2%"> </td>
								</tr> 
								<tr>   
									<td colspan="5" align="center">
										<iframe name="MyiFrame" id="MyiFrame" src="monitor_door_left.jsp?" frameborder="0" scrolling="yes" align="center" width="100%" height="466px"> </iframe>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				
				<table style="width: 27%;" align="right" id="table_right" border="0">
					<tr>
						<td>
							<table width="100%" class="table" align="center" id="subtable_right" border="0" style="margin-bottom: -15px; display: none;">
								<tr>
									<td width="15%" height="28px" align="center">
										<i class="glyphicon glyphicon-search" onClick="show_detail('<%= lb_detail_doorcolor %>');" style="cursor: pointer; cursor: hand;" data-toggle="tooltip" data-placement="right" title="<%= lb_detail_doorcolor %>"> </i> 
									</td>
									<td width="85%" align="center"> <label> <%= lb_trans_err %> </label> </td>
									<td width="30" height="25" align="center" class="text_green">
										<a href="monitor_door_excel.jsp">
											<img src="images/excelimg.png" width="22" height="22" onMouseOver="this.style.cursor='hand'" data-toggle="tooltip" data-placement="left" title="excel <%= lb_trans_err %>">
										</a>
									</td>
								</tr> 
								<tr>   
									<td width="100%" colspan="3" align="left">
										<iframe name="MyiFrame2" id="MyiFrame2" src="about: blank" frameborder="0" scrolling="yes" align="center" width="100%" height="466px"></iframe>
									</td>	
								</tr>
							</table>
						</td>
					</tr>
				</table>
			
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <p id="text_header"> </p> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; height: 450px;" border="0">
							<iframe src="#" id="view_detail2" name="view_detail2" frameborder="0" height="440px" style="min-width: 850px; "></iframe>
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
			function view_select(){
				document.form_select.action = "monitor_door.jsp?action=save";
				document.getElementById("form_select").submit();
			}
			
			function ShowPreViewMap(data){
				if(data == '1'){
					location.href = "monitor_map.jsp?";
				}else if(data == '2'){
					location.href = "monitor_row.jsp?";
				}
			}
			
			function show_detail(text_header){ 
				document.getElementById("text_header").innerHTML = text_header;
				parent.view_detail2.location = 'monitor_door_help.jsp';
				$('#myModalViewDetail2').modal('show');
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
					/*	//	Check Flash On/Off
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