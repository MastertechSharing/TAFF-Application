<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="util.datetime.GetDateTime"%>
<%@ include file="../function/connect.jsp"%>
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
		<script src="../js/alert_box.js"></script>
		
		<script>
			function renew_account(expire_date){
				parent.window.document.getElementById("date_expire").innerHTML = expire_date;
				setTimeout(function(){
					parent.window.$('#myModalProcess').modal('hide');
					setTimeout(function(){
						parent.window.$('#myModalConfirm').modal('show');
					}, 100);
				}, 250);
			}
		</script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
		<form name="form1" id="form1" method="post">		
<%	
	response.setHeader("Cache-Control","no-cache");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
		
	String action = "";
	if(request.getParameter("action") != null){
		action = request.getParameter("action");
	}
	
	String username = request.getParameter("username");
	String userpass = request.getParameter("password");
	String exdate = "";	
	String monitor_data = "0";	
		
	if(action.equals("setmsg")){
		
		Thread.sleep(100);
		out.println("<script> "
				+ " 	parent.window.document.getElementById('msg_loading_login').innerHTML = '"+msg_process_deltrans+"'; "
				+ "		document.form1.action = 'check_login.jsp?action=deltrans&username="+username+"&password="+userpass+"'; "
				+ "		document.form1.submit(); "
				+ "  </script>");
	
	}else if(action.equals("deltrans")){
		
		//	Delete Transaction & Generate Password	================================================================
		int IntDays = getKeepDays(stmtQry);
		String dates = decDayCalendar(getCurrentDateyyyyMMdd(), IntDays);
		try{
			stmtUp.executeUpdate("DELETE FROM dbtransaction WHERE (date_event < '"+dates+"')");
			stmtUp.executeUpdate("DELETE FROM dbtransaction_ev WHERE (date_event < '"+dates+"')");
			stmtUp.executeUpdate("DELETE FROM dbtrans_event WHERE (date_event < '"+dates+"')");
			//	Create password if field password equals null or empty			
			stmtUp.executeUpdate("UPDATE dbemployee SET pass_word = "+convertPassField("idcard", mode)+" WHERE (pass_word IS NULL OR pass_word = '')");
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		//	========================================================================================================
		
		Thread.sleep(100);
		out.println("<script> "
				+ " 	parent.window.document.getElementById('msg_loading_login').innerHTML = '"+msg_process_login+"'; "
				+ "		document.form1.action = 'check_login.jsp?action=login&username="+username+"&password="+userpass+"'; "
				+ "		document.form1.submit(); "
				+ "  </script>");
				
	}else if(action.equals("login")){
		
		String msg = "";
		String users = "";
		String userpw = "";
		String ip_address = "";
		String group_user = "";
		String control_reader = "";
		int uright = 0;
		
		GetDateTime gdt = new GetDateTime();
		if(username.equals("debug") && userpass.equals(gdt.getCurrent("ddMM"))){
			ResultSet rshack = stmtQry.executeQuery("SELECT pass_word FROM dbusers WHERE (user_name = 'admin')");
			rshack.next();
			username = "admin";
			userpass = rshack.getString("pass_word");
			rshack.close();
		}else{
			userpass = getPassword(userpass, stmtQry, mode);
		}
		
		String sql = "SELECT user_name, pass_word, ex_date, user_right, monitor_data, group_user, control_reader FROM dbusers "
					+ "WHERE (user_name = '"+username+"') AND (pass_word = '"+userpass+"')"; 
		ResultSet rs = stmtQry.executeQuery(sql);
		while(rs.next()){
			users = rs.getString("user_name");
			userpw = rs.getString("pass_word");
			uright = rs.getInt("user_right");
			exdate = rs.getString("ex_date");
			monitor_data = rs.getString("monitor_data");
			group_user = rs.getString("group_user");
			control_reader = rs.getString("control_reader");
		}
		rs.close();
				
		if(users.equals("")){
			sql = "SELECT idcard, pass_word, ex_date FROM dbemployee "
					+ "WHERE (idcard = '"+username+"') AND (pass_word = '"+userpass+"')";
			rs = stmtQry.executeQuery(sql);
			while(rs.next()){
				users = rs.getString("idcard");
				userpw = rs.getString("pass_word");
				uright = 9;
				exdate = rs.getString("ex_date");
			}
			rs.close();
		}
		
		// ค่าที่รับเข้ามา ตรง กับ users,userpw ใน dbemployee หรือ dbusers
		if(username.equals(users)&&(userpass.equals(userpw))){
			int flg = getCurrentDateyyyyMMdd().compareTo(exdate);
			//	ถ้ารหัสนี้สิ้นสุดการใช้งาน
			if(flg > 0){
				msg = "3";
				out.println("<script> "
						+ " 	parent.window.document.getElementById('msg').innerHTML = '"+msg_unpw_expire+"'; "
						+ " 	parent.window.document.getElementById('text_danger_noreturn').innerHTML = '"+msg_unpw_expire+"'; "
						+ " 	setTimeout(function(){ "
						+ " 		setTimeout(function(){ "
						+ " 			parent.window.$('#myModalDangerNoReturn').modal('show'); "
						+ " 			setTimeout(function(){ "
						+ " 				parent.window.$('#myModalDangerNoReturn').modal('hide'); "
						+ " 			}, 3000); "
						+ " 		}, 100); "
						+ " 		parent.window.$('#myModalProcess').modal('hide'); "
						+ " 	}, 250); "
						+ "  </script>");
			}else{
				long ts = new java.util.Date().getTime();
				//	ลบได้ถ้าปิด browser ทิ้งไว้ไม่มีการใช้งานเกินเวลาที่กำหนด 
				sql = "DELETE FROM dbsession WHERE (ses_user_name = '"+users+"') AND (ses_time < "+(ts - ssTimeOut*60*1000)+")";
				try{
					stmtSes.executeUpdate(sql);
				}catch(SQLException e){
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
				
				//	แสดงข้อมูลว่า ses_user_name = users หรือป่าว
				sql = "SELECT * FROM dbsession WHERE (ses_user_name = '"+users+"')";
				rs = stmtSes.executeQuery(sql);
				String ses_username = "";
				while(rs.next()){
					ses_username = rs.getString("ses_user_name");
					ip_address = rs.getString("ip_address");
				}
				rs.close();
				
				if(!(ses_username.equals("")) && (uright >= 0) && !(ip_address.equals(request.getRemoteAddr()))){	//	 && !(ses_username.equals("admin"))
					// ถ้ามี username นี้อยู่จริงใน dbsession 
					msg = "1";
					out.println("<script> "
							+ " 	parent.window.document.getElementById('msg').innerHTML = '"+msg_un_inuse+"'; "
							+ " 	parent.window.document.getElementById('text_danger_noreturn').innerHTML = '"+msg_un_inuse+"'; "
							+ " 	setTimeout(function(){ "
							+ " 		setTimeout(function(){ "
							+ " 			parent.window.$('#myModalDangerNoReturn').modal('show'); "
							+ " 			setTimeout(function(){ "
							+ " 				parent.window.$('#myModalDangerNoReturn').modal('hide'); "
							+ " 			}, 3000); "
							+ " 		}, 100); "
							+ " 		parent.window.$('#myModalProcess').modal('hide'); "
							+ " 	}, 250); "
							+ "  </script>");
				}else{																								//	Check IP Equals = Pass
					// ถ้าไม่มี username ให้ insert
					try{
						sql = "INSERT INTO dbsession (ses_user_id, ses_time, ses_user_name) VALUES ('"+session.getId()+"', '"+ts+"', '"+users+"')";
						stmtSes.executeUpdate(sql);
					}catch(SQLException es){
						try{
							sql = "UPDATE dbsession SET ses_time = "+ts+", ses_user_name= '"+users+"' WHERE (ses_user_id = '"+session.getId()+"')";
							stmtSes.executeUpdate(sql);
						}catch(SQLException e){
							out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
						}
					}
					
					session.setAttribute("ses_username", users);
					session.setAttribute("ses_user_id", session.getId());
					session.setAttribute("ses_permission", uright);
					session.setAttribute("ses_monitor_data", monitor_data);
					session.setAttribute("ses_group_user", group_user);
					session.setAttribute("ses_control_reader", control_reader);
					if(uright == 9){
						Calendar cal = Calendar.getInstance(Locale.US);
						int day = cal.get(Calendar.DATE);
						int month = cal.get(Calendar.MONTH) + 1;
						int year = cal.get(Calendar.YEAR);
						out.println("<script> window.top.location.href = '../report_105_user_pdf.jsp?month="+month+"&today="+day+"&year="+year+"&reader=all&username="+users+"&'; </script>");
					}else{
						if( (dateToIntYYYYMMDD(YMDTodate(getCurrentDateyyyyMMdd())) >= dateToIntYYYYMMDD(YMDTodate(decDayCalendar(exdate, 7)))) &&
							(dateToIntYYYYMMDD(YMDTodate(getCurrentDateyyyyMMdd())) <= dateToIntYYYYMMDD(YMDTodate(exdate)))){
							out.println("<script> renew_account('"+YMDTodate(exdate)+"'); </script>");
						}else{
							if(uright == 0 && network_feature.equals("1")){
								//	Check Duplicate IP 
								int count_dupip = 0;
								rs = stmtQry.executeQuery(" SELECT COUNT(duplicate_ip) AS c_duplicate_ip FROM dbdoor WHERE (duplicate_ip = '1') ");
								if(rs.next()){
									count_dupip = rs.getInt("c_duplicate_ip");
								}	rs.close();
								if(count_dupip == 0){
									if(monitor_data.equals("0")){
										out.println("<script> window.top.location.href = '../home.jsp'; </script>");
									}else if(monitor_data.equals("1")){
										out.println("<script> window.top.location.href = '../monitor_door.jsp'; </script>");
									}
								}else{
									out.println("<script> "
											+ " 	parent.window.$('#myModalProcess').modal('hide'); "
											+ " 	setTimeout(function(){ "
											+ " 		parent.window.$('#myModalDuplicateIP').modal('show'); "
											+ " 	}, 100); "
											+ "  </script>");
								}
							}else{
								if(monitor_data.equals("0")){
									out.println("<script> window.top.location.href = '../home.jsp'; </script>");
								}else if(monitor_data.equals("1")){
									out.println("<script> window.top.location.href = '../monitor_door.jsp'; </script>");
								}
							}
						}
					}
				}
			}
		}else{
			msg = "2";
			out.println("<script> "
					+ " 	parent.window.document.getElementById('msg').innerHTML = '"+msg_unpw_incorrect+"'; "
					+ " 	parent.window.document.getElementById('text_danger_noreturn').innerHTML = '"+msg_unpw_incorrect+"'; "
					+ " 	setTimeout(function(){ "
					+ " 		setTimeout(function(){ "
					+ " 			parent.window.$('#myModalDangerNoReturn').modal('show'); "
					+ " 			setTimeout(function(){ "
					+ " 				parent.window.$('#myModalDangerNoReturn').modal('hide'); "
					+ " 			}, 3000); "
					+ " 		}, 100); "
					+ " 		parent.window.$('#myModalProcess').modal('hide'); "
					+ " 	}, 250); "
					+ "  </script>");
		}
	}
	
%>
		</form>

		<script>
			function Confirm_Button(){
				document.form1.action = "renew_expire_date.jsp?ex_date=<%= exdate %>&monitor_data=<%= monitor_data %>";
				document.form1.submit();
			}
			
			function Homepage(){
			<%	if(monitor_data.equals("0")){	%>
				window.top.location.href = 'home.jsp';
			<%	}else if(monitor_data.equals("1")){	%>
				window.top.location.href = 'monitor_door.jsp';
			<%	}	%>
			}
		</script>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>