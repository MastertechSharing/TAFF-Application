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
		for(int i = 0; i < 5; i++){
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
			
		String reader_no = request.getParameter("reader_no");
		String type_data = request.getParameter("type_data");
		
		String[] cols = null;
		if(type_data.equals("employee")){
			cols = new String[]{ "emp.idcard", "th_fname, th_sname", "en_fname, en_sname", "emp.sec_code", "emp.date_data" };
		}else if(type_data.equals("transaction")){
			cols = new String[]{ "trans.idcard", "th_fname, th_sname", "en_fname, en_sname", "emp.sec_code", "emp.date_data" };
		}
		
		int amount = 12;
		int row_start = 0;
		int echo = 0;
		int col = 0;
		
		String dir = "asc";
		String sStart = request.getParameter("iDisplayStart");
		String sAmount = request.getParameter("iDisplayLength");
		String sEcho = request.getParameter("sEcho");
		String sCol = request.getParameter("iSortCol_0");
		String sdir = request.getParameter("sSortDir_0");
		
		if (sStart != null) {
			row_start = Integer.parseInt(sStart);
			if (row_start < 0){
				row_start = 0;
			}
		}
		if (sAmount != null) {
			amount = Integer.parseInt(sAmount);
			if (amount < 12 || amount > 1000){
				amount = 12;
			}
		}
		if (sEcho != null) {
			echo = Integer.parseInt(sEcho);
		}
		if (sCol != null) {
			col = Integer.parseInt(sCol);
			if (col < 0 || col > 4){
				col = 0;
			}
		}
	   if (sdir != null) {
			if (!sdir.equals("asc")){
				dir = "desc";
			}
		}
		String colName = cols[col];
		int total = 0;
		String sqlcount = "";
		if(type_data.equals("employee")){
			sqlcount = " SELECT count(emp.idcard) AS count_row "
					+ " FROM dbemployee emp, dbsection sec, dbzone_group zone, dbreader rd, dbdoor door "
					+ " WHERE ((emp.group_code = zone.group_code) AND (emp.sec_code = sec.sec_code) "
					+ " AND (zone.reader_no = rd.reader_no) AND (rd.door_id = door.door_id) AND (rd.reader_no = '"+reader_no+"')) " ;
		}else if(type_data.equals("transaction")){
			sqlcount = " SELECT count(trans.idcard) AS count_row "
					+ " FROM view_trans_last_idcard trans, dbemployee emp, dbsection sec, dbzone_group zone, dbreader rd, dbdoor door " 
					+ " WHERE ( (trans.idcard = emp.idcard) AND (emp.sec_code = sec.sec_code) "
					+ " AND (emp.group_code = zone.group_code) AND (zone.reader_no = rd.reader_no) "
					+ " AND (rd.door_id = door.door_id) AND (rd.reader_no = '"+reader_no+"') ) " ;
		}
		
		ResultSet rs1 = stmtQry.executeQuery(sqlcount);
		if(rs1.next()){
			total = rs1.getInt("count_row");
		}	rs1.close();
		int totalAfterFilter = total;
		
		try{
			String sql = "", fromWhere = "", select_idcard = "", searchTerm = "", searchSQL = "";	
			
			if(request.getParameter("sSearch") != null){
				searchTerm = request.getParameter("sSearch");	//	new String(request.getParameter("sSearch").getBytes("ISO8859_1"), "utf-8");
				if(type_data.equals("employee")){
					searchSQL = " AND ( (emp.idcard like '%"+searchTerm+"%') " ;
				}else if(type_data.equals("transaction")){
					searchSQL = " AND ( (trans.idcard like '%"+searchTerm+"%') " ;
				}
				searchSQL += " OR (emp.th_fname like '%"+searchTerm+"%') OR (emp.th_sname like '%"+searchTerm+"%') "
							+ " OR (emp.en_fname like '%"+searchTerm+"%') OR (emp.en_sname like '%"+searchTerm+"%') "
							+ " OR (emp.sec_code like '%"+searchTerm+"%') OR (emp.date_data like '%"+searchTerm+"%') ";
				if(lang.equals("th")){
					searchSQL += " OR (sec.th_desc LIKE '%"+searchTerm+"%') ) ";
				}else{
					searchSQL += " OR (sec.en_desc LIKE '%"+searchTerm+"%') ) ";
				}
			}
			
			if(type_data.equals("employee")){
				select_idcard = " emp.idcard ";
				fromWhere = " FROM dbemployee emp, dbsection sec, dbzone_group zone, dbreader rd, dbdoor door " 
						+ " WHERE ( (emp.sec_code = sec.sec_code) AND (emp.group_code = zone.group_code) "
						+ " AND (zone.reader_no = rd.reader_no) AND (rd.door_id = door.door_id) AND (rd.reader_no = '"+reader_no+"') ) " ;
			}else if(type_data.equals("transaction")){
				select_idcard = " trans.idcard ";
				fromWhere = " FROM view_trans_last_idcard trans, dbemployee emp, dbsection sec, dbzone_group zone, dbreader rd, dbdoor door " 
						+ " WHERE ( (trans.idcard = emp.idcard) AND (emp.sec_code = sec.sec_code) "
						+ " AND (emp.group_code = zone.group_code) AND (zone.reader_no = rd.reader_no) "
						+ " AND (rd.door_id = door.door_id) AND (rd.reader_no = '"+reader_no+"') ) " ;
			}
			
			if(mode == 0){
				sql = " SELECT "+select_idcard+", emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.date_data, "
						+ " emp.sec_code, sec.th_desc AS sec_th_desc, sec.en_desc AS sec_en_desc " ;
				sql	+= fromWhere;
				sql += searchSQL;
				sql += " ORDER BY " + colName + " " + dir + " LIMIT " + row_start + ", " + amount;
			}else if(mode == 1){
				int sEnd = Integer.parseInt(sStart) + Integer.parseInt(sAmount);
				
				sql = " SELECT * FROM ( SELECT ROW_NUMBER() OVER ( ORDER BY " + colName + " " + dir + " ) AS 'NumRow', ";	
				sql += select_idcard+", emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.date_data, "
						+ " emp.sec_code, sec.th_desc AS sec_th_desc, sec.en_desc AS sec_en_desc " ;
				sql	+= fromWhere;
				sql += searchSQL;
				sql += " ) AS employee ";
				sql += " WHERE NumRow BETWEEN " + (row_start +1) + " AND " + sEnd;			
			}
			
			ResultSet rs = stmtQry.executeQuery(sql);
			while (rs.next()) {			
				String idcard = rs.getString("idcard");
				String th_name = rs.getString("th_fname")+" "+rs.getString("th_sname");
				String en_name = rs.getString("en_fname")+" "+rs.getString("en_sname");
				String date_data = "";//YMDTodate(rs.getString("date_data"))+" "+rs.getString("date_data").substring(11, 19);
				
				String sec_code = rs.getString("sec_code");
				if(sec_code != null){
					if(lang.equals("th")){
						if(rs.getString("sec_th_desc") != null){
							sec_code += " - " + rs.getString("sec_th_desc");
						}
					}else{
						if(rs.getString("sec_en_desc") != null){
							sec_code += " - " + rs.getString("sec_en_desc");
						}
					}
				}
				
				JSONArray ja = new JSONArray();
				ja.put("<span class='pad-left-10'> "+idcard+" </span>");
				ja.put("<div class='ellipsis_string' style='max-width: 250px;'> <span class='pad-left-10'> "+ th_name +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 250px;'> <span class='pad-left-10'> "+ en_name +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 250px;'> <span class='pad-left-10'> "+ sec_code +" </span> </div>");
				ja.put("<center> <span value='"+rs.getString("date_data")+"'> "+ date_data +" </span> </center>");
				array.put(ja);
		
			}
			rs.close();
			
			if (searchTerm != "") {
				ResultSet rs2 = stmtQry.executeQuery(sqlcount + searchSQL);
				if(rs2.next()){
					totalAfterFilter = rs2.getInt("count_row");
				}	rs2.close();
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