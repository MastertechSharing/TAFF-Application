<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}	
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="max-width: 500px;">
	
<%	
	String idcard = request.getParameter("idcard");
	if(request.getParameter("idcard") != null){				
		String pathfile = "";
		if(!ip.equals("")){
			pathfile = path_data + ip + "\\" + idcard + ".jpg";
		}else{
			pathfile = path_data + door_id + "\\" + idcard + ".jpg";
		}
				
		ResultSet rs = null;
		String sql_employee = " SELECT ";
		if(lang.equals("th")){
			sql_employee += " th_fname AS fname, th_sname AS sname ";
		}else{
			sql_employee += " en_fname AS fname, en_sname AS sname ";
		}
		sql_employee += " FROM dbemployee WHERE idcard = '"+idcard+"' ";
		rs = stmtQry.executeQuery(sql_employee);
		if(rs.next()){
			idcard += " - " + rs.getString("fname")+" "+rs.getString("sname");
		}	
		rs.close();
				
%>		
		<div style="border: 0px !important; margin-bottom: -50px;" border="0">
			<div class="table" border="0">
				<div class="row" style="margin-left: 5px; margin-bottom: 5px;"> 
					<label class="control-label label-text-1 col-md-12"> <%= lb_empcode %> : <%= idcard %> </label>
				</div>								
				<div class="row"> 
					<div class="col-md-12" style="margin-left: 20px;" align="center">
						<img id="img_capture" class="img-rounded" src="data:image/jpeg;base64,<%= decodeToImage(pathfile, "jpg") %>" width="480" height="360" style="cursor: default;"> <br/> 
					</div>
				</div>
			</div>
		</div>
		
<%	}	%>

	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>