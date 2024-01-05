<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="../css/taff.css" type="text/css">
		<!-- Bootstrap -->
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		<link href="../css/alert-messages.css" rel="stylesheet">
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="../js/jquery.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>	
		<script language="javascript" src="../js/alert_box.js"></script> 
		
	</head>
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		<%@ include file="../tools/modal_danger.jsp"%>
	</body>
</html>
<%
	String action = request.getParameter("action");
	String ckActionCmd = "0";
	
	String pattern = "", card_pattern = "";
	pattern = request.getParameter("pattern1");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern2");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern3");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern4");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern5");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern6");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern7");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern8");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern9");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern10");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern11");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern12");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern13");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern14");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern15");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}
	pattern = request.getParameter("pattern16");
	if(pattern.equals("")){card_pattern += " ";}else{card_pattern += pattern;}

	String display_digit = "";
	if(request.getParameter("dis1") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis2") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis3") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis4") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis5") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis6") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis7") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis8") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis9") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis10") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis11") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis12") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis13") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis14") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis15") == null){display_digit += "N";}else{display_digit += "Y";}
	if(request.getParameter("dis16") == null){display_digit += "N";}else{display_digit += "Y";}	
	
	String save_digit = "";
	if(request.getParameter("save1") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save2") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save3") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save4") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save5") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save6") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save7") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save8") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save9") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save10") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save11") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save12") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save13") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save14") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save15") == null){save_digit += "N";}else{save_digit += "Y";}
	if(request.getParameter("save16") == null){save_digit += "N";}else{save_digit += "Y";}
	
	String master_card1 = new String(request.getParameter("master_card1").getBytes("ISO8859_1"),"tis-620");
	String master_card2 = new String(request.getParameter("master_card2").getBytes("ISO8859_1"),"tis-620");
	String master_card3 = new String(request.getParameter("master_card3").getBytes("ISO8859_1"),"tis-620");
	String master_card4 = new String(request.getParameter("master_card4").getBytes("ISO8859_1"),"tis-620");
	String master_card5 = new String(request.getParameter("master_card5").getBytes("ISO8859_1"),"tis-620");	
	String customer_code = new String(request.getParameter("customer_code").getBytes("ISO8859_1"),"tis-620");
	String block_id = request.getParameter("block_id");
	String key_card2 = request.getParameter("key_card2");
	String modulef = request.getParameter("moduleF");
	String duplicate_time = request.getParameter("duplicate_time");
	String start_digit = request.getParameter("start_digit");
	String issue_digit = request.getParameter("issue_digit");
	
	if (action.equals("edit")) {
		String sql = "UPDATE dbconfigcorp SET config_code='0', card_pattern='" + card_pattern + "', display_digit='"
				+ display_digit + "', save_digit='" + save_digit + "', master_card1=UPPER('" + master_card1
				+ "'), master_card2=UPPER('" + master_card2 + "'), master_card3=UPPER('" + master_card3
				+ "'), master_card4=UPPER('" + master_card4 + "'), master_card5=UPPER('" + master_card5
				+ "'), customer_code='" + customer_code + "', duplicate_time='" + duplicate_time
				+ "', start_digit='" + start_digit + "', issue_digit='" + issue_digit + "', key_card2=UPPER('"
				+ key_card2 + "'), block_id='" + block_id + "', moduleF='" + modulef 
				+ "' WHERE (config_code = '0') ";
		try{
			resultQry = stmtUp.executeUpdate(sql);
			if (resultQry != 0) {
				if (!(key_card2.equals(request.getParameter("oldkeycard2"))
						&& block_id.equals(request.getParameter("oldblockid"))
						&& duplicate_time.equals(request.getParameter("oldduplicatetime"))
						&& issue_digit.equals(request.getParameter("oldissuedigit"))
						&& start_digit.equals(request.getParameter("oldstartdigit"))
						&& master_card1.equals(request.getParameter("oldmascard1"))
						&& master_card2.equals(request.getParameter("oldmascard2"))
						&& master_card3.equals(request.getParameter("oldmascard3"))
						&& master_card4.equals(request.getParameter("oldmascard4"))
						&& master_card5.equals(request.getParameter("oldmascard5"))
						&& customer_code.equals(request.getParameter("oldcustomercode"))
						&& save_digit.equals(request.getParameter("oldsavedigit"))
						&& display_digit.equals(request.getParameter("olddisplaydigit"))
						&& card_pattern.equals(request.getParameter("oldpattern")))){
					ckActionCmd = "2";
				}
				session.setAttribute("session_alert", msg_editsuccess);
				rc.WriteDataLogFile("[" + ses_user + "] Edit data configcorp [dbconfigcorp]");
				out.println("<script>document.location='../view_configcorp.jsp';</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	}
	
	if (!(ckActionCmd.equals("0"))) {
		String date_updates = dateToYMDTime(getCurrentDateTimeShow());
		String doorID = "";
		String ipAddr = "";
		ResultSet rs = stmtQry.executeQuery(selectDbDoor());
		while (rs.next()) {
			doorID = rs.getString("door_id");
			ipAddr = rs.getString("ip_address");
			try{
				stmtUp.executeUpdate(insertDbStatus(doorID, "30", ipAddr, ckActionCmd, date_updates));
			}catch (SQLException e1){
				stmtUp.executeUpdate(updateDbStatus(doorID, "30", ipAddr, ckActionCmd, date_updates));
			}
		}
		rs.close();
	}
%>

<%@ include file="../function/disconnect.jsp"%>