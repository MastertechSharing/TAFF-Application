<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="server.process.ConvertData"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<!-- Bootstrap -->
		<link href="../css/bootstrap.min.css" rel="stylesheet">
		<link href="../css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="../js/jquery.min.js"></script>
		<script src="../js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="../js/ie10-viewport-bug-workaround.js"></script>
		<script src="../js/ie-emulation-modes-warning.js"></script>
		
		<style>
			table, tr, td { padding: 5px !important; }
		</style>
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
	
<%	
	String pages = request.getParameter("pages");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	
	String filename = "";
	if(request.getParameter("filename") != null){
		filename = new String(request.getParameter("filename").getBytes("ISO8859_1"),"tis-620");
	}
	String subfolder = "";
	if(request.getParameter("subfolder") != null){
		subfolder = new String(request.getParameter("subfolder").getBytes("ISO8859_1"),"tis-620");
	}
	
	String pathfile = "";
	if(!ip.equals("")){
		pathfile = path_data + ip + "\\" + subfolder + "\\" + filename;
	}else{
		pathfile = path_data + door_id + "\\" + subfolder + "\\" + filename;
	}
	String data = "";
	
	int countRecOK = 0;
	int countRecFail = 0;
	int countAllRec = 0;
	int countLine = 0;
	
	if(pages == null){ 
		out.println("");
	}else if(pages.equals("process")) {
		
%>	
		<div class="alert alert-info" role="alert" style="min-height: 50px; display: none;">
			<label class="modal-title col-xs-12 col-md-12">
				<span class="alert-link"> 
					<%= lb_total_data %> : <span id="count_all"></span> <%= lb_record %> , &nbsp; 
					<%= lb_succ %> : <span id="count_ok"></span> <%= lb_record %> , &nbsp; 
					<font style="color: #D9534F;"> <%= lb_notprocessuc %> : <span id="count_fail"></span> <%= lb_record %> </font>
				</span>
			</label>
		</div>
		
		<div class="table-responsive" style="border: 0px !important;" border="0">
			<div style="max-width: 100%; margin-left: 15px; margin-right: 15px;" border="0">

				<div class="row" style="margin-bottom: 0px;">
					
					<table class="table table-hover" style="min-width: 800px; max-width: 100%;" align="center">
						<thead>
							<tr>
								<td width="10%" align="center"> <%= lb_no %> </td>
								<td width="10%" align="center"> <%= lb_line_no %> </td>
								<td width="50%" align="center"> <%= uploadFile_msgerror6 %> </td>
								<td width="30%" align="center"> <%= lb_cause %> </td>
							</tr>
						</thead>
						<tbody>
<%
		try{
			int chk_int = 0;
			if(!(new File(pathfile).exists())){
				//	No File
			}else{
				try{
					
					BufferedReader buff = new BufferedReader(new FileReader(pathfile));
					while((data = buff.readLine()) != null){
						
						countLine++;
						if(data.trim().length() != 0){
							
							countAllRec++;
							resultQry = 0;
							
							String fail_message = "";
							boolean data_error = false;
							if(data.length() == 50){
								
								String dates = data.substring(17, 25);	//yyyymmdd
								String times = data.substring(25, 31);
								try{
									chk_int = Integer.parseInt(dates);
									chk_int = Integer.parseInt(times);
								}catch(Exception e){
									countRecFail++;
									data_error = true;
								}
								
								int message_format = 0;
								if(!data_error){
									//	Call function convert in java
									ConvertData convData = new ConvertData();
									message_format = convData.ConvertDataFormat(data);
									if(message_format == 1){			//	1 = Success
										countRecOK++;
									}else{
										countRecFail++;
										data_error = true;
										if(message_format == 0){		//	0 = Fail Format Error
											fail_message = uploadFile_msgerror6;
										}else if(message_format == 2){		//	2 = Software Event 6 Uncheck
											fail_message = lb_events + " " + data.substring(40, 42) + " " + lb_software6_uncheck;
										}else if(message_format == 3){		//	3 = No File config.set or path
											fail_message = uploadFile_msgerror7;
										}else if(message_format == 4){		//	4 = No Set Standard File
											fail_message = uploadFile_msgerror8;
										}
									}
								}else{
									fail_message = uploadFile_msgerror6;
									data_error = true;
								}
							}else{
								fail_message = lb_length_not50;
								countRecFail++;
								data_error = true;
							}
							
							if(data_error){
%>
							<tr>
								<td align="center"> <%= countRecFail %> </td>
								<td align="center"> <%= countLine %> </td>
								<td align="center"> <strong> <font face="Courier New"> <%= data.replace(" ", "&nbsp;") %> </font> </strong> </td>
								<td align="left"> &nbsp; &nbsp; &nbsp; <%= fail_message %> </td>
							</tr>
<%	
							}
						}
					}
					buff.close();
					
				}catch(Exception e){
				
				}
			}
			
		}catch(Exception e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		
%> 					
							
						</tbody>
					</table>
				
				</div> 
			
			</div> 
		</div>
		
<%	}	%>
		
		<script>
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				setTimeout(function(){
					
					var countRecFail = '<%= countRecFail %>';
					parent.document.getElementById("btn_format").disabled = false;
				//	parent.document.getElementById('img_load').style.display = "none";
				//	parent.document.getElementById('space').style.display = "";
					
					if(Number(countRecFail) == 0){
						parent.document.getElementById('result_sumfail').style.display = "none";
						parent.document.getElementById('result_1btn').style.display = "";
						parent.document.getElementById('result_2btn').style.display = "none";
					}else{
						parent.document.getElementById('result_sumfail').style.display = "";
						parent.document.getElementById('result_1btn').style.display = "none";
						parent.document.getElementById('result_2btn').style.display = "";
					}
					
					parent.document.getElementById("result_all").textContent = "<%= countAllRec %>";
					parent.document.getElementById("result_ok").textContent = "<%= countRecOK %>";
					parent.document.getElementById("result_fail").textContent = "<%= countRecFail %>";
					
					document.getElementById("count_all").textContent = "<%= countAllRec %>";
					document.getElementById("count_ok").textContent = "<%= countRecOK %>";
					document.getElementById("count_fail").textContent = "<%= countRecFail %>";
					
					window.top.$('#myModalWait').modal('hide');
					setTimeout(function(){
						window.top.$('#process_res').text('<%= lb_show_process_to_format %>');
						window.top.$('#myModalResult').modal('show');
					}, 200);
				}, 500);
			}
		}
		</script>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>