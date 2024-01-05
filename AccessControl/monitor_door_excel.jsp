<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.*"%>
<%@ page import="org.apache.poi.hssf.util.HSSFColor"%> 
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/displaydata.jsp"%>

<%
	Calendar cal = Calendar.getInstance(Locale.US);
	int day = cal.get(Calendar.DATE);
	int month = cal.get(Calendar.MONTH) + 1;
	int year = cal.get(Calendar.YEAR);
	String mm = "", dd = "";
	if (Integer.toString(month).length() < 2) {
		mm = "0" + Integer.toString(month);
	} else {
		mm = Integer.toString(month);
	}
	if (Integer.toString(day).length() < 2) {
		dd = "0" + Integer.toString(day);
	} else {
		dd = Integer.toString(day);
	}
	String filename = "trans_err_" + Integer.toString(year) + mm + dd + ".xls";// "trans_err_"+yyyymmdd+".xls"
	try{
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet(filename);

		HSSFCellStyle style = wb.createCellStyle();
		style.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
		// set font
		HSSFFont font = wb.createFont();
		font.setFontName(HSSFFont.FONT_ARIAL);
		font.setFontHeightInPoints((short) 14);

		HSSFCellStyle cs = wb.createCellStyle();
		HSSFCellStyle cs2 = wb.createCellStyle();
		HSSFCellStyle cs3 = wb.createCellStyle();

		HSSFFont f = wb.createFont();
		HSSFFont f2 = wb.createFont();
		HSSFFont f3 = wb.createFont();
		// Set font 1 to 18 point type, blue and bold
		f.setFontHeightInPoints((short) 12);
		f.setFontName("Tahoma");

		// Set font 2 to 16 point type, red and bold
		f2.setFontHeightInPoints((short) 11);
		f2.setFontName("Tahoma");

		// Set font 2 to 16 point type, red and bold
		f3.setFontHeightInPoints((short) 10);
		f3.setFontName("Tahoma");
		// Set cell style and formatting
		cs.setFont(f);

		// Set the other cell style and formatting
		// cs2.setBorderBottom(cs2.BORDER_THIN);
		cs2.setFont(f2);
		cs3.setFont(f3);
		// Sheet 1
		HSSFRow row1 = sheet.createRow((short) 0);
		HSSFCell cell = row1.createCell((short) 2);
		cell.setCellValue(lb_trans_err);
		cell.setCellStyle(cs);

		HSSFRow row_head = sheet.createRow((short) 1);

		// Header
		HSSFCell cell_c0 = row_head.createCell((short) 0);
		cell_c0.setCellValue(lb_eventdoor);
		cell_c0.setCellStyle(cs2);
		HSSFCell cell_c1 = row_head.createCell((short) 1);
		cell_c1.setCellValue(lb_date + " " + lb_time);
		cell_c1.setCellStyle(cs2);
		HSSFCell cell_c2 = row_head.createCell((short) 2);
		cell_c2.setCellValue(lb_event);
		cell_c2.setCellStyle(cs2);
		HSSFCell cell_c3 = row_head.createCell((short) 3);
		cell_c3.setCellValue(lb_door);
		cell_c3.setCellStyle(cs2);
		HSSFCell cell_c4 = row_head.createCell((short) 4);
		cell_c4.setCellValue(lb_empcode);
		cell_c4.setCellStyle(cs2);

		int count_row = 0;
		int num = 0;		
		String door_desc = "";
		String img = "";
		String event_desc = "";
		String idcard_desc = "";
		String old_code = "";
		String data_display = "";
		String sql = selectViewTransMonitorByHost();
		try{
			ResultSet rs = stmtQry.executeQuery(sql);
			while (rs.next()) {
				count_row++;
				String datetime_evt = YMDTodate(rs.getString("date_event")) + " " + rs.getString("time_event");
				String event_code = rs.getString("event_code");
				String groupimg = rs.getString("group_img");
				String textevent = displayText(Integer.parseInt(groupimg), lang);
				String idcard = rs.getString("idcard");

				if (lang.equals("th")) {
					if ((rs.getString("th_desc") != null) && (!rs.getString("th_desc").equals(""))) {
						door_desc = rs.getString("door_id") + " : " + rs.getString("th_desc");
					}
					if ((rs.getString("ev_th_desc") != null) && (!rs.getString("ev_th_desc").equals(""))) {
						event_desc = rs.getString("event_code") + " : " + rs.getString("ev_th_desc");
					}
					if ((rs.getString("th_fname") != null) && (!rs.getString("th_fname").equals(""))) {
						idcard_desc = rs.getString("idcard") + " : " + rs.getString("th_fname");
					}
					if ((rs.getString("th_sname") != null) && (!rs.getString("th_sname").equals(""))) {
						idcard_desc += "  " + rs.getString("th_sname");
					}
				} else {
					if ((rs.getString("en_desc") != null) && (!rs.getString("en_desc").equals(""))) {
						door_desc = rs.getString("door_id") + " : " + rs.getString("en_desc");
					}
					if ((rs.getString("ev_en_desc") != null) && (!rs.getString("ev_en_desc").equals(""))) {
						event_desc = rs.getString("event_code") + " : " + rs.getString("ev_en_desc");
					}
					if ((rs.getString("en_fname") != null) && (!rs.getString("en_fname").equals(""))) {
						idcard_desc = rs.getString("idcard") + " : " + rs.getString("en_fname");
					}
					if ((rs.getString("en_sname") != null) && (!rs.getString("en_sname").equals(""))) {
						idcard_desc += "  " + rs.getString("en_sname");
					}
				}				

				HSSFRow row_query_db = sheet.createRow((short) num + 2);
				num++;
				HSSFCell cell_data0 = row_query_db.createCell((short) 0);
				if (!(groupimg.equals(old_code))) {
					cell_data0.setCellValue(textevent);
				} else {
					cell_data0.setCellValue("");
				}
				cell_data0.setCellStyle(cs3);

				HSSFCell cell_data1 = row_query_db.createCell((short) 1);
				cell_data1.setCellValue(datetime_evt);
				cell_data1.setCellStyle(cs3);

				HSSFCell cell_data2 = row_query_db.createCell((short) 2);
				cell_data2.setCellValue(event_desc);
				cell_data2.setCellStyle(cs3);

				HSSFCell cell_data3 = row_query_db.createCell((short) 3);
				cell_data3.setCellValue(door_desc);
				cell_data3.setCellStyle(cs3);
				
				HSSFCell cell_data4 = row_query_db.createCell((short) 4);
				cell_data4.setCellValue(idcard_desc);
				cell_data4.setCellStyle(cs3);

				old_code = groupimg;
			}
		}catch(SQLException e){
			out.println("<span class='err_exp'> SQL Exception :" + e.getMessage() + "</span>");
		}

		FileOutputStream fileOut = new FileOutputStream(filename);
		wb.write(fileOut);
		fileOut.close();

	}catch (Exception ex){
		out.println("Error = " + ex.getMessage());
	}

	// open excel file
	openFileExcel(filename, response);
	
%>
<%@ include file="../function/disconnect.jsp"%>