<%@ page contentType="text/html; charset=tis-620" language="java"%>

<% try{			
		if(stmtQry != null){
			stmtQry.close();
		}
		if(stmtUp != null){
			stmtUp.close();
		}
		if(stmtTmp != null){
			stmtTmp.close();
		}
		if(stmtSes != null){
			stmtSes.close();
		}
		if(!con.isClosed()){			
			con.close();
		}
	}catch(SQLException e){
		out.println("Unable to connect to database.");
	}
%>