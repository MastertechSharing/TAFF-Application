<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	
	String ip = "", door_id = "", idcard = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("idcard") != null){
		idcard = new String(request.getParameter("idcard").getBytes("ISO8859_1"),"tis-620").trim();
	}
	session.setAttribute("action", "readtransactioncard_report2.jsp?ip="+ip+"&door_id="+door_id+"&idcard="+idcard+"&");
%>
<span/>
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
		<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">

		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script language="javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
	</head>

	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="sendRequest(); ShowCurrentTime(); updateClock();">

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
			
		String empname = "";
		rs = stmtQry.executeQuery("SELECT th_fname, th_sname, en_fname, en_sname FROM dbemployee e WHERE (idcard = '"+idcard+"')");
		while(rs.next()){
			if(lang.equals("th")){
				empname = rs.getString("th_fname")+" "+rs.getString("th_sname");
			}else{
				empname = rs.getString("en_fname")+" "+rs.getString("en_sname");
			}
		}
		rs.close();
		
		String pathfile = "";
		if(!ip.equals("")){
			pathfile = path_data+ip+"\\ID\\"+idcard+".CFG";
		}else{
			pathfile = path_data+door_id+"\\ID\\"+idcard+".CFG";
		}
		File f = new File(pathfile);
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("<span class='alert-link'> "+msg_not_file_upload+" "+lb_datatransaction+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
%>	
			<div class="alert alert-info" role="alert">
				<span class="alert-link"> <%= lb_datatransaction %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> <br/> <% out.println(lb_empcode+" "+idcard+" : "+empname); %> </span>
			</div>
			
			<div class="table-responsive" style="border: 0px !important; margin-left: 0px; margin-right: 0px;" border="0">
				<div style="min-width: 1000px; max-width: 100%; margin-left: 0px; margin-right: -30px;" class="table" border="0">
				
					<table style="min-width: 1000px;" class="table table-hover" align="center" id="table1" border="0">
						<thead>
							<tr>
								<td width="10%" align="center"> <label class="control-label"> <%= lb_no %> </label> </td>
								<td width="20%" align="center"> <label class="control-label"> <%= lb_date %> </label> </td>
								<td width="20%" align="center"> <label class="control-label"> <%= lb_time %> </label> </td>
								<td width="20%" align="center"> <label class="control-label"> <%= lb_duty %> </label> </td>
								<td width="30%" align="center"> <label class="control-label"> <%= lb_readerno %> </label> </td>
							</tr>
						</thead>
						</tbody>
<%					
			BufferedReader in = new BufferedReader(new FileReader(pathfile));
			String textStr = "";
			String mm = "", dd = "", yy = "", hh = "", mn = "", duty = "", shift = "", taff = "", date_show = "", time_show = "";
			int i = 1;
			while((textStr = in.readLine()) != null){
				if((textStr.length() == 16) && (!(textStr.equals("2020202020202020") || textStr.equals("FFFFFFFFFFFFFFFF") || textStr.equals("ffffffffffffffff") || textStr.equals("0000000000000000")))){
					mm = textStr.substring(0, 2);
					dd = textStr.substring(2, 4);
					yy = textStr.substring(4, 6);
					hh = textStr.substring(6, 8);
					mn = textStr.substring(8, 10);
					duty = textStr.substring(10, 12);
					shift = textStr.substring(12, 14);
					taff = textStr.substring(14, 16);
					date_show = dd+"/"+mm+"/20"+yy;
					time_show = hh+":"+mn;
				}else{	
					duty = "";
					taff = "";	
					date_show = "";
					time_show = "";
				}
%>		
							<tr>
								<td align="center"> <%= i++ %> </td>
								<td align="center"> <%= date_show %> </td>
								<td align="center"> <%= time_show %> </td>
								<td align="center"> <%= convertHexToString(duty) %> </td>
								<td align="center"> <%= taff %> </td>
							</tr>
<% 
			}
			in.close();
		}
	}catch(IOException e){
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
	}
%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<script>
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