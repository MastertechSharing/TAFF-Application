<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*" %>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%@ include file="../function/datetime.jsp"%>

<%@ page import="java.util.Arrays" %>
<%@ page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@ page import="javax.xml.parsers.DocumentBuilder"%>
<%@ page import="javax.xml.transform.OutputKeys"%>
<%@ page import="javax.xml.transform.Transformer"%>
<%@ page import="javax.xml.transform.TransformerFactory"%>
<%@ page import="javax.xml.transform.dom.DOMSource"%>
<%@ page import="javax.xml.transform.stream.StreamResult"%>
<%@ page import="org.w3c.dom.Attr"%>
<%@ page import="org.w3c.dom.Document"%>
<%@ page import="org.w3c.dom.Element"%>

<% 
	session.setAttribute("page_g", "special"); 
	session.setAttribute("action", "gen_data_idtables_file.jsp?");
%>

<%	 
	String reader_no = request.getParameter("reader_no");
	String type_file = request.getParameter("type_file");
	String type_data = request.getParameter("type_data");
	String fileName = reader_no.substring(0, 4) + "." + type_file;
	String pathIDCardDAT = "";
	
	String sql = "";
	String update_mu = "1", update_cru1 = "1", update_cru2 = "1";
	String idcard = "", issue = "", pincode = "", st_date = "", ex_date = "", time_code_rd1 = "", time_code_rd2 = "", datetime_data = "";
	String quanlity1 = "", finger1 = "", template1 = "", quanlity2 = "", finger2 = "", template2 = "", datetime_finger = "";
	String use_finger = "", anti_pass = "", name = "", use_sn_card = "", sn_card = "", st_time = "", ex_time = "", blank = "", crc = "";
	String data = "", data1 = "", data2 = "";
	String fname = "", sname = "", time_code = "", emp_card = "";
	int num = 0;
	
	//	File IDS	========================================================
	FileInputStream fileinputstream = null;
	FileOutputStream fileoutputstream = new FileOutputStream(fileName);		//	use ids, csv
	
	//	File XML	========================================================
	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
	Document doc = dBuilder.newDocument();
	
	// root element
	Element rootElement = doc.createElement("data");
	doc.appendChild(rootElement);
	
	//	File CSV	========================================================
	PrintWriter pwriter = new PrintWriter(fileoutputstream);

	try{
		if(type_data.equals("employee")){
			sql = " select emp.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.emp_card, "
					+ " emp.issue, emp.pincode, emp.st_date, emp.st_time, emp.ex_date, emp.ex_time, emp.date_data, "
					+ " emp.use_finger, emp.use_map_card, emp.sn_card, emp.date_data, zone.time_code, zone.reader_no as z_reader_no "
					+ " from dbemployee emp, dbzone_group zone, dbreader rd, dbdoor door "
					+ " where ((emp.group_code = zone.group_code) and (zone.reader_no = rd.reader_no) "
					+ " and (rd.door_id = door.door_id) and (rd.reader_no = '"+reader_no+"')) "
					+ " order by emp.idcard, rd.reader_no asc ";
		}else if(type_data.equals("transaction")){
			sql = " select trans.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.emp_card, "
					+ " emp.issue, emp.pincode, emp.st_date, emp.st_time, emp.ex_date, emp.ex_time, emp.date_data, "
					+ " emp.use_finger, emp.use_map_card, emp.sn_card, emp.date_data, zone.time_code, zone.reader_no as z_reader_no "
					+ " from view_trans_last_idcard trans, dbemployee emp, dbsection sec, dbzone_group zone, dbreader rd, dbdoor door " 
					+ " where ( (trans.idcard = emp.idcard) and (emp.sec_code = sec.sec_code) "
					+ " and (emp.group_code = zone.group_code) and (zone.reader_no = rd.reader_no) "
					+ " and (rd.door_id = door.door_id) and (rd.reader_no = '"+reader_no+"') ) "
					+ " order by trans.idcard, rd.reader_no asc ";
		}
		
		ResultSet rs = stmtQry.executeQuery(sql);
		while (rs.next()) {
			
			if(type_file.equals("IDS")){
			
				idcard = setFormatString(rs.getString("idcard").trim(), " ", 16);
				issue = rs.getString("issue");
				pincode = setFormatString(rs.getString("pincode"), "*", 4);
				st_date = YMDToYYYYMMDD(rs.getString("st_date"));
				ex_date = YMDToYYYYMMDD(rs.getString("ex_date"));
				time_code_rd1 = "**";
				time_code_rd2 = "**";
				datetime_data = DateTimeToYYYYMMDDHHMMSS(rs.getString("date_data"));
				
				use_finger = rs.getString("use_finger");
				anti_pass = "*";
				name = rs.getString("th_fname")+" "+rs.getString("th_sname");
				use_sn_card = rs.getString("use_map_card");
				sn_card = rs.getString("sn_card");
				st_time = TimeToHHMM(rs.getString("st_time"));
				ex_time = TimeToHHMM(rs.getString("ex_time"));
				blank = "**";
				crc = "**";
				
				if(issue.length() == 1){
					issue = "0"+issue;
				}
				
				if(rs.getString("z_reader_no").substring(4, 5).equals("1")){
					time_code_rd1 = rs.getString("time_code");	
				}else if(rs.getString("z_reader_no").substring(4, 5).equals("2")){
					time_code_rd2 = rs.getString("time_code");	
				}
				
				if(name.length() > 32){
					name = name.substring(0, 32);
				}else{
					name = setFormatString(name, " ", 32);
				}
				
				if(!(sn_card.equals(""))){
					if(sn_card.length() == 14){
						anti_pass = convertHexToString(sn_card.substring(8, 10));
						blank = convertHexToString(sn_card.substring(10, 12))+convertHexToString(sn_card.substring(12, 14));
					}
					sn_card = convertHexToString(sn_card.substring(0, 2))+convertHexToString(sn_card.substring(2, 4))
						+convertHexToString(sn_card.substring(4, 6))+convertHexToString(sn_card.substring(6, 8));
				
				}else{
					sn_card = setFormatString(rs.getString("sn_card"), "*", 4);
				}
				
				data1 = "$" + update_mu + update_cru1 + update_cru2 
					+ idcard + issue + pincode + st_date + ex_date + time_code_rd1 + time_code_rd2 + datetime_data;
				
				data2 = quanlity1 + finger1 + template1 + quanlity2 + finger2 + template2 + datetime_finger
					+ use_finger + anti_pass + name + use_sn_card + sn_card + st_time + ex_time + blank;
				
				//	Write IDS	====================================================
				
				fileoutputstream.write(data1.getBytes());
				
				byte dataTemplate[] = {};
				pathIDCardDAT = rs.getString("idcard").trim()+".DAT";
				String file = path_tpl + pathIDCardDAT;
				File chkFile = new File(path_tpl + pathIDCardDAT);
				if(chkFile.exists() && !chkFile.isDirectory()) {
					
					//	Read TPL
					fileinputstream = new FileInputStream(file);
					int numberBytes = fileinputstream.available();
					byte dataTPL[] = new byte[numberBytes];
					fileinputstream.read(dataTPL);
					
					dataTemplate = Arrays.copyOfRange(dataTPL, 16, 1668);
					
					//	Write TPL
					for (int j = 0; j < dataTPL.length; j++) {
						if(j > 15){
							fileoutputstream.write(dataTPL[j]);
						}
					}
					
				}else{
					
					dataTemplate = setFormatString("", "*", 1652).getBytes();
					fileoutputstream.write(dataTemplate);
					
				}
				
				fileoutputstream.write(data2.getBytes());
				
				//	Check CRC	====================================================
				
				byte[] byte_detailID = data1.substring(1).getBytes();
				byte[] byte_template = dataTemplate;
				byte[] byte_detailCard = data2.getBytes();
				crc = getCrcASCII(byte_detailID, byte_template, byte_detailCard);

				byte[] b_eot = (crc + "#" + '\r' + '\n').getBytes();
				for (int j = 0; j < b_eot.length; j++) {
					try {
						fileoutputstream.write((byte) (b_eot[j] & 0xFF));
					} catch (IOException e) { }
				}
				
			}else if(type_file.equals("XML")){
				
				if(!(rs.getString("th_fname").equals(""))){
					fname = rs.getString("th_fname");
				}else{
					fname = " ";
				}
				if(!(rs.getString("th_sname").equals(""))){
					sname = rs.getString("th_sname");
				}else{
					sname = " ";
				}
				
				issue = rs.getString("issue");
				if(issue.length() == 1){
					issue = "0"+issue;
				}
				
				if(!(rs.getString("pincode").equals(""))){
					pincode = rs.getString("pincode");
				}else{
					pincode = " ";
				}
				
				st_date = YMDTodate(rs.getString("st_date"));
				ex_date = YMDTodate(rs.getString("ex_date"));
				datetime_data = YMDTodate(rs.getString("date_data").substring(0, 10))+" "+rs.getString("date_data").substring(11, 19);
				
				if(!(rs.getString("sn_card").equals(""))){
					sn_card = rs.getString("sn_card");
				}else{
					sn_card = " ";
				}
				
				if(!(rs.getString("emp_card").equals(""))){
					emp_card = rs.getString("emp_card");
				}else{
					emp_card = " ";
				}
				
				// employees element
				Element employee = doc.createElement("employee");
				rootElement.appendChild(employee);
				
				Element el_id = doc.createElement("id");
				el_id.appendChild(doc.createTextNode(rs.getString("idcard").trim()));
				employee.appendChild(el_id);
				
				Element el_fname = doc.createElement("fname");
				el_fname.appendChild(doc.createTextNode(fname));
				employee.appendChild(el_fname);
				
				Element el_sname = doc.createElement("sname");
				el_sname.appendChild(doc.createTextNode(sname));
				employee.appendChild(el_sname);
				
				Element el_issue = doc.createElement("issue");
				el_issue.appendChild(doc.createTextNode(issue));
				employee.appendChild(el_issue);
				
				Element el_pincode = doc.createElement("pincode");
				el_pincode.appendChild(doc.createTextNode(pincode));
				employee.appendChild(el_pincode);
				
				Element el_startdate = doc.createElement("startdate");
				el_startdate.appendChild(doc.createTextNode(st_date));
				employee.appendChild(el_startdate);
				
				Element el_expiredate = doc.createElement("expiredate");
				el_expiredate.appendChild(doc.createTextNode(ex_date));
				employee.appendChild(el_expiredate);
				
				Element el_dataupdate = doc.createElement("dataupdate");
				el_dataupdate.appendChild(doc.createTextNode(datetime_data));
				employee.appendChild(el_dataupdate);
				
				Element el_usefinger = doc.createElement("usefinger");
				el_usefinger.appendChild(doc.createTextNode(rs.getString("use_finger")));
				employee.appendChild(el_usefinger);
				
				Element el_emp_sTime = doc.createElement("emp_sTime");
				el_emp_sTime.appendChild(doc.createTextNode(rs.getString("st_time")));
				employee.appendChild(el_emp_sTime);
				
				Element el_emp_eTime = doc.createElement("emp_eTime");
				el_emp_eTime.appendChild(doc.createTextNode(rs.getString("ex_time")));
				employee.appendChild(el_emp_eTime);
				
				Element el_emp_mapCard = doc.createElement("emp_mapCard");
				el_emp_mapCard.appendChild(doc.createTextNode(sn_card));
				employee.appendChild(el_emp_mapCard);
				
				Element el_emp_useMapCard = doc.createElement("emp_useMapCard");
				el_emp_useMapCard.appendChild(doc.createTextNode(rs.getString("use_map_card")));
				employee.appendChild(el_emp_useMapCard);
				
				Element el_time_zone = doc.createElement("time_zone");
				el_time_zone.appendChild(doc.createTextNode(rs.getString("time_code")));
				employee.appendChild(el_time_zone);
				
				Element el_ref_id = doc.createElement("ref_id");
				el_ref_id.appendChild(doc.createTextNode(emp_card));
				employee.appendChild(el_ref_id);
			
			}else if(type_file.equals("CSV")){
				
				idcard = rs.getString("idcard").trim();
				fname = rs.getString("th_fname");
				sname = rs.getString("th_sname");
				issue = rs.getString("issue");
				pincode = rs.getString("pincode");
				st_date = YMDTodate(rs.getString("st_date"));
				ex_date = YMDTodate(rs.getString("ex_date"));
				datetime_data = YMDTodate(rs.getString("date_data").substring(0, 10))+" "+rs.getString("date_data").substring(11, 19);
				st_time = rs.getString("st_time");
				ex_time = rs.getString("ex_time");
				use_finger = rs.getString("use_finger");
				sn_card = rs.getString("sn_card");
				use_sn_card = rs.getString("use_map_card");
				time_code = rs.getString("time_code");
				if(!(rs.getString("emp_card").equals(""))){
					emp_card = rs.getString("emp_card");
				}else{
					emp_card = " ";
				}
				
				data = idcard +","+ fname +","+ sname +","+ issue +","+ pincode +","+ st_date +","+ ex_date +","+ datetime_data
					+","+ st_time +","+ ex_time +","+ use_finger +","+ sn_card +","+ use_sn_card +","+ time_code +","+ emp_card;
				
				pwriter.println(new String(data.getBytes("tis-620")));
				
			}
			
			num++;
			
		}	rs.close();
		
		if(type_file.equals("XML")){
			
			try{
				// write the content into xml file
				TransformerFactory transformerFactory = TransformerFactory.newInstance();
				Transformer transformer = transformerFactory.newTransformer();
				transformer.setOutputProperty(OutputKeys.INDENT, "yes");
				transformer.setOutputProperty(OutputKeys.METHOD, "xml");
				
				DOMSource source = new DOMSource(doc);
				StreamResult result = new StreamResult(new File(fileName));
				transformer.transform(source, result);
				
				// Output to console for testing
				StreamResult consoleResult = new StreamResult(System.out);
				transformer.transform(source, consoleResult);
		    }catch (Exception e){
		
			}
		}
		
    }catch (Exception e){
		
    }
	
	pwriter.close();
	
	// open file
	openFileExcel(fileName, response);
	
	fileinputstream.close();
	fileoutputstream.close();
	
%>
	
<%@ include file="../function/disconnect.jsp"%>