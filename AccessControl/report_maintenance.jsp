<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%	
	session.setAttribute("page_g", "special"); 	
	session.setAttribute("subpage", "others");
	session.setAttribute("subtitle", "maintenance");
	session.setAttribute("action", "report_maintenance.jsp?");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<script language="javascript" src="js/select_ajax.js"></script>
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/check_key.js"></script> 
		<script language="javascript" src="js/alert_box.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet"> 
		<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
		<script src="js/locales/bootstrap-datetimepicker.th.js" charset="UTF-8"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script>
			document.onkeydown = searchKeyPress_Report;
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>	
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" isReady="true">
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<div class="body-display">
			<div class="container">
			
				<form id="form1" name="form1" method="post">
	
					<div class="table-responsive" style="border: 0px !important; margin-bottom: -15px; margin-left: -15px; margin-right: -15px;" border="0">
						<div style="min-width: 1000px;" class="table" border="0">
								
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title col-xs-12 col-md-12">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-edit"> </i> &nbsp; [ <%= lb_reportdata %> ] </label>
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_date %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<div class="input-group col-md-12">
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; max-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="st_date" name="st_date" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div>
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_to_date %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<div class="input-group col-md-12">
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="ed_date" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; max-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="ed_date" name="ed_date" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_to_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 6px;"> <div align="right"> <b> <%= lb_username %> <%= lb_adddata %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<input type="text" class="form-control" id="uname_add" name="uname_add" style="max-height: 28px !important;">
											</div>
											<div class="modal-title col-xs-6 col-md-6"> </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 6px;"> <div align="right"> <b> <%= lb_username %> <%= lb_editdata %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<input type="text" class="form-control" id="uname_edit" name="uname_edit" style="max-height: 28px !important;">
											</div>
											<div class="modal-title col-xs-5 col-md-5" align="right">
												<input type="button" name="Button" id="pdf" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_report_pdf %> &nbsp; &nbsp; &nbsp; " style="max-height: 24px !important;" onClick="Javascript: fncSubmit('pdf', '<%= lang %>');" onMouseOver="this.style.cursor='hand';" > &nbsp;
												<input type="button" name="Button" id="excel" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_report_excel %> &nbsp; &nbsp; &nbsp; " style="max-height: 24px !important;" onClick="Javascript: fncSubmit('excel', '<%= lang %>');"  onMouseOver="this.style.cursor='hand';" >
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
									</div>
								</div>		
							</div>
						
						</div>
					</div>
				
				</form>
				
			</div>
		</div>
		
		<script>
			function fncSubmit(strPage, lang){
				if(strPage == "pdf"){		
					document.form1.action = "report_maintenance_pdf.jsp?rep_id=_ma";	
				}else if(strPage == "excel"){
					document.form1.action = "report_maintenance_excel.jsp?rep_id=_ma";
				}
				document.form1.submit();
			}
		</script>

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