<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/displaydata.jsp"%>

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
		<%= font_face %>		
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
    <table width="100%" border="1" align="left" cellpadding="0" cellspacing="0">
	<%
		String door_desc = "";
		String img = "";
		String groupimg = "";		
		String event_code = "";
		String old_code = "";
		String data_display = "";
		String textcode = "";			  
		String sql = "SELECT group_img,event_code,th_desc,en_desc "
				+"FROM dbevent "
				+"ORDER BY group_img,event_code";
				 
		try{
			ResultSet rs = stmtQry.executeQuery(sql);		
			int count_row = 0;
			while(rs.next()){	
				count_row++;	
				event_code = rs.getString("event_code");
				groupimg = rs.getString("group_img");			
				if(lang.equals("th")){															
					door_desc = rs.getString("event_code")+" : "+rs.getString("th_desc");
				}else{								
					door_desc = rs.getString("event_code")+" : "+rs.getString("en_desc");
				}
				
				img = displayImg(Integer.parseInt(groupimg));	
				textcode = displayText(Integer.parseInt(groupimg),lang);	
				if(count_row == 1){				
					data_display = "<span style='color: #333333;font-family: MS Sans Serif;font-weight: bold;font-size: 15px; '>"+textcode+"</span><br/>&nbsp;"+door_desc+"<br/>&nbsp;";
				}else{
					if(!groupimg.equals(old_code)){
						img = " <img src='"+displayImg(Integer.parseInt(old_code))+"' width='30' height='30' border='0'>";							
			   %>
				<tr>	
					<td width="15%" align="center"> <%= img %> </td>
					<td width="85%" align="left" class="pad-left-10"> 
					<div class="ellipsis_string" style="width: 315px"> <%= data_display %> </div> </td>
				</tr>    
			  <%										
						data_display =  "<span style='color: #333333;font-family: MS Sans Serif;font-weight: bold;font-size: 15px; '>"+textcode+"</span><br/>&nbsp;"+door_desc+"<br/>&nbsp;";
					}else{
						data_display = data_display+ door_desc+"<br/>&nbsp;";
					}
				}	 
				old_code = groupimg;					
			}rs.close();// while()			 		
				img = " <img src='"+displayImg(Integer.parseInt(old_code))+"' width='30' height='30' border='0'>";		
				textcode = displayText(Integer.parseInt(groupimg) ,lang);				
		%>
				<tr>	
					<td width="15%" align="center"> <%= img %> </td>
					<td width="85%" align="left" class="pad-left-10"> 
					<div class="ellipsis_string" style="width: 315px"> <%= data_display %> </div> </td>
				</tr>
	      <%		  
		}catch(SQLException e){	
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");			
		}		
	%>
        </table>
</body>
</html>
<%@ include file="../function/disconnect.jsp"%>