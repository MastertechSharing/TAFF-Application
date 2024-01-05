<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%	
	session.setAttribute("st_date", request.getParameter("st_date"));
	session.setAttribute("st_time", request.getParameter("st_time"));
	session.setAttribute("end_time", request.getParameter("end_time"));
	
%>