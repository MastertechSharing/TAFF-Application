<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "abouttime");
	session.setAttribute("subtitle", "timezone"); 
	session.setAttribute("action", "edit_timezone.jsp?"+"&action="+request.getParameter("action")+"&time_code="+request.getParameter("time_code")+"&");	
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
			
			function changeIframe(y, x){
				parent.frames['showIFrame'+y].location.href = 'iframe_changetime.jsp?number='+x.value;
			}
			
			function change_class(field_name){
				if(field_name == 'time_code'){
					document.getElementById("select_"+field_name).className = "input-group has-success has-feedback";
					document.getElementById("icon_"+field_name).className = "glyphicon glyphicon-ok form-control-feedback";
				}
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
<% 
		String action = "";
		if(request.getParameter("action") != null){
			action = request.getParameter("action");
		}else{
			response.sendRedirect("data_timezone.jsp");
		}
		session.setAttribute("act", action);
		
		String sql_timedesc = "SELECT time_id FROM dbtimedesc ORDER BY time_id ";	
		ResultSet rs_timedesc = null;
		int i = 1;	
%>	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<%	if(!checkPermission(ses_per, "01")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">				
				<form id="form1" name="form1" method="post">				
<% 					if(action.equals("add")){	%>
					<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
						<div class="bs-callout bs-callout-info"> 						
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_timecode %> : </label>
								<div class="col-md-4">
									<div class="input-group has-success has-feedback" id="select_time_code">
										<select class="form-control selectpicker" data-width="100%" data-size="12" data-container="body" name="time_code" id="time_code" onChange="change_class('time_code');">
								<% 		ResultSet rs = stmtQry.executeQuery("SELECT time_code FROM dbtimezonedesc ORDER BY time_code ");	   	
										String code = "";
										while(rs.next()){	  																
											for(i = i; i <= 20; i++){
												if(i < 10){
													code = "0" + i;
												}else{
													code = Integer.toString(i);		
												}
												if(rs.getString("time_code").equals(code)){
													i++;
													break;
												}else{
								%>
											<option value="<%= code %>" > <%= code %> </option> 
								<%				}
											}
										}	
										rs.close();
										for(i = i; i <= 20; i++){
											if(i < 10){
												code = "0" + i;
											}else{
												code = Integer.toString(i);		
											}																									 
								%>			
											<option value="<%= code %>" > <%= code %> </option> 
								<%	    }	%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_time_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
								</div>
								<div class="col-md-6" style="margin-top: 6px;"> </div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_thdesc %> : </label>
								<div class="col-md-4">
									<input type="text" class="form-control" id="th_desc" name="th_desc" maxlength="50" placeholder="<%= lb_thdesc %>">
								</div>
								<div class="col-md-6"> </div>
							</div> 
							<div class="row form-group" style="margin-bottom: 0px;">
								<label class="control-label label-text-1 col-md-2"> <%= lb_endesc %> : </label>
								<div class="col-md-4">
									<input type="text" class="form-control" id="en_desc" name="en_desc" maxlength="50" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
								</div>
								<div class="col-md-1"> </div>
								<div class="col-md-4" style="margin-top: 6px;" align="center">
									<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return onSubmit_Ok('module/act_timezone.jsp?action=add');"> &nbsp; 
									<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_timezone.jsp'">
								</div>
								<div class="col-md-1"> </div>
							</div> 
						</div>
					</div>					
					<div class="row" style="margin-bottom: -5px;"> &nbsp; </div>
			
					<div class="bs-callout bs-callout-info"> 					
						<div class="row" >
							<div class="modal-title col-xs-12 col-md-12" > 
								<div class="table-responsive" style="border: 1px !important; overflow:hidden;">
									<table style="min-width: 1020px;" class="table" align="center" border="0">
										<tr>
											<td rowspan="2" align="center"> <%= lb_timeid %> </td>
											<td rowspan="2" align="center"> <%= lb_day %> </td>
											<td colspan="3" align="center"> <%= lb_timezone %> 1 </td>
											<td colspan="3" align="center"> <%= lb_timezone %> 2 </td>
											<td colspan="3" align="center"> <%= lb_timezone %> 3 </td>
											<td colspan="3" align="center"> <%= lb_timezone %> 4 </td>
											<td colspan="3" align="center"> <%= lb_timezone %> 5 </td>
										</tr>
										<tr>
											<td width="14%" align="center"> <%= lb_time %> </td>
											<td width="3%" align="center"> PIN </td>
											<td width="3%" align="center"> BIO </td>
											<td width="14%" align="center"> <%= lb_time %> </td>
											<td width="3%" align="center"> PIN </td>
											<td width="3%" align="center"> BIO </td>
											<td width="14%" align="center"> <%= lb_time %> </td>
											<td width="3%" align="center"> PIN </td>
											<td width="3%" align="center"> BIO </td>
											<td width="14%" align="center"> <%= lb_time %> </td>
											<td width="3%" align="center"> PIN </td>
											<td width="3%" align="center"> BIO </td>
											<td width="14%" align="center"> <%= lb_time %> </td>
											<td width="3%" align="center"> PIN </td>
											<td width="3%" align="center"> BIO </td>
										</tr>									
									<%																											
											for (i = 1; i <= 8; i++){							
									%>	
										<tr>
											<td align="center"> 
												<select name="time_id<%=i%>" id="time_id<%=i%>" class="form-control max-height-28" style="font-size: 12px; width: 80px;" onChange="changeIframe(<%=i%>, document.form1.time_id<%=i%>);" >
													<option value="" selected="selected"> <%= lb_timeid %> </option>
									<%			try{
													rs_timedesc = stmtQry.executeQuery(sql_timedesc);													
													while (rs_timedesc.next()){																									
									%>
													<option value='<%= rs_timedesc.getString("time_id") %>'> <%= rs_timedesc.getString("time_id") %> </option>
									<%				}	
												}catch(SQLException e){
													out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
												}
									%>
												</select>
											</td>
											<td align="center"> <div style="margin-top: 3px;"> <%= getDay(i, lang) %> </div> </td>
											<td colspan="15" > 
												<div style="margin-left: 0px; margin-right: -10px;">
													<iframe name="showIFrame<%=i%>" width="98%" height="24" src="iframe_changetime.jsp" frameborder="0" scrolling="no"></iframe>
												</div>
											</td>
										</tr>
									<%															
											}
									%>
									</table>
								</div>
							</div>
						</div>
					</div>	 
<%					}else if(action.equals("edit")){			
						String time_code = request.getParameter("time_code");
						try{
							ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbtimezonedesc WHERE (time_code = '"+time_code+"') ");
							while(rs.next()){			
%>
					<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
						<div class="bs-callout bs-callout-info"> 				
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_timecode %> : </label>
								<div class="col-md-4" style="margin-top: 6px; margin-bottom: 8px;">
									<%= time_code %>
									<input type="hidden" class="form-control" id="time_code" name="time_code" value="<%= time_code %>" maxlength="2" placeholder="<%= time_code %>" onKeyPress="IsValidCharacter()">
									<input type="hidden" name="time_code2" id="time_code2" value="<%= time_code %>">
								</div>
								<div class="col-md-6" style="margin-top: 6px;"> </div>
								</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_thdesc %> : </label>
								<div class="col-md-4">
									<input type="text" class="form-control" id="th_desc" name="th_desc" value="<%= rs.getString("th_desc") %>" maxlength="50" placeholder="<%= lb_thdesc %>">
								</div>
								<div class="col-md-6"> </div>
							</div> 
							<div class="row form-group" style="margin-bottom: 0px;">
								<label class="control-label label-text-1 col-md-2"> <%= lb_endesc %> : </label>
								<div class="col-md-4">
									<input type="text" class="form-control" id="en_desc" name="en_desc" value="<%= rs.getString("en_desc") %>" maxlength="50" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
								</div>
								<div class="col-md-1"> </div>
								<div class="col-md-4" style="margin-top: 6px;" align="center">
									<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="Confirm_edit('<%= msg_confirmedit %>', 'module/act_timezone.jsp?action=edit');"> &nbsp; 
									<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_timezone.jsp'">
								</div>
								<div class="col-md-1"> </div>
							</div> 
						</div> 
					</div> 
		<%					}
							rs.close();
		%>
					<div class="row" style="margin-bottom: -5px;"> &nbsp; </div>					
					<div class="bs-callout bs-callout-info"> 					
						<div class="row" >
							<div class="modal-title col-xs-12 col-md-12" > 
								<div class="table-responsive" style="border: 0px !important; overflow:hidden;">
									<table style="min-width: 1080px;" class="table" align="center" border="0">
										<tr>
											<td rowspan="2" align="center"> <%= lb_timeid %> </td>
											<td rowspan="2" align="center"> <%= lb_day %> </td>
											<td colspan="3" align="center"> <%= lb_timezone %> 1 </td>
											<td colspan="3" align="center"> <%= lb_timezone %> 2 </td>
											<td colspan="3" align="center"> <%= lb_timezone %> 3 </td>
											<td colspan="3" align="center"> <%= lb_timezone %> 4 </td>
											<td colspan="3" align="center"> <%= lb_timezone %> 5 </td>
										</tr>
										<tr>
											<td width="14%" align="center"> <%= lb_time %> </td>
											<td width="3%" align="center"> PIN </td>
											<td width="3%" align="center"> BIO </td>
											<td width="14%" align="center"> <%= lb_time %> </td>
											<td width="3%" align="center"> PIN </td>
											<td width="3%" align="center"> BIO </td>
											<td width="14%" align="center"> <%= lb_time %> </td>
											<td width="3%" align="center"> PIN </td>
											<td width="3%" align="center"> BIO </td>
											<td width="14%" align="center"> <%= lb_time %> </td>
											<td width="3%" align="center"> PIN </td>
											<td width="3%" align="center"> BIO </td>
											<td width="14%" align="center"> <%= lb_time %> </td>
											<td width="3%" align="center"> PIN </td>
											<td width="3%" align="center"> BIO </td>
										</tr>
								
						<% 	ResultSet rs_timezone = stmtUp.executeQuery("SELECT time_code, day_type, time_id FROM dbtimezone WHERE (time_code = '"+time_code+"') ORDER BY day_type "); 																
							String cnt = "";
							String cmdChange = "";
							String hidtime = "";
							int loops = 0;
							int day = 1;
							while(rs_timezone.next()){	
								loops++;
								try{
									day = Integer.parseInt(rs_timezone.getString("day_type"));
								}catch (Exception e){

								}	
								cnt = rs_timezone.getString("day_type");
								cmdChange = "changeIframe("+cnt+", document.form1.time_id"+cnt+");";
								hidtime = rs_timezone.getString("time_id");
								
								for(i = loops; i < day; i++){
							%>
								<tr>
									<td align="center">
										<select name="time_id<%=i%>" id="time_id<%=i%>" class="form-control max-height-28" style="font-size: 12px; width: 80px;" onChange="changeIframe(<%=i%>, document.form1.time_id<%=i%>);" >
											<option value="" selected="selected"> <%= lb_timeperiod %> </option>
											<%	rs_timedesc = stmtQry.executeQuery(sql_timedesc);																						
												while (rs_timedesc.next()){													
											%>
												<option value='<%= rs_timedesc.getString("time_id") %>'> <%= rs_timedesc.getString("time_id") %></option>
											<%	} %>
										</select>
										</td> 
									<td align="center"> <div style="margin-top: 3px;"> <%= getDay(i, lang) %> </div> </td>
									<td colspan="15" >
										<div style="margin-left: 0px; margin-right: -10px;">
											<iframe name="showIFrame<%=i%>" width="98%" height="24" src="iframe_changetime.jsp?" frameborder="0" scrolling="no"></iframe>
										</div>
									</td>
								</tr>             
							<% 		
								}									
								loops = day;
						%>
								<tr>
									<td align="center">
										<select name="time_id<%=loops%>" id="time_id<%=loops%>" class="form-control max-height-28" style="font-size: 12px; width: 80px;" onChange="<%= cmdChange %>" >
											<option value="" selected="selected"> <%= lb_timeperiod %> </option>
						<%			rs_timedesc = stmtQry.executeQuery(sql_timedesc);
									while(rs_timedesc.next()){
						%>
											<option value="<%=rs_timedesc.getString("time_id") %>"<%= checkDataSelected(rs_timedesc.getString("time_id"), rs_timezone.getString("time_id")) %>> <%= rs_timedesc.getString("time_id") %> </option>
						<%			}	%>
										</select>
										<input type="hidden" name="hidtime_id<%=loops%>" id="hidtime_id<%=loops%>" value="<%=hidtime%>">
									</td> 
									<td align="center"> <div style="margin-top: 3px;"> <%= getDay(loops, lang) %> </div> </td>
									<td colspan="15" >
										<div style="margin-left: 0px; margin-right: -10px;">
											<iframe name="showIFrame<%=loops%>" width="98%" height="24" src="iframe_changetime.jsp?number=<%= rs_timezone.getString("time_id") %>" frameborder="0" scrolling="no"></iframe>
										</div>
									</td>
								</tr>             
						<% 		}	
								rs_timezone.close();
								for (i = loops+1; i <= 8; i++){		
						%>
							<tr>
								<td align="center">
									<select name="time_id<%=i%>" id="time_id<%=i%>" class="form-control max-height-28" style="font-size: 12px; width: 80px;" onChange="changeIframe(<%=i%>, document.form1.time_id<%=i%>);" >
										<option value="" selected="selected"> <%= lb_timeperiod %> </option>
										<%															
											rs_timedesc = stmtQry.executeQuery(sql_timedesc);
											while(rs_timedesc.next()){	
										%>
											<option value='<%= rs_timedesc.getString("time_id") %>'> <%= rs_timedesc.getString("time_id") %> </option>
										<%	}	%>
									</select>									
								</td> 
								<td align="center"> <div style="margin-top: 3px;"> <%= getDay(i, lang) %> </div> </td>
								<td colspan="15" >
									<div style="margin-left: 0px; margin-right: -10px;">
										<iframe name="showIFrame<%=i%>" width="98%" height="24" src="iframe_changetime.jsp?" frameborder="0" scrolling="no"></iframe>
									</div>
								</td>
							</tr>  
						<%}%>
							</table>
						</div>
					</div>
				</div>
			</div>					
<%					
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
			} 
		}
%>
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
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_timezone.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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

		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>