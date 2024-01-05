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
	session.setAttribute("subpage", "aboutsystem");
	session.setAttribute("subtitle", "reader"); 
	session.setAttribute("action", "edit_reader.jsp?"+"&action="+request.getParameter("action")+"&reader_no="+request.getParameter("reader_no")+"&");
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
		
		<link rel=" stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel=" stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel=" stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
		.nav-tabs > li a {
			border: 1px solid #EEEEEE;
			background-color: #DEDEDE;
			color: #2870A0;
		}
		.li-white {
			background-color: #FFFFFF !important;
			color: #333333 !important;
		}
		</style>
		
		<script language="javascript">
			document.onkeydown = searchKeyPress;
			
			function checkdata(){
				var doorid = document.form1.doorid.value;
				var a = document.getElementById('radio1');
				var b = document.getElementById('radio2');
				
			//	if(doorid == 0){
			//		document.form1.reader_no.value = "";
			//	}
				if(doorid.length != 0){
					if (a.checked){
						doorid = doorid+"1";					
						document.form1.reader_no.value = doorid;
					}else if (b.checked){
						doorid = doorid+"2";
						document.form1.reader_no.value = doorid;
					}
				}
			}
			
			function ConfirmAddEdit(act, sText, sText2, lb_duty, alr1, alrMist1, alr2, alrMist2, alr3, alrMist3, alr4, alrMist4, alr5, alrMist5, rd2duty){
				if(form1.doorid.value == ''){
					ModalWarning_TextName(sText2, 'doorid');
					$('#li_first').addClass('active');
					$('#li_second').removeClass('active');
					$('#1').removeClass('fade');
					$('#1').addClass('active');
					$('#2').removeClass('active');
					return false;
				}
				//	duty1 time1
				var duty1_time1, hh111, mm111, hh112, mm112 = "";
				hh111 = document.form1.hh111.value;
				mm111 = document.form1.mm111.value;
				hh112 = document.form1.hh112.value;
				mm112 = document.form1.mm112.value;
				duty1_time1 = hh111+mm111+hh112+mm112;
				
				if(duty1_time1 != ''){
					if(chkEmptyTime(hh111,mm111,hh112,mm112)){
						ModalWarning_TextName(lb_duty+' 1 '+alr1, '');
						return false;
					}else{
						if(comparetime(hh111,mm111,hh112,mm112)){
							ModalWarning_TextName(lb_duty+' 1 '+alrMist1, '');
							return false;				
						}
					}
				}
				
				//	duty1 time2
				var duty1_time2, hh121, mm121, hh122, mm122 = "";
				hh121 = document.form1.hh121.value;
				mm121 = document.form1.mm121.value;
				hh122 = document.form1.hh122.value;
				mm122 = document.form1.mm122.value;
				duty1_time2 = hh121+mm121+hh122+mm122;	
				if(duty1_time2 != ''){
					if(chkEmptyTime(hh121,mm121,hh122,mm122)){
						ModalWarning_TextName(lb_duty+' 1 '+alr2, '');
						return false;
					}else{
						if(comparetime(hh121,mm121,hh122,mm122)){
							ModalWarning_TextName(lb_duty+' 1 '+alrMist2, '');
							return false;				
						}
					}
				}
				//duty1 time3
				var duty1_time3,hh131,mm131,hh132,mm132="";
				hh131 = document.form1.hh131.value;
				mm131 = document.form1.mm131.value;
				hh132 = document.form1.hh132.value;
				mm132 = document.form1.mm132.value;
				duty1_time3 = hh131+mm131+hh132+mm132;	
				if(duty1_time3 != ''){
					if(chkEmptyTime(hh131,mm131,hh132,mm132)){
						ModalWarning_TextName(lb_duty+' 1 '+alr3, '');
						return false;
					}else{
						if(comparetime(hh131,mm131,hh132,mm132)){
							ModalWarning_TextName(lb_duty+' 1 '+alrMist3, '');
							return false;				
						}
					}
				}
				//	duty1 time4
				var duty1_time4, hh141, mm141, hh142, mm142 = "";
				hh141 = document.form1.hh141.value;
				mm141 = document.form1.mm141.value;
				hh142 = document.form1.hh142.value;
				mm142 = document.form1.mm142.value;
				duty1_time4 = hh141+mm141+hh142+mm142;	
				if(duty1_time4 != ''){
					if(chkEmptyTime(hh141,mm141,hh142,mm142)){
						ModalWarning_TextName(lb_duty+' 1 '+alr4, '');
						return false;
					}else{
						if(comparetime(hh141,mm141,hh142,mm142)){
							ModalWarning_TextName(lb_duty+' 1 '+alrMist4, '');
							return false;				
						}
					}
				}
				//	duty1 time5
				var duty1_time5, hh151, mm151, hh152, mm152 = "";
				hh151 = document.form1.hh151.value;
				mm151 = document.form1.mm151.value;
				hh152 = document.form1.hh152.value;
				mm152 = document.form1.mm152.value;
				duty1_time5 = hh151+mm151+hh152+mm152;	
				if(duty1_time5 != ''){
					if(chkEmptyTime(hh151,mm151,hh152,mm152)){
						ModalWarning_TextName(lb_duty+' 1 '+alr5, '');
						return false;
					}else{
						if(comparetime(hh151,mm151,hh152,mm152)){
							ModalWarning_TextName(lb_duty+' 1 '+alrMist5, '');
							return false;				
						}
					}
				}
				
				//	duty 2 time1
				var duty2_time1, hh211, mm211, hh212, mm212 = "";
				hh211 = document.form1.hh211.value;
				mm211 = document.form1.mm211.value;
				hh212 = document.form1.hh212.value;
				mm212 = document.form1.mm212.value;
				duty2_time1 = hh211+mm211+hh212+mm212;
				if(duty2_time1 != ''){
					if(chkEmptyTime(hh211,mm211,hh212,mm212)){
						ModalWarning_TextName(lb_duty+' 2 '+alr1, '');
						return false;
					}else{
						if(comparetime(hh211,mm211,hh212,mm212)){
							ModalWarning_TextName(lb_duty+' 2 '+alrMist1, '');
							return false;				
						}
					}
				}
				//	duty 2 time2
				var duty2_time2, hh221, mm221, hh222, mm222 = "";
				hh221 = document.form1.hh221.value;
				mm221 = document.form1.mm221.value;
				hh222 = document.form1.hh222.value;
				mm222 = document.form1.mm222.value;
				duty2_time2 = hh221+mm221+hh222+mm222;
				if(duty2_time2 != ''){
					if(chkEmptyTime(hh221,mm221,hh222,mm222)){
						ModalWarning_TextName(lb_duty+' 2 '+alr2, '');
						return false;
					}else{
						if(comparetime(hh221,mm221,hh222,mm222)){
							ModalWarning_TextName(lb_duty+' 2 '+alrMist2, '');
							return false;				
						}
					}
				}
				//	duty 2 time3
				var duty2_time3, hh231, mm231, hh232, mm232 = "";
				hh231 = document.form1.hh231.value;
				mm231 = document.form1.mm231.value;
				hh232 = document.form1.hh232.value;
				mm232 = document.form1.mm232.value;
				duty2_time3 = hh231+mm231+hh232+mm232;
				if(duty2_time3 != ''){
					if(chkEmptyTime(hh231,mm231,hh232,mm232)){
						ModalWarning_TextName(lb_duty+' 2 '+alr3, '');
						return false;
					}else{
						if(comparetime(hh231,mm231,hh232,mm232)){
							ModalWarning_TextName(lb_duty+' 2 '+alrMist3, '');
							return false;				
						}
					}
				}
				//	duty 2 time4
				var duty2_time4, hh241, mm241, hh242, mm242 = "";
				hh241 = document.form1.hh241.value;
				mm241 = document.form1.mm241.value;
				hh242 = document.form1.hh242.value;
				mm242 = document.form1.mm242.value;
				duty2_time4 = hh241+mm241+hh242+mm242;
				if(duty2_time4 != ''){
					if(chkEmptyTime(hh241,mm241,hh242,mm242)){
						ModalWarning_TextName(lb_duty+' 2 '+alr4, '');
						return false;
					}else{
						if(comparetime(hh241,mm241,hh242,mm242)){
							ModalWarning_TextName(lb_duty+' 2 '+alrMist4, '');
							return false;				
						}
					}
				}
				//	duty 2 time5
				var duty2_time5, hh251, mm251, hh252, mm252 = "";
				hh251 = document.form1.hh251.value;
				mm251 = document.form1.mm251.value;
				hh252 = document.form1.hh252.value;
				mm252 = document.form1.mm252.value;
				duty2_time5 = hh251+mm251+hh252+mm252;
				if(duty2_time5 != ''){
					if(chkEmptyTime(hh251,mm251,hh252,mm252)){
						ModalWarning_TextName(lb_duty+' 2 '+alr5, '');
						return false;
					}else{
						if(comparetime(hh251,mm251,hh252,mm252)){
							ModalWarning_TextName(lb_duty+' 2 '+alrMist5, '');
							return false;				
						}
					}
				}
				//	duty3 time1
				var duty3_time1, hh311, mm311, hh312, mm312 = "";
				hh311 = document.form1.hh311.value;
				mm311 = document.form1.mm311.value;
				hh312 = document.form1.hh312.value;
				mm312 = document.form1.mm312.value;
				duty3_time1 = hh311+mm311+hh312+mm312;
				if(duty3_time1 != ''){
					if(chkEmptyTime(hh311, mm311, hh312, mm312)){
						ModalWarning_TextName(lb_duty+' 3 '+alr1, '');
						return false;
					}else{
						if(comparetime(hh311, mm311, hh312, mm312)){
							ModalWarning_TextName(lb_duty+' 3 '+alrMist1, '');
							return false;				
						}
					}
				}
				//	duty3 time2
				var duty3_time2, hh321, mm321, hh322, mm322 = "";
				hh321 = document.form1.hh321.value;
				mm321 = document.form1.mm321.value;
				hh322 = document.form1.hh322.value;
				mm322 = document.form1.mm322.value;
				duty3_time2 = hh321+mm321+hh322+mm322;
				if(duty3_time2 != ''){
					if(chkEmptyTime(hh321, mm321, hh322, mm322)){
						ModalWarning_TextName(lb_duty+' 3 '+alr2, '');
						return false;
					}else{
						if(comparetime(hh321, mm321, hh322, mm322)){
							ModalWarning_TextName(lb_duty+' 3 '+alrMist2, '');
							return false;				
						}
					}
				}
				//	duty3 time3
				var duty3_time3, hh331, mm331, hh332, mm332 = "";
				hh331 = document.form1.hh331.value;
				mm331 = document.form1.mm331.value;
				hh332 = document.form1.hh332.value;
				mm332 = document.form1.mm332.value;
				duty3_time3 = hh331+mm331+hh332+mm332;
				if(duty3_time3 != ''){
					if(chkEmptyTime(hh331, mm331, hh332, mm332)){
						ModalWarning_TextName(lb_duty+' 3 '+alr3, '');
						return false;
					}else{
						if(comparetime(hh331, mm331, hh332, mm332)){
							ModalWarning_TextName(lb_duty+' 3 '+alrMist3, '');
							return false;				
						}
					}
				}
				//	duty3 time4
				var duty3_time4, hh341, mm341, hh342, mm342 = "";
				hh341 = document.form1.hh341.value;
				mm341 = document.form1.mm341.value;
				hh342 = document.form1.hh342.value;
				mm342 = document.form1.mm342.value;
				duty3_time4 = hh341+mm341+hh342+mm342;
				if(duty3_time4 != ''){
					if(chkEmptyTime(hh341, mm341, hh342, mm342)){
						ModalWarning_TextName(lb_duty+' 3 '+alr4, '');
						return false;
					}else{
						if(comparetime(hh341, mm341, hh342, mm342)){
							ModalWarning_TextName(lb_duty+' 3 '+alrMist4, '');
							return false;				
						}
					}
				}
				//	duty3 time5
				var duty3_time5,hh351, mm351, hh352, mm352 = "";
				hh351 = document.form1.hh351.value;
				mm351 = document.form1.mm351.value;
				hh352 = document.form1.hh352.value;
				mm352 = document.form1.mm352.value;
				duty3_time5 = hh351+mm351+hh352+mm352;
				if(duty3_time5 != ''){
					if(chkEmptyTime(hh351, mm351, hh352, mm352)){
						ModalWarning_TextName(lb_duty+' 3 '+alr5, '');
						return false;
					}else{
						if(comparetime(hh351, mm351, hh352, mm352)){
							ModalWarning_TextName(lb_duty+' 3 '+alrMist5, '');
							return false;				
						}
					}
				}
				//	duty4 time1
				var duty4_time1, hh411, mm411, hh412, mm412 = "";
				hh411 = document.form1.hh411.value;
				mm411 = document.form1.mm411.value;
				hh412 = document.form1.hh412.value;
				mm412 = document.form1.mm412.value;
				duty4_time1 = hh411+mm411+hh412+mm412
				if(duty4_time1 != ''){
					if(chkEmptyTime(hh411, mm411, hh412, mm412)){
						ModalWarning_TextName(lb_duty+' 4 '+alr1, '');
						return false;
					}else{
						if(comparetime(hh411, mm411, hh412, mm412)){
							ModalWarning_TextName(lb_duty+' 4 '+alrMist1, '');
							return false;				
						}
					}
				}
				//	duty4 time2
				var duty4_time2, hh421, mm421, hh422, mm422 = "";
				hh421 = document.form1.hh421.value;
				mm421 = document.form1.mm421.value;
				hh422 = document.form1.hh422.value;
				mm422 = document.form1.mm422.value;
				duty4_time2 = hh421+mm421+hh422+mm422;
				if(duty4_time2 != ''){
					if(chkEmptyTime(hh421, mm421, hh422, mm422)){
						ModalWarning_TextName(lb_duty+' 4 '+alr2, '');
						return false;
					}else{
						if(comparetime(hh421, mm421, hh422, mm422)){
							ModalWarning_TextName(lb_duty+' 4 '+alrMist2, '');
							return false;				
						}
					}
				}
				//	duty4 time3
				var duty4_time3, hh431, mm431, hh432, mm432 = "";
				hh431 = document.form1.hh431.value;
				mm431 = document.form1.mm431.value;
				hh432 = document.form1.hh432.value;
				mm432 = document.form1.mm432.value;
				duty4_time3 = hh431+mm431+hh432+mm432;
				if(duty4_time3 != ''){
					if(chkEmptyTime(hh431, mm431, hh432, mm432)){
						ModalWarning_TextName(lb_duty+' 4 '+alr3, '');
						return false;
					}else{
						if(comparetime(hh431, mm431, hh432, mm432)){
							ModalWarning_TextName(lb_duty+' 4 '+alrMist3, '');
							return false;				
						}
					}
				}
				//	duty4 time4
				var duty4_time4, hh441, mm441, hh442, mm442 = "";
				hh441 = document.form1.hh441.value;
				mm441 = document.form1.mm441.value;
				hh442 = document.form1.hh442.value;
				mm442 = document.form1.mm442.value;
				duty4_time4 = hh441+mm441+hh442+mm442;
				if(duty4_time4 != ''){
					if(chkEmptyTime(hh441, mm441, hh442, mm442)){
						ModalWarning_TextName(lb_duty+' 4 '+alr4, '');
						return false;
					}else{
						if(comparetime(hh441, mm441, hh442, mm442)){
							ModalWarning_TextName(lb_duty+' 4 '+alrMist4, '');
							return false;				
						}
					}
				}
				//	duty4 time5
				var duty4_time5, hh451, mm451, hh452, mm452 = "";
				hh451 = document.form1.hh451.value;
				mm451 = document.form1.mm451.value;
				hh452 = document.form1.hh452.value;
				mm452 = document.form1.mm452.value;
				duty4_time5 = hh451+mm451+hh452+mm452;
				if(duty4_time5 != ''){
					if(chkEmptyTime(hh451, mm451, hh452, mm452)){
						ModalWarning_TextName(lb_duty+' 4 '+alr5, '');
						return false;
					}else{
						if(comparetime(hh451, mm451, hh452, mm452)){
							ModalWarning_TextName(lb_duty+' 4 '+alrMist5, '');
							return false;				
						}
					}
				}
				
				if(document.form1.rd2duty.value == ''){
					ModalWarning_TextName(rd2duty, 'rd2duty');
					$('#li_first').removeClass('active');
					$('#li_second').addClass('active');
					$('#1').removeClass('active');
					$('#2').removeClass('fade');
					$('#2').addClass('active');
					return false;
				}
				
				if(act == 'add'){
					document.form1.action = "module/act_reader.jsp?action=add";	
					document.getElementById("form1").submit();
				}else{
					Confirm_Save(sText);
				}
			}
			
			function Confirm_Save(sText){
				document.getElementById("text_confirm").innerHTML = sText;
				$('#myModalConfirm').modal('show');
			}
			
			function Confirm_Button(){
				document.form1.action = "module/act_reader.jsp?action=edit";
				document.getElementById("form1").submit();
			}	
			
			function loadPage(){
				if(document.form1.level_no.value == 1){
					document.getElementById('checkbox1').disabled = '';
					document.getElementById('checkbox2').disabled = 'disabled';
					document.getElementById('checkbox3').disabled = 'disabled';
					document.getElementById('checkbox4').disabled = 'disabled';
					document.getElementById('checkbox5').disabled = 'disabled';
					document.getElementById('checkbox2').checked = false;
					document.getElementById('checkbox3').checked = false;
					document.getElementById('checkbox4').checked = false;
					document.getElementById('checkbox5').checked = false;
				}else if(document.form1.level_no.value == 2){
					document.getElementById('checkbox1').disabled = '';
					document.getElementById('checkbox2').disabled = '';
					document.getElementById('checkbox3').disabled = 'disabled';
					document.getElementById('checkbox4').disabled = 'disabled';
					document.getElementById('checkbox5').disabled = 'disabled';
					document.getElementById('checkbox3').checked = false;
					document.getElementById('checkbox4').checked = false;
					document.getElementById('checkbox5').checked = false;
				}else if(document.form1.level_no.value == 3){
					document.getElementById('checkbox1').disabled = '';
					document.getElementById('checkbox2').disabled = '';
					document.getElementById('checkbox3').disabled = '';
					document.getElementById('checkbox4').disabled = 'disabled';
					document.getElementById('checkbox5').disabled = 'disabled';
					document.getElementById('checkbox4').checked = false;
					document.getElementById('checkbox5').checked = false;
				}else if(document.form1.level_no.value == 4){
					document.getElementById('checkbox1').disabled = '';
					document.getElementById('checkbox2').disabled = '';
					document.getElementById('checkbox3').disabled = '';
					document.getElementById('checkbox4').disabled = '';
					document.getElementById('checkbox5').disabled = 'disabled';
					document.getElementById('checkbox5').checked = false;
				}else if(document.form1.level_no.value == 5){
					document.getElementById('checkbox1').disabled = '';
					document.getElementById('checkbox2').disabled = '';
					document.getElementById('checkbox3').disabled = '';
					document.getElementById('checkbox4').disabled = '';
					document.getElementById('checkbox5').disabled = '';
				}else{
					document.getElementById('checkbox1').disabled = 'disabled';
					document.getElementById('checkbox2').disabled = 'disabled';
					document.getElementById('checkbox3').disabled = 'disabled';
					document.getElementById('checkbox4').disabled = 'disabled';
					document.getElementById('checkbox5').disabled = 'disabled';
					document.getElementById('checkbox1').checked = false;
					document.getElementById('checkbox2').checked = false;
					document.getElementById('checkbox3').checked = false;
					document.getElementById('checkbox4').checked = false;
					document.getElementById('checkbox5').checked = false;
				}
			}
			
			function set_pluszero(currentObj){
				if(currentObj.value.length == '1'){
					currentObj.value = '0'+currentObj.value;
				}
			}

			function CheckConfig(countRD, config_reader, sText, status){
				var m_int = new Number(countRD);
				var config_int = new Number(config_reader);
				if(status == "add"){
					if(((config_int == 0) && (m_int < 4)) || ((config_int == 1) && (m_int < 8)) || ((config_int == 2) && (m_int < 10)) || (config_int == 3)){
						location.href = 'module/act_reader.jsp?action=add';
					}else{
						document.getElementById("btn_warning").style.display = 'none';
						document.getElementById("btn_warning2").style.display = '';
						ModalWarning_TextName(sText, '');
						return false;
					}
				}
			}
			
			function change_class(field_name){
				if(field_name == 'rd2duty'){
					if(document.form1.rd2duty.value != ""){
						document.getElementById("textbox_rd2duty").className = "form-group has-success has-feedback";
						document.getElementById("icon_rd2duty").className = "glyphicon glyphicon-ok form-control-feedback";
					}else{
						document.getElementById("textbox_rd2duty").className = "form-group has-error has-feedback";
						document.getElementById("icon_rd2duty").className = "glyphicon glyphicon glyphicon-star form-control-feedback";
					}
				}else if(field_name == 'doorid'){
					document.getElementById("select_"+field_name).className = "input-group has-success has-feedback";
					document.getElementById("icon_"+field_name).className = "glyphicon glyphicon-ok form-control-feedback";
				}
			}
		</script>
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadPage();">
		
