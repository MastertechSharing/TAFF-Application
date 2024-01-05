<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.*"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session_server_side.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>

<%	
	JSONObject result = new JSONObject();
	JSONArray array = new JSONArray();
	
	if (session.getAttribute("ses_permission") == null) {
		
		JSONArray ja = new JSONArray();
		for(int i = 0; i < 6; i++){
			ja.put(" ");
		}
		array.put(ja);
		result.put("iTotalRecords", 0);
		result.put("iTotalDisplayRecords", 0);
		result.put("aaData", array);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-store");
		out.print(result);
		
	} else {
			
		String[] cols = null;
		if(checkPermission(ses_per, "0")){
			cols = new String[]{ "", "", "reader_no", "rd.th_desc", "rd.en_desc", "rd.door_id" };
		}else{
			cols = new String[]{ "reader_no", "rd.th_desc", "rd.en_desc", "rd.door_id", "", "" };
		}
		
		int amount = 15;
		int row_start = 0;
		int echo = 0;
		int col = 0;
		
		String dir = "asc";
		String sStart = request.getParameter("iDisplayStart");
		String sAmount = request.getParameter("iDisplayLength");
		String sEcho = request.getParameter("sEcho");
		String sCol = request.getParameter("iSortCol_0");
		String sdir = request.getParameter("sSortDir_0");
		
		//	Use in SQL Server
		int sEnd = Integer.parseInt(sStart) + Integer.parseInt(sAmount);

		if (sStart != null) {
			row_start = Integer.parseInt(sStart);
			if (row_start < 0){
				row_start = 0;
			}
		}
		if (sAmount != null) {
			amount = Integer.parseInt(sAmount);
			if (amount < 15 || amount > 1000){
				amount = 15;
			}
		}
		if (sEcho != null) {
			echo = Integer.parseInt(sEcho);
		}
		if (sCol != null) {
			col = Integer.parseInt(sCol);
			if(checkPermission(ses_per, "0")){
				if (col < 2 || col > 5){
					col = 2;
				}
			}else{
				if (col < 0 || col > 3){
					col = 0;
				}
			}
		}
		if (sdir != null) {
			if (!sdir.equals("asc")){
				dir = "desc";
			}
		}
		String colName = cols[col];
		int total = getCountRecord("dbreader",stmtQry);
		int totalAfterFilter = total;
		
		//	check show all record
		if (sAmount != null) {
			if (Integer.parseInt(sAmount) < 0){
				if(mode == 0){
					amount = total;
				}else if(mode == 1){
					sEnd = total;
				}
			}
		}
		
		try{
			String sql = "", sqlcount = "", searchTerm = "", searchSQL = "";		
			if(request.getParameter("sSearch") != null){
				searchTerm = request.getParameter("sSearch");	//	new String(request.getParameter("sSearch").getBytes("ISO8859_1"), "utf-8");
				searchSQL = "WHERE ((rd.reader_no LIKE '%"+searchTerm+"%') OR (rd.door_id LIKE '%"+searchTerm+"%') "
						+ "OR (rd.th_desc LIKE '%"+searchTerm+"%') OR (rd.en_desc LIKE '%"+searchTerm+"%') ";
				if(lang.equals("th")){
					searchSQL += "OR (door.th_desc LIKE '%"+searchTerm+"%') ";
				}else{
					searchSQL += "OR (door.en_desc LIKE '%"+searchTerm+"%') ";
				}
				searchSQL += ") ";
			}
			
			if(mode == 0){		
				sql = "SELECT rd.reader_no, rd.th_desc AS rd_th_desc, rd.en_desc AS rd_en_desc, "
					+ "rd.door_id, door.th_desc AS d_th_desc, door.en_desc AS d_en_desc "
					+ "FROM dbreader rd "
					+ "LEFT JOIN dbdoor door ON (door.door_id = rd.door_id) ";
				sql += searchSQL;
				sql += "ORDER BY " + colName + " " + dir + " LIMIT " + row_start + ", " + amount;			
			}else if(mode == 1){			
				sql = "SELECT * FROM ( SELECT ROW_NUMBER() OVER ( ORDER BY " + colName + " " + dir + " ) AS 'NumRow', ";	
				sql += "rd.reader_no, rd.th_desc AS rd_th_desc, rd.en_desc AS rd_en_desc, "
						+ "rd.door_id, door.th_desc AS d_th_desc, door.en_desc AS d_en_desc "
						+ "FROM dbreader rd "
						+ "LEFT JOIN dbdoor door ON (door.door_id = rd.door_id) ";  
				sql += searchSQL;
				sql += " ) AS reader ";
				sql += "WHERE NumRow BETWEEN " + (row_start +1) + " AND " + sEnd;			
			}
			
			ResultSet rs = stmtQry.executeQuery(sql);
			while (rs.next()) {			
				String reader_no = rs.getString("reader_no");
				String reader_no_link = "<b> <a href='#' onClick='show_detail(\""+reader_no+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'>" + reader_no + "</a> </b>";
				String th_name = rs.getString("rd_th_desc");
				String en_name = rs.getString("rd_en_desc");
				String door_id = rs.getString("door_id");	
				
				String door_id_link = "", door_desc_alert = "";
				door_id_link = "<b> <a href='#' onClick='show_detail2(\""+door_id+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'>" + door_id + "</a> </b>";
				door_desc_alert = door_id;
				if(door_id != null){
					if(lang.equals("th")){
						if(rs.getString("d_th_desc") != null){
							door_id_link += " - " + rs.getString("d_th_desc");	
							door_desc_alert += " - " + rs.getString("d_th_desc");
						}
					}else{
						if(rs.getString("d_en_desc") != null){
							door_id_link += " - " + rs.getString("d_en_desc");	
							door_desc_alert += " - " + rs.getString("d_en_desc");
						}
					}
				}	
				
				JSONArray ja = new JSONArray();
				if(checkPermission(ses_per, "0")){
					ja.put("<center> <a href='edit_reader.jsp?action=edit&reader_no="+reader_no+"'> <img src='images/edit.png' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_editdata+"'> </a> </center>");
					ja.put("<center> <img src='images/delete.png' width='20' height='20' border='0' align='absmiddle' onClick='ModalConfirm(\""+reader_no+"\", \""+msg_confirmdel+"\", \""+th_name+"\", \""+en_name+"\", \""+door_desc_alert+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_deletedata+"'> </center>");
				}
				ja.put("<center> "+ reader_no_link +" </center>");
				ja.put("<div class='ellipsis_string' style='max-width: 270px;'> <span class='pad-left-10'> "+ th_name +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 270px;'> <span class='pad-left-10'> "+ en_name +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 290px;'> <span class='pad-left-10'> "+ door_id_link +" </span> </div>");
				array.put(ja);			
			}
			rs.close();
			
			sqlcount = "SELECT COUNT(*) AS count_row FROM dbreader rd "
					+ "LEFT JOIN dbdoor door ON (door.door_id = rd.door_id) ";  
			if (searchTerm != "") {
				ResultSet rs2 = stmtQry.executeQuery(sqlcount + searchSQL);
				if(rs2.next()){
					totalAfterFilter = rs2.getInt("count_row");
				}
				rs2.close();
			}
			
			result.put("iTotalRecords", total);
			result.put("iTotalDisplayRecords", totalAfterFilter);
			result.put("aaData", array);
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-store");
			out.print(result);
		
		}catch (Exception e){
	 
		}
		
	}
%>

<%@ include file="../function/disconnect.jsp"%>