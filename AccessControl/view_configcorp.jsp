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
	session.setAttribute("action", "view_configcorp.jsp?");
	session.setAttribute("act", "");
	
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
<span/>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
		<div class="body-display">
			<div class="container">
		
		<%	
			String cardPattern = "", displayDigit = "", saveDigit = "", duplicate_time = "", start_digit = "", issue_digit = "";
			String master_card1 = "", master_card2 = "", master_card3 = "", master_card4 = "", master_card5 = "", customer_code = "";
			String key_card = "", modulef = "", key_card2 = "", block_id = "";
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
					if(!(key_card2.equals(""))){
						key_card = "************";
					}
					block_id = rs.getString("block_id");
				
					if(rs.getString("block_id").equals("-1")){
						block_id = lb_none;
					}
					
					if(rs.getInt("moduleF")== 0){
						modulef = "Suprema";
					}else{
						modulef = "SecuGen";
					}				
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
												<%	for(int i = 1; i <= 16; i++){	%>
												<td width="5%" align="center"> <%= i %> </td>
												<%	}	%>
											</tr>
											<tr>
												<td> <label class="control-label"> <%= lb_cardpattern %> </label> </td>
												<%	for(int i=0; i <= 15; i++){	%>
												<td align="center"><%= subStringCharAt(cardPattern, i) %> </td>
												<%	}	%>
											</tr>
											<tr>
												<td> <label class="control-label"> <%= lb_disdigit %> </label> </td>
												<%	for(int i=0; i <= 15; i++){	%>
												<td align="center"> <%= checkImgAtPosY(displayDigit, i) %> </td>
												<%	}	%>												
											</tr>
											<tr>
												<td> <label class="control-label"> <%= lb_savedigit %> </label> </td>
												<%	for(int i=0; i <= 15; i++){	%>
												<td align="center"> <%= checkImgAtPosY(saveDigit, i) %> </td>
												<%	}	%>												
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
								<label class="control-label col-md-6" style="margin-top: 6px;"> <% if((customer_code)==(null)){ out.print(""); }else{ out.print(customer_code); } %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_mastercard %> 1 : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <% if((master_card1)==(null)){ out.print(""); }else{ out.print(master_card1); } %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_mastercard %> 2 : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <% if((master_card2)==(null)){ out.print(""); }else{ out.print(master_card2); } %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_mastercard %> 3 : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <% if((master_card3)==(null)){ out.print(""); }else{ out.print(master_card3); } %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_mastercard %> 4 : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <% if((master_card4)==(null)){ out.print(""); }else{ out.print(master_card4); } %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_mastercard %> 5 : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <% if((master_card5)==(null)){ out.print(""); }else{ out.print(master_card5); } %> </label>
							</div>
						</div>
						<div class="row col-md-6">
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_stdigit %> : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= start_digit %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_issuedigit %> : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= issue_digit %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_duplicatetime %> : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= duplicate_time %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <div style="margin-left: -5px;"> <%= lb_block_id %> : </div> </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= block_id %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_key_card2 %> : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= key_card %> </label>
							</div>
							<div class="row form-group">
								<label class="control-label label-text-1 col-md-6"> <%= lb_modulef %> : </label>
								<label class="control-label col-md-6" style="margin-top: 6px;"> <%= modulef %> </label>
							</div>
						</div>
						
					<%	if(ses_per == 0){	%>
						<div class="row form-group" style="margin-bottom: 5px;">
							<center>
								<input name="Submit2" type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_edit %> &nbsp; &nbsp; &nbsp; " onClick="location.href='edit_configcorp.jsp'"> &nbsp; 
								
							</center>
						</div>
					<%	}	%>
						
					</div>
				</div>
		<%	
				}
				rs.close();
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
		%>
		
		<%@ include file="tools/modal_result.jsp"%>
		
		<script>
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				$('body').addClass('loaded');
				
				<%	if(!text_result.equals("")){	%>
				$('#myModalResult').modal('show');
				setTimeout(function(){
					$('#myModalResult').modal('hide');
				}, 3000);
				<%	}	%>
			}
		}
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>