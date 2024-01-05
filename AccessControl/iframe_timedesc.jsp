<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script language="javascript" src="js/select_ajax.js"></script>
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/check_key.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script language="javascript">
			function add_valueID(hh1, mm1, hh2, mm2, hh3, mm3, hh4, mm4, hh5, mm5, hh6, mm6, hh7, mm7, hh8, mm8, hh9, mm9, hh10, mm10){
				var req = Inint_AJAX();
				req.onreadystatechange = function (){
					if(req.readyState == 4){
						if(req.status == 200){
							var ret = req.responseText;
							if(ret != null){
								parent.window.document.getElementById("hh1").value = hh1;
								parent.window.document.getElementById("mm1").value = mm1;						
								parent.window.document.getElementById("hh2").value = hh2;
								parent.window.document.getElementById("mm2").value = mm2;
								parent.window.document.getElementById("hh3").value = hh3;
								parent.window.document.getElementById("mm3").value = mm3;
								parent.window.document.getElementById("hh4").value = hh4;
								parent.window.document.getElementById("mm4").value = mm4;
								parent.window.document.getElementById("hh5").value = hh5;
								parent.window.document.getElementById("mm5").value = mm5;
								parent.window.document.getElementById("hh6").value = hh6;
								parent.window.document.getElementById("mm6").value = mm6;	
								parent.window.document.getElementById("hh7").value = hh7;
								parent.window.document.getElementById("mm7").value = mm7;
								parent.window.document.getElementById("hh8").value = hh8;
								parent.window.document.getElementById("mm8").value = mm8;
								parent.window.document.getElementById("hh9").value = hh9;
								parent.window.document.getElementById("mm9").value = mm9;
								parent.window.document.getElementById("hh10").value = hh10;
								parent.window.document.getElementById("mm10").value = mm10;		  		  
								
								window.top.$("#myModalViewDetail").modal('hide');
							}
						}
					}  
				};
				req.open("POST", "edit_unlock.jsp"); //	Create connection
				req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620"); // Set Header
				req.send("hh1="+hh1+"&mm1="+mm1+"&hh2="+hh2+"&mm2="+mm2+"&hh3="+mm3+"&hh4="+mm4+"&hh5="+hh5+"&mm5="+mm5+"&hh6="+hh6+"&mm6="+mm6+"&hh7="+mm7+"&hh8="+hh8+"&mm8="+mm8+"&hh9="+mm9+"&hh10="+hh10+"&mm10="+mm10); //Send data	
			}
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px;">		
		<form id="form1" name="form1" method="post">
		<div class="row" style="min-width: 825px; border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
			<div class="bs-callout bs-callout-info"> 			
				<table style="min-width: 800px; margin-bottom: 0px;" class="table table-bordered table-hover" align="center" border="0">
					<thead>
						<td width="10%" align="center" > <b> <%= lb_timeid %> </b> </td>
						<td width="16%" align="center" > <b> <%= lb_timezone %> 1 </b> </td>
						<td width="16%" align="center" > <b> <%= lb_timezone %> 2 </b> </td>
						<td width="16%" align="center" > <b> <%= lb_timezone %> 3 </b> </td>
						<td width="16%" align="center" > <b> <%= lb_timezone %> 4 </b> </td>
						<td width="16%" align="center" > <b> <%= lb_timezone %> 5 </b> </td>
						<td width="10%" align="center" > <b> <%= lb_select %> </b> </td>
					</thead>
			<%	String keyword = "";
				String modes = "";
				if((request.getParameter("keyword") != null) && (request.getParameter("keyword") != "") ){
					keyword = new String (request.getParameter("keyword").getBytes("ISO8859_1"),"TIS-620");
				}
				if(request.getParameter("mode") != null){
					modes = request.getParameter("mode");
				} 	
				int count = 0;					
				try{			
					ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbtimedesc WHERE (time_id LIKE '%"+keyword+"%') OR (th_desc LIKE '%"+keyword+"%') ORDER BY time_id ASC");			
					while(rs.next()){
						count ++;
						String time1 = rs.getString("time1");
						String time2 = rs.getString("time2");
						String time3 = rs.getString("time3");
						String time4 = rs.getString("time4");
						String time5 = rs.getString("time5");
			%>
					<tr>
						<td align="center"> <%= rs.getString("time_id") %> </td>
						<td align="center"> <%= changeTime(time1) %> </td>
						<td align="center"> <%= changeTime(time2) %> </td>
						<td align="center"> <%= changeTime(time3) %> </td>
						<td align="center"> <%= changeTime(time4) %> </td>
						<td align="center"> <%= changeTime(time5) %> </td>
						<td align="center">
							<img src="images/complete.gif" width="20" height="20" border="0" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="add_valueID('<%= getTime(time1, 1) %>', '<%= getTime(time1, 2) %>', '<%= getTime(time1, 3) %>', '<%= getTime(time1,4) %>','<%= getTime(time2, 1) %>', '<%= getTime(time2, 2) %>', '<%= getTime(time2, 3) %>', '<%= getTime(time2, 4) %>', '<%= getTime(time3, 1) %>', '<%= getTime(time3, 2) %>', '<%= getTime(time3, 3) %>', '<%= getTime(time3, 4) %>', '<%= getTime(time4, 1) %>', '<%= getTime(time4, 2) %>', '<%= getTime(time4, 3) %>', '<%= getTime(time4, 4) %>', '<%= getTime(time5, 1) %>', '<%= getTime(time5, 2) %>', '<%= getTime(time5, 3) %>', '<%= getTime(time5, 4) %>');" data-toggle="tooltip" data-placement="left" data-container="body" title="<%= lb_sel_timezone %>">
						</td>
					</tr>					
			<% 			}	rs.close();	
					}catch(SQLException e){		
						out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
					}				
			%>
				</table>
			</div>
		</div>			
		</form> 		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>