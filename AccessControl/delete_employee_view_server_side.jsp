<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.*"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session_server_side.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>

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
		if(lang.equals("th")){
			cols = new String[]{ "", "emp.idcard", "emp.th_fname", "st_date", "ex_date", "emp.group_code", "emp.sec_code"};
		}else{
			cols = new String[]{ "", "emp.idcard", "emp.en_fname", "st_date", "ex_date", "emp.group_code", "emp.sec_code"};
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
		
		//	Term select employee
		String empcode = request.getParameter("emp_id"); 
		if(!empcode.equals("")){
			empcode = request.getParameter("emp_id");
		}else{
			empcode = "";
		}
		
		String stdate = "", stdate2 = "", exdate = "", exdate2 = "";
		if(request.getParameter("valuechk").equals("0")){
			stdate = dateToYMD(request.getParameter("stdate"));
			stdate2 = dateToYMD(request.getParameter("stdate2"));
			exdate = dateToYMD(request.getParameter("exdate"));
			exdate2 = dateToYMD(request.getParameter("exdate2"));
		}else if(request.getParameter("valuechk").equals("1")){
			stdate = dateToYMD(request.getParameter("stdate"));
			stdate2 = dateToYMD(request.getParameter("stdate2"));
		}else if(request.getParameter("valuechk").equals("2")){
			exdate = dateToYMD(request.getParameter("exdate"));
			exdate2 = dateToYMD(request.getParameter("exdate2"));
		}
		
		String groupcode = "", seccode = "";	
		if(!(request.getParameter("groupCode") == null && request.getParameter("groupCode") == "")){
			groupcode = request.getParameter("groupCode");
		}
		if(!(request.getParameter("secCode") == null && request.getParameter("secCode") == "")){
			seccode = request.getParameter("secCode");
		}
		
		String check_group = "";
		String[] check_group_id = null ;
		String paramName_group = "";
		String[] param_value_group;
		
		String check_sec ="";
		String[] check_sec_id =  null;	
		String paramName_sec = "";	
		String[] param_value_sec ;
		
		String setwhere_group = "";
		String setwhere_sec = "";
	
		String get_section = "", getbase_where_sec = "";
		
		if(checkPermission(ses_per, "1")){	
			if(seccode.equals("all") || seccode.equals("")){
				String sql = " SELECT sec.sec_code FROM dbsection sec "
					+ " LEFT OUTER JOIN dbdepart dep ON (sec.dep_code = dep.dep_code) "	
					+ " LEFT OUTER JOIN dbusers users ON (users.dep_code = dep.dep_code) "
					+ " WHERE (users.user_name = '"+ses_user+"') "			 		
					+ " ORDER BY sec.sec_code ASC ";
				
				ResultSet rssec = stmtQry.executeQuery(sql);
				while(rssec.next()){
					get_section += rssec.getString("sec.sec_code")+",";
				}	rssec.close();
				get_section = get_section.substring(0, (get_section.length() -1));
				
				getbase_where_sec += "AND (";
				param_value_sec = get_section.split(",");
					for(int i = 0; i < param_value_sec.length; i++){
						getbase_where_sec += " (sec.sec_code = '"+param_value_sec[i]+"') ";
						if(i != param_value_sec.length - 1){
							getbase_where_sec += "OR";
						}
					}
				getbase_where_sec += ") ";
			}
		}
		
		if(!groupcode.equals("all") && !groupcode.equals("")){
			check_group_id = request.getParameterValues("groupCode");
			for (int i = 0; i <= check_group_id.length -1; i++){
				if(i != check_group_id.length -1){
					check_group =  check_group+check_group_id[i] +",";
				} else {
					check_group =  check_group+check_group_id[i] ;
				}				 
			}
			paramName_group = check_group;
		
			if(!(paramName_group == null||paramName_group.equals(""))){
				setwhere_group += "AND (";
				param_value_group = paramName_group.split(",");
				for(int i = 0; i < param_value_group.length; i++){
					setwhere_group += " (emp.group_code = '"+param_value_group[i]+"') ";
					if(i != param_value_group.length - 1){
						setwhere_group += "OR";
					}
				}
				setwhere_group += ") ";
			}
		}
		
		if(!seccode.equals("all") && !seccode.equals("")){
			check_sec_id = request.getParameterValues("secCode");
			for (int i = 0; i <= check_sec_id.length -1; i++){
				if(i != check_sec_id.length -1){
					check_sec =  check_sec+check_sec_id[i] +",";
				} else {
					check_sec =  check_sec+check_sec_id[i] ;
				}
			}
			paramName_sec = check_sec;
		
			if(!(paramName_sec == null||paramName_sec.equals(""))){
				setwhere_sec += "AND (";
				param_value_sec = paramName_sec.split(",");
				for(int i = 0; i < param_value_sec.length; i++){
					setwhere_sec += " (sec.sec_code = '"+param_value_sec[i]+"') ";
					if(i != param_value_sec.length - 1){
						setwhere_sec += "OR";
					}
				}
				setwhere_sec += ") ";
			}
		}
		
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
			if (col < 1 || col > 6){
				col = 1;
			}
		}
		if (sdir != null) {
			if (!sdir.equals("asc")){
				dir = "desc";
			}
		}
		String colName = cols[col];	
		try{		
			String sql = "", sqlcount = "", whereParam = "", whereSearch = "";		
			
			if(!(empcode == null||empcode.equals("")||empcode.equals("null"))){
				whereParam += "AND (emp.idcard = '"+empcode+"') ";
			}else{
				if(!(request.getParameter("valuechk").equals(""))){
					if(request.getParameter("valuechk").equals("0")){
						if(!(request.getParameter("stdate") == null && request.getParameter("stdate2") == null)){
							if(!(request.getParameter("exdate") == null && request.getParameter("exdate2") == null)){
								whereParam += "AND (st_date BETWEEN '"+stdate+"' AND '"+stdate2+"') OR (ex_date BETWEEN '"+exdate+"' AND '"+exdate2+"') ";
							}
						}
					}else if(request.getParameter("valuechk").equals("1")){
						if(!(request.getParameter("stdate") == null && request.getParameter("stdate2") == null)){
							whereParam += "AND (st_date BETWEEN '"+stdate+"' AND '"+stdate2+"') ";
						}
					}else if(request.getParameter("valuechk").equals("2")){
						if(!(request.getParameter("exdate") == null && request.getParameter("exdate2") == null)){
							whereParam += "AND (ex_date BETWEEN '"+exdate+"' AND '"+exdate2+"') ";
						} 
					}
				}
				
				if(!groupcode.equals("all") && !groupcode.equals("")){
					whereParam += setwhere_group;
				}
				
				if(!seccode.equals("all") && !seccode.equals("")){
					whereParam += setwhere_sec;
				}else{
					whereParam += getbase_where_sec;
				}
			}
			
			if(request.getParameter("sSearch") != null){
				String sSearch = request.getParameter("sSearch");	//	new String(request.getParameter("sSearch").getBytes("ISO8859_1"), "utf-8");
				whereSearch = "AND ((emp.idcard like '%"+sSearch+"%') OR (emp.group_code like '%"+sSearch+"%') OR (emp.sec_code like '%"+sSearch+"%') ";
				if(lang.equals("th")){
					whereSearch += "OR (th_fname like '%"+sSearch+"%') OR (th_sname like '%"+sSearch+"%') OR (gr.th_desc LIKE '%"+sSearch+"%') OR (sec.th_desc LIKE '%"+sSearch+"%') ";
				}else{
					whereSearch += "OR (en_fname like '%"+sSearch+"%') OR (en_sname like '%"+sSearch+"%') OR (gr.en_desc LIKE '%"+sSearch+"%') OR (sec.en_desc LIKE '%"+sSearch+"%') ";
				}
				whereSearch += ") ";
			}
			
			if(mode == 0){		
				sql = "SELECT emp.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.st_date, emp.ex_date, "
					+ "emp.group_code AS groupcode, gr.th_desc AS grthdesc, gr.en_desc AS grendesc, "
					+ "emp.sec_code AS seccode, sec.th_desc AS sthdesc, sec.en_desc AS sendesc "
					+ "FROM dbemployee emp "
					+ "LEFT JOIN dbgroup gr ON (gr.group_code = emp.group_code) "
					+ "LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) ";
				sql += "WHERE (idcard != '****************') ";
				sql += whereParam + whereSearch;
				sql += "ORDER BY " + colName + " " + dir + " LIMIT " + row_start + ", " + amount;
			}else if(mode == 1){
				int sEnd = Integer.parseInt(sStart) + Integer.parseInt(sAmount);
				
				sql = "SELECT * FROM ( SELECT ROW_NUMBER() OVER ( ORDER BY " + colName + " " + dir + " ) AS 'NumRow', ";
				sql += "emp.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.st_date, emp.ex_date, "
						+ "emp.group_code AS groupcode, gr.th_desc AS grthdesc, gr.en_desc AS grendesc, "
						+ "emp.sec_code AS seccode, sec.th_desc AS sthdesc, sec.en_desc AS sendesc "
						+ "FROM dbemployee emp "
						+ "LEFT JOIN dbgroup gr ON (gr.group_code = emp.group_code) "
						+ "LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) ";
				sql += "WHERE (idcard != '****************') ";
				sql += whereParam + whereSearch;
				sql += " ) AS employee ";
				sql += "WHERE NumRow BETWEEN " + (row_start +1) + " AND " + sEnd;		
			}
			
			ResultSet rs = stmtQry.executeQuery(sql);
			while (rs.next()) {			
				String idcard = rs.getString("idcard");
				String st_date = rs.getString("st_date");	//	YMDTodate(rs.getString("st_date"));
				String ex_date = rs.getString("ex_date");	//	YMDTodate(rs.getString("ex_date"));
				
				String name = "", grpdesc = "", secdesc = "";
				if(lang.equals("th")){
					name = rs.getString("th_fname")+" "+rs.getString("th_sname");
					grpdesc = "<b> <a href='#' onClick='show_detail2(\""+rs.getString("groupcode")+"\");' data-toggle='tooltip' data-placement='left' title='"+lb_viewdata+"'>" + rs.getString("groupcode") + "</a>" + " : </b> "+rs.getString("grthdesc");
					secdesc = "<b> <a href='#' onClick='show_detail3(\""+rs.getString("seccode")+"\");' data-toggle='tooltip' data-placement='left' title='"+lb_viewdata+"'>" + rs.getString("seccode") + "</a>" + " : </b> "+rs.getString("sthdesc");
				}else{
					name = rs.getString("en_fname")+" "+rs.getString("en_sname");
					grpdesc = "<b> <a href='#' onClick='show_detail2(\""+rs.getString("groupcode")+"\");' data-toggle='tooltip' data-placement='left' title='"+lb_viewdata+"'>" + rs.getString("groupcode") + "</a>" + " : </b> "+rs.getString("grendesc");
					secdesc = "<b> <a href='#' onClick='show_detail3(\""+rs.getString("seccode")+"\");' data-toggle='tooltip' data-placement='left' title='"+lb_viewdata+"'>" + rs.getString("seccode") + "</a>" + " : </b> "+rs.getString("sendesc");
				}
				
				JSONArray ja = new JSONArray();
				ja.put("<center> <input type='checkbox' name='chkemp' id='chkemp' value='"+idcard+"' style='margin-top: 3px; margin-bottom: 3px; cursor: pointer; cursor: hand;' onclick='checkSelectObj(document.form1.checkall2, document.form1.chkemp);'> </center>");
				ja.put("<span class='pad-left-10'> <b> <a href='#' onClick='show_detail(\""+idcard+"\");' data-toggle='tooltip' data-placement='right' title='"+lb_viewdata+"'> "+idcard+" </a> </b> </span>");
				ja.put("<div class='ellipsis_string' style='max-width: 220px;'> <span class='pad-left-10'> "+ name +" </span> </div>");
				ja.put("<center> "+st_date+" </center>");
				ja.put("<center> "+ex_date+" </center>");
				ja.put("<div class='ellipsis_string' style='max-width: 220px;'> <span class='pad-left-10'> "+ grpdesc +" </span> </div>");
				ja.put("<div class='ellipsis_string' style='max-width: 220px;'> <span class='pad-left-10'> "+ secdesc +" </span> </div>");
				array.put(ja);
			}
			rs.close();
		
			int total = 0;
			try{
				sqlcount = "SELECT COUNT(*) AS count_row FROM dbemployee emp "
						+ "LEFT JOIN dbgroup gr ON (gr.group_code = emp.group_code) "
						+ "LEFT JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
						+ "WHERE (idcard != '****************') "
						+ whereParam;
				ResultSet rs2 = stmtQry.executeQuery(sqlcount);
				if(rs2.next()){
					total = rs2.getInt("count_row");
				}
				rs2.close();
			}catch(Exception e){ }
			
			int totalAfterFilter = total;
			try{
				if (whereSearch != "") {
					ResultSet rs2 = stmtQry.executeQuery(sqlcount + whereSearch);
					if(rs2.next()){
						totalAfterFilter = rs2.getInt("count_row");
					}
					rs2.close();
				}
			}catch(Exception e){ }
			
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