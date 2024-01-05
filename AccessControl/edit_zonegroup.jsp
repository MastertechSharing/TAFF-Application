<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "personnel");
	session.setAttribute("subtitle", "zonegroup"); 
	session.setAttribute("action", "edit_zonegroup.jsp?"+"&action="+request.getParameter("action")+"&group_code="+request.getParameter("group_code")+"&");
	
	// Clear localStorage of DataTable
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
	
	String ses_username = (String)session.getAttribute("ses_username");
	String ses_group_user = (String)session.getAttribute("ses_group_user");
	
	String group_code = request.getParameter("group_code");
	String action = "";
	if(request.getParameter("action") != null){
		action = request.getParameter("action");
	}else{
		response.sendRedirect("data_group.jsp");
	}
	session.setAttribute("act", "");
	
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
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		
		<!-- Latest compiled AND minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled AND minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

		<script type="text/javascript">
			function Clear_Session_Table(clear_ses, key){ 
				if(clear_ses == 'true'){
					localStorage.removeItem(key);
				}
			}
			
			function Load_DataTable(data){
				$(document).ready(function(){
					$('#data_table').dataTable({
					//	"stateSave": true,
						
						"bServerSide": true,
						"bProcessing": true,
						"sAjaxSource": "edit_zonegroup_server_side.jsp?view_data="+data+"&group_code=<%= group_code %>&time_code=00",
						"drawCallback": function( settings ) {
							var api = new $.fn.dataTable.Api( settings );
							if( api.rows().data()[0] !== undefined ){	
								if( api.rows().data()[0][0] == ' '){
									window.location.href = 'login.jsp';
								}
							}
						},
					
					<%	if(checkPermission(ses_per, "0135")){	%>	
						"aoColumnDefs": [
							{ "bSortable": false, "aTargets": [ 0, 4, 5 ] }
						],
					<%	}	%>
						"aaSorting": [
					<%	if(checkPermission(ses_per, "0135")){	%>	
							[ 1, "asc" ]
					<%	}else{	%>
							[ 0, "asc" ]
					<%	}	%>
						],
						"dom": "<flr<t>ip>",	//	<lf<t>ip>
						
					<%	if(lang.equals("en")){	%>	
							"lengthMenu": [ [ 15, 50, 100, -1 ], [ 15, 50, 100, "All" ] ]
					<%	}else if(lang.equals("th")){	%>	
							"lengthMenu": [ [ 15, 50, 100, -1 ], [ 15, 50, 100, "ทั้งหมด" ] ],
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
				//	$('.dataTables_length, select').addClass('min-width-80');
					$('.dataTables_paginate ul').addClass('pagination-sm');
				});
			}
			
			var data_view = '1';
			function changeIframe(x){
				document.showIFrame.location.href = "iframe_zonegroup.jsp?number="+x.value;
				
				setTimeout(function(){
					$('#li_first').removeClass('active');	$('#li_second').addClass('active');
					$('#1').addClass('fade');				$('#1').removeClass('active');
					$('#2').removeClass('fade');			$('#2').addClass('active');
					
					$('#data_table').DataTable().ajax.url("edit_zonegroup_server_side.jsp?view_data="+$('#view_data').val()+"&group_code=<%= group_code %>&time_code="+x.value).load( null, false );
				}, 200);
			}
		
			function chkView(data){
				var sText = "";
				var icon = "";
				data_view = data;
				if(data == "all"){
					sText = "<%= lb_view_all_zonegroup %>";
					icon = "view_all.png";
				}else if(data == "0"){
					sText = "<%= lb_view_not_allow %>";
					icon = "door_close_red.png";
				}else if(data == "1"){
					sText = "<%= lb_view_allow %>";
					icon = "door_open.png";
				}
				
				var myobj = document.getElementById("img_icon");				
				var oImg = new Image();	
				oImg.src = "images/"+icon;
				oImg.onload = function(){
					myobj.src = oImg.src;
				}
				
				document.getElementById("view_data").value = data;
				document.getElementById("text_view").innerHTML = sText;
				$('#data_table').DataTable().ajax.url("edit_zonegroup_server_side.jsp?view_data="+$('#view_data').val()+"&group_code=<%= group_code %>&time_code="+$('#time_code').val()).load();
			}
			
			function action_door(act, reader_no){
				$('#form1').attr('action', 'module/act_zonegroup.jsp?action='+act+'&reader_no='+reader_no+'&time_code='+$('#time_code').val()+'&group_code=<%= group_code %>');
				$('#form1').attr('target', 'iframe_zonegroup');
				$('#form1').submit();
			}
			
			function action_time(act, reader_no, time_code){
				if($('#time_code').val() != time_code){
					$('#form1').attr('action', 'module/act_zonegroup.jsp?action='+act+'&reader_no='+reader_no+'&time_code='+$('#time_code').val()+'&group_code=<%= group_code %>');
					$('#form1').attr('target', 'iframe_zonegroup');
					$('#form1').submit();
				}else{
					ModalWarning_TextName('<%= msg_duptimezone %>', $('#time_code').val());
				}
			}
			
			function change_class(field_name){
				if(field_name == 'group_code' || field_name == 'reader_no'){
					document.getElementById("select_"+field_name).className = "input-group has-success has-feedback";
					document.getElementById("icon_"+field_name).className = "glyphicon glyphicon-ok form-control-feedback";
				}else if(field_name == 'time_code'){
					if(document.form1.time_code.value == '00'){
						document.getElementById("select_"+field_name).className = "input-group has-warning has-feedback";
						document.getElementById("icon_"+field_name).className = "glyphicon glyphicon-warning-sign form-control-feedback";
					}else{
						document.getElementById("select_"+field_name).className = "input-group has-success has-feedback";
						document.getElementById("icon_"+field_name).className = "glyphicon glyphicon-ok form-control-feedback";
					}
				}
			}
		</script>
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="Clear_Session_Table('<%= clear_session %>', 'DataTables_data_table_<%= request.getRequestURI() %>'); Load_DataTable('all');">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<%@ include file="../tools/modal_danger.jsp"%>
		
	<%	if(request.getParameter("group_code").equals("groupblacklist")){	%>
		
		<script> setTimeout(function(){ ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); }, 500); </script>
		
	<%	}else{	%>
	
		<%	if(!checkPermission(ses_per, "0135")){	%>
			
			<script> setTimeout(function(){ ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); }, 500); </script>
			
		<%	}else{	%>
		
		<%		
				//	Check grant group user
				boolean show_action = true;
				String where_reader_list = "";
				try{
					ResultSet rs = stmtTmp.executeQuery("SELECT group_user FROM dbgroup WHERE (group_code = '"+group_code+"') ");
					while(rs.next()){
						String group_user = rs.getString("group_user");
						
						if(ses_per == 1 || ses_per == 2 || ses_per == 5 || ses_per == 6){
							if(!group_user.equals("")){
								if(!group_user.equals(ses_group_user)){
									show_action = false;
								}
							}else{
								if(!ses_group_user.equals("")){
									show_action = false;
								}
							}
						}else{
							if(!group_user.equals("")){
								show_action = false;
							}
						}
					}	rs.close();
				}catch(SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
				} 
				
				//	Define Group
				if(group_code.length() > 6){
					show_action = true;
				}
				
				if(!show_action){
					
					out.println("<script> ModalDanger_NoTimeout('"+lb_invalid_permissions+"'); </script>");
					
				}else{
					
					if(ses_per == 1 || ses_per == 5){
						
						String[] control_reader = new String[0];
						try{
							ResultSet rs = stmtTmp.executeQuery(" SELECT control_reader FROM dbusers WHERE (user_name = '"+ses_username+"') ");
							if(rs.next()){
								if(!rs.getString("control_reader").equals("")){
									control_reader = rs.getString("control_reader").split(",");
								}
							}	rs.close();
						}catch(SQLException e){
							out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
						} 
						
						for(int i = 0; i < control_reader.length; i++){
							where_reader_list += " reader_no = '" + control_reader[i] +"' " ;
							if(i < (control_reader.length -1)){
								where_reader_list += " OR ";
							}
						}
						
						if(!where_reader_list.equals("")){
							where_reader_list = " ( " + where_reader_list + " ) AND ";
						}
					}
					
		%>
		
		<div class="body-display">
			<div class="container">
				
				<form id="form1" name="form1" method="post">
				
<% 		if(action.equals("add")){	%>

					<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
						<div class="bs-callout bs-callout-info"> 
							
						<%	try{	%>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-2"> <%= lb_groupcode %> : </label>
								<div class="col-md-3">
									<div class="input-group has-success has-feedback" id="select_group_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="group_code" id="group_code" onChange="change_class('group_code');">
								<%		ResultSet rs_group = stmtQry.executeQuery(" SELECT group_code, "+lang+"_desc AS group_desc FROM dbgroup WHERE (group_code = '"+group_code+"') ORDER BY group_code ASC ");
										while(rs_group.next()){
											if(group_code.length() == 13){
												String groupdesc = "";
												if(lang.equals("th"))
													groupdesc = "กลุ่มที่กำหนดเฉพาะแต่ละบุคคล";
												else
													groupdesc = "Specifically defined group";
													
								%>
											<option value="<%= rs_group.getString("group_code") %>"> <%= group_code %> </option>
								<%			}else{	%>
											<option value="<%= rs_group.getString("group_code") %>"> <%= group_code %> - <%= rs_group.getString("group_desc") %> </option>
								<%			}	
										}	rs_group.close();
								%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_group_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
								</div>
								<div class="col-md-1"></div>
								<label class="control-label label-text-1 col-md-2"> <%= lb_timecode %> : </label>
								<div class="col-md-3">
									<div class="input-group has-warning has-feedback" id="select_time_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="time_code" id="time_code" onChange="change_class('time_code'); changeIframe(document.form1.time_code);" >
								<%		String sql_timezone = " SELECT distinct tz.time_code, tzd.time_code, tzd."+lang+"_desc AS timezone_desc "
													+ " FROM dbtimezone tz ,dbtimezonedesc tzd WHERE (tz.time_code = tzd.time_code) ORDER BY tzd.time_code";							
										ResultSet rs_timezone = stmtQry.executeQuery(sql_timezone);
								%>
											<option value="00" selected> </option>
								<%		while(rs_timezone.next()){	%>
											<option value="<%= rs_timezone.getString("time_code") %>"> <%= rs_timezone.getString("time_code") %> - <%= rs_timezone.getString("timezone_desc") %> </option>
								<%		}	rs_timezone.close();		%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-warning-sign form-control-feedback" id="icon_time_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
								</div>
							</div>
							
					<%	
						}catch(SQLException e){		
							out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
						}
					%>
					
							<div class="row form-group" style="margin-top: 10px; margin-bottom: -10px;">
								<div class="modal-title col-xs-12 col-md-12"> 

									<ul class="nav nav-tabs">
										<li id="li_first" class="active" style="max-height: 28px;"> <a href="#1" style="max-height: 28px;" data-toggle="tab"> <div style="margin-top: -7px;"> <b><%= lb_zonegroup %></b> </div> </a> </li>
										<li id="li_second" style="max-height: 28px;"> <a href="#2" style="max-height: 28px;" data-toggle="tab"> <div style="margin-top: -7px;"> <b><%= lb_timeperiod %></b> </div> </a> </li>
									</ul>
				 
									<div class="tab-content" style="margin-top: 5px;">
										<div class="tab-pane fade active" id="1">
											<div class="table-responsive" style="border: 0px !important;" border="0">
												
												<table style="min-width: 1080px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
													<thead>
														<tr>
													<%	if(checkPermission(ses_per, "0135")){	%>	
															<td width="4%" align="center"> </td>
													<%	}	%>
															<td width="12%" align="center"> <%= lb_readerno %> </td>
															<td width="27%" align="center"> <%= lb_thdesc %> </td>
															<td width="27%" align="center"> <%= lb_endesc %> </td>
													<%	if(checkPermission(ses_per, "0135")){	%>	
															<td width="4%" align="center"> </td>
													<%	}	%>
															<td width="26%" align="center"> <%= lb_timecode %> </td>
														</tr>
													</thead>
												</table>
					
												<div class="col-xs-12" align="left" style="margin-left: -15px; margin-bottom: 8px; min-width: 500px;">
													<div class="btn-group">
														<div class="btn-group dropup">
															<button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
																<i class="glyphicon glyphicon-info-sign"> </i> &nbsp; <%= lb_information %> &nbsp; 
																<span class="caret"></span>
																<span class="sr-only">Toggle Dropdown</span>
															</button>
															<ul class="dropdown-menu" style="width: 200px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
																<li> <img src="images/door_close_red.png" width="22" height="22" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_not_allow %> <p> </li>
																<li> <img src="images/door_open.png" width="22" height="22" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_allow %> <p> </li>
																<li> <img src="images/time_right.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_update_time %> <p> </li>
																<li> <img src="images/time_correct.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_time_now %> </li>
															</ul>
														</div>
													</div>
													
													&nbsp;
													<div class="btn-group">
														<div class="btn-group dropup">
															<div class="input-group-addon" style="width: 20px !important; background-color: #FFF;"> <img id="img_icon" src="images/view_all.png" style="margin-left: -4px; cursor: default;" align="absmiddle" width="16" height="16" border="0"> </div>
															<button type="button" id="btnview" class="btn btn-info btn-sm dropdown-toggle" style="margin-top: -30px; margin-left: 32px;" onClick="setClassView();" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
																<span id="text_view"> <%= lb_view_all_zonegroup %> </span> &nbsp; 
																<span id="caretview" class="caret"></span>
																<span class="sr-only">Toggle Dropdown</span>
															</button>
															<ul class="dropdown-menu bottom-30" id="liview" style="width: 280px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
																<li onClick="chkView('all');" style="margin-top: 0px; margin-bottom: -5px;"> <a href="#"> <img src="images/view_all.png" width="20" height="20" align="absmiddle" style="margin-left: -12px;"> &nbsp; <%= lb_view_all_zonegroup %>  </a> <p> </li>
																<li onClick="chkView('0');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/door_close_red.png" width="20" height="20" align="absmiddle" style="margin-left: -12px; margin-top: -4px;"> &nbsp; <%= lb_view_not_allow %> </a> <p> </li>
																<li onClick="chkView('1');" style="margin-top: -5px; margin-bottom: -5px;"> <a href="#"> <img src="images/door_open.png" width="20" height="20" align="absmiddle" style="margin-left: -12px; margin-top: -4px;"> &nbsp; <%= lb_view_allow %> </a> <p> </li>
															</ul>
														</div>
													</div>
												</div>
												
											</div>
										</div>
										<div class="tab-pane fade" id="2">
											<div class="table-responsive" style="border: 0px !important;" border="0">
												<iframe name="showIFrame" valign="top" width="100%" height="320" src="iframe_zonegroup.jsp?number=00" frameborder="0" scrolling="yes"> </iframe>
											</div>
										</div>
									</div>
									
								</div>
							</div>
							
						</div>
					</div> 
					
					<input type="hidden" class="form-control" id="view_data" name="view_data" value="all" maxlength="3" readonly>
					
					<iframe src="" id="iframe_zonegroup" name="iframe_zonegroup" frameborder="0" height="0px" width="0px"> </iframe>
		
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
		
		<%@ include file="tools/modal_viewdetail.jsp"%>
		
		<script>
		function show_detail(reader_no){
			view_detail.location = 'view_reader.jsp?action=view&reader_no='+reader_no;
			$('#myModalViewDetail').modal('show');
		}
		
		function show_detail2(time_code){
			view_detail.location = 'view_timezone.jsp?action=view&time_code='+time_code;
			$('#myModalViewDetail').modal('show');
		}
		
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				setTimeout(function(){
					$('#li_first').addClass('active');		$('#li_second').removeClass('active');
					$('#1').removeClass('fade');			$('#1').addClass('active');
					$('#2').addClass('fade');				$('#2').removeClass('active');
				}, 500);
			}
		}
		</script>
		
				<%	}	%>
		
			<%	}	%>
		
		<%	}	%>
	
	<%	}	%>
	
		<script src="js/dropdown-menu.animated.js"></script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>