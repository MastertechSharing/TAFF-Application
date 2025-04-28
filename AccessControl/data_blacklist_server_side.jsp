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
		for(int i = 0; i < 9; i++){
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
		if(checkPermission(ses_per, "03")){
			cols = new String[]{ "", "", "idcard", "fullname", "sec_code", "record_detail", "record_date", "record_by", "cancel_status" };
		}else{
			cols = new String[]{ "idcard", "fullname", "sec_code", "record_detail", "record_date", "record_by", "cancel_status", "", "" };
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
		String view_data = request.getParameter("view_data");
		
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
			if(checkPermission(ses_per, "03")){
				if (col < 2 || col > 8){
					col = 6;
				}
			}else{
				if (col < 0 || col > 4){
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
		String setWhere = "", setAnd = "";
		if(view_data.equals("1")){
			setWhere = " WHERE ( bl.cancel_status = '0' ) ";
			setAnd = " AND ( bl.cancel_status = '0' ) ";
		}else if(view_data.equals("2")){
			setWhere = " WHERE ( bl.cancel_status = '1' ) ";
			setAnd = " AND ( bl.cancel_status = '1' ) ";
		}
		
		int total = 0;
		String sqlcount = " SELECT COUNT(*) AS count_row FROM dbblacklist bl "
					+ " LEFT JOIN dbemployee emp ON (emp.idcard = bl.idcard) "	
					+ " LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) ";	 		
		if(checkPermission(ses_per, "1256")){
			sqlcount += " LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
				+ " LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) "
				+ " WHERE (users.user_name = '"+ses_user+"') " + setAnd;
			if(checkPermission(ses_per, "56")){
				sqlcount += " AND (sec.sec_code = users.sec_code) ";
			}
		}
		ResultSet rs1 = stmtQry.executeQuery(sqlcount);
		if(rs1.next()){
			total = rs1.getInt("count_row");
		}	rs1.close();
		int totalAfterFilter = total;
		
		try{
			String sql = "", searchTerm = "", searchSQL = "";		
			if(request.getParameter("sSearch") != null){
				searchTerm = request.getParameter("sSearch");	//	new String(request.getParameter("sSearch").getBytes("ISO8859_1"), "utf-8");
				searchSQL = " WHERE ((bl.idcard LIKE '%"+searchTerm+"%') OR (emp.sec_code LIKE '%"+searchTerm+"%') "
						+ " OR (bl.record_detail LIKE '%"+searchTerm+"%') OR (bl.record_by LIKE '%"+searchTerm+"%') ";
				if(lang.equals("th")){
					searchSQL += " OR (emp.th_fname LIKE '%"+searchTerm+"%') OR (emp.th_sname LIKE '%"+searchTerm+"%')) ";
				}else{
					searchSQL += " OR (emp.en_fname LIKE '%"+searchTerm+"%') OR (emp.en_sname LIKE '%"+searchTerm+"%')) ";
				}
				searchSQL += setAnd;
				
				if(checkPermission(ses_per, "1256")){
					searchSQL += " AND (users.user_name = '"+ses_user+"') ";
					if(checkPermission(ses_per, "56")){
						searchSQL += " AND (sec.sec_code = users.sec_code) ";
					}
				}
			}else{
				searchSQL += setWhere;
				
				if(checkPermission(ses_per, "1256")){
					searchSQL += " AND (users.user_name = '"+ses_user+"') ";
					if(checkPermission(ses_per, "56")){
						searchSQL += " AND (sec.sec_code = users.sec_code) ";
					}
				}
			}
			
			if(mode == 0){
				
				sql = " SELECT bl.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, "
					+ " emp.sec_code, bl.record_detail, bl.record_date, bl.record_by, bl.cancel_status, bl.fullname ";
				if(lang.equals("th")){
					sql += " , CONCAT(emp.th_fname, ' ', emp.th_sname) AS emp_name, sec.th_desc AS sec_desc ";
				}else{
					sql += " , CONCAT(emp.en_fname, ' ', emp.en_sname) AS emp_name, sec.en_desc AS sec_desc ";
				}
				sql += " FROM dbblacklist bl "
					+  " LEFT JOIN dbemployee emp ON (emp.idcard = bl.idcard) "
					+  " LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) ";
				if(checkPermission(ses_per, "1256")){
					sql += "LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
						+ "LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
				}
				sql += searchSQL;
				sql += " ORDER BY " + colName + " " + dir ;
				sql += " LIMIT " + row_start + ", " + amount;
				
			}else if(mode == 1){		
				int sEnd = Integer.parseInt(sStart) + Integer.parseInt(sAmount);
				
				sql = " SELECT * FROM ( SELECT ROW_NUMBER() OVER ( ORDER BY " + colName + " " + dir + " ) AS 'NumRow', "
					+ " bl.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, "
					+ " emp.sec_code, bl.record_detail, FORMAT(record_date, 'yyyy-MM-dd') as record_date, bl.record_by, bl.cancel_status, bl.fullname ";
				if(lang.equals("th")){
					sql += " , emp.th_fname+' '+emp.th_sname AS emp_name, sec.th_desc AS sec_desc ";
				}else{
					sql += " , emp.en_fname+' '+emp.en_sname AS emp_name, sec.en_desc AS sec_desc ";
				}
				sql += " FROM dbblacklist bl "
					+  " LEFT JOIN dbemployee emp ON (emp.idcard = bl.idcard) "
					+  " LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) ";
				if(checkPermission(ses_per, "1256")){
					sql += " LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
						+ " LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
				}
				sql += searchSQL;
				sql += " ) AS blacklist_emp ";
				sql += " WHERE NumRow BETWEEN " + (row_start +1) + " AND " + sEnd;			
				
			}
			
			ResultSet rs = stmtQry.executeQuery(sql);
			while (rs.next()) {		
			 	String idcard = rs.getString("idcard");
				String emp_id_link = "<b> <a href='#' onClick='show_detail2(\""+idcard+"\");' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + idcard + "</a> </b>";
				String fullname = rs.getString("emp_name");
				if(fullname == null){
					fullname = rs.getString("fullname");
				}
				String sec_code = rs.getString("sec_code");
				String sec_link = "";
				if(sec_code != null){
					sec_link = "<b> <a href='#' onClick='show_detail3(\""+sec_code+"\");' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + sec_code + "</a> </b> ";
					if(rs.getString("sec_desc") != null && rs.getString("sec_desc") != ""){
						sec_link += " - " + rs.getString("sec_desc");
					}
				}else{
					sec_link = "<i>"+lb_nodata+"</i>";
				}
				
				String record_detail = rs.getString("record_detail");
				String record_date = rs.getString("record_date");
				String record_by = rs.getString("record_by");
				String record_by_link = "<b> <a href='#' onClick='show_detail4(\""+record_by+"\");' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + record_by + "</a> </b>";
				String cancel_status = rs.getString("cancel_status");
				if(cancel_status.equals("0")){
					cancel_status = "<font color='red'> <strong> "+lb_blacklist2+" <strong> </font>";
				}else if(cancel_status.equals("1")){
					cancel_status = "<font color='black'> "+btn_cancel+" </font>";
				}
				
				JSONArray ja = new JSONArray();
				ja.put("<center> <img src='images/view.png' width='20' height='20' border='0' align='absmiddle' onClick='show_detail(\""+idcard+"\", \""+record_date+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'> </center>");
				if(checkPermission(ses_per, "03")){
					ja.put("<center> <a href='edit_blacklist.jsp?action=edit&idcard="+idcard+"&record_date="+record_date+"'> <img src='images/edit.png' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_editblacklist+"'> </a> </center>");
				}
				ja.put("<center> "+ emp_id_link +" </center>");
				ja.put("<div class='ellipsis_string' style='max-width: 150px;'> <span class='pad-left-10'> "+ fullname +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 200px;'> <span class='pad-left-10'> "+ sec_link +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 280px;'> <span class='pad-left-10'> "+ record_detail +" </span> </div>");
				ja.put("<center> "+ record_date +" </center>");
				ja.put("<div class='ellipsis_string' style='max-width: 100px;'> <span class='pad-left-10'> "+ record_by_link +" </span> </div>");
				ja.put("<center> "+ cancel_status +" </center>");
				array.put(ja);
			}
			rs.close();
			
			sqlcount = "SELECT COUNT(*) AS count_row "
				+ "FROM dbblacklist bl "
				+ "LEFT JOIN dbemployee emp ON (emp.idcard = bl.idcard) "
				+ "LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) ";			
			if(checkPermission(ses_per, "1256")){
				sqlcount += "LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
					+ "LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
			}
			
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