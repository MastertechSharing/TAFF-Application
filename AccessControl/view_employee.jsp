<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
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
			.ellipsis_string {
			  white-space: nowrap;
			  overflow: hidden;
			  text-overflow: ellipsis;
			}
		</style>
		
		<script>
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
			
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
				$('#img_emp').animate({height: '180px', width: '180px'}, 'slow');	//	100px
				document.getElementById("resize_small").style.display = "";
			}
			
			function ShowSmallImage(){
				document.getElementById("resize_small").style.display = "none";
				$('#img_emp').animate({height: '24px', width: '24px'}, 'slow');
				document.getElementById("resize_full").style.display = "";
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="ImgLoad(); Rotate();">
	
<% 
	String action = request.getParameter("action");
	if(action.equals("view")){	
		String idcard = request.getParameter("idcard");			
		String col1 = "col-xs-5 col-md-5";
		String col2 = "col-xs-7 col-md-7";
		String col_line = "col-xs-12";
		String set_hr = " <div class='row'> <hr class='"+col_line+"' style='width: 86%; height: 6px; margin-top: 8px; margin-bottom: 4px; margin-left: 3%;' /> </div> ";
		String sql = "";
		if(mode == 0){
			sql = "SELECT *, DATE_FORMAT(st_date,'%d/%m/%Y') AS stdate_show, "
				 +"DATE_FORMAT(ex_date,'%d/%m/%Y') AS exdate_show ";			
		}else if(mode == 1){
			sql = "SELECT *, CONVERT(varchar(10),st_date,103) AS stdate_show, "
				 +"CONVERT(varchar(10),ex_date,103) AS exdate_show ";			
		}
		sql += "FROM dbemployee WHERE (idcard = '"+idcard+"') ";
		try{
			ResultSet rs = stmtQry.executeQuery(sql);
			if(rs.next()){
				String use_finger = rs.getString("use_finger");
				String usemapcard = rs.getString("use_map_card");
				String mapcard = rs.getString("sn_card"); 
				String sex = rs.getString("sex");
				String st_date = rs.getString("stdate_show");
				String ex_date = rs.getString("exdate_show");	
				String seccode_emp = rs.getString("sec_code");
				String poscode_emp = rs.getString("pos_code");
				String typecode_emp = rs.getString("type_code");
				String groupcode_emp = rs.getString("group_code");
				
				//	ex : xxxxxxxxxx		==>>   xxx-xxx-xxxx
				String phoneno = rs.getString("phone_no");
				if(!(phoneno.equals("") || phoneno.equals("null"))){									
					phoneno = displayFormatPhone(phoneno);
				}
				
				//	ex : xxxxxxxxxxxxx	==>>   x-xxxx-xxxxx-xx-x	
				String card_id = rs.getString("card_id"); 
				if(!(card_id.equals("") || card_id.equals("null"))){				
					card_id = displayFormatPublicId(card_id);
				}					
%>
		<div class="bodycontainer scrollable" style="overflow-x: hidden; overflow-y: auto;">
			<div class="row">
				
				<div class="col-xs-6 col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-list-alt" > </i> &nbsp; <b> ID Card & Grant Information </b> </label>
						</div>
						
						<div class="row">
							<h5 class="modal-title col-xs-5 col-md-5"> <div align="right"> <b> Photo : </b> </div> </h5>
							<div class="modal-title col-xs-7 col-md-7" style="margin-top: -3px;">
								<img id="img_emp" class="img-rounded" width="24" height="24"> &nbsp; 
								<span id="resize_full" class="glyphicon glyphicon-resize-full" style="cursor: pointer; vertical-align: top; cursor: hand;" onClick="ShowFullImage();" data-toggle="tooltip" data-placement="right" title="Full size"> </span> 
								<span id="resize_small" class="glyphicon glyphicon-resize-small" style="cursor: pointer; vertical-align: top; cursor: hand;" onClick="ShowSmallImage();" data-toggle="tooltip" data-placement="left" title="Small size"> </span>
								<input name="idcard" type="hidden" id="idcard" value="<%=idcard %>">
							</div>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title col-xs-5 col-md-5"> <div align="right"> <b> <%= lb_empcode %> : </b> </div> </h5>
							<h5 class="modal-title col-xs-4 col-md-4"> <%= idcard %> </h5>
							<h5 class="modal-title col-xs-3 col-md-3" style="font-size: 12px;"> 
								<div align="right" style="margin-top: 3px;"> 
									<%	if(use_finger.equals("1")){	%>
										<img src="images/checkbox_ch.png" width="16" height="16" style="margin-top: -8px;">
									<%	}else{	%>
										<img src="images/checkbox_un.png" width="16" height="16" style="margin-top: -8px;">
									<%	}	%>
									<%= lb_usebio %> 
								</div>
							</h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title col-xs-5 col-md-5"> <div align="right"> <b> <%= lb_serial_card %> : </b> </div> </h5>
							<h5 class="modal-title col-xs-3 col-md-3"> <%= mapcard.toUpperCase() %> </h5>
							<h5 class="modal-title col-xs-4 col-md-4" style="font-size: 12px;"> 
								<div align="right" style="margin-top: 3px;"> 
									<%	if(usemapcard.equals("1")){	%>
										<img src="images/checkbox_ch.png" width="16" height="16" style="margin-top: -8px;">
									<%	}else{	%>
										<img src="images/checkbox_un.png" width="16" height="16" style="margin-top: -8px;">
									<%	}	%>
									<%= lb_use_mapcard %> 
								</div>
							</h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_issue %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <%= rs.getString("issue") %> &nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_pincode %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > <%= rs.getString("pincode") %> &nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_startdate %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > 
								<%= st_date %> &nbsp; &nbsp;
								<b> <%= lb_time %> </b> &nbsp; <%= rs.getString("st_time") %> 
							</h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>" > <div align="right"> <b> <%= lb_expiredate %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>" > 
								<%= ex_date %> &nbsp; &nbsp;
								<b> <%= lb_time %> </b> &nbsp; <%= rs.getString("ex_time") %> 
							</h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_groupemp %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> 
								<div class="ellipsis_string" style="width: 190px;">
							<%	if(groupcode_emp.length() == 13){
									if(lang.equals("th")){
										out.println("กลุ่มที่กำหนดเฉพาะแต่ละบุคคล");
									}else{
										out.println("Specifically defined group");
									}
								}else{				
									String groupcode = "";			  
									String sql_group = "SELECT group_code, ";
									if(lang.equals("th")){
										sql_group = sql_group + "th_desc ";
									}else{
										sql_group = sql_group + "en_desc AS th_desc ";
									}
									sql_group = sql_group + "FROM dbgroup ORDER BY group_code ";
									ResultSet rs_group = stmtUp.executeQuery(sql_group);
									while (rs_group.next()){
										groupcode = rs_group.getString("group_code");
										if ( rs_group.getString("group_code").equals(groupcode_emp) ){
											if(rs_group.getString("group_code").equals("groupblacklist")){
												out.println("<span style='color: #FF0000;'>"+ rs_group.getString("th_desc") +"</span>");
											}else{
												out.println(groupcode+" - "+rs_group.getString("th_desc"));
											}
										}
									}	rs_group.close();
								}
							%>	&nbsp; </div>
							</h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_sect %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> 
								<div class="ellipsis_string" style="width: 190px;">
							<%	String sec_code = "";			   
								String sql_section = "SELECT sec_code, ";
								if(lang.equals("th")){
									sql_section = sql_section + "th_desc ";
								}else{
									sql_section = sql_section + "en_desc AS th_desc ";
								}
								sql_section = sql_section + "FROM dbsection ORDER BY sec_code ";
								ResultSet rs_section = stmtUp.executeQuery(sql_section);
								while (rs_section.next()){
									sec_code = rs_section.getString("sec_code"); 
									if( rs_section.getString("sec_code").equals(seccode_emp) )
										out.println(sec_code+" - "+rs_section.getString("th_desc"));
								}rs_section.close();
							%> 	&nbsp; </div>
							</h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_posemp %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> 
								<div class="ellipsis_string" style="width: 190px;">
							<%	String pos_code = "";			   
								String sql_position = "SELECT pos_code, ";
								if(lang.equals("th")){
									sql_position = sql_position + "th_desc ";
								}else{
									sql_position = sql_position + "en_desc AS th_desc ";
								}
								sql_position = sql_position + "FROM dbposition ORDER BY pos_code ";
								ResultSet rs_position = stmtUp.executeQuery(sql_position);
								while (rs_position.next()){
									pos_code = rs_position.getString("pos_code"); 
									if( rs_position.getString("pos_code").equals(poscode_emp) )
										out.println(pos_code+" - "+rs_position.getString("th_desc"));
								}rs_position.close();
							%> 	&nbsp; </div>
							</h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_typeemployee %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> 
								<div class="ellipsis_string" style="width: 190px;">
							<%	String type_code = "";			  
								String sql_type = "SELECT type_code, ";
								if(lang.equals("th")){
									sql_type = sql_type + "th_desc AS type_desc ";
								}else{
									sql_type = sql_type + "en_desc AS type_desc ";
								}
								sql_type = sql_type + "FROM dbtype ORDER BY type_code ";
								ResultSet rs_type = stmtUp.executeQuery(sql_type);
								while (rs_type.next()){
									type_code = rs_type.getString("type_code");
									if (rs_type.getString("type_code").equals(typecode_emp) )					
										out.println(type_code+" - "+rs_type.getString("type_desc"));
								}rs_type.close();
							%> 	&nbsp; </div>
							</h5>
						</div>
					
					</div>
				</div>
					
				<div class="col-xs-6 col-md-6" style="border: 0px !important; margin-bottom: 15px; margin-left: 0px; margin-right: 0px;">
					<div class="bs-callout bs-callout-info"> 
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-user" > </i> &nbsp; <b> Employee Information </b> </label>
						</div>
						
						<div class="row">
							<h5 class="modal-title <%= col1 %>" style="font-size: 12px;"> <div align="right"> <b> <%= lb_empcard %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> <%= rs.getString("emp_card") %> &nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_sex %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> 
							<%	if(sex.equals("0")){ out.println(lb_none); }else if(sex.equals("1")){ out.println(lb_male); }else if(sex.equals("2")){ out.println(lb_female); }	%> &nbsp; 
							</h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_prefix %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> 
								<% if (rs.getInt("prefix") == 0) out.print(lb_none); %>
								<% if (rs.getInt("prefix") == 1) out.print(lb_mr); %>
								<% if (rs.getInt("prefix") == 2) out.print(lb_mrs); %>
								<% if (rs.getInt("prefix") == 3) out.print(lb_miss); %>
							&nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_thname %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> <%= rs.getString("th_fname") %> &nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_thsname %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> <%= rs.getString("th_sname") %> &nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_enname %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> <%= rs.getString("en_fname") %> &nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_ensname %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> <%= rs.getString("en_sname") %> &nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>" style="font-size: 12px;"> <div align="right"> <b> <%= lb_cardid %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> <%= rs.getString("nationality") %> &nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_nationality %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> <%= card_id %> &nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_phoneno %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> <%= phoneno %> &nbsp; </h5>
						</div>
						<%= set_hr %>
						<div class="row">
							<h5 class="modal-title <%= col1 %>"> <div align="right"> <b> <%= lb_email %> : </b> </div> </h5>
							<h5 class="modal-title <%= col2 %>"> <%= rs.getString("email") %> &nbsp; </h5>
						</div>
					</div>
				</div>
			
			</div>

<%			}else{	%>
		<div class="alert alert-warning" role="alert">
			<center> <strong> <%= lb_nodata %> <%= lb_empcode %> <%= idcard %> </strong> </center>
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