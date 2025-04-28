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
		for(int i = 0; i < 7; i++){
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
		if(checkPermission(ses_per, "0135")){
			cols = new String[]{ "", "", "idcard", "fullname", "sec_code", "message", "message_date" };
		}else{
			cols = new String[]{ "idcard", "fullname", "sec_code", "message", "message_date", "", "" };
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
			if(checkPermission(ses_per, "0135")){
				if (col < 2 || col > 6){
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
		try{
			String colName = cols[col];
			int total = 0;
			String sqlcount = " SELECT COUNT(*) AS count_row ";
			String sqlFromWhere = "FROM dbemployee emp "	
						+ " LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) ";	 		
			if(checkPermission(ses_per, "1256")){
				sqlFromWhere += " LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
					+ " LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) "
					+ " WHERE (users.user_name = '"+ses_user+"') AND message_date IS NOT NULL ";
				if(checkPermission(ses_per, "56")){
					sqlFromWhere += " AND (sec.sec_code = users.sec_code) ";
				}
			}else{
				sqlFromWhere += " WHERE message_date IS NOT NULL ";
			}
			
			ResultSet rs1 = stmtQry.executeQuery(sqlcount+sqlFromWhere);
			if(rs1.next()){
				total = rs1.getInt("count_row");
			}	rs1.close();
			int totalAfterFilter = total;
				
			String sql = "", searchTerm = "", searchSQL = "";		
			if(request.getParameter("sSearch") != null){
				searchTerm = request.getParameter("sSearch");	//	new String(request.getParameter("sSearch").getBytes("ISO8859_1"), "UTF-8");								
				searchSQL = sqlFromWhere + " AND ((emp.idcard LIKE '%"+searchTerm+"%') OR (emp.sec_code LIKE '%"+searchTerm+"%') "
							+ " OR (emp.message LIKE '%"+searchTerm+"%') ";
				if(lang.equals("th")){
					searchSQL += " OR (emp.th_fname LIKE '%"+searchTerm+"%') OR (emp.th_sname LIKE '%"+searchTerm+"%')) ";
				}else{
					searchSQL += " OR (emp.en_fname LIKE '%"+searchTerm+"%') OR (emp.en_sname LIKE '%"+searchTerm+"%')) ";
				}							
			}			
			
			if(mode == 0){				
				sql = " SELECT emp.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, "
					+ " emp.sec_code, emp.message, emp.message_date ";
				if(lang.equals("th")){
					sql += " , CONCAT(emp.th_fname, ' ', emp.th_sname) AS fullname, sec.th_desc AS sec_desc ";
				}else{
					sql += " , CONCAT(emp.en_fname, ' ', emp.en_sname) AS fullname, sec.en_desc AS sec_desc ";
				}				
				sql += searchSQL;
				sql += " ORDER BY " + colName + " " + dir ;
				sql += " LIMIT " + row_start + ", " + amount;				
			}else if(mode == 1){		
				int sEnd = Integer.parseInt(sStart) + Integer.parseInt(sAmount);				
				sql = " SELECT * FROM ( SELECT ROW_NUMBER() OVER ( ORDER BY " + colName + " " + dir + " ) AS 'NumRow', "
					+ " emp.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, "
					+ " emp.sec_code, emp.message, FORMAT(message_date, 'yyyy-MM-dd') as message_date ";
				if(lang.equals("th")){
					sql += " , emp.th_fname+' '+emp.th_sname AS fullname, sec.th_desc AS sec_desc ";
				}else{
					sql += " , emp.en_fname+' '+emp.en_sname AS fullname, sec.en_desc AS sec_desc ";
				}
				sql += searchSQL;
				sql += " ) AS message_emp ";
				sql += " WHERE NumRow BETWEEN " + (row_start +1) + " AND " + sEnd;							
			}
			
			ResultSet rs = stmtQry.executeQuery(sql);
			while (rs.next()) {		
			 	String idcard = rs.getString("idcard");
				String emp_id_link = "<b> <a href='#' onClick='show_detail(\""+idcard+"\");' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + idcard + "</a> </b>";
				String fullname = rs.getString("fullname");
				String sec_code = rs.getString("sec_code");
				String sec_link = "<b> <a href='#' onClick='show_detail2(\""+sec_code+"\");' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + sec_code + "</a> </b> ";
				if(rs.getString("sec_desc") != null && rs.getString("sec_desc") != ""){
					sec_link += " - " + rs.getString("sec_desc");
				}
				String message = rs.getString("message");
				String message_date = "";
				if(rs.getString("message_date") != null){
					message_date = rs.getString("message_date");
				}
				
				JSONArray ja = new JSONArray();
				if(checkPermission(ses_per, "0135")){
					ja.put("<center> <a href='edit_message.jsp?action=edit&idcard="+idcard+"'> <img src='images/edit.png' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_editdata+"'> </a> </center>");
					ja.put("<center> <img src='images/delete.png' width='20' height='20' border='0' align='absmiddle' onClick='ModalConfirm(\""+idcard+"\", \""+fullname+"\", \""+message+"\", \""+YMDTodate(message_date)+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_deletedata+"'> </center>");
				}
				ja.put("<center> "+ emp_id_link +" </center>");
				ja.put("<div class='ellipsis_string' style='max-width: 200px;'> <span class='pad-left-10'> "+ fullname +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 200px;'> <span class='pad-left-10'> "+ sec_link +" </span> </div>");
				ja.put("<div> <span class='pad-left-10'> "+ message +" </span> </div>");
				ja.put("<center> "+ message_date +" </center>");
				array.put(ja);
			}
			rs.close();
						
			if (searchTerm != "") {
				ResultSet rs2 = stmtQry.executeQuery(sqlcount+searchSQL);
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