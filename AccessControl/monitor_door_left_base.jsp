<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<%	
	session.setAttribute("page_g", "index"); 
	session.setAttribute("action", "monitor_door_left_base.jsp?");
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
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>

	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="padding-top: 0px; padding-bottom: 0px">
		<table width="100%" class="table table-striped table-bordered" align="center" border="0">
		
<%		
	int count_row = 0;	
	String event_code = "", locate_code = "", locate_desc = "", old_locate = "";
	String door_id = "", door_desc = "", old_door = "";	
	String groupimg = "", img = "", hints = "", display_locate = "", display_door = "";			
	
	String where_location = " WHERE ";
	if(!(locate_box.equals("")) ){
		for(int i = 0; i < locate_select.length; i++){
			where_location += " (locate_code = '"+locate_select[i]+"') or ";
		}
		where_location = where_location.substring(0, (where_location.length() -3));
	}else{
		where_location += " (locate_code is null) ";
	}
	
	int per_row = 0;
	String sql = "SELECT * FROM view_trans_monitor " + where_location + " ORDER BY locate_code, door_id, dt_event desc";
	try{
		ResultSet rs = stmtQry.executeQuery(sql);					
		while(rs.next()){
			count_row++;
			event_code = rs.getString("event_code");
			locate_code = rs.getString("locate_code");			
			groupimg = rs.getString("group_img");	
			
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
			}else{				
				locate_desc = rs.getString("lo_en_desc");
				door_desc = rs.getString("en_desc");
			}
			
			if(rs.getString("date_event") != null){
				hints = "<p class=\"ellipsis_string\" style=\"text-align: left; max-width: 200px;\">"+ YMDTodate(rs.getString("date_event"))+" "+rs.getString("time_event")+"</p> <p class=\"ellipsis_string\" style=\"text-align: left; max-width: 200px; margin-top: -10px;\"> ["+event_code+"] "+door_id+" : "+door_desc+" </p> <p class=\"ellipsis_string\" style=\"text-align: left; max-width: 200px; margin-top: -10px; margin-bottom: -2px;\">*"+displayText(Integer.parseInt(groupimg), lang) +" </p>";
			}else{
				hints = "<p class=\"ellipsis_string\" style=\"text-align: left; max-width: 200px;\">"+ door_id+" : "+door_desc+" </p> <p class=\"ellipsis_string\" style=\"text-align: left; margin-top: -10px; margin-bottom: -2px;\">*"+displayText(0, lang)+" </p>";
			}
			
			if(count_row == 1){
				per_row = 2;
				display_locate = " <b> <span onClick='show_detail3(\""+locate_code+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+locate_desc+"'> "+ locate_code +" </span> </b> ";
				display_door = " <img src='"+img+"' style='cursor: default;' width='18' height='18' align='absmiddle' border='0' data-toggle='tooltip' data-placement='right' data-html='true' title='"+hints+"'> "
							+ " <b> <span onClick='show_detail2(\""+door_id+"\", \""+lb_viewdata+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+door_desc+"'> "+ door_id +" </span> </b> &nbsp;&nbsp; ";
			}else{
				if(!(door_id.equals(old_door))){
					if(!(locate_code.equals(old_locate))){
						per_row = 2;
%>
			<tr>
				<td width="10%" align="center"> <%= display_locate %> </td>
				<td width="90%" align="left" class="pad-left-10"> <%= display_door %> </td>
			</tr>	
<%			
						display_locate = " <b> <span onClick='show_detail3(\""+locate_code+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+locate_desc+"'> "+ locate_code +" </span> </b> ";
						display_door = " <img src='"+img+"' style='cursor: default;' width='18' height='18' align='absmiddle' border='0' data-toggle='tooltip' data-placement='right' data-html='true' title='"+hints+"'> "
									+ " <b> <span onClick='show_detail2(\""+door_id+"\", \""+lb_viewdata+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+door_desc+"'> "+ door_id +" </span> </b> &nbsp;&nbsp; ";
					}else{
						display_locate = " <b> <span onClick='show_detail3(\""+locate_code+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+locate_desc+"'> "+ locate_code +" </span> </b> ";
						display_door += " <img src='"+img+"' style='cursor: default;' width='18' height='18' align='absmiddle' border='0' data-toggle='tooltip' data-placement='right' data-html='true' title='"+hints+"'> "
									+ " <b> <span onClick='show_detail2(\""+door_id+"\", \""+lb_viewdata+"\");' style='color: #337AB7; cursor: pointer; cursor: hand;' data-toggle='tooltip' data-placement='right' title='"+door_desc+"'> "+ door_id +" </span> </b> &nbsp;&nbsp; ";
						if(per_row == 12){
							per_row = 0;
							display_door += "<br/>";
						}
						per_row++;
					}	
				}				
			}
			old_locate = locate_code;
			old_door = door_id;
		}	rs.close();
		
		if(count_row != 0){	
%>
			<tr>
				<td width="10%" align="center"> <%= display_locate %> </td>
				<td width="90%" align="left" class="pad-left-10"> <%= display_door %> </td>
			</tr>
<%
		}
	}catch(SQLException e){							
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
	}
%>
   </table>
		
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
		</script>
</body>
</html>

<%@ include file="../function/disconnect.jsp"%>