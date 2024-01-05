<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%		
	String ses_user = (String)session.getAttribute("ses_username");
	int ses_per = ((Integer)session.getAttribute("ses_permission")).intValue();
	String monitor_data = request.getParameter("monitor_data");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<link rel="stylesheet" href="../css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		<link href="../css/alert-messages.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="../js/jquery.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
		<script src="../js/alert_box.js"></script>
		
		<script>
			function success_renew(new_expire_date){
				parent.window.document.getElementById("new_date_expire").innerHTML = new_expire_date;
				setTimeout(function(){
					setTimeout(function(){
						parent.window.$("#myModalSuccessRenew").modal("show");
					}, 100);
					parent.window.$("#myModalConfirm").modal("hide");
				}, 250); 
			}
			
			function OK_Button(){
			<%	if(monitor_data.equals("0")){	%>
				window.top.location.href = 'home.jsp';
			<%	}else if(monitor_data.equals("1")){	%>
				window.top.location.href = 'monitor_door.jsp';
			<%	}	%>
				document.form1.submit();
			}
		</script>
		
	</head>
	
	<body>
		
		<form id="form1" name="form1" method="post">
<%	
	String ex_date = request.getParameter("ex_date");
	if(ses_per != 9){
		String new_ex_date = incDayCalendar(ex_date, 365);
		try{
			resultQry = stmtUp.executeUpdate("UPDATE dbusers SET ex_date = '" + new_ex_date + "' WHERE (user_name = '" + ses_user + "') ");
			if (resultQry != 0) {
				rc.WriteDataLogFile("[" + ses_user + "] Renew expire date : " + new_ex_date + " [dbusers]");
				out.println("<script> success_renew('"+YMDTodate(new_ex_date)+"'); </script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	}
%>	
		</form>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>