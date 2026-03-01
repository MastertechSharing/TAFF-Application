<%@ page contentType="text/html; charset=tis-620" language="java"%>

<% try{			
		if(stmSQLite != null){
			stmSQLite.close();
		}		
	}catch(SQLException e){
		out.println("Unable to connect to database.");
	}
%>