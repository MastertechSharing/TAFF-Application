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
		for(int i = 0; i < 10; i++){
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
			cols = new String[]{ "", "", "", "photo", "template", "idcard", "th_fullname", "en_fullname", "sec_code", "date_data" };
		}else{
			cols = new String[]{ "photo", "template", "idcard", "th_fullname", "en_fullname", "sec_code", "date_data", "", "", "" };
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
			if(checkPermission(ses_per, "0135")){
				if (col < 3 || col > 8){
					col = 5;
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
		
		try{
			String sqlWhere = "";				
			String sqlcount = " SELECT COUNT(*) AS count_row ";
			String sqlFrom = " FROM dbemployee emp "
						+ " LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) ";	 		
			if(checkPermission(ses_per, "1256")){
				sqlFrom += " LEFT JOIN dbdepart dep ON (dep.dep_code = sec.dep_code) "
					+ " LEFT JOIN dbusers users ON (users.dep_code = dep.dep_code) ";
				
				sqlWhere = " WHERE (users.user_name = '"+ses_user+"') ";
				if(checkPermission(ses_per, "56")){
					sqlWhere += " AND (sec.sec_code = users.sec_code) ";
				}				
			}	
			String sqlView = "";
			if(view_data.equals("1")){
				sqlView = " (emp.photo = '1') ";
			}else if(view_data.equals("2")){
				sqlView = " (emp.photo = '0') ";
			}else if(view_data.equals("3")){
				sqlView = " (emp.template = '1') ";
			}else if(view_data.equals("4")){
				sqlView = " (emp.template = '0') ";
			}
			if(!sqlView.equals("")){
				if(sqlWhere.equals("")){
					sqlWhere += " WHERE ";	
				}else{
					sqlWhere += " AND ";	
				}
				sqlWhere += sqlView;	
			}	
				
			ResultSet rs1 = stmtQry.executeQuery(sqlcount+sqlFrom+sqlWhere);			
			int total = 0;		
			if(rs1.next()){
				total = rs1.getInt("count_row");
			}	
			rs1.close();
			int totalAfterFilter = total;		
			
			String colName = cols[col];
			String sql = "", searchTerm = "", searchSQL = "";	
			if(request.getParameter("sSearch") != null){
				searchTerm = request.getParameter("sSearch");	//	new String(request.getParameter("sSearch").getBytes("ISO8859_1"), "utf-8");								
				if(sqlWhere.equals("")){
					sqlWhere += " WHERE ";	
				}else{
					sqlWhere += " AND ";	
				}
				searchSQL = sqlFrom + sqlWhere + " ((emp.idcard like '%"+searchTerm+"%') " 
							+ " OR (emp.th_fname like '%"+searchTerm+"%') OR (emp.th_sname like '%"+searchTerm+"%') "
							+ " OR (emp.en_fname like '%"+searchTerm+"%') OR (emp.en_sname like '%"+searchTerm+"%') "
							+ " OR (emp.sec_code like '%"+searchTerm+"%') ";
							//" OR (emp.date_data like '%"+searchTerm+"%') ";
				if(lang.equals("th")){
					searchSQL += " OR (sec.th_desc LIKE '%"+searchTerm+"%')) ";
				}else{
					searchSQL += " OR (sec.en_desc LIKE '%"+searchTerm+"%')) ";
				}					
			}	
			
			if(mode == 0){				
				sql = "SELECT emp.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.date_data, "
						+ "emp.sec_code, emp.photo, emp.template "
						+ ", CONCAT(emp.th_fname, ' ', emp.th_sname) AS th_fullname "
						+ ", CONCAT(emp.en_fname, ' ', emp.en_sname) AS en_fullname ";						
				if(lang.equals("th")){
					sql += ", sec.th_desc AS sec_desc ";
				}else{
					sql += ", sec.en_desc AS sec_desc ";
				}						
				sql += searchSQL;
				sql += " ORDER BY " + colName + " " + dir ;
				if(colName.equals("photo") || colName.equals("template")){
					sql += ", idcard asc ";
				}
				sql += " LIMIT " + row_start + ", " + amount;				
			}else if(mode == 1){
				int sEnd = Integer.parseInt(sStart) + Integer.parseInt(sAmount);				
				sql = " SELECT * FROM ( SELECT ROW_NUMBER() OVER ( ORDER BY " + colName + " " + dir ;
				if(colName.equals("photo") || colName.equals("template")){
					sql += ", idcard asc ";
				}
				sql += " ) AS 'NumRow', ";
				sql += "emp.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.date_data, "
						+ "emp.sec_code, emp.photo, emp.template "
						+ ", emp.th_fname+' '+emp.th_sname AS th_fullname "
						+ ", emp.en_fname+' '+emp.en_sname AS en_fullname ";							
				if(lang.equals("th")){
					sql += ", sec.th_desc AS sec_desc ";
				}else{
					sql += ", sec.en_desc AS sec_desc ";
				}	
				sql += searchSQL;
				sql += " ) AS employee ";
				sql += "WHERE NumRow BETWEEN " + (row_start +1) + " AND " + sEnd;				
			}
			
			ResultSet rs = stmtQry.executeQuery(sql);			
			while (rs.next()) {				
				String idcard = rs.getString("idcard");				
				String emp_id_link = "<b> <a href='#' onClick='show_detail(\""+idcard+"\");' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + idcard + "</a> </b>";
				String th_name = rs.getString("th_fullname");//rs.getString("emp.th_fname")+" "+rs.getString("emp.th_sname");
				String en_name = rs.getString("en_fullname");//rs.getString("emp.en_fname")+" "+rs.getString("emp.en_sname");				
				String date_data = YMDTodate(rs.getString("date_data"))+" "+rs.getString("date_data").substring(11, 19);
				
				String sec_code = rs.getString("sec_code");
				String sec_link = "<b> <a href='#' onClick='show_detail2(\""+sec_code+"\");' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + sec_code + "</a> </b> ";
				if(rs.getString("sec_desc") != null && rs.getString("sec_desc") != ""){
					sec_link += " - " + rs.getString("sec_desc");
				}				
				
				String img_jpg = "camera.png", img_tlp = "finger_tab.png";
				if(rs.getString("photo").equals("0")){
					img_jpg = "camera_bw.png";
				}
				if(rs.getString("template").equals("0")){
					img_tlp = "finger_tab_bw.png";
				}
				
				//	Check Blacklist
				boolean chk_blacklist = false;
				ResultSet rs_bl = stmtTmp.executeQuery(" SELECT COUNT(idcard) as c_idcard FROM dbblacklist WHERE (idcard = '"+idcard+"') AND (cancel_status = '0') ");
				if(rs_bl.next()) {
					if(rs_bl.getInt("c_idcard") != 0){
						chk_blacklist = true;
					}
				}	rs_bl.close();
				
				JSONArray ja = new JSONArray();
				if(checkPermission(ses_per, "0135")){
					if(chk_blacklist){
						ja.put("<center> <a href='#'> <img src='images/edit_bw.png' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_emp_blacklist+"' onClick='javascript: ModalDanger_10Second_NoReturn(\" "+lb_emp_blacklist+", "+lb_cannot_editemployee+" \");'> </a> </center>");
					}else{
						ja.put("<center> <a href='edit_employee.jsp?action=edit&idcard="+idcard+"'> <img src='images/edit.png' width='18' height='18' border='0' align='absmiddle' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_editdata+"'> </a> </center>");
					}
					ja.put("<center> <img src='images/delete.png' width='20' height='20' border='0' align='absmiddle' onClick='ModalConfirm(\""+idcard+"\", \"delete\", \""+msg_confirmdel+"\", \"alert-message-danger\", \"glyphicon-trash\", \"alert-message-danger\", \"btn-danger\", \""+th_name+"\", \""+en_name+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_deletedata+"'> </center>");
					ja.put("<center> <img src='images/refresh.png' width='16' height='16' border='0' align='absmiddle' onClick='ModalConfirm(\""+idcard+"\", \"clear\", \""+msg_confirmClear+"\", \"alert-message-warning\", \"glyphicon-repeat\", \"alert-message-warning\", \"btn-warning\", \"\", \"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_clear_pw+"'> </center>");
					ja.put("<center> <img src='images/"+img_jpg+"' width='18' height='18' border='0' align='absmiddle' onClick='cameraCapture(\""+lb_take_photo+"\", \""+idcard+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_take_photo+"'> </center>");	//	onLoad='chkPhoto(\""+idcard+"\");'  id='img_"+idcard+"'
					ja.put("<center> <img src='images/"+img_tlp+"' width='20' height='20' border='0' align='absmiddle' onClick='registerFinger(\""+lb_enrollfp+"\", \""+idcard+"\");' data-toggle='tooltip' data-placement='right' data-html='true' title='"+lb_enrollfp+"'> </center>");
				}
				ja.put("<center> "+ emp_id_link +" </center>");
				ja.put("<div class='ellipsis_string' style='max-width: 250px;'> <span class='pad-left-10'> "+ th_name +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 250px;'> <span class='pad-left-10'> "+ en_name +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 250px;'> <span class='pad-left-10'> "+ sec_link +" </span> </div>");
				ja.put("<center> "+ date_data +" </center>");
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