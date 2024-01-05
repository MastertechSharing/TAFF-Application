<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<% 
	session.setAttribute("page_g", "setting");
	session.setAttribute("subpage", "config");
	session.setAttribute("subtitle", "user");
	String action = "";
	if(request.getParameter("action") != null){
		action = request.getParameter("action");
	}else{
		response.sendRedirect("data_user.jsp");
	}
	session.setAttribute("action", "edit_user.jsp?action="+action+"&user_name="+request.getParameter("user_name")+"&");	   	
	session.setAttribute("act", action);
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
		<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
		<script src="js/locales/bootstrap-datetimepicker.th.js" charset="UTF-8"></script>
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			
		</style>
		
		<script language="javascript">
			document.onkeydown = searchKeyPress;
			
			function ConfirmAddEdit(act,sText,sText1,sText2,sText3,sText4,sText5,sText6,sText7){
				var stdate = form1.st_date.value;
				var expdate = form1.ex_date.value;
				var st_date = Number(stdate.substring(6, 10) + stdate.substring(3, 5) + stdate.substring(0, 2));
				var exp_date = Number(expdate.substring(6, 10) + expdate.substring(3, 5) + expdate.substring(0, 2));
				
				if(form1.user_name.value == ''){
					ModalWarning_TextName(sText1, "user_name");
					return false;
				}else{
					if (form1.user_name.value.length < 4) {
						ModalWarning_TextName(sText2+"<br/><br/>"+sText3, "user_name");	
						return false;		
					}
					if(form1.user_right.value == 1 || form1.user_right.value == 2 || form1.user_right.value == 5 || form1.user_right.value == 6){
						if(form1.dep_code.value == ''){
							ModalWarning_TextName(sText4, "dep_code");
							return false;
						}
					}
					if(form1.user_right.value == 5 || form1.user_right.value == 6){
						if(form1.sec_code.value == ''){
							ModalWarning_TextName(sText5, "sec_code");
							return false;
						}
					}
				/*	if(form1.user_right.value == 1 || form1.user_right.value == 2 || form1.user_right.value == 5 || form1.user_right.value == 6){
						if(form1.group_user.value == ''){
							ModalWarning_TextName(sText7, "group_user");
							return false;
						}
					}
				*/
					//	compareDate
					if(st_date > exp_date){
						ModalWarning_TextName(sText6, "ex_date");
						return false;
					}
				}
				
				if(act == 'add'){
					document.form1.action = 'module/act_user.jsp?action=add';		
					document.form1.submit();
				}else{
				
					document.getElementById("text_confirm").innerHTML = sText;
					$('#myModalConfirm').modal('show');
				}	
				
			}
			
			function Confirm_Button(){
				document.form1.action = "module/act_user.jsp?action=edit";	
				document.getElementById("form1").submit();
			}

			//	Change Section By Depart
			var list_sec_code = [];
			var list_sec_name = [];
			var list_dep_code = [];
			
			<%	try{
					String sql = "SELECT sec_code, dep_code, ";					
					if(lang.equals("th")){
						sql += "th_desc AS sec_desc ";
					}else{
						sql += "en_desc AS sec_desc ";
					}
					sql += "FROM dbsection ORDER BY sec_code asc ";
					ResultSet rs = stmtQry.executeQuery(sql);
					while(rs.next()){
			%>
					list_sec_code.push("<%= rs.getString("sec_code") %>"); 
					list_sec_name.push("<%= rs.getString("sec_code") %> - <%= rs.getString("sec_desc") %>"); 
					list_dep_code.push("<%= rs.getString("dep_code") %>");  
					
			<%		}	rs.close();
				} catch (SQLException e) { }
			%>
			
			function onClickDisplay(){
				if(document.form1.user_right.value == 0 || document.form1.user_right.value == 3 || document.form1.user_right.value == 4 || document.form1.user_right.value == 7){
					document.getElementById("dep_code").selectedIndex = "0";
					document.getElementById("dep_code").disabled = true;
					document.getElementById("select_dep_code").className = "input-group has-feedback";
					document.getElementById("icon_dep_code").className = "glyphicon glyphicon-ban-circle form-control-feedback";
				}else{
					document.getElementById("dep_code").disabled = false;
					if(document.form1.dep_code.value == ""){
						document.getElementById("select_dep_code").className = "input-group has-error has-feedback";
						document.getElementById("icon_dep_code").className = "glyphicon glyphicon-star form-control-feedback";
					}else{
						document.getElementById("select_dep_code").className = "input-group has-success has-feedback";
						document.getElementById("icon_dep_code").className = "glyphicon glyphicon-ok form-control-feedback";
					}
				}
				
				if(document.form1.user_right.value == 0 || document.form1.user_right.value == 1 || document.form1.user_right.value == 2 || document.form1.user_right.value == 3 || document.form1.user_right.value == 4 || document.form1.user_right.value == 7){
					document.getElementById("sec_code").selectedIndex = "0";
					document.getElementById("sec_code").disabled = true;
					document.getElementById("select_sec_code").className = "input-group has-feedback";
					document.getElementById("icon_sec_code").className = "glyphicon glyphicon-ban-circle form-control-feedback";
				}else{
					if(document.form1.dep_code.value != ''){
						
						RemoveAndNewOptions(document.getElementById("sec_code"));
						
						document.getElementById("sec_code").disabled = false;
						if(document.form1.sec_code.value == ""){
							document.getElementById("select_sec_code").className = "input-group has-error has-feedback";
							document.getElementById("icon_sec_code").className = "glyphicon glyphicon-star form-control-feedback";
						}else{
							document.getElementById("select_sec_code").className = "input-group has-success has-feedback";
							document.getElementById("icon_sec_code").className = "glyphicon glyphicon-ok form-control-feedback";
						}
					}
				}
				document.getElementById("control_reader").disabled = true;
				
				$('.selectpicker').selectpicker('refresh');
			}
			
			function onClickDisplayReader(){
				if(document.form1.user_right.value == 1 || document.form1.user_right.value == 2 || document.form1.user_right.value == 5 || document.form1.user_right.value == 6){
					document.getElementById("group_user").value = "";
					document.getElementById("group_user").disabled = false;
					document.getElementById("textbox_group_user").className = "form-group has-feedback";
					document.getElementById("icon_group_user").className = "glyphicon glyphicon-star form-control-feedback";
				}else{
					document.getElementById("group_user").value = "";
					document.getElementById("group_user").disabled = true;
					document.getElementById("textbox_group_user").className = "form-group has-feedback";
					document.getElementById("icon_group_user").className = "glyphicon glyphicon-ban-circle form-control-feedback";
				}
				document.getElementById("control_reader").disabled = true;
				
				$('#control_reader').val([]);
				$('.selectpicker').selectpicker('refresh');
			}
			
			function onClickDisplayCheckbox(){	
				if(document.form1.user_right.value == 7){
					document.getElementById("monitor_data").checked = true;
				}else{
					document.getElementById("monitor_data").checked = false;
				}
			}

			function chk_checkbox_monitor(){
				if(document.form1.user_right.value == 7){
					document.getElementById("monitor_data").checked = true;
				}
			}
			
			function change_class(field_name){
				if(field_name == "user_name"){
					if(document.form1.user_name.value.length >= 4){
						document.getElementById("textbox_username").className = "form-group has-success has-feedback";
						document.getElementById("icon_username").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_username").className = "form-group has-error has-feedback";
						document.getElementById("icon_username").className = "glyphicon glyphicon-star form-control-feedback";
					}
				}else if(field_name == "group_user"){
					if(document.form1.group_user.value.length >= 1){
						document.getElementById("textbox_group_user").className = "form-group has-success has-feedback";
						document.getElementById("icon_group_user").className = "glyphicon glyphicon-ok form-control-feedback";
						document.getElementById("control_reader").disabled = false;
					}else{
						document.getElementById("textbox_group_user").className = "form-group has-feedback";
						document.getElementById("icon_group_user").className = "glyphicon glyphicon-star form-control-feedback";
						
						document.getElementById("control_reader").disabled = true;
						$('#control_reader').val([]);
						$('.selectpicker').selectpicker('refresh');
					}
				}else if(field_name == "dep_code" || field_name == "sec_code"){
					document.getElementById("select_"+field_name).className = "input-group has-success has-feedback";
					document.getElementById("icon_"+field_name).className = "glyphicon glyphicon-ok form-control-feedback";
				}
				
				if(field_name == "dep_code"){
					
					if(document.form1.user_right.value == 5 || document.form1.user_right.value == 6){
						
						if(document.form1.dep_code.value != ''){
							
							document.getElementById("sec_code").selectedIndex = "0";
							
							RemoveAndNewOptions(document.getElementById("sec_code"));
							
							document.getElementById("sec_code").disabled = false;
							if(document.form1.sec_code.value == ""){
								document.getElementById("select_sec_code").className = "input-group has-error has-feedback";
								document.getElementById("icon_sec_code").className = "glyphicon glyphicon-star form-control-feedback";
							}else{
								document.getElementById("select_sec_code").className = "input-group has-success has-feedback";
								document.getElementById("icon_sec_code").className = "glyphicon glyphicon-ok form-control-feedback";
							}
						}
					}
					
				}
				
				$('.selectpicker').selectpicker('refresh');
			}
			
			function RemoveAndNewOptions(selectbox){
				for(var i = selectbox.options.length -1; i >= 1; i--){
					selectbox.remove(i);
				}
				
				for ( var i = 0; i < list_dep_code.length; i++) {
					if(document.form1.dep_code.value == list_dep_code[i]){
						$("#sec_code").append($('<option>', {value:  list_sec_code[i], text: list_sec_name[i]}));
					}
				}
			}
		</script>
		
	</head> 
		
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="onClickDisplay(); <% if(action.equals("add")){ %> onClickDisplayReader(); <% } %>">
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<%	if(!checkPermission(ses_per, "0")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">				
			<form id="form1" name="form1" method="post">
			
				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info"> 
<% 	
	String check_sec_code = "";
	if(action.equals("add")){
		String sql = "";
		String user_right = request.getParameter("user_right");
		
%>
						<div class="col-md-6" style="margin-left: -15px; margin-right: -15px;">
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_username %> : </label>
								<div class="col-md-8">
									<div class="form-group has-error has-feedback" id="textbox_username" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="user_name" name="user_name" maxlength="16" placeholder="<%= lb_username %>" onKeyPress="IsValidCharacter()" onKeyUp="change_class('user_name');" onBlur="change_class('user_name');" onChange="check_textbox()">
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_username" aria-hidden="true"> </span>
									</div>
								</div>	
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_permission %> : </label>
								<div class="col-md-8">
									<select class="form-control selectpicker" name="user_right" id="user_right" onChange="onClickDisplay();onClickDisplayReader();onClickDisplayCheckbox();">
										<option value="0"> <%= displayUser("0") %> </option>
										<option value="1"> <%= displayUser("1") %> </option>
										<option value="2"> <%= displayUser("2") %> </option>
										<option value="3"> <%= displayUser("3") %> </option>
										<option value="4"> <%= displayUser("4") %> </option>
										<option value="5"> <%= displayUser("5") %> </option>
										<option value="6"> <%= displayUser("6") %> </option>
										<option value="7"> <%= displayUser("7") %> </option>
									</select>
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_departcode %> : </label>
								<div class="col-md-8">
									<div class="input-group has-error has-feedback" id="select_dep_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="dep_code" id="dep_code" onChange="change_class('dep_code');">
											<option name="dep_code" value="" disabled selected> <%= lb_sel_depart %> </option>
									<%	try{
											ResultSet rs = stmtQry.executeQuery(" SELECT dep_code, "+lang+"_desc AS dep_desc FROM dbdepart ORDER BY dep_code ASC ");
											while(rs.next()){
									%>
											<option name="dep_code" value="<%= rs.getString("dep_code") %>"> <%= rs.getString("dep_code") %> - <%= rs.getString("dep_desc") %> </option>
									<%		}	rs.close();
										} catch (SQLException e) {
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
										}
									%>			
										</select>				  
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_dep_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
								</div>		
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_seccode %> : </label>
								<div class="col-md-8">
									<div class="input-group has-error has-feedback" id="select_sec_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="sec_code" id="sec_code" onChange="change_class('sec_code');">
											<option name="sec_code" value="" disabled selected> <%= lb_sel_sec %> </option>
									<%	try{
											ResultSet rs = stmtQry.executeQuery(" SELECT sec_code, "+lang+"_desc AS sec_desc FROM dbsection ORDER BY sec_code ASC ");
											while(rs.next()){
									%>
											<option name="sec_code" value="<%= rs.getString("sec_code") %>"> <%= rs.getString("sec_code") %> - <%= rs.getString("sec_desc" )%> </option>
									<%		}	rs.close();
										} catch (SQLException e) {
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
										}
									%>			
										</select>				  
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_sec_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
								</div>	
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_group_rights_assign %> : </label>
								<div class="col-md-8">
									<div class="form-group has-error has-feedback" id="textbox_group_user" style="margin-bottom: 0px">
										<input type="text" class="form-control" style="text-transform: uppercase;" id="group_user" name="group_user" maxlength="3" placeholder="<%= lb_group_rights_assign %>" onKeyPress="IsValidCharacter();" onKeyUp="change_class('group_user');" onBlur="change_class('group_user');" onselectstart="return false" onpaste="return false;" onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" />
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_group_user" aria-hidden="true"> </span>
									</div>
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_readers %> : </label>
								<div class="col-md-8">
									<select class="selectpicker" data-live-search="true" data-width="100%" data-size="10" data-container="body" name="control_reader" id="control_reader" multiple data-selected-text-format="count>3" data-actions-box="true">
								<%	try{
										ResultSet rs_rd = stmtQry.executeQuery(" SELECT rd.reader_no, rd."+lang+"_desc AS reader_desc FROM dbreader rd ORDER BY rd.reader_no ASC ");
										while(rs_rd.next()){
								%>			<option value="<%= rs_rd.getString("reader_no") %>"> <%= rs_rd.getString("reader_no") %> - <%= rs_rd.getString("reader_desc") %> </option>
								<%		}	rs_rd.close();
									}catch(SQLException e){							
										out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
									}
								%>	</select>
								</div>
							</div>  
						</div> 
						<div class="col-md-6" style="margin-left: -15px; margin-right: -15px;">
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_std %> : </label>
								<div class="col-md-6">
									<div class="input-group col-md-12">
										<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date" data-link-format="dd/mm/yyyy">
											<input class="form-control" type="text" value="<%= getCurrentDate() %>" readonly>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
										<input type="hidden" class="form-control" id="st_date" name="st_date" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_std %>" readonly="readonly" onChange="onChange_Date(form1.st_date.value,form1.ex_date.value);" style="background-color:#F0F0F0">
									</div>
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_exd %> : </label>
								<div class="col-md-6">
									<div class="input-group col-md-12">
										<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="ex_date" data-link-format="dd/mm/yyyy">
											<input class="form-control" type="text" value="<%= getCurrentDateInc(10) %>" readonly>
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
										<input type="hidden" class="form-control" id="ex_date" name="ex_date" maxlength="10" value="<%= getCurrentDateInc(10) %>" placeholder="<%= lb_std %>"  readonly="readonly" style="background-color:#F0F0F0">
									</div>
								</div>
							</div>
							<div class="row form-group" style="margin-bottom: 0px;">
								<div class="col-md-offset-4 col-md-6">
									<input name="monitor_data" type="checkbox" id="monitor_data" value="monitor_data" style="margin-right: 10px;" onClick="chk_checkbox_monitor();"> <strong> Monitor Data </strong>
								</div>
							</div>
						</div> 
						
						<div class="row form-group" style="margin-bottom: 0px;">
							<div class="col-md-12" align="center"> 
								<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return ConfirmAddEdit('add','<%=msg_confirmedit%>','<%= msg_user_login %>','<%= msg_un_input_len %>','<%= msg_un_input_again %>','<%= lb_sel_depart %>', '<%= lb_sel_sec %>', '<%= msg_mistake_datetime %>', '<%= lb_group_rights_assign %>');"> &nbsp; 
								<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_user.jsp'">
							</div>
						</div> 
		
<%	}else if(action.equals("edit")){
		String user_right = "", dep_code = "", sec_code = "", stdate = "", exdate = "", monitor_data = "", group_user = "";
		String[] control_reader = new String[0];
		String sql = "";
		if(mode == 0){
			sql = "SELECT u.*, DATE_FORMAT(st_date,'%d/%m/%Y') AS stdate_show, "
					+ "DATE_FORMAT(ex_date,'%d/%m/%Y') AS exdate_show ";
		}else if(mode == 1){
			sql = "SELECT u.*, CONVERT(varchar(10),st_date,103) AS stdate_show,"
					+ "CONVERT(varchar(10),ex_date,103) AS exdate_show ";
		}
		sql += "FROM dbusers u "
			+ "WHERE (u.user_name = '"+request.getParameter("user_name")+"') ";
		try{
			ResultSet rs = stmtQry.executeQuery(sql);		
			while(rs.next()){ 
				user_right = rs.getString("user_right");
				stdate = rs.getString("stdate_show");
				exdate = rs.getString("exdate_show");
				dep_code = rs.getString("dep_code");
				sec_code = rs.getString("sec_code");
				check_sec_code = sec_code;	
				monitor_data = rs.getString("monitor_data");
				
				group_user = rs.getString("group_user");
				control_reader = rs.getString("control_reader").split(",");
				
%>
						<div class="col-md-6" style="margin-left: -15px; margin-right: -15px;">
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_username %> : </label>
								<div class="col-md-8">
									<div class="form-group has-success has-feedback" id="textbox_user_name" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="user_name" name="user_name" value="<%= request.getParameter("user_name") %>" maxlength="16" placeholder="<%= request.getParameter("user_name") %>" onKeyPress="IsValidCharacters()" onKeyUp="change_class('user_name');" onBlur="change_class('user_name');" onChange="check_textbox()">
										<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_user_name" aria-hidden="true"> </span>
									 <input name="user_name2" type="hidden" id="user_name2" value="<%= request.getParameter("user_name") %>" />
									</div>
								</div>				
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_permission %> : </label>
								<div class="col-md-8">
									<select class="form-control selectpicker" name="user_right" id="user_right" onChange="onClickDisplay();onClickDisplayReader();onClickDisplayCheckbox();">
										<option value="0" <% if(user_right.equals("0")){ %> selected <% } %>> <%= displayUser("0") %> </option>
										<option value="1" <% if(user_right.equals("1")){ %> selected <% } %>> <%= displayUser("1") %> </option>
										<option value="2" <% if(user_right.equals("2")){ %> selected <% } %>> <%= displayUser("2") %> </option>
										<option value="3" <% if(user_right.equals("3")){ %> selected <% } %>> <%= displayUser("3") %> </option>
										<option value="4" <% if(user_right.equals("4")){ %> selected <% } %>> <%= displayUser("4") %> </option>
										<option value="5" <% if(user_right.equals("5")){ %> selected <% } %>> <%= displayUser("5") %> </option>
										<option value="6" <% if(user_right.equals("6")){ %> selected <% } %>> <%= displayUser("6") %> </option>
										<option value="7" <% if(user_right.equals("7")){ %> selected <% } %>> <%= displayUser("7") %> </option>
									</select>
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_departcode %> : </label>
								<div class="col-md-8">
									<div class="input-group has-success has-feedback" id="select_dep_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="dep_code" id="dep_code" onChange="change_class('dep_code');">
											<option name="dep_code" value="" disabled> <%= lb_sel_depart %> </option>
									<%	try{
											ResultSet rs_depart = stmtTmp.executeQuery(" SELECT dep_code, "+lang+"_desc AS dep_desc FROM dbdepart ORDER BY dep_code ASC ");
											while(rs_depart.next()){	
									%>
										<option value="<%= rs_depart.getString("dep_code") %>"<%= checkDataSelected(rs_depart.getString("dep_code"), dep_code) %>> <%= rs_depart.getString("dep_code") %> - <%= rs_depart.getString("dep_desc") %> </option>
									<%		}	rs_depart.close();	
										} catch (SQLException e) {
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
										}
									%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_dep_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>							
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_seccode %> : </label>
								<div class="col-md-8">
									<div class="input-group has-error has-feedback" id="select_sec_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="sec_code" id="sec_code" onChange="change_class('sec_code');">
											<option name="sec_code" value="" disabled> <%= lb_sel_sec %> </option>
									<%	try{
											ResultSet rs_section = stmtTmp.executeQuery(" SELECT sec_code, "+lang+"_desc AS sec_desc FROM dbsection ORDER BY sec_code ASC ");
											while(rs_section.next()){
									%>
											<option value="<%= rs_section.getString("sec_code") %>" <%= checkDataSelected(rs_section.getString("sec_code"), sec_code) %>> <%= rs_section.getString("sec_code") %> - <%= rs_section.getString("sec_desc") %> </option>
									<%		}	rs_section.close();
										} catch (SQLException e) {
											out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
										}
									%>			
										</select>				  
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_sec_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
								</div>	
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_group_rights_assign %> : </label>
								<div class="col-md-8">
									<div class="form-group has-feedback" id="textbox_group_user" style="margin-bottom: 0px">
										<input type="text" class="form-control" style="text-transform: uppercase;" id="group_user" name="group_user" value="<%= group_user %>" maxlength="3" placeholder="<%= lb_group_rights_assign %>" onKeyPress="IsValidCharacter();" onKeyUp="change_class('group_user');" onBlur="change_class('group_user');" onselectstart="return false" onpaste="return false;" onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" />
										<span class="glyphicon glyphicon-ban-circle form-control-feedback" id="icon_group_user" aria-hidden="true"> </span>
									</div>
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_readers %> : </label>
								<div class="col-md-8">
									<select class="selectpicker" data-live-search="true" data-width="100%" data-size="10" data-container="body" name="control_reader" id="control_reader" multiple data-selected-text-format="count>3" data-actions-box="true">
								<%	try{
										ResultSet rs_rd = stmtTmp.executeQuery(" SELECT rd.reader_no, rd."+lang+"_desc AS reader_desc FROM dbreader rd ORDER BY rd.reader_no ASC ");
										while(rs_rd.next()){
								%>			<option value="<%= rs_rd.getString("reader_no") %>" <%= checkSelectQryDataList(rs_rd.getString("reader_no"), control_reader) %> > <%= rs_rd.getString("reader_no") %> - <%= rs_rd.getString("reader_desc") %> </option>
								<%		}	rs_rd.close();
									}catch(SQLException e){							
										out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
									}
								%>	</select>
									<input type="hidden" class="form-control" id="control_reader_old" name="control_reader_old" value="<%= rs.getString("control_reader") %>" onselectstart="return false" onpaste="return false;" onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" />
								</div>
							</div>  
						</div>
						<div class="col-md-6" style="margin-left: -15px; margin-right: -15px;">
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_std %> : </label>
								<div class="col-md-6">
									<div class="input-group col-md-12">
										<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date" data-link-format="dd/mm/yyyy">
											<input class="form-control" type="text" value="<%= stdate %>" readonly onChange="onChange_Date(form1.st_date.value,form1.ex_date.value);">
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
										<input type="hidden" class="form-control" id="st_date" name="st_date" value="<%= stdate %>" maxlength="10" placeholder="<%= lb_std %>" readonly="readonly" onChange="onChange_Date(form1.st_date.value,form1.ex_date.value);" style="background-color:#F0F0F0">									
									</div>
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_exd %> : </label>
								<div class="col-md-6">
									<div class="input-group col-md-12">
										<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="ex_date" data-link-format="dd/mm/yyyy">
											<input class="form-control" type="text" value="<%= exdate %>" readonly >
											<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
										</div>
										<input type="hidden" class="form-control" id="ex_date" name="ex_date" value="<%= exdate %>" maxlength="10" placeholder="<%= lb_std %>" readonly="readonly" style="background-color:#F0F0F0">									
									</div>
								</div>
							</div>
							<div class="row form-group" style="margin-bottom: 0px;">
								<div class="col-md-offset-4 col-md-6">
									<input name="monitor_data" type="checkbox" id="monitor_data" value="monitor_data" style="margin-right: 10px;" <%= checkBoxAtPos(monitor_data, 0) %> onClick="chk_checkbox_monitor();"> <strong> Monitor Data </strong>
								</div>
							</div>
						</div>
						
						<div class="row form-group" style="margin-bottom: 0px;">
							<div class="col-md-12" align="center">
								<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return ConfirmAddEdit('edit','<%=msg_confirmedit%>','<%= msg_user_login %>','<%= msg_un_input_len %>','<%= msg_un_input_again %>','<%= lb_sel_depart %>', '<%= lb_sel_sec %>', '<%=msg_mistake_datetime %>', '<%= lb_group_rights_assign %>')"> &nbsp; 
								<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_user.jsp'">
								<input type="hidden" name="action" id="action" value="edit" >
							</div>
						</div>
<%		
			}
			rs.close();	
		}catch(SQLException e){		
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
		}	
	}	
%>	
					</div>   
				</div>   
				
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
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_user.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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
			
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
					setTimeout(function(){
						checkSection('<%= check_sec_code %>');
						
					<%	if(action.equals("edit")){	%>	
						onClickDisplayReaderEdit();
					<%	}	%>
					}, 150);
				}
			}
			
			function onClickDisplayReaderEdit(){
				var user_right = document.getElementById("user_right").value;
				if(user_right == 1 || user_right == 2 || user_right == 5 || user_right == 6){
					document.getElementById("group_user").disabled = false;
					change_class("group_user");
				}else{
					document.getElementById("group_user").value = "";
					document.getElementById("group_user").disabled = true;
					document.getElementById("textbox_group_user").className = "form-group has-feedback";
					document.getElementById("icon_group_user").className = "glyphicon glyphicon-ban-circle form-control-feedback";
					
					document.getElementById("control_reader").disabled = true;
				}
			}
			
			function checkSection(sec_code){
				if(sec_code != '' && sec_code != 'null'){
					var select_sec = document.getElementById("sec_code");
					for ( var i = 1; i < select_sec.options.length; i++) {
						if(select_sec.options[i].value == sec_code){
							select_sec.selectedIndex = i;
						}
					}
					$('.selectpicker').selectpicker('refresh');
				}
			}
		</script>	
		
		<%	}	%>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>