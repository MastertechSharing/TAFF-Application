<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%	
	if(session.getAttribute("ses_permission") == null || session.getAttribute("ses_permission") == ""){
		out.println("<script>location.href='login.jsp';</script>");
	}
%>