<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>

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
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script>
			document.onkeydown = searchKeyPress;
			
			function onSubmit(){				
				window.document.form1.submit();
			}
			
			function set_value(event_id, event_name){
				parent.window.$('#event_id').val(event_id);
				parent.window.$('#event_name').val(event_name);
				parent.window.$('#myModalViewDetail').modal('hide');
			}
		</script>	
	</head>
 
	<%	
		String keyword = "";
		if((request.getParameter("keyword") != null) && (request.getParameter("keyword") != "")){
			keyword = new String (request.getParameter("keyword").getBytes("ISO8859_1"),"TIS-620").trim();
		} 	
	
	%>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px;">		
		<form id="form1" name="form1" method="post">
			<div class="table-responsive" style="border: 0px !important; margin-top: -10px; margin-bottom: -15px;" border="0">
				<div style="min-width: 800px;" class="table" border="0">
					<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;"> 
						<div class="row">
							<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 6px;"> <div align="right"> <b> <%= lb_finddata %> : </b> </div> </h5>
							<div class="modal-title col-xs-8 col-md-8"> 
								<input type="text" id="keyword" name="keyword" class="form-control" value="<%= keyword %>" onKeyPress="IsValidNumber()">
							</div>
							<div class="modal-title col-xs-2 col-md-2"> 
								<input type="button" id="btnok" class="btn btn-primary btn-sm button-shadow1 button-shadow2" onclick="return onSubmit();" value=" &nbsp; <%= btn_ok %> &nbsp; " onmouseover="this.style.cursor='hand';" />
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="table-responsive" style="border: 0px !important; margin-bottom: -50px;" border="0">
				<div style="min-width: 800px;" class="table" border="0">

					<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;"> 
						<div class="row">
							<div class="modal-title col-xs-12 col-md-12"> 
								<table style="min-width: 760px; margin-bottom: -5px;" class="table table-bordered table-hover" align="center" border="0">
									<thead>
										<tr class="active">
										  <td width="20%" align="center"> <%= lb_eventcode %> </td>
										  <td width="70%" align="center"> <% if(lang.equals("th")){ out.println(lb_thdesc); }else{ out.println(lb_endesc); } %> </td>
										  <td width="10%" align="center"> <%= lb_select %> </td>
										</tr>
									</thead>
							<%		
								try{
									String ac_code = "";
									if(request.getParameter("ac_code") != null){
										ac_code = request.getParameter("ac_code");
									}
									
									String sql = " SELECT event_code, th_desc, en_desc FROM dbevent ";
									if(ac_code.equals("1")){					
										sql += "WHERE ((event_code BETWEEN '01' AND '24') OR (event_code = '47')) ";
									}else if(ac_code.equals("2")){
										sql += "WHERE ((event_code BETWEEN '25' AND '50') AND (event_code != '47')) ";
									}
									if(!(keyword.equals(""))){
										if(ac_code.equals("")){
											sql += "WHERE (event_code like '%"+keyword+"%') ";
										}else{
											sql += "AND (event_code like '%"+keyword+"%') ";
										}
										if(lang.equals("th")){
											sql += "OR (th_desc like '%"+keyword+"%') ";
										}else{
											sql += "OR (en_desc like '%"+keyword+"%') ";
										}
									}
									sql += " ORDER BY event_code ASC ";
									
							
									int count = 0;		
									String event_code = "", desc = "";
									ResultSet rs = stmtQry.executeQuery(sql);	
									while(rs.next()){
										count ++;		
										event_code = rs.getString("event_code");
										if(lang.equals("th")){
											desc = rs.getString("th_desc");
										}else{
											desc = rs.getString("en_desc");
										} 
							%>						  
									<tr>
										<td align="center"> <%= event_code %> </td>
										<td class="pad-left-10"> <%= desc %> </td>
										<td align="center">
											<img src="images/complete.gif" width="20" height="20" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="set_value('<%= event_code %>', '<%= desc %>');">
										</td>
									</tr>
							<% 			
									}	rs.close();
								}catch(SQLException e){							
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
								}
							%>
							</div>
						</div>
					</div>					
				</div>
			</div>
		</form> 		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>
