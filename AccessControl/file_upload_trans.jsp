<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="server.process.ConvertData"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<% 
	session.setAttribute("page_g", "special"); 
	session.setAttribute("subpage", "processfile");
	session.setAttribute("subtitle", "filetrans");	
	session.setAttribute("action", "file_upload_trans.jsp?&");
	
	String process_todatabase = "";
	String process_todataformat = "";
	String process_tofiletaf = "";
	
	if(request.getParameter("todatabase") != null && request.getParameter("todatabase") != ""){
		process_todatabase = request.getParameter("todatabase");
	}
	if(request.getParameter("todataformat") != null && request.getParameter("todataformat") != ""){
		process_todataformat = request.getParameter("todataformat");
	}
	if(request.getParameter("tofiletaf") != null && request.getParameter("tofiletaf") != ""){
		process_tofiletaf = request.getParameter("tofiletaf");
	}
	
	String text_result = "", type_alert = "success", type_glyphicon = "ok-circle";
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script language="javascript" src="js/alert_box.js"></script> 
		<script language="javascript" src="js/check_input.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-filestyle.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
 
		<script>
			document.onkeydown = searchKeyPress_tool;
			$(":file").filestyle({ buttonBefore: true });
			
			function checkInputFile(obj, sText, sText2){
				if(document.getElementById("todatabase").checked == false 
					&& document.getElementById("todataformat").checked == false
					&& document.getElementById("tofiletaf").checked == false){
					ModalWarning_TextName(sText, "");
					return false;
				}else if(document.getElementById("files").value == ""){
					ModalWarning_TextName(sText2, "");
					return false;
				}else{
					var chk_base = "";
					var chk_format = "";
					var chk_taf = "";
					if(document.getElementById("todatabase").checked == true){
						chk_base = "&todatabase=checked";
					}
					if(document.getElementById("todataformat").checked == true){
						chk_format = "&todataformat=checked";
					}
					if(document.getElementById("tofiletaf").checked == true){
						chk_taf = "&tofiletaf=checked";
					}
					
					document.form1.action = "file_upload_trans.jsp?" + chk_base + chk_format + chk_taf;
					document.form1.submit();
				}
			}
			
		</script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<br/>
		
		<%@ include file="../tools/modal_warning.jsp"%>
		<%@ include file="../tools/modal_result.jsp"%>
		<%@ include file="../tools/modal_danger.jsp"%>
		
