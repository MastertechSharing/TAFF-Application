<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="org.apache.commons.codec.binary.*"%>
<%@ page import="org.apache.commons.io.*"%>

<%	
	String action =	request.getParameter("action");
	String file = request.getParameter("file");
	 
	if(action.equals("add")){
		new File(getServletContext().getRealPath("/") + "photos\\tmpCapture\\"+file).delete();
	}else if(action.equals("edit")){
		new File(getServletContext().getRealPath("/") + "photos\\"+file).delete();
	}

%>