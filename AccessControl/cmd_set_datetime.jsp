<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "general");
	session.setAttribute("subtitle", "setdatetime");
	session.setAttribute("action", "cmd_set_datetime.jsp?");
	
	String clear_session = "true";
	if(session.getAttribute("subtitle").equals(subtitle)) clear_session = "false";
	
	String ses_group_user = (String)session.getAttribute("ses_group_user");
	String ses_control_reader = (String)session.getAttribute("ses_control_reader");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<!-- TAFF -->
		<link href="css/taff.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/alert_box.js"></script>
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet" type="text/css">
		<link href="css/dataTables.checkboxes.css" rel="stylesheet" type="text/css">
		<link href="css/alert-messages.css" rel="stylesheet" type="text/css">
		<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">	
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/datatables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		<script src="js/dataTables.checkboxes.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
		<script src="js/locales/bootstrap-datetimepicker.th.js" charset="UTF-8"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script>
			document.onkeydown = searchKeyPress_tool;
			
			$(document).ready(function() {
				var table = $('#data_table').DataTable({
					"initComplete": function (settings) {
						var api = this.api();
						api.cells(
						   api.rows(function (idx, data, node) {
							   return (data[0].length !== 4) ? true : false;
						   }).indexes(),
						   0
						).checkboxes.disable();
					},
					"columnDefs": [{ 
						"targets": 0, 
						"checkboxes": { "selectRow": true }
					}],
					"select": { "style": "multi" },
					"aaSorting": [ 1, "asc" ],
					"dom": "<f<t>i>",	//	<lf<t>ip>
					"lengthMenu": [ [ -1 ], [ "All" ] ],
					"scrollY": "329px",
					"scrollCollapse": true,
					"paging": false
					
				<%	if(lang.equals("th")){	%>	
					,"oLanguage": {
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
				$('.dataTables_info').addClass('pull-left');
				
				$('.data_table_filter, input').addClass('max-height-24');
				
				$('#btn_okA').on('click', function(){
					
					$('input[name="chkid"]', form).remove();
					
					var data_selected = "";
					var form = this;
					var rows_selected = table.column(0).checkboxes.selected();
					$.each(rows_selected, function(index, rowId){
						$(form).append($('<input>').attr('type', 'hidden').attr('name', 'chkid').val(rowId));
						data_selected = "1";		//	"&chkid="+rows_selected.join("&chkid=")
					});
					
					document.form1.mode.value = "A";
					onSubmit(data_selected, '<%= lang %>', '<%= lb_no_datadoor %>', '<%= msg_ps_selectdoor %>');
					return false;
				});
				
				$('#btn_okM').on('click', function(){
					
					$('input[name="chkid"]', form).remove();
					
					var data_selected = "";
					var form = this;
					var rows_selected = table.column(0).checkboxes.selected();
					$.each(rows_selected, function(index, rowId){
						$(form).append($('<input>').attr('type', 'hidden').attr('name', 'chkid').val(rowId));
						data_selected = "1";		//	"&chkid="+rows_selected.join("&chkid=")
					});
					
					document.form1.mode.value = "M";
					onSubmit(data_selected, '<%= lang %>', '<%= lb_no_datadoor %>', '<%= msg_ps_selectdoor %>');
					return false;
				});
			});
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">
				<form id="form1" name="form1" method="post">				
					<div class="table-responsive" style="border: 0px !important; margin-top: -10px;" border="0">
						<div style="min-width: 800px;" class="table" border="0">
							<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;"> 
								<div class="row">
									<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 5px;"> <div align="right"> <b> <%= lb_date %> : </b> </div> </h5>
									<h5 class="modal-title col-xs-3 col-md-3" > 
										<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="txtdate" data-link-format="dd/mm/yyyy">
											<input type="text" class="form-control" style="min-height: 34px !important;" value="<%= getCurrentDate() %>" readonly>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
										<input type="hidden" class="form-control" id="txtdate" name="txtdate" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_date %>" value="<%= getCurrentDate()%>" readonly="readonly" style="background-color:#F0F0F0">
									</h5>
									<h5 class="modal-title col-xs-1 col-md-1" style="margin-top: 5px;"> <div align="right"> <b> <%= lb_time %> : </b> </div> </h5>
									<h5 class="modal-title col-xs-3 col-md-3" > 
										<input type="text" name="txttime" id="txttime" class="form-control" style="min-height: 34px !important;" maxlength="8" onKeyPress="IsValidNumberForTime()" value="<%= getCurrentTime() %>">
									</h5>
								</div> 
							</div>
						</div>
					</div>
				
					<div class="table-responsive" style="border: 0px !important; margin-top: -10px;" border="0">
						
						<div style="min-width: 800px;" class="table" border="0">
						
							<table style="min-width: 800px;" align="center" id="data_table" class="table table-striped table-bordered" cellspacing="0" >
								<thead>
									<tr>
										<th width="10%" style="text-align: center;"> </th>
										<th width="15%" style="text-align: center;"> <%= lb_doorcode %> </th>
										<th width="35%" style="text-align: center;"> <%= lb_description %> </th>
										<th width="35%" style="text-align: center;"> <%= lb_locatecode %> </th>
									</tr>
								</thead>
								<tbody>
						<%			
							String door_id = "", door_id_link = "", ip_address = "";
							String lang_desc = "", thdesc = "", endesc = "", txt_desc = "";
							String locate_code_link = "", locate_desc = "";
							String datetimes = "",txt_time = "";
							String chkbox_door_id = "";
							int numtaff = 0, num_duplicateip = 0;
							try{
								ResultSet rs = stmtQry.executeQuery(selectDbDoorByHostByGroupUser(ses_per, ses_group_user, ses_control_reader));
								while(rs.next()){ 
									door_id = rs.getString("door_id");
									door_id_link = "<b> <a href='#' onClick='show_door(\""+door_id+"\");' data-toggle='tooltip' data-placement='left' title='"+lb_viewdata+"'>" + door_id + "</a> </b>";
									ip_address = rs.getString("ip_address");
									
									thdesc = rs.getString("th_desc");
									if((thdesc == null || (thdesc.equals("null")) || (thdesc.equals("")))){
										thdesc = "&nbsp;";
									}
									endesc = rs.getString("en_desc");
									if((endesc == null || (endesc.equals("null")) || (endesc.equals("")))){
										endesc = "&nbsp;";
									}
									if(lang.equals("th")){				
										lang_desc = thdesc + " &nbsp; <b>" + txt_desc + "</b>";	
									}else{
										lang_desc = endesc + " &nbsp; <b>" + txt_desc + "</b>";	
									}
									
									locate_desc = rs.getString("l_th_desc");
									locate_code_link = "<b> <a href='#' onClick='show_location(\""+rs.getString("locate_code")+"\");' data-toggle='tooltip' data-placement='left' title='"+lb_viewdata+"'>" + rs.getString("locate_code") + "</a> </b>";
									if(locate_desc != null){
										if(lang.equals("th")){
											locate_desc = locate_code_link + " - " + rs.getString("l_th_desc");	
										}else{
											locate_desc = locate_code_link + " - " + rs.getString("l_en_desc");	
										}
									}else{
										locate_desc = locate_code_link + " - ";
									}
									
									chkbox_door_id = rs.getString("door_id");
									if(network_feature.equals("1")){
										if(rs.getString("duplicate_ip").equals("1")){
											chkbox_door_id = "";
											num_duplicateip++;
										}
									}
									
						%>
									<tr>
										<td align="center"> <%= chkbox_door_id %> </td>
										<td align="center"> <%= door_id_link %> <input type="hidden" name="hid_<%= door_id %>" value="<%= door_id %>"> </td>
										<td class="pad-left-10"> <%= lang_desc %> </td>
										<td class="pad-left-10"> <%= locate_desc %> </td>
									</tr>
						<% 
									numtaff++;
								}	rs.close();
							}catch(SQLException e){							
								out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
							}
						%>
								</tbody>
							</table>
						</div>
					</div>
					
					<div class="col-xs-4" align="left" style="padding-left: 0px;"> 
					<%	if(network_feature.equals("1")){	%>
						<%	if(num_duplicateip != 0){		%>
						<div class="has-error" style="margin-top: 6px;"> <label class="control-label"> 
							<%= lb_ip_dullicate1 %> <%= num_duplicateip %> <%= lb_ip_dullicate2 %> 
						</label> </div> 
						<%	}	%>
					<%	}	%>
					</div>
					<div class="col-xs-4" align="center"> 
						<input type="hidden" name="sessions" value="<%= ses_user %>">
						<input type="hidden" name="command" value="70">
						<input type="hidden" name="mode" value="A">						
						<button class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" name="btn_okA" id="btn_okA" onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; &nbsp; <%= btn_okserver %> &nbsp; &nbsp; &nbsp; </button> &nbsp;
						<button class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" name="btn_okM" id="btn_okM" onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; &nbsp; <%= btn_configuser %> &nbsp; &nbsp; &nbsp; </button>
					</div>
					<div class="col-xs-4" align="center"> </div>

					<!--	Connect HW	-->
					<%@ include file="../tools/modal_connect_hw.jsp"%>
				
				</form>
				
			</div>
		</div>
		
		<!--viewdoor & viewlocation -->
		<%@ include file="../tools/modal_warning.jsp"%>
		
		<!--viewdoor & viewlocation -->
		<%@ include file="../tools/modal_view_door_location.jsp"%>
		
		<script>					
			function show_door(door_id){
				view_door.location = 'view_door.jsp?action=view&door_id='+door_id;
				$('#myModalViewDoor').modal('show');
			}	

			function show_location(locate_code){
				view_location.location = 'view_location.jsp?action=view&locate_code='+locate_code;
				$('#myModalViewLocation').modal('show');
			}
			
			function onSubmit(data_selected, lang, msg, msg2){
				var st_date = document.form1.txttime.value;
				var colon = 0;
				var sTextH, sTextM;
				if(lang == "th"){
					sTextH = "ข้อมูลชั่วโมงไม่ถูกต้อง";
					sTextM = "ข้อมูลนาทีหรือวินาทีไม่ถูกต้อง";
				}else{
					sTextH = "Hours incorrect information.";
					sTextM = "Min or sec incorrect information.";
				}
				while(st_date.indexOf(":") >= 0){
					colon = st_date.indexOf(":");
					st_date = st_date.substring(0, colon)+ st_date.substring(colon+1, st_date.length);
				}
				
				var calst_date = 6 - st_date.length;
				
				while(calst_date > 0){
					st_date = "0"+st_date;
					calst_date = 6 - st_date.length;
				}
				
				tt = st_date.substring(0, 2);
				mm = st_date.substring(2, 4);
				ss = st_date.substring(4, 6);
				
				st_date = tt+":"+mm+":"+ss;
				document.form1.txttime.value = st_date;				
				
				if(tt > 23){
					//alert(sTextH);
					ModalWarning_TextName(sTextH, "txttime");
					document.form1.txttime.focus();
					return false;	
				}else if ((mm > 59) || (ss > 59)){
					//alert(sTextM);
					ModalWarning_TextName(sTextM, "txttime");
					document.form1.txttime.focus();
					return false;
				}
				
				if("<%= numtaff %>" == 0){
					ModalWarning_TextName(msg, "txttime");
					return false;
				}else{
					if(data_selected == ""){
						ModalWarning_TextName(msg2, "chkid");
						return false;
					}else{
					//	window.document.form1.submit();		
						$('#myModalConnectHW').modal('show');
						window.document.form1.action = 'SetRequest.do?';
						window.document.form1.target = 'connect_hw';
						window.document.form1.submit();
					}
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