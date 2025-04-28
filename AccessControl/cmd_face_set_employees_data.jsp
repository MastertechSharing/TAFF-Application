<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%    
	session.setAttribute("page_g", "tool"); 
	session.setAttribute("subpage", "face");
	session.setAttribute("subtitle", "facesetemployees");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "cmd_face_set_employees_data.jsp?ip="+ip+"&door_id="+door_id+"&");	
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
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			.bs-callout-info {
				border-left-color: #1b809e;
			}
			.bs-callout {
				padding: 10px;
				margin: 10px 0;
				border: 1px solid #1b809e;
				border-left-width: 5px;
				border-radius: 3px;
			}
		</style>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">
			
<%  
	String sql = "", desc = "";
	int countRec = 0;	
	int resultOK = 0;
	int resultFail = 0;
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
			pathfile = path_data+ip+"\\EMPLOYEES.txt";
		}else{
			pathfile = path_data+door_id+"\\EMPLOYEES.txt";
		}
		File f = new File(pathfile);
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("	<span class='alert-link'> "+msg_not_file_upload+" "+lb_face_setemployees+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
%>
				<div class="alert alert-info" role="alert">
					<span class="alert-link"> <%= lb_face_setemployees %> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </span>
				</div>
				
				<table style="min-width: 800px;" class="table table-hover" align="center" id="table1" border="0">
					<thead>
						<tr>
							<td width="10%" align="center"> <label class="control-label"> <%= lb_no %> </div> </td>
							<td width="20%" align="center"> <label class="control-label"> <%= lb_empcode %> </div> </td>
							<td width="35%" align="center"> <label class="control-label"> <%= lb_names %> </div> </td>
							<td width="35%" align="center"> <label class="control-label"> <%= lb_comment %> </div> </td>
						</tr>
					</thead>
					</tbody>					
<%		
			BufferedReader in = new BufferedReader(new FileReader(pathfile));
			String textStr = "";
			String idcard = "", errMsg = "", th_desc = "", en_desc = "";					
			while((textStr = in.readLine()) != null){				
				String[] data = textStr.split(",");				
					idcard = data[0];
					errMsg = data[1];					
					countRec++;
					if (errMsg.trim().equals("Success")){
						resultOK++;
					}else{
						resultFail++;
					}					
					rs = stmtQry.executeQuery("SELECT * FROM dbemployee WHERE (idcard='"+idcard+"')");
					while(rs.next()){
						th_desc = rs.getString("th_fname")+"  "+rs.getString("th_sname");
						en_desc = rs.getString("en_sname")+"  "+rs.getString("en_sname");
					}
					rs.close();
%>
					<tr>
					   <td align="center"> <%= countRec %> </td>
					   <td align="center"> <%= idcard %> </td>   
					   <td class="pad-left-10"> <%= th_desc %> </td>
					   <td class="pad-left-10"> <%= errMsg %> </td>
					</tr>						
<%				
			}
			in.close();		
		}
	}catch(SQLException e){
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
	}	
	
	String resultStr = lb_total + " " + countRec + " " + lb_record + " " + lb_succ + " " + resultOK + " " +lb_record + " " + lb_notprocessuc + " " + resultFail + " " + lb_record;
%> 
					</tbody>
					<div class="col-xs-12 col-md-12"> <p> <b> <font style="color:blue"> <%= resultStr %> </font> </b> </p>  					
					</div> 
						
				</table>							
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
					save_excel.location.href = 'cmd_face_set_employees_excel.jsp?ip='+ip;
				}else{
					save_excel.location.href = 'cmd_face_set_employees_excel.jsp?door_id='+door_id;
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