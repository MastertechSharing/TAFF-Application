<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>

<%	
	session.setAttribute("page_g", "index"); 
	session.setAttribute("subpage", "home");
	session.setAttribute("subtitle", "map");
	session.setAttribute("action", "monitor_map.jsp?");
		
	String[] locate_select = new String[0];
	if(request.getParameter("action") != null && request.getParameter("action").equals("save")){
		String location_set = "";
		if(request.getParameterValues("locate_select") != null){			
			locate_select = request.getParameterValues("locate_select");
			if(!locate_select[0].equals("")){
				for(int i = 0; i < locate_select.length; i++){
					location_set += locate_select[i]+",";
				}
				location_set = location_set.substring(0, (location_set.length() -1));
			}
		}
		stmtQry.executeUpdate("UPDATE dbusers SET monitor_location = '"+location_set+"' WHERE (user_name = '"+ses_user+"') ");
		//	Remove sessionStorage [ Key ] > li_location & locate_code
		out.println("<script> sessionStorage.removeItem('li_location'); sessionStorage.removeItem('locate_code'); </script>");
		out.println("<script> document.location='monitor_map.jsp'; </script>");
	}else{
		try{
			ResultSet rs_location = stmtQry.executeQuery("SELECT monitor_location FROM dbusers WHERE (user_name = '"+ses_user+"') ");
			if(rs_location.next()){
				locate_select = rs_location.getString("monitor_location").split(",");				
			}
			rs_location.close();
		}catch(Exception e){ }
	}
	
	String locate_box = "";
	try{
		if(!locate_select[0].equals(""))
			locate_box = locate_select[0];
	}catch(Exception e){ }
	
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->		
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/ajax_datamonitor.js"></script>
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
				
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			span#font-red a:hover { color: red; }
		</style>		
		
		<style type="text/css">
		.style7 { font-size: 12px }
		.drag { position: absolute; cursor: hand; }
		span.line { background: #FFCC00; }

		<!-- Door Detail -->
		div.imgdoor_{ position: relative; }
		div.detail_door{
			position: absolute;	
			display: none;
			width: 450px;
			height: auto;
			background-color: #FFFFCC;
			padding: 9px;
			border: solid 1px #555555;
			margin: 5px;	
			list-style: inside circle; 
			font-weight: bold;	
			opacity: 0.9;	
			text-align: left;
			box-shadow: 0 15px 15px 0 rgba(0,0,0,0.15),0 15px 15px 0 rgba(0,0,0,0.10);
		}
		
		.scrollable-menu {
			height: auto;
			max-height: 450px;
			overflow-x: hidden;
		}
		.scrollable-menu::-webkit-scrollbar {
			-webkit-appearance: none;
			width: 5px;        
		}    
		.scrollable-menu::-webkit-scrollbar-thumb {
			border-radius: 3px;
			background-color: lightgray;
			-webkit-box-shadow: 0 0 1px rgba(255,255,255,.75);        
		}
		
		.nav-tabs > li a {
			border: 1px solid #EEEEEE;
			background-color: #DEDEDE;
			color: #2870A0;
		}
		.li-white {
			border: 0px solid #FFFFFF !important;
			background-color: #FFFFFF !important;
			color: #333333 !important;
		}
		.tab-content {
			border-left: 1px solid #EEEEEE;
			border-right: 1px solid #EEEEEE;
			padding: 2px;
		}
		</style>
		
		<script type="text/javascript">
		//	กรณีมีรหัสเข้ามา..ให้มีป๊อบอัพ ขึ้นที่ประตูที่มีการเข้า ออก
		function showAutoDetail(door_id){
			if(door_id != ""){		
				$('#Move_detail_'+door_id).show();
				
				var date = new Date().getTime();
				$('#datetime_'+door_id).val(date);
				setTimeout(function(){
					if (date == $('#datetime_'+door_id).val()){
						$('#Move_detail_'+door_id).fadeOut(300);
						$('#datetime_'+door_id).val("");
					}
				}, 5000);
			}
		}
		
		var onDIV = "";
		function showDoorDetailHover(door_id, show_type){
			$('#imgdoor_'+door_id).hover(function() {
				onDIV = "on";
				$('#Move_detail_'+door_id).show('slide', {direction: show_type}, 200);
			}, function() {
				onDIV = "off";
				setTimeout(function(){
					if(onDIV == "off"){
						$('#Move_detail_'+door_id).fadeOut(300);
					}
				}, 500);
			});		
		}
		function showDoorDetailHoverDiv(door_id){
			$('#Move_detail_'+door_id).hover(function() {
				onDIV = "on";
				setTimeout(function(){
					onDIV = "on";
				}, 300);
			}, function() {
				onDIV = "off";
				setTimeout(function(){
					if(onDIV == "off"){
						$('#Move_detail_'+door_id).fadeOut(300);
					}
				}, 500);
			});	
		}
		function hideDoorDetailHoverDiv(door_id){
			$('#Move_detail_'+door_id).hover(function() {
				
			}, function() {
				onDIV = "off";
				setTimeout(function(){
					if(onDIV == "off"){
						$('#Move_detail_'+door_id).fadeOut(300);
					}
				}, 300);
			});	
		}
		
		//	click mouse()
		function moveDoor(door_id, msg_alert, msg_comfirm){
			var pos_x = "", pos_y="";	
			pos_x = document.form1.posX;
			pos_y = document.form1.posY;		
			
			$('#imgdoor_'+door_id).draggable();	
			$('#imgdoor_'+door_id).mousemove(function(e){
				pos_x.value = e.pageX -120;
				pos_y.value = e.pageY -185;
			});
			
			$('#imgdoor_'+door_id).dblclick(function(e){
				ModalWarning_TextName(msg_alert+' '+door_id, "");
			});	
			
			$('#imgdoor_'+door_id).mouseup(function(e){
				document.getElementById("text_confirm").innerHTML = msg_comfirm+' '+door_id;
				document.getElementById("door_id").value = door_id;
				$('#myModalConfirm').modal('show');
			});
		}
		//	ส่งค่าประตูเพื่อไปแก้ไข แกน x,y
		function sent_data(door_id){	//	save ค่าประตูแล้ว ส่งค่าไปอัพเดท แล้วให้รีเฟรส		
			if(document.form1.posX.value != '' || document.form1.posY.value != ''){
				document.form1.action = "module/save_monitor_map.jsp?door_id="+door_id;
				document.form1.submit();		
			}		
		}
		
		function Confirm_Button(){
			sent_data(document.getElementById("door_id").value);
		}
		
		function Cancel_Button(){
			$('#myModalConfirm').modal('hide');
		//	$('#imgdoor_'+document.getElementById("door_id").value).draggable('disable');	
		}
		
		$(function(){
			$('[data-toggle="tooltip"]').tooltip()
		})
		
		function view_select(){
			document.form_select.action = "monitor_map.jsp?locate_code=&action=save";
			document.getElementById("form_select").submit();
		}
		
		function change_header(text_header){
			var code_name = text_header.split("-");
			document.getElementById("header_tab_last").innerHTML = "<b><span onClick=\"show_detail3('"+code_name[0]+"');\" style='color: #337AB7; cursor: pointer; cursor: hand;'>"+code_name[0]+"</span></b> - "+code_name[1];
		}
		
		//	Load Location by Session Store
		function loadTab(first_tab){
			var li_location = sessionStorage.getItem('li_location');
			var locate_code = sessionStorage.getItem('locate_code');
			
			if(li_location == null){
				$('#li_'+first_tab).addClass('active');
				$('#'+first_tab).addClass('active');
				$('#'+first_tab).removeClass('fade');
			}else{
				$('#'+li_location).addClass('active');
				$('#'+locate_code).addClass('active');
				$('#'+locate_code).removeClass('fade');
			}
			
			if(li_location == 'li_other'){
				document.getElementById("header_tab_last").innerHTML = "<b><span onClick=\"show_detail3('"+locate_code.trim()+"');\" style='color: #337AB7; cursor: pointer; cursor: hand;'>"+locate_code+"</span></b> - " + $('#name_'+locate_code).text().split("-")[1];
			}
		}
		
		function set_session(li_location, locate_code){
			sessionStorage.setItem('li_location', li_location);
			sessionStorage.setItem('locate_code', locate_code);
		}
		</script>
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadTab('<%= locate_box %>');">
		<input type="hidden" name="hidden" id="data_page" value="map"/>
		<input type="hidden" name="hidden" id="lang" value="<%= lang %>"/>
		<input type="hidden" name="hidden" id="data_host" value="<%= hostIPAddr %>">
		<input type="hidden" name="hidden" id="data_port" value="<%= port4 %>">
		
		<!-- INCLUDE HEADER & MENU-->		
		<jsp:include page="header.jsp" flush="true"/>		
		
		<div class="body-display">
			<div class="container">	
				
			<%	//	if(!locate_box.equals("")){	%>
		<!--		<div style="max-height: 0px !important; text-align: center;">
					<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="FlexClient" width="0" height="0" codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
						<param name="movie" value="ClientReciveFlex.swf" />
						<param name="quality" value="high" />
						<param name="bgcolor" value="#FFFFFF" />
						<param name="allowScriptAccess" value="sameDomain" />
						<embed src="flash/ClientReciveFlex.swf" quality="high" bgcolor="#FFFFFF" width="241" height="174" name="FlexClient" align="middle" style="max-height: 0px !important;"
							play="true" loop="false" quality="high" allowScriptAccess="sameDomain" type="application/x-shockwave-flash"
							pluginspage="http://www.adobe.com/go/getflashplayer">
						</embed>
					</object>
				</div>	-->
			<%	//	}	%>
			
				<form id="form_select" name="form_select" method="post" action="monitor_row.jsp?action=save">
					
					<div class="table-responsive" style="border: 0px !important;" border="0">
						<div class="table" style="min-width: 1000px; min-height: 30px;" align="left" border="0">
							<div class="col-xs-2" style="margin-left: -15px;">
								<label style="margin-left: 50px; margin-top: 6px;"> <i class="glyphicon glyphicon-th-large"> </i> <%= lb_location %> </label>
							</div>
							<div class="col-xs-6">
								<select id="locate_select" name="locate_select" class="selectpicker" data-live-search="true" data-width="100%" data-size="12" data-container="body" multiple data-actions-box="true" onChange="change_select();">
							<%	try{
									String sql = selectDbLocationByHost();
									ResultSet rsLoc = stmtQry.executeQuery(sql);
									while(rsLoc.next()){
							%>			<option value="<%= rsLoc.getString("locate_code") %>" <%= checkSelectQryDataList(rsLoc.getString("locate_code"), locate_select) %> > <%= rsLoc.getString("locate_code") %> <% if(lang.equals("th")){ out.println(rsLoc.getString("th_desc")); }else{  out.println(rsLoc.getString("en_desc")); } %> </option>
							<%		}
									rsLoc.close();
								}catch(SQLException e){							
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
								}
							%>	</select>
							</div>
							<div class="col-xs-1" align="left"> 
								<input type="button" id="btn1" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="view_select();" />
							</div>
							<div class="col-xs-3" align="right">
								<div style="margin-right: -30px">
									<input name="pop_listrow" type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="pop_listrow" value=" &nbsp; <%= lb_viewrow %> &nbsp; " onClick="ShowPreViewList('1')" onMouseOver="this.style.cursor='hand'"> &nbsp;
									<input name="pop_listrow" type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="pop_listrow" value=" &nbsp; <%= lb_viewdoor %> &nbsp; " onClick="ShowPreViewList('2')" onMouseOver="this.style.cursor='hand'" >
								</div>
							</div>
						</div>
					</div>
				</form>
				
				<div class="table-responsive" style="margin-top: -5px;">
					<div class="table" style="min-width: 1120px; min-height: 475px;" align="left">
						
			<%		
					String ellipsis_width = "180px", ellipsis2_width = "200px", ellipsis3_width = "235px";
					int check_tab = 0;
					if(!(locate_box.equals("")) ){
						out.println("<ul class='nav nav-tabs'>");
						if(locate_select.length <= 5){
							for(int i = 0; i < locate_select.length; i++){
								check_tab++;
								locate_box = locate_select[i];
								
								String locate_desc = "";
								ResultSet rs_locate_desc = stmtQry.executeQuery("SELECT * FROM dblocation WHERE (locate_code = '"+locate_box+"') ");
								if(rs_locate_desc.next()){
									if(lang.equals("th")){
										locate_desc = rs_locate_desc.getString("th_desc");
									}else{
										locate_desc = rs_locate_desc.getString("en_desc");
									}
									out.println("<li id='li_"+locate_box+"' style='max-height: 24px;' onClick='set_session(\"li_"+locate_box+"\", \""+locate_box+"\");'> <a href='#"+locate_box+"' style='max-height: 24px;' data-toggle='tab'> <div class='ellipsis_string' style='margin-top: -8px; width: "+ellipsis_width+";'> "+locate_box+" - "+locate_desc+" </div> </a> </li>");
								}	rs_locate_desc.close();
							}
						}else if(locate_select.length > 5){
							for(int i = 0; i < locate_select.length; i++){
								check_tab++;
								locate_box = locate_select[i];
								
								String locate_desc = "";
								ResultSet rs_locate_desc = stmtQry.executeQuery("SELECT * FROM dblocation WHERE (locate_code = '"+locate_box+"') ");
								if(rs_locate_desc.next()){
									if(lang.equals("th")){
										locate_desc = rs_locate_desc.getString("th_desc");
									}else{
										locate_desc = rs_locate_desc.getString("en_desc");
									}
									if(check_tab <= 4){					//	row 1 - 4 normal tab
										out.println("<li id='li_"+locate_box+"' style='max-height: 24px;' onClick='set_session(\"li_"+locate_box+"\", \""+locate_box+"\");'> <a href='#"+locate_box+"' style='max-height: 24px;' data-toggle='tab'> <div class='ellipsis_string' style='margin-top: -8px; width: "+ellipsis_width+";'> <span onClick='show_detail3(\""+locate_box+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'> <b> "+locate_box+" </b> </span> - "+locate_desc+" </div> </a> </li>");
									}else if(check_tab == 5){			//	row 5 create -> dropdown-toggle & first sub <li>
										out.println("<li id='li_other' style='max-height: 24px;' role='presentation' class='dropdown'>");
										out.println("	<a class='dropdown-toggle' style='max-height: 24px;' data-toggle='dropdown' href='#' role='button' aria-haspopup='true' aria-expanded='false'>");
										out.println("		<div style='margin-top: -5px;'> <span class='glyphicon glyphicon-chevron-down'> </span> </div> &nbsp; <div class='ellipsis_string' style='width: "+ellipsis2_width+"; margin-top: -42px; margin-left: 20px;'> <span id='header_tab_last'> "+locate_box+" - "+locate_desc+"</span> </div> ");
										out.println("	</a>");
										out.println("	<ul class='dropdown-menu scrollable-menu' style='min-width: 280px;'>");
										out.println("		<li onClick='set_session(\"li_other\", \""+locate_box+"\");'> <a href='#"+locate_box+"' class='li-white' data-toggle='tab' onClick='change_header(\""+locate_box+" - "+locate_desc+"\");'> <div class='ellipsis_string' style='width: "+ellipsis3_width+";'> <span id='name_"+locate_box+"'> <span onClick='show_detail3(\""+locate_box+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'> <b> "+locate_box+" </b> </span> - "+locate_desc+" </span> </div> </a> </li>");
									}else if(check_tab >= 6){			//	row 6+ create sub <li>
										out.println("		<li onClick='set_session(\"li_other\", \""+locate_box+"\");'> <a href='#"+locate_box+"' class='li-white' data-toggle='tab' onClick='change_header(\""+locate_box+" - "+locate_desc+"\");'> <div class='ellipsis_string' style='width: "+ellipsis3_width+";'> <span id='name_"+locate_box+"'> <span onClick='show_detail3(\""+locate_box+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'> <b> "+locate_box+" </b> </span> - "+locate_desc+" </span> </div> </a> </li>");
									}
								}	rs_locate_desc.close();
							}
										out.println("	</ul>");
										out.println("</li>");
						}
						out.println("</ul>");
					}
			%>		
						<div class="tab-content">
						
			<%	
					if(!(locate_box.equals("")) ){
						for(int i = 0; i < locate_select.length; i++){
							locate_box = locate_select[i];
			%>	
							<div class="tab-pane fade" id="<%= locate_box %>">
								<div class="row col-md-12" style="margin-left: 0px; margin-right: 0px; max-width: 1100px; height: 450px; background-image: url('photos/map/<%= locate_box %>.jpg'); background-repeat: no-repeat;">
									
					<%	
							int pos_x = 0, pos_y = 0, no = 0; 
							String locate_code = "", door_id = "", ip_address = "";
							String th_desc = "", en_desc = "";
							try{
								ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbdoor WHERE (locate_code = '"+locate_box+"') ");
								while(rs.next()){ 
									door_id = rs.getString("door_id");
									ip_address = rs.getString("ip_address");	
									pos_x = rs.getInt("pos_x");
									pos_y = rs.getInt("pos_y");
									
									if(lang.equals("th")){
										if((rs.getString("th_desc") != null) && (!rs.getString("th_desc").equals(""))){
											th_desc = rs.getString("th_desc");						
										}
									}else{
										if((rs.getString("en_desc") != null) && (!rs.getString("en_desc").equals(""))){
											th_desc = rs.getString("en_desc");						
										}
									}
									
									int div_pos_x = 0;
									int div_pos_y = 0;
									String fn_showDoorDetail = "";
									
									if(pos_x >= 550){
										div_pos_x = pos_x - 430;
										fn_showDoorDetail = "showDoorDetailHover('"+door_id+"', 'right');";
									}else{
										div_pos_x = pos_x - 0;
										fn_showDoorDetail = "showDoorDetailHover('"+door_id+"', 'left');";
									}
									
									if(pos_y <= 250){
										div_pos_y = pos_y + 25;
									}else{
										div_pos_y = pos_y - 130;
									}
					%>				
									<div style="background-repeat: no-repeat; position: absolute; top: <%= pos_y %>px; left: <%= pos_x %>px;" onMouseOver="this.style.cursor='pointer'">
										<div id="imgdoor_<%= door_id %>" <% if(ses_per == 0){ %> onDblClick="moveDoor('<%= door_id %>', '<%= msg_editdoor %>', '<%= msg_confirm_editdoor %>');" <% } %> onMouseMove="<%= fn_showDoorDetail %>" onMouseOver="this.style.cursor='hand'" style="width: 32px; height: 28px;">
											<img src="images/close_door.gif" width="24" height="24">
											<div onClick="show_detail_tran('<%= door_id %>', '<%= th_desc %>');" style="margin-top: -11px; margin-left: 22px; color: #286090; font-size: 10px;" data-toggle="tooltip" data-placement="right" title="<%= lb_detailcardmas %>" onMouseOver="this.style.cursor='hand'">
												<span class="glyphicon glyphicon-info-sign" id="search<%= door_id %>"> </span>
											</div>
										</div>
									</div>
									
									<!-- รายละเอียด ข้อมูลประตู  style="background-image: url(images/images_popup3.jpg);" -->
									<div id="Move_detail_<%= door_id %>" class="detail_door" style="top: <%= div_pos_y %>px; left: <%= div_pos_x %>px;" onMouseMove="showDoorDetailHoverDiv('<%= door_id %>');" onMouseOut="hideDoorDetailHoverDiv('<%= door_id %>');"> 
										<div id="tb_pic_<%= door_id %>">
											<img src="photos/person.png" style="cursor: default;" width="70" height="70" align="right" id="img_emp_<%=door_id%>">          
										</div>              
										<!-- พนักงาน ประกอบด้วย รหัสพนักงาน ชื่อ - นามสกุล -->
										<div id="emp_code_<%= door_id %>">
											<div> <%= lb_empcode %> &nbsp; <span id="tb_emp_<%= door_id %>" data-toggle="tooltip" data-placement="left" title="<%= lb_viewdata %>"> &nbsp; </span> </div>
											<div> <%= lb_names %> &nbsp; <span id="tb_names_<%= door_id %>"> &nbsp; </span> </div>
											<div> <%= lb_date %> &nbsp; <span id="date_<%= door_id %>"> &nbsp; </span> </div>
										</div> 
										<!-- เหตุการณ์ ประกอบไปด้วย สถานะประตู รหัสประตู รายละเอียด -->
										<div class="ellipsis_string" style="width: 340px;">
											<%= lb_reportstatus %> &nbsp; 
											<span id="door_duty<%= door_id %>"> &nbsp; </span> &nbsp;
											<span> <%= lb_doors %> <span onClick="show_detail2('<%= door_id %>', 'door_detail');" style="color: #337AB7; cursor: pointer; cursor: hand;" data-toggle="tooltip" data-placement="left" title="<%= lb_viewdata %>"> <%= door_id %> </span> : <%= th_desc %> </span>
										</div>  
										<div class="ellipsis_string" style="max-width: 430px;"> <%= lb_eventdoor %> &nbsp; <span id="door_event_<%= door_id %>" data-toggle="tooltip" data-placement="left" title="<%= lb_viewdata %>"> &nbsp; </span> </div>
										<input type="hidden" id="datetime_<%= door_id %>" name="datetime_div" readonly>
									</div>
								
					<%  				
								}	rs.close();	 
							}catch(SQLException e){							
								out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
							}	
					%>
								</div>
							</div>
					
			<%				
						}
					}
			%>		
						</div>
						
					</div>
				</div>
				
				<div align="right" style="margin-top: -15px; margin-bottom: -15px;">
					<b> <i> <i class="glyphicon glyphicon-picture"></i> <%= lb_map_pixel %> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </i> </b>
				</div>
				
			</div>
		</div>
		
		<form name="form1" id="form" method="post" >
			<input type="hidden" name="server_port" value="<%= port3 %>">
			<input name="posX" type="hidden" id="posX">
			<input name="posY" type="hidden" id="posY">        
		</form>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; height: 450px;" border="0">
							<iframe src="" id="view_detail2" name="view_detail2" frameborder="0" width="850px" height="440px" ></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; height: 265px;" border="0">
							<iframe src="" id="view_detail3" name="view_detail3" frameborder="0" width="850px" height="255px" ></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
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
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_save" class="glyphicon glyphicon-floppy-saved alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
									</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" onClick="Cancel_Button();" style="width: 100%;"> <%= btn_cancel %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> 
									<input type="hidden" id="text_label" name="text_label" readonly>
									<input type="hidden" id="door_id" name="door_id" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetailTran" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_door %> <span id="text_head"> </span> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; height: 430px;" border="0">
							<iframe src="" id="view_detail_tran" name="view_detail_tran" frameborder="0" width="850px" height="420px"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<div class="col-md-6 col-xs-6" align="left">
							<input type="button" name="Button" id="pdf" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_report_pdf %> &nbsp; &nbsp; &nbsp; " onClick="Javascript:fncSubmit_Page('pdf', '<%= lang %>');" onMouseOver="this.style.cursor='hand';" > &nbsp;
							<input type="button" name="Button" id="excel" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_report_excel %> &nbsp; &nbsp; &nbsp; " onClick="Javascript:fncSubmit_Page('excel', '<%= lang %>');" onMouseOver="this.style.cursor='hand';" >
						</div>
						<div class="col-md-6 col-xs-6">
							<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="../tools/modal_fix_flash.jsp"%>
		
		<script type="text/javascript" language="javascript">
			function ShowPreViewList(data){
				if(data == '1'){
					location.href = "monitor_row.jsp?";
				}else if(data == '2'){
					location.href = "monitor_door.jsp?";
				}
			}
			
			function show_detail2(sCode, type){
				if(type == 'door_detail'){
					parent.view_detail2.location = 'view_door.jsp?action=view&door_id='+sCode;
				}else if(type == 'event_detail'){
					parent.view_detail2.location = 'view_event.jsp?action=view&event_code='+sCode;
				}else if(type == 'employee_detail'){
					parent.view_detail2.location = 'view_employee.jsp?action=view&idcard='+sCode;
				}
				$('#myModalViewDetail2').modal('show');
			}
			
			function show_detail3(locate_code){
				parent.view_detail3.location = 'view_location.jsp?action=view&locate_code='+locate_code;
				$('#myModalViewDetail3').modal('show');
			}
			
			var door_id = "";
			var door_desc = "";
			function show_detail_tran(sCode, sText){
				document.getElementById("text_head").innerHTML = sCode +" : "+ sText;
				parent.view_detail_tran.location = 'monitor_map_detail.jsp?door_id='+sCode;
				$('#myModalViewDetailTran').modal('show');
			 
				door_id = sCode;
				door_desc = sText;
			}
			
			function fncSubmit_Page(strPage, lang){	
				if(strPage == "pdf"){		
					document.form1.action = "report_monitor_detail_pdf.jsp?door_id="+door_id+"&door_desc="+door_desc+"&lang="+lang+"&rep_id=_monitor";
					form1.target = "_blank";
				}else if(strPage == "excel"){
					document.form1.action = "report_monitor_detail_excel.jsp?door_id="+door_id+"&door_desc="+door_desc;
				}
				document.form1.submit();
			}
			
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
					$('body').addClass('loaded');
					setTimeout(function(){

						const host = $('#data_host').val();
						const port4 = $('#data_port').val();
						const source = new EventSource('http://'+host+':'+port4+'/sse');
						source.onmessage = (ev) => {
						//	console.log(ev.data);
							var d = JSON.parse(ev.data); 
							var data = {id:d.idcard, data_date:d.data_date, data_time:d.data_time, readerid:d.readerid, event_code:d.event_code};
							
							get_datatransaction(data);	
							displaydata(data);
						}
					
					/*
						//	Check Flash On/Off
						checkFlash();
						//	Check browser show fix problems with Flash.
						checkBrowserFixFlash();
					*/
					}, 300);
				}
			}
		
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>