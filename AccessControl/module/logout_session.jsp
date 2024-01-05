<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>

<%	
	String lang = request.getParameter("lang");
	session.setAttribute("sesid", null);
	session.setAttribute("ses_username", null);
	session.setAttribute("ses_permission", null);
	session.setAttribute("ses_monitor_data", null);
	
	session.setAttribute("page_g", null);
	session.setAttribute("subpage", null);
	session.setAttribute("subtitle", null);
	
	session.setAttribute("action", null);
	session.setAttribute("act", null);
	
	session.setAttribute("session_alert", null);
	session.setAttribute("type_alert", null);
	
	session.setAttribute("level_no", null);	
	
	session.invalidate();
	stmtSes.executeUpdate("DELETE FROM dbsession WHERE (ses_user_id = '"+session.getId()+"')");	
	out.println("<script>location.href='../login.jsp?lang="+lang+"';</script>");
%>

<%@ include file="../function/disconnect.jsp"%>