<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%	
	session.setAttribute("page_g", "special"); 
	session.setAttribute("subpage", "importfile");
	session.setAttribute("subtitle", "employee2");	
	session.setAttribute("action", "file_upload_employee2.jsp?");
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
	int pass = 0;
	int no_pass = 0;
	int countall = 0;
	ArrayList msgerr = new ArrayList();
	String[] data_arr;
	String message = "";
	String sql = "", sql_in = "", sql_up = "";
	
	String fname = "";
	String sname = "";
	String use_finger = "";
	String sn_card = "";
	String use_map_card = "";
	String issue = "";
	String pincode = "";
	String st_date = "";
	String ex_date = "";
	String st_time = "";
	String ex_time = "";
	String group_code = "";
	String sec_code = "";	
	String pos_code = "";
	String type_code = "";
	String cardid = "";
	String user_password = "";
	String date_data = "";
	String chk_lang_fname = "";
	String chk_lang_sname = "";
	ResultSet myresult = null;
	
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
            byteRead = in.read(dataBytes, totalBytesRead,formDataLength);
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
		
		String fileSave = pathName+"\\"+fileName;
		if(!fileSave.equals("")){
			FileOutputStream fileOut = new FileOutputStream(fileSave);
			fileOut.write(dataBytes, startPos, (endPos - startPos));
			fileOut.flush();
			fileOut.close();
		}else{
			out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror5+"'); </script>");
		}
		
		if((fileName != "") && (lastName.equals("TXT") ||lastName.equals("txt") || lastName.equals("CSV") || lastName.equals("csv"))){
			try{
				rc.WriteDataLogFile("["+ses_user+"] Upload File Employee [dbemployee]");
				boolean chk_data = true;
				BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(pathName+"\\"+fileName),"tis-620"));
				int rec_no = 0;
				while((message = br.readLine()) != null){					
					rec_no++;
					if(rec_no == 1 || message.trim().length() == 0){
						continue;
					}else{
						chk_data = true;
						boolean chk_dupcardid = false, chk_blacklist = false;
						
						if(message.length() > 250){
							message = message.substring(0, 250);
						}
						
						data_arr = (message+",#").split(",");
						
						boolean ckCode = chkPatternCode(data_arr[0].trim());
						if(data_arr.length != 17 && data_arr.length != 18){
							msgerr.add(message+" --> ("+lb_format_file_err+")");
							no_pass++;
						}else if(!ckCode || data_arr[0].length() > 16){
							msgerr.add(message+" --> ("+lb_format_file_err+")");
							no_pass++;
						}else if((data_arr[8].length() != 10) || data_arr[9].length() != 10){
							msgerr.add(message+" --> ("+alertDT_upload+")" );
							no_pass++;
						}else if((data_arr[10].length() != 5) || data_arr[11].length() != 5){
							msgerr.add(message+" --> ("+alertT_upload+")" );
							no_pass++;
						}else{
							if(!chkPatternDate(data_arr[8]) || !chkPatternDate(data_arr[9])){
								msgerr.add(message+" --> ("+alertDT_upload+")");
								no_pass++;
							}else if(!chkPatternTime2(data_arr[10]) || !chkPatternTime2(data_arr[11])){
								msgerr.add(message+" --> ("+alertDT_upload+")");
								no_pass++;
							}else if(data_arr[12].length() > 13 || data_arr[12].equals("")){ //group_code
								msgerr.add(message+" --> "+alert_codesgroup+" "+lb_orspace);
								no_pass++;
							}else if(data_arr[13].length() > 6 || data_arr[13].equals("")){ //sec_code
								msgerr.add(message+" --> "+alert_codes+" "+lb_orspace);
								no_pass++;
							}else if(data_arr[14].length() > 6 || data_arr[14].equals("")){ //pos_code
								msgerr.add(message+" --> "+alert_codespos+" "+lb_orspace);
								no_pass++;
							}else if(data_arr[15].length() > 6 || data_arr[15].equals("")){ //type_code
								msgerr.add(message+" --> "+alert_codestype+" "+lb_orspace);
								no_pass++;
							}else{
								
								fname = data_arr[1];
								sname = data_arr[2];
								use_finger = data_arr[3].trim();
								sn_card = data_arr[4].trim();
								use_map_card = data_arr[5].trim();
								issue = data_arr[6].trim();
								pincode = data_arr[7].trim();
								st_date = dateToYMD(data_arr[8]);
								ex_date = dateToYMD(data_arr[9]);
								st_time = data_arr[10].trim();
								ex_time = data_arr[11].trim();
								group_code = data_arr[12].trim();
								sec_code = data_arr[13].trim();
								pos_code = data_arr[14].trim();
								type_code = data_arr[15].trim();
								date_data = getCurrentDateTime();
								
								if(!(issue.equals(""))){
									if(issue.length() >= 1 || issue.length() <= 2){									
										if(!chkPatternIssue(issue)){
											issue = "01";
										}
									}
								}else{
									issue = "01";
								}
								if(!(pincode.equals(""))){
									if(pincode.length() == 4){
										if (!chkPatternPinCode(pincode)){
											pincode = "";
											msgerr.add(message+" --> "+alert_format_pincode);
										}
									}else{
										pincode = "";
										msgerr.add(message+" --> "+alert_format_pincode);
									}
								}							
								if(!(sn_card.equals(""))){
									if(sn_card.length() == 8 || sn_card.length() == 14){
										if (!chkPatternSNCard(sn_card)){
											sn_card = "";
											msgerr.add(message+" --> "+alert_format_sncard);
										}
									}else{
										sn_card = "";
										msgerr.add(message+" --> "+alert_not_sncard);
									}
								}
								
								chk_lang_fname = "th_fname";
								chk_lang_sname = "th_sname";
								if(!(fname.equals(""))){
									if(chkCharacterEng(fname.trim().substring(0, 1))){
										chk_lang_fname = "en_fname";
										chk_lang_sname = "en_sname";
									}
								}
								
								if(chk_dupcardid == false && chk_blacklist == false){
									try{
										//	Check Blacklist From IDCard
										sql = " SELECT COUNT(idcard) AS count_id FROM dbblacklist "
											+ " WHERE (idcard = '"+data_arr[0]+"' AND cancel_status = '0') ";
										ResultSet rs = stmtQry.executeQuery(sql);
										if(rs.next()){
											if(rs.getInt("count_id") > 0){
												chk_blacklist = true;
												msgerr.add(message+" --> "+lb_blacklist_idcard);
											}
										}	rs.close();
									}catch(SQLException e){ }
								}
								
								user_password = getPassword(data_arr[0].toString(), stmtQry, mode);							
								sql_in = "INSERT INTO dbemployee (idcard, "+chk_lang_fname+", "+chk_lang_sname+", use_finger, sn_card, use_map_card, issue, pincode, "
										+ "st_date, ex_date, st_time, ex_time, group_code, sec_code, pos_code, type_code, pass_word, date_data) "
										+ "VALUES ('"+data_arr[0]+"', '"+fname+"', '"+sname+"' ,'"+use_finger+"', '"+sn_card+"', '"+use_map_card+"', '"+issue+"', '"+pincode
										+ "', '"+st_date+"', '"+ex_date+"', '"+st_time+"', '"+ex_time+"', '"+group_code+"', '"+sec_code+"', '"+pos_code+"', '"+type_code
										+ "', '"+user_password+"', '"+date_data+"')";
								
								sql_up = "UPDATE dbemployee SET "+chk_lang_fname+"='"+fname+"', "+chk_lang_sname+"='"+sname+"', "
										+ "use_finger='"+use_finger+"', sn_card='"+sn_card+"', use_map_card='"+use_map_card+"', "
										+ "issue='"+issue+"', pincode='"+pincode+"',st_date='"+st_date+"', ex_date='"+ex_date+"', "
										+ "st_time='"+st_time+"', ex_time='"+ex_time+"', group_code='"+group_code+"', sec_code='"+sec_code+"', "
										+ "pos_code='"+pos_code+"', type_code='"+type_code+"', pass_word='"+user_password+"', date_data='"+date_data+"' "
										+ "WHERE (idcard = '"+data_arr[0]+"')";
								
								if(chk_dupcardid == false && chk_blacklist == false){
									
									if(data_arr.length == 17){				//	No Type Card ID		17Length
										
										try{
											resultQry = stmtUp.executeUpdate(sql_in);
											rc.WriteDataLogFile("["+ses_user+"] Insert idcard : " + data_arr[0] + " [dbemployee]");
											pass++;
										}catch(SQLException e){
											if(resultQry != 1){
												try{
													stmtUp.executeUpdate(sql_up);
													rc.WriteDataLogFile("["+ses_user+"] Update idcard : " + data_arr[0] + " [dbemployee]");
													pass++;
												}catch(SQLException eupdate){
													msgerr.add(message+" -->("+eupdate.getMessage()+")");
													no_pass++;
												}
											}
										}
										
									}else if(data_arr.length == 18){		//	 Type Card ID		18Length
										
										cardid = data_arr[16].trim();
										if(!(cardid.equals(""))){
											if(cardid.length() == 13){
												if (!chkPatternCardID(cardid)){
													cardid = "";
													msgerr.add(message+" --> "+alert_cardids);
												}else{
													
													try{
														//	Check Duplicate Card ID
														sql = " SELECT COUNT(idcard) AS count_id FROM dbemployee "
															+ " WHERE idcard != '"+data_arr[0]+"' AND card_id = '"+cardid+"' ";
														ResultSet rs = stmtQry.executeQuery(sql);
														if(rs.next()){
															if(rs.getInt("count_id") > 0){
																chk_dupcardid = true;
																msgerr.add(message+" --> "+msg_dupcardid);
															}
														}	rs.close();
													}catch(SQLException e){ }
													
													if(chk_dupcardid == false){
														try{
															//	Check Blacklist From Card ID
															sql = " SELECT COUNT(idcard) AS count_id FROM dbblacklist "
																+ " WHERE (card_id = '"+cardid+"' AND cancel_status = '0') ";
															ResultSet rs2 = stmtQry.executeQuery(sql);
															if(rs2.next()){
																if(rs2.getInt("count_id") > 0){
																	chk_blacklist = true;
																	msgerr.add(message+" --> "+lb_blacklist_cardid);
																}
															}	rs2.close();
														}catch(SQLException e){ }
													}
												}
											}else{
												cardid = "";
												msgerr.add(message+" --> "+alert_cardids);
											}
										}
										
										if(chk_dupcardid == false && chk_blacklist == false){
										
											try{
												resultQry = stmtUp.executeUpdate(sql_in);
												rc.WriteDataLogFile("["+ses_user+"] Insert idcard : " + data_arr[0] + " [dbemployee]");
												pass++;
											}catch(SQLException e){
												if(resultQry != 1){
													String card_id_old = "";
													try{
														//	Get Old Card ID
														sql = " SELECT card_id FROM dbemployee WHERE idcard = '"+data_arr[0]+"' ";
														ResultSet rs = stmtQry.executeQuery(sql);
														if(rs.next()){
															card_id_old = rs.getString("card_id");
														}	rs.close();
													}catch(SQLException e2){ }
													
													try{
														stmtUp.executeUpdate(sql_up);
														rc.WriteDataLogFile("["+ses_user+"] Update idcard : " + data_arr[0] + " [dbemployee]");
														pass++;
														
														if(!(cardid.equals("") && cardid.equals(card_id_old))){
															//	Change Card ID
															stmtUp.executeUpdate(updateTable("dbblacklist","card_id",cardid,card_id_old));
														}
													
													}catch(SQLException eupdate){
														msgerr.add(message+" -->("+eupdate.getMessage()+")");
														no_pass++;
													}
												}
											}
											
											try{
												stmtUp.executeUpdate(" UPDATE dbemployee SET card_id = '"+cardid+"' WHERE idcard = '"+data_arr[0]+"' ");
											}catch(SQLException e2){ }
											
										}else{
											no_pass++;
										}
									}
								}else{
									no_pass++;
								}
							}
						}
						countall++;
					}
				}
				br.close();
				
				if((!chk_data)){
					out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror4+"'); </script>");//	ไม่มีข้อมูล
				}else if(no_pass == 0){
					out.println("<script> ModalSuccess_NoParam('"+uploadFile_msgerror3+"'); </script>");//	การอัพโหลดข้อมูลสำเร็จ
				}else if(pass == 0){
					out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror1+"'); </script>");//	ไม่สามารถอัพโหลดข้อมูลได้ [ กรุณารอสักครู่ .... ]
				}else{
					out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror2+"'); </script>");//	ไม่สามารถอัพโหลดข้อมูลได้ครบ
				}
				rc.WriteDataLogFile("[" + ses_user + "] Record all "+countall+" records, Upload success "+pass+" records, Upload fail "+no_pass+" records [dbemployee]");
			}catch(IOException e){
				out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror5+"'); </script>");
			}
		}else{
			out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror6+"'); </script>");
		}
		File f1 = new File(pathName+"\\"+fileName);
		f1.delete();
	}
