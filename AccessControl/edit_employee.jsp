<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<% 
	session.setAttribute("page_g", "database");
	session.setAttribute("subpage", "personnel");
	session.setAttribute("subtitle", "employee"); 
	session.setAttribute("action", "edit_employee.jsp?"+"&action="+request.getParameter("action")+"&idcard="+request.getParameter("idcard")+"&");
	
	String username = (String) session.getAttribute("ses_username");
	String ses_group_user = (String)session.getAttribute("ses_group_user");
	
	//	Check grant group user
	boolean show_action = true;
	String where_group_user = "";
	if(ses_per == 1 || ses_per == 2 || ses_per == 5 || ses_per == 6){
		if(!ses_group_user.equals("")){
			show_action = false;
			where_group_user = " AND ( group_user = '"+ses_group_user+"' ) ";
		}else{
			where_group_user = " AND ( group_user = '' ) ";
		}
	}else{
		where_group_user = " AND ( group_user = '' ) ";
	}
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
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
		
		<script language="javascript">
			document.onkeydown = searchKeyPress;
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
			function chkSncard(sText, elementid){	
				if(form1.use_map_card.checked == true){
					if(form1.sn_card.value == '' || form1.sn_card.value == null ){
						document.getElementById('use_map_card').checked = false;
						ModalWarning_TextName(sText, "sn_card");
					}else{
						document.getElementById('use_map_card').checked= true;
					}
				}
			}
			
			function ImgLoad(){
				var myobj = document.getElementById("img_emp");				
				if(myobj != null){  
					var id =  document.getElementById("idcard").value;	
					var oImg = new Image();			
					oImg.src = "photos/"+id+".jpg";
					oImg.onload = function(){ myobj.src = oImg.src; }
					oImg.onerror = function(){ 					
						oImg.src = "photos/"+id+".JPG"; 						
						oImg.onerror = function(){ 
							oImg.src = "photos/person.png";
						}
					}					
				}
			}
			
			function Rotate() {
				document.getElementById("resize_small").style.display = "none";
			
				// Code for Safari
				document.getElementById("resize_full").style.WebkitTransform = "rotate(90deg)"; 
				document.getElementById("resize_small").style.WebkitTransform = "rotate(90deg)"; 
				// Code for IE9
				document.getElementById("resize_full").style.msTransform = "rotate(90deg)"; 
				document.getElementById("resize_small").style.msTransform = "rotate(90deg)"; 
				// Standard syntax
				document.getElementById("resize_full").style.transform = "rotate(90deg)"; 
				document.getElementById("resize_small").style.transform = "rotate(90deg)"; 
			}
			
			function ShowFullImage(){
				document.getElementById("resize_full").style.display = "none";
				$('#img_emp').animate({height: '170px', width: '170px'}, 'slow');	//	100px
				document.getElementById("resize_small").style.display = "";
			}
			
			function ShowSmallImage(){
				document.getElementById("resize_small").style.display = "none";
				$('#img_emp').animate({height: '24px', width: '24px'}, 'slow');
				document.getElementById("resize_full").style.display = "";
			}
		
			function ConfirmAdd(act, sText, sText2, sText3, sText4, sText5, sText6, sText7, sText8, sText9, sText10, sText11){
				var stdate = form1.st_date.value;
				var expdate = form1.ex_date.value;
				var hh1 = form1.hh1.value;
				var mm1 = form1.mm1.value;
				var hh2 = form1.hh2.value;
				var mm2 = form1.mm2.value;
				
				var st_date = stdate.substring(6, 10)+stdate.substring(3, 5)+stdate.substring(0, 2)+hh1+mm1;	
				var exp_date = expdate.substring(6, 10)+expdate.substring(3, 5)+expdate.substring(0, 2)+hh2+mm2;
				if(document.form1.idcard.value == ""){
					ModalWarning_TextName(sText2, "idcard");
					return false;
				}else{
					//	sn_card
					if(form1.sn_card.value != "" && form1.sn_card.value.length != 8){
						if(form1.sn_card.value.length != 14){
							ModalWarning_TextName(sText3, "sn_card");
							return false;
						}
					}	
					//	issue
					if(document.form1.issue.value == ""){
						ModalWarning_TextName(sText4, "issue");
						return false;
					}
					if(form1.issue.value < 00 || form1.issue.value > 99){
						ModalWarning_TextName(sText11, "issue");
						return false;
					}
					//	pin_code
					if(form1.pincode.value != "" && form1.pincode.value.length != 4){
						ModalWarning_TextName(sText5, "pincode");
						return false;
					}	
					//	compareDate
					if(st_date > exp_date){
						ModalWarning_TextName(sText6, "ex_date");
						return false;
					}
					//	groupcode
					if(document.form1.group_code.value == ""){
						ModalWarning_TextName(sText10, "group_code");
						return false;
					}
					//	seccode
					if(document.form1.sec_code.value == ""){
						ModalWarning_TextName(sText7, "sec_code");
						return false;
					}
					//	poscode
					if(document.form1.pos_code.value == ""){
						ModalWarning_TextName(sText8, "pos_code");
						return false;
					}
					//	typecode
					if(document.form1.type_code.value == ""){
						ModalWarning_TextName(sText9, "type_code");
						return false;
					}
					if(act == 'add'){
						document.form1.action = "module/act_employee.jsp?action=add";
						document.getElementById("form1").submit();
					}
				}
			}
		
			function ConfirmEdit(act, sText, sText2, sText3, sText4, sText5, sText6, sText7, sText8, sText9, sText10, sText11, sQuestion){
				sQuestion = sQuestion + ' ?';
				var stdate = form1.st_date.value;
				var expdate = form1.ex_date.value;
				var hh1 = form1.hh1.value;
				var mm1 = form1.mm1.value;
				var hh2 = form1.hh2.value;
				var mm2 = form1.mm2.value;
				
				var st_date = stdate.substring(6, 10)+stdate.substring(3, 5)+stdate.substring(0, 2)+hh1+mm1;	
				var exp_date = expdate.substring(6, 10)+expdate.substring(3, 5)+expdate.substring(0, 2)+hh2+mm2;
				if(document.form1.idcard.value == ""){
					ModalWarning_TextName(sText2, "idcard");
					return false;
				}else{	
					//	sn_card
					if(form1.sn_card.value != "" && form1.sn_card.value.length != 8){
						if(form1.sn_card.value.length != 14){
							ModalWarning_TextName(sText3, "sn_card");
							return false;
						}
					}			
					//	issue
					if(document.form1.issue.value == ""){
						ModalWarning_TextName(sText4, "issue");
						return false;
					}
					if(form1.issue.value < 00 || form1.issue.value > 99){
						ModalWarning_TextName(sText11, "issue");
						return false;
					}
					//	pin_code
					if(form1.pincode.value != "" && form1.pincode.value.length != 4){
						ModalWarning_TextName(sText5, "pincode");
						return false;		
					}
					//	compareDate
					if(st_date > exp_date){
						ModalWarning_TextName(sText6, "ex_date");
						return false;
					}
					
					Confirm_Save(sText, sQuestion);
				}
			}
			
			function Confirm_Save(sText, sQuestion){
				document.getElementById("text_confirm").innerHTML = sText;
				document.getElementById("text_label").value = sQuestion;
				$('#myModalConfirm').modal('show');
			}
			
			function Confirm_Button(){
				$('#myModalConfirm').modal('hide');
				
				if(document.form1.group_code.value.length == "13") {
					setTimeout(function(){
						Confirm_Save(document.getElementById("text_label").value, '');
						document.getElementById('btn_save_ok1').style.display = 'none';
						document.getElementById('btn_save_ok2').style.display = '';
						document.getElementById('btn_save_cancel1').style.display = 'none';
						document.getElementById('btn_save_cancel2').style.display = '';
						
						document.getElementById("glyphicon_save").classList.remove("glyphicon-floppy-saved"); 
						document.getElementById("glyphicon_save").classList.add("glyphicon-edit"); 
					}, 550);
				} else {
					document.form1.action = "module/act_employee.jsp?action=edit";
					document.getElementById("form1").submit();
				}
			}
			
			function Confirm_Change(change_group){
				if(change_group == '1'){
					document.form1.action = "module/act_employee.jsp?action=edit2";
					document.getElementById("form1").submit();
				}else if(change_group == '0'){
					document.form1.action = "module/act_employee.jsp?action=edit";
					document.getElementById("form1").submit();
				}
			}
			
			function set_hhmm(currentObj, data_default){
				if(currentObj.value == ''){
					currentObj.value = data_default;
				}else{
					if(currentObj.value.length == '1'){
						currentObj.value = '0'+currentObj.value;
					}
				}
			}
		 	
			function change_class(field_name){
				if(field_name == 'idcard' || field_name == 'issue'){
					if(document.form1.idcard.value != ""){
						document.getElementById("textbox_idcard").className = "form-group has-success has-feedback";
						document.getElementById("icon_idcard").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_idcard").className = "form-group has-error has-feedback";
						document.getElementById("icon_idcard").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
					if(document.form1.issue.value != ""){
						document.getElementById("textbox_issue").className = "form-group has-success has-feedback";
						document.getElementById("icon_issue").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_issue").className = "form-group has-error has-feedback";
						document.getElementById("icon_issue").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}else if(field_name == 'sec_code' || field_name == 'pos_code' || field_name == 'type_code' || field_name == 'group_code'){
					document.getElementById("select_"+field_name).className = "input-group has-success has-feedback";
					document.getElementById("icon_"+field_name).className = "glyphicon glyphicon-ok form-control-feedback";
				}
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="ImgLoad(); Rotate();">
		
<% 
		String action = "";
		if(request.getParameter("action") != null){
			action = request.getParameter("action");
		}else{
			response.sendRedirect("data_employee.jsp");
		}
		session.setAttribute("act", action);
%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<!--	Use in page edit	-->
		<%@ include file="../tools/modal_danger.jsp"%>
		
		<%	if(!checkPermission(ses_per, "0135")){	%>
			
			<script> ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">
				
				<form id="form1" name="form1" method="post">
				
<% 		if(action.equals("add")){	
			
			//	Delete tmp photo
			new File(getServletContext().getRealPath("/") + "photos\\tmpCapture\\CaptureBy-"+username+".jpg").delete();
%>
				
				<div class="row">
				
					<div class="col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
								<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt" > </i> &nbsp; <b> ID Card & Grant Information </b> </label>
							</div>
						
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_emp_photo %> : </label>
								<div class="col-md-5">
									<img id="img_emp" class="img-rounded" width="24" height="24" style="cursor: default;"> &nbsp; 
									<span id="resize_full" class="glyphicon glyphicon-resize-full" style="cursor: pointer; cursor: hand; vertical-align: top; margin-top: 5px;" onClick="ShowFullImage();" data-toggle="tooltip" data-placement="right" title="Full size"> </span> 
									<span id="resize_small" class="glyphicon glyphicon-resize-small" style="cursor: pointer; cursor: hand; vertical-align: top; margin-top: 5px;" onClick="ShowSmallImage();" data-toggle="tooltip" data-placement="left" title="Small size"> </span>
								</div>
								<label class="control-label col-md-3" style="padding-right: 10px;">
									<i class="glyphicon glyphicon-camera" style="cursor: pointer; cursor: hand;" onClick="cameraCapture('add', '');"> </i> &nbsp; <span onClick="cameraCapture('add', '');"> <%= lb_take_photo %> </span>
								</label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_empcode %> : </label>
								<div class="col-md-5">
									<div class="form-group has-error has-feedback" id="textbox_idcard" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="idcard" name="idcard" maxlength="16" placeholder="<%= lb_empcode %>" onKeyPress="IsValidCharacters();" onKeyUp="change_class('idcard'); upperCase(this);" onBlur="change_class('idcard'); upperCase(this); ImgLoad();">
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_idcard" aria-hidden="true"> </span>
									</div>
								</div>
								<div class="col-md-3" style="margin-top: 6px;">
									<input name="use_finger" type="checkbox" id="use_finger" value="checkbox" checked style="margin-right: 10px;"> <%= lb_usebio %>
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_serial_card %> : </label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="sn_card" name="sn_card" maxlength="14" placeholder="Serial ( 8 <%= lb_or %> 14 <%=  lb_digit %> )" onKeyPress="IsValidHex()" style="text-transform: uppercase">
								</div>
								<div class="col-md-3" style="margin-top: 6px;">
									<input name="use_map_card" type="checkbox" id="use_map_card" style="margin-right: 10px;" onClick="chkSncard('<%= msg_notset_serail  %>', document.form1.sn_card)"> <%= lb_use_mapcard %> </label>
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_issue %> : </label>
								<div class="col-md-7">
									<div class="form-group has-error has-feedback" id="textbox_issue" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="issue" name="issue" maxlength="2" placeholder="<%= lb_issue %>" onKeyPress="IsValidNumber()" onKeyUp="change_class('issue');" onBlur="change_class('issue');">
										<span class="glyphicon glyphicon-star form-control-feedback" id="icon_issue" aria-hidden="true"> </span>
									</div>
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_pincode %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="pincode" name="pincode" maxlength="4" placeholder="<%= lb_pincode %>" onKeyPress="IsValidNumber()">
								</div>
							</div> 

							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_startdate %> : </label>
								<div class="col-md-8">
									<div class="col-xs-7 col-md-7" style="margin-left: -15px; margin-right: -15px;">
										<div class="input-group col-md-12">
											<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date" data-link-format="dd/mm/yyyy">
												<input class="form-control" type="text" value="<%= getCurrentDate() %>" readonly>
												<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
											</div>
											<input type="hidden" class="form-control" id="st_date" name="st_date" maxlength="10" value="<%= getCurrentDate() %>" placeholder="<%= lb_startdate %>" readonly="readonly" onChange="onChange_Date(form1.st_date.value, form1.ex_date.value);" style="background-color:#F0F0F0">
										</div>
									</div>
									<div class="col-xs-5 col-md-5">
										<div class="row form-inline">
											<div class="col-xs-4 col-md-4">
												<input type="text" class="form-control input-group" id="hh1" name="hh1" style="min-width: 55px; max-width: 55px;" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>');" onBlur="set_hhmm(this, '00'); return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0');" value="00">							 
											</div>
											<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 20px;"> : </label>
											<div class="col-xs-4 col-md-4" style="margin-left: -10px;">
												<input type="text" class="form-control input-group" id="mm1" name="mm1" style="min-width: 55px; max-width: 55px;"  maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh2, '<%= msg_input_minute %>');" onBlur="set_hhmm(this, '00'); return checkMinute(this, document.form1.hh2, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0');" value="00">
											</div>							
										</div>
									</div>
								</div> 
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_expiredate %> : </label>
								<div class="col-md-8">
									<div class="col-xs-7 col-md-7" style="margin-left: -15px; margin-right: -15px;">
										<div class="input-group col-md-12">
											<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="ex_date" data-link-format="dd/mm/yyyy">
												<input class="form-control" type="text" value="<%= getCurrentDateInc(100) %>" readonly>
												<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
											</div>
											<input type="hidden" class="form-control" id="ex_date" name="ex_date" maxlength="10" value="<%= getCurrentDateInc(100) %>" placeholder="<%= lb_startdate %>" readonly="readonly" style="background-color:#F0F0F0">
										</div>
									</div>
									<div class="col-xs-5 col-md-5">
										<div class="row form-inline">
											<div class="col-xs-4 col-md-4">
												<input type="text" class="form-control input-group" id="hh2" name="hh2" style="min-width: 55px; max-width: 55px;" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>');" onBlur="set_hhmm(this, '23'); return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0');" value="23">
											</div>
											<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 20px;"> : </label>
											<div class="col-xs-4 col-md-4" style="margin-left: -10px;">
												<input type="text" class="form-control input-group" id="mm2" name="mm2" style="min-width: 55px; max-width: 55px;" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh1, '<%= msg_input_minute %>');" onBlur="set_hhmm(this, '59'); return checkMinute(this, document.form1.hh1, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0');" value="59">
											</div>							
										</div>
									</div>
								</div> 
							</div> 
					
					<%	try{	%>
							
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_groupemp %> : </label>
								<div class="col-md-7">
									<div class="input-group has-error has-feedback" id="select_group_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="group_code" id="group_code" onChange="change_class('group_code');">
						<%				String sql_group = "SELECT distinct(group_code), ";
										if(lang.equals("th")){
											sql_group = sql_group + "th_desc AS group_desc ";
										}else{
											sql_group = sql_group + "en_desc AS group_desc ";
										}
										if(mode == 0){
											sql_group = sql_group + "FROM dbgroup WHERE (LENGTH(group_code) <= 6) " + where_group_user + " ORDER BY group_code ASC";
										}else{
											sql_group = sql_group + "FROM dbgroup WHERE (LEN(group_code) <= 6) " + where_group_user + " ORDER BY group_code ASC";
										}
										ResultSet rs_group = stmtUp.executeQuery(sql_group);
						%>
											<option name="group_code" value="" disabled selected> <%= lb_sel_group %> </option>
											<option name="group_code" value="99"> <%= lb_defineextra %> </option>
						<%				while(rs_group.next()){	%>
											<option name="group_code" value="<%= rs_group.getString("group_code") %>"> <%= rs_group.getString("group_code") %> - <%= rs_group.getString("group_desc") %> </option>
						<%  			}	rs_group.close();	%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_group_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_sect %> : </label>
								<div class="col-md-7">
									<div class="input-group has-error has-feedback" id="select_sec_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="sec_code" id="sec_code" onChange="change_class('sec_code');">
						<% 				String sql_section = "SELECT sec.sec_code, ";	
										if(lang.equals("th")){
											sql_section = sql_section + "sec.th_desc AS sec_desc ";
										}else{
											sql_section = sql_section + "sec.en_desc AS sec_desc ";
										}
										if(checkPermission(ses_per, "03")){
											sql_section = sql_section + "FROM dbsection sec ORDER BY sec.sec_code ";
										}else if(checkPermission(ses_per, "15")){
											sql_section = sql_section + "FROM dbsection sec LEFT JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) ";
											sql_section = sql_section + "LEFT JOIN dbusers u ON (u.dep_code = dep.dep_code) ";
											sql_section = sql_section + "WHERE (u.user_name = '"+ses_user+"') ";
											if(checkPermission(ses_per, "5")){
												sql_section = sql_section + "AND (sec.sec_code = u.sec_code) ";
											}
											sql_section = sql_section + "ORDER BY sec.sec_code ";
										}
										ResultSet rs_section = stmtUp.executeQuery(sql_section);
						%>
											<option name="sec_code" value="" disabled selected> <%= lb_sel_sec %> </option>
						<%				while(rs_section.next()){	%> 
											<option name="sec_code" value="<%= rs_section.getString("sec_code") %>"> <%= rs_section.getString("sec_code") %> - <%= rs_section.getString("sec_desc") %> </option>
						<%  			}	rs_section.close();		%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_sec_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
								</div>
							</div>
							
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_posemp %> : </label>
								<div class="col-md-7">
									<div class="input-group has-error has-feedback" id="select_pos_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="pos_code" id="pos_code" onChange="change_class('pos_code');">
						<%				String sql_position = "SELECT pos_code, ";		
										if(lang.equals("th")){
											sql_position = sql_position + "th_desc AS pos_desc ";
										}else{
											sql_position = sql_position + "en_desc AS pos_desc ";
										}
										sql_position = sql_position + "FROM dbposition ORDER BY pos_code";		
										ResultSet rs_position = stmtUp.executeQuery(sql_position);
						%>
											<option name="pos_code" value="" disabled selected> <%= lb_sel_pos %> </option>
						<%				while(rs_position.next()){	%>
											<option name="pos_code" value="<%= rs_position.getString("pos_code") %>"> <%= rs_position.getString("pos_code") %> - <%= rs_position.getString("pos_desc") %> </option>
						<%  			}	rs_position.close();	%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_pos_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
								</div>
							</div>
							
							<div class="row form-group" style="margin-bottom: 4px;">
								<label class="control-label label-text-1 col-md-4"> <%= lb_typeemployee %> : </label>
								<div class="col-md-7">
									<div class="input-group has-error has-feedback" id="select_type_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="type_code" id="type_code" onChange="change_class('type_code');">
						<%				String sql_type = "SELECT type_code, ";
										if(lang.equals("th")){
											sql_type = sql_type + "th_desc AS type_desc ";
										}else{
											sql_type = sql_type + "en_desc AS type_desc ";
										}
										sql_type = sql_type + "FROM dbtype ORDER BY type_code";	
										ResultSet rs_type = stmtUp.executeQuery(sql_type);
						%>
											<option name="type_code" value="" disabled selected> <%= lb_sel_type %> </option>
						<%				while(rs_type.next()){	%>
											<option name="type_code" value="<%= rs_type.getString("type_code") %>"> <%= rs_type.getString("type_code") %> - <%= rs_type.getString("type_desc") %> </option>
						<% 				 }	rs_type.close();	%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-star form-control-feedback" id="icon_type_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
								</div>
							</div> 
							
					<%	}catch(SQLException e){		
							out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
						}
					%>		
							
						</div> 
					</div> 
					
					<div class="col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
								<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-user" > </i> &nbsp; <b> Employee Information </b> </label>
							</div>

							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_empcard %> : </label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="emp_card" name="emp_card" maxlength="16" placeholder="<%= lb_empcard %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_sex %> : </label>
								<div class="col-md-5" style="margin-top: 2px;">
									<input type="radio" name="sex" id="sex" value="0" checked style="margin-right: 2px;"> <label class="control-label"> <%= lb_none %> </label> &nbsp;
								
									<input type="radio" name="sex" id="sex" value="1" style="margin-right: 2px;"> <label class="control-label"> <%= lb_male %> </label> &nbsp;
								
									<input type="radio" name="sex" id="sex" value="2" style="margin-right: 2px;"> <label class="control-label"> <%= lb_female %> </label>
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_prefix %> : </label>
								<div class="col-md-5">
									<select class="form-control selectpicker" name="prefix" id="prefix">
										<option value="0"> <%= lb_none %> </option>
										<option value="1"> <%= lb_mr %> </option>
										<option value="2"> <%= lb_mrs %> </option>
										<option value="3"> <%= lb_miss %> </option>
										<option value="4"> <%= lb_ms %> </option>
									</select>
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_thname %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="th_fname" name="th_fname" maxlength="30" placeholder="<%= lb_thname %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_thsname %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="th_sname" name="th_sname" maxlength="45" placeholder="<%= lb_thsname %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_enname %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="en_fname" name="en_fname" maxlength="30" placeholder="<%= lb_enname %>">
								</div>					
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_ensname %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="en_sname" name="en_sname" maxlength="45" placeholder="<%= lb_ensname %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_cardid %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="card_id" name="card_id" maxlength="17" placeholder="<%= lb_cardid %> ( x-xxxx-xxxxx-xx-x )" onKeyPress="IsValidNumberAndDash()" onBlur="return checkPublicID(this, '<%=lang%>')">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_nationality %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="nationality" name="nationality" maxlength="20" placeholder="<%= lb_nationality %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_phoneno %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="phone_no" name="phone_no" maxlength="15" placeholder="<%= lb_phoneno %> ( xxx-xxx-xxxx )" onKeyPress="IsValidNumberAndDash()" onBlur="return checkPhoneNumber(this, '<%=lang%>')">
								</div>
							</div>
							<div class="row form-group" style="margin-bottom: 2px;">
								<label class="control-label label-text-1 col-md-4"> <%= lb_email %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="email" name="email" maxlength="50" placeholder="<%= lb_email %>" onBlur="return checkEmail(this, '<%=lang%>')">
								</div>
							</div> 
						</div> 
					</div> 
				
				</div>
			
				<div class="row" style="border: 0px !important; margin-top: -15px; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
						<center>
							<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="ConfirmAdd('add', '<%=msg_confirmedit %>', '<%= msg_notinput_emp %>', '<%= msg_chk_mapcard %>', '<%= msg_chk_issue %>', '<%= msg_chk_pincode %>', '<%= msg_mistake_datetime %>', '<%= msg_chksel_sec %>', '<%= msg_chksel_pos %>', '<%= msg_chksel_type %>', '<%= msg_chksel_group %>', '<%= msg_chk_inputissue%>');"> &nbsp; 
							<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_employee.jsp'">
							<input name="date_data" type="hidden" id="date_data" value="<%= getCurrentDateTimeShow() %>">
						</center>
					</div>
				</div>
				
<%		}else if(action.equals("edit")){
			
			String idcard = request.getParameter("idcard"); 
			
			boolean blacklisted = false;
			ResultSet rs_bl = stmtQry.executeQuery(" SELECT COUNT(bl.idcard) AS c_idcard FROM dbblacklist bl WHERE bl.idcard = '"+idcard+"' AND bl.cancel_status = '0' ");
			if(rs_bl.next()){
				if(rs_bl.getInt("c_idcard") > 0){
					blacklisted = true;
					out.println("<script> setTimeout(function(){ ModalDanger_NoTimeout('"+lb_emp_blacklist+", "+lb_cannot_editemployee+"'); }, 500); </script>");
				}
			}	rs_bl.close();
			
			if(!blacklisted){
				String sql = "";
				if(mode == 0){
					sql = "SELECT *, DATE_FORMAT(st_date,'%d/%m/%Y') AS st_date1, "
							+ "DATE_FORMAT(ex_date,'%d/%m/%Y') AS ex_date1 ";					
				}else if(mode == 1){
					sql = "SELECT *, CONVERT(varchar(10),st_date,103) AS st_date1, "
							+ "CONVERT(varchar(10),ex_date,103) AS ex_date1 ";					
				}
				sql += "FROM dbemployee WHERE (idcard = '"+idcard+"') "; 
				try{
					ResultSet rs = stmtQry.executeQuery(sql);
					while(rs.next()){
						String stdate = rs.getString("st_date1");
						String exdate = rs.getString("ex_date1");
						String seccode_emp = rs.getString("sec_code");
						String poscode_emp = rs.getString("pos_code");
						String typecode_emp = rs.getString("type_code");
						String groupcode_emp = rs.getString("group_code");
						String use_finger = rs.getString("use_finger");
						String sex = rs.getString("sex");
						String sttime = rs.getString("st_time");
						String extime = rs.getString("ex_time");
						String usemapcard = rs.getString("use_map_card");
						String mapcard = rs.getString("sn_card");
						String phoneno = rs.getString("phone_no");
						String email = rs.getString("email");
						String nationality = rs.getString("nationality");
						String card_id = rs.getString("card_id");
						String emp_card = rs.getString("emp_card");
						
						if(!(phoneno.equals("") || phoneno.equals("null"))){
							phoneno = displayFormatPhone(phoneno);
						}
						if(!(card_id.equals("") || card_id.equals("null"))){
							card_id = displayFormatPublicId(card_id);
						}					
%>				
				<div class="row">
				
					<div class="col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
								<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt" > </i> &nbsp; <b> ID Card & Grant Information </b> </label>
							</div>
						
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_emp_photo %> : </label>
								<div class="col-md-5">
									<img id="img_emp" class="img-rounded" width="24" height="24" style="cursor: default;"> &nbsp; 
									<span id="resize_full" class="glyphicon glyphicon-resize-full" style="cursor: pointer; cursor: hand; vertical-align: top; margin-top: 5px;" onClick="ShowFullImage();" data-toggle="tooltip" data-placement="right" title="Full size"> </span> 
									<span id="resize_small" class="glyphicon glyphicon-resize-small" style="cursor: pointer; cursor: hand; vertical-align: top; margin-top: 5px;" onClick="ShowSmallImage();" data-toggle="tooltip" data-placement="left" title="Small size"> </span>
								</div>
								<label class="control-label col-md-3" style="padding-right: 10px;">
									<i class="glyphicon glyphicon-camera" style="cursor: pointer; cursor: hand;" onClick="cameraCapture('edit', '<%= idcard %>');"> </i> &nbsp; <span onClick="cameraCapture('edit', '<%= idcard %>');"> <%= lb_take_photo %> </span>
								</label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_empcode %> : </label>
								<div class="col-md-5">
									<div class="form-group has-success has-feedback" id="textbox_idcard" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="idcard" name="idcard" value="<%= idcard %>" maxlength="16" placeholder="<%= idcard %>" onKeyPress="IsValidCharacters();" onKeyUp="change_class('idcard'); upperCase(this);" onBlur="change_class('idcard'); upperCase(this);">
										<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_idcard" aria-hidden="true"> </span>
										<input type="hidden" name="idcard2" id="idcard2" value="<%= idcard %>">
									</div>
								</div>
								<div class="col-md-3" style="margin-top: 6px;">
									<input name="use_finger" type="checkbox" id="use_finger" value="checkbox" <%= checkBoxAtPos(use_finger, 0) %> style="margin-right: 10px;"> <%= lb_usebio %>
									<input type="hidden" name="use_fingerold" value="<%= use_finger %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_serial_card %> : </label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="sn_card" name="sn_card" value="<%= mapcard %>" maxlength="14" placeholder="<%= lb_serial_card %> ( 8 <%= lb_or %> 14 <%=  lb_digit %> )" onKeyPress="IsValidHex()" style="text-transform: uppercase">
									<input name="txserailcard" type="hidden" id="txserailcard" value="<%= mapcard %>">
								</div>
								<div class="col-md-3" style="margin-top: 6px;">
									<input name="use_map_card" type="checkbox" id="use_map_card" style="margin-right: 10px;" <%= checkBoxAtPos(usemapcard, 0) %> onClick="chkSncard('<%= msg_notset_serail  %>', document.form1.sn_card)"> <%= lb_use_mapcard %>
									<input name="txmapcard" type="hidden" id="txmapcard" value="<%= usemapcard %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_issue %> : </label>
								<div class="col-md-7">
									<div class="form-group has-success has-feedback" id="textbox_issue" style="margin-bottom: 0px">
										<input type="text" class="form-control" id="issue" name="issue" value="<%= rs.getString("issue") %>" maxlength="2" placeholder="<%= rs.getString("issue") %>" onKeyPress="IsValidNumber()" onKeyUp="change_class('issue');" onBlur="change_class('issue');">
										<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_issue" aria-hidden="true"> </span>
										<input type="hidden" name="txissue" id="txissue" value="<%= rs.getString("issue") %>">
									</div>
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_pincode %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="pincode" name="pincode" value="<%= rs.getString("pincode") %>" maxlength="4" placeholder="<%= lb_pincode %>" onKeyPress="IsValidNumber()">
									<input type="hidden" name="txpin_code" id="txpin_code" value="<%= rs.getString("pincode") %>">
								</div>
							</div>
							
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_startdate %> : </label>
								<div class="col-md-8">
									<div class="col-xs-7 col-md-7" style="margin-left: -15px; margin-right: -15px;">
										<div class="input-group col-md-12">
											<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date" data-link-format="dd/mm/yyyy">
												<input class="form-control" type="text" value="<%= stdate %>" readonly>
												<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
											</div>
											<input type="hidden" class="form-control" id="st_date" name="st_date" value="<%= stdate %>" maxlength="10" placeholder="<%= lb_startdate %>" readonly="readonly" onChange="onChange_Date(form1.st_date.value, form1.ex_date.value);" style="background-color:#F0F0F0">
										</div>
									</div>
									<div class="col-xs-5 col-md-5">
										<div class="row form-inline">
											<div class="col-xs-4 col-md-4">
												<input type="text" class="form-control input-group" id="hh1" name="hh1" value="<%= sttime.substring(0, 2) %>" style="min-width: 55px; max-width: 55px;" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>');" onBlur="set_hhmm(this, '00'); return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0');">							 
											</div>
											<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 20px;"> : </label>
											<div class="col-xs-4 col-md-4" style="margin-left: -10px;">
												<input type="text" class="form-control input-group" id="mm1" name="mm1" value="<%= sttime.substring(3, 5) %>" style="min-width: 55px; max-width: 55px;" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh2, '<%= msg_input_minute %>');" onBlur="set_hhmm(this, '00'); return checkMinute(this, document.form1.hh2, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0');">
												
												<input type="hidden" name="txst_date" id="txst_date" value="<%= stdate %>">
												<input type="hidden" name="txst_hh1" id="txst_hh1" value="<%= sttime.substring(0, 2) %>">
												<input type="hidden" name="txst_mm1" id="txst_mm1" value="<%= sttime.substring(3, 5) %>">
											</div>
										</div>
									</div>
								</div> 
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_expiredate %> : </label>
								<div class="col-md-8">
									<div class="col-xs-7 col-md-7" style="margin-left: -15px; margin-right: -15px;">
										<div class="input-group col-md-12">
											<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="ex_date" data-link-format="dd/mm/yyyy">
												<input class="form-control" type="text" value="<%= exdate %>" readonly>
												<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
											</div>
											<input type="hidden" class="form-control" id="ex_date" name="ex_date" value="<%= exdate %>" maxlength="10" placeholder="<%= lb_startdate %>" readonly="readonly" style="background-color:#F0F0F0">
										</div>
									</div>
									<div class="col-xs-5 col-md-5">
										<div class="row form-inline">
											<div class="col-xs-4 col-md-4">
												<input type="text" class="form-control input-group" id="hh2" name="hh2" value="<%= extime.substring(0, 2) %>" style="min-width: 55px; max-width: 55px;" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>');" onBlur="set_hhmm(this, '23'); return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0');">
											</div>
											<label class="control-label col-xs-1 col-md-1 label-text-1" style="margin-left: 20px;"> : </label>
											<div class="col-xs-4 col-md-4" style="margin-left: -10px;">
												<input type="text" class="form-control input-group" id="mm2" name="mm2" value="<%= extime.substring(3, 5) %>" style="min-width: 55px; max-width: 55px;" maxlength="2" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh1, '<%= msg_input_minute %>');" onBlur="set_hhmm(this, '59'); return checkMinute(this, document.form1.hh1, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0');">

												<input type="hidden" name="txex_date" id="txex_date" value="<%= exdate %>">
												<input type="hidden" name="txst_hh2" id="txst_hh2" value="<%= extime.substring(0, 2) %>">
												<input type="hidden" name="txst_mm2" id="txst_mm2" value="<%= extime.substring(3, 5) %>">
											</div>	
										</div>
									</div>
								</div> 
							</div>
							
					<%	try{	%>	
							
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_groupemp %> : </label>
								<div class="col-md-7">
									<div class="input-group has-success has-feedback" id="select_group_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="group_code" id="group_code" onChange="change_class('group_code');">
						<%				String groupcode = "";
										String sql_group = "SELECT distinct(group_code), ";
										if(lang.equals("th")){
											sql_group = sql_group + "th_desc AS group_desc ";
										}else{
											sql_group = sql_group + "en_desc AS group_desc ";
										}
										sql_group = sql_group + "FROM dbgroup WHERE (group_code = '"+groupcode_emp+"') OR ( (group_code != 'groupblacklist') " + where_group_user + " ) ORDER BY group_code ASC ";
										ResultSet rs_group = stmtUp.executeQuery(sql_group);
						%>
											<option name="group_code" value="99"> <% if(lang.equals("th")){ out.println("กำหนดใหม่"); }else{ out.println("Define new"); } %> </option>
						<%				while(rs_group.next()){
											groupcode = rs_group.getString("group_code");
											if(groupcode.length() == 13)
												if(!groupcode.equals(groupcode_emp))
													continue;
						%>
											<option name="group_code" value="<%= rs_group.getString("group_code") %>" <%= checkDataSelected(rs_group.getString("group_code"), groupcode_emp) %>> <%= rs_group.getString("group_code") %> - <%= rs_group.getString("group_desc") %> </option>
						<%  			}	rs_group.close();	%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;"> 
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_group_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
									<input type="hidden" name="txgroup_code" id="txgroup_code" value="<%= groupcode_emp %>">
								</div>
							</div> 	
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_sect %> : </label>
								<div class="col-md-7">
									<div class="input-group has-success has-feedback" id="select_sec_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="sec_code" id="sec_code" onChange="change_class('sec_code');">
						<% 				String sql_section = "SELECT sec.sec_code, ";	
										if(lang.equals("th")){
											sql_section = sql_section + "sec.th_desc AS sec_desc ";
										}else{
											sql_section = sql_section + "sec.en_desc AS sec_desc ";
										}
										if(checkPermission(ses_per, "03")){
											sql_section = sql_section + "FROM dbsection sec ORDER BY sec.sec_code ";
										}else if(checkPermission(ses_per, "15")){
											sql_section = sql_section + "FROM dbsection sec LEFT JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) ";
											sql_section = sql_section + "LEFT JOIN dbusers u ON (u.dep_code = dep.dep_code) ";
											sql_section = sql_section + "WHERE (u.user_name = '"+ses_user+"') ";
											if(checkPermission(ses_per, "5")){
												sql_section = sql_section + "AND (sec.sec_code = u.sec_code) ";
											}
											sql_section = sql_section + "ORDER BY sec.sec_code ";
										}
										ResultSet rs_section = stmtUp.executeQuery(sql_section);
										while(rs_section.next()){	
						%> 
											<option name="sec_code" value="<%= rs_section.getString("sec_code") %>" <%= checkDataSelected(rs_section.getString("sec_code"), seccode_emp) %>> <%= rs_section.getString("sec_code") %> - <%= rs_section.getString("sec_desc") %> </option>
						<%  			}	rs_section.close();		%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_sec_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
									<input type="hidden" name="sec_code2" id="sec_code2">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_posemp %> : </label>
								<div class="col-md-7">
									<div class="input-group has-success has-feedback" id="select_pos_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="pos_code" id="pos_code" onChange="change_class('pos_code');">
						<%				String sql_position = "SELECT pos_code, ";		
										if(lang.equals("th")){
											sql_position = sql_position + "th_desc AS pos_desc ";
										}else{
											sql_position = sql_position + "en_desc AS pos_desc ";
										}
										sql_position = sql_position + "FROM dbposition ORDER BY pos_code";		
										ResultSet rs_position = stmtUp.executeQuery(sql_position);
										while(rs_position.next()){	
						%>
											<option name="pos_code" value="<%= rs_position.getString("pos_code") %>" <%= checkDataSelected(rs_position.getString("pos_code"), poscode_emp) %>> <%= rs_position.getString("pos_code") %> - <%= rs_position.getString("pos_desc") %> </option>
						<%  			}	rs_position.close();	%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_pos_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
									<input type="hidden" name="pos_code2" id="pos_code2">
								</div>
							</div> 
							<div class="row form-group" style="margin-bottom: 4px;">
								<label class="control-label label-text-1 col-md-4"> <%= lb_typeemployee %> : </label>
								<div class="col-md-7">
									<div class="input-group has-success has-feedback" id="select_type_code">
										<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="type_code" id="type_code" onChange="change_class('type_code');">
						<%				String sql_type = "SELECT type_code, ";
										if(lang.equals("th")){
											sql_type = sql_type + "th_desc AS type_desc ";
										}else{
											sql_type = sql_type + "en_desc AS type_desc ";
										}
										sql_type = sql_type + "FROM dbtype ORDER BY type_code";	
										ResultSet rs_type = stmtUp.executeQuery(sql_type);
										while(rs_type.next()){	
						%>
											<option name="type_code" value="<%= rs_type.getString("type_code") %>" <%= checkDataSelected(rs_type.getString("type_code"), typecode_emp) %>> <%= rs_type.getString("type_code") %> - <%= rs_type.getString("type_desc") %> </option>
						<% 				 }	rs_type.close();	%>
										</select>
										<span class="input-group-addon" style="background-color: #ffffff;">
											<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_type_code" aria-hidden="true"> </span> &nbsp; &nbsp;
										</span>
									</div>
									<input type="hidden" name="type_code2" id="type_code2">
								</div>
							</div> 
							
					<%	
						}catch(SQLException e){		
							out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
						}
					%>
						</div>
					</div>
					
					<div class="col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
						<div class="bs-callout bs-callout-info"> 
							<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
								<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-user" > </i> &nbsp; <b> Employee Information </b> </label>
							</div>
							
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_empcard %> : </label>
								<div class="col-md-5">
									<input type="text" class="form-control" id="emp_card" name="emp_card" value="<%= emp_card %>" maxlength="16" placeholder="<%= lb_empcard %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_sex %> : </label>
								<div class="col-md-5" style="margin-top: 2px;">
									<input type="radio" name="sex" id="sex" value="0" <% if(sex.equals("0")){ out.println("checked"); } %> style="margin-right: 2px;"> <label class="control-label"> <%= lb_none %> </label> &nbsp;
								
									<input type="radio" name="sex" id="sex" value="1" <% if(sex.equals("1")){ out.println("checked"); } %> style="margin-right: 2px;"> <label class="control-label"> <%= lb_male %> </label> &nbsp;
								
									<input type="radio" name="sex" id="sex" value="2" <% if(sex.equals("2")){ out.println("checked"); } %> style="margin-right: 2px;"> <label class="control-label"> <%= lb_female %> </label>
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_prefix %> : </label>
								<div class="col-md-5">
									<select class="form-control selectpicker" name="prefix" id="prefix">
										<option value="0"> <%= lb_none %> </option>
										<option value="1" <%= checkDataSelected(rs.getString("prefix"), "1") %>> <%= lb_mr %> </option>
										<option value="2" <%= checkDataSelected(rs.getString("prefix"), "2") %>> <%= lb_mrs %> </option>
										<option value="3" <%= checkDataSelected(rs.getString("prefix"), "3") %>> <%= lb_miss %> </option>
										<option value="4" <%= checkDataSelected(rs.getString("prefix"), "4") %>> <%= lb_ms %> </option>
									</select>
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_thname %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="th_fname" name="th_fname" value="<%= rs.getString("th_fname") %>" maxlength="30" placeholder="<%= lb_thname %>">
									<input name="txtthfname" type="hidden" value="<%= rs.getString("th_fname") %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_thsname %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="th_sname" name="th_sname" value="<%= rs.getString("th_sname") %>" maxlength="45" placeholder="<%= lb_thsname %>">
									<input name="txtthsname" type="hidden" value="<%= rs.getString("th_sname") %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_enname %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="en_fname" name="en_fname" value="<%= rs.getString("en_fname") %>" maxlength="30" placeholder="<%= lb_enname %>">
									<input name="txtenfname" type="hidden" value="<%= rs.getString("en_fname") %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_ensname %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="en_sname" name="en_sname" value="<%= rs.getString("en_sname") %>" maxlength="45" placeholder="<%= lb_ensname %>">
									<input name="txtensname" type="hidden" value="<%= rs.getString("en_sname") %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_cardid %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="card_id" name="card_id" value="<%= card_id %>" maxlength="17" placeholder="<%= lb_cardid %> ( x-xxxx-xxxxx-xx-x )" onKeyPress="IsValidNumberAndDash()" onBlur="return checkPublicID(this, '<%=lang%>')">
									<input name="txtcardid" type="hidden" value="<%= card_id %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_nationality %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="nationality" name="nationality" value="<%= nationality %>" maxlength="20" placeholder="<%= lb_nationality %>">
								</div>
							</div> 
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-4"> <%= lb_phoneno %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="phone_no" name="phone_no" value="<%= phoneno %>" maxlength="15" placeholder="<%= lb_phoneno %> ( xxx-xxx-xxxx )" onKeyPress="IsValidNumberAndDash()" onBlur="return checkPhoneNumber(this, '<%=lang%>')">
								</div>
							</div> 
							<div class="row form-group" style="margin-bottom: 2px;">
								<label class="control-label label-text-1 col-md-4"> <%= lb_email %> : </label>
								<div class="col-md-7">
									<input type="text" class="form-control" id="email" name="email" value="<%= email %>" maxlength="50" placeholder="<%= lb_email %>" onBlur="return checkEmail(this, '<%=lang%>')">
								</div>
							</div> 
						
						</div>
					</div>
					
				</div>
				
				<div class="row" style="border: 0px !important; margin-top: -15px; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
						<center>
							<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return ConfirmEdit('edit', '<%=msg_confirmedit %>', '<%= msg_notinput_emp %>', '<%= msg_chk_mapcard %>', '<%= msg_chk_issue %>', '<%= msg_chk_pincode %>', '<%= msg_mistake_datetime %>', '<%= msg_chksel_sec %>', '<%= msg_chksel_pos %>', '<%= msg_chksel_type %>', '<%= msg_chksel_group %>', '<%= msg_chk_inputissue %>', '<%= lb_strquestion %>');"> &nbsp; 
							<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_employee.jsp'">
							<input type="hidden" name="action2" id="action2" value="edit" >
							<input type="hidden" name="date_data" id="date_data" size="20" maxlength="80" value="<%= getCurrentDateTimeShow() %>">
						</center>
					</div>
				</div>

<%	
					}	
					rs.close();
				}catch(SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
				}
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
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_save" class="glyphicon glyphicon-floppy-saved alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_save_ok1" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_save_ok2" onClick="Confirm_Change('1');" style="width: 100%; display: none;"> <%= lb_update %> </button>
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_save_cancel1" onClick="javascript: history.back();" style="width: 100%;"> <%= btn_cancel %> </button>
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_save_cancel2" onClick="Confirm_Change('0');" style="width: 100%; display: none;"> <%= lb_no_update %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> 
									<input type="hidden" id="text_label" name="text_label" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalCapture" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" onClick="set_blank();">&times;</button>
						<h4 class="modal-title"> <%= lb_take_photo %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="" id="camera_capture" name="camera_capture" frameborder="0" height="430px" style="min-width: 850px;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal" onClick="set_blank();"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>
		
		<%	}	%>
		
		<script language="javascript">
			function cameraCapture(action, idcard){
				camera_capture.location = 'camera_capture.jsp?action='+action+'&idcard='+idcard;
				$('#myModalCapture').modal('show');
			}
			
			function set_blank(action, idcard){
				camera_capture.location = 'about:blank';
			}
			
			function upperCase(obj){
				obj.value = obj.value.toLocaleUpperCase();
			}
			
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