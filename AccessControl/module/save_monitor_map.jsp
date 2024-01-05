<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>

<%	
	String door_id = request.getParameter("door_id");
	String posX = request.getParameter("posX");
	String posY = request.getParameter("posY");
	String sql = "UPDATE dbdoor SET pos_x = '"+posX+"', pos_y = '"+posY+"' WHERE (door_id = '"+door_id+"')";
	try{
		stmtUp.executeUpdate(sql);
	}catch (SQLException e) {
		response.sendRedirect("../try_catch.jsp?error="+e.getMessage());
	}
	out.println("<script> document.location='../monitor_map.jsp'; </script>");
%>

<%@ include file="../function/disconnect.jsp"%>