%>
		<div class="body-display">
			<div class="container" style="margin-top: -20px;">
			
				<div class="col-md-1"> </div>
				<div class="col-md-10">
					<form name="form1" id="form1" enctype="multipart/form-data" method="post" action="file_upload_employee2.jsp">
						<div class="panel panel-primary"> 
							<div class="panel-heading">
								<h3 class="panel-title"> <b> <%= lb_employee %> [<%= lb_master_data %>] </b> </h3> 
							</div> 
							<div class="panel-body"> 

								<div class="table-responsive" style="border: 0px !important;" border="0">
									<div style="min-width: 800px; max-width: 100%; margin-left: 15px; margin-right: 15px;" border="0">

										<div class="row">
											<label class="col-md-2 col-xs-2"> 
												<span class="glyphicon glyphicon-list-alt" style="margin-left: -15px; font-size: 16px;"> </span> &nbsp; <%= lb_dataformat %> 
											</label> 
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_empcode %> ( 16 <%= lb_letter %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_fname %> ( 100 <%= lb_letter2 %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_sname %> ( 100 <%= lb_letter2 %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_usebio %> ( 1 <%= lb_letter %> <%= lb_detail_use_bio %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_serial_card %> ( 8 <%= lb_or2 %> 14 <%= lb_digit %> <%= lb_ex2 %> : a-f A-F 0-9 <%= lb_or2 %> 0-9 a-f A-F ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_use_mapcard %> ( 1 <%= lb_letter %> <%= lb_detail_use %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_issue %> ( 2 <%= lb_letter %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_pincode %> ( <%= lb_numberic %> 4 <%= lb_letter %> <%= lb_orspace %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_startdate %> ( dd/mm/yyyy ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_expiredate %> ( dd/mm/yyyy ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_starttime %> ( HH:MM ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_expiretime %> ( HH:MM ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_groupcode %> ( 6 <%= lb_letter %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_seccode %> ( 6 <%= lb_letter %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_poscode %> ( 6 <%= lb_letter %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_typecode %> ( 6 <%= lb_letter %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_cardid %> ( 13 <%= lb_letter %> <%= lb_orspace %> <%= lb_ex2 %> : XXXXXXXXXXXXX ) <i> *<%= lb_not_force %> </i> </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div> 
											<div class="col-md-6 col-xs-6">
												<input type="file" name="files" id="files" class="filestyle" data-buttonBefore="true" data-buttonText="&nbsp; Choose File" data-buttonName="btn-primary" data-size="md">
											</div>
											<div class="col-md-4 col-xs-4" align="right" style="margin-bottom: 0px;"> 
												<input type="button" name="upload" id="btnok" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_upload %> &nbsp; &nbsp; &nbsp; " onclick="return checkInputFile(document.form1.files, '<%= alert_InputFile %>');">
											</div> 
										</div>
									</div> 
								</div>

							<%	if(msgerr.size() != 0){	%>
							
								<div class="table-responsive" style="border: 0px !important;" border="0">
									<div style="min-width: 800px; max-width: 100%; margin-top: 15px; margin-left: 15px; margin-right: 15px;" border="0">
							
										<div class="row">
											<label class="col-md-12"> 
												<div class="alert alert-danger" role="alert">
													<span class="glyphicon glyphicon-remove"> </span> <%= lb_incorrectdata %> &nbsp; <%= lb_notupload %> <%= no_pass %> <%= lb_reccorddata %> , &nbsp; <%= lb_uploadok %> <%= pass %> <%= lb_reccorddata %> , &nbsp; <%= lb_recordall %> <%= countall %> <%= lb_reccorddata %>
												</div>
											</label> 
										</div>
									<%		for (int i = 0; i < msgerr.size(); i++) {	%>
										<div class="row">
											<label class="col-md-12"> 
												<%= i + 1 + ". " + msgerr.get(i) %>
											</label> 
										</div>
									<%		}	%>
									
									</div> 
								</div>
								
							<%	}	%>
							
							</div> 
						</div>
					</form>
				</div>
				<div class="col-md-1"> </div>
				
			</div>
		</div> 
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>