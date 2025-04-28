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
		if(checkPermission(ses_per, "0135")){
			cols = new String[]{ "", "reader_no", "th_desc", "en_desc", "", "" };
		}else{
			cols = new String[]{ "reader_no", "th_desc", "en_desc", "", "", "" };
		}
		
		int amount = 15;
		int row_start = 0;
		int echo = 0;
		int col = 0;
	/*	
		String dir = "asc";
		String sStart = "0";		//request.getParameter("iDisplayStart");
		String sAmount = "15";		//request.getParameter("iDisplayLength");
		String sEcho = "0";			//request.getParameter("sEcho");
		String sCol = "1";			//request.getParameter("iSortCol_0");
		String sdir = "asc";		//request.getParameter("sSortDir_0");
	*/
		String dir = "";
		String sStart = request.getParameter("iDisplayStart");
		String sAmount = request.getParameter("iDisplayLength");
		String sEcho = request.getParameter("sEcho");
		String sCol = request.getParameter("iSortCol_0");
		String sdir = request.getParameter("sSortDir_0");
		
		String view_data = request.getParameter("view_data");
		String group_code = request.getParameter("group_code");
		String time_code_index = request.getParameter("time_code");
		
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
			if(checkPermission(ses_per, "0135")){
				if (col < 1 || col > 3){
					col = 1;
				}
			}else{
				if (col < 0 || col > 2){
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
		
		//	Condition show data
		String where_exists = "";
		if(!view_data.equals("all")){
			where_exists = " AND ( ";
			if(view_data.equals("0")){
				where_exists += " NOT EXISTS ";
			}else if(view_data.equals("1")){
				where_exists += " EXISTS ";
			}
			where_exists += " ( SELECT * FROM dbzone_group WHERE reader_no = rd.reader_no AND group_code = '"+group_code+"' ) ) ";
		}
		
		//	Check grant group user
		String ses_username = (String)session.getAttribute("ses_username");
		String where_is_not_null = " WHERE (rd.reader_no IS NOT NULL) ";
		String where_reader_list = "";
		if(ses_per == 1 || ses_per == 5){
			String[] control_reader = new String[0];
			try{
				ResultSet rs_user = stmtTmp.executeQuery(" SELECT control_reader FROM dbusers WHERE (user_name = '"+ses_username+"') ");
				if(rs_user.next()){
					if(!rs_user.getString("control_reader").equals("")){
						control_reader = rs_user.getString("control_reader").split(",");
					}
				}	rs_user.close();
			}catch(SQLException e){ } 
			
			for(int i = 0; i < control_reader.length; i++){
				where_reader_list += " rd.reader_no = '" + control_reader[i] +"' " ;
				if(i < (control_reader.length -1)){
					where_reader_list += " OR ";
				}
			}
			
			if(!where_reader_list.equals("")){
				where_reader_list = " AND ( " + where_reader_list + " ) ";
			}
		}
		
		int total = 0;
	 	String sqlcount = " SELECT COUNT(*) AS count_row FROM dbreader rd ";  
		ResultSet rs_count = stmtQry.executeQuery(sqlcount + where_is_not_null + where_reader_list + where_exists);
		if(rs_count.next()){
			total = rs_count.getInt("count_row");
		}	rs_count.close();
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
			String sql = "", searchTerm = "", searchSQL = "";		
			if(request.getParameter("sSearch") != null){
				searchTerm = request.getParameter("sSearch");	//	new String(request.getParameter("sSearch").getBytes("ISO8859_1"), "utf-8");
				searchSQL = " AND ((rd.reader_no LIKE '%"+searchTerm+"%') OR (rd.th_desc LIKE '%"+searchTerm+"%') OR (rd.en_desc LIKE '%"+searchTerm+"%')) ";
			}
			
			if(mode == 0){
				sql = " SELECT rd.reader_no, rd.th_desc AS rd_th_desc, rd.en_desc AS rd_en_desc "
					+ " FROM dbreader rd "
					+	where_is_not_null
					+	where_reader_list
					+	where_exists
					+	searchSQL
					+ " ORDER BY " + colName + " " + dir + " LIMIT " + row_start + ", " + amount;
			}else if(mode == 1){
				sql = " SELECT * FROM ( SELECT ROW_NUMBER() OVER ( ORDER BY " + colName + " " + dir + " ) AS 'NumRow', "
					+ " rd.reader_no, rd.th_desc AS rd_th_desc, rd.en_desc AS rd_en_desc "
					+ " FROM dbreader rd "
					+	where_is_not_null
					+	where_reader_list
					+	where_exists
					+	searchSQL
					+ " ) AS reader "
					+ " WHERE NumRow BETWEEN " + (row_start +1) + " AND " + sEnd;
			}
		/*	out.println(sql);
			out.println("<br/>");
			out.println(" SELECT zg.reader_no, zg.time_code, td."+lang+"_desc AS time_desc "
						+ " FROM dbzone_group zg "
						+ " LEFT OUTER JOIN dbtimezone tz ON zg.time_code = tz.time_code "
						+ " LEFT OUTER JOIN dbtimedesc td ON tz.time_id = td.time_id "
						+ " WHERE zg.group_code = '"+group_code+"' "
						+ " GROUP BY zg.time_code, zg.reader_no ");
		*/
			ResultSet rs = stmtQry.executeQuery(sql);
			while (rs.next()) {
				
				String reader_no = rs.getString("reader_no");
				String reader_no_link = "<b> <a href='#' onClick='show_detail(\""+reader_no+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'>" + reader_no + "</a> </b>";
				String th_name = rs.getString("rd_th_desc");
				String en_name = rs.getString("rd_en_desc");
				
				boolean chk_open = false, view_status = false;
				String time_code = "", time_code_link = "", time_desc = "";
				String sql_time = " SELECT DISTINCT zg.reader_no, zg.time_code, td."+lang+"_desc AS time_desc "
						+ " FROM dbzone_group zg "
						+ " LEFT OUTER JOIN dbtimezone tz ON zg.time_code = tz.time_code "
						+ " LEFT OUTER JOIN dbtimedesc td ON tz.time_id = td.time_id "
						+ " WHERE zg.group_code = '"+group_code+"' " ;
					//	+ " GROUP BY zg.time_code, zg.reader_no " ;		//	Not support SQL Server
				ResultSet rs_time = stmtTmp.executeQuery(sql_time);  
				while(rs_time.next()){
					if(rs_time.getString("reader_no").equals(reader_no)){
						chk_open = true;
						time_code = rs_time.getString("time_code");
						time_code_link = "<b> <a href='#' onClick='show_detail2(\""+time_code+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'>" + time_code + "</a> </b>";
						if(rs_time.getString("time_desc") != null){
							time_desc += " - " + rs_time.getString("time_desc");
						}
					}
				}	rs_time.close();
				
				JSONArray ja = new JSONArray();
				
				if(checkPermission(ses_per, "0135")){
					if(chk_open){
						ja.put("<center> <img src='images/door_open.png' onClick='action_door(\"close\", \""+reader_no+"\");' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_allow+"'> </center>");
					}else{
						ja.put("<center> <img src='images/door_close_red.png' onClick='action_door(\"open\", \""+reader_no+"\");' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_not_allow+"'> </center>");
					}
				}
				
				ja.put("<center> "+ reader_no_link +" </center>");
				ja.put("<div class='ellipsis_string' style='max-width: 270px;'> <span class='pad-left-10'> "+ th_name +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 270px;'> <span class='pad-left-10'> "+ en_name +" </span> </div>");
				
				if(checkPermission(ses_per, "0135")){
					if(chk_open){
						if(!time_code_index.equals(time_code)){
							ja.put("<center> <img src='images/time_right.png' onClick='action_time(\"update_time\", \""+reader_no+"\", \""+time_code+"\");' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_update_time+"'> </center>");
						}else{
							ja.put("<center> <img src='images/time_correct.png' style='cursor: default;' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_time_now+"'> </center>");
						}
					}else{
						ja.put("<center> <img src='images/time_bw.png' style='cursor: default;' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title=''> </center>");
					}
				}
				if(!time_code.equals("00")){
					ja.put("<div class='ellipsis_string' style='max-width: 290px;'> <span class='pad-left-10'> "+ time_code_link +" "+time_desc+" </span> </div>");
				}else if(time_code.equals("00")){
					ja.put("<div class='ellipsis_string' style='max-width: 290px; font-size: 12px !important; color: red;'> <span class='pad-left-10'> <strong> <i> "+lb_no_define_time+" </i> </strong> </span> </div>");
				}else{
					ja.put("<div> </div>");
				}
				
				array.put(ja);	
				
			}	rs.close();
			
			if (searchTerm != "") {
				ResultSet rs2 = stmtQry.executeQuery(sqlcount + where_is_not_null + where_reader_list + where_exists + searchSQL);
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