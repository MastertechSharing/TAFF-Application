<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="server.process.ConvertData"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%	
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "processfile");
	session.setAttribute("subtitle", "fileraw");  	
	session.setAttribute("action", "file_upload_text.jsp?");
	
	String stdate = "";
	String eddate = "";	
	String start_date = "";
	String stop_date = "";	
	String pages = request.getParameter("pages");
	if(pages == null) {
		stdate = getCurrentDate();
		eddate = getCurrentDate();
		start_date = dateToYMD(stdate);
		stop_date = dateToYMD(eddate);			
	}else if(pages.equals("process")) {
		stdate = request.getParameter("st_date");
		eddate = request.getParameter("st_date2");
		try{			
			// นำวันที่มาตัดสตริงเพื่อนำไปทำการเปรียบเทียบวันที่
			int startdate1 = Integer.parseInt(stdate.substring(6, 10) + stdate.substring(3, 5) + stdate.substring(0, 2));
			int expdate1 = Integer.parseInt(eddate.substring(6, 10) + eddate.substring(3, 5) + eddate.substring(0, 2));
			if(startdate1 > expdate1){
				start_date = dateToYMD(eddate);
				stop_date = dateToYMD(stdate);
			} else {
				start_date = dateToYMD(stdate);
				stop_date = dateToYMD(eddate);
			}	
		}catch(Exception e){
		
		}
	}	
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<script language="javascript" src="js/check_key.js"></script>
		<script language="javascript" src="js/check_input.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
		<script src="js/locales/bootstrap-datetimepicker.th.js" charset="UTF-8"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			table, tr, td { padding: 5px !important; }
		</style>
		
		<script>
			document.onkeydown = searchKeyPress;
		</script>
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>	
    
		<br/>
		<div class="body-display">
			<div class="container">
			
				<div class="col-md-12">
					<form name="form1" id="form1" method="post">
						<div class="panel panel-primary"> 
							<div class="panel-heading">
								<h3 class="panel-title"> <b> <%= lb_import_data_text %> [<%= lb_process_todatabase %>] </b> </h3> 
							</div> 
							<div class="panel-body"> 
							
								<div class="table-responsive" style="border: 0px !important;" border="0">
									<div style="min-width: 800px; max-width: 100%; margin-left: 15px; margin-right: 15px;" border="0">
								
										<div class="row">
											<label class="col-xs-2 col-md-2" style="margin-top: 6px;" align="right"> <%= lb_date %> </label>
											<div class="col-xs-3 col-md-3"> 
												<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date" data-link-format="dd/mm/yyyy">
													<input class="form-control" type="text" value="<%= stdate %>" readonly onKeyPress="IsValidNumberForDate();">
													<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
												</div>
												<input type="hidden" class="form-control" id="st_date" name="st_date" maxlength="10" value="<%= stdate %>" placeholder="<%= lb_date %>" readonly="readonly" style="background-color:#F0F0F0">
											</div>
											<label class="col-xs-2 col-md-2" style="margin-top: 6px;" align="right"> <%= lb_to_date %> </label>
											<div class="col-xs-3 col-md-3">
												<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date2" data-link-format="dd/mm/yyyy">
													<input class="form-control" type="text" value="<%= eddate %>" readonly onKeyPress="IsValidNumberForDate();">
													<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
												</div>
												<input type="hidden" class="form-control" id="st_date2" name="st_date2" maxlength="10" value="<%= eddate %>" placeholder="<%= lb_to_date %>" readonly="readonly" style="background-color:#F0F0F0">
											</div>
											<div class="col-xs-2 col-md-2" style="margin-bottom: 20px;" align="right">  
												<input type="button" name="button" id="btnok" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_process_text %> &nbsp; &nbsp; &nbsp; " onclick="return onSubmit_Ok('file_upload_text.jsp?pages=process');">
											</div>
										</div>
										
									</div>
								</div>
