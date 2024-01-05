<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			.bs-callout-info {
				border-left-color: #1b809e;
			}
			.bs-callout {
				padding: 10px;
				margin: 10px 0;
				border: 1px solid #1b809e;
				border-left-width: 5px;
				border-radius: 3px;
			}
		</style>
		
		<script language="javascript">
		
		</script>
	</head>
	
		<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
<% 
	String action = request.getParameter("action");
	if(action.equals("view")){
		String event_code = request.getParameter("event_code");
		String th_msg = "", en_msg = "", event_act = "", software_act = "";
		String email1 = "", email2 = "", email3 = "", email4 = "", email5 = "";
		String phone1 = "", phone2 = "", phone3 = "", phone4 = "", phone5 = "";
	
		String col1 = "col-xs-4 col-md-4";
		String col2 = "col-xs-8 col-md-8";
		String col_line = "col-xs-12";
		String set_hr = " <div class='row'> <hr class='"+col_line+"' style='height: 6px; margin-top: 8px; margin-bottom: 4px;' /> </div> ";
		
		try{
			ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbevent WHERE (event_code = '"+event_code+"') ");
			if(rs.next()){
				event_act = rs.getString("event_act");
				software_act =  rs.getString("software_act");	
				
				if(rs.getString("th_msg").equals("null")){
					th_msg = "&nbsp;";
				}else{
					th_msg = rs.getString("th_msg");
				}
				if(rs.getString("en_msg").equals("null")){
					en_msg = "&nbsp;";
				}else{
					en_msg = rs.getString("en_msg");
				}
				
				if(rs.getString("email1").equals("null")){
					email1 = "&nbsp;";
				}else{
					email1 = rs.getString("email1");
				}
				if(rs.getString("email2").equals("null")){
					email2 = "&nbsp;";
				}else{
					email2 = rs.getString("email2");
				}
				if(rs.getString("email3").equals("null")){
					email3 = "&nbsp;";
				}else{
					email3 = rs.getString("email3");
				}
				if(rs.getString("email4").equals("null")){
					email4 = "&nbsp;";
				}else{
					email4 = rs.getString("email4");
				}
				if(rs.getString("email5").equals("null")){
					email5 = "&nbsp;";
				}else{
					email5 = rs.getString("email5");
				}			
%>
		<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto;">
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_eventcode %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= event_code %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_thdesc %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= rs.getString("th_desc") %> </h5>
			</div>
			<%= set_hr %>
			<div class="row">
				<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_endesc %> : </b> </div> </h5>
				<h5 class="modal-title <%= col2 %>" > <%= rs.getString("en_desc") %> </h5>
			</div>			
			<div class="row" style="margin-bottom: -10px;"> &nbsp; </div>	
			<div class="row" style="overflow-y: hidden;">			
				<div class="col-xs-6 col-md-6" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-th-list" > </i> &nbsp; <b> HardWare Action </b> </label>
						</div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 1 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(event_act, 0) %> UnLock (Out1) </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 2 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(event_act, 1) %> Alarm (Out2) </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 3 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(event_act, 2) %> Bell (Out3) </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 4 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(event_act, 3) %> - (Out4) </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 5 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(event_act, 4) %> Write Transaction </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 6 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(event_act, 5) %> All Lock </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 7 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(event_act, 6) %> All UnLock </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 8 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(event_act, 7) %> All Alarm </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> HW 9 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(event_act, 8) %> Capture </b> </h5>
						</div>
					</div>
				</div>			
				<div class="col-xs-6 col-md-6" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-th-list" > </i> &nbsp; <b> Software Action </b> </label>
						</div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 1 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(software_act, 0) %> Show Message </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-5 col-md-5" > <div align="right"> <b> <%= lb_thai %> : </b> </div> </h5>
							<h5 class="modal-title col-xs-7 col-md-7" > <b> <%= th_msg %> </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-5 col-md-5" > <div align="right"> <b> <%= lb_eng %> : </b> </div> </h5>
							<h5 class="modal-title col-xs-7 col-md-7" > <b> <%= en_msg %> </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 2 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(software_act, 1) %> Sound Alert </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 3 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(software_act, 2) %> Print </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 4 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(software_act, 3) %> Send Email </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-5 col-md-5" > <div align="right"> <b> <%= lb_email %> 1 : </b> </div> </h5>
							<h5 class="modal-title col-xs-7 col-md-7" > <b> <%= email1 %> </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-5 col-md-5" > <div align="right"> <b> <%= lb_email %> 2 : </b> </div> </h5>
							<h5 class="modal-title col-xs-7 col-md-7" > <b> <%= email2 %> </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-5 col-md-5" > <div align="right"> <b> <%= lb_email %> 3 : </b> </div> </h5>
							<h5 class="modal-title col-xs-7 col-md-7" > <b> <%= email3 %> </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-5 col-md-5" > <div align="right"> <b> <%= lb_email %> 4 : </b> </div> </h5>
							<h5 class="modal-title col-xs-7 col-md-7" > <b> <%= email4 %> </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <span class="modal-title col-xs-12 col-md-12" style="height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </span> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title col-xs-5 col-md-5" > <div align="right"> <b> <%= lb_email %> 5 : </b> </div> </h5>
							<h5 class="modal-title col-xs-7 col-md-7" > <b> <%= email5 %> </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 5 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(software_act, 4) %> Send SMS </b> </h5>
						</div>
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 6 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(software_act, 5) %> Write Transaction </b> </h5>
						</div> 
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 7 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(software_act, 6) %> Send TCP/IP Socket </b> </h5>
						</div> 
						<div class="row" style="margin-left: 0px"> <div align="center"> <hr class="modal-title col-xs-12 col-md-12" style="width: 85%; height: 6px; margin-top: 8px; margin-bottom: 4px;" /> </div> </div>
						<div class="row" style="margin-left: -25px">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> SW 8 </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <b> <%= checkImgAtPos(software_act, 7) %> Send API 3rd Party </b> </h5>
						</div> 
					</div> 
					<div class="row"> &nbsp; </div>
				</div> 				
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
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>