<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "special"); 
	session.setAttribute("subpage", "deletedata");
	session.setAttribute("subtitle", "transaction");	
	session.setAttribute("action", "delete_transaction.jsp?");
	String text_result = "", type_alert = "success", type_glyphicon = "ok-circle";
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script language="javascript" src="js/check_key.js"></script>
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/alert_box.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
		<script src="js/locales/bootstrap-datetimepicker.th.js" charset="UTF-8"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script type="text/javascript">
		//	document.onkeydown = searchKeyPress_tool;
			
			function checkdate(lang){
				var text_warning = "";
				var olddays = form1.hiddate.value;
				var days = form1.date.value;			
				var d1 = olddays.substring(6,10)+''+olddays.substring(3,5)+''+olddays.substring(0,2);
				var d2 = days.substring(6,10)+''+days.substring(3,5)+''+days.substring(0,2);
				if(d2 > d1){
					if(lang == 'th'){
						text_warning = 'วันที่ต้องไม่เกิน  '+olddays;
					}else{
						text_warning = 'Date not later than '+olddays;
					}
					ModalWarning_TextName(text_warning, "");
					form1.date_show.value = olddays;
					form1.date.value = olddays;
					return false;
				}else{
					return true;
				}
			}
			
			function onSubmit(sText, lang){
				document.getElementById("text_confirm").innerHTML = sText;
				$('#myModalConfirm').modal('show');
			}
			
			function Confirm_Button(){
				var dates = form1.date.value;
				location.href = 'delete_transaction.jsp?date='+dates;
				document.form1.submit(); 
			}
		</script>
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<br/>
		
		<%@ include file="../tools/modal_result.jsp"%>
		<%@ include file="../tools/modal_warning.jsp"%>
		
		<div class="body-display">
			<div class="container">
			
				<div class="col-md-1"> </div>
				<div class="col-md-10">
					<form name="form1" id="form1" method="post">
						<div class="panel panel-primary"> 
							<div class="panel-heading">
								<h3 class="panel-title"> <b> <%= lb_del_trans %> </b> </h3> 
							</div> 
							<div class="panel-body"> 
							
								<div class="table-responsive" style="border: 0px !important;" border="0">
									<div style="min-width: 500px; max-width: 100%; margin-left: 15px; margin-right: 15px;" border="0">
									
							<%	
									String sql = "";
									ResultSet rs = null;									
									int IntDays = getKeepDays(stmtQry);									
									String mydate = YMDTodate(decDayCalendar(getCurrentDateyyyyMMdd(),IntDays));													
									String dates = "";
									if((request.getParameter("date")==null || request.getParameter("date").equals(""))){	
										dates = dateToYMD(mydate);
									}else{
										dates = dateToYMD(request.getParameter("date"));										
										try{	
											stmtUp.executeUpdate("DELETE FROM dbtransaction WHERE (date_event < '"+dates+"')"); // คำสั่ง 1						
											stmtUp.executeUpdate("DELETE FROM dbtransaction_ev WHERE (date_event < '"+dates+"')"); // คำสั่ง 2
											stmtUp.executeUpdate("DELETE FROM dbtrans_event WHERE (date_event < '"+dates+"')"); // คำสั่ง 3
										}catch(SQLException e){
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
										}
										out.println("<script> ModalSuccess_NoParam('"+msg_delsuccess+"'); </script>");		
										rc.WriteDataLogFile("["+ses_user+"] Delete Transaction date_event < '"+dates+"' [dbtransaction]");
										rc.WriteDataLogFile("["+ses_user+"] Delete Transaction_ev date_event < '"+dates+"' [dbtransaction_ev]");
										rc.WriteDataLogFile("["+ses_user+"] Delete Trans_event date_event < '"+dates+"' [dbtrans_event]");
									}
							%>
						
										<div class="row">
											<div class="col-xs-1 col-md-1"> </div>
											<label class="col-xs-2 col-md-2" align="right" style="margin-top: 6px;">  <%= lb_old %> </label>
											<div class="col-xs-4 col-md-3"> 
												<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="date" data-link-format="dd/mm/yyyy">
													<input type="text" class="form-control" id="date_show" name="date_show" value="<%= mydate %>" onChange="checkdate('<%= lang %>');" readonly onKeyPress="IsValidNumberForDate();">
													<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
												</div>
												<input type="hidden" class="form-control" id="date" name="date" onChange="checkdate('<%= lang %>');" maxlength="10" value="<%= mydate %>" readonly="readonly" style="background-color:#F0F0F0">
												<input type="hidden" name="hiddate" id="hiddate" value="<%= mydate %>">
											</div>
											<div class="col-xs-1 col-md-2"> </div>
											<div class="col-xs-4 col-md-4" align="right" style="margin-bottom: 20px;"> 
												<input type="button" name="upload" id="btnok" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onclick="return onSubmit('<%= msg_deldatatrans %>', '<%= lang %>');">
											</div> 
										</div>
									</div>
								</div>
							</div> 
						</div>
					</form>
				</div>
				<div class="col-md-1"> </div>
				
			</div>
		</div> 
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_save" class="glyphicon glyphicon-glyphicon glyphicon-trash alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_save_ok1" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_save_cancel1" onClick="javascript: $('#myModalConfirm').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> 
									<input type="hidden" id="text_label" name="text_label" readonly>
								</div>
							</div>
						</div>
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