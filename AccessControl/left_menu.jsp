<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	
	Calendar cal = Calendar.getInstance(Locale.US);
	int day = cal.get(Calendar.DATE);
	int month = cal.get(Calendar.MONTH) + 1; 
	int year = cal.get(Calendar.YEAR);
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
		<div id="wrapper" class="toggled">
		
		<!-- Sidebar -->
		<div id="sidebar-wrapper" style="background: #272B38; min-width: 300px;">
			<ul class="sidebar-nav" style="min-width: 300px;">
				<li class="sidebar-brand" style="margin-bottom: -20px">
				<%	if(checkPermissionNot(ses_per, 9)){	%>
					<a href="monitor_door.jsp?"> <i class="glyphicon glyphicon-home" style="margin-left: -20px; margin-right: 10px;"></i> <b> <font color="white" style="font-size: 24px;"> <%= lb_home %> </b> </font> </a>
				<%	}else{	%>
					<a href="report_105_user_pdf.jsp?month=<%= month %>&today=<%= day %>&year=<%= year %>&reader=all&username=<%= ses_user %>&"> <i class="glyphicon glyphicon-home" style="margin-left: -20px; margin-right: 10px;"></i> <b> <font color="white"> <%= lb_home %> </b> </font> </a>
				<%	}	%>
				</li>
		
		<%	if(request.getParameter("report").equals("trans")){		%>
		
				<!--	100		-->
				<li style="margin-top: 10px;"> <font color="white" style="font-size: 16px;"> <b> <%= lb_reportname %> <%= lb_report100 %> </b> </font> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_101.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_101 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_102.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_102 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_103.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_103 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_104.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_104 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_105.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_105 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_106.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_106 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_107.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_107 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_108.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_108 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_109.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_109 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_110.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_110 %> </a> </li>
				<!--	<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_111.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_111 %> </a> </li>	-->
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_112.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_112 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_113.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_113 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_114.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_114 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_115.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_115 %> </a> </li>
				<!--	<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_151.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_151 %> </a> </li>  -->
				
				<!--	200		-->
				<li style="margin-top: 10px;"> <font color="white" style="font-size: 16px;"> <b> <%= lb_reportname %> <%= lb_report200 %> </b> </font> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_201.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_201 %> </a> </li>
			<%	if(checkPermission(ses_per, "01234")){	%>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_202.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_202 %> </a> </li>
			<%	}	%>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_203.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_203 %> </a> </li>
			<%	if(checkPermission(ses_per, "01234")){	%>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_204.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_204 %> </a> </li>
			<%	}	%>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_205.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_205 %> </a> </li>
			<%	if(checkPermission(ses_per, "01234")){	%>
			<!--	<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_206.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_206 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_207.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_207 %> </a> </li>	-->
			<%	}	%>
			
				<!--	300		-->
				<li style="margin-top: 10px;"> <font color="white" style="font-size: 16px;"> <b> <%= lb_reportname %> <%= lb_rep_dataevent %> </b> </font> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_301.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_301 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_302.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_302 %> </a> </li>
				
				<!--	400		-->
				<li style="margin-top: 10px;"> <font color="white" style="font-size: 16px;"> <b> <%= lb_reportname %> <%= lb_rigthuser %> </b> </font> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_401_pdf.jsp?file=InOutByDoor"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_righofdoor %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_402_pdf.jsp?file=InOutByDoorQuick"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_righofdoor_q %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_403_pdf.jsp?file=InOutByPerson"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_righofemp %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_404_pdf.jsp?file=InOutByPersonQuick"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_righofemp_q %> </a> </li>
				<br/>
				
		<%	}else if(request.getParameter("report").equals("data")){	%>
		
			<%	if(checkPermissionNot(ses_per, 9)){	%>
				<%	if(checkPermission(ses_per, "0")){	%>
				<li style="margin-top: 10px;"> <font color="white" style="font-size: 16px;"> <b> <%= lb_reportname %> <%= lb_configdata %> </b> </font> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=location"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_location %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=door"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_door %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=reader"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_reader %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=event"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_event %> </a> </li>
				<%	}	%>
				
				<%	if(checkPermission(ses_per, "01234")){	%>
				<li style="margin-top: 10px;"> <font color="white" style="font-size: 16px;"> <b> <%= lb_reportname %> <%= lb_abouttime %> </b> </font> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=holiday"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_holiday %> </a> </li>
				<%	if(checkPermission(ses_per, "012")){	%>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=timedesc"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_timedesc %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=timezone"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_time_zone %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=unlock"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_unlock %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=lock"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_lock %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=timeonoutput4"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_timeonoutput4 %> </a> </li>
				<%	} }	%>
				
				<li style="margin-top: 10px;"> <font color="white" style="font-size: 16px;"> <b> <%= lb_reportname %> <%= lb_person %> </b> </font> </li>
				<%	if(checkPermission(ses_per, "01234")){	%>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=depart"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_depart %> </a> </li>
				<%	}	%>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=section"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_section %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=position"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_position %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=type_employee"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_typeemp %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data1_pdf.jsp?file=group"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_group %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_data2_pdf.jsp?file=employee"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_employee %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_employee_detail.jsp?file=employee2"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_report_employee2 %> </a> </li>
				<li style="margin-top: -10px; margin-bottom: -10px; margin-left: -15px;"> <a href="report_blacklist.jsp"> <i class="glyphicon glyphicon-menu-right"></i> <%= lb_blacklist %> </a> </li>
				<br/>
			<%	}	%>
			
		<%	}	%>
		</div> 
		
		<script>
		function show_detail(show_page){
			view_detail.location = show_page;
			$('#myModalViewDetail').modal('show');
		}
		
		//	Menu Sidebar for IE
		$("#menu-toggle").click(function(e) {
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});
		</script>
		
	</body>
</html>