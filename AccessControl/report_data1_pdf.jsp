<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "report"); 	
	session.setAttribute("subpage", "database");
	session.setAttribute("subtitle", request.getParameter("file"));
	session.setAttribute("action", "report_data1_pdf.jsp?file="+request.getParameter("file")+"&");
	
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
				document.form1.submit();
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
				String main = "";
				if(request.getParameter("id1") != null){
					id1 = request.getParameter("id1");	
				}
				if(request.getParameter("id2") != null){
					id2 = request.getParameter("id2");
				}		
				if(request.getParameter("file") != null){
					file = request.getParameter("file");
				}
				if(request.getParameter("hid") != null){
					file = request.getParameter("hid");
				}
						
			%>
					<div class="table-responsive" align="center" style="border: 0px !important; margin: <% if(menu_sidebar == false){ %> -15px <% }else if(menu_sidebar == true){ %> 0px <% } %> -15px -15px -15px;">
						<div <%= width_align %> class="table" border="0">
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">								
									<div class="bs-callout bs-callout-info"> 										
										<p>
										<div class="row">
										<%//	if(menu_sidebar == false){	%>
											<label class="col-xs-2 col-md-2" style="margin-top: 6px; text-align: right;"> <%= lb_code %> </label>
										<%//	}else if(menu_sidebar == true){	%>
										<!--	<label class="col-xs-1 col-md-1" style="margin-top: 0px; text-align: left;"> 
												<a href="#menu-toggle" class="btn btn-default btn-sm max-height-26 button-shadow1 button-shadow2" id="menu-toggle"> &nbsp; <i class="glyphicon glyphicon-th-list"></i> &nbsp; <%= lb_menu %> &nbsp; </a>
											</label>
											<label class="col-xs-1 col-md-1" style="margin-top: 6px; text-align: right;"> <%= lb_code %> </label>
										-->
										<%//	}	%>
											<div class="col-xs-2 col-md-2"> 
												<input type="text" class="form-control" name="id1" id="id1" size="12" maxlength="16" onKeyPress="IsValidCharacters()"/> 
											</div>
											<div class="col-xs-1 col-md-1"> 
												<img src="images/view.png" style="margin-left: -6px;" width="28" height="28" border="0" align="absmiddle" onClick="show_detail('iframe_data.jsp?ac=<%=file%>&mode=1&');" data-toggle="tooltip" data-placement="right" data-container="body" title="<%= lb_finddata %>"/>
											</div>
											<label class="col-xs-1 col-md-1" style="margin-top: 6px; text-align: right;"> <%= lb_to_code %> </label>
											<div class="col-xs-2 col-md-2"> 
												<input type="text" class="form-control" name="id2" id="id2" size="12" maxlength="16" onKeyPress="IsValidCharacters()"/>
											</div>
											<div class="col-xs-1 col-md-1">
												<img src="images/view.png" style="margin-left: -6px;" width="28" height="28" border="0" align="absmiddle" onClick="show_detail('iframe_data.jsp?ac=<%=file%>&mode=2&');" data-toggle="tooltip" data-placement="right" data-container="body" title="<%= lb_finddata %>"/>
											</div>
											<div class="col-xs-1 col-md-1"> &nbsp; </div>
											<div class="col-xs-2 col-md-2" style="margin-top: 0px; text-align: right;"> 
												<input type="button" class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" name="look23" onClick="onSubmit()" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onMouseOver="this.style.cursor='hand';"> &nbsp;
												<input type="hidden" id="hid" name="hid" value="<%= file %>" readonly>
											</div>
										</div>
									</div>									
								</div>
							</div>							
						</div>
					</div>
				</form>

				<div class="table-responsive" align="center" style="border: 0px !important; margin: -25px -15px -55px -15px;">
					<div <%= width_align %> class="table" border="0">
						
						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">
							
								<div class="bs-callout bs-callout-info"> 
									<div class="row" align="center">
										<iframe name="show_body" width="97%" height="700" src="ReportData1.do?lang=<%= lang %>&id1=<%= id1 %>&id2=<%= id2 %>&file=<%= file %>&username=<%= ses_user %>&sesper=<%= ses_per %>" frameborder="0" scrolling="yes"></iframe>
									</div>
								</div>
							
							</div>
						</div>
					
					</div>
				</div>
				
			</div>
		</div>
		
	<%	if(menu_sidebar == true){	%>
		</div>
	<%	}	%>	
	
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_finddata %> </h4>
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