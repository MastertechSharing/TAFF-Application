<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 		
	session.setAttribute("page_g", "special"); 
	session.setAttribute("subpage", "deletedata");
	session.setAttribute("subtitle", "employee_view");
		
	String groupcode = "";	
	String seccode = "";
	if(!(request.getParameter("groupCode").equals(""))){
		groupcode = request.getParameter("groupCode");
	}
	if(!(request.getParameter("secCode").equals(""))){
		seccode = request.getParameter("secCode");
	}
	
	if(request.getParameter("emp_id") != null){
		session.setAttribute("action", "delete_employee_view.jsp?groupCode="+groupcode+"&secCode="+seccode+"&emp_id="+request.getParameter("emp_id")+"&stdate=&stdate2=&exdate=&exdate2=&valuechk=&");
	}else{
		session.setAttribute("action", "delete_employee_view.jsp?groupCode="+groupcode+"&secCode="+seccode+"&stdate="+request.getParameter("stdate")+"&stdate2="+request.getParameter("stdate2")+"&exdate="+request.getParameter("exdate")+"&exdate2="+request.getParameter("exdate2")+"&valuechk="+request.getParameter("valuechk")+"&");
	}
	
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
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>	
		
		<script type="text/javascript" src="js/check_input.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet"> 
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script> 
		
		<script type="text/javascript">
			$(document).ready(function() {
				$('#data_table').dataTable( {
					
					"bServerSide": true,
					"bProcessing": true,
					"sAjaxSource": "delete_employee_view_server_side.jsp?groupCode=<%= request.getParameter("groupCode") %>&secCode=<%= request.getParameter("secCode") %>&emp_id=<%= request.getParameter("emp_id") %>&valuechk=<%= request.getParameter("valuechk") %>&stdate=<%= request.getParameter("stdate") %>&stdate2=<%= request.getParameter("stdate2") %>&exdate=<%= request.getParameter("exdate") %>&exdate2=<%= request.getParameter("exdate2") %>",
					"drawCallback": function( settings ) {
						var api = new $.fn.dataTable.Api( settings );
						if( api.rows().data()[0] !== undefined ){	
							if( api.rows().data()[0][0] == ' '){
								window.location.href = 'login.jsp';
							}
						}
					},
					
					"aoColumnDefs": [
						{ "bSortable": false, "aTargets": [ 0 ] }
					],
					"aaSorting": [
						[ 1, "asc" ]
					],
					"dom": "<fl<t>ip>",	//	<lf<t>ip>
					
					"aLengthMenu": [ [ 15, 50, 100, 1000 ], [ 15, 50, 100, 1000 ] ],
				<%	if(lang.equals("th")){	%>
					"oLanguage": {
						"sProcessing":   "กำลังดำเนินการ...",
						"sLengthMenu":   "แสดง _MENU_ รายการ",
						"sZeroRecords":  "ไม่พบข้อมูล",
						"sInfo":         "แสดง _START_ ถึง _END_ จาก _TOTAL_ รายการ",
						"sInfoEmpty":    "แสดง 0 ถึง 0 จาก 0 รายการ",
						"sInfoFiltered": "(กรองข้อมูลทั้งหมด จาก _MAX_ รายการ)",
						"sInfoPostFix":  "",
						"sSearch":       "ค้นหา: ",
						"sUrl":          "",
						"oPaginate": {
							"sFirst":    "หน้าแรก",
							"sPrevious": "ก่อนหน้า",
							"sNext":     "ถัดไป",
							"sLast":     "หน้าสุดท้าย"
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
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
			function DeleteEmp(lbstr, lbstr1){
				var checkemp = "";
				var num = "";
				if(num == 0){				
					if(document.form1.chkemp.length == null){	
						if(document.form1.chkemp.checked == true){	
							num = 1;
							checkemp = form1.chkemp.value;								
						}	
					}else{	
						for (var g = 0; g < form1.chkemp.length; g++) {
							if(document.form1.chkemp[g].checked == true){				
								num = 1;	
								checkemp = checkemp+form1.chkemp[g].value;								
								break;  
							}			
						} 
					}
				}
				
				document.getElementById("modal-alert").classList.remove("alert-message-danger"); 
				document.getElementById("modal-alert").classList.remove("alert-message-warning"); 
				
				document.getElementById("modal-glyphicon").classList.remove("glyphicon-trash"); 
				document.getElementById("modal-glyphicon").classList.remove("alert-message-danger"); 
				document.getElementById("modal-glyphicon").classList.remove("glyphicon-exclamation-sign"); 
				document.getElementById("modal-glyphicon").classList.remove("alert-message-warning"); 
				
				document.getElementById("display_alert").style.display = 'none';
				document.getElementById("display_confirm").style.display = 'none';
				
				if(num == 0){
				
					document.getElementById("modal-alert").classList.add("alert-message-warning"); 
					document.getElementById("modal-glyphicon").classList.add("glyphicon-exclamation-sign"); 
					document.getElementById("modal-glyphicon").classList.add("alert-message-warning"); 
					
					document.getElementById("display_alert").style.display = '';
				
					Confirm_Alert(lbstr, '1');
					
				}else{	
					
					document.getElementById("modal-alert").classList.add("alert-message-danger"); 
					document.getElementById("modal-glyphicon").classList.add("glyphicon-trash"); 
					document.getElementById("modal-glyphicon").classList.add("alert-message-danger"); 
					
					document.getElementById("display_confirm").style.display = '';
					
					Confirm_Alert(lbstr1, '0');
					
				}
			}
			
			function Confirm_Alert(sText, hide){
				var date = new Date().getTime();
				document.getElementById("text_header").innerHTML = sText;
				document.getElementById("sTime").value = date;
				$('#myModalAlert').modal('show');
				
				setTimeout(function(){ 
					if ((!$('#myModalAlert').is(':hidden')) && date == document.getElementById("sTime").value && hide == '1') {
						$('#myModalAlert').modal('hide');
					}
				}, 3000);
			}
			
			function Confirm_Button(){				
				var value_choice = document.form1.chkemp;
				var id = "";
				var loop = 0;
				
				var group_code = document.form1.groupCode.value;
				var sec_code = document.form1.secCode.value;
				var stdate = document.form1.stdate.value;
				var stdate2= document.form1.stdate2.value;
				var exdate = document.form1.exdate.value;
				var exdate2 = document.form1.exdate2.value;
				var valuechk = document.form1.valuechk.value;				

				if(value_choice.length == null){	
					if(value_choice.checked == true){	
						loop = 1;
						id = form1.chkemp.value;			
					}				
				}else{				
					for (i = 0; i < value_choice.length; i++){
						if(value_choice[i].checked){
							loop = loop + 1;
							if(loop != 1){
								id = id +","+ value_choice[i].value;								
							}else{
								id = id + value_choice[i].value;
							}
						}
					}
				}
				location.href = 'module/act_employee.jsp?action=dels&idcard='+id+'&groupCode='+group_code+'&secCode='+sec_code+'&stdate='+stdate+'&stdate2='+stdate2+'&exdate='+exdate+'&exdate2='+exdate2+'&valuechk='+valuechk+'&';
			}
		</script>
	
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" isReady="true" onLoad="loadSubmit()">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>

		<div class="body-display">
			<div class="container">
			
				<div class="table-responsive" style="border: 0px !important;" border="0">
					<div style="min-width: 1080px;" class="table" border="0">					
						
						<form name="form1" id="form1">						
					<% 
						String check_group = "";
						String[] check_group_id = null;
						String paramName_group = "";
						
						String check_sec ="";
						String[] check_sec_id =  null;	
						String paramName_sec = "";	
						
						if(request.getParameterValues("groupCode") != null){
							check_group_id = request.getParameterValues("groupCode");
							for (int i = 0; i <= check_group_id.length -1; i++){
								if(i != check_group_id.length -1){
									check_group =  check_group+check_group_id[i] +",";
								} else {
									check_group =  check_group+check_group_id[i] ;
								}				 
							}
							paramName_group = check_group;
						}
						
						if(request.getParameterValues("secCode") != null){
							check_sec_id = request.getParameterValues("secCode");
							for (int i = 0; i <= check_sec_id.length -1; i++){
								if(i != check_sec_id.length -1){
									check_sec =  check_sec+check_sec_id[i] +",";
								} else {
									check_sec =  check_sec+check_sec_id[i] ;
								}
							}
							paramName_sec = check_sec;
						}
					%>					
						<input type="hidden" name="groupCode" value="<%= paramName_group %>">
						<input type="hidden" name="secCode" value="<%= paramName_sec %>">
						<input type="hidden" name="stdate" value="<%= request.getParameter("stdate") %>">
						<input type="hidden" name="stdate2" value="<%= request.getParameter("stdate2") %>">
						<input type="hidden" name="exdate" value="<%= request.getParameter("exdate") %>">
						<input type="hidden" name="exdate2" value="<%= request.getParameter("exdate2") %>">
						<input type="hidden" name="valuechk" value="<%= request.getParameter("valuechk") %>">
						<input type="hidden" name="emp_id" value="<%= request.getParameter("emp_id") %>">
				
						<table style="min-width: 1080px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
							<thead>
								<tr>
									<td width="4%" align="center">
										<input type="checkbox" name="checkall" id="checkall2" value="*" alt="<%= lb_select %>" style="margin-top: 3px; margin-bottom: 3px; cursor: pointer; cursor: hand;" onclick="checkAllObj(this, document.form1.chkemp);"/> 
									</td>
									<td width="16%" align="center"> <%= lb_empcode %> </td>
									<td width="20%" align="center"> <%= lb_names %> </td>
									<td width="10%" align="center"> <%= lb_startdate %> </td>
									<td width="10%" align="center"> <%= lb_expiredate %> </td>
									<td width="20%" align="center"> <%= lb_groupcode %> </td>
									<td width="20%" align="center"> <%= lb_seccode %> </td>
								</tr>
							</thead>
						</table>
		
						</form>
					</div>
					
					<div class="col-xs-12" align="left" style="margin-left: -15px; min-width: 500px;">
						<div class="btn-group">
							<button type="button" class="btn btn-danger btn-sm" onClick="return DeleteEmp('<%= lb_sel_emp %>', '<%= msg_confirmdel %>');"> 
								<i class="glyphicon glyphicon glyphicon-trash"> </i> &nbsp; <%= lb_deletedata %> &nbsp; 
							</button>
						</div>
					</div>
				</div>
			
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
							<iframe src="#" id="view_detail" name="view_detail" frameborder="0" height="450px" style="min-width: 850px; overflow: hidden;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_detail2" name="view_detail2" frameborder="0" height="100px" style="min-width: 850px; overflow: hidden;"></iframe>
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
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_detail3" name="view_detail3" frameborder="0" height="140px" style="min-width: 850px; overflow: hidden;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalAlert" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal-alert" class="modal-content alert-message alert-message-danger">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; " border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="modal-glyphicon" class="glyphicon glyphicon-trash alert-message-danger" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_header"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;" id="display_alert">
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="modal-btn" onClick="javascript: $('#myModalAlert').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> </div>
							</div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;" id="display_confirm">
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="modal-btn" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: $('#myModalAlert').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
							<input type="hidden" id="sTime" name="sTime" readonly>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="tools/modal_result.jsp"%>
		
		<script>
			function show_detail(idcard){
				view_detail.location = 'view_employee.jsp?action=view&idcard='+idcard;
				$('#myModalViewDetail').modal('show');
			}
			
			function show_detail2(group_code){
				view_detail2.location = 'view_group.jsp?action=view&group_code='+group_code;
				$('#myModalViewDetail2').modal('show');
			}
			
			function show_detail3(sec_code){
				view_detail3.location = 'view_section.jsp?action=view&sec_code='+sec_code;
				$('#myModalViewDetail3').modal('show');
			}
				
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
					$('body').addClass('loaded');
				
					<% if(!text_result.equals("")){ %>
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
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>