<%		
	try{
		if((pages != null) && pages.equals("process")) { 
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
			// แปลงวันที่ให้อยู่ในรูปแบบ Date = yyyy-MM-dd	
			Date d1 = sdf.parse(start_date);
			Date d2 = sdf.parse(stop_date);
			// นำวันที่เริ่มต้นเก็บในรูปแบบ Date 
			Date date_process = sdf.parse(start_date);
			
			String ip_string = getIP(request.getRemoteAddr());
			String TempName = "tmpraw_"+ip_string;
			String TempNotFound = "tmpnotfound_"+ip_string;
			try{				
				stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,"raw",mode));
				
				stmtUp.executeUpdate(dropTableTmpReport(db_database,TempNotFound,mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database, TempNotFound, "notfound", mode));				
			}catch(SQLException e){
				
			}
			
			int numfile_Success = 0; // นับไฟล์ที่พบ
			int numfile_Fail = 0; // นับไฟล์ที่ไม่สำเร็จ
			int numfile_NotFound = 0; // นับไฟล์ที่ไม่พบ
			int numfile_All = 0; // นับไฟล์ทั้งหมด
			int numfile_Found = 0; // นับไฟล์ที่ไม่พบ
			
			int countRecOK = 0;
			int countRecFail = 0;
			int countAllRec = 0;
			int countAllFail = 0;
			
			String fileSuccess = "";
			String fileFail = "";
			
			String pathFile = "";
			String fileName = "";			
			SimpleDateFormat sdf_file = new SimpleDateFormat("yyyyMMdd", Locale.US);			
			boolean isError = true;					
			boolean isProcess = true;
			while(isProcess){
				Calendar cal = Calendar.getInstance();
				cal.setTime(date_process);	// นำวันที่เข้าอยู่ในรูป ปฏิทิน
				fileName = sdf_file.format(date_process) + ".raw";
				
				if ((date_process.compareTo(d1) >= 0 && date_process.compareTo(d2) <= 0)) {
					pathFile = path_raw + fileName;
					if(!(new File(pathFile).exists())){
						numfile_All++;
						numfile_NotFound++;	//นับจำนวนไฟล์ที่ไม่พบ
						try{
							stmtUp.executeUpdate("INSERT INTO "+TempNotFound+" (id, filename) VALUES ("+numfile_NotFound+", '"+fileName+"') ");
						}catch(SQLException e){ }
					}else{						
						numfile_All++;
						numfile_Found++;	//	นับจำนวนไฟล์ที่พบ
						// เซตค่าให้เป็น 0 
						countAllRec = 0;
						countRecOK = 0;
						countRecFail = 0;
						
						String data = "";
						String message_status = "0";
						BufferedReader buff = new BufferedReader(new FileReader(pathFile));							
						while((data = buff.readLine()) != null){
							if(data.trim().length() != 0 && data.indexOf("BEGIN") == -1 && data.indexOf("END") == -1 && data.indexOf("====") == -1){
								countAllRec++;
								if((data.length() != 24) && (data.length() != 32)){									
									isError = true;
									message_status = "9";
								}else{
									isError = false;
									
									int idLen = 0;
									//TAFF_ID(2)+CARD_ID(7)+T(1)+duty(1)+mm(2)+dd(2)+yy(2)+hh(2)+mm(2)+seq(1)+sec(2)
									if(data.length() == 24){
										idLen = 7;
									}else{
										idLen = 15;
									}
									String taff = data.substring(0, 2);
									String id = data.substring(2, (2+idLen));
									String duty = data.substring((3+idLen), (4+idLen));
									String dates = "20"+data.substring((8+idLen), (10+idLen))+data.substring((4+idLen), (6+idLen))+data.substring((6+idLen), (8+idLen));//yymmdd
									String times = data.substring((10+idLen), (12+idLen))+data.substring((12+idLen), (14+idLen))+data.substring((15+idLen), (17+idLen));//hhmmss
									String seq = "000"+data.substring((14+idLen), (15+idLen));
									String ev_code = "01";
										
									// เปรียบเทียบ วันที่ที่อ่านมากับ วันที่เลือกมา , เช็คเวลาว่าถูกตาม Pattern หรือป่าว ถ้าผิดรูปแบบ
									if(!chkPatternTime(times)){
										isError = true;
									}else{
										String date_event = dates.substring(0,4)+"-"+dates.substring(4,6)+"-"+dates.substring(6,8);
										String time_event = times.substring(0,2)+":"+times.substring(2,4)+":"+times.substring(4,6);										
										String workday = date_event+" "+time_event;
										if(mode == 0){
											workday = "'"+workday+"'";
										}
										if(mode == 1){
											workday = "CONVERT(datetime, '"+workday+".000', 121)";
										}										
										
										String door_id = "99"+taff;
										// หา ip address
										String ip_address = "";
										String sql = "SELECT door.ip_address, rd.reader_no FROM dbdoor door "
													+ "LEFT OUTER JOIN dbreader rd ON (door.door_id = rd.door_id) "
													+ "WHERE (door.door_id = '"+door_id+"' AND rd.door_id = '"+door_id+"') ";
										ResultSet rs = stmtQry.executeQuery(sql);
										while(rs.next()){
											ip_address = rs.getString("ip_address");
											taff = rs.getString("reader_no");
										}
										rs.close();
										
										//insert ลงเบส dbtransaction
										if(ev_code.compareTo("08") <= 0){
											sql = "INSERT INTO dbtransaction (date_event,time_event,reader_no,event_code,idcard,workday,ip_address,duty,data_seq,data_blank) "
												+"VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"','"+id+"',"+workday+",'"+ip_address+"','"+duty+"','"+seq+"','')";
										}else{
											if(ev_code.compareTo("09") >= 0 && ev_code.compareTo("24") <= 0 || ev_code.equals("47")){
												sql = "INSERT INTO dbtransaction_ev (date_event,time_event,reader_no,event_code,idcard,workday,ip_address,duty,data_seq,data_blank) "
													+"VALUES ('"+date_event+"','"+time_event+"','"+taff+ "','"+ev_code+"','"+id+"',"+workday+",'"+ip_address+"','"+duty+"','"+seq+"','')";
											}else{
												sql = "INSERT INTO dbtrans_event (date_event,time_event,reader_no,event_code,workday,ip_address,duty,data_blank) "
													+"VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"',"+workday+",'"+ip_address +"','"+duty+"','')";
											}
										}
										try{
											resultQry = stmtUp.executeUpdate(sql);
										}catch(SQLException es){
											if(resultQry != 1){
												if(ev_code.compareTo("08") <= 0){
													sql = "UPDATE dbtransaction SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
														+"idcard='"+id+"',workday="+workday+",ip_address='"+ip_address+"',duty='"+duty+"',data_seq='"+seq+"',data_blank='' "
														+"WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') AND (idcard = '"+id+"')";
												}else{
													if(ev_code.compareTo("09") >= 0 && ev_code.compareTo("24") <= 0 || ev_code.equals("47")){
														sql = "UPDATE dbtransaction_ev SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
															+"idcard='"+id+"',workday="+workday+",ip_address='"+ip_address+"',duty='"+duty+"',data_seq='"+seq+"',data_blank='' "
															+"WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') AND (idcard = '"+id+"')";													
													}else{
														sql = "UPDATE dbtrans_event SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
															+"workday="+workday+",ip_address='"+ip_address+"',duty='"+duty+"',data_blank='' "
															+"WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"')";
													}
												}
												try{
													resultQry = stmtUp.executeUpdate(sql);
												}catch(SQLException e){
												
												}
											}
										}											
										// ถ้า resultQry == 1 นับเรคคอร์ดที่บันทึกได้ทั้งหมด
										if(resultQry == 1){
											countRecOK++;
										}else{
											isError = true;
										}
									}
								}
								// ถ้า isError=true ให้ insert ลง rawupload
								if(isError){
									countRecFail++;	// นับเรคคอร์ดที่ผิดรุปแบบไฟล์
									countAllFail++;
									String sqlTmp = "INSERT INTO "+TempName+" (id, filename, description, error_message) VALUES ("+countAllFail+", '"+fileName+"','"+data+"', '"+message_status+"') ;";
									stmtUp.executeUpdate(sqlTmp);
								}
							}
						}
						buff.close();
						// ถ้าเรคคอร์ดท้ังหมดเท่ากับเรคคอร์ดที่บันทึกได้
						if(countAllRec == countRecOK){
							numfile_Success++;	// เก็บชื่อไฟล์ที่สำเร็จและจำนวน countRecOK
							fileSuccess = fileSuccess + fileName + "#" + countAllRec + ",";	//หาจำนวนเรคคอร์ดไฟล์ที่บันทึกได้
						}else{
							numfile_Fail++; // นับไฟล์ที่ ไม่ถูกรูปแบบ หรือ ฟอแมท
							//เก็บจำนวนเรคคอร์ดไฟล์ที่สำเร็จและจำนวนเรคคอร์ดทั้งหมด
							fileFail = fileFail + fileName + "[" + countRecOK + "/" + countAllRec + "]#" + countRecFail + ",";
						}
					}
				}else{
					isProcess = false;
				}
				// เพิ่มวันที่ไปทีละ 1 วัน
				cal.add(Calendar.DATE, 1);
				date_process = cal.getTime();
			}//while
			
			// แสดงรายการ
			String process = alert_file_err + " &nbsp; " + YMDTodate(start_date) + " &nbsp; " + lb_to + " &nbsp; " + YMDTodate(stop_date);
			out.println("<div class='alert alert-info' role='alert' align='center'> <b> "+process+" </b> </div>");
						
			out.println("<table class='table' style='max-width: 700px;' align='center'>");
			out.println("	<tr>");
			out.println("		<td align='left' width='35%'> <strong> " + lb_process_files + " " + numfile_All + " " + lb_day + " </strong> </td>");
			out.println("		<td align='right' width='15%'> " + lb_found2 + " </td>");
			out.println("		<td align='right' width='15%'> <strong> " + numfile_Found + " </strong> &nbsp; " + lb_file + " </td>");
			out.println("		<td align='right' width='20%'> " + lb_not_found + " </td>");
			out.println("		<td align='right' width='15%'> <strong> <a href='javascript: show_detail2();'>" + numfile_NotFound + "</a> </strong> &nbsp; " + lb_file + " </td>");
			out.println("	</tr>");
			out.println("	<tr>");
			out.println("		<td align='left' width='35%'> <strong> " + lb_process_todatabase + " </strong> </td>");
			out.println("		<td align='right' width='15%' style='color: #3C763D;'> <span class='glyphicon glyphicon-ok'> </span> &nbsp; " + lb_succ + " </td>");
			out.println("		<td align='right' width='15%' style='color: #3C763D;'> <strong> " + numfile_Success + " </strong> &nbsp; " + lb_file + " </td>");
			out.println("		<td align='right' width='20%' style='color: #A94442;'> <span class='glyphicon glyphicon-remove'> </span> &nbsp; " + lb_notprocessuc + " </td>");
			out.println("		<td align='right' width='15%' style='color: #A94442;'> <strong> " + numfile_Fail + " </strong> &nbsp; " + lb_file + " </td>");
			out.println("	</tr>");
			out.println("	<tr>");
			out.println("		<td colspan='5'> </td>");
			out.println("	</tr>");
			out.println("</table>");				
