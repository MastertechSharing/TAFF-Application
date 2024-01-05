<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<%	
	session.setAttribute("page_g", "setting");
	session.setAttribute("subpage", "config");
	session.setAttribute("subtitle", "configcorp");
	session.setAttribute("action", "edit_configcorp.jsp?");
	session.setAttribute("act", "edit");
	
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
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

		<script>
			document.onkeydown = searchKeyPress;
			
			function ConfirmEditConfigCop(sText,alert_mas1,alert_mas2,alert_mas3,alert_mas4,alert_mas5,alert_mas6,alert_mas7,alert_mas8,alert_mas9,alert_mas10){
				//	master1-2
				if(document.form1.master_card1.value != '' && document.form1.master_card2.value != ''){
					if(form1.master_card1.value == form1.master_card2.value){
						ModalWarning_TextName(alert_mas1, "master_card2");
						return false;
					}
				}
				//	master1-3
				if(document.form1.master_card1.value != '' && document.form1.master_card3.value != ''){
					if(form1.master_card1.value == form1.master_card3.value){
						ModalWarning_TextName(alert_mas2, "master_card3");
						return false;
					}
				}
				//	master1-4
				if(document.form1.master_card1.value != '' && document.form1.master_card4.value != ''){
					if(form1.master_card1.value == form1.master_card4.value){
						ModalWarning_TextName(alert_mas3, "master_card4");
						return false;
					}
				}
				//	master1-5
				if(document.form1.master_card1.value != '' && document.form1.master_card5.value != ''){
					if(form1.master_card1.value == form1.master_card5.value){
						ModalWarning_TextName(alert_mas4, "master_card5");
						return false;
					}
				}
				//	master2-3
				if(document.form1.master_card2.value != '' && document.form1.master_card3.value != ''){
					if(form1.master_card2.value == form1.master_card3.value){
						ModalWarning_TextName(alert_mas5, "master_card3");
						return false;
					}
				}
				//	master2-4
				if(document.form1.master_card2.value != '' && document.form1.master_card4.value != ''){
					if(form1.master_card2.value == form1.master_card4.value){
						ModalWarning_TextName(alert_mas6, "master_card4");
						return false;
					}
				}
				//	master2-5
				if(document.form1.master_card2.value != '' && document.form1.master_card5.value != ''){
					if(form1.master_card2.value == form1.master_card5.value){
						ModalWarning_TextName(alert_mas7, "master_card5");
						return false;
					}
				}
				//	master3-4
				if(document.form1.master_card3.value != '' && document.form1.master_card4.value != ''){
					if(form1.master_card3.value == form1.master_card4.value){
						ModalWarning_TextName(alert_mas8, "master_card4");
						return false;
					}
				}
				//	master3-5
				if(document.form1.master_card3.value != '' && document.form1.master_card5.value != ''){
					if(form1.master_card3.value == form1.master_card5.value){
						ModalWarning_TextName(alert_mas9, "master_card5");
						return false;
					}
				}
				//	master4-5
				if(document.form1.master_card4.value != '' && document.form1.master_card5.value != ''){
					if(form1.master_card4.value == form1.master_card5.value){
						ModalWarning_TextName(alert_mas10, "");
						return false;
					}
				}
				
				ModalConfirm(sText, "module/act_configcorp.jsp?action=edit");
				
			}

			var currentselect;
			function swap_tr(tr){
				currentselect = tr;
				document.getElementById("pattern").innerHTML = tr.substring(7);
				$('#myModalCardPattern').modal('show');
			}

			function checkdata(lang){    
				var a = document.getElementById('radio1');
				var n = document.getElementById('radio2');
				var b = document.getElementById('radio3');
				var al = document.getElementById('radio4');
				var f = document.getElementById('radio5');
				var num = document.getElementById('radio6');
				
				if(a.checked){
					document.getElementById(currentselect).value = "a";
				}else if(n.checked){
					document.getElementById(currentselect).value = "n";
				}else if(b.checked){
					document.getElementById(currentselect).value = "";
				}else if(al.checked){
					document.getElementById(currentselect).value = "?";
				}else if(num.checked){
					document.getElementById(currentselect).value = "0";
				}else if(f.checked){
					var data = document.getElementById('text_f').value;
					if(data.length != '0'){
						document.getElementById(currentselect).value = data;
						$('#myModalCardPattern').modal('hide');
					}else{
						document.getElementById('text_f').focus();
					}
				}
				$('#myModalCardPattern').modal('hide');
			}
			
			function close_modal(lang){
				var text_warning = "";
				var f = document.getElementById('radio5');
				var data = document.getElementById('text_f').value;
				if(f.checked){
					if(data.length != '0'){
						document.getElementById(currentselect).value = data;
						$('#myModalCardPattern').modal('hide');
					}else{
						if(lang == 'th'){
							text_warning = "กรุณาใส่ตัวอักษรหรือตัวเลข";
						}else{
							text_warning = "Please fill charecter or number.";
						}
					//	ModalWarning_TextName(text_warning, "text_f");
					}
				}
			}

			function onloadKeyCode(element){
				if(form1.block_id.value == -1){		
					document.getElementById('key_card2').readOnly = true;		
				}else{
					document.getElementById('key_card2').readOnly = false;		
				}
			}

			function checkLength(current,sText){		
				if(form1.block_id.value >= 0 && form1.block_id.value <= 63 ){
					if(current.vlaue != ""){
						if(current.value.length < 12){
							ModalWarning_ObjectName(sText, current);
							return false;
						}else{
							return true;
						}
					}else{
						ModalWarning_ObjectName(sText, current);
					//	return false;
					}
				}else{
					document.form1.submit();
				}
			}

			function changeKey(){
				var blockId = form1.block_id.value;
				 if(blockId == -1){		
					document.getElementById('key_card2').readOnly = true;												
				 }else if(blockId >= 0 && blockId <= 63){
					document.getElementById('key_card2').readOnly = false;	
					
				 }
			}
		</script>
		
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="onloadKeyCode(document.form1.key_code2);">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<div class="body-display">
			<div class="container">
			  
				<form id="form1" name="form1" method="post" onSubmit="return checkLength(document.form1.key_card2, '<%= lb_inputkey %>');">
		<%		
			String cardPattern = "", displayDigit = "", saveDigit = "", duplicate_time = "", start_digit = "", issue_digit = "";
			String master_card1 = "", master_card2 = "", master_card3 = "", master_card4 = "", master_card5 = "";
			String customer_code = "", key_card2 = "", block_id = "";
			String loop = "";
			String modulef = "";
			try{
				ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbconfigcorp");
				while(rs.next()){ 
					cardPattern = rs.getString("card_pattern");
					displayDigit = rs.getString("display_digit");
					saveDigit = rs.getString("save_digit");
					duplicate_time = rs.getString("duplicate_time");
					start_digit = rs.getString("start_digit");
					issue_digit = rs.getString("issue_digit");	
					master_card1 = rs.getString("master_card1");
					master_card2 = rs.getString("master_card2");
					master_card3 = rs.getString("master_card3");
					master_card4 = rs.getString("master_card4");
					master_card5 = rs.getString("master_card5");
					customer_code = rs.getString("customer_code");
					key_card2 = rs.getString("key_card2");
					block_id = rs.getString("block_id");
					modulef = rs.getString("modulef");
		
		%>
		
				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info"> 
						<div class="row form-group alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
							<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt"> </i> &nbsp; <%= lb_configcorp %> </label>
						</div>
						<div class="row form-group" style="margin-bottom: -20px;">
							<div class="control-label label-text-1 col-md-12"> 
								
								<div class="table-responsive" style="border: 0px !important;" border="0">									
									<div style="min-width: 1000px;" border="0">	
									
										<table width="100%" class="table" border="0">
											<tr>
												<td width="20%"> </td>
												<td width="5%" align="center"> 1 </td>
												<td width="5%" align="center"> 2 </td>
												<td width="5%" align="center"> 3 </td>
												<td width="5%" align="center"> 4 </td>
												<td width="5%" align="center"> 5 </td>
												<td width="5%" align="center"> 6 </td>
												<td width="5%" align="center"> 7 </td>
												<td width="5%" align="center"> 8 </td>
												<td width="5%" align="center"> 9 </td>
												<td width="5%" align="center"> 10 </td>
												<td width="5%" align="center"> 11 </td>
												<td width="5%" align="center"> 12 </td>
												<td width="5%" align="center"> 13 </td>
												<td width="5%" align="center"> 14 </td>
												<td width="5%" align="center"> 15 </td>
												<td width="5%" align="center"> 16 </td>
											</tr>
											<tr>
												<td> <label class="control-label"> <%= lb_cardpattern %> </label> <input type="hidden" name="oldpattern" value="<%= cardPattern %>"> </td>
												<td align="center"> <input type="text" class="form-control" id="pattern1" name="pattern1" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 0) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern2" name="pattern2" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 1) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern3" name="pattern3" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 2) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern4" name="pattern4" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 3) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern5" name="pattern5" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 4) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern6" name="pattern6" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 5) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern7" name="pattern7" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 6) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern8" name="pattern8" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 7) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern9" name="pattern9" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 8) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern10" name="pattern10" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 9) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern11" name="pattern11" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 10) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern12" name="pattern12" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 11) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern13" name="pattern13" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 12) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern14" name="pattern14" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 13) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern15" name="pattern15" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 14) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
												<td align="center"> <input type="text" class="form-control" id="pattern16" name="pattern16" style="width: 35px; max-height: 24px;" value="<%= subStringCharAt(cardPattern, 15) %>" maxlength="1" onClick="swap_tr(this.id)" readonly="readonly"></td>
											</tr>
											<tr>
												<td> <label class="control-label"> <%= lb_disdigit %> </label> <input type="hidden" name="olddisplaydigit" value="<%=displayDigit%>"> </td>
												<td align="center"> <input type="checkbox" id="dis1" name="dis1" value="1" <%= checkBoxAtPosY(displayDigit, 0) %>> </td>
												<td align="center"> <input type="checkbox" id="dis2" name="dis2" value="1" <%= checkBoxAtPosY(displayDigit, 1) %>> </td>
												<td align="center"> <input type="checkbox" id="dis3" name="dis3" value="1" <%= checkBoxAtPosY(displayDigit, 2) %>> </td>
												<td align="center"> <input type="checkbox" id="dis4" name="dis4" value="1" <%= checkBoxAtPosY(displayDigit, 3) %>> </td>
												<td align="center"> <input type="checkbox" id="dis5" name="dis5" value="1" <%= checkBoxAtPosY(displayDigit, 4) %>> </td>
												<td align="center"> <input type="checkbox" id="dis6" name="dis6" value="1" <%= checkBoxAtPosY(displayDigit, 5) %>> </td>
												<td align="center"> <input type="checkbox" id="dis7" name="dis7" value="1" <%= checkBoxAtPosY(displayDigit, 6) %>> </td>
												<td align="center"> <input type="checkbox" id="dis8" name="dis8" value="1" <%= checkBoxAtPosY(displayDigit, 7) %>> </td>
												<td align="center"> <input type="checkbox" id="dis9" name="dis9" value="1" <%= checkBoxAtPosY(displayDigit, 8) %>> </td>
												<td align="center"> <input type="checkbox" id="dis10" name="dis10" value="1" <%= checkBoxAtPosY(displayDigit, 9) %>> </td>
												<td align="center"> <input type="checkbox" id="dis11" name="dis11" value="1" <%= checkBoxAtPosY(displayDigit, 10) %>> </td>
												<td align="center"> <input type="checkbox" id="dis12" name="dis12" value="1" <%= checkBoxAtPosY(displayDigit, 11) %>> </td>
												<td align="center"> <input type="checkbox" id="dis13" name="dis13" value="1" <%= checkBoxAtPosY(displayDigit, 12) %>> </td>
												<td align="center"> <input type="checkbox" id="dis14" name="dis14" value="1" <%= checkBoxAtPosY(displayDigit, 13) %>> </td>
												<td align="center"> <input type="checkbox" id="dis15" name="dis15" value="1" <%= checkBoxAtPosY(displayDigit, 14) %>> </td>
												<td align="center"> <input type="checkbox" id="dis16" name="dis16" value="1" <%= checkBoxAtPosY(displayDigit, 15) %>> </td>
											</tr>
											<tr>
												<td> <label class="control-label"> <%= lb_savedigit %> </label> <input type="hidden" name="oldsavedigit" value="<%=saveDigit%>"> </td>
												<td align="center"> <input type="checkbox" id="save1" name="save1" value="1" <%= checkBoxAtPosY(saveDigit, 0) %>> </td>
												<td align="center"> <input type="checkbox" id="save2" name="save2" value="1" <%= checkBoxAtPosY(saveDigit, 1) %>> </td>
												<td align="center"> <input type="checkbox" id="save3" name="save3" value="1" <%= checkBoxAtPosY(saveDigit, 2) %>> </td>
												<td align="center"> <input type="checkbox" id="save4" name="save4" value="1" <%= checkBoxAtPosY(saveDigit, 3) %>> </td>
												<td align="center"> <input type="checkbox" id="save5" name="save5" value="1" <%= checkBoxAtPosY(saveDigit, 4) %>> </td>
												<td align="center"> <input type="checkbox" id="save6" name="save6" value="1" <%= checkBoxAtPosY(saveDigit, 5) %>> </td>
												<td align="center"> <input type="checkbox" id="save7" name="save7" value="1" <%= checkBoxAtPosY(saveDigit, 6) %>> </td>
												<td align="center"> <input type="checkbox" id="save8" name="save8" value="1" <%= checkBoxAtPosY(saveDigit, 7) %>> </td>
												<td align="center"> <input type="checkbox" id="save9" name="save9" value="1" <%= checkBoxAtPosY(saveDigit, 8) %>> </td>
												<td align="center"> <input type="checkbox" id="save10" name="save10" value="1" <%= checkBoxAtPosY(saveDigit, 9) %>> </td>
												<td align="center"> <input type="checkbox" id="save11" name="save11" value="1" <%= checkBoxAtPosY(saveDigit, 10) %>> </td>
												<td align="center"> <input type="checkbox" id="save12" name="save12" value="1" <%= checkBoxAtPosY(saveDigit, 11) %>> </td>
												<td align="center"> <input type="checkbox" id="save13" name="save13" value="1" <%= checkBoxAtPosY(saveDigit, 12) %>> </td>
												<td align="center"> <input type="checkbox" id="save14" name="save14" value="1" <%= checkBoxAtPosY(saveDigit, 13) %>> </td>
												<td align="center"> <input type="checkbox" id="save15" name="save15" value="1" <%= checkBoxAtPosY(saveDigit, 14) %>> </td>
												<td align="center"> <input type="checkbox" id="save16" name="save16" value="1" <%= checkBoxAtPosY(saveDigit, 15) %>> </td>
											</tr>
											<tr>
												<td colspan="17"> </td>
											</tr>
										</table>
									
									</div>
								</div>
								
							</div>
						</div>
						
						<div class="row col-md-6">
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_customercode %> : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="customer_code" name="customer_code" value="<% if((customer_code)==(null)){ out.print(""); }else{ out.print(customer_code); } %>" maxlength="3" placeholder="<%= lb_customercode %>" onKeypress="IsValidCharacter();" onselectstart="return false" onpaste="return false;" onCopy="return false" onCut="return false" onDrag="return false" onDrop="return false" />
									<input type="hidden" name="oldcustomercode" value="<%= customer_code %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_mastercard %> 1 : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="master_card1" name="master_card1" value="<% if((master_card1)==(null)){ out.print(""); }else{ out.print(master_card1); } %>" maxlength="16" placeholder="<%= lb_mastercard %> 1">
									<input type="hidden" name="oldmascard1" value="<%= master_card1 %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_mastercard %> 2 : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="master_card2" name="master_card2" value="<% if((master_card2)==(null)){ out.print(""); }else{ out.print(master_card2); } %>" maxlength="16" placeholder="<%= lb_mastercard %> 2">
									<input type="hidden" name="oldmascard2" value="<%= master_card2 %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_mastercard %> 3 : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="master_card3" name="master_card3" value="<% if((master_card3)==(null)){ out.print(""); }else{ out.print(master_card3); } %>" maxlength="16" placeholder="<%= lb_mastercard %> 3">
									<input type="hidden" name="oldmascard3" value="<%= master_card3 %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_mastercard %> 4 : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="master_card4" name="master_card4" value="<% if((master_card4)==(null)){ out.print(""); }else{ out.print(master_card4); } %>" maxlength="16" placeholder="<%= lb_mastercard %> 4">
									<input type="hidden" name="oldmascard4" value="<%= master_card4 %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_mastercard %> 5 : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="master_card5" name="master_card5" value="<% if((master_card5)==(null)){ out.print(""); }else{ out.print(master_card5); } %>" maxlength="16" placeholder="<%= lb_mastercard %> 5">
									<input type="hidden" name="oldmascard5" value="<%= master_card5 %>">
								</div>
							</div>
						</div>
						
						
						<div class="row col-md-6">
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_stdigit %> : </label>
								<div class="control-label col-md-6">
									<select class="form-control selectpicker" data-width="100%" data-size="12" data-container="body" name="start_digit" id="start_digit">
								<%	for(int i = 1; i <= 16; i++){
										if(i < 10) loop = "0" + i; else loop = Integer.toString(i);
								%>		<option value="<%= loop %>" <%= checkDataSelected(start_digit, loop) %>> <%= loop %> </option>
								<%	}	%>
									</select>
									<input type="hidden" name="oldstartdigit" value="<%= start_digit %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_issuedigit %> : </label>
								<div class="control-label col-md-6">
									<select class="form-control selectpicker" data-width="100%" data-size="12" data-container="body" name="issue_digit" id="issue_digit">
								<%	for(int i = 1; i <= 16; i++){
										if(i < 10) loop = "0" + i; else loop = Integer.toString(i);
								%>		<option value="<%= loop %>" <%= checkDataSelected(issue_digit, loop) %>> <%= loop %> </option>
								<%	}	%>
									</select>
									<input type="hidden" name="oldissuedigit" value="<%= issue_digit %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_duplicatetime %> : </label>
								<div class="control-label col-md-6">
									<select class="form-control selectpicker" data-width="100%" data-size="12" data-container="body" name="duplicate_time" id="duplicate_time">
								<%	for(int i = 0; i <= 99; i++){
										if(i < 10) loop = "0" + i; else loop = Integer.toString(i);
								%>		<option value="<%= loop %>" <%= checkDataSelected(duplicate_time, loop) %>> <%= loop %> </option>
								<%	}	%>
									</select>
									<input type="hidden" name="oldduplicatetime" value="<%= duplicate_time %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_block_id %> : </label>
								<div class="control-label col-md-6">
									<select class="form-control selectpicker" data-width="100%" data-size="12" data-container="body" name="block_id" id="block_id" onChange="changeKey();">
										<option value="-1" <%= checkDataSelected(block_id, "-1") %>> <%= lb_none %> </option>
								<%	String block_id2;
									for(int i = 0; i <= 63; i++){						
										block_id2 = Integer.toString(i);
								%>		<option value="<%= block_id2 %>" <%= checkDataSelected(block_id, block_id2) %>> <%= block_id2 %> </option>
								<%	}	%>
									</select>
									<input type="hidden" name="oldblockid" value="<%= block_id %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_key_card2 %> : </label>
								<div class="control-label col-md-6">
									<input type="text" class="form-control" id="key_card2" name="key_card2" value="<%= key_card2 %>" maxlength="12" placeholder="<%= lb_key_card2 %>" onKeyPress="IsValidHex()" style="text-transform: uppercase">
									<input type="hidden" name="oldkeycard2" value="<%= key_card2 %>">
								</div>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_modulef %> : </label>
								<div class="control-label col-md-6">
									<select class="form-control selectpicker" data-width="100%" data-container="body" name="moduleF" id="moduleF">
										<option value="0" <%= checkDataSelected(modulef, "0") %>> Suprema </option>
										<option value="1" <%= checkDataSelected(modulef, "1") %>> SecuGen </option>
									</select>
									<input type="hidden" name="oldModuleF" value="<%= modulef %>">
								</div>
							</div>
						</div>
				  
			<%	if(ses_per == 0){	%>	
						<div class="row form-group" style="margin-bottom: 5px;">
							<center>
								<input name="Submit2" type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="ConfirmEditConfigCop('<%= msg_confirmedit%>', '<%= msg_mas1 %>', '<%= msg_mas2 %>', '<%= msg_mas3 %>', '<%= msg_mas4 %>', '<%= msg_mas5 %>', '<%= msg_mas6 %>', '<%= msg_mas7 %>', '<%= msg_mas8 %>', '<%= msg_mas9 %>', '<%= msg_mas10 %>');"> &nbsp; 
								<input name="Reset2" type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='view_configcorp.jsp?action=data'">
							</center>
						</div>
			<%	}	%>
				
					</div>
				</div>

		<%	
				}	rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
			}
		%>

		<div class="modal fade" id="myModalCardPattern" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12"> 
								<p>
								<div class="row" align="left">
									<label class="control-label col-md-12"> <i class="glyphicon glyphicon-credit-card"> </i> &nbsp; <%= lb_cardpattern %> &nbsp; <span id="pattern"> </span> </label>
								</div>
								<p>
								<div class="row">
									<div class="col-xs-2 col-md-2"> </div>
									<label class="control-label col-xs-10 col-md-10" align="left">
										<input name="radiobutton" id="radio1" type="radio" onclick="checkdata('<%= lang %>')" value="a" checked> &nbsp;
										Alphabet <i class="glyphicon glyphicon-arrow-right" style="margin-left: 64px; margin-right: 15px;"> </i> a
									</label>
								</div>
								<div class="row"> <hr style="width: 80%; height: 6px; margin-top: 4px; margin-bottom: 4px;" align="center"/> </div>
								<div class="row">
									<div class="col-xs-2 col-md-2"> </div>
									<label class="control-label col-xs-10 col-md-10" align="left">
										<input name="radiobutton" id="radio2" type="radio" onclick="checkdata('<%= lang %>')" value="n"> &nbsp;
										Numeric <i class="glyphicon glyphicon-arrow-right" style="margin-left: 70px; margin-right: 15px;"> </i> n
									</label>
								</div>
								<div class="row"> <hr style="width: 80%; height: 6px; margin-top: 4px; margin-bottom: 4px;" align="center"/> </div>
								<div class="row">
									<div class="col-xs-2 col-md-2"> </div>
									<label class="control-label col-xs-10 col-md-10" align="left">
										<input name="radiobutton" id="radio3" type="radio" onclick="checkdata('<%= lang %>')" value=""> &nbsp;
										Blank
									</label>
								</div>
								<div class="row"> <hr style="width: 80%; height: 6px; margin-top: 4px; margin-bottom: 4px;" align="center"/> </div>
								<div class="row">
									<div class="col-xs-2 col-md-2"> </div>
									<label class="control-label col-xs-10 col-md-10" align="left">
										<input name="radiobutton" id="radio4" type="radio" onclick="checkdata('<%= lang %>')" value="?"> &nbsp;
										All Character <i class="glyphicon glyphicon-arrow-right" style="margin-left: 39px; margin-right: 15px;"> </i> ?
									</label>
								</div>
								<div class="row"> <hr style="width: 80%; height: 6px; margin-top: 4px; margin-bottom: 4px;" align="center"/> </div>
								<div class="row">
									<div class="col-xs-2 col-md-2"> </div>
									<label class="control-label col-xs-10 col-md-10" align="left">
										<input name="radiobutton" id="radio5" type="radio"> &nbsp;
										Fixed Character <input type="text" class="form-control" name="text_f" id="text_f" style="width: 40px; max-height: 24px; margin-top: -22px; margin-left: 174px;" size="1" maxlength="1" onBlur="close_modal('<%= lang %>');">
									</label>
								</div>
								<div class="row"> <hr style="width: 80%; height: 6px; margin-top: 4px; margin-bottom: 4px;" align="center"/> </div>
								<div class="row">
									<div class="col-xs-2 col-md-2"> </div>
									<label class="control-label col-xs-10 col-md-10" align="left">
										<input name="radiobutton" id="radio6" type="radio" onclick="checkdata('<%= lang %>')" value="0"> &nbsp;
										Numeric <i class="glyphicon glyphicon-arrow-right" style="margin-left: 70px; margin-right: 15px;"> </i> 0
									</label>
								</div>
								<p>
							</div>
						</div>
					</div>
				</div>
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
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'view_configcorp.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>
