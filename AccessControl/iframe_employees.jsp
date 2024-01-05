<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
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
		
		<script language="javascript">
			$(document).ready(function() {
				var table = $('#data_table').DataTable({
					"initComplete": function (settings) {
						var api = this.api();
						api.cells(
							api.rows(function (idx, data, node) {
								return (data[2].length > 16) ? true : false;
							//	return true;
							}).indexes(),
							0
						).checkboxes.disable();
					//	).checkboxes.select();
					},
					"columnDefs": [{ 
						"targets": 2, 
						"checkboxes": { "selectRow": true }
					}],
					"select": { "style": "multi" },
					"aaSorting": [ 0, "asc" ],
					"dom": "<f<t>i>",	//	<lf<t>ip>
					"lengthMenu": [ [ -1 ], [ "All" ] ],
					"scrollY": "195px",
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
				
				/*	
				//	$('input[name="chkid"]', form).remove();
					
					var data_selected = "";
					var form = this;
					var rows_selected = table.column(2).checkboxes.selected();
					$.each(rows_selected, function(index, rowId){
					
						$(form).append($('<input>').attr('type', 'hidden').attr('name', 'chkid').val(rowId));
						data_selected = "1";		//	"&chkid="+rows_selected.join("&chkid=")
					});
					
				//	onSubmitSetID(data_selected, document.form1.hidden_ID.value, document.form1.rdo_cru, '<%= lang %>', '<%= lb_no_datadoor %>', '<%= msg_ps_selectdoor %>');
				*/	
					var rows_selected = table.column(2).checkboxes.selected();
					var rows_data = rows_selected.join(",");
					console.log(rows_data);
					
					if(rows_data != ''){
						window.top.$("#hidden_ID").val(rows_data);
						window.top.$("#myModalViewDetail").modal('hide');
						window.top.onLoads('<%= lang %>');
					}else{
						<%	if(lang.equals("th")){	%>	
							ModalWarning_TextName('กรุณาเลือกรหัสพนักงาน', 'data_table_filter');
						<%	}else{	%>
							ModalWarning_TextName('Please select ID Card', 'data_table_filter');
						<%	}	%>
					}
					
					return false;
				});
			});
			
			function orderBy(){	//	Section & Group
				value_choice = document.forms[0].check_choice;
				sel_s = document.form1.select_search.value;	
				location.href = 'iframe_employees.jsp?select_search='+sel_s+'&check_search='+document.form1.hidcheck_search.value;
			}
			
			function order_search(lang){	//	Search Data
				value_choice = document.forms[0].check_choice;
				id = "";
				loop = 0;
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
				
				if(id == ''){
					if(document.form1.select_search.value == '0'){ 		
						if(lang == "th"){
							alert('กรุณาเลือกแผนก');
						}else{
							alert('Please Select section');
						}
					}else{
						if(lang == "th"){
							alert('กรุณาเลือกกลุ่มพนักงาน');
						}else{
							alert('Please Select group employee');
						}
					}
					return false;
				}
				location.href = 'iframe_employees.jsp?select_search='+document.form1.select_search.value+'&check_search='+document.form1.hidcheck_search.value+'&check_choice='+id;
			}

			function add_valueID(lang){	
		/*		var req = Inint_AJAX();
				var loop = 0;
				var i;
				var value_id = "";
				var value_chk = document.forms[0].check_empid;
				
				if(document.form1.check_empid == null){ //	Can't found employee
					value_id = "";
				}else{	
					if(value_chk.length == null){
						if(value_chk.checked){
							value_id = value_chk.value;	
						}else{
							value_id = "";
						}
					}else{ 		
						for(i = 0; i < value_chk.length; i++){
							if(value_chk[i].checked){
								loop = loop+1;
								if(loop != 1){
									value_id = value_id +","+ value_chk[i].value;
								}else{
									value_id = value_id + value_chk[i].value;
								}
							}
						}
					}		
				}
				
				if(value_id == ''){
					if(lang == "th"){
						alert('กรุณาเลือกรหัสพนักงาน');
					}else{
						alert('Please Select ID Card');
					}
					return false;
				}
				var txt;
				if (value_id != '') {
					if(lang == "th"){
						txt = "เลือกรหัสพนักงานแล้ว";
					}else{
						txt = "Selected ID Card";
					}      
				}
				parent.window.document.getElementById("lbtxt").innerHTML = txt;
				parent.window.document.getElementById("hidden_ID").value = value_id; 
				
				window.top.$("#myModalViewDetail").modal('hide');
				
				req.open("POST", "set_idtables.jsp");
				req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620");
				req.send("hidden_ID="+value_id);
				req.send("lbtxt="+txt);
		
			*/
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -60px; overflow-y: hidden;">
	
		<form name="form1" method="post">
	<%	
		String select_search = "";
		String check_search = "";
		String[] check_choice_id =  null;
		String check_choice = "";
		String[] check_value;
		String[] check_id;

		if(request.getParameter("select_search") != null || request.getParameter("select_search") != ""){
			select_search = request.getParameter("select_search"); 
		}
		if(request.getParameter("check_search") != null){
			check_search = request.getParameter("check_search");
		}
		if(request.getParameterValues("check_choice") != null){
			check_choice_id = request.getParameterValues("check_choice");
		
			for(int i = 0; i <= check_choice_id.length -1; i++){
				if(i != check_choice_id.length -1){
					check_choice =  check_choice+check_choice_id[i] +",";
				}else{
					check_choice =  check_choice+check_choice_id[i];
				}
			}
			check_search = check_choice;
		}
	%>
			
			<div class="table-responsive" style="border: 0px !important; margin-bottom: -10px; margin-bottom: -50px;" border="0">
				<div style="min-width: 800px;" class="table" border="0">
					
					<div class="row" style="margin-left: 0px; margin-right: 0px;">
						<div class="modal-title col-xs-12 col-md-12">
							<div class="bs-callout bs-callout-info"> 
								<div class="row">
									<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 6px;"> <div align="right"> <b> <%= lb_select %> : </b> </div> </h5>
								<%	if(select_search == null) { select_search = "0"; }	%>
									<div class="modal-title col-xs-3 col-md-3">
										<select name="select_search" data-width="97%" id="select_search" onchange="orderBy();" class="form-control selectpicker">
											<option value="0" <% if(select_search.equals("0")){ %>selected="selected" <% } %> > <%= lb_sect %> </option>
											<option value="1" <% if(select_search.equals("1")){ %>selected="selected" <% } %> > <%= lb_groupemp %> </option>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row" style="margin-left: 0px; margin-right: 0px;">
						<div class="modal-title col-xs-5 col-md-5">
						
							<div class="bs-callout bs-callout-info"> 
								<div class="row">
						
									<div style="overflow-y:scroll; overflow-x:hidden; height:300px; width:95%; margin-left: 10px;">
									<table class="table table-bordered table-hover" align="center" border="0" style="max-width: 100%; margin-bottom: 0px;">
										<thead>
											<tr class="active">
												<td class="pad-left-10"> 
													<input type="checkbox" name="checkall" id="checkall2" value="*" onclick="checkAllObj(this, document.form1.check_choice, '<%= lang %>', 'secs');"/> &nbsp; 
													<b> <%= lb_chooseall %> </b>
												</td>
											</tr>
										</thead>
										<tbody>
							<%	
								String sql_section = "";
								if((select_search.equals("0")) || (select_search == null) || (select_search.equals(""))){	
									if(mode == 0){
										sql_section = "SELECT DISTINCT(sec.sec_code), CONCAT('[',sec.sec_code,'] - ',sec.th_desc) AS desc_th, CONCAT ('[',sec.sec_code,']-',sec.en_desc) AS desc_en ";
									}else if(mode == 1){
										sql_section = "SELECT DISTINCT(sec.sec_code), sec.sec_code+' - '+sec.th_desc AS desc_th, sec.sec_code+'-'+sec.en_desc AS desc_en ";
									}
									sql_section = sql_section + "FROM dbsection sec ";
									if(checkPermission(ses_per, "12")){
										sql_section = sql_section + "LEFT OUTER JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) "
												+ "LEFT OUTER JOIN dbusers users ON (users.dep_code = dep.dep_code) "
												+ "WHERE (users.user_name = '"+ses_user+"') ";
									}else if(checkPermission(ses_per, "56")){
										sql_section = sql_section + "LEFT OUTER JOIN dbusers users ON (users.sec_code = sec.sec_code) "
												+ "WHERE (users.user_name = '"+ses_user+"') ";
									}
									sql_section = sql_section + "ORDER BY sec.sec_code ";
									
									ResultSet rs_section = stmtQry.executeQuery(sql_section);
									while(rs_section.next()){
							%>
											<tr>
												<td class="pad-left-10"> 
													<div class="ellipsis_string" style="width: 90%">
														<input type="checkbox" id="check_choice" name="check_choice" value="<%= rs_section.getString("sec_code") %>" onclick="checkSelectObj(document.form1.checkall2, document.form1.check_choice);"
							<%	
									if(!(check_choice == null)){
										check_id = check_choice.split(",");
										for(int i = 0; i < check_id.length; i++){
											if(rs_section.getString("sec_code").equals(check_id[i])){
												out.print("checked");
											}
										}
									}
							%>
														/> &nbsp; 
							<%		
									if(lang.equals("th")){
										out.print(rs_section.getString("desc_th"));
									}else{
										out.print(rs_section.getString("desc_en"));
									}
							%>
													</div>
												</td>
											</tr>	
							<%	
									}
									rs_section.close();
								}
								
								try{
									String sql_group = "";
									if(select_search.equals("1")) {
										if(mode == 0){
											sql_group = "SELECT DISTINCT(gr.group_code), CONCAT ('[',gr.group_code,'] - ',gr.th_desc) AS desc_th, CONCAT ('[',gr.group_code,']-',gr.en_desc) AS desc_en ";
										}else if(mode == 1){
											sql_group = "SELECT DISTINCT(gr.group_code),gr.group_code+' - '+ gr.th_desc AS desc_th,gr.group_code+'-'+ gr.en_desc AS desc_en ";
										}
										sql_group = sql_group + "FROM dbgroup gr ";
										if(checkPermission(ses_per, "12")){
											sql_group = sql_group + "LEFT JOIN dbemployee emp ON (emp.group_code = gr.group_code) "
													+ "LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
													+ "LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
													+ "LEFT JOIN dbusers ur ON (ur.dep_code = dep.dep_code) ";
										}else if(checkPermission(ses_per, "56")){
											sql_group = sql_group + "LEFT JOIN dbemployee emp ON (emp.group_code = gr.group_code) "
													+ "LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
													+ "LEFT JOIN dbusers ur ON (ur.sec_code = sec.sec_code) ";
										}
										sql_group = sql_group + "WHERE (gr.group_code != 'groupblacklist') ";
										if(checkPermission(ses_per, "1256")){
											sql_group = sql_group + " AND (ur.user_name = '"+ses_user+"') ";
										}
										sql_group = sql_group + "ORDER BY gr.group_code ";
										
										ResultSet rs_group = stmtQry.executeQuery(sql_group);
										while(rs_group.next()){
							%>
											<tr>
												<td class="pad-left-10"> 
													<div class="ellipsis_string" style="width: 90%">
														<input type="checkbox" id="check_choice" name="check_choice" value="<%= rs_group.getString("group_code") %>" onclick="checkSelectObj(document.form1.checkall2, document.form1.check_choice);"
							<%	
											if(!(check_choice == null)){
												check_id = check_choice.split(",");
												for(int i = 0; i < check_id.length; i++){
													if(rs_group.getString("group_code").equals(check_id[i])){
														out.print("checked");
													}
												}
											}
							%>
														/> &nbsp; 
							<%	
											if(lang.equals("th")){
												out.print(rs_group.getString("desc_th"));
											}else{
												out.print(rs_group.getString("desc_en"));
											} 
							%>						
													</div>
												</td>
											</tr>
							<%	
										}	rs_group.close();	
									}
							
								}catch(SQLException e){
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
								}
							%>	
										</tbody>
									</table>
									</div>
									
								</div>
								<p>
								<div class="row">
									<div class="modal-title col-xs-12 col-md-12" align="center">
										<input type="button" name="button2" class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_finddata %> &nbsp; &nbsp; &nbsp; " onclick="order_search('<%= lang %>');" onMouseOver="this.style.cursor='hand';">
										<input type="hidden" name="hidcheck_search" value="<%= check_search %>"/>
									</div>
								</div>
							</div>
						
						</div>
						
						<div class="modal-title col-xs-7 col-md-7">
						
							<div class="bs-callout bs-callout-info" style="margin-left: -10px;"> 
								<div class="row">
						
									<div style="overflow-y:scroll; overflow-x:hidden; height:300px; max-width:95%; margin-left: 10px; overflow-y: hidden;">
									<table class="table table-bordered table-hover" id="data_table" align="center" border="0" style="max-width: 95%; margin-bottom: 0px;">
										<thead>
											<tr class="active">
												<th width="30%" align="center"> <%= lb_empcode %> </th>
												<th width="60%" align="center"> <%= lb_names %> </th>
												<th width="5%" align="center"> </th> <!--	<input type="checkbox" name="checkall1" id="checkall1" value="*" onclick="checkAllObj(this, document.form1.check_empid, '<%= lang %>', 'emps');"/>	-->
											</tr>
										</thead>
										<tbody>
										
							<%	
								int count = 0;
								String sql = "SELECT emp.idcard, emp.sec_code, emp.group_code, ";
								if(mode == 0){
									if(lang.equals("th")){
										sql += "CONCAT(th_fname,' ',th_sname) AS em_name ";
									}else{
										sql += "CONCAT(en_fname,' ',en_sname) AS em_name ";
									}
								}else if(mode == 1){
									if(lang.equals("th")){
										sql += "th_fname+' '+th_sname AS em_name ";
									}else{
										sql += "en_fname+' '+en_sname AS em_name ";
									}
								}
								sql = sql + "FROM dbemployee emp ";
	
								if(checkPermission(ses_per, "034")){
									
									sql = sql + "WHERE NOT EXISTS (SELECT bl.idcard, bl.cancel_status FROM dbblacklist bl WHERE emp.idcard = bl.idcard AND bl.cancel_status = '0')";
									
									if(select_search.equals("0")){ 
										if(!(check_choice == null||check_choice.equals(""))){
											sql = sql + "AND (";
											check_value = check_choice.split(",");
											for(int i = 0; i < check_value.length; i++){
												sql = sql + " (emp.sec_code = '"+check_value[i]+"') ";
												if(i != check_value.length - 1){
													sql = sql + "OR";
												}
											}
											sql = sql + ") ";				
										}
									}
									
									if(select_search.equals("1")) { 
										if(!(check_choice == null||check_choice.equals(""))){
											sql = sql + "AND (";
											check_value = check_choice.split(",");
											for(int i = 0; i < check_value.length; i++){
												sql = sql + " (emp.group_code = '"+check_value[i]+"') ";
												if(i != check_value.length - 1){
													sql = sql + "OR";
												}
											}
											sql = sql + ") ";
										}
									}
									sql = sql + "ORDER BY emp.idcard";	
								
								}else if(checkPermission(ses_per, "1256")){
									
									if(checkPermission(ses_per, "12")){
										sql += "INNER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
											+ "INNER JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
											+ "INNER JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
									}else if(checkPermission(ses_per, "56")){
										sql += "INNER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
											+ "INNER JOIN dbusers users ON (users.sec_code = sec.sec_code) ";
									}
									
									sql = sql + "WHERE NOT EXISTS (SELECT bl.idcard, bl.cancel_status FROM dbblacklist bl WHERE emp.idcard = bl.idcard AND bl.cancel_status = '0')";
									sql = sql + "AND (users.user_name = '"+ses_user+"')";
									
									if(select_search.equals("0")){ 
										if(!(check_choice == null||check_choice.equals(""))){
											sql = sql + "AND (";
											check_value = check_choice.split(",");
											for(int i = 0; i < check_value.length; i++){
												sql = sql + " (emp.sec_code = '"+check_value[i]+"') ";
												if(i != check_value.length - 1){
													sql = sql + "OR";
												}
											}
											sql = sql + ") ";
										}		
									}
									
									if(select_search.equals("1")) { 
										if(!(check_choice == null||check_choice.equals(""))){
											sql = sql + "AND (";
											check_value = check_choice.split(",");
											for(int i = 0; i < check_value.length; i++){
												sql = sql + " (group_code = '"+check_value[i]+"') ";
												if(i != check_value.length - 1){
													sql = sql + "OR";
												}
											}
											sql = sql + ") ";
										}			
									}
									sql = sql + "ORDER BY idcard";	
								
								}
								
								try{		
									ResultSet rs = stmtQry.executeQuery(sql);	
									while(rs.next()){
							%>
											<tr>
												<td class="pad-left-10"> <%= rs.getString("idcard") %> </td>
												<td class="pad-left-10"> <div class="ellipsis_string" style="max-width: 240px"> <%= rs.getString("em_name") %> </div> </td>
												<td align="center"> <%= rs.getString("idcard") %> </td> <!--	<input type="checkbox" name="check_empid" id="check_empid" value="<%= rs.getString("idcard") %>" onclick="checkSelectObj(document.form1.checkall1,document.form1.check_empid);"/>	-->
											</tr>
							<%		}	rs.close();
								}catch(SQLException e){
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
								}
							%>		
										</tbody>
									</table> 
									</div>
						
								</div>
								<p>
								<div class="row">
									<div class="modal-title col-xs-12 col-md-12" align="center">
										<input type="button" name="btn_ok" id="btn_ok" class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onclick="add_valueID('<%= lang %>')" onMouseOver="this.style.cursor='hand';"/></td>
									</div>
								</div>
							</div>
						
						</div>
					</div>
				</div>
			</div>	
		<%@ include file="../tools/modal_viewdetail.jsp"%>
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
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>