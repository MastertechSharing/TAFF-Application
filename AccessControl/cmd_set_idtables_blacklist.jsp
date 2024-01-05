<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%	
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "personnel");
	session.setAttribute("subtitle", "setidtables_blacklist");
	session.setAttribute("action", "cmd_set_idtables_blacklist.jsp?");
	
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
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/datatables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		<script src="js/dataTables.checkboxes.min.js"></script>
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
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
					"scrollY": "289px",
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
				
				$('#btn_ok').on('click', function(){
					
					$('input[name="chkid"]', form).remove();
					
					var data_selected = "";
					var form = this;
					var rows_selected = table.column(0).checkboxes.selected();
					$.each(rows_selected, function(index, rowId){
						$(form).append($('<input>').attr('type', 'hidden').attr('name', 'chkid').val(rowId));
						data_selected = "1";		//	"&chkid="+rows_selected.join("&chkid=")
					});
					
					onSubmitSetID(data_selected, document.form1.hidden_ID.value, document.form1.rdo_cru, '<%= lang %>', '<%= lb_no_datadoor %>', '<%= msg_ps_selectdoor %>');
					return false;
				});
			});
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})

			function onLoads(lang){	
				if(lang  == "th"){ 
					txt = "ยังไม่เลือกรหัสพนักงาน";
					txt2 = "เลือกรหัสพนักงานแล้ว";
				}else{
					txt = "No select ID Card";
					txt2 = "Selected ID Card";
				}	
				
				if(document.getElementById("hidden_ID").value != ''){
					document.getElementById("lbtxt").innerHTML = txt2;
				}else{
					document.getElementById("lbtxt").innerHTML = txt;
				}	
			}
		</script>	
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onLoads('<%= lang %>');">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">	
			
				<form id="form1" name="form1" method="post">	
				
					<div class="table-responsive" style="border: 0px !important; margin-top: -10px;" border="0">
						<div style="min-width: 800px;" class="table" border="0">
							<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;">
								<div class="row" style="margin-bottom: -8px;">
									<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 5px;"> <div align="right"> <b>  <%= lb_sel_emp %> : </b> </div> </h5>
									<h5 class="modal-title col-xs-9 col-md-9">
										<img src="images/view.png" style="margin-left: -6px;" width="28" height="28" border="0" align="absmiddle" onClick="show_detail();" data-toggle="tooltip" data-placement="right" title="<%= lb_search %>"/>
										<label class="control-label"> <p style="color: #0000FF; margin-left: 15px; margin-top: 5px;" id="lbtxt"> </p> </label>
										<input type="hidden" name="hidden_ID" id="hidden_ID" value=""> <!--	id="hidden_ID"เก็บค่ารหัสพนักงาน	-->
									</h5>
								</div>
								<div class="row" style="display: none;">	
									<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 5px;"> <div align="right"> <b>  <%= lb_function %> : </b> </div> </h5>
									<h5 class="modal-title col-xs-9 col-md-9">
										<select class="form-control selectpicker" data-width="15%" data-container="body" data-size="10" name="rdo_cru" id="rdo_cru">
											<option value="2" selected> <%= lb_del %> </option>
										</select>
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
							String chkbox_door_id = "";
							int numtaff = 0, num_duplicateip = 0;
							try{
								ResultSet rs = stmtQry.executeQuery(selectDbDoorByHostByGroupUser(ses_per, ses_group_user, ses_control_reader));
								while(rs.next()){ 
									door_id = rs.getString("door_id");
									door_id_link = "<b> <a href='#' onClick='show_door(\""+ door_id +"\");' data-toggle='tooltip' data-placement='left' title='"+lb_viewdata+"'>" + door_id + "</a> </b>";
									ip_address = rs.getString("ip_address");
									
									thdesc = rs.getString("th_desc");
									if((thdesc == null || (thdesc.equals("null")) || (thdesc.equals("")))){
										thdesc = "&nbsp";
									}
									endesc = rs.getString("en_desc");
									if((endesc == null || (endesc.equals("null")) || (endesc.equals("")))){
										endesc = "&nbsp";
									}
									if(lang.equals("th")){				
										lang_desc = thdesc + " &nbsp; <b>" + txt_desc + "</b>";	
									}else{
										lang_desc = endesc + " &nbsp; <b>" + txt_desc + "</b>";	
									}
									
									locate_code_link = "<b> <a href='#' onClick='show_location(\""+rs.getString("locate_code")+"\");' data-toggle='tooltip' data-placement='left' title='"+lb_viewdata+"'>" + rs.getString("locate_code") + "</a> </b>";
									if(lang.equals("th")){
										locate_desc = locate_code_link + " - " + rs.getString("l_th_desc");	
									}else{
										locate_desc = locate_code_link + " - " + rs.getString("l_en_desc");	
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
										<td align="center"> <%= door_id_link %> <input type="hidden" name="hid_<%= door_id %>" value="<%= door_id %>"></td>
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
						<input type="hidden" name="emp_ids">
						<input type="hidden" name="rdo_mu" value="1">
						<input type="hidden" name="rdo_cru2" value="1">
						<% 
							if(getModuleF(stmtQry).equals("0")){
								out.println("<input type='hidden' name='command' value='A0'>");
							}else{
								out.println("<input type='hidden' name='command' value='47'>");
							}
						%>
						<button class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" name="btn_ok" id="btn_ok" onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; </button> &nbsp;
					</div>
					<div class="col-xs-4" align="center"> </div>

					<!--	Connect HW	-->
					<%@ include file="../tools/modal_connect_hw.jsp"%>
				
				</form>
				
			</div>
		</div>
		
		<%@ include file="../tools/modal_warning.jsp"%>
		<%@ include file="../tools/modal_viewdetail.jsp"%>
		
		<!--viewdoor & viewlocation -->
		<%@ include file="../tools/modal_view_door_location.jsp"%>
		
		<script>
			function show_detail(){
				view_detail.location = 'iframe_employees_blacklist.jsp';
				$('#myModalViewDetail').modal('show');
			}	
			
			function show_door(door_id){
				view_door.location = 'view_door.jsp?action=view&door_id='+door_id;
				$('#myModalViewDoor').modal('show');
			}	
			
			function show_location(locate_code){
				view_location.location = 'view_location.jsp?action=view&locate_code='+locate_code;
				$('#myModalViewLocation').modal('show');
			}	
			//--------------				
			function onSubmitSetID(data_selected, id, rdo, lang, msg, msg2){
			/* 	var v = "";
				var v1 = "1";
				var v2 = "1";
				var v3 = "1";
				var emp_ids = "";
				
				for(var i = 0; i < rdo.length; i++){
					if(rdo[i].checked == true){	
						v1 = rdo[i].value;
					}
				}	
				for(var i = 0; i < rdo1.length; i++){
					if(rdo1[i].checked == true){	
						v2 = rdo1[i].value;
					}
				}
				for(var i = 0; i < rdo2.length; i++){
					if(rdo2[i].checked == true){	
						v3 = rdo2[i].value;
					}
				}
				v = v1 + v2 + v3;	
			 */	
				var loop_rdo = "";
				if(id.value != "" ){ 
					for(var i = 0; i < 3; i++){
						loop_rdo += rdo.value;
					}
					emp_ids = loop_rdo + id;
				}
				
				if("<%= numtaff %>" == 0){
					ModalWarning_TextName(msg, "chkid");
					return false;	
				}else{
					if(document.form1.hidden_ID.value == ""){
						if(lang == 'th'){
							ModalWarning_TextName("กรุณาเลือกพนักงาน", "hidden_ID");
						}else{
							ModalWarning_TextName("Please select employee", "hidden_ID");
						}
						return false;
					}else if(data_selected == ""){
						ModalWarning_TextName(msg2, "chkid");
						return false;						
					}else{
						document.form1.emp_ids.value = emp_ids;
						
					//	window.document.form1.submit();		
						$('#myModalConnectHW').modal('show');
						window.document.form1.action = 'SetRequest.do?';
						window.document.form1.target = 'connect_hw';
						window.document.form1.submit();
					}
				}
			}
		</script>
	
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>