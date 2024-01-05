<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "special"); 
	session.setAttribute("action", "report_maintenance_pdf.jsp?");
%>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<script language="javascript" src="js/alert_box.js"></script>

	<link rel="stylesheet" href="css/taff.css" type="text/css">

	<!-- Bootstrap -->
	<link href="css/bootstrap.min.css" rel="stylesheet">
	<link href="css/bootstrap-select.min.css" rel="stylesheet">
	<link href="css/alert-messages.css" rel="stylesheet">

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootstrap-select.min.js"></script>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script src="js/ie10-viewport-bug-workaround.js"></script>
	<script src="js/ie-emulation-modes-warning.js"></script>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	<%@ include file="../tools/modal_danger.jsp"%>
	<div class="body-display">
		<div class="container">

			<form name="form1" name="form1" method="post">
				<%	
				screen = checkScreen(request.getParameter("screen"));		
				//เปลี่ยน รูปแบบวันที่
				String date1 = dateToYMD(request.getParameter("st_date"));
				String date2 = dateToYMD(request.getParameter("ed_date"));
				String repid =  request.getParameter("rep_id");				
				String dtNote = "";
				String descNote = "";
				String usname_add = "";
				String dtuname_add = "";
				String usname_edit = "";
				String dtuname_edit = "";
				String unameadd = "", unameedit = "";
				String adddate1 = "", editdate1 = ""; 
				
				if(date1.compareTo(date2) > 0){
					out.println("<script> ModalDanger_10Second('"+msg_datetime_notvalid+"'); </script>");
				}
				if(request.getParameter("uname_add") != null  || request.getParameter("uname_add") != ""){  
					unameadd = request.getParameter("uname_add"); 
				}
				if(request.getParameter("uname_edit") != null  || request.getParameter("uname_edit") != ""){  
					unameedit = request.getParameter("uname_edit"); 
				}	
				String TempName = "tmp"+repid+"_"+getIP(request.getRemoteAddr());			
				try{		
					stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
					stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,"1000",mode));	
				}catch(SQLException e){ }
				
				String sql = ""; 
				if((ses_per == 0) || (ses_per == 1)){
					if(mode == 0){
						sql = "SELECT *, substring(datetime_note, 1, 19) AS dtnote FROM dbnote "
							+ "WHERE (substring(datetime_note, 1, 10) BETWEEN '"+date1+"'  AND '"+date2+"') ";			 
					}else{
						sql = "SELECT *, datetime_note AS dtnote FROM dbnote "
							+ "WHERE (datetime_note BETWEEN '"+date1+"' AND '"+date2+"') ";		
					}
				}
				if(!(unameadd == null||unameadd.equals("")||unameadd.equals("null"))){
					sql = sql + "AND (user_add = '"+unameadd+"') ";	//	AND substring(datetime_add,1,10)='"+adddate1+"'						
				}
				if(!(unameedit == null||unameedit.equals("")||unameedit.equals("null"))){
					sql = sql + "AND (user_edit = '"+unameedit+"') ";						
				}
				sql = sql + "ORDER BY datetime_note";				
				
				int row_count = 0;
				String sqlTmp = "";
				ResultSet rs = null;
				try{
					rs = stmtQry.executeQuery(sql);	
					while(rs.next()){
						row_count++;
						if(mode == 0){
							dtNote = rs.getString("dtnote");
						}else if(mode == 1){
							dtNote = rs.getString("dtnote").substring(0, 19);
						}
						descNote = rs.getString("desc_note");
						usname_add = rs.getString("user_add");
						dtuname_add = rs.getString("datetime_add").substring(0,19);
						usname_edit = rs.getString("user_edit");
						dtuname_edit = rs.getString("datetime_edit").substring(0,19);
						
						sqlTmp = "INSERT INTO "+TempName+"(id,dt_note,desc_note,useradd,dtadd,useredit,dtedit) "+
									"VALUES ('"+row_count+"','"+dtNote+"','"+descNote+"','"+usname_add+"','"+dtuname_add+"','"+usname_edit+"','"+dtuname_edit+"')";
						stmtUp.executeUpdate(sqlTmp);
					}
					rs.close();
				}catch(SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
				}				
				totalRow = getCountRecord(TempName,stmtQry);							
				totalPage = (int)Math.ceil((double)totalRow/(double)rowOfPage);					
%>
				<div class="table-responsive"
					style="border: 0px !important; margin: -45px -15px -15px -15px;">
					<div style="min-width: 1050px;" class="table" border="0">

						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">

								<div class="bs-callout bs-callout-info">
									<div class="row alert-message-info"
										style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: -10px;">
										<label class="col-xs-6 col-md-6 control-label"
											style="margin-top: 5px;"> <i
											class="glyphicon glyphicon-list-alt"> </i> &nbsp; <a
											href="report_maintenance.jsp"> <%= lb_maintenance %>
										</a>
										</label> <label class="col-xs-4 col-md-4"
											style="margin-top: 5px; text-align: right;"> <%= lb_all %>
											<%= nf1.format(row_count) %> <%= lb_record %> &nbsp;
										</label> <label class="col-xs-2 col-md-2"
											style="margin-top: 5px; text-align: right;"> 
												<%	startRow = (screen - 1) * rowOfPage; 
													if(totalPage != 0){
														if(totalRow == 0){
															out.print(lb_record + " " + "0" + " - "); 
														}else{
															out.print(lb_record + " " + nf1.format(startRow + 1) + " - ");
														}
														if(screen == totalPage){
															out.print(nf1.format(totalRow));
														}else{
															out.print(nf1.format(startRow + rowOfPage));
														}
													}
												%>&nbsp;
										</label>
									</div>
								</div>

							</div>
						</div>

					</div>
				</div>

				<div class="table-responsive"
					style="border: 0px !important; margin: -25px -15px -95px -15px;">
					<div style="min-width: 1050px;" class="table" border="0">

						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">

								<div class="bs-callout bs-callout-info">
									<div class="row" align="center">
										<iframe name="show_body" width="97%" height="700" src="ReportMaintenance.do?st_date=<%= date1 %>&ed_date=<%= date2 %>&rep_id=<%= repid %>&lang=<%= lang %>" frameborder="0" scrolling="yes"></iframe>
									</div>
								</div>

							</div>
						</div>

					</div>
				</div>

			</form>

		</div>
	</div>

</body>
</html>

<%@ include file="../function/disconnect.jsp"%>