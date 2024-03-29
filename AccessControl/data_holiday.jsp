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
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
	
	String getaction = "";
	if(request.getParameter("action") != null){
		getaction = new String(request.getParameter("action").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "data_holiday.jsp?action="+getaction+"&");
	session.setAttribute("act", getaction);
	
	// show modal alert success
	String text_result = "", type_alert = "success", type_glyphicon = "ok-circle";
	if(session.getAttribute("session_alert") != null){
		text_result = (String)session.getAttribute("session_alert");
		session.setAttribute("session_alert", null);
		if(session.getAttribute("type_alert") != null){
			type_alert = (String)session.getAttribute("type_alert");
			type_glyphicon = "remove-circle";
			session.setAttribute("type_alert", null);
		}
	}
%>
<span/>
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
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		<script src="js/alert_box.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

		<script language="javascript">
			function Clear_Session_Table(clear_ses, key){ 
				if(clear_ses == 'true'){
					localStorage.removeItem(key);
				}
			}
		
			function Load_DataTable(){
				$(document).ready(function() {
					$('#data_table').dataTable( {
						"stateSave": true,
					<%	if(checkPermission(ses_per, "013")){	%>	
						"aoColumnDefs": [
							{ "bSortable": false, "aTargets": [ 0, 1 ] }
						],
					<%	}	%>
						"aaSorting": [
					<%	if(checkPermission(ses_per, "013")){	%>	
							[ 2, "asc" ]
					<%	}else{	%>
							[ 0, "asc" ]
					<%	}	%>
						],
						"dom": "<fl<t>ip>",	//	<lf<t>ip>
						
					<%	if(lang.equals("en")){	%>	
						"lengthMenu": [ [ 15, 50, 100, -1 ], [ 15, 50, 100, "All" ] ]
					<%	}else if(lang.equals("th")){	%>	
						"lengthMenu": [ [ 15, 50, 100, -1 ], [ 15, 50, 100, "������" ] ],
						"oLanguage": {
							"sProcessing":   "���ѧ���Թ���...",
							"sLengthMenu":   "�ʴ� _MENU_ ��¡��",
							"sZeroRecords":  "��辺������",
							"sInfo":         "�ʴ� _START_ �֧ _END_ �ҡ _TOTAL_ ��¡��",
							"sInfoEmpty":    "�ʴ� 0 �֧ 0 �ҡ 0 ��¡��",
							"sInfoFiltered": "(��ͧ�����ŷ����� �ҡ _MAX_ ��¡��)",
							"sInfoPostFix":  "",
							"sSearch":       "����: ",
							"sUrl":          "",
							"oPaginate": {
								"sFirst":    "˹���á",
								"sPrevious": "��͹˹��",
								"sNext":     "�Ѵ�",
								"sLast":     "˹���ش����"
							}
						}
					<%	}	%>
					});
					$('.dataTables_filter').addClass('pull-left');
					$('.dataTables_length').addClass('pull-right');
					$('.dataTables_info').addClass('pull-left');
					$('.dataTables_paginate').addClass('pull-right');
					
					$('.data_table_filter, input').addClass('max-height-24');
					$('.dataTables_length, select').addClass('max-height-24');
					$('.dataTables_length, select').addClass('min-width-80');
					$('.dataTables_paginate ul').addClass('pagination-sm');
				});
			}
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
			function ModalConfirm(sCode, sText, th_name, en_name){															
				document.getElementById("text_confirm").innerHTML = sText;					
				document.getElementById("text_code").innerHTML = sCode;
				document.getElementById("text_th_name").innerHTML = th_name;
				document.getElementById("text_en_name").innerHTML = en_name;
				document.getElementById("sCode").value = sCode;
				$('#myModalConfirm').modal('show');		
			}
			
			function ModalConfirmNoneDisplay(sType){								
				document.getElementById("text_confirm").innerHTML = "Confirm Clear All Holiday ?";
				document.getElementById("sType").value = sType;			
				document.getElementById("display_name").style.display = 'none';
				$('#myModalConfirm').modal('show');												
			}
			
			function Confirm_Button(){
				if(document.getElementById('sType').value == 'clear'){
					location.href = 'module/act_holiday.jsp?action=clear';
				}else{
					location.href = 'module/act_holiday.jsp?action=del&holi_date='+document.getElementById('sCode').value;
				}
			}
			
			function CheckCountholi(count_holi, lang){
				var text_warning = "";
				var countholi_int = new Number(count_holi);		
				if((countholi_int >= 0) && (countholi_int <= 99)){
					location.href = 'edit_holiday.jsp?action=add';
					return false;
				}else{
					if(lang == "th"){
						text_warning = "�ӡѴ�ӹǹ�ѹ��ش";
					}else{
						text_warning = "Limit number of day";
					}
					ModalWarning_TextName(text_warning, "");
				}	
			}
			
			function Add_Data(pageAdd){ 
				location.href = pageAdd;
			}
		</script>	
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Clear_Session_Table('<%= clear_session %>', 'DataTables_data_table_<%= request.getRequestURI() %>'); Load_DataTable();">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<%	if(!checkPermission(ses_per, "01234")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> setTimeout(function(){ ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); }, 500); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">
			
				<div class="table-responsive" style="border: 0px !important;" border="0">
						
					<div style="min-width: 800px;" class="table" border="0">	
				
						<table style="min-width: 800px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
							<%	if(checkPermission(ses_per, "013")){	%>	
									<td width="3%" align="center"> </td>
									<td width="3%" align="center"> </td>
							<%	}	%>
									<td width="24%" align="center"> <%= lb_date %> </td>
									<td width="35%" align="center"> <%= lb_thdesc %> </td>
									<td width="35%" align="center"> <%= lb_endesc %> </td>
								</tr>
							</thead>
							<tbody>
							<%	int count_holi0 = 0;
								try{								
									String sql = "";							
									if(mode == 0){
										sql = "SELECT date_format(holi_date,'%d/%m/%Y') AS holi_date ";
									}else{
										sql = "SELECT CONVERT(varchar(10), holi_date, 103) AS holi_date ";
									}
									sql += ", th_desc, en_desc FROM dbholiday ORDER BY holi_date ASC";
									
									ResultSet rs = stmtQry.executeQuery(sql);	
									while(rs.next()){		
										count_holi0++;
										String holi_date = rs.getString("holi_date");	
										
							%>	<input type="hidden" id="sCode" name="sCode" value="<%=dateToYMD(holi_date)%>">
								<tr>
							<%	if(checkPermission(ses_per, "013")){	%>			
									<td align="center"> 
										<a href="edit_holiday.jsp?action=edit&holi_date=<%= dateToYMD(holi_date) %>"> <img src="images/edit.png" width="18" height="18" border="0" align="absmiddle" data-toggle="tooltip" data-placement="right" title="<%= lb_editdata %>"> </a>
									</td>
									<td align="center"> 
										<img src="images/delete.png" width="20" height="20" border="0" align="absmiddle" onClick="ModalConfirm('<%= holi_date %>', '<%= msg_confirmdel %>', '<%= rs.getString("th_desc") %>', '<%= rs.getString("en_desc") %>');" data-toggle="tooltip" data-placement="right" title="<%= lb_deletedata %>">
									</td>
							<%	}	%>		
									<td align="center"> <span style="display: none;"> <%= dateToYMD(holi_date) %> </span> <b> <a href="#" onClick="show_detail('<%= dateToYMD(holi_date) %>');" data-toggle="tooltip" data-placement="right" data-html="true" title="<%= lb_viewdata %>"> <%= holi_date %> </a> </b> </td>
									<td class="pad-left-10"> <%= rs.getString("th_desc") %> </td>
									<td class="pad-left-10"> <%= rs.getString("en_desc") %> </td>
								</tr>
							<%	
									}
									rs.close();
								}catch(SQLException e){	
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
								}
							%>
							</tbody>
						</table>
					</div>
					
					<div class="col-xs-12" align="left" style="margin-left: -15px; min-width: 500px;">
						<div class="btn-group">
							<%@ include file="tools/toggle_dropdown.jsp"%>
							<%	if(checkPermission(ses_per, "013")){	%>	
							<button type="button" class="btn btn-primary btn-sm" onClick="Add_Data('edit_holiday.jsp?action=add');"> 
								<i class="glyphicon glyphicon-plus"> </i> &nbsp; <%= lb_adddata %> &nbsp; 
							</button>
							<% if(count_holi0 > 0){ %>
							<button type="button" class="btn btn-primary btn-sm" onClick="ModalConfirmNoneDisplay('clear');"> 
								<i class="glyphicon glyphicon-hourglass"> </i> &nbsp; Clear All Holiday &nbsp; 
							</button>								
							<%	}	} %>
						</div>
					</div>
				</div>
			
			</div>
		</div>

		<%@ include file="tools/modal_viewdetail.jsp"%>
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_confirm" class="modal-content alert-message alert-message-danger">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; " border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_confirm" class="glyphicon glyphicon-trash alert-message-danger" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px; display: none;" id="display_name">
								<strong>								
									<div class="alert alert-warning" role="alert" style="min-width: 50px;">
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_date %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_code"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_thdesc %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_th_name"> </p> </div>
										</div>
										<div class="row">
											<div class="col-xs-5 col-md-5" align="right"> <%= lb_endesc %> :  </div>
											<div class="col-xs-7 col-md-7" align="left"> <p id="text_en_name"> </p> </div>
										</div>
									</div>
								</strong>
							</div>
							<%@ include file="tools/modal_confirm.jsp"%>							
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="tools/modal_result.jsp"%>
		
		<!--	Function CheckCountholi()	-->
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

		<%	}	%>
		
		<script>
		function show_detail(holi_date){
			view_detail_100px.location = 'view_holiday.jsp?action=view&holi_date='+holi_date;
			$('#myModalViewDetail100px').modal('show');
		}
		
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				$('body').addClass('loaded');
				
				<%	if(!text_result.equals("")){	%>
				setTimeout(function(){
					$('#myModalResult').modal('show');
					setTimeout(function(){
						$('#myModalResult').modal('hide');
					}, 3000);
				}, 500);
				<%	}	%>
			}
		}
		</script>
		
		<script src="js/dropdown-menu.animated.js"></script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>