<% 
		String action = "";
		if(request.getParameter("action") != null){
			action = request.getParameter("action");
		}else{
			response.sendRedirect("data_reader.jsp");
		}
		session.setAttribute("act", action);
		
		String countRD = "";
		ResultSet rs_count = stmtQry.executeQuery("SELECT COUNT(reader_no) AS countRD FROM dbreader ");
		if(rs_count.next()){
			countRD = rs_count.getString("countRD");
			if(rs_count.getString("countRD").equals("0")){
				rs_count.close();
			} 
		}
		int m_int = Integer.parseInt(countRD);
	
%>
	
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<%	if(!checkPermission(ses_per, "0")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); </script>
			
		<%	}else{	%>
		
		<div class="body-display">
			<div class="container">
				
				<form id="form1" name="form1" method="post" onSubmit="return CheckConfig('<%= countRD %>', '<%= m_int %>', '<%= msg_limit_vs %>', '<%= action%>')">

				<div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
					<div class="bs-callout bs-callout-info"> 
					
<% 		if(action.equals("add")){	%>

						<ul class="nav nav-tabs">
							<li id="li_first" class="active" style="max-height: 28px;"> <a href="#1" style="max-height: 28px;" data-toggle="tab"> <div style="margin-top: -7px;"> &nbsp; <b><%= lb_reader%></b> &nbsp; </div> </a> </li>
							<li id="li_second" style="max-height: 28px;"> <a href="#2" style="max-height: 28px;" data-toggle="tab"> <div style="margin-top: -7px;"> &nbsp; <b><%= lb_add_config %></b> &nbsp; </div> </a> </li>
						</ul>
	 
						<div class="tab-content">
							<div class="tab-pane active" id="1">
								
						<%	try{	%>
						
								<div class="row form-group" style="margin-top: 20px">
									<label class="control-label label-text-1 col-md-3"> <%= lb_doorcode %> : </label>
									<div class="col-md-3">
										<div class="input-group has-error has-feedback" id="select_doorid">
											<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="doorid" id="doorid" onChange="change_class('doorid'); checkdata();">
							<% 				String sql_door = "SELECT DISTINCT door.door_id, ";		//	 COUNT(door.door_id) AS count_door,
											if(lang.equals("th")){
												sql_door += "door.th_desc AS door_desc ";
											}else{
												sql_door += "door.en_desc AS door_desc ";
											}
											sql_door += " FROM dbdoor door ";
											sql_door += " LEFT OUTER JOIN dbreader rd on (door.door_id = rd.door_id) ";		//	 group by door.door_id
											sql_door += " ORDER BY door.door_id ASC ";
											
											ResultSet rs_door = stmtUp.executeQuery(sql_door);											
							%>
												<option name="door_id" value="" disabled selected> <%= msg_ps_selectdoor %> </option>
							<%				while(rs_door.next()){	
											//	if(rs_door.getInt("count_door") < 2){	
							%> 
												<option name="door_id" value="<%= rs_door.getString("door_id") %>"> <%= rs_door.getString("door_id") %> - <%= rs_door.getString("door_desc") %> </option>
							<%  			//	}
											}
											rs_door.close();		
							%>
											</select>
											<span class="input-group-addon" style="background-color: #ffffff;">
												<span class="glyphicon glyphicon-star form-control-feedback" id="icon_doorid" aria-hidden="true"> </span> &nbsp; &nbsp;
											</span>
										</div>
									</div>
									<div class="col-md-6" style="margin-top: 6px;">
										<input type="radio" name="reader_in" value="1" id="radio1" onClick="checkdata();" checked > &nbsp; <b> 1 </b> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
										<input type="radio" name="reader_in" value="2" id="radio2" onClick="checkdata();" > &nbsp; <b> 2 </b>
									</div>
								</div> 
								
						<%	}catch(SQLException e){		
								out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
							}
						%>
				
								<div class="row form-group">
									<label class="control-label label-text-1 col-md-3"> <%= lb_readerno %> : </label>
									<div class="col-md-3">
										<input type="text" name="reader_no" id="reader_no" class="form-control" placeholder="<%= lb_readerno %>" readonly="readonly" style="background-color: #F0F0F0">
									</div>
									<div class="col-md-6 has-error" style="margin-top: 6px;"> <label class="control-label"> ( <%=  lb_rdauto %> ) </label> </div> 
								</div>
								<div class="row form-group">
									<label class="control-label label-text-1 col-md-3"> <%= lb_thdesc %> : </label>
									<div class="col-md-3">
										<input type="text" class="form-control" id="th_desc" name="th_desc" maxlength="80" placeholder="<%= lb_thdesc %>">
									</div>
									<div class="col-md-6"> </div>
								</div> 
								<div class="row form-group">
									<label class="control-label label-text-1 col-md-3"> <%= lb_endesc %> : </label>
									<div class="col-md-3">
										<input type="text" class="form-control" id="en_desc" name="en_desc" maxlength="80" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
									</div>
									<div class="col-md-6"> </div>
								</div> 								
								
								<div class="row" style="margin-top: 5px; margin-left: 0px; margin-right: 0px">
									<div class="row col-md-6" style="margin-top: 0px; margin-left: 0px; margin-right: -20px">
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_readerfunc %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="reader_func" id="reader_func">
													<option value="0" selected> Access </option>
													<option value="1"> Time Attendance  </option>
													<option value="2"> Safety  </option>
												</select>
											</div>									
										</div>
										
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_security %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="security" id="security">
													<option value="0" selected> <%= lb_on %> </option>
													<option value="1"> <%= lb_off %> </option>
												</select>
											</div>	
										</div>	
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_language %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="language" id="language">
													<option value="0" selected> <%= lb_thai %> </option>
													<option value="1"> <%= lb_eng %> </option>
												</select>
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_displaybright %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="display_bright" id="display_bright">
										<%		String loop1;
												for(int i = 0; i <= 10; i++){
													if(i < 10) loop1 = "0" + i; else loop1 = Integer.toString(i);
										%>
													<option value="<%= loop1 %>" <%= checkDataSelected(loop1, "07") %>> <%= loop1 %> </option>
										<%		}	%>
												</select>
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_volume %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="volume" id="volume">
										<%		String loop_volume;
												for(int i = 0; i <= 10; i++){
													if(i < 10) loop_volume = "0" + i; else loop_volume = Integer.toString(i);
										%>
													<option value="<%= loop_volume %>" <%= checkDataSelected(loop_volume, "08") %>> <%= loop_volume %> </option>
										<%		}	%>
												</select>
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_time_off_display %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="timeoffdisplay" id="timeoffdisplay">
										<%		String loop_tod;
												for(int i = 0; i <= 99; i++){
													if(i < 10) loop_tod = "0" + i; else loop_tod = Integer.toString(i);
										%>
													<option value="<%= loop_tod %>" <%= checkDataSelected(loop_tod, "08") %>> <%= loop_tod %> </option>
										<%		}	%>
												</select>
											</div>
										</div>
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_writecard %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="write_oncard" id="write_oncard">
													<option value="0" selected> <%= lb_inactive %> </option>
													<option value="1"> <%= lb_aftercheck %> </option>
													<option value="2"> <%= lb_beforecheck %> </option>
												</select>
											</div>
										</div> 
									</div> 
									
									<div class="row col-md-6" style="margin-top: 0px; margin-left: 0px; margin-right: -20px">									
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_readertype %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="reader_type" id="reader_type">
													<option value="0" selected> Standard </option>
													<option value="1"> Finger </option>
													<option value="2"> Palm vein  </option>
												</select>
											</div>												
										</div>	
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> &nbsp; </label>
											<div class="col-md-6">
												
											</div>	
										</div>										
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_actkeypad %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="keypad" id="keypad">
													<option value="0" selected> <%= lb_push_inact %> </option>
													<option value="1"> <%= lb_push_act %> </option>
													<option value="2"> <%= lb_push_key %> </option>
												</select>
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_actkeyduty %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="keyduty" id="keyduty">
													<option value="0" selected> Active View Only </option>
													<option value="1"> Active Duty & View </option>
													<option value="2"> Inactive Duty & View </option>
													<option value="3"> Active Duty Only </option>
												</select>
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_enablediden %> :</label>
											<div class="control-label col-md-6" style="margin-top: 6px;">
												<input type="checkbox" name="finger_iden" id="finger_iden" value="checkbox" checked> &nbsp; 
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_keybeep %> :</label>
											<div class="control-label col-md-6" style="margin-top: 6px;">
												<input type="checkbox" name="key_beep" id="key_beep" value="checkbox"> &nbsp;
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_outoffservice %> :</label>
											<div class="control-label col-md-6" style="margin-top: 6px;">
												<input type="checkbox" name="outofservice" id="outofservice" value="checkbox"> &nbsp; 
											</div>
										</div>
									</div>
								</div>
                                
								<div class="bs-callout bs-callout-info" style="margin-top: 0px; margin-right: -11px;"> 
									<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
										<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-time" > </i> &nbsp; <b> <%= lb_statustaff %> </b> </label>
									</div>
									<div class="table-responsive" style="border: 0px !important;" border="0">
										<div class="row" style="min-width: 1500px; margin-left: -10px; margin-right: -20px;">
											<div class="row" style="margin-left: -45px">
												<h5 class="modal-title col-xs-1 col-md-1"> </h5>
												<h5 class="modal-title col-xs-1 col-md-1" style="margin-left: -10px"> <div align="center"> <b> <%= lb_duty %>  </b> </div> </h5>
												<h5 class="modal-title col-xs-2 col-md-2" style="margin-left: -15px"> <div align="center"> <b> <%= lb_timezone %> 1 </b> </div> </h5>
												<h5 class="modal-title col-xs-2 col-md-2" style="margin-left: -10px"> <div align="center"> <b> <%= lb_timezone %> 2 </b> </div> </h5>
												<h5 class="modal-title col-xs-2 col-md-2" style="margin-left: -10px"> <div align="center"> <b> <%= lb_timezone %> 3 </b> </div> </h5>
												<h5 class="modal-title col-xs-2 col-md-2" style="margin-left: -10px"> <div align="center"> <b> <%= lb_timezone %> 4 </b> </div> </h5>
												<h5 class="modal-title col-xs-2 col-md-2" style="margin-left: -10px"> <div align="center"> <b> <%= lb_timezone %> 5 </b> </div> </h5>
											</div>
											<div class="row" style="margin-left: 0px; margin-right: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 96%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
											<div class="row" style="margin-left: -25px">
												<h5 class="modal-title col-xs-1 col-md-1" style="margin-top: 6px;" align="right"> <b> IN &nbsp; </b> </h5>
												<div class="modal-title col-xs-1 col-md-1"> 
													<input name="display_duty1" type="text" class="form-control" id="display_duty1" maxlength="1" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidCharacter()" onKeyDown="nextObject(window.event.keyCode, document.form1.hh111)">
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center" style="margin-left: -45px">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh111" type="text" class="form-control" id="hh111" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm111, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm111', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm111, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm111" type="text" class="form-control" id="mm111" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh112, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh112', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh112, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh112" type="text" class="form-control" id="hh112" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm112, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm112', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm112, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm112" type="text" class="form-control" id="mm112" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh121, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh121', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh121, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh121" type="text" class="form-control" id="hh121" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm121, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm121', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm121, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm121" type="text" class="form-control" id="mm121" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh122, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh122', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh122, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh122" type="text" class="form-control" id="hh122" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm122, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm122', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm122, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm122" type="text" class="form-control" id="mm122" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh131, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh131', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh131, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                      
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh131" type="text" class="form-control" id="hh131" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm131, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm131', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm131, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm131" type="text" class="form-control" id="mm131" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh132, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh132', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh132, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh132" type="text" class="form-control" id="hh132" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm132, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm132', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm132, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm132" type="text" class="form-control" id="mm132" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh141, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh141', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh141, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-3 col-md-1"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh141" type="text" class="form-control" id="hh141" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm141, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm141', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm141, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm141" type="text" class="form-control" id="mm141" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh142, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh142', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh142, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh142" type="text" class="form-control" id="hh142" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm142, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm142', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm142, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm142" type="text" class="form-control" id="mm142" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh151, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh151', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh151, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-3 col-md-1"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh151" type="text" class="form-control" id="hh151" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm151, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm151', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm151, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm151" type="text" class="form-control" id="mm151" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh152, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh152', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh152, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh152" type="text" class="form-control" id="hh152" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm152, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm152', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm152, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm152" type="text" class="form-control" id="mm152" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.display_duty2, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh211', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.display_duty2, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-3 col-md-1"> </div>                          
													</div>
												</div>
											</div>
											<div class="row" style="margin-left: 0px; margin-right: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 96%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
											<div class="row" style="margin-left: -25px">
												<h5 class="modal-title col-xs-1 col-md-1" style="margin-top: 6px;" align="right"> <b> OUT &nbsp; </b> </h5>
												<div class="modal-title col-xs-1 col-md-1"> 
													<input name="display_duty2" type="text" class="form-control" id="display_duty2" maxlength="1" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidCharacter()" onKeyDown="nextObject(window.event.keyCode, document.form1.hh211)">
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center" style="margin-left: -45px">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">                                                    
															<input name="hh211" type="text" class="form-control" id="hh211" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm211, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm211', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm211, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm211" type="text" class="form-control" id="mm211" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh212, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh212', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh212, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh212" type="text" class="form-control" id="hh212" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm212, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm212', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm212, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm212" type="text" class="form-control" id="mm212" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh221, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh221', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh221, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh221" type="text" class="form-control" id="hh221" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm221, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm221', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm221, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm221" type="text" class="form-control" id="mm221" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh222, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh222', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh222, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh222" type="text" class="form-control" id="hh222" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm222, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm222', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm222, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm222" type="text" class="form-control" id="mm222" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh231, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh231', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh231, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh231" type="text" class="form-control" id="hh231" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm231, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm231', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm231, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm231" type="text" class="form-control" id="mm231" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh232, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh232', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh232, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh232" type="text" class="form-control" id="hh232" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm232, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm232', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm232, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm232" type="text" class="form-control" id="mm232" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh241, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh241', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh241, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh241" type="text" class="form-control" id="hh241" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm241, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm241', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm241, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm241" type="text" class="form-control" id="mm241" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh242, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh242', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh242, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh242" type="text" class="form-control" id="hh242" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm242, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm242', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm242, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm242" type="text" class="form-control" id="mm242" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh251, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh251', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh251, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh251" type="text" class="form-control" id="hh251" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm251, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm251', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm251, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm251" type="text" class="form-control" id="mm251" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh252, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh252', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh252, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh252" type="text" class="form-control" id="hh252" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm252, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm252', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm252, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm252" type="text" class="form-control" id="mm252" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.display_duty3, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh311', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.display_duty3, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>
													</div>
												</div>
											</div>
											<div class="row" style="margin-left: 0px; margin-right: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 96%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
											<div class="row" style="margin-left: -25px">
												<h5 class="modal-title col-xs-1 col-md-1" style="margin-top: 6px;" align="right"> <b> OT IN &nbsp; </b> </h5>
												<div class="modal-title col-xs-1 col-md-1"> 
													<input name="display_duty3" type="text" class="form-control" id="display_duty3" maxlength="1" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidCharacter()" onKeyDown="nextObject(window.event.keyCode, document.form1.hh311)">
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center" style="margin-left: -45px">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">                                                    
															<input name="hh311" type="text" class="form-control" id="hh311" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm311, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm311', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm311, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm311" type="text" class="form-control" id="mm311" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh312, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh312', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh312, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh312" type="text" class="form-control" id="hh312" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm312, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm312', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm312, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm312" type="text" class="form-control" id="mm312" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh321, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh321', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh321, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh321" type="text" class="form-control" id="hh321" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm321, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm321', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm321, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm321" type="text" class="form-control" id="mm321" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh322, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh322', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh322, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh322" type="text" class="form-control" id="hh322" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm322, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm322', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm322, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm322" type="text" class="form-control" id="mm322" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh331, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh331', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh331, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh331" type="text" class="form-control" id="hh331" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm331, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm331', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm331, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm331" type="text" class="form-control" id="mm331" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh332, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh332', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh332, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh332" type="text" class="form-control" id="hh332" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm332, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm332', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm332, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm332" type="text" class="form-control" id="mm332" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh341, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh341', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh341, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh341" type="text" class="form-control" id="hh341" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm341, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm341', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm341, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm341" type="text" class="form-control" id="mm341" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh342, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh342', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh342, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh342" type="text" class="form-control" id="hh342" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm342, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm342', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm342, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm342" type="text" class="form-control" id="mm342" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh351, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh351', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh351, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh351" type="text" class="form-control" id="hh351" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm351, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm351', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm351, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm351" type="text" class="form-control" id="mm351" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh352, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh352', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh352, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh352" type="text" class="form-control" id="hh352" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm352, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm352', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm352, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm352" type="text" class="form-control" id="mm352" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.display_duty4, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh411', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.display_duty4, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>
													</div>
												</div>
											</div>
											<div class="row" style="margin-left: 0px; margin-right: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 96%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
											<div class="row" style="margin-left: -25px">
												<h5 class="modal-title col-xs-1 col-md-1" style="margin-top: 6px;" align="right"> <b> OT OUT &nbsp; </b> </h5>
												<div class="modal-title col-xs-1 col-md-1"> 
													<input name="display_duty4" type="text" class="form-control" id="display_duty4" maxlength="1" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidCharacter()" onKeyDown="nextObject(window.event.keyCode, document.form1.hh411)">
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center" style="margin-left: -45px">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">                                                    
															<input name="hh411" type="text" class="form-control" id="hh411" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm411, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm411', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm411, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm411" type="text" class="form-control" id="mm411" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh412, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh412', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh412, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh412" type="text" class="form-control" id="hh412" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm412, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm412', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm412, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm412" type="text" class="form-control" id="mm412" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh421, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh421', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh421, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh421" type="text" class="form-control" id="hh421" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm421, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm421', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm421, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm421" type="text" class="form-control" id="mm421" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh422, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh422', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh422, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh422" type="text" class="form-control" id="hh422" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm422, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm422', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm422, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm422" type="text" class="form-control" id="mm422" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh431, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh431', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh431, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh431" type="text" class="form-control" id="hh431" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm431, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm431', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm431, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm431" type="text" class="form-control" id="mm431" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh432, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh432', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh432, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh432" type="text" class="form-control" id="hh432" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm432, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm432', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm432, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm432" type="text" class="form-control" id="mm432" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh441, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh441', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh441, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh441" type="text" class="form-control" id="hh441" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm441, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm441', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm441, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm441" type="text" class="form-control" id="mm441" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh442, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh442', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh442, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh442" type="text" class="form-control" id="hh442" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm442, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm442', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm442, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm442" type="text" class="form-control" id="mm442" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh451, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh451', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh451, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>                          
													</div>
												</div>
												<div class="modal-title col-xs-2 col-md-2" align="center">
													<div class="row form-inline">
														<div class="col-xs-1 col-md-1">
															<input name="hh451" type="text" class="form-control" id="hh451" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm451, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm451', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm451, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm451" type="text" class="form-control" id="mm451" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh452, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh452', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh452, '<%= msg_input_minute %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
														<div class="col-xs-1 col-md-1">
															<input name="hh452" type="text" class="form-control" id="hh452" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm452, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm452', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm452, '<%= msg_input_hour %>');">
														</div>
														<label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
														<div class="col-xs-1 col-md-1">
															<input name="mm452" type="text" class="form-control" id="mm452" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.display_duty1, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh111', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.display_duty1, '<%= msg_input_minute %>');">
														</div>
														<div class="col-xs-5 col-md-5"> </div>
													</div>
												</div>
											</div>
											
										</div>
									</div>
								</div>
							
								<div class="row col-md-6" style="margin-top: 10px; margin-left: 0px; margin-right: -20px">
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_clock_color %> (<%= lb_normal %>) : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="color_normal" id="color_normal">
												<option value="0" selected> <%= displayColorStr("0", lang) %> </option>
												<option value="1"> <%= displayColorStr("1", lang) %> </option> 
												<option value="2"> <%= displayColorStr("2", lang) %> </option> 
												<option value="3"> <%= displayColorStr("3", lang) %> </option> 
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_clock_color %> (<%= lb_rdunlock %>) : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="color_unlock" id="color_unlock">
												<option value="0"> <%= displayColorStr("0", lang) %> </option>
												<option value="1"> <%= displayColorStr("1", lang) %> </option> 
												<option value="2" selected> <%= displayColorStr("2", lang) %> </option> 
												<option value="3"> <%= displayColorStr("3", lang) %> </option> 
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_clock_color %> (<%= lb_alarm %>) : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="color_alarm" id="color_alarm">
												<option value="0"> <%= displayColorStr("0", lang) %> </option>
												<option value="1" selected> <%= displayColorStr("1", lang) %> </option> 
												<option value="2"> <%= displayColorStr("2", lang) %> </option> 
												<option value="3"> <%= displayColorStr("3", lang) %> </option> 
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_alarm_mode %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="alarmmode" id="alarmmode">
												<option value="0" selected> <%= displayAlarmMode("0") %> </option>
												<option value="1"> <%= displayAlarmMode("1") %> </option> 
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_access_mode %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="accessmode" id="accessmode">
												<option value="0" selected> <%= displayAccessMode("0") %> </option>
												<option value="1"> <%= displayAccessMode("1") %> </option> 
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_config_gprs %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="configgprs" id="configgprs">
												<option value="0" selected> <%= displayConfigGPRS("0") %> </option>
												<option value="1"> <%= displayConfigGPRS("1") %> </option>
												<option value="2"> <%= displayConfigGPRS("2") %> </option>
												<option value="3"> <%= displayConfigGPRS("3") %> </option>
												<option value="4"> <%= displayConfigGPRS("4") %> </option>
											</select>
										</div>
									</div> 
								</div>
								
								<div class="row col-md-6" style="margin-top: 10px; margin-left: 20px; margin-right: 0px">
									<div class="row" style="margin-top: -10px; margin-left: -15px; margin-right: -26px;">
										<div class="bs-callout bs-callout-info"> 
											<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
												<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-edit" > </i> &nbsp; <b> Anti-Passback </b> </label>
											</div>
											<div class="row form-group" style="margin-top: 0px; margin-left: -10px; margin-right: -10px">
												<label class="control-label label-text-1 col-md-5"> <%= lb_status_io %> : </label>
												<div class="col-md-7">
													<select class="form-control selectpicker" name="status_io" id="status_io">
														<option value="I"> <%= displayStatusIO("I", lang) %> </option>
														<option value="O" selected> <%= displayStatusIO("O", lang) %> </option>
													</select>
												</div>
											</div>
											<div class="row form-group" style="margin-top: 0px; margin-left: -10px; margin-right: -10px">
												<label class="control-label label-text-1 col-md-5"> <%= lb_antilevel %> : </label>
												<div class="col-md-7">
													<select class="form-control selectpicker" name="level_no" id="level_no" onChange="loadPage();">
														<option value="0" selected> <%= lb_selectlevel %> </option>
														<option value="1"> 1 </option>
														<option value="2"> 2 </option>
														<option value="3"> 3 </option>
														<option value="4"> 4 </option>
														<option value="5"> 5 </option>
													</select>
												</div>
											</div>
											<div class="row form-group" style="margin-top: 0px; margin-bottom: 50px; margin-left: -10px; margin-right: -10px">
												<div class="col-md-12">
													<table class="table table-bordered">
														<tr>
															<td width="40%" class="pad-left-10"> <b> <%= lb_levelno %> </b> </td>
															<td width="12%" align="center"> <b> 1 </b> </td>
															<td width="12%" align="center"> <b> 2 </b> </td>
															<td width="12%" align="center"> <b> 3 </b> </td>
															<td width="12%" align="center"> <b> 4 </b> </td>
															<td width="12%" align="center"> <b> 5 </b> </td>
														</tr>
														<tr>
															<td class="pad-left-10"> <b> <%= lb_clearanti %> </b> </td>
															<td align="center"> <input type="checkbox" name="checkbox1" id="checkbox1" value="checkbox1"> </td>
															<td align="center"> <input type="checkbox" name="checkbox2" id="checkbox2" value="checkbox2"> </td>
															<td align="center"> <input type="checkbox" name="checkbox3" id="checkbox3" value="checkbox3"> </td>
															<td align="center"> <input type="checkbox" name="checkbox4" id="checkbox4" value="checkbox4"> </td>
															<td align="center"> <input type="checkbox" name="checkbox5" id="checkbox5" value="checkbox5"> </td>
														</tr>
													</table>
												</div>
											</div>
										</div>
									</div>
								</div> 
								<div class="row form-group" style="margin-bottom: 10px;"> &nbsp; </div>
							</div>
							
							<div class="tab-pane fade" id="2">
							
								<div class="row col-md-6" style="margin-top: 10px; margin-left: 0px; margin-right: -20px">
									<div class="row form-group" style="margin-top: 10px; margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_tshow_message %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="time_show_msg" id="time_show_msg">
									<%		String time_sm = "";
											for(int i = 1; i <= 9; i++){
												time_sm = Integer.toString(i);
									%>
												<option value="<%= time_sm %>" <%= checkDataSelected(time_sm, "5") %>> <%= time_sm %> </option>
									<%		}	%>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_ton_pic %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="time_onpic" id="time_onpic">
									<%		String time_onpic = "";
											for(int i = 0; i <= 999; i++){
												if(i < 10){ 
												time_onpic = "00" + i;										
											}else if(i < 100){
												time_onpic = "0" + i;
											}else{
												time_onpic = Integer.toString(i);
											}
									%>
												<option value="<%= time_onpic %>" <%= checkDataSelected(time_onpic, "010") %>> <%= time_onpic %> </option>
									<%		}	%>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_vdo_volume %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="vdo_volume" id="vdo_volume">
									<%		String vdo_volume = "";
											for(int i = 0; i <= 9; i++){
												vdo_volume = Integer.toString(i);
									%>
												<option value="<%= vdo_volume %>" <%= checkDataSelected(vdo_volume, "5") %>> <%= vdo_volume %> </option>
									<%		}	%>
											</select>
										</div>
									</div>  
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_scr_serv %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="scr_server" id="scr_server">
												<option value="0"> <%= lb_inactive %> </option>
												<option value="1" selected> <%= lb_active %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_camera %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="camera" id="camera">
												<option value="0"> <%= lb_inactive %> </option>
												<option value="1" selected> <%= lb_active %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_cap_preview %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="capt_preview" id="capt_preview">
												<option value="0"> <%= lb_inactive %> </option>
												<option value="1" selected> <%= lb_active %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_disable_taff %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="disable_taff" id="disable_taff">
												<option value="0" selected> <%= lb_inactive %> </option>
												<option value="1" > <%= lb_active %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_disable_mifare %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="disable_mifare" id="disable_mifare">
												<option value="0" selected> <%= lb_inactive %> </option>
												<option value="1" > <%= lb_active %> </option>
											</select>
										</div>
									</div> 
								</div>
								
								<div class="row col-md-6" style="margin-top: 10px; margin-left: 0px; margin-right: -20px">
									<div class="row form-group" style="margin-top: 10px; margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_rdenable %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="rd2enabled" id="rd2enabled">
												<option value="0" selected> <%= lb_rd2_0 %> </option>
												<option value="1"> <%= lb_rd2_1 %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_rd_duty %> : </label>
										<div class="col-md-6">
											<div class="form-group has-success has-feedback" id="textbox_rd2duty" style="margin-bottom: 0px">
												<input type="text" class="form-control" id="rd2duty" name="rd2duty" value="O" maxlength="1" placeholder="<%= lb_rd_duty %>" onKeyPress="IsValidCharacter()" style="text-transform: uppercase" onKeyUp="change_class('rd2duty');" onBlur="change_class('rd2duty');">
												<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_rd2duty" aria-hidden="true"> </span>
											</div>
										</div>
									</div>
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_timezone0_unlock %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="timezoneunlock" id="timezoneunlock">
												<option value="0" selected> <%= lb_not_opendoor %> </option>
												<option value="1"> <%= lb_opendoor %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_wtransloop %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="write_transloop" id="write_transloop">
												<option value="0" selected> <%= lb_wt_noloop %> </option>
												<option value="1"> <%= lb_wt_loop %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_card_antipassback %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="usecardantipassback" id="usecardantipassback">
												<option value="0" selected> <%= lb_notuse %> </option>
												<option value="1"> <%= lb_use %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_proximity %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="proximity" id="proximity">
												<option value="0" selected> <%= lb_prox0 %> </option>
												<option value="1"> <%= lb_prox1 %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_fingsecur %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker dropup" data-width="100%" data-size="10" name="finger_security" id="finger_security">
									<%		String finger_security = "";
											for(int i = 1; i <= 9; i++){
											finger_security = Integer.toString(i);
									%>
												<option value="<%= finger_security %>" <%= checkDataSelected(finger_security, "6") %>> <%= finger_security %> </option>
									<%		}	%>
											</select>
										</div>
									</div>  
								</div>
							</div>
						</div>
						<div class="row form-group" style="margin-bottom: 0px;">
							<div class="col-md-12" align="center">
								<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return ConfirmAddEdit('add', '<%= msg_confirmedit %>', '<%= msg_notinputdoor %>','<%= lb_duty %>', '<%= msg_input_time1 %>', '<%= msg_chk_mistaketime1 %>', '<%= msg_input_time2 %>', '<%= msg_chk_mistaketime2 %>', '<%= msg_input_time3 %>', '<%= msg_chk_mistaketime3 %>', '<%= msg_input_time4 %>', '<%= msg_chk_mistaketime4 %>', '<%= msg_input_time5 %>', '<%= msg_chk_mistaketime5 %>', '<%= msg_inputduty_rd2 %>');"> &nbsp; 
								<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_reader.jsp'">
							</div>
						</div> 
					
<% 
	}else if(action.equals("edit")){

		String reader_no = request.getParameter("reader_no");
		int no = 0; 		
		try{
		
			ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbreader WHERE (reader_no = '"+reader_no+"') ");
			if(rs.next()){
				String doorid = rs.getString("door_id");
				String reader_in = reader_no.substring(4, 5);
				String reader_type = rs.getString("reader_type");
				String reader_func = rs.getString("reader_func");
				String level_no = rs.getString("level_no");
				String clear_l1 = rs.getString("clear_l1");
				String clear_l2 = rs.getString("clear_l2");
				String clear_l3 = rs.getString("clear_l3");
				String clear_l4 = rs.getString("clear_l4");
				String clear_l5 = rs.getString("clear_l5");
				String display_bright = rs.getString("display_bright");
				String language = rs.getString("language");
				String finger_identify = rs.getString("finger_identify");
				String key_beep = rs.getString("key_beep");
				String write_oncard = rs.getString("write_oncard");
				String active_keypad = rs.getString("active_keypad");
				String active_keyduty = rs.getString("active_keyduty");
				String display_duty1 = rs.getString("display_duty1");
				String display_duty2 = rs.getString("display_duty2");
				String display_duty3 = rs.getString("display_duty3");
				String display_duty4 = rs.getString("display_duty4");
				String duty1_time1 = rs.getString("duty1_time1");
				String duty1_time2 = rs.getString("duty1_time2");
				String duty1_time3 = rs.getString("duty1_time3");
				String duty1_time4 = rs.getString("duty1_time4");
				String duty1_time5 = rs.getString("duty1_time5");
				String duty2_time1 = rs.getString("duty2_time1");
				String duty2_time2 = rs.getString("duty2_time2");
				String duty2_time3 = rs.getString("duty2_time3");
				String duty2_time4 = rs.getString("duty2_time4");
				String duty2_time5 = rs.getString("duty2_time5");
				String duty3_time1 = rs.getString("duty3_time1");
				String duty3_time2 = rs.getString("duty3_time2");
				String duty3_time3 = rs.getString("duty3_time3");
				String duty3_time4 = rs.getString("duty3_time4");
				String duty3_time5 = rs.getString("duty3_time5");
				String duty4_time1 = rs.getString("duty4_time1");
				String duty4_time2 = rs.getString("duty4_time2");
				String duty4_time3 = rs.getString("duty4_time3");
				String duty4_time4 = rs.getString("duty4_time4");
				String duty4_time5 = rs.getString("duty4_time5");
				String security = rs.getString("security_online");
				String time_sm = rs.getString("timeshowmess");
				String time_onpic = rs.getString("timeonpicture");
				String write_transloop = rs.getString("writetransloop");				
				String volume = rs.getString("volume");
				String timeoffdisplay = rs.getString("time_off_display");
				String configgprs = rs.getString("config_gprs");
				String alarmmode = rs.getString("alarm_mode");
				String accessmode = rs.getString("access_mode");			
				String color_normal = rs.getString("clock_color_normal");
				String color_unlock = rs.getString("clock_color_unlock");
				String color_alarm = rs.getString("clock_color_alarm");			
				String outoffservice = rs.getString("out_of_service");	
				String tzunlock = rs.getString("timezone0_unlock");	
				String usecardantipb = rs.getString("usecardantipassback");
				String proximity = rs.getString("prox_format");

				// CRU71
				String fing_secur = rs.getString("fing_security");
				String rd2enable = rs.getString("rd2mode");
				String rd2duty = rs.getString("rd2duty");
				String vdo_volume = rs.getString("vdo_volume");
				String scr_server = rs.getString("screen_server");
				String camera = rs.getString("camera");
				String capt_preview = rs.getString("capt_preview");
				String disabletaff = rs.getString("mifare_std");
				String disablemifare = rs.getString("mifare_uid");
				
				String status_io = rs.getString("status_io");
				
%>
	
						<ul class="nav nav-tabs">
							<li id="li_first" class="active" style="max-height: 28px;"> <a href="#1" style="max-height: 28px;" data-toggle="tab"> <div style="margin-top: -7px;"> &nbsp; <b><%= lb_reader%></b> &nbsp; </div> </a> </li>
							<li id="li_second" style="max-height: 28px;"> <a href="#2" style="max-height: 28px;" data-toggle="tab"> <div style="margin-top: -7px;"> &nbsp; <b><%= lb_add_config %></b> &nbsp; </div> </a> </li>
						</ul>
	 
						<div class="tab-content">
							<div class="tab-pane active" id="1">
								
						<%	try{	%>
						
								<div class="row form-group" style="margin-top: 20px">
									<label class="control-label label-text-1 col-md-3"> <%= lb_doorcode %> : </label>
									<div class="col-md-3">
										<div class="input-group has-success has-feedback" id="select_doorid">
											<select class="form-control selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" name="doorid" id="doorid" onChange="change_class('doorid'); checkdata();">
							<% 				
											String sql_door = "SELECT DISTINCT door_id, ";
											if(lang.equals("th")){
												sql_door = sql_door + "th_desc AS door_desc ";
											}else{
												sql_door = sql_door + "en_desc AS door_desc ";
											}
											sql_door += " FROM dbdoor ORDER BY door_id";
											ResultSet rs_door = stmtUp.executeQuery(sql_door);
											while(rs_door.next()){	
							%> 
												<option name="door_id" value="<%= rs_door.getString("door_id") %>" <%= checkDataSelected(rs_door.getString("door_id"), doorid) %>> <%= rs_door.getString("door_id") %> - <%= rs_door.getString("door_desc") %> </option>
							<%  			}
											rs_door.close();
							%>
											</select>
											<span class="input-group-addon" style="background-color: #ffffff;">
												<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_doorid" aria-hidden="true"> </span> &nbsp; &nbsp;
											</span>
										</div>
										<input type="hidden" name="doorid2" id="doorid2" class="form-control" readonly="readonly" value="<%= doorid %>">
									</div>
									<div class="col-md-6" style="margin-top: 6px;">
										<input type="radio" name="reader_in" value="1" id="radio1" onClick="checkdata()" <% if(reader_in.equals("1")){ out.println("checked"); } %>> &nbsp; <b> 1 </b> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
										<input type="radio" name="reader_in" value="2" id="radio2" onClick="checkdata()" <% if(reader_in.equals("2")){ out.println("checked"); } %>> &nbsp; <b> 2 </b>
									</div>
								</div> 
								
						<%	}catch(SQLException e){		
								out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
							}
						%>
				
								<div class="row form-group">
									<label class="control-label label-text-1 col-md-3"> <%= lb_readerno %> : </label>
									<div class="col-md-3">
										<input type="text" name="reader_no" id="reader_no" class="form-control" value="<%= reader_no %>" placeholder="<%= lb_readerno %>" readonly="readonly" style="background-color: #F0F0F0">
										<input type="hidden" name="reader_no2" id="reader_no2" class="form-control" readonly="readonly" value="<%= reader_no %>">
									</div>
									<div class="col-md-6 has-error" style="margin-top: 6px;"> <label class="control-label"> ( <%=  lb_rdauto %> ) </label> </div> 
								</div>
								<div class="row form-group">
									<label class="control-label label-text-1 col-md-3"> <%= lb_thdesc %> : </label>
									<div class="col-md-3">
										<input type="text" class="form-control" id="th_desc" name="th_desc" value="<%= rs.getString("th_desc") %>" maxlength="80" placeholder="<%= lb_thdesc %>">
									</div>
									<div class="col-md-6"> </div>
								</div> 
								<div class="row form-group">
									<label class="control-label label-text-1 col-md-3"> <%= lb_endesc %> : </label>
									<div class="col-md-3">
										<input type="text" class="form-control" id="en_desc" name="en_desc" value="<%= rs.getString("en_desc") %>" maxlength="80" placeholder="<%= lb_endesc %>" onKeyPress="IsValidCharacterEn2()">
									</div>
									<div class="col-md-6"> </div>
								</div> 
								<div class="row" style="margin-top: 5px; margin-left: 0px; margin-right: 0px">
									<div class="row col-md-6" style="margin-top: 0px; margin-left: 0px; margin-right: -20px">
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_readerfunc %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="reader_func" id="reader_func">
													<option value="0" <%= checkDataSelected(reader_func, "0") %>> Access </option>
													<option value="1" <%= checkDataSelected(reader_func, "1") %>> Time Attendance  </option>
													<option value="2" <%= checkDataSelected(reader_func, "2") %>> Safety  </option>
												</select>
											</div>	
										</div>										
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_security %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="security" id="security">
													<option value="0" <%= checkDataSelected(security, "0") %>> <%= lb_on %> </option>
													<option value="1" <%= checkDataSelected(security, "1") %>> <%= lb_off %> </option>
												</select>
											</div>	
										</div>										
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_language %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="language" id="language">
													<option value="0" <%= checkDataSelected(language, "0") %>> <%= lb_thai %> </option>
													<option value="1" <%= checkDataSelected(language, "1") %>> <%= lb_eng %> </option>
												</select>
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_displaybright %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="display_bright" id="display_bright">
										<%		String loop1;
												for(int i = 0; i <= 10; i++){
													if(i < 10) loop1 = "0" + i; else loop1 = Integer.toString(i);
										%>
													<option value="<%= loop1 %>" <%= checkDataSelected(display_bright, loop1) %>> <%= loop1 %> </option>
										<%		}	%>
												</select>
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_volume %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="volume" id="volume">
										<%		String loop_volume;
												for(int i = 0; i <= 10; i++){
													if(i < 10) loop_volume = "0" + i; else loop_volume = Integer.toString(i);
										%>
													<option value="<%= loop_volume %>" <%= checkDataSelected(volume, loop_volume) %>> <%= loop_volume %> </option>
										<%		}	%>
												</select>
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_time_off_display %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="timeoffdisplay" id="timeoffdisplay">
										<%		String loop_tod;
												for(int i = 0; i <= 99; i++){
													if(i < 10) loop_tod = "0" + i; else loop_tod = Integer.toString(i);
										%>
													<option value="<%= loop_tod %>" <%= checkDataSelected(timeoffdisplay, loop_tod) %>> <%= loop_tod %> </option>
										<%		}	%>
												</select>
											</div>
										</div>  
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_writecard %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="write_oncard" id="write_oncard">
													<option value="0" <%= checkDataSelected(write_oncard, "0") %>> <%= lb_inactive %> </option>
													<option value="1" <%= checkDataSelected(write_oncard, "1") %>> <%= lb_aftercheck %> </option>
													<option value="2" <%= checkDataSelected(write_oncard, "2") %>> <%= lb_beforecheck %> </option>
												</select>
											</div>
										</div> 
									</div> 
									
									<div class="row col-md-6" style="margin-top: 0px; margin-left: 0px; margin-right: -10px">
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_readertype %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="reader_type" id="reader_type">
													<option value="0" <%= checkDataSelected(reader_type, "0") %>> Standard </option>
													<option value="1" <%= checkDataSelected(reader_type, "1") %>> Finger  </option>
													<option value="2" <%= checkDataSelected(reader_type, "2") %>> Palm vein  </option>
												</select>
											</div>																					
										</div>	
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> &nbsp; </label>
											<div class="col-md-6">
												
											</div>	
										</div>	
										
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_actkeypad %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="keypad" id="keypad">
													<option value="0" <%= checkDataSelected(active_keypad, "0") %>> <%= lb_push_inact %> </option>
													<option value="1" <%= checkDataSelected(active_keypad, "1") %>> <%= lb_push_act %> </option>
													<option value="2" <%= checkDataSelected(active_keypad, "2") %>> <%= lb_push_key %> </option>
												</select>
												<input type="hidden" name="oldackpad" id="oldackpad" value="<%= active_keypad %>">
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_actkeyduty %> : </label>
											<div class="col-md-6">
												<select class="form-control selectpicker" data-width="100%" data-size="10" name="keyduty" id="keyduty">
													<option value="0" <%= checkDataSelected(active_keyduty, "0") %>> Active View Only </option>
													<option value="1" <%= checkDataSelected(active_keyduty, "1") %>> Active Duty & View </option>
													<option value="2" <%= checkDataSelected(active_keyduty, "2") %>> Inactive Duty & View </option>
													<option value="3" <%= checkDataSelected(active_keyduty, "3") %>> Active Duty Only </option>
												</select>
												<input type="hidden" name="oldackduty" id="oldackduty" value="<%= active_keyduty %>">
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_enablediden %> : </label>
											<div class="control-label col-md-6" style="margin-top: 6px;">
												<input type="checkbox" name="finger_iden" id="finger_iden" value="checkbox" <%= checkBoxAtPos(finger_identify, 0) %>> &nbsp; 
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_keybeep %> : </label>
											<div class="control-label col-md-6" style="margin-top: 6px;">
												<input type="checkbox" name="key_beep" id="key_beep" value="checkbox" <%= checkBoxAtPos(key_beep, 0) %>> &nbsp;
											</div>
										</div> 
										<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
											<label class="control-label label-text-1 col-md-6"> <%= lb_outoffservice %> : </label>
											<div class="control-label col-md-6" style="margin-top: 6px;">
												<input type="checkbox" name="outofservice" id="outofservice" value="checkbox" <%= checkBoxAtPos(outoffservice, 0) %>> &nbsp; 
											</div>
										</div>
									</div>
								</div>
                                
                                <div class="bs-callout bs-callout-info" style="margin-top: 0px; margin-right: -11px;"> 
                                    <div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
                                        <label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-time" > </i> &nbsp; <b> <%= lb_statustaff %> </b> </label>
                                    </div>
                                    <div class="table-responsive" style="border: 0px !important;" border="0">
                                        <div class="row" style="min-width: 1500px; margin-left: -10px; margin-right: -20px;">
                                            <div class="row" style="margin-left: -45px">
                                                <h5 class="modal-title col-xs-1 col-md-1"> </h5>
                                                <h5 class="modal-title col-xs-1 col-md-1" style="margin-left: -10px"> <div align="center"> <b> <%= lb_duty %> </b> </div> </h5>
                                                <h5 class="modal-title col-xs-2 col-md-2" style="margin-left: -15px"> <div align="center"> <b> <%= lb_timezone %> 1 </b> </div> </h5>
                                                <h5 class="modal-title col-xs-2 col-md-2" style="margin-left: -10px"> <div align="center"> <b> <%= lb_timezone %> 2 </b> </div> </h5>
                                                <h5 class="modal-title col-xs-2 col-md-2" style="margin-left: -10px"> <div align="center"> <b> <%= lb_timezone %> 3 </b> </div> </h5>
                                                <h5 class="modal-title col-xs-2 col-md-2" style="margin-left: -10px"> <div align="center"> <b> <%= lb_timezone %> 4 </b> </div> </h5>
                                                <h5 class="modal-title col-xs-2 col-md-2" style="margin-left: -10px"> <div align="center"> <b> <%= lb_timezone %> 5 </b> </div> </h5>
                                            </div>
                                            <div class="row" style="margin-left: 0px; margin-right: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 96%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
                                            <div class="row" style="margin-left: -25px">
                                                <h5 class="modal-title col-xs-1 col-md-1" style="margin-top: 6px;" align="right"> <b> IN &nbsp; </b> </h5>
                                                <div class="modal-title col-xs-1 col-md-1"> 
                                                    <input name="display_duty1" type="text" class="form-control" id="display_duty1" value="<%= display_duty1 %>" maxlength="1" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidCharacter()" onKeyDown="nextObject(window.event.keyCode, document.form1.hh111)">
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center" style="margin-left: -45px">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh111" type="text" class="form-control" id="hh111" value="<%= getTime(duty1_time1, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm111, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm111', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm111, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm111" type="text" class="form-control" id="mm111" value="<%= getTime(duty1_time1, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh112, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh112', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh112, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh112" type="text" class="form-control" id="hh112" value="<%= getTime(duty1_time1, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm112, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm112', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm112, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm112" type="text" class="form-control" id="mm112" value="<%= getTime(duty1_time1, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh121, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh121', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh121, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh121" type="text" class="form-control" id="hh121" value="<%= getTime(duty1_time2, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm121, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm121', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm121, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm121" type="text" class="form-control" id="mm121" value="<%= getTime(duty1_time2, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh122, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh122', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh122, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh122" type="text" class="form-control" id="hh122" value="<%= getTime(duty1_time2, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm122, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm122', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm122, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm122" type="text" class="form-control" id="mm122" value="<%= getTime(duty1_time2, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh131, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh131', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh131, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                      
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh131" type="text" class="form-control" id="hh131" value="<%= getTime(duty1_time3, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm131, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm131', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm131, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm131" type="text" class="form-control" id="mm131" value="<%= getTime(duty1_time3, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh132, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh132', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh132, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh132" type="text" class="form-control" id="hh132" value="<%= getTime(duty1_time3, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm132, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm132', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm132, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm132" type="text" class="form-control" id="mm132" value="<%= getTime(duty1_time3, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh141, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh141', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh141, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-3 col-md-1"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh141" type="text" class="form-control" id="hh141" value="<%= getTime(duty1_time4, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm141, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm141', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm141, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm141" type="text" class="form-control" id="mm141" value="<%= getTime(duty1_time4, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh142, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh142', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh142, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh142" type="text" class="form-control" id="hh142" value="<%= getTime(duty1_time4, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm142, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm142', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm142, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm142" type="text" class="form-control" id="mm142" value="<%= getTime(duty1_time4, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh151, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh151', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh151, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-3 col-md-1"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh151" type="text" class="form-control" id="hh151" value="<%= getTime(duty1_time5, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm151, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm151', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm151, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm151" type="text" class="form-control" id="mm151" value="<%= getTime(duty1_time5, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh152, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh152', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh152, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh152" type="text" class="form-control" id="hh152" value="<%= getTime(duty1_time5, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm152, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm152', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm152, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm152" type="text" class="form-control" id="mm152" value="<%= getTime(duty1_time5, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.display_duty2, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh211', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.display_duty2, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-3 col-md-1"> </div>                          
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row" style="margin-left: 0px; margin-right: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 96%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
                                            <div class="row" style="margin-left: -25px">
                                                <h5 class="modal-title col-xs-1 col-md-1" style="margin-top: 6px;" align="right"> <b> OUT &nbsp; </b> </h5>
                                                <div class="modal-title col-xs-1 col-md-1"> 
                                                    <input name="display_duty2" type="text" class="form-control" id="display_duty2" value="<%= display_duty2 %>" maxlength="1" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidCharacter()" onKeyDown="nextObject(window.event.keyCode, document.form1.hh211)">
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center" style="margin-left: -45px">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">                                                    
                                                            <input name="hh211" type="text" class="form-control" id="hh211" value="<%= getTime(duty2_time1, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm211, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm211', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm211, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm211" type="text" class="form-control" id="mm211" value="<%= getTime(duty2_time1, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh212, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh212', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh212, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh212" type="text" class="form-control" id="hh212" value="<%= getTime(duty2_time1, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm212, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm212', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm212, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm212" type="text" class="form-control" id="mm212" value="<%= getTime(duty2_time1, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh221, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh221', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh221, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh221" type="text" class="form-control" id="hh221" value="<%= getTime(duty2_time2, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm221, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm221', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm221, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm221" type="text" class="form-control" id="mm221" value="<%= getTime(duty2_time2, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh222, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh222', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh222, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh222" type="text" class="form-control" id="hh222" value="<%= getTime(duty2_time2, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm222, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm222', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm222, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm222" type="text" class="form-control" id="mm222" value="<%= getTime(duty2_time2, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh231, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh231', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh231, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh231" type="text" class="form-control" id="hh231" value="<%= getTime(duty2_time3, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm231, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm231', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm231, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm231" type="text" class="form-control" id="mm231" value="<%= getTime(duty2_time3, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh232, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh232', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh232, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh232" type="text" class="form-control" id="hh232" value="<%= getTime(duty2_time3, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm232, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm232', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm232, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm232" type="text" class="form-control" id="mm232" value="<%= getTime(duty2_time3, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh241, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh241', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh241, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh241" type="text" class="form-control" id="hh241" value="<%= getTime(duty2_time4, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm241, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm241', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm241, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm241" type="text" class="form-control" id="mm241" value="<%= getTime(duty2_time4, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh242, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh242', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh242, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh242" type="text" class="form-control" id="hh242" value="<%= getTime(duty2_time4, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm242, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm242', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm242, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm242" type="text" class="form-control" id="mm242" value="<%= getTime(duty2_time4, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh251, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh251', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh251, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh251" type="text" class="form-control" id="hh251" value="<%= getTime(duty2_time5, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm251, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm251', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm251, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm251" type="text" class="form-control" id="mm251" value="<%= getTime(duty2_time5, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh252, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh252', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh252, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh252" type="text" class="form-control" id="hh252" value="<%= getTime(duty2_time5, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm252, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm252', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm252, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm252" type="text" class="form-control" id="mm252" value="<%= getTime(duty2_time5, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.display_duty3, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh311', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.display_duty3, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row" style="margin-left: 0px; margin-right: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 96%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
                                            <div class="row" style="margin-left: -25px">
                                                <h5 class="modal-title col-xs-1 col-md-1" style="margin-top: 6px;" align="right"> <b> OT IN &nbsp; </b> </h5>
                                                <div class="modal-title col-xs-1 col-md-1"> 
                                                    <input name="display_duty3" type="text" class="form-control" id="display_duty3" value="<%= display_duty3 %>" maxlength="1" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidCharacter()" onKeyDown="nextObject(window.event.keyCode, document.form1.hh311)">
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center" style="margin-left: -45px">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">                                                    
                                                            <input name="hh311" type="text" class="form-control" id="hh311" value="<%= getTime(duty3_time1, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm311, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm311', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm311, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm311" type="text" class="form-control" id="mm311" value="<%= getTime(duty3_time1, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh312, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh312', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh312, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh312" type="text" class="form-control" id="hh312" value="<%= getTime(duty3_time1, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm312, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm312', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm312, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm312" type="text" class="form-control" id="mm312" value="<%= getTime(duty3_time1, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh321, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh321', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh321, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh321" type="text" class="form-control" id="hh321" value="<%= getTime(duty3_time2, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm321, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm321', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm321, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm321" type="text" class="form-control" id="mm321" value="<%= getTime(duty3_time2, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh322, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh322', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh322, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh322" type="text" class="form-control" id="hh322" value="<%= getTime(duty3_time2, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm322, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm322', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm322, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm322" type="text" class="form-control" id="mm322" value="<%= getTime(duty3_time2, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh331, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh331', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh331, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh331" type="text" class="form-control" id="hh331" value="<%= getTime(duty3_time3, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm331, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm331', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm331, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm331" type="text" class="form-control" id="mm331" value="<%= getTime(duty3_time3, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh332, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh332', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh332, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh332" type="text" class="form-control" id="hh332" value="<%= getTime(duty3_time3, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm332, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm332', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm332, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm332" type="text" class="form-control" id="mm332" value="<%= getTime(duty3_time3, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh341, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh341', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh341, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh341" type="text" class="form-control" id="hh341" value="<%= getTime(duty3_time4, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm341, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm341', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm341, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm341" type="text" class="form-control" id="mm341" value="<%= getTime(duty3_time4, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh342, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh342', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh342, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh342" type="text" class="form-control" id="hh342" value="<%= getTime(duty3_time4, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm342, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm342', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm342, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm342" type="text" class="form-control" id="mm342" value="<%= getTime(duty3_time4, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh351, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh351', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh351, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh351" type="text" class="form-control" id="hh351" value="<%= getTime(duty3_time5, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm351, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm351', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm351, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm351" type="text" class="form-control" id="mm351" value="<%= getTime(duty3_time5, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh352, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh352', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh352, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh352" type="text" class="form-control" id="hh352" value="<%= getTime(duty3_time5, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm352, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm352', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm352, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm352" type="text" class="form-control" id="mm352" value="<%= getTime(duty3_time5, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.display_duty4, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh411', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.display_duty4, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row" style="margin-left: 0px; margin-right: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 96%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
                                            <div class="row" style="margin-left: -25px">
                                                <h5 class="modal-title col-xs-1 col-md-1" style="margin-top: 6px;" align="right"> <b>OT OUT &nbsp; </b> </h5>
                                                <div class="modal-title col-xs-1 col-md-1"> 
                                                    <input name="display_duty4" type="text" class="form-control" id="display_duty4" value="<%= display_duty4 %>" maxlength="1" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidCharacter()" onKeyDown="nextObject(window.event.keyCode, document.form1.hh411)">
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center" style="margin-left: -45px">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">                                                    
                                                            <input name="hh411" type="text" class="form-control" id="hh411" value="<%= getTime(duty4_time1, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm411, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm411', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm411, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm411" type="text" class="form-control" id="mm411" value="<%= getTime(duty4_time1, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh412, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh412', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh412, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh412" type="text" class="form-control" id="hh412" value="<%= getTime(duty4_time1, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm412, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm412', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm412, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm412" type="text" class="form-control" id="mm412" value="<%= getTime(duty4_time1, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh421, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh421', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh421, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh421" type="text" class="form-control" id="hh421" value="<%= getTime(duty4_time2, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm421, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm421', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm421, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm421" type="text" class="form-control" id="mm421" value="<%= getTime(duty4_time2, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh422, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh422', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh422, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh422" type="text" class="form-control" id="hh422" value="<%= getTime(duty4_time2, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm422, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm422', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm422, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm422" type="text" class="form-control" id="mm422" value="<%= getTime(duty4_time2, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh431, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh431', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh431, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh431" type="text" class="form-control" id="hh431" value="<%= getTime(duty4_time3, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm431, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm431', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm431, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm431" type="text" class="form-control" id="mm431" value="<%= getTime(duty4_time3, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh432, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh432', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh432, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh432" type="text" class="form-control" id="hh432" value="<%= getTime(duty4_time3, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm432, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm432', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm432, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm432" type="text" class="form-control" id="mm432" value="<%= getTime(duty4_time3, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh441, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh441', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh441, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh441" type="text" class="form-control" id="hh441" value="<%= getTime(duty4_time4, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm441, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm441', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm441, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm441" type="text" class="form-control" id="mm441" value="<%= getTime(duty4_time4, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh442, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh442', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh442, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh442" type="text" class="form-control" id="hh442" value="<%= getTime(duty4_time4, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm442, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm442', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm442, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm442" type="text" class="form-control" id="mm442" value="<%= getTime(duty4_time4, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh451, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh451', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh451, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>                          
                                                    </div>
                                                </div>
                                                <div class="modal-title col-xs-2 col-md-2" align="center">
                                                    <div class="row form-inline">
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh451" type="text" class="form-control" id="hh451" value="<%= getTime(duty4_time5, 1) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm451, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm451', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm451, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm451" type="text" class="form-control" id="mm451" value="<%= getTime(duty4_time5, 2) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh452, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh452', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.hh452, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> - </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="hh452" type="text" class="form-control" id="hh452" value="<%= getTime(duty4_time5, 3) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm452, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm452', event)" onBlur="set_pluszero(this); return checkHour(this, document.form1.mm452, '<%= msg_input_hour %>');">
                                                        </div>
                                                        <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -20px; margin-top: 6px;"> : </label>
                                                        <div class="col-xs-1 col-md-1">
                                                            <input name="mm452" type="text" class="form-control" id="mm452" value="<%= getTime(duty4_time5, 4) %>" maxlength="2" style="min-width: 45px; max-width: 45px;" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.display_duty1, '<%= msg_input_minute %>'); autofocus(this, 2, 'hh111', event)" onBlur="set_pluszero(this); return checkMinute(this, document.form1.display_duty1, '<%= msg_input_minute %>');">
                                                        </div>
                                                        <div class="col-xs-5 col-md-5"> </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
							
								<div class="row col-md-6" style="margin-top: 10px; margin-left: 0px; margin-right: -20px">
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_clock_color %> (<%= lb_normal %>) : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="color_normal" id="color_normal">
												<option value="0" <%= checkDataSelected(color_normal, "0") %>> <%= displayColorStr("0", lang) %> </option>
												<option value="1" <%= checkDataSelected(color_normal, "1") %>> <%= displayColorStr("1", lang) %> </option> 
												<option value="2" <%= checkDataSelected(color_normal, "2") %>> <%= displayColorStr("2", lang) %> </option> 
												<option value="3" <%= checkDataSelected(color_normal, "3") %>> <%= displayColorStr("3", lang) %> </option> 
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_clock_color %> (<%= lb_rdunlock %>) : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="color_unlock" id="color_unlock">
												<option value="0" <%= checkDataSelected(color_unlock, "0") %>> <%= displayColorStr("0", lang) %> </option>
												<option value="1" <%= checkDataSelected(color_unlock, "1") %>> <%= displayColorStr("1", lang) %> </option> 
												<option value="2" <%= checkDataSelected(color_unlock, "2") %>> <%= displayColorStr("2", lang) %> </option> 
												<option value="3" <%= checkDataSelected(color_unlock, "3") %>> <%= displayColorStr("3", lang) %> </option> 
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_clock_color %> (<%= lb_alarm %>) : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="color_alarm" id="color_alarm">
												<option value="0" <%= checkDataSelected(color_alarm, "0") %>> <%= displayColorStr("0", lang) %> </option>
												<option value="1" <%= checkDataSelected(color_alarm, "1") %>> <%= displayColorStr("1", lang) %> </option> 
												<option value="2" <%= checkDataSelected(color_alarm, "2") %>> <%= displayColorStr("2", lang) %> </option> 
												<option value="3" <%= checkDataSelected(color_alarm, "3") %>> <%= displayColorStr("3", lang) %> </option> 
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_alarm_mode %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="alarmmode" id="alarmmode">
												<option value="0" <%= checkDataSelected(alarmmode, "0") %>> <%= displayAlarmMode("0") %> </option>
												<option value="1" <%= checkDataSelected(alarmmode, "1") %>> <%= displayAlarmMode("1") %> </option> 
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_access_mode %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="accessmode" id="accessmode">
												<option value="0" <%= checkDataSelected(accessmode, "0") %>> <%= displayAccessMode("0") %> </option>
												<option value="1" <%= checkDataSelected(accessmode, "1") %>> <%= displayAccessMode("1") %> </option> 
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_config_gprs %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="configgprs" id="configgprs">
												<option value="0" <%= checkDataSelected(configgprs, "0") %>> <%= displayConfigGPRS("0") %> </option>
												<option value="1" <%= checkDataSelected(configgprs, "1") %>> <%= displayConfigGPRS("1") %> </option>
												<option value="2" <%= checkDataSelected(configgprs, "2") %>> <%= displayConfigGPRS("2") %> </option>
												<option value="3" <%= checkDataSelected(configgprs, "3") %>> <%= displayConfigGPRS("3") %> </option>
												<option value="4" <%= checkDataSelected(configgprs, "4") %>> <%= displayConfigGPRS("4") %> </option>
											</select>
										</div>
									</div> 
                                </div>
								
								<div class="row col-md-6" style="margin-top: 10px; margin-left: 20px; margin-right: 0px">
									<div class="row" style="margin-top: -10px; margin-left: -15px; margin-right: -26px;">
										<div class="bs-callout bs-callout-info"> 
											<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
												<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-edit" > </i> &nbsp; <b> Anti-Passback </b> </label>
											</div>
											<div class="row form-group" style="margin-top: 0px; margin-left: -10px; margin-right: -10px">
												<label class="control-label label-text-1 col-md-5"> <%= lb_status_io %> : </label>
												<div class="col-md-7">
													<select class="form-control selectpicker" name="status_io" id="status_io">
														<option value="I" <%= checkDataSelected(status_io, "I") %>> <%= displayStatusIO("I", lang) %> </option>
														<option value="O" <%= checkDataSelected(status_io, "O") %>> <%= displayStatusIO("O", lang) %> </option>
													</select>
												</div>
											</div>
											<div class="row form-group" style="margin-top: 0px; margin-left: -10px; margin-right: -10px">
												<label class="control-label label-text-1 col-md-5"> <%= lb_antilevel %> : </label>
												<div class="col-md-7">
													<select class="form-control selectpicker" name="level_no" id="level_no" onChange="loadPage();">
														<option value="0" <%= checkDataSelected(level_no, "0") %>> <%= lb_selectlevel %> </option>
														<option value="1" <%= checkDataSelected(level_no, "1") %>> 1 </option>
														<option value="2" <%= checkDataSelected(level_no, "2") %>> 2 </option>
														<option value="3" <%= checkDataSelected(level_no, "3") %>> 3 </option>
														<option value="4" <%= checkDataSelected(level_no, "4") %>> 4 </option>
														<option value="5" <%= checkDataSelected(level_no, "5") %>> 5 </option>
													</select>
													</select>
												</div>
											</div>
											<div class="row form-group" style="margin-top: 0px; margin-bottom: 50px; margin-left: -10px; margin-right: -10px">
												<div class="col-md-12">
													<table class="table table-bordered">
														<tr>
															<td width="40%" class="pad-left-10"> <b> <%= lb_levelno %> </b> </td>
															<td width="12%" align="center"> <b> 1 </b> </td>
															<td width="12%" align="center"> <b> 2 </b> </td>
															<td width="12%" align="center"> <b> 3 </b> </td>
															<td width="12%" align="center"> <b> 4 </b> </td>
															<td width="12%" align="center"> <b> 5 </b> </td>
														</tr>
														<tr>
															<td class="pad-left-10"> <b> <%= lb_clearanti %> </b> </td>
															<td align="center"> <input type="checkbox" name="checkbox1" id="checkbox1" value="checkbox1" <%= checkBoxAtPos(clear_l1, 0) %>> </td>
															<td align="center"> <input type="checkbox" name="checkbox2" id="checkbox2" value="checkbox2" <%= checkBoxAtPos(clear_l2, 0) %>> </td>
															<td align="center"> <input type="checkbox" name="checkbox3" id="checkbox3" value="checkbox3" <%= checkBoxAtPos(clear_l3, 0) %>> </td>
															<td align="center"> <input type="checkbox" name="checkbox4" id="checkbox4" value="checkbox4" <%= checkBoxAtPos(clear_l4, 0) %>> </td>
															<td align="center"> <input type="checkbox" name="checkbox5" id="checkbox5" value="checkbox5" <%= checkBoxAtPos(clear_l5, 0) %>> </td>
														</tr>
													</table>
												</div>
											</div>
										</div>
									</div>
								</div> 
								<div class="row form-group" style="margin-bottom: 10px;"> &nbsp; </div>
							</div>
							
							<div class="tab-pane fade" id="2">
							
								<div class="row col-md-6" style="margin-top: 10px; margin-left: 0px; margin-right: -20px">
									<div class="row form-group" style="margin-top: 10px; margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_tshow_message %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="time_show_msg" id="time_show_msg">
									<%		String timesm = "";
											for(int i = 1; i <= 9; i++){
												timesm = Integer.toString(i);
									%>
												<option value="<%= timesm %>" <%= checkDataSelected(time_sm, timesm) %>> <%= timesm %> </option>
									<%		}	%>
											</select>
											<input type="hidden" name="oldtime_show_msg" id="oldtime_show_msg" value="<%= time_sm %>">
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_ton_pic %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="time_onpic" id="time_onpic">
									<%		String timeonpic = "";
											for(int i = 0; i <= 999; i++){
												if(i < 10){ 
												timeonpic = "00" + i;										
											}else if(i < 100){
												timeonpic = "0" + i;
											}else{
												timeonpic = Integer.toString(i);
											}
									%>
												<option value="<%= timeonpic %>" <%= checkDataSelected(time_onpic, timeonpic) %>> <%= timeonpic %> </option>
									<%		}	%>
											</select>
											<input type="hidden" name="oldtonpic" id="oldtonpic" value="<%=time_onpic%>"> 
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_vdo_volume %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="vdo_volume" id="vdo_volume">
									<%		String vdovolume = "";
											for(int i = 0; i <= 9; i++){
												vdovolume = Integer.toString(i);
									%>
												<option value="<%= vdovolume %>" <%= checkDataSelected(vdo_volume, vdovolume) %>> <%= vdovolume %> </option>
									<%		}	%>
											</select>
										</div>
									</div>
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_scr_serv %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="scr_server" id="scr_server">
												<option value="0" <%= checkDataSelected(scr_server, "0") %>> <%= lb_inactive %> </option>
												<option value="1" <%= checkDataSelected(scr_server, "1") %>> <%= lb_active %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_camera %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="camera" id="camera">
												<option value="0" <%= checkDataSelected(camera, "0") %>> <%= lb_inactive %> </option>
												<option value="1" <%= checkDataSelected(camera, "1") %>> <%= lb_active %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_cap_preview %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="capt_preview" id="capt_preview">
												<option value="0" <%= checkDataSelected(capt_preview, "0") %>> <%= lb_inactive %> </option>
												<option value="1" <%= checkDataSelected(capt_preview, "1") %>> <%= lb_active %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_disable_taff %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="disable_taff" id="disable_taff">
												<option value="0" <%= checkDataSelected(disabletaff, "0") %>> <%= lb_inactive %> </option>
												<option value="1" <%= checkDataSelected(disabletaff, "1") %>> <%= lb_active %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_disable_mifare %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="disable_mifare" id="disable_mifare">
												<option value="0" <%= checkDataSelected(disablemifare, "0") %>> <%= lb_inactive %> </option>
												<option value="1" <%= checkDataSelected(disablemifare, "1") %>> <%= lb_active %> </option>
											</select>
										</div>
									</div> 
								</div>
								
								<div class="row col-md-6" style="margin-top: 10px; margin-left: 0px; margin-right: -20px">
									<div class="row form-group" style="margin-top: 10px; margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_rdenable %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="rd2enabled" id="rd2enabled">
												<option value="0" <%= checkDataSelected(rd2enable, "0") %>> <%= lb_rd2_0 %> </option>
												<option value="1" <%= checkDataSelected(rd2enable, "1") %>> <%= lb_rd2_1 %> </option>
											</select>
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_rd_duty %> : </label>
										<div class="col-md-6">
											<div class="form-group has-success has-feedback" id="textbox_rd2duty" style="margin-bottom: 0px">
												<input type="text" class="form-control" id="rd2duty" name="rd2duty" value="<%= rd2duty %>" maxlength="1" placeholder="<%= lb_rd_duty %>" onKeyPress="IsValidCharacter()" style="text-transform: uppercase" onKeyUp="change_class('rd2duty');" onBlur="change_class('rd2duty');">
												<span class="glyphicon glyphicon-ok form-control-feedback" id="icon_rd2duty" aria-hidden="true"> </span>
											</div>
										</div>
									</div>
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_timezone0_unlock %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="timezoneunlock" id="timezoneunlock">
												<option value="0" <%= checkDataSelected(tzunlock, "0") %>> <%= lb_not_opendoor %> </option>
												<option value="1" <%= checkDataSelected(tzunlock, "1") %>> <%= lb_opendoor %> </option>
											</select>
											<input type="hidden" name="oldtzunlock" id="oldtzunlock" value="<%= tzunlock %>">
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_wtransloop %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="write_transloop" id="write_transloop">
												<option value="0" <%= checkDataSelected(write_transloop, "0") %>> <%= lb_wt_noloop %> </option>
												<option value="1" <%= checkDataSelected(write_transloop, "1") %>> <%= lb_wt_loop %> </option>
											</select>
											<input type="hidden" name="oldwtsloop" id="oldwtsloop" value="<%= write_transloop %>">
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_card_antipassback %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="usecardantipassback" id="usecardantipassback">
												<option value="0" <%= checkDataSelected(usecardantipb, "0") %>> <%= lb_notuse %> </option>
												<option value="1" <%= checkDataSelected(usecardantipb, "1") %>> <%= lb_use %> </option>
											</select>
											<input type="hidden" name="oldusecardantipb" id="oldusecardantipb" value="<%= usecardantipb %>"> 
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_proximity %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="proximity" id="proximity">
												<option value="0" <%= checkDataSelected(proximity, "0") %>> <%= lb_prox0 %> </option>
												<option value="1" <%= checkDataSelected(proximity, "1") %>> <%= lb_prox1 %> </option>
											</select>
											<input type="hidden" name="oldproximity" id="oldproximity" value="<%= proximity %>">  
										</div>
									</div> 
									<div class="row form-group" style="margin-left: -30px; margin-right: -10px">
										<label class="control-label label-text-1 col-md-6"> <%= lb_fingsecur %> : </label>
										<div class="col-md-6">
											<select class="form-control selectpicker" data-width="100%" data-size="10" name="finger_security" id="finger_security">
									<%		String fingsecur = "";
											for(int i = 1; i <= 9; i++){
												fingsecur = Integer.toString(i);
									%>
												<option value="<%= fingsecur %>" <%= checkDataSelected(fing_secur, fingsecur) %>> <%= fingsecur %> </option>
									<%		}	%>
											</select>
										</div>
									</div> 
								</div> 
							</div>
						</div>
						<div class="row form-group" style="margin-bottom: 0px;">
							<div class="col-md-12" align="center"> 
								<input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="return ConfirmAddEdit('edit', '<%= msg_confirmedit %>', '<%= msg_notinputdoor %>', '<%= lb_duty %>', '<%= msg_input_time1 %>', '<%= msg_chk_mistaketime1 %>', '<%= msg_input_time2 %>', '<%= msg_chk_mistaketime2 %>', '<%= msg_input_time3 %>', '<%= msg_chk_mistaketime3 %>', '<%= msg_input_time4 %>', '<%= msg_chk_mistaketime4 %>', '<%= msg_input_time5 %>', '<%= msg_chk_mistaketime5 %>', '<%= msg_inputduty_rd2 %>');"> &nbsp; 
								<input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_reader.jsp'">
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
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_warning2" onClick="javascript: location.href = 'data_reader.jsp';" style="width: 100%; display: none;"> <%= btn_ok %> </button>
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
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_reader.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
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
		
		<%	}	%>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>