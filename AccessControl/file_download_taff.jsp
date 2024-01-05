<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%	
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "download");
	session.setAttribute("subtitle", "downloadtaff");       
	session.setAttribute("action", "file_download_taff.jsp?");
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<script language="javascript" src="js/alert_box.js"></script> 
		
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
				text-transform: uppercase;
				letter-spacing: 3px;
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
				text-align: center;
				margin-bottom: 0px;
				font-size: 16px;
				color: #777;
				height: 30px;
			}

			.days .active {
				padding: 5px;
				background: #1abc9c;
				color: white !important;
				-webkit-border-radius: 5px;
				-moz-border-radius: 5px;
				background-color: rgba(26, 188, 156, 1);
			}

		/*	.days :hover {
				padding: 5px;
				background: #1abc9c;
				color: white !important;
				-webkit-border-radius: 5px;
				-moz-border-radius: 5px;
				background-color: rgba(26, 188, 156, 0.5);
			} 	*/

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
		</style>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container">
			
			<%	
			/* $diffHour และ $diffMinute คือตัวแปรที่ใช้เก็บจำนวนชั่วโมงและจำนวนนาทีที่
			   แตกต่างกันระหว่างเครื่องไคลเอนต์กับเครื่องเซิร์ฟเวอร์ ตามลำดับ เช่นถ้าเวลาของ
			   เครื่องไคลเอ็นต์เร็วกว่าเวลาของเครื่องเซิร์ฟเวอร์ 11 ชั่วโมง 15 นาที ก็ให้กำหนด 
			   $diffHour เป็น 11 และกำหนด $diffMinute เป็น 15 ในที่นี้ผู้เขียนถือว่า
			   เครื่องเซิร์ฟเวอร์กับเครื่องไคลเอ็นต์มีเวลาตรงกัน */
			  
				int diffHour = 0, diffMinute = 0;
				String dfToday = "", dfYear  = "", dfMonth = "";
				int Lday = 0, today = 0, month = 0, year = 0;
				String dd = "", mm = "", yyyy = "", won = "", sub = "", date_str = "";
				String won_date[] ={"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
				
				if(request.getParameter("today") != null){
					dfToday = request.getParameter("today");
				}
				if(request.getParameter("month") != null){
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
				Lday = LastDay(mm,yyyy ,"MM/dd/yyyy");
				won = validateDate3(date_str,"MM/dd/yyyy");
				sub = won.substring(0, 3);
				
				int k;	
				for(k = 0; k <= won_date.length; k++){
					if(won_date[k].equals(sub)){
						break;
					}
				}
				
				String set_class_act = "", font_tag_a = "";
				if(Integer.parseInt(getCurrentDate().substring(3, 5)) == Integer.parseInt(mm) && 
					Integer.parseInt(getCurrentDate().substring(6)) == Integer.parseInt(yyyy) ){
					set_class_act = "class='active'";
					font_tag_a = "style='color: white !important;'";
				}
				
			%>
	  
				<div class="table-responsive" style="border: 0px !important; margin-bottom: -25px; margin-left: -15px; margin-right: -15px;" border="0">
					<div style="min-width: 550px;" class="table" border="0">

						<div class="row" style="margin-left: 0px; margin-right: 0px;">
							<div class="modal-title col-xs-12 col-md-12">
								
								<div class="bs-callout bs-callout-info"> 
									<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
										<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-calendar"> </i> &nbsp; <%= lb_downloaddata %> </label>
									</div>
									<p>
									<div class="row">
										<center>
											<div class="month" style="max-width: 95% !important;">
												<ul>
													<li class="prev"> <a href="file_download_taff.jsp?month=<%= (month-1) %>&today=<%= Integer.parseInt(dd) %>&year=<%= yyyy %>"> &#10094; </a> </li>
													<li class="next"> <a href="file_download_taff.jsp?month=<%= (month+1) %>&today=<%= Integer.parseInt(dd) %>&year=<%= yyyy %>"> &#10095; </a> </li>
													<li align="center"> <span style="font-size: 30px;"> <%= getLongMonth(month, lang) %> <%= year %> </span> </li>
												</ul>
											</div>
											<ul class="weekdays" style="max-width: 95% !important;">
											<%	for(int i = 1; i <= 7; i++){	%>
												<li> <label> <%= getDay(i, lang) %> </label> </li>
											<%	}	%>											
											</ul>
											<ul class="days" style="max-width: 95% !important;">											
										<%	
											int iday = 1;	
											int i = 0;
											String file_href = "", d = "";
											
											for(i = 0; i <= 6; i++){
												if(iday < 10){
													d = "0"+iday;
												}
											 
												if(i < k){  
													if(i == 0){     
														out.print("<li> &nbsp; </li>");
													}else if(i == 6){
														out.print("<li> &nbsp; </li>");
													}else{            
														out.print("<li> &nbsp; </li>");
													}
												}else{
													file_href = path_taff+yyyy+"\\"+mm+"\\"+yyyy+mm+d+".taf&namefile="+yyyy+mm+d+".taf&lang="+lang;
													file_href = file_href.replace('\\', '?');
													
													if(i == 0 && (iday != today)){ 
														out.print("<li> <a href='DownloadTAFFile.do?file="+file_href+"'>"+iday+"</a> </li>");
													}else if(iday == today){
														out.print("<li "+set_class_act+"> <a href='DownloadTAFFile.do?file="+file_href+"' "+font_tag_a+">"+iday+"</a> </li>");
													}else if(i == 6){
														out.print("<li> <a href='DownloadTAFFile.do?file="+file_href+"'>"+iday+"</a> </li>");
													}else{
														out.print("<li> <a href='DownloadTAFFile.do?file="+file_href+"'>"+iday+"</a> </li>");
													}
													iday++;
												}
											}

											for(int j = 0; j <= 4; j++){
												if(iday <= Lday){
													for(i = 0; i <= 6; i++){
														if(iday < 10){
															d = "0"+iday;
														}else{
															d = Integer.toString(iday);
														}

														if(iday <= Lday){
															file_href = path_taff+yyyy+"\\"+mm+"\\"+yyyy+mm+d+".taf&namefile="+yyyy+mm+d+".taf&lang="+lang;
															file_href = file_href.replace('\\', '?');
															
															if(i == 0 && (iday != today)){
																out.print("<li> <a href='DownloadTAFFile.do?file="+file_href+"'>"+iday+"</a> </li>");
															}else if(i == 0 && (iday == today)){
																out.print("<li "+set_class_act+"> <a href='DownloadTAFFile.do?file="+file_href+"' "+font_tag_a+">"+iday+"</a> </li>");
															}else if(iday == today){
																out.print("<li "+set_class_act+"> <a href='DownloadTAFFile.do?file="+file_href+"' "+font_tag_a+">"+iday+"</a> </li>");
															}else if(i==6){
																out.print("<li> <a href='DownloadTAFFile.do?file="+file_href+"'>"+iday+"</a> </li>");
															}else{
																out.print("<li> <a href='DownloadTAFFile.do?file="+file_href+"'>"+iday+"</a> </li>");
															}
															iday++;
														}else{
															if(i == 6){
																out.print("<li> &nbsp; </li>");
															}else{
																out.print("<li> &nbsp; </li>");
															}
														}
													}
												}else{
													break;
												}
											}
										%>
											</ul>
											<div class="month-footer" style="max-width: 95% !important;">
												<ul>
													<li align="center"> <%= lb_clickhere %> </li>
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

		<div class="modal fade" id="myModalWarning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div id="modal_warning" class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_warning" class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_warning"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_warning" onClick="javascript: $('#myModalWarning').modal('hide'); javascript: document.getElementById($('#object_warning').val()).focus(); " style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> 
									<input type="hidden" id="object_warning" name="object_warning" readonly>
									<input type="hidden" id="datetime_warning" name="datetime_warning" readonly>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	<%	
		if(request.getParameter("lang") != null){
			String a = request.getParameter("a");
			out.println("<script> ModalWarning_TextName('"+uploadFile_msgerror5+" "+a+".taf', ''); </script>");
		}
	%>	
  
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>