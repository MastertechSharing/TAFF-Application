<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "others");
	session.setAttribute("subtitle", "logdata");
	session.setAttribute("action", "view_logdata.jsp?");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
		<script src="js/locales/bootstrap-datetimepicker.th.js" charset="UTF-8"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

		<style>
			.bs-callout-info {
				border-left-color: #1b809e;
			}
			.bs-callout {
				padding: 10px;
				margin: 10px 0;
				border: 1px solid #1b809e;
				border-left-width: 5px;
				border-radius: 3px;
			}
		</style>
		
		<script>
			function submitform(){
				document.forms["form1"].submit();
			}
		</script>
	
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>

		<div class="body-display">
			<div class="container">
			
				<div class="table-responsive" style="border: 0px !important; margin-bottom: -25px; margin-left: -15px; margin-right: -15px;" border="0">
					<div style="min-width: 1080px;" class="table" border="0">
					
						<form id="form1" name="form1" method="post" action="view_logdata.jsp"> 
						
					<%	
						String date_check = "";
						if(request.getParameter("theDate") == null){	
							date_check = getCurrentDate();
						}else{
							date_check = request.getParameter("theDate");
						}
					%> 
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">
								
									<div class="bs-callout bs-callout-info" style="margin-bottom: 0px;"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;" align="right">
											<label class="col-xs-12 col-md-12">
												<div class="input-group">
													<label style="margin-right: 150px; margin-top: 6px;"> <%= lb_date %> </label>
													<div class="input-group date form_date" style="margin-top: -30px; margin-right: -3px;" data-date="" data-date-format="dd/mm/yyyy" data-link-field="theDate" data-link-format="dd/mm/yyyy">
														<input type="text" id="theDate" name="theDate" class="form-control" style="max-height: 28px !important; max-width: 100px !important;" value="<%= date_check %>" onChange="submitform();" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important; color: #555555;"></span></span>
													</div>
												</div>
											</label>
										</div>
										<p>
										<div class="row" style="margin-bottom: 0px;">
											<div class="modal-title col-xs-12 col-md-12">											
												<textarea class="form-control" style="min-width: 100%; max-width: 100%; min-height: 440px; max-height: 440px; overflow-x: scroll; word-wrap: normal; background-color: #ffffff; resize: none;" readonly><%	
												
												String fileName = path_log+"Web\\"+getCurrentDate().substring(6, 10)+"\\"+getCurrentDate().substring(3, 5)+"\\"+date_check.substring(6,10)+date_check.substring(3,5)+date_check.substring(0,2)+".LOG";	
												File f = new File(fileName);
												if(f.exists()){
													BufferedReader in = new BufferedReader(new FileReader(fileName));
													String text_string = new String();
													while ((text_string = in.readLine()) != null){														
														out.println(text_string);														
													}
													in.close();
												}
											%></textarea>
											</div>
										</div>
									</div>
									
								</div>
							</div>
						
						</form>

					</div>
				</div>

			</div>
		</div>	

		<script language="javascript">
			$('.form_date').datetimepicker({
				language:  '<%= lang %>',
				weekStart: 1,
				todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0
			});
		</script>						

		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>