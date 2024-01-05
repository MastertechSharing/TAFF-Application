<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session_server_side.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>

<%	
	JSONObject result = new JSONObject();
	JSONArray array = new JSONArray();
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	
	if (session.getAttribute("ses_permission") == null) {
		
		JSONArray ja = new JSONArray();
		for(int i = 0; i < 3; i++){
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
			cols = new String[]{ "", "", "" };
		}
		
		int amount = 15;
		int row_start = 0;
		int echo = 0;
		int col = 1;
		
		String dir = "asc";
		String sStart = request.getParameter("iDisplayStart");
		String sAmount = request.getParameter("iDisplayLength");
		String sEcho = request.getParameter("sEcho");
		String sCol = request.getParameter("iSortCol_0");
		String sdir = request.getParameter("sSortDir_0");
		String path = request.getParameter("data").replace("?", "\\");
		
		if (sStart != null) {
			row_start = Integer.parseInt(sStart);
			if (row_start < 0){
				row_start = 0;
			}
		}
		if (sAmount != null) {
		//	amount = Integer.parseInt(sAmount);
		//	if (amount < 15 || amount > 1000){
		//		amount = 3660;
		//	}
		}
		if (sEcho != null) {
			echo = Integer.parseInt(sEcho);
		}
		if (sdir != null) {
			if (!sdir.equals("asc")){
				dir = "desc";
			}
		}
		String colName = cols[col];
		int total = 0;
		int totalAfterFilter = total;
		
		try{
			String search = "";
			if(request.getParameter("sSearch") != null){
				search = request.getParameter("sSearch");
			}
			
			try{	
				File files = new File(path);
				if (files.exists()) {
					String [] fileNames = files.list();
					File [] fileObjects = files.listFiles();
					
					for (int i = 0; i < fileObjects.length; i++) {
						if(!fileObjects[i].isDirectory()){
							
							boolean putarr = false;
							if(!search.equals("")){		//	Search
								if((fileNames[i].toLowerCase()).indexOf(search.toLowerCase()) != -1){
									putarr = true;
								}
							}else{
								putarr = true;
							}
							
							if(putarr){
								
							//	String datemodified = sdf.format(new File(path + "\\" + fileNames[i]).lastModified()).toString();
								
								JSONArray ja = new JSONArray();
								ja.put(fileNames[i]);	//	+"?"+fileObjects[i].length()
								ja.put("<span class='pad-left-10' style='max-width: 240px;'> " + fileNames[i] + " &nbsp; ( " + Long.toString(fileObjects[i].length()) + " bytes ) </span>");
								ja.put("<center style='max-width: 160px;'> <a href='#' onClick='downloadSingleFile(\"" + fileNames[i] + "\");'> <i class='glyphicon glyphicon-download-alt' data-toggle='tooltip' data-placement='left' title='" + lb_when_download_txt + "'> </i> </a> </center>");
								array.put(ja);
								
							}
				
						}
					}
				}
			}catch(Exception  e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
			}
			
		//	result.put("iTotalRecords", total);
		//	result.put("iTotalDisplayRecords", totalAfterFilter);
			result.put("aaData", array);
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-store");
			out.print(result);
		
		}catch (Exception e){
	 
		}
	
	}
	
%>

<%@ include file="../function/disconnect.jsp"%>