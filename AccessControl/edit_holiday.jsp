<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "abouttime");
	session.setAttribute("subtitle", "holiday"); 
	session.setAttribute("action", "edit_holiday.jsp?action="+request.getParameter("action")+"&holi_date="+request.getParameter("holi_date")+"&");
%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/check_key.js"></script> 
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
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

		<script language="javascript">
			document.onkeydown = searchKeyPress;

			function CheckCountholi(count_holi, lang){
				var text_warning = "";
				var countholi_int = new Number(count_holi);	
				if((countholi_int >= 0) && (countholi_int <= 99)){
					location.href = 'module/act_holiday.jsp?action=add';
				}else{
					if(lang == "th"){
						text_warning = "จำกัดจำนวนวันหยุด";
					}else{
						text_warning = "Limit number of day";
					}
					ModalWarning_TextName(text_warning, "");
				}
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">	<!--	onLoad="ImgLoad()"	-->
		
<% 
		String action = "";
		if(request.getParameter("action") != null){
			action = request.getParameter("action");
		}else{
			response.sendRedirect("data_holiday.jsp");
		}
		session.setAttribute("act", action);
%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<%	if(!checkPermission(ses_per, "013")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">
				
<%      	
		String count_holi = "";
		try{
			ResultSet rs_holi = stmtQry.executeQuery("SELECT count(holi_date) AS count_code FROM dbholiday ");
			if(rs_holi.next()){
				count_holi = rs_holi.getString("count_code");
			}	rs_holi.close();
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
		}
%>

				<form id="form1" name="form1" method="post" onSubmit="return CheckCountholi('<%= count_holi %>', '<%= lang %>')" >
				
				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info"> 
					
<% 		if(action.equals("add")){	%> 

						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_date %> : </label>
							<div class="col-md-4">
								<div class="input-group col-md-12">
									<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="holi_date" data-link-format="dd/mm/yyyy">
										<input class="form-control" type="text" value="<%= getCurrentDate() %>" readonly>
										<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
									</div>
									<input type="hidden" class="form-control" id="holi_date" name="holi_date" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_date %>" value="<%= getCurrentDate() %>" readonly="readonly" style="background-color:#F0F0F0">
								</div>
							</div>
							<div class="col-md-6 has-error" style="margin-top: 6px;"> <label class="control-label"> ( <%= lb_setdate %> ) </label> </div> 
						</div>
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_thdesc %> : </label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="th_desc" name="th_desc" maxlength="50" placeholder="<%= lb_thdesc %>">
							</div>
							<div class="col-md-6"> </div>
						</div> 
						<div class="row form-group">
							<label class="control-label label-text-1 col-md-2"> <%= lb_endesc %> : </label>
							<div class="col-md-4">
								<input type="text" class="form-control" id="en_desc" name="en_desc" maxlength="50" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
							</div>
							<div class="col-md-6"> </div>
						</div> 
						<div class="row form-group" style="margin-bottom: 0px;">
							<div class="col-md-12" align="center"> 
								<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return onSubmit_Ok('module/act_holiday.jsp?action=add');"> &nbsp; 
								<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_holiday.jsp'">
							</div>
						</div> 
					
<% 		}else if(action.equals("edit")){			
			String sql = "";
			String holi_date = request.getParameter("holi_date");		
			if(mode == 0){
				sql = "SELECT DATE_FORMAT(holi_date,'%d/%m/%Y') AS holi_date ";
			}else{
				sql = "SELECT CONVERT(varchar(10), holi_date, 103) AS holi_date ";
			}
			sql += ", th_desc, en_desc FROM dbholiday WHERE (holi_date = '"+holi_date+"')";
			
			try{
				ResultSet rs = stmtQry.executeQuery(sql);
				while(rs.next()){	
					holi_date = rs.getString("holi_date");
%>

					<div class="row form-group">
						<label class="control-label label-text-1 col-md-2"> <%= lb_date %> : </label>
						<div class="col-md-4">
							<div class="input-group col-md-12">
								<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="holi_date" data-link-format="dd/mm/yyyy">
									<input class="form-control" type="text" value="<%= holi_date %>" readonly>
									<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
								</div>
								<input type="hidden" class="form-control" id="holi_date" name="holi_date" maxlength="10" value="<%= holi_date %>" placeholder="<%= holi_date %>" readonly="readonly" style="background-color:#F0F0F0">
								<input type="hidden" name="holi_date2" id="holi_date2" value="<%=holi_date%>">
							</div>
						</div>
						<div class="col-md-6 has-error" style="margin-top: 6px;"> <label class="control-label"> ( <%= lb_setdate %> ) </label> </div> 
					</div>
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-2"> <%= lb_thdesc %> : </label>
						<div class="col-md-4">
							<input type="text" class="form-control" id="th_desc" name="th_desc" value="<%= rs.getString("th_desc") %>" maxlength="50" placeholder="<%= lb_thdesc %>">
						</div>
						<div class="col-md-6"> </div>
					</div> 
					<div class="row form-group">
						<label class="control-label label-text-1 col-md-2"> <%= lb_endesc %> : </label>
						<div class="col-md-4">
							<input type="text" class="form-control" id="en_desc" name="en_desc" value="<%= rs.getString("en_desc") %>" maxlength="50" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
						</div>
						<div class="col-md-6"> </div>
					</div> 
					<div class="row form-group" style="margin-bottom: 0px;">
						<div class="col-md-12" align="center"> 
							<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="ModalConfirm('<%= msg_confirmedit %>', 'module/act_holiday.jsp?action=edit');"> &nbsp; 
							<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_holiday.jsp'">
						</div>
					</div> 

<%	
				}	
				rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
			} 
		}
%>
					</div>
				</div> 

				</form> 
				
			</div>
		</div>
		
		<div class="modal fade" id="myModalWarning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_warning" class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_warning" class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_warning"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_warning" onClick="javascript: $('#myModalWarning').modal('hide'); javascript: document.getElementById($('#object_warning').val()).focus(); " style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> 
									<input type="hidden" id="object_warning" name="object_warning" readonly>
									<input type="hidden" id="datetime_warning" name="datetime_warning" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-floppy-saved alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_holiday.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> 
									<input type="hidden" id="text_url" name="text_url" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%	}	%>

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