<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="org.apache.commons.io.FileUtils"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	
	String ip = "", door_id = "", idcard = "", type_data = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("idcard") != null){
		idcard = request.getParameter("idcard");
	}
	if(request.getParameter("type_data") != null){
		type_data = request.getParameter("type_data");
	}
	
	String pathfile = "";
	if(!ip.equals("")){
		pathfile = path_data + ip + "\\EMPLOYEE_PICTURES\\"+idcard+".jpg";
	}else{
		pathfile = path_data + door_id + "\\EMPLOYEE_PICTURES\\"+idcard+".jpg";
	}
	
	if(type_data.equals("view")){
		
		String fullname = "";
		String sql_employee = " SELECT ";
		if(lang.equals("th")){
			sql_employee += " th_fname AS fname, th_sname AS sname ";
		}else{
			sql_employee += " en_fname AS fname, en_sname AS sname ";
		}
		sql_employee += " FROM dbemployee WHERE idcard = '"+idcard+"' ";
		ResultSet rs = stmtQry.executeQuery(sql_employee);
		if(rs.next()){
			fullname = rs.getString("fname")+" "+rs.getString("sname");
		}	rs.close();
%>	
	<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
	
	<label style="margin-left: 50px; margin-top: 10px;"> <%// lb_empcode %> <%= idcard %> - <%= fullname %> </label>
	<center> <img id="img_picture" class="img-rounded" src="data:image/jpeg;base64,<%= decodeToImage(pathfile, "jpg") %>" width="336" height="252" style="cursor: pointer;"> </center>
		
<%		
	}else if(type_data.equals("save")){
		
		try {
			
			File getFile = new File(pathfile);
			File saveFile = new File(request.getRealPath("/")+"photos\\"+idcard+".jpg");
			FileUtils.copyFile(getFile, saveFile);
			
			if((new File(getServletContext().getRealPath("/")+"photos/" + idcard + ".jpg").exists() == true)){
				stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '1' WHERE idcard = '"+idcard+"' ");
			}
			
		} catch(Exception e){ }
		
	}
%>

<%@ include file="../function/disconnect.jsp"%>