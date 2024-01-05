<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%	
	String idcard = "";
	if(request.getParameter("idcard") != null && request.getParameter("idcard") != ""){
		idcard = request.getParameter("idcard").toUpperCase();
	}
	
	String action = request.getParameter("action");
	boolean enable_btn = true;
	
	ResultSet rs = stmtQry.executeQuery(" SELECT COUNT(bl.idcard) AS c_idcard FROM dbblacklist bl WHERE cancel_status = '0' AND bl.idcard = '"+idcard+"' ");
	if(rs.next()){
		if(rs.getInt("c_idcard") != 0){
			enable_btn = false;
			
			if(action.equals("onChange")){
			out.println(rs.getInt("c_idcard"));
				out.println("<script> "
					+ " 	parent.window.document.getElementById('text_danger_noreturn').innerHTML = '"+lb_emp_blacklist+"'; "
					+ " 	parent.window.document.getElementById('emp_id').value = ''; "
					+ "		parent.window.$('#myModalDangerNoReturn').modal('show'); "
					+ " 	setTimeout(function(){ parent.window.document.getElementById('btn_ok').disabled = false; }, 1000); "
					+ "	 </script> ");
					
			}else if(action.equals("onKey")){
				
				out.println("<script> "
						+ " 	parent.window.document.getElementById('btn_ok').disabled = true; "
						+ "	 </script> ");
				
			}
		}
	}	rs.close();
	
	if(enable_btn){
		out.println("<script> parent.window.document.getElementById('btn_ok').disabled = false; </script>");
	}
	
%>
<%@ include file="../function/disconnect.jsp"%>