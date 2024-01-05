<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	
	String st_date = (String) session.getAttribute("st_date");
	String st_time = (String) session.getAttribute("st_time");
	String end_time = (String) session.getAttribute("end_time");
	
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style> 
			.scroll tbody {
				display: block;
				max-height: 405px;
				overflow-y: scroll;
			}
			.scroll thead, tbody tr {
				padding-left: 15px;
				display: table;
				width: 100%;
				table-layout: fixed;
			}
		</style>
		
		<script>
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
		
<%	
	String event_code = "", idcard = "";
	if(request.getParameter("iframe_pass") != null){
		
		if(request.getParameter("event_pass") != null){
			event_code = request.getParameter("event_pass");
		}
		if(request.getParameter("idcard_pass") != null){
			idcard = request.getParameter("idcard_pass");
		}
		
%>

		<div class="table-responsive" style="border: 0px !important; margin-bottom: -70px;" border="0">
			<div style="min-width: 100%;" class="table" border="0">
				<table style="min-width: 100% !important; margin-top: 10px;" class="table table-hover scroll" align="center" id="table1" border="0">
					<thead>
						<tr>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_no %> </td>
							<td width="25%" align="center"> <label class="control-label"> <%= lb_empcode %> </td>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_events %> </td>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_date %> </td>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_time %> </td>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_photo %> </td>
						</tr>
					</thead>
					<tbody>
				<% 	
					int row_pass = 0;
					String pathfile = "";
					if(!ip.equals("")){
						pathfile = path_data + ip + "\\CAPTURE_PICTURES\\FileCapture\\";
					}else{
						pathfile = path_data + door_id + "\\CAPTURE_PICTURES\\FileCapture\\";
					}
					File aDirectory = new File(pathfile);
					String[] filesInDir = aDirectory.list();
					for(int i = 0; i < filesInDir.length; i++){
						
						String filename = filesInDir[i].substring(0, (filesInDir[i].length() -4));
						String[] data = filename.split("_");
						
						String idcard_pass = data[0];
						String event_pass = data[1];
						String get_date = "";
						String get_time = "";
						String time = "";
						
						if(data.length == 3){
							time = data[2];
							get_date = st_date;
							get_time = data[2].substring(0, 2)+":"+data[2].substring(2, 4)+":"+data[2].substring(4, 6);
						}else if(data.length == 4){
							time = data[3];
							get_date = data[2].substring(6, 8)+"/"+data[2].substring(4, 6)+"/"+data[2].substring(0, 4);
							get_time = data[3].substring(0, 2)+":"+data[3].substring(2, 4)+":"+data[3].substring(4, 6);
						}
						
						int time_chk = Integer.parseInt(time.substring(0, 2)+time.substring(2, 4));
						int st_time_chk = Integer.parseInt(st_time.substring(0, 2)+st_time.substring(3, 5));
						int end_time_chk = Integer.parseInt(end_time.substring(0, 2)+end_time.substring(3, 5));
						
						if(!st_date.equals(get_date)){
							continue;
						}
						if(!((time_chk >= st_time_chk) && (time_chk <= end_time_chk))){
							continue;
						}
						
						if(Integer.parseInt(event_pass) > 5){
							continue;
						}
						if((!event_code.equals("00")) && event_code != ""){
							if(!(event_code.equals(event_pass))){
								continue;
							}
						}
						if((!idcard.equals("NoID")) && idcard != ""){
							if(!(idcard.equals(idcard_pass))){
								continue;
							}
						}
						
						String idcard_link = "<b> <span onClick='show_detail(\""+idcard_pass+"\", \"employee\");' style='color: #337AB7; cursor: pointer;' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + idcard_pass + "</span> </b>";
						String event_link = "<b> <span onClick='show_detail(\""+event_pass+"\", \"event\");' style='color: #337AB7; cursor: pointer;' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + event_pass + "</span> </b>";
						String path_capture = pathfile + filesInDir[i];
						
						row_pass++;
				%>		
						<tr>
							<td width="15%" align="center"> <%= row_pass %> </td>
							<td width="25%" class="pad-left-10"> <%= idcard_link %> </td>
							<td width="15%" align="center"> <%= event_link %> </td>
							<td width="15%" align="center" style="padding-left: 25px;"> <%= get_date %> </td>
							<td width="15%" align="center" style="padding-left: 30px;"> <%= get_time %> </td>
							<td width="15%" align="center" style="padding-left: 35px;"> <img id="img_capture" class="img-rounded" src="data:image/jpeg;base64,<%= decodeToImage(path_capture, "jpg") %>" onClick="show_capture('<%= ip %>', '<%= door_id %>', '<%= filesInDir[i] %>')" width="24" height="24" style="cursor: pointer;" data-toggle="tooltip" data-placement="left" data-container="body" title="<%= filesInDir[i] %>"> </td>
						</tr>
				<%	}	%>
					</tbody>
				</table>
			</div>
		</div>
		
<%	}else if(request.getParameter("iframe_notpass") != null){
		
		if(request.getParameter("event_notpass") != null){
			event_code = request.getParameter("event_notpass");
		}
		if(request.getParameter("idcard_notpass") != null){
			idcard = request.getParameter("idcard_notpass");
		}
		
%>		
		<div class="table-responsive" style="border: 0px !important; margin-bottom: -70px;" border="0">
			<div style="min-width: 100%;" class="table" border="0">
				<table style="min-width: 100% !important; margin-top: 10px;" class="table table-hover scroll" align="center" id="table1" border="0">
					<thead>
						<tr>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_no %> </td>
							<td width="25%" align="center"> <label class="control-label"> <%= lb_empcode %> </td>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_events %> </td>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_date %> </td>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_time %> </td>
							<td width="15%" align="center"> <label class="control-label"> <%= lb_photo %> </td>
						</tr>
					</thead>
					<tbody>
				<% 	
					int row_notpass = 0;
					String pathfile = "";
					if(!ip.equals("")){
						pathfile = path_data + ip + "\\CAPTURE_PICTURES\\FileCapture\\";
					}else{
						pathfile = path_data + door_id + "\\CAPTURE_PICTURES\\FileCapture\\";
					}
					File aDirectory = new File(pathfile);
					String[] filesInDir = aDirectory.list();
					for(int i = 0; i < filesInDir.length; i++){
						
						String filename = filesInDir[i].substring(0, (filesInDir[i].length() -4));
						String[] data = filename.split("_");
						
						String idcard_notpass = data[0];
						String event_notpass = data[1];
						String get_date = "";
						String get_time = "";
						String time = "";
						
						if(data.length == 3){
							time = data[2];
							get_date = st_date;
							get_time = data[2].substring(0, 2)+":"+data[2].substring(2, 4)+":"+data[2].substring(4, 6);
						}else if(data.length == 4){
							time = data[3];
							get_date = data[2].substring(6, 8)+"/"+data[2].substring(4, 6)+"/"+data[2].substring(0, 4);
							get_time = data[3].substring(0, 2)+":"+data[3].substring(2, 4)+":"+data[3].substring(4, 6);
						}
						
						int time_chk = Integer.parseInt(time.substring(0, 2)+time.substring(2, 4));
						int st_time_chk = Integer.parseInt(st_time.substring(0, 2)+st_time.substring(3, 5));
						int end_time_chk = Integer.parseInt(end_time.substring(0, 2)+end_time.substring(3, 5));
						
						if(!st_date.equals(get_date)){
							continue;
						}
						if(!((time_chk >= st_time_chk) && (time_chk <= end_time_chk))){
							continue;
						}
						
						if(Integer.parseInt(event_notpass) != 6 && (Integer.parseInt(event_notpass) < 8 || Integer.parseInt(event_notpass) > 23)){
							continue;
						}
						if((!event_code.equals("00")) && event_code != ""){
							if(!(event_code.equals(event_notpass))){
								continue;
							}
						}
						if((!idcard.equals("NoID")) && idcard != ""){
							if(!(idcard.equals(idcard_notpass))){
								continue;
							}
						}
						
						String idcard_link = "<b> <span onClick='show_detail(\""+idcard_notpass+"\", \"employee\");' style='color: #337AB7; cursor: pointer;' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + idcard_notpass + "</span> </b>";
						String event_link = "<b> <span onClick='show_detail(\""+event_notpass+"\", \"event\");' style='color: #337AB7; cursor: pointer;' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + event_notpass + "</span> </b>";
						String path_capture = pathfile + filesInDir[i];
						
						row_notpass++;
				%>		
						<tr>
							<td width="15%" align="center"> <%= row_notpass %> </td>
							<td width="25%" class="pad-left-10"> <%= idcard_link %> </td>
							<td width="15%" align="center"> <%= event_link %> </td>
							<td width="15%" align="center" style="padding-left: 25px;"> <%= get_date %> </td>
							<td width="15%" align="center" style="padding-left: 30px;"> <%= get_time %> </td>
							<td width="15%" align="center" style="padding-left: 35px;"> <img id="img_capture" class="img-rounded" src="data:image/jpeg;base64,<%= decodeToImage(path_capture, "jpg") %>" onClick="show_capture('<%= ip %>', '<%= door_id %>', '<%= filesInDir[i] %>')" width="24" height="24" style="cursor: pointer;" data-toggle="tooltip" data-placement="left" data-container="body" title="<%= filesInDir[i] %>"> </td>
						</tr>
				<%	}	%>
					</tbody>
				</table>
			</div>
		</div>
		
<%	}	%>
		
		<script>
		function show_detail(data, data_type){
			var page = "";
			if(data_type == 'employee'){
				page = 'view_employee.jsp?action=view&idcard='+data;
			}else if(data_type == 'event'){
				page = 'view_event.jsp?action=view&event_code='+data;
			}
			parent.view_detail_450px.location = page;
			window.top.$('#myModalViewDetail450px').modal('show');
		}
		
		function show_capture(ip, door_id, filename){
			parent.view_capture.location = 'cmd_get_capture_view.jsp?action=view&ip='+ip+'&door_id='+door_id+'&filename='+filename;
			window.top.$('#myModalViewCapture').modal('show');
		}
		</script>

	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>