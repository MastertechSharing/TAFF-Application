<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
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
	String day_type = request.getParameter("day_type");	
	String ckActionCmd = "0";
	
	if (action.equals("clear")) {
		try{
			resultQry = stmtUp.executeUpdate("UPDATE dbtimeon_out4 SET time1='', time2='', time3='', time4='', time5='', "
					+ "time6='', time7='', time8='', time9='', time10='', time11='', time12='', time13='', time14='', time15='', "
					+ "time16='', time17='', time18='', time19='', time20='', time21='', time22='', time23='', time24='', time25='', "
					+ "time26='', time27='', time28='', time29='', time30='' WHERE (day_type = '"+ day_type + "')");
			if (resultQry != 0) {
				ckActionCmd = "2";
				session.setAttribute("session_alert", msg_cleartimecomplete);
				rc.WriteDataLogFile("[" + ses_user + "] Clear day_type : " + day_type + " [dbtimeon_out4]");
				out.println("<script>document.location='../data_timeonoutput4.jsp';</script>");
			}
		}catch (SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	} else {
		String time1 = formatFullTimeOut4(request.getParameter("hh1"), request.getParameter("mm1"),
				request.getParameter("ss1"), request.getParameter("hh2"), request.getParameter("mm2"),
				request.getParameter("ss2"));
		String time2 = formatFullTimeOut4(request.getParameter("hh3"), request.getParameter("mm3"),
				request.getParameter("ss3"), request.getParameter("hh4"), request.getParameter("mm4"),
				request.getParameter("ss4"));
		String time3 = formatFullTimeOut4(request.getParameter("hh5"), request.getParameter("mm5"),
				request.getParameter("ss5"), request.getParameter("hh6"), request.getParameter("mm6"),
				request.getParameter("ss6"));
		String time4 = formatFullTimeOut4(request.getParameter("hh7"), request.getParameter("mm7"),
				request.getParameter("ss7"), request.getParameter("hh8"), request.getParameter("mm8"),
				request.getParameter("ss8"));
		String time5 = formatFullTimeOut4(request.getParameter("hh9"), request.getParameter("mm9"),
				request.getParameter("ss9"), request.getParameter("hh10"), request.getParameter("mm10"),
				request.getParameter("ss10"));
		String time6 = formatFullTimeOut4(request.getParameter("hh11"), request.getParameter("mm11"),
				request.getParameter("ss11"), request.getParameter("hh12"), request.getParameter("mm12"),
				request.getParameter("ss12"));
		String time7 = formatFullTimeOut4(request.getParameter("hh13"), request.getParameter("mm13"),
				request.getParameter("ss13"), request.getParameter("hh14"), request.getParameter("mm14"),
				request.getParameter("ss14"));
		String time8 = formatFullTimeOut4(request.getParameter("hh15"), request.getParameter("mm15"),
				request.getParameter("ss15"), request.getParameter("hh16"), request.getParameter("mm16"),
				request.getParameter("ss16"));
		String time9 = formatFullTimeOut4(request.getParameter("hh17"), request.getParameter("mm17"),
				request.getParameter("ss17"), request.getParameter("hh18"), request.getParameter("mm18"),
				request.getParameter("ss18"));
		String time10 = formatFullTimeOut4(request.getParameter("hh19"), request.getParameter("mm19"),
				request.getParameter("ss19"), request.getParameter("hh20"), request.getParameter("mm20"),
				request.getParameter("ss20"));
		String time11 = formatFullTimeOut4(request.getParameter("hh21"), request.getParameter("mm21"),
				request.getParameter("ss21"), request.getParameter("hh22"), request.getParameter("mm22"),
				request.getParameter("ss22"));
		String time12 = formatFullTimeOut4(request.getParameter("hh23"), request.getParameter("mm23"),
				request.getParameter("ss23"), request.getParameter("hh24"), request.getParameter("mm24"),
				request.getParameter("ss24"));
		String time13 = formatFullTimeOut4(request.getParameter("hh25"), request.getParameter("mm25"),
				request.getParameter("ss25"), request.getParameter("hh26"), request.getParameter("mm26"),
				request.getParameter("ss26"));
		String time14 = formatFullTimeOut4(request.getParameter("hh27"), request.getParameter("mm27"),
				request.getParameter("ss27"), request.getParameter("hh28"), request.getParameter("mm28"),
				request.getParameter("ss28"));
		String time15 = formatFullTimeOut4(request.getParameter("hh29"), request.getParameter("mm29"),
				request.getParameter("ss29"), request.getParameter("hh30"), request.getParameter("mm30"),
				request.getParameter("ss30"));
		String time16 = formatFullTimeOut4(request.getParameter("hh31"), request.getParameter("mm31"),
				request.getParameter("ss31"), request.getParameter("hh32"), request.getParameter("mm32"),
				request.getParameter("ss32"));
		String time17 = formatFullTimeOut4(request.getParameter("hh33"), request.getParameter("mm33"),
				request.getParameter("ss33"), request.getParameter("hh34"), request.getParameter("mm34"),
				request.getParameter("ss34"));
		String time18 = formatFullTimeOut4(request.getParameter("hh35"), request.getParameter("mm35"),
				request.getParameter("ss35"), request.getParameter("hh36"), request.getParameter("mm36"),
				request.getParameter("ss36"));
		String time19 = formatFullTimeOut4(request.getParameter("hh37"), request.getParameter("mm37"),
				request.getParameter("ss37"), request.getParameter("hh38"), request.getParameter("mm38"),
				request.getParameter("ss38"));
		String time20 = formatFullTimeOut4(request.getParameter("hh39"), request.getParameter("mm39"),
				request.getParameter("ss39"), request.getParameter("hh40"), request.getParameter("mm40"),
				request.getParameter("ss40"));
		String time21 = formatFullTimeOut4(request.getParameter("hh41"), request.getParameter("mm41"),
				request.getParameter("ss41"), request.getParameter("hh42"), request.getParameter("mm42"),
				request.getParameter("ss42"));
		String time22 = formatFullTimeOut4(request.getParameter("hh43"), request.getParameter("mm43"),
				request.getParameter("ss43"), request.getParameter("hh44"), request.getParameter("mm44"),
				request.getParameter("ss44"));
		String time23 = formatFullTimeOut4(request.getParameter("hh45"), request.getParameter("mm45"),
				request.getParameter("ss45"), request.getParameter("hh46"), request.getParameter("mm46"),
				request.getParameter("ss46"));
		String time24 = formatFullTimeOut4(request.getParameter("hh47"), request.getParameter("mm47"),
				request.getParameter("ss47"), request.getParameter("hh48"), request.getParameter("mm48"),
				request.getParameter("ss48"));
		String time25 = formatFullTimeOut4(request.getParameter("hh49"), request.getParameter("mm49"),
				request.getParameter("ss49"), request.getParameter("hh50"), request.getParameter("mm50"),
				request.getParameter("ss50"));
		String time26 = formatFullTimeOut4(request.getParameter("hh51"), request.getParameter("mm51"),
				request.getParameter("ss51"), request.getParameter("hh52"), request.getParameter("mm52"),
				request.getParameter("ss52"));
		String time27 = formatFullTimeOut4(request.getParameter("hh53"), request.getParameter("mm53"),
				request.getParameter("ss53"), request.getParameter("hh54"), request.getParameter("mm54"),
				request.getParameter("ss54"));
		String time28 = formatFullTimeOut4(request.getParameter("hh55"), request.getParameter("mm55"),
				request.getParameter("ss55"), request.getParameter("hh56"), request.getParameter("mm56"),
				request.getParameter("ss56"));
		String time29 = formatFullTimeOut4(request.getParameter("hh57"), request.getParameter("mm57"),
				request.getParameter("ss57"), request.getParameter("hh58"), request.getParameter("mm58"),
				request.getParameter("ss58"));
		String time30 = formatFullTimeOut4(request.getParameter("hh59"), request.getParameter("mm59"),
				request.getParameter("ss59"), request.getParameter("hh60"), request.getParameter("mm60"),
				request.getParameter("ss60"));
		
		if (action.equals("edit")) {
			try{
				String sql = "UPDATE dbtimeon_out4 SET day_type='" + day_type + "', time1='" + time1 + "', time2='"
						+ time2 + "', time3='" + time3 + "', time4='" + time4 + "', time5='" + time5 + "', time6='"
						+ time6 + "', time7='" + time7 + "', time8='" + time8 + "', time9='" + time9 + "', time10='"
						+ time10 + "', time11='" + time11 + "', time12='" + time12 + "', time13='" + time13 + "', time14='" 
						+ time14 + "', time15='" + time15 + "', time16='" + time16 + "', time17='" + time17 + "', time18='" 
						+ time18 + "', time19='" + time19 + "', time20='" + time20 + "', time21='" + time21 + "', time22='" 
						+ time22 + "', time23='" + time23 + "', time24='" + time24 + "', time25='" + time25 + "', time26='" 
						+ time26 + "', time27='" + time27 + "', time28='" + time28 + "', time29='" + time29 + "', time30='" 
						+ time30 + "' WHERE (day_type = '" + day_type + "')";
				resultQry = stmtUp.executeUpdate(sql);
				if (resultQry != 0) {
					if (!(time1.equals(request.getParameter("hidtime1"))
							&& time2.equals(request.getParameter("hidtime2"))
							&& time3.equals(request.getParameter("hidtime3"))
							&& time4.equals(request.getParameter("hidtime4"))
							&& time5.equals(request.getParameter("hidtime5"))
							&& time6.equals(request.getParameter("hidtime6"))
							&& time7.equals(request.getParameter("hidtime7"))
							&& time8.equals(request.getParameter("hidtime8"))
							&& time9.equals(request.getParameter("hidtime9"))
							&& time10.equals(request.getParameter("hidtime10"))
							&& time11.equals(request.getParameter("hidtime11"))
							&& time12.equals(request.getParameter("hidtime12"))
							&& time13.equals(request.getParameter("hidtime13"))
							&& time14.equals(request.getParameter("hidtime14"))
							&& time15.equals(request.getParameter("hidtime15"))
							&& time16.equals(request.getParameter("hidtime16"))
							&& time17.equals(request.getParameter("hidtime17"))
							&& time18.equals(request.getParameter("hidtime18"))
							&& time19.equals(request.getParameter("hidtime19"))
							&& time20.equals(request.getParameter("hidtime20"))
							&& time21.equals(request.getParameter("hidtime21"))
							&& time22.equals(request.getParameter("hidtime22"))
							&& time23.equals(request.getParameter("hidtime23"))
							&& time24.equals(request.getParameter("hidtime24"))
							&& time25.equals(request.getParameter("hidtime25"))
							&& time26.equals(request.getParameter("hidtime26"))
							&& time27.equals(request.getParameter("hidtime27"))
							&& time28.equals(request.getParameter("hidtime28"))
							&& time29.equals(request.getParameter("hidtime29"))
							&& time30.equals(request.getParameter("hidtime30")))) {
						ckActionCmd = "2";
					}
					session.setAttribute("session_alert", msg_editsuccess);
					rc.WriteDataLogFile("[" + ses_user + "] Edit day_type : " + day_type + " [dbtimeon_out4]");
					out.println("<script>document.location='../data_timeonoutput4.jsp';</script>");
				}
			}catch(SQLException e){
				out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
			}
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
				stmtUp.executeUpdate(insertDbStatus(doorID, "39", ipAddr, ckActionCmd, date_updates));
			}catch (SQLException e1){
				stmtUp.executeUpdate(updateDbStatus(doorID, "39", ipAddr, ckActionCmd, date_updates));
			}
		}
		rs.close();
	}	
%>

<%@ include file="../function/disconnect.jsp"%>	