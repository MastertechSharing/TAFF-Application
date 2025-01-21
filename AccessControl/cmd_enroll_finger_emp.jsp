<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%	
	String idcard = "", fullname = "";
	if(!(request.getParameter("idcard") == null || request.getParameter("idcard").equals("") || request.getParameter("idcard").equals("null"))){			
		idcard = request.getParameter("idcard");
		try{
			ResultSet rs = stmtQry.executeQuery("SELECT th_fname, th_sname, en_fname, en_sname FROM dbemployee WHERE (idcard = '"+idcard+"')");
			rs.next();
			if(lang.equals("th")){
				fullname = rs.getString("th_fname")+" "+rs.getString("th_sname");						
			}else{	  
				fullname = rs.getString("en_fname")+"  "+rs.getString("en_sname");					
			}
			rs.close();
		}catch(SQLException e){ }
	}
	session.setAttribute("iframe_emp", idcard);
	
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
					"select": { "style": "single" },
					"aaSorting": [ 1, "asc" ],
					"dom": "<f<t>i>",	//	<lf<t>ip>
					"lengthMenu": [ [ -1 ], [ "All" ] ],
					"scrollY": "124px",
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
				
				$("input[type='checkbox']").first().remove();
				
				$('#btn_ok').on('click', function(){
					
					$('input[name="chkid"]', form).remove();
					
					var data_selected = "";
					var form = this;
					var rows_selected = table.column(0).checkboxes.selected();
					$.each(rows_selected, function(index, rowId){
						$(form).append($('<input>').attr('type', 'hidden').attr('name', 'chkid').val(rowId));
						data_selected = "1";		//	"&chkid="+rows_selected.join("&chkid=")
					});
					
					onSubmitGetSet(data_selected, '<%= lang %>', '<%= lb_no_datadoor %>', '<%= msg_ps_selectdoor %>');
					return false;
				});
			});
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>	
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px; margin-bottom: -50px; overflow-y: hidden;">
		
		<form id="form1" name="form1" method="post">
			<div class="table-responsive" style="border: 0px !important; margin-top: -10px;" border="0">
				<div style="min-width: 800px;" class="table" border="0">
					<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;"> 
						<div class="row">
							<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: 5px;"> <div align="right"> <b> <%= lb_empcode %> : </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2"> 
								<input type="text" class="form-control" id="emp_id" name="emp_id" value="<%= idcard %>" maxlength="16" style="max-height: 24px !important; background-color:#F0F0F0" readonly="readonly"/>
							</h5>
							<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 5px;"> <div align="right"> <b> <%= lb_names %> : </b> </div> </h5>
							<h5 class="modal-title col-xs-2 col-md-2">
								<input type="text" class="form-control" id="emp_name" name="emp_name" value="<%= fullname %>" style="max-height: 24px !important; min-width: 160px !important; background-color:#F0F0F0" readonly="readonly"/>										
							</h5>
							<div class="modal-title col-xs-1 col-md-1"> 
								<input type="hidden" name="sessions" value="<%= ses_user %>">
								<% 	if(getModuleF(stmtQry).equals("0")){
										out.println("<input type='hidden' name='command' value='25'>");
									}else{
										out.println("<input type='hidden' name='command' value='41'>");
									}						
								%>
								<button class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" name="btn_ok" id="btn_ok" style="max-height: 24px !important; margin-left: 35px;" onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; &nbsp; <%= lb_send_data %> &nbsp; &nbsp; &nbsp; </button> &nbsp;
							</div> 
							<div class="modal-title col-xs-2 col-md-2"> </div>
						</div>
						<div class="row">
							<h5 class="modal-title col-xs-3 col-md-3" style="margin-top: -10px;"> <div align="right"> <b> <%= lb_fingers %> : </b> </div> </h5>
							<h5 class="modal-title col-xs-9 col-md-9" style="margin-top: -10px;"> 
								<input name="NumFinger" type="radio" id="radio13" value="1" style="margin-left:  0px;" checked> &nbsp; <%= lb_fingers2 %> 1
								<input name="NumFinger" type="radio" id="radio14" value="2" style="margin-left: 30px;"> &nbsp; <%= lb_fingers2 %> 2
							</h5>
						</div>
						<div class="row">
							<div class="modal-title col-xs-1 col-md-1"> </div>
							<div class="modal-title col-xs-10 col-md-10">
								<table width="100%" class="table table-bordered" style="margin-top: 5px; margin-bottom: -5px;" cellspacing="0">
									<tr class="active">
										<td width="50%" colspan="5" align="center"> &nbsp; <label class="control-label"> <%= lb_fing1 %> </label> </td>
										<td width="50%" colspan="5" align="center"> &nbsp; <label class="control-label"> <%= lb_fing2 %> </label> </td>
									</tr>
									<tr>
										<td width="10%" align="center"> <label class="control-label"> <%= lb_finger0 %> </span> </td>
										<td width="10%" align="center"> <label class="control-label"> <%= lb_finger1 %> </span> </td>
										<td width="10%" align="center"> <label class="control-label"> <%= lb_finger2 %> </span> </td>
										<td width="10%" align="center"> <label class="control-label"> <%= lb_finger3 %> </span> </td>
										<td width="10%" align="center"> <label class="control-label"> <%= lb_finger4 %> </span> </td>
										<td width="10%" align="center"> <label class="control-label"> <%= lb_finger5 %> </span> </td>
										<td width="10%" align="center"> <label class="control-label"> <%= lb_finger6 %> </span> </td>
										<td width="10%" align="center"> <label class="control-label"> <%= lb_finger7 %> </span> </td>
										<td width="10%" align="center"> <label class="control-label"> <%= lb_finger8 %> </span> </td>
										<td width="10%" align="center"> <label class="control-label"> <%= lb_finger9 %> </span> </td>
									</tr>
									<tr>
										<td width="10%" align="center"> <input type="radio" name="typefinger" id="radio1" value="0" checked> </td>
										<td width="10%" align="center"> <input type="radio" name="typefinger" id="radio2" value="1"> </td>
										<td width="10%" align="center"> <input type="radio" name="typefinger" id="radio3" value="2"> </td>
										<td width="10%" align="center"> <input type="radio" name="typefinger" id="radio4" value="3"> </td>
										<td width="10%" align="center"> <input type="radio" name="typefinger" id="radio5" value="4"> </td>
										<td width="10%" align="center"> <input type="radio" name="typefinger" id="radio11" value="5"> </td>
										<td width="10%" align="center"> <input type="radio" name="typefinger" id="radio12" value="6"> </td>
										<td width="10%" align="center"> <input type="radio" name="typefinger" id="radio8" value="7"> </td>
										<td width="10%" align="center"> <input type="radio" name="typefinger" id="radio9" value="8"> </td>
										<td width="10%" align="center"> <input type="radio" name="typefinger" id="radio10" value="9"> </td>
									</tr>
								</table>
							</div>
							<div class="modal-title col-xs-1 col-md-1"> </div>
						</div>
					</div>
				</div>
			</div>
		
			<div class="table-responsive" style="border: 0px !important; margin-top: -10px; margin-bottom: 0px;" border="0">
				
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
					String door_id = "", ip_address = "";
					String lang_desc = "", thdesc = "", endesc = "", txt_desc = "";
					String locate_desc = "";
					String chkbox_door_id = "";
					int numtaff = 0, num_duplicateip = 0;
					try{
						ResultSet rs = stmtQry.executeQuery(selectDbDoorByHostByGroupUserByHWModel(ses_per, ses_group_user, ses_control_reader,""));
						while(rs.next()){ 
							door_id = rs.getString("door_id");
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
							
							if(lang.equals("th")){
								locate_desc = "<strong>" + rs.getString("locate_code") + "</strong> - " + rs.getString("l_th_desc");	
							}else{
								locate_desc = "<strong>" + rs.getString("locate_code") + "</strong> - " + rs.getString("l_en_desc");	
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
								<td align="center"> <strong> <%= door_id %> </strong> <input type="hidden" name="hid_<%= door_id %>" value="<%= door_id %>"> </td>
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
			
			<div class="col-xs-12" align="right" style="margin-top: -26px; padding-left: 320px;">
			<%	if(network_feature.equals("1")){	%>
				<%	if(num_duplicateip != 0){		%>
				<div class="has-error" style="margin-top: 6px;"> <label class="control-label"> 
					<%= lb_ip_dullicate1 %> <%= num_duplicateip %> <%= lb_ip_dullicate2 %> 
				</label> </div> 
				<%	}	%>
			<%	}	%>
			</div>
			
		</form>	
		
		<div class="modal fade" id="myModalWarning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="false" data-keyboard="false">
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
			function onSubmitGetSet(data_selected, lang, msg, msg2){
				if("<%= numtaff %>" == 0){
					ModalWarning_TextName(msg, "chkid");
					return false;	
				}else{
					if(document.form1.emp_id.value == ""){
						if(lang == 'th'){
							ModalWarning_TextName("กรุณาเลือกพนักงาน", "emp_id");
						}else{
							ModalWarning_TextName("Please select employee", "emp_id");
						}
						return false;
					}else if(data_selected == ""){
						ModalWarning_TextName(msg2, "chkid");
						return false;						
					}else{
						document.form1.action = 'SetRequest.do?';
					//	window.document.form1.target = 'connect_hw';
						document.form1.submit();
					}
				}
			}
		</script>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>