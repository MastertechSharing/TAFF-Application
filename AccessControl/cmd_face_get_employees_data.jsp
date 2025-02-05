<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%	
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "face");
	session.setAttribute("subtitle", "facegetemployees");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "cmd_face_get_employees_data.jsp?ip="+ip+"&door_id="+door_id+"&");	
%>
<span/>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet" type="text/css">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">			
<%  
	String sql = "", desc = "";
	try{
		sql = " SELECT door_id, th_desc, en_desc FROM dbdoor ";
		if(!ip.equals("")){
			sql += " WHERE ip_address = '"+ip+"' ";
		}else{
			sql += " WHERE door_id = '"+door_id+"' ";
		}
		ResultSet rs = stmtQry.executeQuery(sql);
		while(rs.next()){
			door_id = rs.getString("door_id");
			if(lang.equals("th")){
				desc = rs.getString("th_desc");
			}else{
				desc = rs.getString("en_desc");
			}
		}
		rs.close();
		
		String pathfile = "";
		if(!ip.equals("")){
			pathfile = path_data+ip+"\\ID\\ID.IDS";
		}else{
			pathfile = path_data+door_id+"\\ID\\ID.IDS";
		}
		File f = new File(pathfile);
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("	<span class='alert-link'> "+uploadFile_msgerror5+" "+lb_cmdA1_48+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
%>			
				<div class="alert alert-info" role="alert" style="min-height: 50px;">
					<span class="modal-title col-xs-8 col-md-8">
						<span class="alert-link"> <%= lb_cmdA1_48 %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </span>
					</span>
					<span class="modal-title col-xs-4 col-md-4" style="text-align: right;">
						<div class="btn-group">
							<button class="btn btn-default btn-xs button-shadow1 button-shadow2" id="btn_download" onClick="saveFile('<%= ip %>', '<%= door_id %>');" onMouseOver="this.style.cursor='hand';"> &nbsp; &nbsp; &nbsp; <%= lb_export %> Excel &nbsp; &nbsp; &nbsp; </button>
						</div>
						<input type="hidden" name="door_id" id="door_id" value="<%= door_id %>">
					</span>
				</div>
				
				<div class="table-responsive" style="border: 0px !important; margin-left: 0px; margin-right: 0px;" border="0">
					<div style="min-width: 1700px; max-width: 98%; margin-left: 0px; margin-right: -30px;" class="table" border="0">	
					
						<table style="min-width: 1700px; max-width: 98%;" align="center" id="data_table" class="table" cellspacing="0" >
							<tr>
								<td width="3%" align="center"> <label class="control-label"> <%= lb_no %> </label> </td>
								<td width="8%" align="center"> <label class="control-label"> <%= lb_empcode %> </label> </td>
								<td width="12%" align="center"> <label class="control-label"> <%= lb_names %> </label> </td>
								<td width="6%" align="center"> <label class="control-label"> <%= lb_issue %> </label> </td>
								<td width="5%" align="center"> <label class="control-label"> <%= lb_pincode %> </label> </td>
								<td width="8%" align="center"> <label class="control-label"> <%= lb_startdate %> </label> </td>
								<td width="8%" align="center"> <label class="control-label"> <%= lb_expiredate %> </label> </td>
								<td width="3%" align="center"> <label class="control-label"> RD 1 </label> </td>
								<td width="3%" align="center"> <label class="control-label"> RD 2 </label> </td>
								<td width="9%" align="center"> <label class="control-label"> <%= lb_dateupdate %> </label> </td>
								<td width="3%" align="center"> <label class="control-label"> BIO </label> </td>
								<td width="5%" align="center"> <label class="control-label"> Map Card </label> </td>
								<td width="6%" align="center"> <label class="control-label"> <%= lb_serial_card %> </label> </td>
								<td width="5%" align="center"> <label class="control-label"> <%= lb_temp %> 1 </label> </td>	
								<td width="5%" align="center"> <label class="control-label"> <%= lb_temp %> 2 </label> </td>
								<td width="10%" align="center"> <label class="control-label"> <%= lb_dateupdate %> </label> </td>				
							</tr>
<%				 			
			int num = 1;
			int lenID = 0;
			int lenFinger1 = 0;
			int lenFinger2 = 0;
			if(getModuleF(stmtQry).equals("0")){
				//Suprema
				lenID = 1800;
				lenFinger1 = 384;
				lenFinger2 = 768;
			}else{
				//SecuGen
				lenID = 3532;
				lenFinger1 = 817;
				lenFinger2 = 1634;
			}	
			String textHex = "", textStr = "";
			String idcard = "", issue = "", pincode = "", st_date = "", ex_date = "", time_rd1 = "", time_rd2 = "", 
					update_data = "", quanlity1 = "", finger1 = "", template1 = "", quanlity2 = "", finger2 = "", 
					template2 = "", date_finger = "", use_finger = "", antipass = "", idname = "", use_mapcard = "", 
					sn_card = "", st_time = "", ex_time = "", new_sn_card = "";
			byte[] byteArray = null;
			try{
				//byteArray = getBytesFromFile(f);
				byteArray = readFileToByte(pathfile);
			}catch (IOException e){
			
			}			
			String byteHexString = "";
			if(byteArray != null) {
				//byteHexString = bytesToHexString(byteArray);
				byteHexString = byteToHex(byteArray);
			}
			for(int i = 0; i <= byteHexString.length()-1; i+=lenID){
				textHex = byteHexString.substring(i,(i+lenID));
				textStr = convertHexToString(textHex);			
				idcard = textStr.substring(4,20);//ID(16)
				issue = textStr.substring(20,22);//ISSUE(2)
				pincode = textStr.substring(22,26);//PINCODE(4)
				st_date = textStr.substring(26,34);//STARTDATE(8)
				ex_date = textStr.substring(34,42);//EXPIREDATE(8)
				time_rd1 = textStr.substring(42,44);//TIMECODE_RD1(2)
				time_rd2 = textStr.substring(44,46);//TIMECODE_RD2(2)
				update_data = textStr.substring(46,60);//DATETIME_DATA(14)
				quanlity1 = textStr.substring(60,61);//QUANLITY1(1)
				finger1 = textStr.substring(61,62);//FINGER1(1)
				template1 = textStr.substring(62,(62+lenFinger1));//TEMPLATE1(384)
				quanlity2 = textStr.substring((62+lenFinger1),(63+lenFinger1));//QUANLITY2(1)
				finger2 = textStr.substring((63+lenFinger1),(64+lenFinger1));//FINGER2(1)
				template2 = textStr.substring((64+lenFinger1),(64+lenFinger2));//TEMPLATE2(384)
				date_finger = textStr.substring((64+lenFinger2),(78+lenFinger2));//DATETIME_FINGER(14)
				use_finger = textStr.substring((78+lenFinger2),(79+lenFinger2));//USE_FINGER(1)
				antipass = textStr.substring((79+lenFinger2),(80+lenFinger2));//ANTIPASSBACK(1) USE NEW_SERAIL_CARD
				idname = textStr.substring((80+lenFinger2),(112+lenFinger2));//NAME(32)
				use_mapcard = textStr.substring((112+lenFinger2),(113+lenFinger2));//USE_MAP_CARD(1)
				sn_card = textStr.substring((113+lenFinger2),(117+lenFinger2));//SERAIL_CARD(4)
				st_time = textStr.substring((117+lenFinger2),(119+lenFinger2))+":"+textStr.substring((119+lenFinger2),(121+lenFinger2));//STARTTIME(4)
				ex_time = textStr.substring((121+lenFinger2),(123+lenFinger2))+":"+textStr.substring((123+lenFinger2),(125+lenFinger2));//EXPIRETIME(4)
				new_sn_card = textStr.substring((125+lenFinger2),(127+lenFinger2));//NEW_SERAIL_CARD(2)
				
				if(pincode.equals("****")){
					pincode = "-";
				}
				if(st_date.equals("********")){
					st_date = "-";
				}else{
					st_date = st_date.substring(6,8)+"/"+st_date.substring(4,6)+"/"+st_date.substring(0,4)+" "+st_time;
				}
				
				if(ex_date.equals("********")){
					ex_date = "-";
				}else{
					ex_date = ex_date.substring(6,8)+"/"+ex_date.substring(4,6)+"/"+ex_date.substring(0,4)+" "+ex_time;	
				}
				
				if(update_data.equals("**************")){
					update_data = "-";
				}else{
					update_data = update_data.substring(6,8)+"/"+update_data.substring(4,6)+"/"+update_data.substring(0,4)
								+" "+update_data.substring(8,10)+":"+update_data.substring(10,12)+":"+update_data.substring(12,14);
				}
				
				String imgUse = "<img src=\"images/checkbox_ch.png\" width='18' height='18' align='absmiddle' style='margin-top: -5px'>";
				String imgNotUse = "<img src=\"images/checkbox_un.png\" width='18' height='18' align='absmiddle' style='margin-top: -5px'>";
				
				if(!(quanlity1.equals("*") || finger1.equals("*"))){
					template1 = imgUse;
				}else{
					template1 = imgNotUse;
				}
				
				if(!(quanlity2.equals("*") || finger2.equals("*"))){
					template2 = imgUse;
				}else{
					template2 = imgNotUse;
				}
				
				if(date_finger.equals("**************")){
					date_finger = "-";
				}else{	
					date_finger = date_finger.substring(6,8)+"/"+date_finger.substring(4,6)+"/"+date_finger.substring(0,4)
								+" "+date_finger.substring(8,10)+":"+date_finger.substring(10,12)+":"+date_finger.substring(12,14);
				}
				
				if(use_finger.equals("1")){
					use_finger = imgUse;
				}else{
					use_finger = imgNotUse;
				}
				
				if(use_mapcard.equals("1")){
					use_mapcard = imgUse;
				}else{
					use_mapcard = imgNotUse;
				}
				
				if(sn_card.equals("****")){
					sn_card = "-";
				}else{
					sn_card = textHex.substring((113+lenFinger2)*2,(117+lenFinger2)*2).toUpperCase();					
				}
				
				if (quanlity2.equals("1")){
				//if(!antipass.equals("*")){
					antipass = textHex.substring((79+lenFinger2)*2,(80+lenFinger2)*2).toUpperCase();
					sn_card = sn_card + antipass;
				//}
				//if (!new_sn_card.equals("**")){					
					new_sn_card = textHex.substring((125+lenFinger2)*2,(127+lenFinger2)*2).toUpperCase();
					sn_card = sn_card + new_sn_card;						
				}				
				
				//idname = new String (idname.getBytes ("ISO8859_1"), "TIS-620");
				String idcard_link = "<b> <a href='#' onClick='show_detail(\""+idcard.trim()+"\");' data-toggle='tooltip' data-placement='left' title='"+lb_viewdata+"'>" + idcard.trim() + "</a> </b>";
%>  
							<tr bgcolor="#FFFFFF">							
								<td align="center"> <%= num++ %> </td>
								<td class="pad-left-10"> <%= idcard_link %> </td>
								<td class="pad-left-10"> <%= idname %> </td>
								<td align="center"> <%= issue %> </td>
								<td align="center"> <%= pincode %> </td>
								<td align="center"> <%= st_date %> </td>
								<td align="center"> <%= ex_date %> </td>
								<td align="center"> <%= time_rd1 %> </td>
								<td align="center"> <%= time_rd2 %> </td>
								<td align="center"> <%= update_data %> </td>	
								<td align="center"> <%= use_finger %> </td>
								<td align="center"> <%= use_mapcard %> </td>
								<td align="center"> <%= sn_card %> </td>				
								<td align="center"> <%= template1 %> </td>				
								<td align="center"> <%= template2 %> </td>
								<td align="center"> <%= date_finger %> </td>
							</tr>
							
<%			}
		}
	}catch(SQLException e){
		out.println("<span class='err_exp'> SQL Exception :"+e.getMessage()+"</span>");	
	}
