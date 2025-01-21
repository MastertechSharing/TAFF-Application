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
		if(checkPermission(ses_per, "0")){
			cols = new String[]{ "", "", "door_id", "ip_address", "door.th_desc", "door.en_desc", "locate_code" };
		}else{
			cols = new String[]{ "door_id", "ip_address", "door.th_desc", "door.en_desc", "locate_code", "", "" };
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
				if (col < 2 || col > 6){
					col = 2;
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
		if(view_data.equals("all")){
			setWhere = " WHERE (door.hardware_model = '') and ( door.duplicate_ip != '"+view_data+"' ) ";
		}else{
			setWhere = " WHERE (door.hardware_model = '') and ( door.duplicate_ip = '"+view_data+"' ) ";
		}
		
		int total = getCountRecord("dbdoor", "hardware_model", "", stmtQry);
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
			String sql = "", sqlcount = "", searchTerm = "", searchSQL = setWhere;		
			if(request.getParameter("sSearch") != null){
				searchTerm = request.getParameter("sSearch");	//	new String(request.getParameter("sSearch").getBytes("ISO8859_1"), "utf-8");
				searchSQL += " AND ((door.door_id LIKE '%"+searchTerm+"%') OR (door.ip_address LIKE '%"+searchTerm+"%') "
						+ "OR (door.th_desc LIKE '%"+searchTerm+"%') OR (door.en_desc LIKE '%"+searchTerm+"%') "
						+ "OR (door.locate_code LIKE '%"+searchTerm+"%') ";
				if(lang.equals("th")){
					searchSQL += "OR (lo.th_desc LIKE '%"+searchTerm+"%') ";
				}else{
					searchSQL += "OR (lo.en_desc LIKE '%"+searchTerm+"%') ";
				}
				searchSQL += ") ";
			}
			
			if(mode == 0){		
				sql = " SELECT door.door_id, door.ip_address, door.th_desc AS d_th_desc, door.en_desc AS d_en_desc, "
					+ " door.locate_code, lo.th_desc AS l_th_desc, lo.en_desc AS l_en_desc, door.duplicate_ip "
					+ " FROM dbdoor door "
					+ " LEFT JOIN dblocation lo ON (door.locate_code = lo.locate_code) "
					+	searchSQL
					+ " ORDER BY " + colName + " " + dir + " LIMIT " + row_start + ", " + amount ;			
			}else if(mode == 1){			
				sql = " SELECT * FROM ( SELECT ROW_NUMBER() OVER ( ORDER BY " + colName + " " + dir + " ) AS 'NumRow', "	
					+ " door.door_id, door.ip_address, door.th_desc AS d_th_desc, door.en_desc AS d_en_desc, "
					+ " door.locate_code, lo.th_desc AS l_th_desc, lo.en_desc AS l_en_desc, door.duplicate_ip "
					+ " FROM dbdoor door "
					+ " LEFT JOIN dblocation lo ON (door.locate_code = lo.locate_code) "
					+	searchSQL
					+ " ) AS door "
					+ " WHERE NumRow BETWEEN " + (row_start +1) + " AND " + sEnd ;
			}
			
			ResultSet rs = stmtQry.executeQuery(sql);
			while (rs.next()) {			
				String door_id = rs.getString("door_id");
				String door_id_link = "<b> <a href='#' onClick='show_detail(\""+door_id+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'>" + door_id + "</a> </b>";
				String ip_address = rs.getString("ip_address");
				String th_name = rs.getString("d_th_desc");
				String en_name = rs.getString("d_en_desc");
				String locate_code = rs.getString("locate_code");	
				
				String locate_code_link = "", locate_desc_alert = "";
				locate_code_link = "<b> <a href='#' onClick='show_location(\""+locate_code+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_viewdata+"'>" + locate_code + "</a> </b>";
				locate_desc_alert = locate_code;
				if(locate_code != null){
					if(lang.equals("th")){
						if(rs.getString("l_th_desc") != null){
							locate_code_link += " - " + rs.getString("l_th_desc");	
							locate_desc_alert += " - " + rs.getString("l_th_desc");
						}
					}else{
						if(rs.getString("l_en_desc") != null){
							locate_code_link += " - " + rs.getString("l_en_desc");	
							locate_desc_alert += " - " + rs.getString("l_en_desc");
						}
					}
				}
				
				String new_ip_address = ip_address;
				if(network_feature.equals("1")){
					if(rs.getString("duplicate_ip").equals("1")){
						new_ip_address = "<div style='color: #a84644;'> <b> " + ip_address + " </b> </div>";
					}
				}
				
				JSONArray ja = new JSONArray();
				if(checkPermission(ses_per, "0")){
					ja.put("<center> <a href='edit_door.jsp?action=edit&door_id="+door_id+"'> <img src='images/edit.png' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_editdata+"'> </a> </center>");
					ja.put("<center> <img src='images/delete.png' width='20' height='20' border='0' align='absmiddle' onClick='ModalConfirm(\""+door_id+"\", \""+msg_confirmdel+"\", \""+ip_address+"\", \""+th_name+"\", \""+en_name+"\", \""+locate_desc_alert+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_deletedata+"'> </center>");
				}
				ja.put("<center> "+ door_id_link +" </center>");
				ja.put("<center> "+ new_ip_address +" </center>");
				ja.put("<div class='ellipsis_string' style='max-width: 260px;'> <span class='pad-left-10'> "+ th_name +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 260px;'> <span class='pad-left-10'> "+ en_name +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 260px;'> <span class='pad-left-10'> "+ locate_code_link +" </span> </div>");
				array.put(ja);			
			
			}	rs.close();
			
			sqlcount = "SELECT COUNT(*) AS count_row FROM dbdoor door "
					+ "LEFT JOIN dblocation lo ON (door.locate_code = lo.locate_code) ";
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