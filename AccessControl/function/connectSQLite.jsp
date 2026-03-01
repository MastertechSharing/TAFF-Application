<%@ page contentType="text/html; charset=tis-620" language="java" errorPage="../try_catch.jsp"%>
<%@ page import="java.sql.*"%>

<%		
	Connection dbConn = null;
	String dbName = "local.db";
	String dbClassName = "org.sqlite.JDBC";
	String dbConnectionURL = "jdbc:sqlite:" + dbName;
	try {
		Class.forName(dbClassName);
		dbConn = DriverManager.getConnection(dbConnectionURL);			
	} catch (ClassNotFoundException e) {
		response.sendRedirect("../try_catch.jsp?error=" + sqle.getMessage());
	} catch (SQLException e) {
		response.sendRedirect("../try_catch.jsp?error=" + sqle.getMessage());
	}			
	Statement stmSQLite = dbConn.createStatement();
%>