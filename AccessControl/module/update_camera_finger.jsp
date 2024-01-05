<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="org.apache.commons.codec.binary.*"%>
<%@ page import="org.apache.commons.io.*"%>
<%@ include file="../function/connect.jsp"%>

<%	
	String action = request.getParameter("action");
	String idcard = request.getParameter("idcard");
	
	if(action.equals("tpl")){
		try {
			if(new File(path_tpl + idcard + ".DAT").exists() == true){
				stmtUp.executeUpdate(" UPDATE dbemployee SET template = '1' WHERE idcard = '"+idcard+"' ");
			}
		} catch (Exception e) { } 
	}else if(action.equals("jpg_add")){
		try {
			if((new File(getServletContext().getRealPath("/")+"photos/" + idcard + ".jpg").exists() == true)){
				stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '1' WHERE idcard = '"+idcard+"' ");
			}
		} catch (Exception e) { } 
	}else if(action.equals("jpg_del")){
		try {
			if((new File(getServletContext().getRealPath("/")+"photos/" + idcard + ".jpg").exists() == false)){
				stmtUp.executeUpdate(" UPDATE dbemployee SET photo = '0' WHERE idcard = '"+idcard+"' ");
			}
		} catch (Exception e) { } 
	}
%>