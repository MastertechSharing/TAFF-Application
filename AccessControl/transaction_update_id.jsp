<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "others");
	session.setAttribute("subtitle", "trans_updateid");
	session.setAttribute("action", "transaction_update_id.jsp?");
	
	String col_xs_md = "col-xs-6 col-md-6";
	String glyphicon_margin_left = "4%";
	String table_reader_max_width = "97%";
	if(true){
		col_xs_md = "col-xs-12 col-md-12";
		glyphicon_margin_left = "2%";
		table_reader_max_width = "98%";
	}
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
			
			$(document).ready(
				function() {
					$('#data_reader').dataTable( {
						"aoColumnDefs": [
							{ "orderable": false }
						],
						"aaSorting": [],
						"dom": "<f<t>>",	//	<lf<t>ip>
						"lengthMenu": [ [ -1 ], [ "All" ] ]
					<%	if(lang.equals("th")){	%>
						,"oLanguage": {
							"sProcessing":   "กำลังดำเนินการ...",
							"sZeroRecords":  "ไม่พบข้อมูล",
							"sSearch":       "ค้นหา: "
						}
					<%	}	%>
					});
					
					$('.dataTables_filter').addClass('pull-right');
					$('.dataTables_filter').addClass('pad-right-15');
					$('.data_table_filter, input').addClass('max-height-24');
				}
			);
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" isReady="true">
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
	<%	
		String idcard = "", sec_code = "", id_name = "";						
		ResultSet rs = null;
		if(ses_per == 9){										
			try{
				rs = stmtQry.executeQuery("SELECT * FROM dbemployee WHERE (idcard = '"+ses_user+"')");
				rs.next();
				idcard = rs.getString("idcard");
				sec_code = rs.getString("sec_code");
				if(lang.equals("th")){
					id_name = rs.getString("th_fname")+" "+rs.getString("th_sname");						
				}else{	  
					id_name = rs.getString("en_fname")+"  "+rs.getString("en_sname");					
				}
				rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
			}
		}
	%>
		
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
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_empcode %> : </b> </div> </h5>
											<div class="modal-title col-xs-2 col-md-2"> 
										<%	if(ses_per == 9){
												out.println("<input type='text' class='form-control' id='emp_id' name='emp_id' maxlength='16' style='min-height: 28px !important;' readonly='readonly' value='"+ses_user+" '>");
											}else {
										%>		<input type="text" class="form-control" id="emp_id" name="emp_id" maxlength="16" style="min-height: 28px !important;" onKeyPress="IsValidCharacters()" onKeyUp="get_datatransaction(this.value, '<%= lang %>');">
										<%	}	%>
											</div>
											<div class="modal-title col-xs-1 col-md-1">
										<%	if(ses_per != 9){	%>
												<img src="images/view.png" width="28" height="28" border="0" align="absmiddle" onClick="show_detail();" data-toggle="tooltip" data-placement="right" data-container="body" title="<%= lb_viewdata %>"/>
										<%	}	%>
											</div>
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_names %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
										<%	if(ses_per == 9){
												out.println("<input type='text' class='form-control' id='emp_name' name='emp_name' style='min-height: 28px !important; background-color:#F0F0F0' value='"+id_name+"' readonly='readonly'>");
											}else {
										%>		<input type="text" class="form-control" id="emp_name" name="emp_name" style="min-height: 28px !important; background-color:#F0F0F0" readonly="readonly"/>
										<%	}	%>
											</div>
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
										<p>
										<div class="row">
											<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_date %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<div class="input-group col-md-12">
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="st_date" name="st_date" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div>
											<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 4px;"> <div align="right"> <b> <%= lb_to_date %> : </b> </div> </h5>
											<div class="modal-title col-xs-3 col-md-3">
												<div class="input-group col-md-12">
													<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date2" data-link-format="dd/mm/yyyy">
														<input type="text" class="form-control" style="min-height: 28px !important; background-color:#F0F0F0" value="<%= getCurrentDate() %>" readonly>
														<span class="input-group-addon"><span class="glyphicon glyphicon-calendar" style="font-size: 12px !important;"></span></span>
													</div>
													<input type="hidden" class="form-control" id="st_date2" name="st_date2" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_to_date %>" readonly="readonly" style="background-color:#F0F0F0">
												</div>
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
										<p>
										<div class="row">
											<div class="modal-title col-xs-6 col-md-6"> &nbsp; </div>
											<div class="modal-title col-xs-5 col-md-5" align="right">
												<input type="button" name="Button" id="pdf" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_preview %> &nbsp; &nbsp; &nbsp; " onClick="Javascript:funcSubmit_Page('<%= lang %>');" onMouseOver="this.style.cursor='hand';" >
											</div> 
											<div class="modal-title col-xs-1 col-md-1"> </div> 
										</div>
									</div>
								
								</div>
							</div>
						
						</div>
					</div>
	
					<div class="table-responsive" style="border: 0px !important; margin-bottom: -30px; margin-left: -15px; margin-right: -15px;" border="0">
						<div style="min-width: 1000px;" class="table" border="0">
						
							<div class="row" style="margin-left: 0px; margin-right: 0px;">
								<div class="modal-title <%= col_xs_md %>">
								
									<div class="bs-callout bs-callout-info"> 
										<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
											<label class="control-label" style="margin-left: <%= glyphicon_margin_left %>; margin-top: 5px;"> 
												<input type="checkbox" name="checkall" id="checkall" value="*" onClick="checkAllObj(this, document.form1.check_door, '<%= lang %>', 'reader')"> &nbsp; 
												<b> <%= lb_chooseall_reader %> </b>
											</label>
										</div>
										<div class="row" style="margin-top: -25px;">
											
											<table class="table table-bordered table-hover" id="data_reader" align="center" border="0" style="max-width: <%= table_reader_max_width %> !important; margin-bottom: -5px;">
												<thead>
													<tr>
														<td data-sortable="false"> </td>
													</tr>
												</thead>
												<tbody>
			
											<% 
												try{
													ResultSet rs_taff = stmtQry.executeQuery("SELECT * FROM dbreader ORDER BY reader_no ");
													while(rs_taff.next()){
											%>
													<tr>
														<td class="pad-left-10"> 
															<div class="ellipsis_string" style="width: 80%">
																<input type="checkbox" name="check_door" id="check_door" value="<%= rs_taff.getString("reader_no") %>" onClick="checkSelectObj(document.form1.checkall, document.form1.check_door);"> &nbsp;
															<%	out.print("<b><span onClick='show_reader(\""+rs_taff.getString("reader_no")+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'>" + rs_taff.getString("reader_no") + "</span></b> -");	%>
															<%	if(lang.equals("th")){ out.print(rs_taff.getString("th_desc")); }else{ out.print(rs_taff.getString("en_desc")); } %>
															</div>
														</td>
													</tr>
											<%	
													}	rs_taff.close();
												}catch(SQLException e){
													out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
												}
											%>
												</tbody>
											</table>
											
										</div>
									</div>
									
								</div>
							
							</div>
						
						</div>
					</div>
				
				</form>
				
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
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

		<div class="modal fade bs-example-modal-lg" id="myModalViewReader" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_reader" name="view_reader" frameborder="0" height="450px" style="min-width: 850px;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
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
		
		<script>
			function show_detail(){
				view_detail.location = 'iframe_employee.jsp';
				$('#myModalViewDetail').modal('show');
			}
			
			function show_reader(reader_no){
				view_reader.location = 'view_reader.jsp?action=view&reader_no='+reader_no;
				$('#myModalViewReader').modal('show');
			}	
			
			function funcSubmit_Page(lang){
				flg = 0;
				text_warning = '';
				if(document.form1.check_door == undefined){
					if(lang == "th"){
						text_warning = "กรุณาเลือกหมายเลขเครื่อง";
					}else{
						text_warning = "Please select reader no";
					}
					ModalWarning_TextName(text_warning, "");
					return false;
				}else{		
					if(document.form1.check_door.length == null){
						if(document.form1.check_door.checked== true){
							flg = 1;
						}
					}else{
						for(i = 0; i < document.form1.check_door.length; i++){
							if(document.form1.check_door[i].checked == true){
								flg = 1;
								break;  
							}
						}
					}
					if(flg == 0){
						if(lang == "th"){
							text_warning = "กรุณาเลือกหมายเลขเครื่อง";
						}else{
							text_warning = "Please select reader no";
						}
						ModalWarning_TextName(text_warning, "");
						return false;
					}	
					document.form1.action = "transaction_update_id_view.jsp";
					document.form1.submit();		
				}
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