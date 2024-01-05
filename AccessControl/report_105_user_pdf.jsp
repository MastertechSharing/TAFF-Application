<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%	
	session.setAttribute("page_g", "index");
	session.setAttribute("subpage", "home");
	session.setAttribute("subtitle", "viewcalendar");
	
	String getdays = "", getmonth = "", getyear = "", getusername = "";	
	if(request.getParameter("today") != null){
	   getdays = new String(request.getParameter("today").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("month") != null){
		getmonth = new String(request.getParameter("month").getBytes("ISO8859_1"),"tis-620");
	}	
	if(request.getParameter("year") != null){
	   getyear = new String(request.getParameter("year").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("username") != null){
	   getusername = new String(request.getParameter("username").getBytes("ISO8859_1"),"tis-620");
	}	
	session.setAttribute("action", "report_105_user_pdf.jsp?today="+getdays+"&month="+getmonth+"&year="+getyear+"&username="+getusername+"&");	
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			* {box-sizing:border-box;}
			ul {list-style-type: none;}

			.month {
				padding: 5px 25px;
				width: 100%;
				background: #1abc9c;
			}

			.month ul {
				margin: 0;
				padding: 0;
			}

			.month ul li {
				color: white;
				font-size: 20px;
				letter-spacing: 3px;
				text-align: left;
			}
			
			.month-footer {
				padding: 5px 10px;
				width: 100%;
				background: #1abc9c;
			}

			.month-footer ul {
				margin: 0;
				padding: 0;
			}

			.month-footer ul li {
				color: white;
				font-size: 20px;
				letter-spacing: 3px;
			}
			
			.month .prev {
				float: left;
				padding-top: 10px;
			}

			.month .next {
				float: right;
				padding-top: 10px;
			}

			.weekdays {
				margin: 0;
				padding-top: 8px;
				padding-bottom: 3px;
				background-color: #ddd;
			}

			.weekdays li {
				display: inline-block;
				width: 13.6%;
				color: #666;
				text-align: center;
			}

			.days {
				padding: 10px 0;
				background: #eee;
				margin: 0;
			}

			.days li {
				list-style-type: none;
				display: inline-block;
				width: 13.6%;
				text-align: left;
				margin-bottom: 0px;
				font-size: 16px;
				color: #777;
				height: 30px;
			}
			
			.days .active {
				padding: 5px;
				background: #1abc9c;
				color: #585858 !important;
				-webkit-border-radius: 5px;
				-moz-border-radius: 5px;
				background-color: rgba(26, 188, 156, 0.7);
				height: 100%;
			}
		/*	
			.days :hover {
				padding: 5px;
				background: #1abc9c;
				color: white !important;
				-webkit-border-radius: 5px;
				-moz-border-radius: 5px;
				background-color: rgba(26, 188, 156, 0.5);
			} 
		*/
			/* Add media queries for smaller screens */
			@media screen and (max-width:720px) {
				.weekdays li, .days li {width: 13.1%;}
			}

			@media screen and (max-width: 420px) {
				.weekdays li, .days li {width: 13.1%;}
				.days li .active {padding: 2px;}
			}

			@media screen and (max-width: 290px) {
				.weekdays li, .days li {width: 12.2%;}
			}
			
			.font-time-duty {
				color: #EF2020;
				font-size: 15px;
				text-align: left !important;
				font-weight: bold;
			}
			
			.font-time-default {
				font-size: 15px;
				text-align: left !important;
			}
			
			.font-holiday {
				color: #EF2020;
				font-size: 16px;
				text-align: left !important;
				font-weight: bold;	
			}
		</style>
		
		<script>
			function reportToexcel(lang){
				var empid = document.form1.empid.value;	
				var rdfunc = document.form1.rdfunc.value;
				var today = document.form1.today.value;
				var month = document.form1.month.value;
				var year = document.form1.year.value;
				location.href = 'report_105_user_excel.jsp?month='+month+'&today='+today+'&year='+year+'&username='+empid+'&readerfunc='+rdfunc+'&';
			}
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/> <p>
		
<%  				 
	String emp_id = request.getParameter("username");
	String reader = "all";
	if(request.getParameter("reader") != null){
		reader = request.getParameter("reader");
	}
	String[] reader_value;
	String dfToday = "";
	String dfYear  = "";
	String dfMonth = "";
	int today = 0;
	int month = 0;
	int year = 0;
	String dd = "";
	String mm = "";
	String yyyy = "";
	String date_str = "";
	
	if(request.getParameter("today") != null){
		dfToday = request.getParameter("today");
	}
	if(request.getParameter("month") !=null){
		dfMonth = request.getParameter("month");
	}
	if(request.getParameter("year") != null){
		dfYear = request.getParameter("year");
	}
	
	if(dfMonth == ""){		
		date_str = getCurrentDate();
		dd = date_str.substring(0, 2);
		mm = date_str.substring(3, 5);
		yyyy = date_str.substring(6, 10);
		today = Integer.parseInt(dd);     
		month = Integer.parseInt(mm);    
		year = Integer.parseInt(yyyy);   		
	}else{
		dd = dfToday;				
		if(dfMonth.equals("0")){
			year = Integer.parseInt(dfYear);
			mm = "12";
			year = year - 1;
			yyyy = Integer.toString(year);		
		}else if(dfMonth.equals("13")){
			year = Integer.parseInt(dfYear);
			mm = "1";
			year = year + 1;
			yyyy = Integer.toString(year);
		}else{
			mm = dfMonth;
			yyyy = dfYear;
		}				
		today = Integer.parseInt(dd);				
		if(today < 10){
			dd = "0"+dd;
		}		
		month = Integer.parseInt(mm);
		if(month < 10){
			mm = "0"+mm;
		}				
		year = Integer.parseInt(yyyy);   
	}
	date_str = mm+"/"+01+"/"+yyyy;
	
	String report_id = "105";
	/*try{
		stmtUp.executeUpdate(insertReport(report_id));
	}catch(SQLException e){}
	*/
	
	String TempName = "tmp"+report_id+"_"+getIP(request.getRemoteAddr());
	try{
		stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
		stmtUp.executeUpdate(createTableTmpReport(db_database,TempName,report_id,mode));
	}catch(SQLException e){
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
	}		
	
	String comp_desc = "";
	String time_in = "";
	String time_out = "";
	String getrdf = "";
	//แสดงเวลาเข้า-ออก จริงของบริษัท
	ResultSet rs = stmtQry.executeQuery("SELECT th_desc, en_desc, time_in, time_out,readerf FROM dbcompany");
	rs.next();
	if(lang.equals("th")){
		comp_desc = rs.getString("th_desc");
	}else{
		comp_desc = rs.getString("en_desc");
	}
	time_in = rs.getString("time_in");
	time_out = rs.getString("time_out");
	getrdf = Integer.toString(rs.getInt("readerf"));
	rs.close();
		
		String sql = "";
		if(mode == 0){
			sql = "SELECT MIN(CONCAT(trs.time_event,' [ ',trs.duty,' ] ',trs.reader_no)) AS min_time, "
					+ "MAX(CONCAT(trs.time_event,' [ ',trs.duty,' ] ',trs.reader_no)) AS max_time, "
					+ "DATE_FORMAT(trs.date_event,'%d/%m/%Y') AS date_work, DAYOFWEEK(trs.date_event) AS day_work ";
		}else{
			sql = "SELECT MIN(trs.time_event+' [ '+trs.duty+' ] '+trs.reader_no) AS min_time, "
					+ "MAX(trs.time_event+' [ '+trs.duty+' ] '+trs.reader_no) AS max_time, "
					+ "CONVERT(varchar(10),trs.date_event,103) AS date_work, DATEPART(dw, trs.date_event) AS day_work ";
		}
		sql = sql + "FROM dbtransaction trs LEFT JOIN dbreader rd ON (rd.reader_no = trs.reader_no) "
				+ "WHERE (trs.idcard = '"+emp_id+"') AND (year(trs.date_event) = '"+year+"') "
				+ "AND (month(trs.date_event) = '"+mm+"') ";
		if(!(getrdf == null || getrdf.equals("") || getrdf.equals("null"))){
			if(getrdf.equals("0")){
				sql = sql + "AND (rd.reader_func = '0') ";
			}else if(getrdf.equals("1")){
				sql = sql + "AND (rd.reader_func = '1') ";
			}
		}	
		if(!(reader == null || reader.equals("") || reader.equals("null") || reader.equals("all"))){
			sql = sql + "AND (";
			reader_value = reader.split(",");
			for(int i = 0; i < reader_value.length; i++){
				sql = sql + " (trs.reader_no = '"+reader_value[i]+"') ";
				if(i != reader_value.length - 1){
					sql = sql + "OR";
				}
			}
			sql = sql + ") ";
		}
		sql = sql + "GROUP BY date_event ORDER BY date_event, min_time, max_time";
		
	String date_work = "";
	String day_work = "";
	String mintime = "";
	String maxtime = "";
	String reader1 = "";
	String reader2 = "";
	int count_id = 0;
	String sqlTmp = "";
	rs = stmtQry.executeQuery(sql);	
	while(rs.next()){
		count_id++;
		date_work = rs.getString("date_work");
		day_work = rs.getString("day_work");
		mintime = rs.getString("min_time").substring(0,14); 
		maxtime = rs.getString("max_time").substring(0,14);	
		reader1 = rs.getString("min_time").substring(15,20);
		reader2 = rs.getString("max_time").substring(15,20);
		sqlTmp = "INSERT INTO "+TempName+" (id,id_card,date_work,day_work,reader1,min_time,"
					+"reader2,max_time) VALUES ('"+count_id+"','"+emp_id+"','"+date_work+"','"
					+day_work+"','"+reader1+"','"+mintime+"','"+reader2+"','"+maxtime+"')";	
		try{
			stmtUp.executeUpdate(sqlTmp);
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
	}
	rs.close();
	
	String id_name = "";
	String sec_desc = "";
	sql = "SELECT emp.idcard, emp.th_fname, emp.th_sname, emp.en_fname, emp.en_sname, emp.sec_code, sec.th_desc, sec.en_desc "
			+ "FROM dbemployee emp LEFT OUTER JOIN dbsection sec ON (sec.sec_code = emp.sec_code) "
			+ "WHERE (emp.idcard = '"+emp_id+"')";
	rs = stmtQry.executeQuery(sql);
	rs.next();
	if(lang.equals("th")){
		id_name = rs.getString("th_fname")+" "+rs.getString("th_sname");
		sec_desc = rs.getString("sec_code")+" - "+rs.getString("th_desc");
	}else{	  
		id_name = rs.getString("en_fname")+" "+rs.getString("en_sname");	
		sec_desc = rs.getString("sec_code")+" - "+rs.getString("en_desc");			
	}
	rs.close();
	
	String set_class_act = "", font_tag_a = "";
	if(Integer.parseInt(getCurrentDate().substring(3, 5)) == Integer.parseInt(mm) && 
		Integer.parseInt(getCurrentDate().substring(6)) == Integer.parseInt(yyyy) ){
		set_class_act = "class='active'";
		font_tag_a = "style='color: white !important;'";
	}	
%>		
		<form name="form1" id="form1" method="post">
		
		<div class="body-display">
			<div class="container">
	  
				<div class="table-responsive" style="border: 0px !important; margin-bottom: -25px; margin-left: -15px; margin-right: -15px;" border="0">
					<div style="min-width: 1150px;" class="table" border="0">

						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">
								
								<div class="bs-callout bs-callout-info"> 
									<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
										<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-calendar"> </i> &nbsp; <%= lb_report_105 %> </label>
										
										<input type="hidden" name="empid" id="empid" value="<%= emp_id %>">
										<input type="hidden" name="today" id="today" value="<%= getdays %>">
										<input type="hidden" name="month" id="month" value="<%= month %>">
										<input type="hidden" name="year" id="year" value="<%= year %>">
										<input type="hidden" name="rdfunc" id="rdfunc" value="<%= getrdf %>">
									</div>
									<p>
									<div class="row">
										<label class="modal-title col-xs-6 col-md-6"> &nbsp; &nbsp; <%= lb_empcode +" : "+emp_id+" - "+id_name %> </label>
										<label class="modal-title col-xs-6 col-md-6" align="right"> <%= lb_sect+" : "+sec_desc %> &nbsp; &nbsp; </label>
									</div>
									<p>
									<div class="row">
										<center>
											<div class="month" style="max-width: 95% !important;">
												<ul>
													<li class="prev" data-toggle="tooltip" data-placement="right" title="<% if(month == 1){ out.print(getLongMonth(12, lang)); }else{ out.print(getLongMonth(month -1, lang)); } %>"> 
														<a href="report_105_user_pdf.jsp?month=<%= (month-1) %>&today=<%= getdays %>&year=<%= yyyy %>&username=<%= emp_id %>&reader=all&readerfunc=<%= getrdf %>"> &#10094; </a> 
													</li>
													<li class="next" data-toggle="tooltip" data-placement="left" title="<% if(month == 12){ out.print(getLongMonth(1, lang)); }else{ out.print(getLongMonth(month +1, lang)); } %>"> 
														<a href="report_105_user_pdf.jsp?month=<%= (month+1) %>&today=<%= getdays %>&year=<%= yyyy %>&username=<%= emp_id %>&reader=all&readerfunc=<%= getrdf %>"> &#10095; </a> 
													</li>
													<li style="text-align: center;"> <span style="font-size: 30px;"> <%= getLongMonth(month, lang) %> <%= year %> </span> </li>
												</ul>
											</div>
											<ul class="weekdays" style="max-width: 95% !important;">
										<%	for(int i = 1; i <= 7; i++){	%>
												<li> <label> <%= getDay(i, lang) %> </label> </li>					
										<%	}	%>	
											</ul>
											<ul class="days" style="max-width: 95% !important;">
	<%
			String won_date[] = {"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
			String won = validateDate3(date_str,"MM/dd/yyyy");
			int k;
			for(k=0; k<=won_date.length; k++){
				if(won_date[k].equals(won.substring(0, 3))){
					break;
				}
			}			
			int iday = 1;
			int i = 0;
			int Lday = LastDay(mm,yyyy ,"MM/dd/yyyy");
			
			//เลือกวันที่มีวันหยุดของ ปี-เดือน ขึ้นมา
			if(mode == 0){
				sql = "SELECT holi_date, ";						
			}else{
				sql = "SELECT convert(varchar(10),holi_date) AS holi_date, ";
			}
			sql += "th_desc, en_desc FROM dbholiday WHERE (year(holi_date) = '"+yyyy+"') AND (month(holi_date) = '"+mm+"') ";
			
			ResultSet rs_holi = null;
			String day = "";		
			String holi_date = "";
			String holi_desc = "";
			String dateSql = "";
			String data = "";					
			String displayBR = "<br/><br/><br/>";			
			String tmpcal = "select * FROM "+TempName;
			for(i=0; i<=6; i++){      
				if(iday<10){                     
					day = "0"+iday;							
				}
				dateSql = yyyy+"-"+mm+"-"+day;			
				
				try{	
					holi_date = "";
					holi_desc = "";
					rs_holi = stmtQry.executeQuery(sql+"AND (day(holi_date)= '"+day+"')");
					while(rs_holi.next()){
						holi_date = rs_holi.getString("holi_date");
						if(lang.equals("th")){
							holi_desc = rs_holi.getString("th_desc");
						}else{
							holi_desc = rs_holi.getString("en_desc");
						}
					}
					rs_holi.close();
					if(dateSql.equals(holi_date)){
						data = "<span class='font-holiday'>"+holi_desc+"</span><br/><br/><br/>"; // แสดงรายละเอียดวันของวันหยุดนั้นๆ
					}else{
						data = displayBR;
					}
					
					rs = stmtQry.executeQuery(tmpcal);
					while(rs.next()){
						date_work = dateToYMD(rs.getString("date_work"));
						if(time_in.compareTo(rs.getString("min_time")) < 0){
							mintime = "<span class='font-time-duty'>"+ rs.getString("min_time")+"</span>";
						}else{
							mintime = "<span class='font-time-default'>"+ rs.getString("min_time")+"</span>";
						}
						if(time_out.compareTo(rs.getString("max_time")) > 0){
							maxtime = "<span class='font-time-duty'>"+ rs.getString("max_time")+"</span>";
						}else{
							maxtime = "<span class='font-time-default'>"+ rs.getString("max_time")+"</span>";
						}
						if(rs.getString("max_time").equals(rs.getString("min_time"))){
							maxtime = " ";
						}
						
						//ถ้าวันที่ในเดือนๆนี้เท่ากับวันที่ใน transaction ที่มีการเข้า-ออก
						//ถ้าปฏิทินมีวันที่ตรงกับ วันที่ในทรานเซกชั่น
						if(dateSql.equals(date_work)){
							if((mintime.equals(""))||(mintime.equals("null"))){
								mintime = "<span class='font-time-duty'>"+lb_nodata+"</span>";
								if((maxtime.equals(""))||(maxtime.equals("null"))){
									maxtime = "<span class='font-time-duty'>"+lb_nodata+"</span>";
								}
							}else if((maxtime.equals(""))||(maxtime.equals("null"))){
								maxtime = "<span class='font-time-duty'>"+lb_nodata+"</span>";
								if((mintime.equals(""))||(mintime.equals("null"))){
									mintime = "<span class='font-time-duty'>"+lb_nodata+"</span>";
								}
							}
							if(date_work.equals(holi_date)){
								if(!(mintime.equals("") || maxtime.equals(""))){
									data = "<span class='font-holiday'>"+holi_desc+"</span><br/>"+lb_statusin+" "+mintime+"<br/>"+lb_statusout+" "+maxtime;
									break;
								}else{
									data = displayBR;
								}
							}else{
								data = "<br/>"+lb_statusin+" "+mintime+"<br/>"+lb_statusout+" "+maxtime;
								break;
							}
						}else{ // ถ้าไม่มีวันที่ ที่ตรงกับทรานแซกชั่น ก็เช็คที่แฟ้มวันหยุดว่ามีข้อมูลไหม ถ้ามีก็ให้แสดงรายละเอียดขอวันหยุด
							if(dateSql.equals(holi_date)){
								if(date_work.equals(holi_date)){
									if(!(mintime.equals("") || maxtime.equals(""))){
										data = "<span class='font-holiday'>"+holi_desc+"</span><br/>"+lb_statusin+" "+mintime+"<br/>"+lb_statusout+" "+maxtime;
										break;
									}
								}else{
									data = "<span class='font-holiday'>"+holi_desc+"</span>"+displayBR;
								}
							}else{
								data = displayBR;
							}
						}
					}//while(rs.next())
					rs.close();
				}catch(SQLException e) {
					out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
				}
				
				if(i < k){
					out.print("<li> &nbsp; </li>");
				}else{
					/*if(data.equals("")){
						data = displayBR;
					}*/
					if((i == 0) && (iday != today)){
						out.print("<li> <label>"+iday+"</label> &nbsp; "+data+" </li>");
					}else if(i == 0 && (iday == today)){
						out.print("<li "+set_class_act+"> <label>"+iday+"</label> &nbsp; "+data+" </li>");
					}else if(iday == today){
						out.print("<li "+set_class_act+"> <label>"+iday+"</label> &nbsp; "+data+" </li>");
					}else{
						out.print("<li> <label>"+iday+"</label> &nbsp; "+data+" </li>");
					}
					iday++;
				}
			}
			
			for(int j=0; j<=4; j++){
				if(iday <= Lday){
					out.print("<tr>\n");
					for(i=0; i<=6; i++){
						if(iday<10){
							day = "0"+iday;
						}else{
							day = Integer.toString(iday);
						}			
						dateSql = yyyy+"-"+mm+"-"+day;
						//หาค่าวันหยุดที่มีในดาต้าเบส
						try{
							holi_date = "";
							holi_desc = "";
							rs_holi = stmtQry.executeQuery(sql+"AND (day(holi_date)= '"+day+"')");
							while(rs_holi.next()){
								holi_date = rs_holi.getString("holi_date");
								if(lang.equals("th")){
									holi_desc = rs_holi.getString("th_desc");
								}else{
									holi_desc = rs_holi.getString("en_desc");
								}
							}
							rs_holi.close();
							if(dateSql.equals(holi_date)){
								data = "<span class='font-holiday'>"+holi_desc+"</span><br/><br/><br/>"; // แสดงรายละเอียดวันของวันหยุดนั้นๆ
							}else{
								data = displayBR;
							}
						
							rs = stmtQry.executeQuery(tmpcal);
							while(rs.next()){
								date_work = dateToYMD(rs.getString("date_work"));
								//เปรียบเวลาเข้าออกของพนักงาน กับ เวลาเข้า-ออกจริงของบริษัท
								if(time_in.compareTo(rs.getString("min_time")) < 0){//ถ้าเวลาเข้าของบริษัทน้อยกว่าเวลาเข้าจริง
									mintime = "<span class='font-time-duty'>"+ rs.getString("min_time")+"</span>";
								}else{
									mintime = "<span class='font-time-default'>"+ rs.getString("min_time")+"</span>";
								}
								if(time_out.compareTo(rs.getString("max_time")) > 0){
									maxtime = "<span class='font-time-duty'>"+ rs.getString("max_time")+"</span>";
								}else{
									maxtime = "<span class='font-time-default'>"+ rs.getString("max_time")+"</span>";
								}
								if(rs.getString("max_time").equals(rs.getString("min_time"))){
									maxtime = " ";
								}
								//ถ้าปฏิทินมีวันที่ตรงกับ วันที่ในทรานเซกชั่น	
								if(dateSql.equals(date_work)){
									if((mintime.equals(""))||(mintime.equals("null"))){
										mintime = "<span class='font-time-duty'>"+lb_nodata+"</span>";
										if((maxtime.equals(""))||(maxtime.equals("null"))){
											maxtime = "<span class='font-time-duty'>"+lb_nodata+"</span>";
										}
									}else if((maxtime.equals(""))||(maxtime.equals("null"))){
										maxtime = "<span class='font-time-duty'>"+lb_nodata+"</span>";
										if((mintime.equals(""))||(mintime.equals("null"))){
											mintime = "<span class='font-time-duty'>"+lb_nodata+"</span>";
										}
									}
									if(date_work.equals(holi_date)){
										if(!(mintime.equals("") || maxtime.equals(""))){
											data = "<span class='font-holiday'>"+holi_desc+"</span><br/>"+lb_statusin+" "+mintime+"<br/>"+lb_statusout+" "+maxtime;
											break;
										}else{
											data = displayBR;
										}
									}else{
										data = "<br/>"+lb_statusin+" "+mintime+"<br/>"+lb_statusout+" "+maxtime;
										break;
									}
								}else{ // ถ้าไม่มีวันที่ ที่ตรงกับทรานแซกชั่น ก็เช็คที่แฟ้มวันหยุดว่ามีข้อมูลไหม ถ้ามีก็ให้แสดงรายละเอียดขอวันหยุด
									if(dateSql.equals(holi_date)){
										if(date_work.equals(holi_date)){
											if(!(mintime.equals("") || maxtime.equals(""))){
												data = "<span class='font-holiday'>"+holi_desc+"</span><br/>"+lb_statusin+" "+mintime+"<br/>"+lb_statusout+" "+maxtime;
												break;
											}
										}else{
											data = "<span class='font-holiday'>"+holi_desc+"</span>"+displayBR;
										}
									}else{
										data = displayBR;
									}
								}
							}//while(rs.next())
							rs.close();
						}catch(SQLException e){
							out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
						}	
						if(iday <= Lday){
							if(i == 0 && (iday != today)){
								out.print("<li> <label>"+iday+"</label> &nbsp; "+data+" </li>");
							}else if(i == 0 && (iday == today)){
								out.print("<li "+set_class_act+"> <label>"+iday+"</label> &nbsp; "+data+" </li>");
							}else if(iday == today){
								out.print("<li "+set_class_act+"> <label>"+iday+"</label> &nbsp; "+data+" </li>");
							}else{
								out.print("<li> <label>"+iday+"</label> &nbsp; "+data+" </li>");
							}
							iday++;
						}else{
							out.print("<li> &nbsp; </li>");	
						}
					}//for
					out.print("</tr>\n");
				}else{
					break;
				}
			}//for
		%>

											</ul>
											<div class="month-footer" style="max-width: 95% !important;">
												<ul>
													<li align="center"> <%= lb_calrepost %> <img src="images/excelimg.png" width="24" height="24" onclick="reportToexcel('<%= lang %>')" data-toggle="tooltip" data-placement="right" title="Excel"> </li>
												</ul>
											</div>
											
										</center>
									</div>
								</div>
							</div>
						</div>
					
					</div>
				</div>
				
			</div>
		</div>
	  
		</form>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>