%> 	
								<div class="table-responsive" style="border: 0px !important;" border="0">
									<div style="min-width: 800px; max-width: 100%; margin-left: 15px; margin-right: 15px;" border="0">

										<div class="row" style="margin-bottom: 0px;">
											
											<table class="table" style="min-width: 800px; max-width: 100%;" align="center">
												<tr>
													<td width="40%">
														
														<div class="alert alert-success" role="alert" style="padding: 5px !important; margin-bottom: 5px;" align="center"> <span class="glyphicon glyphicon-ok"> </span> &nbsp; <b> <%= lb_succ %> </b> </div>
														
														<table width="100%" class="table" border="0">							   
															<tr>
																<td width="20%" align="center">	<%= lb_no %> </td>
																<td width="60%" align="center">	<%= lb_filename %> </td>
																<td width="20%" align="center">	Full Rec. </td>
															</tr>
														<%	//	แสดงตารางของไฟล์ที่พบ
															if (!fileSuccess.equals("")) {
																String fSuccess = "";
																String[] fileS = fileSuccess.split(",");
																for(int i = 0; i <= fileS.length-1; i++){
																	fSuccess = fileS[i];
														%>
															<tr>
																<td align="center"> <%= (i+1) %> </td>									
																<td align="center"> <%= fSuccess.substring(0, 12) %> </td>									
																<td align="center"> <%= fSuccess.substring(13, fSuccess.length())%> </td>										
															</tr>
														<% 		}
															}
														%>
															<tr>
																<td colspan="3"> </td>
															</tr>	
														</table>
													
													</td>
													<td width="60%"> 
														
														<div class="alert alert-danger" role="alert" style="padding: 5px !important; margin-bottom: 5px;" align="center"> <span class="glyphicon glyphicon-remove"> </span> &nbsp; <b> <%= lb_notprocessuc %> </b> </div>
														
														<table width="100%" class="table" border="0">							   
															<tr>
																<td width="15%" align="center">	<%= lb_no %> </td>
																<td width="40%" align="center">	<%= lb_filename %> </td>
																<td width="25%" align="center">	<%= lb_succ %> / Full Rec. </td>
																<td width="20%" align="center">	Fail Rec. </td>
															</tr>
														<%	// 	แสดงตารางของไฟล์ที่พบ แต่ ไม่สำเร็จ หรือ ผิดรูปแบบไฟล์
															if (!fileFail.equals("")) {
																int len;
																String failName = "", resultSuccess = "", resultFail = "";
																String fFile = "";
																String[] fileF = fileFail.split(",");
																for(int i = 0; i <= fileF.length-1; i++){
																	fFile = fileF[i];
																	len = fFile.length();
																	failName = fFile.substring(0,fFile.lastIndexOf("[", len));	//	ตัดเอาค่าตั้งแต่ตัวแรกจนถึงเครื่องหาย ]
																	resultSuccess = fFile.substring(fFile.lastIndexOf("[", len)+1,fFile.lastIndexOf("]", len));	//	เอาค่าที่อยู่ในเครื่องหมาย []
																	resultFail = fFile.substring(fFile.lastIndexOf("#", len)+1, len);	//	ตัดเอาค่าที่อยู่หลังเครื่องหมาย #
														%>
															<tr>
																<td align="center"> <%= (i+1) %> </td>									
																<td align="center"> <%= failName %> </td>
																<td align="center"> <%= resultSuccess %> </td>
																<td align="center"> <a href="javascript:show_detail('<%= failName %>');"> <%= resultFail %> </a> </td>
															</tr>
														<% 		}
															}	
														%>
															<tr>
																<td colspan="4"> </td>
															</tr>	
														</table>
														
													</td>
												</tr>
											</table>
										
										</div> 
									
									</div> 
								</div>
								<%	}	%>
								
							</div> 
						</div>
					</form>
				</div>
				
			</div>
		</div> 
<%	
	}catch(Exception e){
		out.println("<div class='alert alert-danger' role='alert'> Exception :"+e.getMessage()+"</div>");
	}
%>		
		<div class="modal fade bs-example-modal-lg" id="myModalViewDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= lb_viewdata %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="#" id="view_detail" name="view_detail" frameborder="0" height="420px" style="min-width: 850px; overflow: hidden;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>

		<script>
			function show_detail(filename){
				view_detail.location = 'file_detail.jsp?file='+filename+'&typefile=raw&';
				$('#myModalViewDetail').modal('show');
			}
			function show_detail2(filename){
				view_detail.location = 'file_detail2.jsp';
				$('#myModalViewDetail').modal('show');
			}
		</script>
		
		<script language="javascript">
			$('.form_date').datetimepicker({
				language:  '<%= lang %>',
				weekStart: 1,
				todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0
			});
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>