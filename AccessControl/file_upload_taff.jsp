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
	session.setAttribute("subtitle", "filetaf");
	session.setAttribute("action", "file_upload_taff.jsp?");
	
	String stdate = "";
	String eddate = "";	
	String start_date = "";
	String stop_date = "";	
	String process_todatabase = "";
	String process_todataformat = "";
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
			
			if(request.getParameter("todatabase") != null && request.getParameter("todatabase") != ""){
				process_todatabase = request.getParameter("todatabase");
			}
			if(request.getParameter("todataformat") != null && request.getParameter("todataformat") != ""){
				process_todataformat = request.getParameter("todataformat");
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
		<script language="javascript" src="js/alert_box.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
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
			
			function loadModalWait(){
		//		$('#myModalWait').modal('show');
			}
		</script>
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadModalWait();">
		
		<div class="modal fade" id="myModalWait" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; margin-bottom: -30px;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <img id="img_load" src="images/loading2.gif" style=" cursor: default;" class="img-rounded" width="48" height="48"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p> <%= lb_please_wait %> </p> </h4> </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>	
			
		<br/>
		<div class="body-display">
			<div class="container">
			
				<div class="col-md-12">
					<form name="form1" id="form1" method="post">
						<div class="panel panel-primary"> 
							<div class="panel-heading">
								<h3 class="panel-title"> <b> <%= lb_import_data_taff %> </b> </h3> 
							</div> 
							<div class="panel-body"> 
							
								<div class="table-responsive" style="border: 0px !important;" border="0">
									<div style="min-width: 850px; max-width: 100%; margin-left: 15px; margin-right: 15px;" border="0">
										
										<div class="row">
											<label class="col-xs-2 col-md-2" style="margin-top: 6px;" align="right"> <div style="text-align: right;"> <%= lb_date %> </div> </label>
											<div class="col-xs-3 col-md-3"> 
												<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date" data-link-format="dd/mm/yyyy">
													<input class="form-control" type="text" value="<%= stdate %>" readonly onKeyPress="IsValidNumberForDate();">
													<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
												</div>
												<input type="hidden" class="form-control" id="st_date" name="st_date" maxlength="10" value="<%= stdate %>" placeholder="<%= lb_date %>" readonly="readonly" style="background-color:#F0F0F0">
											</div>
											<label class="col-xs-1 col-md-1" style="margin-top: 6px;" align="right"> </label>
											<div class="col-xs-4 col-md-4" style="margin-top: 6px;">
												<input type="checkbox" style="margin-left: 20px;" id="todatabase" name="todatabase" value="checked" <%= process_todatabase %> > 
												<label style="margin-left: 5px;"> <%= lb_process_todatabase %> </label>
											</div>
											<div class="col-xs-2 col-md-2" style="margin-bottom: 20px;" align="right"> </div>
										</div>
										<div class="row" style="margin-top: 10px;">
											<label class="col-xs-2 col-md-2" style="margin-top: 6px;" align="right"> <div style="text-align: right;"> <%= lb_to_date %> </div> </label>
											<div class="col-xs-3 col-md-3"> 	
												<div class="input-group date form_date" data-date="" data-date-format="dd/mm/yyyy" data-link-field="st_date2" data-link-format="dd/mm/yyyy">
													<input class="form-control" type="text" value="<%= eddate %>" readonly onKeyPress="IsValidNumberForDate();">
													<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
												</div>
												<input type="hidden" class="form-control" id="st_date2" name="st_date2" maxlength="10" value="<%= eddate %>" placeholder="<%= lb_to_date %>" readonly="readonly" style="background-color:#F0F0F0">
											</div>
											<label class="col-xs-1 col-md-1" style="margin-top: 6px;" align="right"> </label>
											<div class="col-xs-4 col-md-4" style="margin-top: 6px;">
												<input type="checkbox" style="margin-left: 20px;" id="todataformat" name="todataformat" value="checked" <%= process_todataformat %> > 
												<label style="margin-left: 5px;"> <%= lb_process_todataformat %> </label>
											</div>
											<div class="col-xs-2 col-md-2" style="margin-bottom: 20px;" align="right">  
												<input type="button" name="button" id="btnok" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_process_text %> &nbsp; &nbsp; &nbsp; " onclick="onSubmit_Ok('file_upload_taff.jsp?pages=process', '<%= lb_select_process %>');">
											</div>
										</div>
										<div class="row">
<%	
	//	Call function convert in java
	ConvertData convData = new ConvertData();
	
	try{
		String ip_string = getIP(request.getRemoteAddr());;
		String TempSuccess = "tmpupsuccess_"+ip_string;
		String TempFail = "tmpupfail_"+ip_string;
		
		if((pages != null) && pages.equals("process")) {
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd", Locale.US);
			// แปลงวันที่ให้อยู่ในรูปแบบ Date = yyyy-MM-dd	
			Date d1 = sdf.parse(start_date);
			Date d2 = sdf.parse(stop_date);
			// นำวันที่เริ่มต้นเก็บในรูปแบบ Date 
			Date date_process = sdf.parse(start_date);
			
			String TempNameDatabase = "tmptaf_"+ip_string;
			String TempNameDataFormat = "tmpformat_"+ip_string;
			String TempreportNotFound = "tmpnotfound_"+ip_string;
		
			try{
				stmtUp.executeUpdate(dropTableTmpReport(db_database, TempNameDatabase, mode));
				stmtUp.executeUpdate(dropTableTmpReport(db_database, TempNameDataFormat, mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database, TempNameDatabase, "taf", mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database, TempNameDataFormat, "format", mode));
				
				stmtUp.executeUpdate(dropTableTmpReport(db_database, TempreportNotFound, mode));
				stmtUp.executeUpdate(dropTableTmpReport(db_database, TempSuccess, mode));
				stmtUp.executeUpdate(dropTableTmpReport(db_database, TempFail, mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database, TempreportNotFound, "notfound", mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database, TempSuccess, "upsuccess", mode));
				stmtUp.executeUpdate(createTableTmpReport(db_database, TempFail, "upfail", mode));
			}catch(SQLException e){
				
			}
			
			String fileName = "";
			String pathFile = "";
			boolean isProcess = true;
			boolean isSuccess = true;
			boolean isErrorDatabase = false;
			boolean isErrorDataFormat = false;
			
			int numfile_NotFound = 0; 				//	นับไฟล์ที่ไม่พบ
			int numfile_Found = 0; 					//	นับไฟล์ที่ไม่พบ
			int numfile_All = 0; 					//	นับไฟล์ทั้งหมด
			int numfile_Database_Success = 0; 		//	นับไฟล์ที่พบ
			int numfile_Database_Fail = 0; 			//	นับไฟล์ที่ไม่สำเร็จ
			int numfile_DataFormat_Success = 0; 	//	นับไฟล์ที่พบ
			int numfile_DataFormat_Fail = 0; 		//	นับไฟล์ที่ไม่สำเร็จ
			int countDatabaseRecOK = 0;
			int countDatabaseRecFail = 0;
			int countDatabaseRecFailtoBase = 0;
			int countDatabaseAllRec = 0;
			int countDataFormatRecOK = 0;
			int countDataFormatRecFail = 0;
			int countDataFormatRecFailtoBase = 0;
			int countDataFormatAllRec = 0;
			
			SimpleDateFormat sdf_file = new SimpleDateFormat("yyyyMMdd", Locale.US);
			while(isProcess){
				Calendar cal = Calendar.getInstance();
				cal.setTime(date_process);	// นำวันที่เข้าอยู่ในรูป ปฏิทิน
				fileName = sdf_file.format(date_process) + ".taf";
				
				if ((date_process.compareTo(d1) >= 0 && date_process.compareTo(d2) <= 0)) {
					pathFile = path_taff + fileName.substring(0, 4) + "\\" + fileName.substring(4, 6) + "\\" + fileName;
					if(!(new File(pathFile).exists())){
						numfile_All++;
						numfile_NotFound++;	//	นับจำนวนไฟล์ที่ไม่พบ
						try{
							stmtUp.executeUpdate("INSERT INTO "+TempreportNotFound+" (id, filename) VALUES ("+numfile_NotFound+", '"+fileName+"') ");
						}catch(SQLException e){ }
					}else{
						numfile_All++;
						numfile_Found++;	//	นับจำนวนไฟล์ที่พบ
						//	เซตค่าให้เป็น 0
						countDatabaseRecOK = 0;
						countDatabaseRecFail = 0;
						countDatabaseAllRec = 0;
						
						countDataFormatRecOK = 0;
						countDataFormatRecFail = 0;
						countDataFormatAllRec = 0;
						
						String data = "";
						BufferedReader buff = new BufferedReader(new FileReader(pathFile));
						while((data = buff.readLine()) != null){
							
							if(data.trim().length() == 0){
								continue;
							}
							
							int msg_status_base = 0, msg_status_format = 0;
							
							//if(data.length() != 50 && data.length() != 52){
							if(data.length() < 50){
								countDatabaseAllRec++;
								countDataFormatAllRec++;
								isErrorDatabase = true;
								isErrorDataFormat = true;
								msg_status_base = 9;
								msg_status_format = 9;
							}else{								
								countDatabaseAllRec++;
								countDataFormatAllRec++;
								isErrorDatabase = false;
								isErrorDataFormat = false;
								msg_status_base = 0;
								msg_status_format = 0;
								
								if(process_todatabase.equals("checked")){
									
									msg_status_base = convData.CheckConvertData(data);
									if(msg_status_base == 1){					//	1 = Success
										
										//	id(16)+duty(1)+date(8)+time(6)+taff(5)+seq(4)+event_code(2)+blank(6)+crc(2)					//	50
										//	id(16)+duty(1)+date(8)+time(6)+taff(5)+seq(4)+event_code(2)+blank(6)+work_code(2)+crc(2)	//	52	//	work_code
										String id = data.substring(0, 16);
										String duty = data.substring(16, 17);
										String dates = data.substring(21,25)+data.substring(19,21)+data.substring(17,19);//yyyymmdd//data.substring(17,25)
										String times = data.substring(25, 31);
										String taff = data.substring(31, 36);
										String seq = data.substring(36, 40);
										String ev_code = data.substring(40, 42);
										String blank = data.substring(42, 48);
										String crc = data.substring(48, 50);	
										String work_code = "";
										String temperature = "";
										String wearingmask = "";				
										
										if(data.length() == 52){
											work_code = data.substring(48, 50);
											crc = data.substring(50, 52);
										} else if(data.length() == 56){
											work_code = data.substring(48, 50);
											temperature = data.substring(50, 54);
											crc = data.substring(54, 56);
										} else if (data != null && data.length() == 60) {
											// work_code = data.substring(48, 50);
											work_code = data.substring(55, 58);
											temperature = data.substring(50, 54);
											wearingmask = data.substring(54, 55);
											crc = data.substring(58, 60);
										}
																				
										//	เปรียบเทียบ วันที่ที่อ่านมากับ วันที่เลือกมา , เช็คเวลาว่าถูกตาม Pattern หรือป่าว ถ้าผิดรูปแบบ
										if((dates.compareTo(fileName.substring(0, 8)) != 0) || (!chkPatternTime(times))){
											isErrorDatabase = true;
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
											
											String door_id = taff.substring(0,4);
											// หา ip address
											String ip_address = "";
											String sql = "SELECT door.ip_address, rd.reader_no FROM dbdoor door "
														+ "LEFT OUTER JOIN dbreader rd ON (door.door_id = rd.door_id) "
														+ "WHERE (door.door_id = '"+door_id+"' AND rd.door_id = '"+door_id+"') ";
											ResultSet rs = stmtQry.executeQuery(sql);
											while(rs.next()){
												ip_address = rs.getString("ip_address");
											}
											rs.close();
											
											//insert ลงเบส dbtransaction
											if(ev_code.compareTo("08") <= 0){
												sql = "INSERT INTO dbtransaction (date_event,time_event,reader_no,event_code,idcard,workday,ip_address,duty,data_seq,data_blank,work_code,temperature,wearmask) "
													+"VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"','"+id+"',"+workday+",'"+ip_address+"','"+duty+"','"+seq+"','"+blank+"','"+work_code+"','"+temperature+"','"+wearingmask+"')";
											}else{
												if(ev_code.compareTo("09") >= 0 && ev_code.compareTo("24") <= 0 || ev_code.equals("47")){
													sql = "INSERT INTO dbtransaction_ev (date_event,time_event,reader_no,event_code,idcard,workday,ip_address,duty,data_seq,data_blank,work_code,temperature,wearmask) "
														+"VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"','"+id+"',"+workday+",'"+ip_address+"','"+duty+"','"+seq+"','"+blank+"','"+work_code+"','"+temperature+"','"+wearingmask+"')";
												}else{
													sql = "INSERT INTO dbtrans_event (date_event,time_event,reader_no,event_code,workday,ip_address,duty,data_blank) "
														+"VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"',"+workday+",'"+ip_address+"','"+duty+"','"+blank+"')";
												}
											}
											
											try{
												resultQry = stmtUp.executeUpdate(sql);
											}catch(SQLException es){
												if(resultQry != 1){
													if(ev_code.compareTo("08") <= 0){
														sql = "UPDATE dbtransaction SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
															+"idcard='"+id+"',workday="+workday+",ip_address='"+ip_address+"',duty='"+duty+"',data_seq='"+seq+"',data_blank='"+blank+"',"
															+"work_code='"+work_code+"',temperature='"+temperature+"',wearmask='"+wearingmask+"' "
															+"WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') AND (idcard = '"+id+"')";
													}else{
														if(ev_code.compareTo("09") >= 0 && ev_code.compareTo("24") <= 0 || ev_code.equals("47")){
															sql = "UPDATE dbtransaction_ev SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
																+"idcard='"+id+"',workday="+workday+",ip_address='"+ip_address+"',duty='"+duty+"',data_seq='"+seq+"',data_blank='"+blank+"',"
															+"work_code='"+work_code+"',temperature='"+temperature+"',wearmask='"+wearingmask+"' "
																+"WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') AND (idcard = '"+id+"')";
														}else{
															sql = "UPDATE dbtrans_event SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
																+"workday="+workday+",ip_address='"+ip_address+"',duty='"+duty+"',data_blank='"+blank+"' "
																+"WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') ";
														}
													}
													try{
														resultQry = stmtUp.executeUpdate(sql);
													}catch(SQLException e){ }
												}
											}
											//	ถ้า resultQry == 1 นับเรคคอร์ดที่บันทึกได้ทั้งหมด
											if(resultQry == 1){
												countDatabaseRecOK++;
											}else{
												isErrorDatabase = true;
											}
										}
									}else{										//	0 = Fail
										isErrorDatabase = true;
									}
								}
								
								if(process_todataformat.equals("checked")){
									
									String dates = data.substring(21,25)+data.substring(19,21)+data.substring(17,19);//yyyymmdd//data.substring(17,25)
									String times = data.substring(25, 31);
									
									//	เปรียบเทียบ วันที่ที่อ่านมากับ วันที่เลือกมา , เช็คเวลาว่าถูกตาม Pattern หรือป่าว ถ้าผิดรูปแบบ
									if((dates.compareTo(fileName.substring(0, 8)) != 0) || (!chkPatternTime(times))){
										isErrorDataFormat = true;
									}else{
										msg_status_format = convData.ConvertDataFormat(data);
										if(msg_status_format == 1){				//	1 = Success
											countDataFormatRecOK++;
										}else{									//	0 = Fail, 2 = Software Event 6 Uncheck
											isErrorDataFormat = true;			//	3 = No File config.set or path, 4 = No Set Standard File
										}
									}
								}
								
							}
							
							//	ถ้า isError=true ให้ insert ลง taffupload
							if(isErrorDatabase){
								countDatabaseRecFail++;			//	นับเรคคอร์ดที่ผิดรุปแบบไฟล์
								countDatabaseRecFailtoBase++;	//	นับเรคคอร์ดที่ผิดรุปแบบไฟล์ และ insert to database
								try{
									String sqlTmp = "INSERT INTO "+TempNameDatabase+" (id, filename, description, error_message) VALUES ("+countDatabaseRecFailtoBase+", '"+fileName+"', '"+data+"', '"+msg_status_base+"') ";
									stmtUp.executeUpdate(sqlTmp);
								}catch(SQLException e){ }
							}
							if(isErrorDataFormat){
								countDataFormatRecFail++;		//	นับเรคคอร์ดที่ผิดรุปแบบไฟล์
								countDataFormatRecFailtoBase++;	//	นับเรคคอร์ดที่ผิดรุปแบบไฟล์ และ insert to database
								try{
									String sqlTmp = "INSERT INTO "+TempNameDataFormat+" (id, filename, description, error_message) VALUES ("+countDataFormatRecFailtoBase+", '"+fileName+"', '"+data+"', '"+msg_status_format+"') ";
									stmtUp.executeUpdate(sqlTmp);
								}catch(SQLException e){ }
							}
						}
						buff.close();
						
						//	ถ้าเรคคอร์ดท้ังหมดเท่ากับเรคคอร์ดที่บันทึกได้
						if(process_todatabase.equals("checked")){
							String sqlTmp = "";
							if(countDatabaseAllRec == countDatabaseRecOK){
								numfile_Database_Success++;	//	เก็บชื่อไฟล์ที่สำเร็จและจำนวน countRecOK
								try{
									sqlTmp = " INSERT INTO "+TempSuccess+" (id, filename, success_base) VALUES ("+numfile_All+", '"+fileName+"', "+countDatabaseAllRec+") ";
									stmtUp.executeUpdate(sqlTmp);
								}catch(SQLException e){ 
									try{
										sqlTmp = " UPDATE "+TempSuccess+" SET filename='"+fileName+"', success_base="+countDatabaseAllRec+" WHERE id="+numfile_All+" ";
										stmtUp.executeUpdate(sqlTmp);
									}catch(SQLException e1){ }	
								}	
							}else{
								numfile_Database_Fail++; //	นับไฟล์ที่ ไม่ถูกรูปแบบ หรือ ฟอแมท
								try{
									sqlTmp = " INSERT INTO "+TempFail+" (id, filename, success_info_base, fail_base) VALUES ("+numfile_All+", '"+fileName+"', '"+countDatabaseRecOK + " / " + countDatabaseAllRec+"', "+countDatabaseRecFail+") ";
									stmtUp.executeUpdate(sqlTmp);
								}catch(SQLException e){ 
									try{
										sqlTmp = " UPDATE "+TempFail+" SET filename='"+fileName+"', success_info_base='"+countDatabaseRecOK + " / " + countDatabaseAllRec+"', fail_base="+countDatabaseRecFail+" WHERE id="+numfile_All+" ";
										stmtUp.executeUpdate(sqlTmp);
									}catch(SQLException e1){ }
								}	
							}
						}
						
						if(process_todataformat.equals("checked")){
							String sqlTmp = "";
							if(countDataFormatAllRec == countDataFormatRecOK){
								numfile_DataFormat_Success++;	//	เก็บชื่อไฟล์ที่สำเร็จและจำนวน countRecOK
								try{
									sqlTmp = " INSERT INTO "+TempSuccess+" (id, filename, success_format) VALUES ("+numfile_All+", '"+fileName+"', "+countDataFormatAllRec+") ";
									stmtUp.executeUpdate(sqlTmp);
								}catch(SQLException e){ 
									try{
										sqlTmp = " UPDATE "+TempSuccess+" SET filename='"+fileName+"', success_format="+countDataFormatAllRec+" WHERE id="+numfile_All+" ";
										stmtUp.executeUpdate(sqlTmp);
									}catch(SQLException e1){ }	
								}	
							}else{
								numfile_DataFormat_Fail++; //	นับไฟล์ที่ ไม่ถูกรูปแบบ หรือ ฟอแมท
								try{
									sqlTmp = " INSERT INTO "+TempFail+" (id, filename, success_info_format, fail_format) VALUES ("+numfile_All+", '"+fileName+"', '"+countDataFormatRecOK + " / " + countDataFormatAllRec+"', "+countDataFormatRecFail+") ";
									stmtUp.executeUpdate(sqlTmp);
								}catch(SQLException e){ 
									try{
										sqlTmp = " UPDATE "+TempFail+" SET filename='"+fileName+"', success_info_format='"+countDataFormatRecOK + " / " + countDataFormatAllRec+"', fail_format="+countDataFormatRecFail+" WHERE id="+numfile_All+" ";
										stmtUp.executeUpdate(sqlTmp);
									}catch(SQLException e1){ }
								}	
							}
						}
					}
				}else{
					isProcess = false;
				}
				//	เพิ่มวันที่ไปทีละ 1 วัน		
				cal.add(Calendar.DATE, 1);
				date_process = cal.getTime();
			}
			
			//	แสดงรายการ
			String process = alert_file_err + " &nbsp; " + YMDTodate(start_date) + " &nbsp; " + lb_to + " &nbsp; " + YMDTodate(stop_date) ;	
			out.println("<div class='alert alert-info' role='alert' align='center'> <b> "+process+" </b> </div>");
			out.println("<table class='table' style='max-width: 700px;' align='center'>");
			out.println("	<tr>");
			out.println("		<td align='left' width='35%'> <strong> " + lb_process_files + " " + numfile_All + " " + lb_day + " </strong> </td>");
			out.println("		<td align='right' width='15%'> " + lb_found2 + " </td>");
			out.println("		<td align='right' width='15%'> <strong> " + numfile_Found + " </strong> &nbsp; " + lb_file + " </td>");
			out.println("		<td align='right' width='20%'> " + lb_not_found + " </td>");
			out.println("		<td align='right' width='15%'> <strong> <a href='javascript: show_detail2();'>" + numfile_NotFound + "</a> </strong> &nbsp; " + lb_file + " </td>");
			out.println("	</tr>");
			if(process_todatabase.equals("checked")){
				out.println("	<tr>");
				out.println("		<td align='left' width='35%'> <strong> " + lb_process_todatabase + " </strong> </td>");
				out.println("		<td align='right' width='15%' style='color: #3C763D;'> <span class='glyphicon glyphicon-ok'> </span> &nbsp; " + lb_succ + " </td>");
				out.println("		<td align='right' width='15%' style='color: #3C763D;'> <strong> " + numfile_Database_Success + " </strong> &nbsp; " + lb_file + " </td>");
				out.println("		<td align='right' width='20%' style='color: #A94442;'> <span class='glyphicon glyphicon-remove'> </span> &nbsp; " + lb_notprocessuc + " </td>");
				out.println("		<td align='right' width='15%' style='color: #A94442;'> <strong> " + numfile_Database_Fail + " </strong> &nbsp; " + lb_file + " </td>");
				out.println("	</tr>");
			}
			if(process_todataformat.equals("checked")){
				out.println("	<tr>");
				out.println("		<td align='left' width='35%'> <strong> " + lb_process_todataformat + " </strong> </td>");
				out.println("		<td align='right' width='15%' style='color: #3C763D;'> <span class='glyphicon glyphicon-ok'> </span> &nbsp; " + lb_succ + " </td>");
				out.println("		<td align='right' width='15%' style='color: #3C763D;'> <strong> " + numfile_DataFormat_Success + " </strong> &nbsp; " + lb_file + " </td>");
				out.println("		<td align='right' width='20%' style='color: #A94442;'> <span class='glyphicon glyphicon-remove'> </span> &nbsp; " + lb_notprocessuc + " </td>");
				out.println("		<td align='right' width='15%' style='color: #A94442;'> <strong> " + numfile_DataFormat_Fail + " </strong> &nbsp; " + lb_file + " </td>");
				out.println("	</tr>");
			}
			out.println("	<tr>");
			out.println("		<td colspan='5'> </td>");
			out.println("	</tr>");
			out.println("</table>");			
		}		
	%> 
										</div> 
										
									</div>
								</div>
								<%	if((pages != null) && pages.equals("process")) {	%>	
								<div class="table-responsive" style="border: 0px !important;" border="0">
									<div style="min-width: 850px; max-width: 100%; margin-left: 15px; margin-right: 15px;" border="0">
										<div class="row" style="margin-bottom: 0px;">
											<table class="table" style="min-width: 800px; max-width: 100%; margin-bottom: 0px;" align="center">
												<tr>
													<td width="35%">
														<div class="alert alert-success" role="alert" style="padding: 5px !important; margin-bottom: 5px;" align="center"> <span class="glyphicon glyphicon-ok"> </span> &nbsp; <b> <%= lb_succ %> </b> </div>
														<table width="100%" class="table" border="0">							   
															<tr>
																<td width="15%" align="center">	<%= lb_no %> </td>
																<td width="35%" align="center">	<%= lb_filename %> </td>
															<%	if(process_todatabase.equals("checked")){	%>
																<td width="25%" align="center">	Base Rec. </td>
															<%	}	%>
															<%	if(process_todataformat.equals("checked")){	%>
																<td width="25%" align="center">	Format Rec. </td>
															<%	}	%>
															</tr>
														<%	try{
																int i = 0;
																ResultSet rs = stmtQry.executeQuery(" SELECT * FROM "+TempSuccess+" ORDER BY id ASC ");
																while(rs.next()){
																	i++;
														%>
															<tr>
																<td align="center"> <%= i %> </td>
																<td align="center"> <%= rs.getString("filename") %> </td>
															<%	if(process_todatabase.equals("checked")){	%>
																<td align="center"> <%= rs.getString("success_base") %> </td>
															<%	}	%>
															<%	if(process_todataformat.equals("checked")){	%>
																<td align="center"> <%= rs.getString("success_format") %> </td>
															<%	}	%>
															</tr>
														<%	
																}	rs.close();
															}catch(SQLException e){
																out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
															}	
														%>
															<tr>
																<td colspan="4"> </td>
															</tr>	
														</table>
													</td>
													<td width="65%"> 
														<div class="alert alert-danger" role="alert" style="padding: 5px !important; margin-bottom: 5px;" align="center"> <span class="glyphicon glyphicon-remove"> </span> &nbsp; <b> <%= lb_notprocessuc %> </b> </div>
														<table width="100%" class="table" border="0">							   
															<tr>
																<td width="5%" align="center">	<%= lb_no %> </td>
																<td width="15%" align="center">	<%= lb_filename %> </td>
															<%	if(process_todatabase.equals("checked")){	%>
																<td width="20%" align="center">	Base Rec. / All Rec. </td>
																<td width="15%" align="center">	Fail Rec. </td>
															<%	}	%>
															<%	if(process_todataformat.equals("checked")){	%>
																<td width="20%" align="center">	Format Rec. / All Rec. </td>
																<td width="15%" align="center">	Fail Rec. </td>
															<%	}	%>
															</tr>
														<%	try{
																int i = 0;
																ResultSet rs = stmtQry.executeQuery(" SELECT * FROM "+TempFail+" ORDER BY id ASC ");
																while(rs.next()){
																	i++;
														%>
															<tr>
																<td align="center"> <%= i %> </td>
																<td align="center"> <%= rs.getString("filename") %> </td>
															<%	if(process_todatabase.equals("checked")){	%>
																<td align="center"> <%= rs.getString("success_info_base") %> </td>
																<td align="center"> <% if(!rs.getString("success_info_base").equals("")){ %> <a href="javascript: show_detail_taf('<%= rs.getString("filename") %>');"> <%= rs.getString("fail_base") %> </a> <% } %> </td>
															<%	}	%>
															<%	if(process_todataformat.equals("checked")){	%>
																<td align="center"> <%= rs.getString("success_info_format") %> </td>
																<td align="center"> <% if(!rs.getString("success_info_format").equals("")){ %> <a href="javascript: show_detail_format('<%= rs.getString("filename") %>');"> <%= rs.getString("fail_format") %> </a> <% } %> </td>
															<%	}	%>
															</tr>
														<%	
																}	rs.close();
															}catch(SQLException e){
																out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
															}	
														%>
															<tr>
																<td colspan="6"> </td>
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
		
		<div class="modal fade" id="myModalWarning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_warning" class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_warning" class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_warning"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_warning" onClick="javascript: $('#myModalWarning').modal('hide'); javascript: document.getElementById($('#object_warning').val()).focus(); " style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> 
									<input type="hidden" id="object_warning" name="object_warning" readonly>
									<input type="hidden" id="datetime_warning" name="datetime_warning" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script>
			function show_detail_taf(filename){
				view_detail.location = 'file_detail.jsp?file='+filename+'&typefile=taf&';
				$('#myModalViewDetail').modal('show');
			}
			function show_detail_format(filename){
				view_detail.location = 'file_detail.jsp?file='+filename+'&typefile=format&';
				$('#myModalViewDetail').modal('show');
			}
			function show_detail2(filename){
				view_detail.location = 'file_detail2.jsp';
				$('#myModalViewDetail').modal('show');
			}
			
			function onSubmit_Ok(url, sText){
				if(document.getElementById("todatabase").checked == false && document.getElementById("todataformat").checked == false){
					ModalWarning_TextName(sText, "");
					return false;
				}else{
					document.form1.action = url;
					document.form1.submit();
				}
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