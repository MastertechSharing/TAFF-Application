<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<%	
	session.setAttribute("page_g", "index"); 
	session.setAttribute("action", "monitor_location_left.jsp?");
	String ses_user = (String)session.getAttribute("ses_username");
	
	String[] locate_select = new String[0];
	try{
		ResultSet rs_location = stmtQry.executeQuery("SELECT monitor_location FROM dbusers WHERE (user_name = '"+ses_user+"') ");
		if(rs_location.next()){
			locate_select = rs_location.getString("monitor_location").split(",");
		}	rs_location.close();
	}catch(Exception e){ }
	
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
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>	
		<script src="js/ajax_datamonitor.js"></script>
		
		<style>
			table, tr, td { padding : 5px !important; }	
		</style>
		
		<script>
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>

	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="padding-top: 0px; padding-bottom: 0px">
		
		<input type="hidden" name="hidden" id="data_page" value="event"/>
		<input type="hidden" name="hidden" id="lang" value="<%= lang %>">
		<input type="hidden" name="hidden" id="data_host" value="<%= hostIPAddr %>">
		<input type="hidden" name="hidden" id="data_port" value="<%= port4 %>">
		
		<%	//	if(!locate_box.equals("")){	%>
	<!--	<div style="max-height: 0px !important; text-align: center;">
			<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="FlexClient" width="0" height="0" codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
				<param name="movie" value="ClientReciveFlex.swf" />
				<param name="quality" value="high" />
				<param name="bgcolor" value="#869ca7" />
				<param name="allowScriptAccess" value="sameDomain" />	-->		<!-- width="482" height="348" -->
	<!--		<embed src="flash/ClientReciveFlex.swf" quality="high" bgcolor="#869ca7" width="10" height="348" name="FlexClient" align="middle" style="max-height: 1px !important; margin-top: -30px;"
					play="true" loop="false" quality="high" allowScriptAccess="sameDomain" type="application/x-shockwave-flash"
					pluginspage="http://www.adobe.com/go/getflashplayer">
				</embed>
			</object>
		</div>	-->
		<%	//	}	%>
		
		<table width="100%" class="table table-striped table-bordered" align="center" border="0">
		
