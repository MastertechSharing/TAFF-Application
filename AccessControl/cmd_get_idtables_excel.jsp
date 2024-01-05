<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%
	session.setAttribute("page_g", "tool");	
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	session.setAttribute("action", "cmd_get_idtables_data.jsp?ip="+ip+"&door_id="+door_id+"&");	
%>

<%
	String sql = "", desc = "", ip_addr = "";
	try{
		if(!ip.equals("")){
			sql = " SELECT door_id, th_desc, en_desc, ip_address FROM dbdoor WHERE ip_address = '"+ip+"' ";
		}else{
			sql = " SELECT door_id, th_desc, en_desc, ip_address FROM dbdoor WHERE door_id = '"+door_id+"' ";
		}
		ResultSet rs = stmtQry.executeQuery(sql);
		while(rs.next()){
			door_id = rs.getString("door_id");
			if(lang.equals("th")){
				desc = rs.getString("th_desc");
			}else{
				desc = rs.getString("en_desc");
			}
			ip_addr = rs.getString("ip_address");
		}
		rs.close();
		
		String pathfile = "";
		if(!ip.equals("")){
			pathfile = path_data+ip+"\\ID\\ID.IDS";
		}else{
			pathfile = path_data+door_id+"\\ID\\ID.IDS";
		}
		out.println(pathfile);
		File f = new File(pathfile);
		if(!(f.exists())){
			out.println("<script> ModalDanger_10Second('"+uploadFile_msgerror5+" "+lb_doorcode+" : "+door_id+" - "+desc+"'); </script>");
		}else{						
			String fileName = "ID_"+door_id+".CSV";
			int num = 1;
			try{
				HSSFWorkbook wb = new HSSFWorkbook();
				HSSFSheet sheet = wb.createSheet("Download Data");
				//ข้อมูลที่แสดงตรงส่วนหัวกระดาษ
				HSSFRow headingsRow = sheet.createRow((short)0);// create row ส่วนหัวข้อใหญ่แถวแรก
				headingsRow.createCell((short)0).setCellValue("Export's DateTime At");
				headingsRow.createCell((short)4).setCellValue(getCurrentDate()+"  "+getCurrentTimeShort());
				//ข้อมูลที่แสดงชื่อหัวข้อ
				HSSFRow headRow = sheet.createRow((short)num++);// create row ส่วนหัว
				headRow.createCell((short)0).setCellValue(lb_empcode);//ID
				headRow.createCell((short)1).setCellValue(lb_names);//NAME
				headRow.createCell((short)2).setCellValue(lb_issue);//ISSUE
				headRow.createCell((short)3).setCellValue(lb_pincode);//PINCODE
				headRow.createCell((short)4).setCellValue(lb_startdate);//START DATE/TIME
				headRow.createCell((short)5).setCellValue(lb_expiredate);//EXPIRE DATE/TIME
				headRow.createCell((short)6).setCellValue("RD 1");//RD1
				headRow.createCell((short)7).setCellValue("RD 2");//RD2
				headRow.createCell((short)8).setCellValue(lb_dateupdate);//DATA UPDATE Time
				headRow.createCell((short)9).setCellValue("BIO");//USE FINGER
				headRow.createCell((short)10).setCellValue("Use Map Card");//USE MAP CARD
				headRow.createCell((short)11).setCellValue(lb_serial_card);//SERAIL CARD
				headRow.createCell((short)12).setCellValue(lb_temp+" 1");//TEMPLATE1
				headRow.createCell((short)13).setCellValue(lb_temp+" 2");//TEMPLATE2
				headRow.createCell((short)14).setCellValue(lb_dateupdate);//FINGER UPDATE
				// แสดงข้อมูลที่อ่านขึ้นมา
				HSSFRow dataRow;
								
				int lenID = 0;
				int lenFinger1 = 0;
				int lenFinger2 = 0;
				if(getModuleF(stmtQry).equals("0")){
					//Suprema
					lenID = 1800;
					lenFinger1 = 384;
					lenFinger2 = 768;
				}else{
					//SecuGen
					lenID = 3532;
					lenFinger1 = 817;
					lenFinger2 = 1634;
				}
				String textHex = "", textStr = "";
				String idcard = "", issue = "", pincode = "", st_date = "", ex_date = "", time_rd1 = "", time_rd2 = "", 
					update_data = "", quanlity1 = "", finger1 = "", template1 = "", quanlity2 = "", finger2 = "", 
					template2 = "", date_finger = "", use_finger = "", antipass = "", idname = "", use_mapcard = "", 
					sn_card = "", st_time = "", ex_time = "", new_sn_card = "";	
				byte[] byteArray = null;
				try{
					//byteArray = getBytesFromFile(f);
					byteArray = readFileToByte(pathfile);
				}catch (IOException e){
				
				}
				String byteHexString = "";
				if(byteArray != null) {
					//byteHexString = bytesToHexString(byteArray);
					byteHexString = byteToHex(byteArray);
				}
				for(int i = 0; i <= byteHexString.length()-1; i+=lenID){
					textHex = byteHexString.substring(i,(i+lenID));
					textStr = convertHexToString(textHex);
					idcard = textStr.substring(4,20);//ID(16)
					issue = textStr.substring(20,22);//ISSUE(2)
					pincode = textStr.substring(22,26);//PINCODE(4)
					st_date = textStr.substring(26,34);//STARTDATE(8)
					ex_date = textStr.substring(34,42);//EXPIREDATE(8)
					time_rd1 = textStr.substring(42,44);//TIMECODE_RD1(2)
					time_rd2 = textStr.substring(44,46);//TIMECODE_RD2(2)
					update_data = textStr.substring(46,60);//DATETIME_DATA(14)
					quanlity1 = textStr.substring(60,61);//QUANLITY1(1)
					finger1 = textStr.substring(61,62);//FINGER1(1)
					template1 = textStr.substring(62,(62+lenFinger1));//TEMPLATE1(384)
					quanlity2 = textStr.substring((62+lenFinger1),(63+lenFinger1));//QUANLITY2(1)
					finger2 = textStr.substring((63+lenFinger1),(64+lenFinger1));//FINGER2(1)
					template2 = textStr.substring((64+lenFinger1),(64+lenFinger2));//TEMPLATE2(384)
					date_finger = textStr.substring((64+lenFinger2),(78+lenFinger2));//DATETIME_FINGER(14)
					use_finger = textStr.substring((78+lenFinger2),(79+lenFinger2));//USE_FINGER(1)
					antipass = textStr.substring((79+lenFinger2),(80+lenFinger2));//ANTIPASSBACK(1) USE NEW_SERAIL_CARD
					idname = textStr.substring((80+lenFinger2),(112+lenFinger2));//NAME(32)
					use_mapcard = textStr.substring((112+lenFinger2),(113+lenFinger2));//USE_MAP_CARD(1)
					sn_card = textStr.substring((113+lenFinger2),(117+lenFinger2));//SERAIL_CARD(4)
					st_time = textStr.substring((117+lenFinger2),(119+lenFinger2))+":"+textStr.substring((119+lenFinger2),(121+lenFinger2));//STARTTIME(4)
					ex_time = textStr.substring((121+lenFinger2),(123+lenFinger2))+":"+textStr.substring((123+lenFinger2),(125+lenFinger2));//EXPIRETIME(4)
					new_sn_card = textStr.substring((125+lenFinger2),(127+lenFinger2));//NEW_SERAIL_CARD(2)
					
					if(pincode.equals("****")){
						pincode = "-";
					}
					if(st_date.equals("********")){
						st_date = "-";
					}else{
						st_date = st_date.substring(6,8)+"/"+st_date.substring(4,6)+"/"+st_date.substring(0,4)+" "+st_time;
					}
					
					if(ex_date.equals("********")){
						ex_date = "-";
					}else{
						ex_date = ex_date.substring(6,8)+"/"+ex_date.substring(4,6)+"/"+ex_date.substring(0,4)+" "+ex_time;	
					}
					
					if(update_data.equals("**************")){
						update_data = "-";
					}else{
						update_data = update_data.substring(6,8)+"/"+update_data.substring(4,6)+"/"+update_data.substring(0,4)
									+" "+update_data.substring(8,10)+":"+update_data.substring(10,12)+":"+update_data.substring(12,14);
					}
					
					if(!(quanlity1.equals("*") || finger1.equals("*"))){
						template1 = lb_use;
					}else{
						template1 = lb_notuse;
					}
					
					if(!(quanlity2.equals("*") || finger2.equals("*"))){
						template2 = lb_use;
					}else{
						template2 = lb_notuse;
					}
					
					if(date_finger.equals("**************")){
						date_finger = "-";
					}else{	
						date_finger = date_finger.substring(6,8)+"/"+date_finger.substring(4,6)+"/"+date_finger.substring(0,4)
									+" "+date_finger.substring(8,10)+":"+date_finger.substring(10,12)+":"+date_finger.substring(12,14);
					}
					
					if(use_finger.equals("1")){
						use_finger = lb_use;
					}else{
						use_finger = lb_notuse;
					}
					
					if(use_mapcard.equals("1")){
						use_mapcard = lb_use;
					}else{
						use_mapcard = lb_notuse;
					}
					
					if(sn_card.equals("****")){
						sn_card = "-";
					}else{
						sn_card = textHex.substring((113+lenFinger2)*2,(117+lenFinger2)*2).toUpperCase();	
					}
					if (quanlity2.equals("1")){
					//if(!antipass.equals("*")){
						antipass = textHex.substring((79+lenFinger2)*2,(80+lenFinger2)*2).toUpperCase();
						sn_card = sn_card + antipass;
					//}
					//if (!new_sn_card.equals("**")){					
						new_sn_card = textHex.substring((125+lenFinger2)*2,(127+lenFinger2)*2).toUpperCase();
						sn_card = sn_card + new_sn_card;					
					}
								
					//idname = new String (idname.getBytes ("ISO8859_1"), "TIS-620");
					
					dataRow = sheet.createRow((short)num++); 
					dataRow.createCell((short)0).setCellValue(idcard);
					dataRow.createCell((short)1).setCellValue(idname);
					dataRow.createCell((short)2).setCellValue(issue);
					dataRow.createCell((short)3).setCellValue(pincode);
					dataRow.createCell((short)4).setCellValue(st_date);
					dataRow.createCell((short)5).setCellValue(ex_date);
					dataRow.createCell((short)6).setCellValue(time_rd1);
					dataRow.createCell((short)7).setCellValue(time_rd2);
					dataRow.createCell((short)8).setCellValue(update_data);
					dataRow.createCell((short)9).setCellValue(use_finger);
					dataRow.createCell((short)10).setCellValue(use_mapcard);
					dataRow.createCell((short)11).setCellValue(sn_card);
					dataRow.createCell((short)12).setCellValue(template1);
					dataRow.createCell((short)13).setCellValue(template2);
					dataRow.createCell((short)14).setCellValue(date_finger);
				}
				FileOutputStream fileOut = new FileOutputStream(fileName);
				wb.write(fileOut);
				fileOut.close();
			}catch(IOException ioe){
				
			}
			
			// open excel file
			openFileExcel(fileName,response);
		}
	}catch(IOException ioe){
		
	}
%>

<%@ include file="../function/disconnect.jsp"%>