<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%	
	session.setAttribute("page_g", "tool");	
	session.setAttribute("subpage", "personnel");
	session.setAttribute("subtitle", "delpicture");
	session.setAttribute("action", "cmd_del_picture.jsp?");
	
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
		<script language="javascript" src="js/check_key.js"></script>
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
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script>
			document.onkeydown = searchKeyPress_tool;
			
			var data_selected = "";
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
					"scrollY": "292px",
					"scrollCollapse": true,
					"paging": false
					
				<%	if(lang.equals("th")){	%>	
					,"oLanguage": {
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
				$('.dataTables_info').addClass('pull-left');
				
				$('.data_table_filter, input').addClass('max-height-24');
				
				$('#btn_ok').on('click', function(){
					
					$('input[name="chkid"]', form).remove();
					
					var cRow = 0;
					var form = this;
					var rows_selected = table.column(0).checkboxes.selected();
					$.each(rows_selected, function(index, rowId){
						cRow++;
						$(form).append($('<input>').attr('type', 'hidden').attr('name', 'chkid').val(rowId));
					});
					//	Submit Form
					if(cRow != 0){
						data_selected = "1";		//	"&chkid="+rows_selected.join("&chkid=")
					}else{
						data_selected = "";
					}
					
					onSubmitGetSet(data_selected, '<%= lang %>', '<%= lb_no_datadoor %>', '<%= msg_ps_selectdoor %>');
					return false;
				});
			});
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>	
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="checkedid('<%= lang %>');">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">			
				<form id="form1" name="form1" method="post">				
					<div class="table-responsive" style="border: 0px !important; margin-top: -10px;" border="0">
						<div style="min-width: 800px;" class="table" border="0">
							<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;"> 
								<div class="row">
									<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 5px;"> <div align="right"> <b> <%= lb_empcode %> : </b> </div> </h5>
									<h5 class="modal-title col-xs-2 col-md-2"> 
										<input type="text" class="form-control" id="emp_id" name="emp_id" maxlength="16" style="min-height: 32px !important;" onKeyPress="IsValidCharacters()" onKeyDown="upperCase(this);" onKeyUp="upperCase(this); get_datatransaction(this.value)" onChange="upperCase(this);">
									<h5 class="modal-title col-xs-1 col-md-1">
										<img  src="images/view.png" width="28" height="28" border="0" align="absmiddle" onClick="show_detail();" data-toggle="tooltip" data-placement="right" title="<%= lb_search %>"/>
									</h5>
									</h5>
									<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 5px;"> <div align="right"> <b> <%= lb_names %> : </b> </div> </h5>
									<h5 class="modal-title col-xs-3 col-md-3">
										<input type="text" class="form-control" id="emp_name" name="emp_name" style="min-height: 32px !important; background-color:#F0F0F0" readonly="readonly"/>										
									</h5>
									<div class="modal-title col-xs-1 col-md-1"> </div> 
								</div>
								<p>
								<div class="row">
									<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 5px;"> </h5>
									<h5 class="modal-title col-xs-9 col-md-9" style="margin-top: 5px;"> 
										<div style="min-height: 24px;">
											<input type="checkbox" name="delall" id="delall" onclick="checkedid('<%= lang %>')" /> <%= lb_delallcmdD1 %>
										</div>
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
								ResultSet rs = stmtQry.executeQuery(selectDbDoorByHostByGroupUserByHWModel(ses_per, ses_group_user, ses_control_reader,""));
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
						<input type="hidden" name="command" value="D1">
						<input type="hidden" name="valueDel" value="1">
						<button class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" name="btn_ok" id="btn_ok" onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; </button> &nbsp;
					</div>
					<div class="col-xs-4" align="center"> </div>

					<!--	Connect HW	-->
					<%@ include file="../tools/modal_connect_hw.jsp"%>
				
				</form>
				
			</div>
		</div>
		
		<div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-trash alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: $('#myModalConfirm').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
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
		
		<%@ include file="../tools/modal_warning.jsp"%>
		<%@ include file="../tools/modal_viewdetail.jsp"%>
		
		<!--viewdoor & viewlocation -->
		<%@ include file="../tools/modal_view_door_location.jsp"%>
		
		<script>
			function show_detail(){
				view_detail.location = 'iframe_employee.jsp';
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
			
			function upperCase(obj){
				obj.value = obj.value.toLocaleUpperCase();
			}
			
			function onSubmitGetSet(data_selected, lang, msg, msg2){
				var num = 0;
				if(lang == "th"){
					sText = '���͡���ʾ�ѡ�ҹ ���� ź�ٻ�Ҿ��ѡ�ҹ������.';
					sDel = 'ź�ٻ�Ҿ��ѡ�ҹ������ ?';
				}else {
					sText = 'Select ID Card Or Delete Picture Employee All.';
					sDel = 'Delete Picture Employee All ?';
				}
				
				if("<%= numtaff %>" == 0){
					ModalWarning_TextName(msg, "chkid");
					return false;	
				}else{
					if(document.form1.emp_id.value != ""){
						num++;
						document.form1.delall.checked = false;
						if(document.form1.emp_id.value == ""){
							if(lang == 'th'){
								ModalWarning_TextName("��س����͡��ѡ�ҹ", "emp_id");
							}else{
								ModalWarning_TextName("Please select employee", "emp_id");
							}
							return false;
						}else if(data_selected == ""){
							ModalWarning_TextName(msg2, "chkid");
							return false;						
						}else{
						//	window.document.form1.submit();		
							$('#myModalConnectHW').modal('show');
							window.document.form1.action = 'SetRequest.do?';
							window.document.form1.target = 'connect_hw';
							window.document.form1.submit();
						}
					}else{				
						if(document.form1.delall.checked == true){			
							if(data_selected == ""){
								ModalWarning_TextName(msg2, "chkid");
								return false;
							}else{
								document.getElementById('text_confirm').innerHTML = sDel;
								$('#myModalConfirm').modal('show');	
								return false;
							}
						}
					}
					if(document.form1.delall.checked == false){
						if(num == 0){
							ModalWarning_TextName(sText,'delall');
							return false;
						}
					}
				}
			}
			
			function Confirm_Button(){
				document.form1.valueDel.value = "0";
				$('#myModalConfirm').modal('hide');
				
			//	window.document.form1.submit();		
				$('#myModalConnectHW').modal('show');
				window.document.form1.action = 'SetRequest.do?';
				window.document.form1.target = 'connect_hw';
				window.document.form1.submit();
			}
			
			function checkedid(lang){	
				if(document.form1.delall.checked == true){		
					if(document.form1.emp_id.value != ""){
						if(lang == "th"){
							ModalWarning_TextName('���͡��ѡ�ҹ����','emp_id');
						}else{
							ModalWarning_TextName('Selected ID Card.','emp_id');
						}		
						document.form1.delall.checked = false;
					}else{
						document.getElementById('emp_id').readOnly = true;
						document.getElementById('emp_id').style.background = "f0f0f0";
						document.getElementById('emp_name').readOnly = true;
						document.getElementById('emp_name').style.background = "f0f0f0";
						document.getElementById("imgfied").disabled = true;
					}			
				}else{
					document.getElementById('emp_id').readOnly = false;
					document.getElementById('emp_id').style.background = "ffffff";
					document.getElementById('emp_name').readOnly = true;
					document.getElementById('emp_name').style.background = "f0f0f0";
					document.getElementById("imgfied").disabled = false;
				}
			}
		</script>
	
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>