<%	
	//	Call function convert in java
	ConvertData convData = new ConvertData();
	
	ArrayList msgerr = new ArrayList(); 
	String[] data_arr;
	String data = "";

	boolean chk_data = false;
	boolean isErrorDatabase = false;
	boolean isErrorDataFormat = false;
	boolean isErrorFileTAF = false;

	int countall = 0;
	int countDatabaseRecOK = 0;
	int countDatabaseRecFail = 0;
	int countDataformatRecOK = 0;
	int countDataformatRecFail = 0;
	int countFileTAFRecOK = 0;
	int countFileTAFRecFail = 0;

	String file_name = "";
	String contentType = request.getContentType();
	if((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)){
		
		String pathUpload = path_data.substring(0, (path_data.length() -6))+"\\Upload";
		makeDirectory(pathUpload); 
		
		DataInputStream in = new DataInputStream(request.getInputStream());
        int formDataLength = request.getContentLength();
        byte dataBytes[] = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;
        while(totalBytesRead < formDataLength){
            byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
            totalBytesRead += byteRead;
        }
		
        String file = new String(dataBytes);
        String saveFile = file.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\") +1, saveFile.indexOf("\""));
		String fileName = saveFile.substring(saveFile.lastIndexOf("\\",saveFile.length()) +1, saveFile.length());
		String lastName = fileName.substring(fileName.indexOf(".") +1);
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex +1, contentType.length());
		int pos;
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
		
		String pathName = pathUpload;	//	 System.getProperty("user.dir");
	//	String fileName = getFileNameUpload(request, contentType);
	//	String lastName = fileName.substring(fileName.indexOf(".") +1);
		
		file_name = fileName;
		String fileSave = pathName+"\\"+fileName;
		if(!fileSave.equals("")){
			FileOutputStream fileOut = new FileOutputStream(fileSave);
			fileOut.write(dataBytes, startPos, (endPos - startPos));
			fileOut.flush();
			fileOut.close();
		}else{
			out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror5+"'); </script>");
		}
		
		String TempNameDatabase = "tmpbase_"+getIP(request.getRemoteAddr());
		String TempNameDataFormat = "tmpformat_"+getIP(request.getRemoteAddr());
		String TempNameFileTAF = "tmptaf_"+getIP(request.getRemoteAddr());
		try{
			stmtUp.executeUpdate(dropTableTmpReport(db_database, TempNameDatabase, mode));
			stmtUp.executeUpdate(dropTableTmpReport(db_database, TempNameDataFormat, mode));
			stmtUp.executeUpdate(dropTableTmpReport(db_database, TempNameFileTAF, mode));
			stmtUp.executeUpdate(createTableTmpReport(db_database, TempNameDatabase, "base", mode));
			stmtUp.executeUpdate(createTableTmpReport(db_database, TempNameDataFormat, "format", mode));
			stmtUp.executeUpdate(createTableTmpReport(db_database, TempNameFileTAF, "taf", mode));
		}catch(SQLException e){ }
		
		
		
	//	if((fileName != "") && (lastName.equals("TXT") || lastName.equals("txt") || lastName.equals("TAF") || lastName.equals("taf") || lastName.equals("REC") || lastName.equals("rec"))){
			try{
				BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(pathName+"\\"+fileName),"tis-620"));
				while((data = br.readLine()) != null){
					if(data.trim().length() != 0){
						chk_data = true;
					
						int msg_status_base = 0, msg_status_format = 0, msg_status_taf = 0;
						
						//if(data.length() != 50 && data.length() != 52){
						if(data.length() < 50){
							isErrorDatabase = true;
							isErrorDataFormat = true;
							isErrorFileTAF = true;
							msg_status_base = 9;
							msg_status_format = 9;
							msg_status_taf = 9;
						}else{
							isErrorDatabase = false;
							isErrorDataFormat = false;
							isErrorFileTAF = false;
							
							if(process_todatabase.equals("checked")){
								
								msg_status_base = convData.CheckConvertData(data);
								if(msg_status_base == 1){					//	1 = Success
									
									//	id(16)+duty(1)+date(8)+time(6)+taff(5)+seq(4)+event_code(2)+blank(6)+crc(2)					//	50
									//	id(16)+duty(1)+date(8)+time(6)+taff(5)+seq(4)+event_code(2)+blank(6)+work_code(2)+crc(2)	//	52	//	work_code
									String id = data.substring(0, 16);
									String duty = data.substring(16, 17);
									String dates = data.substring(21,25)+data.substring(19,21)+data.substring(17,19);	// yyyymmdd	// data.substring(17,25)
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
										
									//	เปรียบเทียบ เช็คเวลาว่าถูกตาม Pattern หรือป่าว ถ้าผิดรูปแบบ
									if(!chkPatternTime(times)){
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
										String ip_address = "";		//	find ip address
										String sql = " SELECT d.ip_address, rd.reader_no FROM dbdoor d "
												+ " LEFT OUTER JOIN dbreader rd ON (d.door_id = rd.door_id) "
												+ " WHERE (d.door_id = '"+door_id+"' AND rd.door_id = '"+door_id+"') ";
										ResultSet rs = stmtQry.executeQuery(sql);
										while(rs.next()){
											ip_address = rs.getString("ip_address");
										}
										rs.close();
										
										//insert ลงเบส dbtransaction
										if(ev_code.compareTo("08") <= 0){
											sql = " INSERT INTO dbtransaction (date_event,time_event,reader_no,event_code,idcard,workday,ip_address,duty,data_seq,data_blank,work_code,temperature,wearmask) "
												+ " VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"','"+id+"',"+workday+",'"+ip_address+"','"+duty+"','"+seq+"','"+blank+"','"+work_code+"','"+temperature+"','"+wearingmask+"')";
										}else{
											if(ev_code.compareTo("09") >= 0 && ev_code.compareTo("24") <= 0 || ev_code.equals("47")){
												sql = " INSERT INTO dbtransaction_ev (date_event,time_event,reader_no,event_code,idcard,workday,ip_address,duty,data_seq,data_blank,work_code,temperature,wearmask) "
													+ " VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"','"+id+"',"+workday+",'"+ip_address+"','"+duty+"','"+seq+"','"+blank+"','"+work_code+"','"+temperature+"','"+wearingmask+"')";
											}else{
												sql = " INSERT INTO dbtrans_event (date_event,time_event,reader_no,event_code,workday,ip_address,duty,data_blank) "
													+ " VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"',"+workday+",'"+ip_address+"','"+duty+"','"+blank+"')";
											}
										}
										
										try{
											resultQry = stmtUp.executeUpdate(sql);
										}catch(SQLException es){
											if(resultQry != 1){
												if(ev_code.compareTo("08") <= 0){
													sql = " UPDATE dbtransaction SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
														+ " idcard='"+id+"',workday="+workday+",ip_address='"+ip_address+"',duty='"+duty+"',data_seq='"+seq+"',data_blank='"+blank+"',"
															+"work_code='"+work_code+"',temperature='"+temperature+"',wearmask='"+wearingmask+"' "
														+ " WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') AND (idcard = '"+id+"')";
												}else{
													if(ev_code.compareTo("09") >= 0 && ev_code.compareTo("24") <= 0 || ev_code.equals("47")){
														sql = " UPDATE dbtransaction_ev SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
															+ " idcard='"+id+"',workday="+workday+",ip_address='"+ip_address+"',duty='"+duty+"',data_seq='"+seq+"',data_blank='"+blank+"',"
															+"work_code='"+work_code+"',temperature='"+temperature+"',wearmask='"+wearingmask+"' "
															+ " WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') AND (idcard = '"+id+"')";
													}else{
														sql = " UPDATE dbtrans_event SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
															+ " workday="+workday+",ip_address='"+ip_address+"',duty='"+duty+"',data_blank='"+blank+"' "
															+ " WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') ";
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
								if(!chkPatternTime(data.substring(25, 31))){	//	เปรียบเทียบ เช็คเวลาว่าถูกตาม Pattern หรือป่าว ถ้าผิดรูปแบบ
									isErrorDataFormat = true;
								}else{
									msg_status_format = convData.ConvertDataFormat(data);
									if(msg_status_format == 1){				//	1 = Success
										countDataformatRecOK++;
									}else{									//	0 = Fail, 2 = Software Event 6 Uncheck
										isErrorDataFormat = true;			//	3 = No File config.set or path, 4 = No Set Standard File
									}
								}
							}
							
							if(process_tofiletaf.equals("checked")){
								if(!chkPatternTime(data.substring(25, 31))){	//	เปรียบเทียบ เช็คเวลาว่าถูกตาม Pattern หรือป่าว ถ้าผิดรูปแบบ
									isErrorFileTAF = true;
								}else{
									msg_status_taf = convData.ConvertDataTAF(data);
									if(msg_status_taf == 1){				//	1 = Success
										countFileTAFRecOK++;
									}else{									//	0 = Fail
										isErrorFileTAF = true;
									}
								}
							}
							
						}
						
						//	if isError is true > insert to taffupload
						if(isErrorDatabase){
							countDatabaseRecFail++;		//	Count fail record
							try{
								stmtUp.executeUpdate(" INSERT INTO "+TempNameDatabase+" (id, filename, description, error_message) VALUES ("+countDatabaseRecFail+", '"+fileName+"', '"+data+"', '"+msg_status_base+"') ");
							}catch(SQLException e){ }
						}
						if(isErrorDataFormat){
							countDataformatRecFail++;	//	Count fail record
							try{
								stmtUp.executeUpdate(" INSERT INTO "+TempNameDataFormat+" (id, filename, description, error_message) VALUES ("+countDataformatRecFail+", '"+fileName+"', '"+data+"', '"+msg_status_format+"') ");
							}catch(SQLException e){ }
						}
						if(isErrorFileTAF){
							countFileTAFRecFail++;	//	Count fail record
							try{
								stmtUp.executeUpdate(" INSERT INTO "+TempNameFileTAF+" (id, filename, description, error_message) VALUES ("+countDataformatRecFail+", '"+fileName+"', '"+data+"', '"+msg_status_taf+"') ");
							}catch(SQLException e){ }
						}
						
						countall++;
					}
				}
				br.close();
				
			 	if((!chk_data)){
					out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror4+"'); </script>");		//	ไม่มีข้อมูล
				}else{
					if(countDatabaseRecFail == 0 && countDataformatRecFail == 0 && countFileTAFRecFail == 0){
						out.println("<script> ModalSuccess_NoParam('"+uploadFile_msgerror3+"'); </script>");			//	การอัพโหลดข้อมูลสำเร็จ
					}else{
						out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror2+"'); </script>");	//	ไม่สามารถอัพโหลดข้อมูลได้ครบ
					}
				}
				
				rc.WriteDataLogFile("["+ses_user+"] Process File [DUMP]");
			}catch(IOException e){
				out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror5+"'); </script>");
			}
			
	//	}else{
	//		out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror6+"'); </script>");
	//	}
	
		File f1 = new File(pathName+"\\"+fileName);
		f1.delete();
		
	}
	
%>	
		<div class="body-display">
			<div class="container" style="margin-top: -20px;">
			
				<div class="col-md-1"> </div>
				<div class="col-md-10">
					<form name="form1" id="form1" enctype="multipart/form-data" method="post" action="file_upload_trans.jsp">
						<div class="panel panel-primary"> 
							<div class="panel-heading">
								<h3 class="panel-title"> <b> <%= lb_transaction_file %> </b> </h3> 
							</div> 
							<div class="panel-body"> 
							
								<div class="table-responsive" style="border: 0px !important;" border="0">
									<div style="min-width: 800px; max-width: 100%; margin-left: 15px; margin-right: 15px;" border="0">

										<div class="row">
											<label class="col-xs-2 col-md-2" style="margin-top: 6px;"> </label>
											<div class="col-xs-4 col-md-4" style="margin-top: 6px;">
												<input type="checkbox" id="todatabase" name="todatabase" value="checked" <%= process_todatabase %> > 
												<label style="margin-left: 5px;"> <%= lb_process_todatabase %> </label>
											</div>
										</div>
										<div class="row" style="margin-top: 5px;">
											<label class="col-xs-2 col-md-2" style="margin-top: 6px;"> </label>
											<div class="col-xs-4 col-md-4" style="margin-top: 6px;">
												<input type="checkbox" id="todataformat" name="todataformat" value="checked" <%= process_todataformat %> > 
												<label style="margin-left: 5px;"> <%= lb_process_todataformat %> </label>
											</div>
										</div>
										<div class="row" style="margin-top: 5px;">
											<label class="col-xs-2 col-md-2" style="margin-top: 6px;"> </label>
											<div class="col-xs-4 col-md-4" style="margin-top: 6px;">
												<input type="checkbox" id="tofiletaf" name="tofiletaf" value="checked" <%= process_tofiletaf %> > 
												<label style="margin-left: 5px;"> <%= lb_process_tofiletaf %> </label>
											</div>
										</div>
										<div class="row" style="margin-top: 15px; margin-bottom: 10px;">
											<label class="col-xs-2 col-md-2" style="margin-top: 1px;"> </label>
											<div class="col-xs-6 col-md-6">
												<input type="file" name="files" id="files" class="filestyle" data-buttonBefore="true" data-buttonText="&nbsp; Choose File" data-buttonName="btn-primary" data-size="md">
											</div>
											<div class="col-md-4 col-xs-4" align="right" style="margin-bottom: 0px;"> 
												<input type="button" name="upload" id="btnok" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_process_text %> &nbsp; &nbsp; &nbsp; " onclick="return checkInputFile(document.form1.files, '<%= lb_select_process %>', '<%= alert_InputFile %>');">
											</div> 
										</div>
										
							<%	
								if(chk_data){
								
									//	แสดงรายการ
									out.println("<div class='row' style='margin-top: 20px;'>");
									out.println("<div class='alert alert-info' role='alert' align='center'> <strong> "+lb_processfile+" &nbsp; "+file_name+" &nbsp; "+lb_all+" &nbsp; " + countall + " &nbsp; " + lb_record + " </strong> </div>");
									out.println("<table class='table' style='max-width: 700px;' align='center'>");
									if(process_todatabase.equals("checked")){
										out.println("	<tr>");
										out.println("		<td align='left' width='35%'> <strong> " + lb_process_todatabase + " </strong> </td>");
										out.println("		<td align='right' width='15%' style='color: #3C763D;'> <span class='glyphicon glyphicon-ok'> </span> &nbsp; " + lb_succ + " </td>");
										out.println("		<td align='right' width='15%' style='color: #3C763D;'> <strong> " + countDatabaseRecOK + " </strong> &nbsp; " + lb_record + " </td>");
										out.println("		<td align='right' width='20%' style='color: #A94442;'> <span class='glyphicon glyphicon-remove'> </span> &nbsp; " + lb_notprocessuc + " </td>");
										if(countDatabaseRecFail != 0){
											out.println("	<td align='right' width='15%' style='color: #A94442;'> <strong> <a href='#' onClick='show_detail(\"base\");'>" + countDatabaseRecFail + "</a> </strong> &nbsp; " + lb_record + " </td>");
										}else{
											out.println("	<td align='right' width='15%' style='color: #A94442;'> <strong> " + countDatabaseRecFail + " </strong> &nbsp; " + lb_record + " </td>");
										}
										out.println("	</tr>");
									}
									if(process_todataformat.equals("checked")){
										out.println("	<tr>");
										out.println("		<td align='left' width='35%'> <strong> " + lb_process_todataformat + " </strong> </td>");
										out.println("		<td align='right' width='15%' style='color: #3C763D;'> <span class='glyphicon glyphicon-ok'> </span> &nbsp; " + lb_succ + " </td>");
										out.println("		<td align='right' width='15%' style='color: #3C763D;'> <strong> " + countDataformatRecOK + " </strong> &nbsp; " + lb_record + " </td>");
										out.println("		<td align='right' width='20%' style='color: #A94442;'> <span class='glyphicon glyphicon-remove'> </span> &nbsp; " + lb_notprocessuc + " </td>");
										if(countDataformatRecFail != 0){
											out.println("	<td align='right' width='15%' style='color: #A94442;'> <strong> <a href='#' onClick='show_detail(\"format\");'>" + countDataformatRecFail + "</a> </strong> &nbsp; " + lb_record + " </td>");
										}else{
											out.println("	<td align='right' width='15%' style='color: #A94442;'> <strong> " + countDataformatRecFail + " </strong> &nbsp; " + lb_record + " </td>");
										}
										out.println("	</tr>");
									}
									if(process_tofiletaf.equals("checked")){
										out.println("	<tr>");
										out.println("		<td align='left' width='35%'> <strong> " + lb_process_tofiletaf + " </strong> </td>");
										out.println("		<td align='right' width='15%' style='color: #3C763D;'> <span class='glyphicon glyphicon-ok'> </span> &nbsp; " + lb_succ + " </td>");
										out.println("		<td align='right' width='15%' style='color: #3C763D;'> <strong> " + countFileTAFRecOK + " </strong> &nbsp; " + lb_record + " </td>");
										out.println("		<td align='right' width='20%' style='color: #A94442;'> <span class='glyphicon glyphicon-remove'> </span> &nbsp; " + lb_notprocessuc + " </td>");
										if(countFileTAFRecFail != 0){
											out.println("	<td align='right' width='15%' style='color: #A94442;'> <strong> <a href='#' onClick='show_detail(\"taf\");'>" + countFileTAFRecFail + "</a> </strong> &nbsp; " + lb_record + " </td>");
										}else{
											out.println("	<td align='right' width='15%' style='color: #A94442;'> <strong> " + countFileTAFRecFail + " </strong> &nbsp; " + lb_record + " </td>");
										}
										out.println("	</tr>");
									}
									out.println("	<tr>");
									out.println("		<td colspan='5'> </td>");
									out.println("	</tr>");
									out.println("</table>");	
									out.println("</div>");
								
								}
								
							%>
										
									</div> 
								</div>
							
							</div> 
						</div>
					</form>
				</div>
				<div class="col-md-1"> </div>
				
			</div>
		</div> 
		
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
			function show_detail(type){
				view_detail.location = 'file_detailall.jsp?typefile='+type;
				$('#myModalViewDetail').modal('show');
			}
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>