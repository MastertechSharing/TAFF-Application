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
		</script>	
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px;">		
		<form id="form1" name="form1" method="post">		
<%	
		String keyword = "";
		String modes = "";
		String ac = "";
		String ac_code = "";
		String sec_code = "", sec_name = "";
		if((request.getParameter("keyword") != null) && (request.getParameter("keyword") != "")){
			keyword = new String (request.getParameter("keyword").getBytes("ISO8859_1"),"TIS-620").trim();
		}
		if(request.getParameter("mode") != null){
			modes = request.getParameter("mode");
		}
		if(request.getParameter("ac") != null){
			ac = request.getParameter("ac");
		}
		
		String sql = "";
		String head_code = "";
		String head_desc = "";	
		if(ac.equals("server")){
			sql = "SELECT server_code AS code, server_code, server_ip FROM dbserver_config ";
			if(!(keyword.equals(""))){
				sql += "WHERE (server_code like '%"+keyword+"%') OR (server_ip like '%"+keyword+"%') ";
			}
			sql += "ORDER BY server_code ";
			
			head_code = lb_servercode;
			head_desc = lb_hostip;
		}else if(ac.equals("location")){
			sql = "SELECT locate_code AS code, locate_code, th_desc, en_desc FROM dblocation ";
			if(!(keyword.equals(""))){
				sql += "WHERE (locate_code like '%"+keyword+"%') ";
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}
			}
			sql += "ORDER BY locate_code ";
			
			head_code = lb_locatecode;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}			
		}else if(ac.equals("door")){
			sql = "SELECT door_id AS code, door_id, th_desc, en_desc, ip_address FROM dbdoor ";
			if(!(keyword.equals(""))){
				sql += "WHERE (door_id like '%"+keyword+"%') OR (ip_address like'%"+keyword+"%') ";
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}
			}
			sql += "ORDER BY door_id ";
			
			head_code = lb_doorcode;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}			
		}else if(ac.equals("reader")){
			sql = "SELECT reader_no AS code, reader_no, th_desc, en_desc FROM dbreader ";
			if(!(keyword.equals(""))){
				sql += "WHERE (reader_no like '%"+keyword+"%') ";				
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}
			} 
			sql += "ORDER BY reader_no ";
			
			head_code = lb_readerno;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}		  
		}else if(ac.equals("event")){			
			sql = "SELECT event_code AS code, event_code, th_desc, en_desc FROM dbevent ";			
			if(request.getParameter("ac_code") != null){
				ac_code = request.getParameter("ac_code");
			}
			if(ac_code.equals("1")){					
				sql += "WHERE ((event_code BETWEEN '01' AND '24') OR (event_code = '47')) ";
			}else if(ac_code.equals("2")){
				sql += "WHERE ((event_code BETWEEN '25' AND '50') AND (event_code <> '47')) ";
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
			sql += "ORDER BY event_code ";
			
			head_code = lb_eventcode;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}
		}else if(ac.equals("holiday")){			
			if(mode == 0){
				sql = "SELECT date_format(holi_date,'%d/%m/%Y') AS code, ";
			}else if(mode == 1){
				sql = "SELECT convert(varchar, holi_date, 103) AS code, ";
			}
			sql += "holi_date, th_desc, en_desc FROM dbholiday ";
			if(!(keyword.equals(""))){
				sql += "WHERE (holi_date like '%"+keyword+"%') ";				
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}
			}
			sql += "ORDER BY holi_date ";
			
			head_code = lb_date;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}			
		}else if(ac.equals("workcode")){
			sql = "SELECT work_code AS code, work_code, th_desc, en_desc FROM dbworkcode ";
			if(!(keyword.equals(""))){
				sql += "WHERE (work_code like '%"+keyword+"%') ";
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}
			}
			sql += "ORDER BY work_code ";
			
			head_code = lb_work_code;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}			
		}else if(ac.equals("timedesc")){
			sql = "SELECT time_id AS code, time_id, th_desc, en_desc FROM dbtimedesc ";
			if(!(keyword.equals(""))){
				sql += "WHERE (time_id like '%"+keyword+"%') ";
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}
			}
			sql += "ORDER BY time_id ";
			
			head_code = lb_timeid;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}								
		}else if(ac.equals("timezone")){
			sql = "SELECT time_code AS code, time_code, th_desc, en_desc FROM dbtimezonedesc ";
			if(!(keyword.equals(""))){
				sql += "WHERE (time_code like '%"+keyword+"%') ";
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}
			}
			sql += "ORDER BY time_code ";
			
			head_code = lb_timecode;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}		
		}else if(ac.equals("unlock")){
			sql = "SELECT day_type AS code, day_type FROM dbunlock ";
			if(!(keyword.equals(""))){
				sql += "WHERE (day_type like '%"+keyword+"%') ";				
			}
			sql += "ORDER BY day_type ";
			
			head_code = lb_no;
			head_desc = lb_day;
		}else if(ac.equals("lock")){
			sql = "SELECT day_type AS code, day_type FROM dblock ";
			if(!(keyword.equals(""))){
				sql += "WHERE (day_type like '%"+keyword+"%') ";				
			}
			sql += "ORDER BY day_type ";
			
			head_code = lb_no;
			head_desc = lb_day;
		}else if(ac.equals("timeonoutput4")){
			sql = "SELECT day_type AS code, day_type FROM dbtimeon_out4 ";
			if(!(keyword.equals(""))){
				sql += "WHERE (day_type like '%"+keyword+"%') ";				
			}
			sql += "ORDER BY day_type ";
			
			head_code = lb_no;
			head_desc = lb_day;
		}else if(ac.equals("depart")){
			sql = "SELECT dep_code AS code, dep_code, th_desc, en_desc FROM dbdepart ";
			if(!(keyword.equals(""))){
				sql += "WHERE (dep_code like '%"+keyword+"%') ";
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}
			}
			sql += "ORDER BY dep_code ";
			
			head_code = lb_departcode;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}
		}else if(ac.equals("section")){
			sql = "SELECT s.sec_code AS code, s.sec_code, s.th_desc, s.en_desc FROM dbsection s ";
			if(ses_per == 0 || ses_per == 3 || ses_per == 4){
				
			}else{
				sql += "LEFT JOIN dbdepart d ON (d.dep_code = s.dep_code) LEFT JOIN dbusers u ON (u.dep_code = d.dep_code) "
				+"WHERE (u.user_name = '"+ses_user+"') ";				
			}
			if(!(keyword.equals(""))){	
				if(ses_per == 0 || ses_per == 3 || ses_per == 4){
					sql += "WHERE (s.sec_code like '%"+keyword+"%') ";
				}else{
					sql += "AND (s.sec_code like '%"+keyword+"%') ";
				}
				if(lang.equals("th")){
					sql += "OR (s.th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (s.en_desc like '%"+keyword+"%') ";
				}
			}			
			sql += "ORDER BY s.sec_code ";				
			
			head_code = lb_seccode;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}		
		}else if(ac.equals("position")){
			sql = "SELECT pos_code AS code, pos_code, th_desc, en_desc FROM dbposition ";
			if(!(keyword.equals(""))){
				sql += "WHERE (pos_code like '%"+keyword+"%') ";
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}				
			}
			sql += "ORDER BY pos_code ";
			
			head_code = lb_poscode;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}		
		}else if(ac.equals("type_employee")){
			sql = "SELECT type_code AS code, type_code, th_desc, en_desc FROM dbtype ";
			if(!(keyword.equals(""))){
				sql += "WHERE (type_code like '%"+keyword+"%') ";
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}				
			}
			sql += "ORDER BY type_code ";
			
			head_code = lb_typecode;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}			
		}else if(ac.equals("group")){		
			sql = "SELECT group_code AS code, group_code, th_desc, en_desc FROM dbgroup ";
			if(!(keyword.equals(""))){
				sql += "WHERE (group_code like '%"+keyword+"%') ";
				if(lang.equals("th")){
					sql += "OR (th_desc like '%"+keyword+"%') ";
				}else{
					sql += "OR (en_desc like '%"+keyword+"%') ";
				}				
			} 
			sql += "ORDER BY group_code ";
			
			head_code = lb_groupcode;
			if(lang.equals("th")){
				head_desc = lb_thdesc;
			}else{
				head_desc = lb_endesc;
			}						
		}else if(ac.equals("employee") || (ac.equals("employee2")) || ac.equals("InOutByPerson") || ac.equals("InOutByPersonQuick")){	
			
			String where_sec_code1 = "", where_sec_code2 = "";
			if( ac.equals("employee") ){
				sec_code = request.getParameter("sec_code");
				where_sec_code1 = " AND sec.sec_code = '"+sec_code+"' ";
				where_sec_code2 = " AND emp.sec_code = '"+sec_code+"' ";
			}
			
			sql = "SELECT emp.idcard AS code, emp.idcard, emp.th_fname AS e_th_fname, emp.th_sname AS e_th_sname, "
					+ "emp.en_fname AS e_en_fname, emp.en_sname AS e_en_sname FROM dbemployee emp ";
			if(ses_per == 1 || ses_per == 2 || ses_per == 5 || ses_per == 6){	
				sql += "LEFT OUTER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
						+ "LEFT OUTER JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
						+ "LEFT OUTER JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
			}
			sql += " WHERE idcard != '****************' ";
			
			if(!(ses_per == 0 || ses_per == 3 || ses_per == 4)){
				sql += " AND (users.user_name = '"+ses_user+"') " + where_sec_code1;	
			}else{
				sql += where_sec_code2;	
			}
			if(!(keyword.equals(""))){
				sql += " AND ((emp.idcard like '%"+keyword+"%') ";
				if(lang.equals("th")){
					sql += "OR (emp.th_fname like '%"+keyword+"%') OR (emp.th_sname like '%"+keyword+"%')) ";
				}else{
					sql += "OR (emp.en_fname like '%"+keyword+"%') OR (emp.en_sname like '%"+keyword+"%')) ";
				}
			}else{
				if(ac.equals("employee")){
					if(ses_per == 5 || ses_per == 6){	
						sql += " AND sec.sec_code = '"+sec_code+"' ";
					}
				}
			}
			sql += "ORDER BY emp.idcard ";
			head_code = lb_empcode;
			head_desc = lb_names;
		}
	%>
			<div class="table-responsive" style="border: 0px !important; margin-top: -10px; margin-bottom: -15px;" border="0">
				<div style="min-width: 800px;" class="table" border="0">
					<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;"> 
					<%	if( ac.equals("employee") ){
							//	get sec_desc for IE
							ResultSet rs1 = stmtQry.executeQuery(" select sec_code, th_desc, en_desc from dbsection where sec_code = '"+request.getParameter("sec_code")+"' ");	
							rs1.next();
							if(lang.equals("th")){
								sec_name = rs1.getString("sec_code") + " - " + rs1.getString("th_desc");
							}else{
								sec_name = rs1.getString("sec_code") + " - " + rs1.getString("en_desc");
							}
							rs1.close();
					%>
						<div class="row">
							<h5 class="modal-title col-xs-2 col-md-2" style="margin-top: 0px; margin-bottom: 8px;"> <div align="right"> <b> <%= lb_sect %> : </b> </div> </h5>
							<h5 class="modal-title col-xs-8 col-md-8" style="margin-top: 0px; margin-bottom: 8px;"> <%= sec_name %> </h5>
						</div>
					<%	}	%>
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
						<%										
							ResultSet rs =  null;	
							int count = 0;		
							String code = "";
							String desc = "";
							if( (ac.equals("server")) || (ac.equals("location")) || (ac.equals("reader")) || (ac.equals("event")) 
								|| (ac.equals("holiday")) || (ac.equals("workcode")) || (ac.equals("timedesc")) || (ac.equals("timezone")) 
								|| (ac.equals("depart")) || (ac.equals("section")) || (ac.equals("position"))
								|| (ac.equals("type_employee")) || (ac.equals("group")) || (ac.equals("employee"))
								|| (ac.equals("employee2"))){
						%>		
								<table style="min-width: 760px; margin-bottom: -5px;" class="table table-bordered table-hover" align="center" border="0">
									<thead>
										<tr class="active">
										  <td width="20%" align="center"> <%= head_code %> </td>
										  <td width="70%" align="center"> <%= head_desc %> </td>
										  <td width="10%" align="center"> <%= lb_select %> </td>
										</tr>
									</thead>
						<%		try{
									rs = stmtQry.executeQuery(sql);	
									while(rs.next()){
										count ++;		
										code = rs.getString("code");
										if(ac.equals("employee") || ac.equals("employee2")){
											if(lang.equals("th")){
												desc = rs.getString("e_th_fname")+" "+rs.getString("e_th_sname");
											}else{
												desc = rs.getString("e_en_fname")+" "+rs.getString("e_en_sname");
											} 
										}else if(ac.equals("server")){
											desc = rs.getString("server_ip");
										}else{
											if(lang.equals("th")){
												desc = rs.getString("th_desc");
											}else{
												desc = rs.getString("en_desc");
											} 
										}
						%>						  
									<tr>
										<td align="center"> <%= code %> </td>
										<td class="pad-left-10"> <%= desc %> </td>
										<td align="center">
									<%	if(ac.equals("employee")){	%>
											<img src="images/complete.gif" width="20" height="20" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="add_value_selectID('<%= code %>', '<%= modes %>', 'report_data2_pdf.jsp');">
									<%	}else if(ac.equals("employee2")){	%>
											<img src="images/complete.gif" width="20" height="20" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="add_value_select_emp('<%= code %>', 'report_employee_detail.jsp');">
									<%	}else if(ac.equals("event")){	
											if(ac_code.equals("1")){	%>
												<img src="images/complete.gif" width="20" height="20" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="add_value_selectIDDesc('<%= code %>', '<%= desc %>', 'report_301.jsp');">
									<%		}else if(ac_code.equals("2")){	%>
												<img src="images/complete.gif" width="20" height="20" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="add_value_selectIDDesc('<%= code %>', '<%= desc %>', 'report_302.jsp');">
									<%		}else{	%>
												<img src="images/complete.gif" width="20" height="20" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="add_value_selectID('<%= code %>', '<%= modes %>', 'report_data1_pdf.jsp');">
									<%		}
										}else{	%>
											<img src="images/complete.gif" width="20" height="20" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="add_value_selectID('<%= code %>', '<%= modes %>', 'report_data1_pdf.jsp');">
									<%	}	%>
										</td>
									</tr>
						<% 			}	
									rs.close();
								}catch(SQLException e){							
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
								}
						%>
								</table>								
						<%	}else if(ac.equals("door")){	%>							
								<table style="min-width: 760px; margin-bottom: -5px;" class="table table-bordered table-hover" align="center" border="0">
									<thead>
										<tr class="active">
											<td width="20%" align="center"> <%= head_code %> </td>
											<td width="20%" align="center"> IP Address </td>
											<td width="50%" align="center"> <%= head_desc %> </td>
											<td width="10%" align="center"> <%= lb_select %> </td>
										</tr>
									</thead>
						<%		try{
									rs = stmtQry.executeQuery(sql);	
									while(rs.next()){	
										count ++;
										code = rs.getString("code");
										if(lang.equals("th")){
											desc = rs.getString("th_desc");
										}else{
											desc = rs.getString("en_desc");
										}
						%>						  
									<tr>
										<td align="center"> <%= code %> </td>
										<td align="center"> <%= rs.getString("ip_address") %> </td>
										<td class="pad-left-10"> <%= desc %> </td>
										<td align="center"> <img src="images/complete.gif" width="20" height="20" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="add_value_selectID('<%= code %>', '<%= modes %>', 'report_data1_pdf.jsp');"> </td>
									</tr>
						<% 			}	
									rs.close();
								}catch(SQLException e){							
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
								}
						%>
								</table>		  
						<%	}else if( (ac.equals("unlock")) || (ac.equals("lock")) || (ac.equals("timeonoutput4")) ){		%>							
								<table style="min-width: 760px; margin-bottom: -5px;" class="table table-bordered table-hover" align="center" border="0">
									<thead>
										<tr class="active">
											<td width="20%" align="center"> <%= head_code %> </td>
											<td width="70%" align="center"> <%= head_desc %> </td>
											<td width="10%" align="center"> <%= lb_select %> </td>
										</tr>
									</thead>
						<%		try{			
									rs = stmtQry.executeQuery(sql);	
									while(rs.next()){
										count ++;
										code = rs.getString("code");
										desc = getLongDay(Integer.parseInt(code), lang);
						%>						  
									<tr>
										<td align="center"> <%= code %> </td>
										<td class="pad-left-10"> <%= desc %> </td>
										<td align="center">	<img src="images/complete.gif" width="20" height="20" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="add_value_selectID('<%= code %>', '<%= modes %>', 'report_data1_pdf.jsp');"> </td>
									</tr>
						<% 			}	
									rs.close();
								}catch(SQLException e){							
									out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
								}
						%>
								</table>		  
						<%	}	%>
							</div>
						</div>
					</div>					
				</div>
			</div>
		</form> 		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>