%>	
						</table>
						
					</div>
				</div>
			
			</div>
		</div>
		
		<div class="modal fade" id="myModalResult" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-ok-circle alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p> <%= msg_export_success %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_save" onClick="javascript: $('#myModalResult').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> <input type="hidden" id="datetime_result" name="datetime_result" readonly> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>
	
		<iframe id="save_excel" name="save_excel" src="" width="0px" height="0px" frameborder="0" scrolling="yes"></iframe>
		
		<script>
			function show_detail(idcard){
				view_detail.location = 'view_employee.jsp?action=view&idcard='+idcard;
				$('#myModalViewDetail').modal('show');
			}
			
			function saveFile(ip, door_id){
				if(ip != ''){
					save_excel.location.href = 'cmd_get_idtables_excel.jsp?ip='+ip;
				}else{
					save_excel.location.href = 'cmd_get_idtables_excel.jsp?door_id='+door_id;
				}
				
				setTimeout(function(){
					var date = new Date().getTime();
					$('#myModalResult').modal('show');
					document.getElementById("datetime_result").value = date;
					setTimeout(function(){
						if ((!$('#myModalResult').is(':hidden')) && date == document.getElementById("datetime_result").value) {
							$('#myModalResult').modal('hide');
						}
					}, 3000);
				}, 100);
			}
			
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
					$('body').addClass('loaded');
				}
			}
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>