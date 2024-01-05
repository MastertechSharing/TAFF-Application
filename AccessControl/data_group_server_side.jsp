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
		
		String ses_group_user = (String)session.getAttribute("ses_group_user");
	
		String[] cols = null;
		if(checkPermission(ses_per, "0135")){
			cols = new String[]{ "", "", "", "group_code", "th_desc", "en_desc", "group_user" };
		}else{
			cols = new String[]{ "group_code", "th_desc", "en_desc", "group_user", "", "", "" };
		}
		
		int amount = 1;
		int row_start = 0;
		int echo = 0;
		int col = 0;
		
		String dir = "asc";
		String sStart =	request.getParameter("iDisplayStart");
		String sAmount = request.getParameter("iDisplayLength");
		String sEcho = request.getParameter("sEcho");
		String sCol = request.getParameter("iSortCol_0");
		String sdir = request.getParameter("sSortDir_0");
		String view_data = request.getParameter("view_data");
	
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
			if (amount < 1 || amount > 1000){
				amount = 1;
			}
		}
		if (sEcho != null) {
			echo = Integer.parseInt(sEcho);
		}
		if (sCol != null) {
			col = Integer.parseInt(sCol);
			if(checkPermission(ses_per, "0135")){
				if (col < 3 || col > 6){
					col = 3;
				}
			}else{
				if (col > 3){
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
		
		//	get group_user
		String get_group_user = "";
		String sql_group_user = " SELECT group_user FROM dbusers WHERE user_name = '"+ses_user+"' ";
		ResultSet rs_group_user = stmtQry.executeQuery(sql_group_user);
		if(rs_group_user.next()){
			get_group_user = rs_group_user.getString("group_user");
		}	rs_group_user.close();
		
		String where_length, where_group_user = "";
		if(mode == 0){
			where_length = " AND (LENGTH(group_code) <= 6) ";
		}else{
			where_length = " AND (LEN(group_code) <= 6) ";
		}
		
		if(view_data.equals("0")){
			//
		}else if(view_data.equals("1")){
			where_group_user = " AND group_user = '"+get_group_user+"' ";
		}else if(view_data.equals("2")){
			where_group_user = " AND group_user != '"+get_group_user+"' ";
		}
		
		int total = 0;
		String sqlcount = " SELECT COUNT(*) AS count_row FROM dbgroup WHERE group_code != '' " + where_group_user + where_length;
		ResultSet rs1 = stmtQry.executeQuery(sqlcount);
		if(rs1.next()){
			total = rs1.getInt("count_row");
		}	rs1.close();
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
				searchSQL = " AND ((group_code like '%"+searchTerm+"%') OR (group_user like '%"+searchTerm+"%') "
						+ " OR (th_desc LIKE '%"+searchTerm+"%') OR (en_desc LIKE '%"+searchTerm+"%')) ";
			}
		
			if(mode == 0){
				
				sql = " SELECT * FROM dbgroup "
					+ " WHERE group_code != '' "
					+   searchSQL
					+   where_group_user
					+   where_length
					+ " ORDER BY " + colName + " " + dir 
					+ " LIMIT " + row_start + ", " + amount;
				
			}else if(mode == 1){
				
				sql = " SELECT * FROM ( SELECT ROW_NUMBER() OVER ( ORDER BY " + colName + " " + dir + " ) AS 'NumRow', * FROM dbgroup "
					+ " WHERE group_code != '' "
					+   searchSQL
					+   where_group_user
					+   where_length
					+ " ) AS group_db "
					+ " WHERE NumRow BETWEEN " + (row_start +1) + " AND " + sEnd;
				
			}
			
			ResultSet rs = stmtQry.executeQuery(sql);
			while (rs.next()) {
			
				String group_code = rs.getString("group_code");
				String group_id_link = "<b> <a href='#' onClick='show_detail(\""+group_code+"\");' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + group_code + "</a> </b>";
				String th_name = rs.getString("th_desc");
				String en_name = rs.getString("en_desc");
				String group_user = rs.getString("group_user");
				
				String img_edit = "edit.png";
				String img_delete = "delete.png";
				String link_edit = "edit_group.jsp?action=edit&group_code="+group_code+"";
				String link_delete = "ModalConfirm(\""+group_code+"\", \""+msg_confirmdel+"\", \""+th_name+"\", \""+en_name+"\");";
				String tooltip_edit = "data-toggle='tooltip' data-placement='right' title='"+lb_editdata+"'";
				String tooltip_delete = "data-toggle='tooltip' data-placement='right' title='"+lb_deletedata+"'";
				boolean show_action = true;
				
				if(ses_per == 1 || ses_per == 2 || ses_per == 5 || ses_per == 6){
					if(!group_user.equals("")){
						if(!group_user.equals(ses_group_user)){
							show_action = false;
						}
					}else{
						if(!ses_group_user.equals("")){
							show_action = false;
						}
					}
				}else{
					if(!group_user.equals("")){
						show_action = false;
					}
				}
				
				if(view_data.equals("1")){
					if(!show_action){
						continue;
					}
				}else if(view_data.equals("2")){
					if(show_action){
						continue;
					}
				}
				
				if(!show_action){
					img_edit = "edit_bw.png";
					img_delete = "delete_bw.png";
					link_edit = "#";
					link_delete = "";
					tooltip_edit = "style='cursor: default;'";
					tooltip_delete = "style='cursor: default;'";
				}
				
				JSONArray ja = new JSONArray();
				if(checkPermission(ses_per, "0135")){
					ja.put("<center> <a href='"+link_edit+"'> <img src='images/"+img_edit+"' width='18' height='18' border='0' align='absmiddle' "+tooltip_edit+"> </a> </center>");
					ja.put("<center> <img src='images/"+img_delete+"' width='20' height='20' border='0' align='absmiddle' onClick='"+link_delete+"' "+tooltip_delete+"> </center>");
				}
				ja.put("<center> <a href='edit_zonegroup.jsp?action=add&group_code="+group_code+"'> <img src='images/group.png' width='18' height='18' border='0' align='absmiddle'> </center>");
				ja.put("<center> "+ group_id_link +" </center>");
				ja.put("<div class='ellipsis_string' style='max-width: 250px;'> <span class='pad-left-10'> "+ th_name +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 250px;'> <span class='pad-left-10'> "+ en_name +" </span> </div>");
				ja.put("<center> "+ group_user +" </center>");
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