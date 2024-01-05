<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<script language="javascript" src="js/select_ajax.js"></script>
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/check_key.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script language="javascript">
			function add_valueID(lang){	
				var req = Inint_AJAX();
				var loop = 0;
				var i;
				var value_id = "";
				var value_chk = document.forms[0].check_empid;
				
				if(document.form1.check_empid == null){ //	Can't found employee
					value_id = "";
				}else{	
					if(value_chk.length == null){
						if(value_chk.checked){
							value_id = value_chk.value;	
						}else{
							value_id = "";
						}
					}else{ 		
						for(i = 0; i < value_chk.length; i++){
							if(value_chk[i].checked){
								loop = loop+1;
								if(loop != 1){
									value_id = value_id +","+ value_chk[i].value;
								}else{
									value_id = value_id + value_chk[i].value;
								}
							}
						}
					}		
				}
				
				if(value_id == ''){
					if(lang == "th"){
						alert('กรุณาเลือกรหัสพนักงาน');
					}else{
						alert('Please Select ID Card');
					}
					return false;
				}
				var txt;
				if (value_id != '') {
					if(lang == "th"){
						txt = "เลือกรหัสพนักงานแล้ว";
					}else{
						txt = "Selected ID Card";
					}      
				}
				parent.window.document.getElementById("lbtxt").innerHTML = txt;
				parent.window.document.getElementById("hidden_ID").value = value_id; 
				
				window.top.$("#myModalViewDetail").modal('hide');
				
				req.open("POST", "set_idtables_blacklist.jsp");
				req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620");
				req.send("hidden_ID="+value_id);
				req.send("lbtxt="+txt);
			}
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -60px; overflow-y: hidden;">
	
		<form name="form1" method="post">
			
			<div class="table-responsive" style="border: 0px !important; margin-bottom: -10px; margin-bottom: -50px;" border="0">
				<div style="min-width: 800px;" class="table" border="0">
					
					<div class="row" style="margin-left: 0px; margin-right: 0px;">
						
						<div class="modal-title col-xs-12 col-md-12">
						
							<div class="bs-callout bs-callout-info"> 
								<div class="row">
						
									<div style="overflow-y:scroll; overflow-x:hidden; height:380px; max-width:98%; margin-left: 10px;"> 
									<table class="table table-bordered table-hover" align="center" border="0" style="max-width: 100%; margin-bottom: 0px;">
										<thead>
											<tr class="active">
												<td width="25%" align="center"> <%= lb_empcode %> </td>
												<td width="70%" align="center"> <%= lb_names %> </td>
												<td width="5%" align="center">
													<input type="checkbox" name="checkall1" id="checkall1" value="*" onclick="checkAllObj(this, document.form1.check_empid, '<%= lang %>', 'emps');"/>
												</td>
											</tr>
										</thead>
										<tbody>
										
							<%	
								int count = 0;
								String sql = "SELECT emp.idcard, emp.sec_code, emp.group_code, ";
								if(mode == 0){
									if(lang.equals("th")){
										sql += "CONCAT(th_fname,' ',th_sname) AS em_name ";
									}else{
										sql += "CONCAT(en_fname,' ',en_sname) AS em_name ";
									}
								}else if(mode == 1){
									if(lang.equals("th")){
										sql += "th_fname+' '+th_sname AS em_name ";
									}else{
										sql += "en_fname+' '+en_sname AS em_name ";
									}
								}
								sql = sql + "FROM dbemployee emp ";
								sql = sql + "INNER JOIN dbblacklist bl ON (emp.idcard = bl.idcard) ";
	
								if(checkPermission(ses_per, "034")){
									
									sql = sql + "WHERE bl.cancel_status = '0'";
									sql = sql + "ORDER BY emp.idcard";	
								
								}else if(checkPermission(ses_per, "1256")){
									
									if(checkPermission(ses_per, "12")){
										sql += "INNER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
											+ "INNER JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
											+ "INNER JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
									}else if(checkPermission(ses_per, "56")){
										sql += "INNER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
											+ "INNER JOIN dbusers users ON (users.sec_code = sec.sec_code) ";
									}
									
									sql = sql + "WHERE bl.cancel_status = '0'";
									sql = sql + "AND (users.user_name = '"+ses_user+"')";
									sql = sql + "ORDER BY idcard";	
								
								}
								
								try{		
									ResultSet rs = stmtQry.executeQuery(sql);	
									while(rs.next()){
							%>	
											<tr>
												<td class="pad-left-10"> <%= rs.getString("idcard") %> </td>
												<td class="pad-left-10"> <div class="ellipsis_string" style="max-width: 220px"> <%= rs.getString("em_name") %> </div> </td>
												<td align="center">
													<input type="checkbox" name="check_empid" id="check_empid" value="<%= rs.getString("idcard") %>" onclick="checkSelectObj(document.form1.checkall1,document.form1.check_empid);"/>
												</td>	                           
											</tr>	
							<%		}	rs.close();
								}catch(SQLException e){
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
								}
								
								try{		
									sql = " SELECT bl.idcard, bl.fullname FROM dbblacklist bl "
										+ " WHERE bl.idcard NOT IN (SELECT emp.idcard FROM dbemployee emp) AND bl.cancel_status = '0' "
										+ " ORDER BY bl.idcard ASC ";
									ResultSet rs = stmtQry.executeQuery(sql);	
									while(rs.next()){
									
							%>		
											<tr>
												<td class="pad-left-10"> <%= rs.getString("idcard") %> </td>
												<td class="pad-left-10"> <div class="ellipsis_string" style="max-width: 460px"> <%= rs.getString("fullname") %> &nbsp; <i> [ <%= lb_notin_database %> ] </i> </div> </td>
												<td align="center">
													<input type="checkbox" name="check_empid" id="check_empid" value="<%= rs.getString("idcard") %>" onclick="checkSelectObj(document.form1.checkall1,document.form1.check_empid);"/>
												</td>	                           
											</tr>
							<%	
									}	rs.close();
								}catch(SQLException e){
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
								}
							%>
										</tbody>
									</table> 
									</div>
						
								</div>
								<p>
								<div class="row">
									<div class="modal-title col-xs-12 col-md-12" align="center">
										<input type="button" name="button" class="btn btn-primary btn-sm max-height-26 button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onclick="add_valueID('<%= lang %>')" onMouseOver="this.style.cursor='hand';"/></td>
									</div>
								</div>
							</div>
						
						</div>
					</div>
				</div>
			</div>	
		<%@ include file="../tools/modal_viewdetail.jsp"%>
		</form>
	
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>