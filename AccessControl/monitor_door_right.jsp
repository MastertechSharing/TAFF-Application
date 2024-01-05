<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<%	
	session.setAttribute("page_g", "index"); 
	session.setAttribute("action", "monitor_door_right.jsp?");	
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
		
		<style>
			table, tr, td { padding : 5px !important; }
		</style>		
		
		<script>
			window.setInterval("reloadIFrame();", 35000);	//	60 * 1000 = 1m.   , 1000 = 1 sec
			function reloadIFrame() {
				location.reload();
			} 
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="padding-top: 0px; padding-bottom: 0px">
		<table width="100%" class="table table-hover table-bordered" align="center" border="0">
	<%	
	int count_row = 0;
	String old_code = "", datetime_evt = "", event_code = "", event_desc = "", door_id = "", door_desc = "", idcard = "", idcard_desc = "";
	String groupimg = "", img = "", hints = "", data_display = "", img_display = "", door_display = "", event_display = "", idcard_display = "";
	
	String where_location = " ";
	if(!(locate_box.equals("")) ){
		where_location = " AND ( ";
		for(int i = 0; i < locate_select.length; i++){
			where_location += " (locate_code = '"+locate_select[i]+"') or ";
		}
		where_location = where_location.substring(0, (where_location.length() -3)) + " ) ";
	}else{
		where_location += " AND (locate_code = '******') ";
	}
	
	String sql = selectViewTransMonitorByHost(where_location);
	try{		
		ResultSet rs = stmtQry.executeQuery(sql);
		while(rs.next()){	
			count_row++;	
			datetime_evt = YMDTodate(rs.getString("date_event"))+" "+rs.getString("time_event");
			event_code = rs.getString("event_code");
			groupimg = rs.getString("group_img");	
			door_id = rs.getString("door_id");		
			idcard = rs.getString("idcard");			
			if(lang.equals("th")){															
				if((rs.getString("th_desc") != null) && (!rs.getString("th_desc").equals(""))){
					door_desc = rs.getString("th_desc");
				}
				event_desc = rs.getString("ev_th_desc");
				if ((rs.getString("th_fname") != null) && (!rs.getString("th_fname").equals(""))) {
					idcard_desc = rs.getString("idcard") + " : " + rs.getString("th_fname");
				}
				if ((rs.getString("th_sname") != null) && (!rs.getString("th_sname").equals(""))) {
					idcard_desc += "  " + rs.getString("th_sname");
				}
			}else{								
				if((rs.getString("en_desc") != null) && (!rs.getString("en_desc").equals(""))){
					door_desc = rs.getString("en_desc");						
				}
				event_desc = rs.getString("ev_en_desc");
				if ((rs.getString("en_fname") != null) && (!rs.getString("en_fname").equals(""))) {
					idcard_desc = rs.getString("idcard") + " : " + rs.getString("en_fname");
				}
				if ((rs.getString("en_sname") != null) && (!rs.getString("en_sname").equals(""))) {
					idcard_desc += "  " + rs.getString("en_sname");
				}
			}
			
			door_display = "<b><span onClick='show_detail(\""+door_id+"\", \""+lb_viewdata+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='left' title='"+door_desc+"'>"+ door_id +"</span></b>";							
			event_display = "<b><span onClick='show_detail2(\""+event_code+"\", \""+lb_viewdata+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='left' title='"+event_desc+"'>"+ event_code +"</span></b>";
			idcard_display = "<b><span onClick='show_detail2(\""+idcard+"\", \""+lb_viewdata+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='left' title='"+idcard_desc+"'>"+ idcard +"</span></b>";
			hints = displayText(Integer.parseInt(groupimg), lang);
			if(count_row == 1){
				data_display = datetime_evt+" ["+event_display+"] "+door_display+" > "+idcard_display+" <br/> ";
			}else{
				if(!groupimg.equals(old_code)){
					hints = displayText(Integer.parseInt(old_code),lang);
					img = displayImg(Integer.parseInt(old_code));							
					img_display = " <img src='"+img+"' style='cursor: default;' width='20' height='20' border='0' data-toggle='tooltip' data-placement='right' title='"+hints+"'>";
	%>
			<tr>	
				<td width="10%" align="center"> <%= img_display %> </td>
				<td width="90%" align="left" class="pad-left-10"> <div class="ellipsis_string" style="width: 315px"> <%= data_display %> </div> </td>
			</tr>
	<%										
						data_display = datetime_evt+" ["+event_display+"] "+door_display+" > "+idcard_display+" <br/> ";
					}else{
						data_display = data_display + datetime_evt+" ["+event_display+"] "+door_display+" > "+idcard_display+" <br/> ";
					}
				}	 
				old_code = groupimg;					
			}	rs.close();
			if(count_row != 0){
				hints = displayText(Integer.parseInt(old_code),lang);	
				img = displayImg(Integer.parseInt(old_code));					
				img_display = " <img src='"+img+"' style='cursor: default;' width='20' height='20' border='0' data-toggle='tooltip' data-placement='right' title='"+hints+"'>";
	%>
			<tr>	
				<td width="10%" align="center"> <%= img_display %> </td>
				<td width="90%" align="left" class="pad-left-10"> <div class="ellipsis_string" style="width: 315px"> <%= data_display %> </div> </td>
			</tr>
	<%		}
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");		
		} 
	%>
		</table>
		
		<script>
		function show_detail(door_id, text_header){
			parent.document.getElementById("text_header").innerHTML = text_header;
			parent.view_detail2.location = 'view_door.jsp?action=view&door_id='+door_id;
			window.top.$('#myModalViewDetail2').modal('show');
		}	
		
		function show_detail2(event_code, text_header){
			parent.document.getElementById("text_header").innerHTML = text_header;
			parent.view_detail2.location = 'view_event.jsp?action=view&event_code='+event_code;
			window.top.$('#myModalViewDetail2').modal('show');
		}	
		</script>
</body>
</html>
<%@ include file="../function/disconnect.jsp"%>