<%		
	int count_row = 0;	
	String event_code = "", locate_code = "", locate_desc = "", old_locate = "";
	String door_id = "", door_desc = "", old_door = "";	
	String groupimg = "", img = "", hints = "", display_locate = "", display_door = "", idcard = "", idcard_desc = "", idDisplay = "";			
	
	String where_location = " WHERE ";
	if(!(locate_box.equals("")) ){
		for(int i = 0; i < locate_select.length; i++){
			where_location += " (locate_code = '"+locate_select[i]+"') or ";
		}
		where_location = where_location.substring(0, (where_location.length() -3));
	}else{
		where_location += " (locate_code is null) ";
	}
	
	String sql = "SELECT * FROM view_trans_monitor " + where_location + " ORDER BY locate_code, door_id, dt_event desc";
	try{
		ResultSet rs = stmtQry.executeQuery(sql);					
		while(rs.next()){
			count_row++;
			event_code = rs.getString("event_code");
			locate_code = rs.getString("locate_code");			
			groupimg = rs.getString("group_img");	
			idcard = rs.getString("idcard");		
			
			if(rs.getString("door_id")!= null){
				door_id = rs.getString("door_id");							
			}else{										
				door_id = "-";
			}
			
			if(rs.getString("event_code") != null){			
				img = displayImg(Integer.parseInt(groupimg));
			}else{
				img = "images/door_close.gif";
			}	
			
			if(lang.equals("th")){
				locate_desc = rs.getString("lo_th_desc");
				door_desc = rs.getString("th_desc");		
				idcard_desc = rs.getString("th_fname")+" "+rs.getString("th_sname");
			}else{				
				locate_desc = rs.getString("lo_en_desc");
				door_desc = rs.getString("en_desc");
				idcard_desc = rs.getString("en_fname")+" "+rs.getString("en_sname");
			}
			
			if((idcard != null) && (idcard != "")){
				idDisplay  = "["+idcard+"] "+idcard_desc+"";
			}			

			if(rs.getString("date_event") != null){
				hints = "<p class=\"ellipsis_string\" style=\"text-align: left; max-width: 200px;\">"+YMDTodate(rs.getString("date_event"))+" "+rs.getString("time_event")+"</p> <p class=\"ellipsis_string\" style=\"text-align: left; max-width: 200px; margin-top: -10px; margin-bottom: 0px;\"> ["+event_code+"] *"+displayText(Integer.parseInt(groupimg), lang) +" </p> <p class=\"ellipsis_string\" style=\"text-align: left; max-width: 200px;\">"+idDisplay+"</p>";
			}else{
				hints = "<p class=\"ellipsis_string\" style=\"text-align: left; max-width: 200px; margin-bottom: 0px;\"> *"+displayText(0, lang)+" </p>";
			}
			
			if(count_row == 1){
				display_locate = " <b> <span onClick='show_detail3(\""+locate_code+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+locate_desc+"'> "+ locate_code +" </span> </b> ";
				display_door = " <div style='display: inline-block; padding-right: 15px; padding-bottom: 1px; padding-top: 1px;'> <img src='"+img+"' id='img_door"+door_id+"' style='cursor: default;' width='18' height='18' align='absmiddle' border='0' data-toggle='tooltip' data-placement='right' data-html='true' title='"+hints+"'> "
							+ " <b> <span onClick='show_detail2(\""+door_id+"\", \""+lb_viewdata+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+door_desc+"'> "+ door_id +" </span> </b> "
							+ " <div onClick='window.top.show_detail_tran(\""+door_id+"\", \""+door_desc+"\");' style='margin-top: -15px; margin-left: 55px; color: #286090; font-size: 10px; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_detailcardmas+"'> <span class='glyphicon glyphicon-info-sign' id='search"+door_id+"'> </span> </div> "
							+ " </div>";
			}else{
				if(!(door_id.equals(old_door))){
					if(!(locate_code.equals(old_locate))){
%>
			<tr>
				<td width="8%" align="center"> <%= display_locate %> </td>
				<td width="92%" align="left" class="pad-left-10"> <span id="imgdoor_<%= door_id %>"> <%= display_door %> </span> </td>
			</tr>	
<%			
						display_locate = " <b> <span onClick='show_detail3(\""+locate_code+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+locate_desc+"'> "+ locate_code +" </span> </b> ";
						display_door = " <div style='display: inline-block; padding-right: 15px; padding-bottom: 1px; padding-top: 1px;'> <img src='"+img+"' id='img_door"+door_id+"' style='cursor: default;' width='18' height='18' align='absmiddle' border='0' data-toggle='tooltip' data-placement='right' data-html='true' title='"+hints+"'> "
									+ " <b> <span onClick='show_detail2(\""+door_id+"\", \""+lb_viewdata+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+door_desc+"'> "+ door_id +" </span> </b> "
									+ " <div onClick='window.top.show_detail_tran(\""+door_id+"\", \""+door_desc+"\");' style='margin-top: -15px; margin-left: 55px; color: #286090; font-size: 10px; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_detailcardmas+"'> <span class='glyphicon glyphicon-info-sign' id='search"+door_id+"'> </span> </div> "
									+ " </div>";
					}else{
						display_locate = " <b> <span onClick='show_detail3(\""+locate_code+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+locate_desc+"'> "+ locate_code +" </span> </b> ";
						display_door += " <div style='display: inline-block; padding-right: 15px; padding-bottom: 1px; padding-top: 1px;'> <img src='"+img+"' id='img_door"+door_id+"' style='cursor: default;' width='18' height='18' align='absmiddle' border='0' data-toggle='tooltip' data-placement='right' data-html='true' title='"+hints+"'> "
									+ " <b> <span onClick='show_detail2(\""+door_id+"\", \""+lb_viewdata+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+door_desc+"'> "+ door_id +" </span> </b> "
									+ " <div onClick='window.top.show_detail_tran(\""+door_id+"\", \""+door_desc+"\");' style='margin-top: -15px; margin-left: 55px; color: #286090; font-size: 10px; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+lb_detailcardmas+"'> <span class='glyphicon glyphicon-info-sign' id='search"+door_id+"'> </span> </div> "
									+ " </div>";
					}	
				}				
			}
			old_locate = locate_code;
			old_door = door_id;
		}	rs.close();
		
		if(count_row != 0){	
%>
			<tr>
				<td width="8%" align="center"> <%= display_locate %> </td>
				<td width="92%" align="left" class="pad-left-10"> <%= display_door %> </td>
			</tr>
<%
		}
	}catch(SQLException e){							
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
	}
%>
		</table>
	
		<form name="form1" id="form" method="post" >
			<input type="hidden" name="server_port" value="<%= port3 %>">
		</form>
		
		<script>
		function show_detail2(door_id, text_header){
			parent.document.getElementById("text_header").innerHTML = text_header;
			parent.view_detail2.location = 'view_door.jsp?action=view&door_id='+door_id;
			window.top.$('#myModalViewDetail2').modal('show');
		}
		
		function show_detail3(locate_code){
			parent.view_detail3.location = 'view_location.jsp?action=view&locate_code='+locate_code;
			window.top.$('#myModalViewDetail3').modal('show');
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
					
				}, 300);
			}
		}
		</script>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>