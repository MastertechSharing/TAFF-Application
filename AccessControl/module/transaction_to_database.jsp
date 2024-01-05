<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="server.process.ConvertData"%>
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
								<td width="30%" align="center"> </td>
							</tr>
						</thead>
						<tbody>
<%
		try{
			
			//	Call function convert in java
			ConvertData convData = new ConvertData();
			
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
							if(data.length() == 50 ){
								
								int msg_status_base = convData.CheckConvertData(data);
								if(msg_status_base == 1){					//	1 = Success
								
									// id(16)+duty(1)+date(8)+time(6)+taff(5)+seq(4)+event_code(2)+blank(6)+crc(2)
									String id = data.substring(0, 16);
									String duty = data.substring(16, 17);
									String dates = data.substring(21,25)+data.substring(19,21)+data.substring(17,19);//yyyymmdd//data.substring(17,25)
									String times = data.substring(25, 31);
									String taff = data.substring(31, 36);
									String seq = data.substring(36, 40);
									String ev_code = data.substring(40, 42);
									String blank = data.substring(42, 48);
									String crc = data.substring(48, 50);
									
									String date_event = dates.substring(0,4)+"-"+dates.substring(4,6)+"-"+dates.substring(6,8);
									String time_event = times.substring(0,2)+":"+times.substring(2,4)+":"+times.substring(4,6);
									String workday = date_event+" "+time_event;
									if(mode == 1){
										workday += ".000";
									}
									
									//	หา ip address
									String ip_address = "";
									String sql = " SELECT door.ip_address, rd.reader_no FROM dbdoor door "
											+ " LEFT OUTER JOIN dbreader rd ON door.door_id = rd.door_id "
											+ " WHERE (door.door_id AND rd.door_id = '"+taff.substring(0,4)+"') ";
									ResultSet rs = stmtQry.executeQuery(sql);
									while(rs.next()){
										ip_address = rs.getString("ip_address");
									}
									rs.close();
									
									//	insert ลงเบส dbtransaction									
									if(ev_code.compareTo("08") <= 0){
										sql = " INSERT INTO dbtransaction (date_event,time_event,reader_no,event_code,idcard,workday,ip_address,duty,data_seq,data_blank) "
											+ " VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"','"+id+"','"+workday+"','"+ip_address+"','"+duty+"','"+seq+"','"+blank+"')";
									}else{
										if(ev_code.compareTo("09") >= 0 && ev_code.compareTo("24") <= 0 || ev_code.equals("47")){
											sql = " INSERT INTO dbtransaction_ev (date_event,time_event,reader_no,event_code,idcard,workday,ip_address,duty,data_seq,data_blank) "
												+ " VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"','"+id+"','"+workday+"','"+ip_address+"','"+duty+"','"+seq+"','"+blank+"')";
										}else{
											sql = " INSERT INTO dbtrans_event (date_event,time_event,reader_no,event_code,workday,ip_address,duty,data_blank) "
												+ " VALUES ('"+date_event+"','"+time_event+"','"+taff+"','"+ev_code+"','"+workday+"','"+ip_address+"','"+duty+"','"+blank+"')";
										}
									}
									
									try{																		
										resultQry = stmtUp.executeUpdate(sql);
									}catch(SQLException es){
										if(resultQry != 1){
											if(ev_code.compareTo("08") <= 0){
												sql = " UPDATE dbtransaction SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
													+ " idcard='"+id+"',workday='"+workday+"',ip_address='"+ip_address+"',duty='"+duty+"',data_seq='"+seq+"',data_blank='"+blank+"' "
													+ " WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') AND (idcard = '"+id+"')";
											}else{
												if(ev_code.compareTo("09") >= 0 && ev_code.compareTo("24") <= 0 || ev_code.equals("47")){
													sql = " UPDATE dbtransaction_ev SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
														+ " idcard='"+id+"',workday='"+workday+"',ip_address='"+ip_address+"',duty='"+duty+"',data_seq='"+seq+"',data_blank='"+blank+"' "
														+ " WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') AND (idcard = '"+id+"')";
												}else{
													sql = " UPDATE dbtrans_event SET date_event='"+date_event+"',time_event='"+time_event+"',reader_no='"+taff+"',event_code='"+ev_code+"',"
														+ " workday='"+workday+"',ip_address='"+ip_address+"',duty='"+duty+"',data_blank='"+blank+"' "
														+ " WHERE (date_event = '"+date_event+"') AND (time_event = '"+time_event+"') AND (reader_no = '"+taff+"') AND (event_code = '"+ev_code+"') ";
												}
											}
											try{
												resultQry = stmtUp.executeUpdate(sql);
											}catch(SQLException e){
												
											}
										}
									}
									
									if(resultQry == 1){	//	ถ้า resultQry == 1 นับเรคคอร์ดที่บันทึกได้ทั้งหมด
										countRecOK++;
									}else{
										countRecFail++;
										fail_message = uploadFile_msgerror6;
%>
							<tr>
								<td align="center"> <%= countRecFail %> </td>
								<td align="center"> <%= countLine %> </td>
								<td align="center"> <strong> <font face="Courier New"> <%= data.replace(" ", "&nbsp;") %> </font> </strong> </td>
								<td align="left"> &nbsp; &nbsp; &nbsp; <%= fail_message %> </td>
							</tr>
<%	
									}
							
								}else{
									
									if(msg_status_base == 0){
										fail_message = uploadFile_msgerror6;
									}else if(msg_status_base == 3){
										fail_message = uploadFile_msgerror7;
									}else if(msg_status_base == 4){
										fail_message = uploadFile_msgerror8;
									}
									countRecFail++;
%>
							<tr>
								<td align="center"> <%= countRecFail %> </td>
								<td align="center"> <%= countLine %> </td>
								<td align="center"> <strong> <font face="Courier New"> <%= data.replace(" ", "&nbsp;") %> </font> </strong> </td>
								<td align="left"> &nbsp; &nbsp; &nbsp; <%= fail_message %> </td>
							</tr>
<%								
								}
							
							}else{
								
								fail_message = lb_length_not50;
								countRecFail++;
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
					parent.document.getElementById("btn_process").disabled = false;
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
						window.top.$('#process_res').text('<%= lb_show_process_to_base %>');
						window.top.$('#myModalResult').modal('show');;
					}, 200);
				}, 500);
			}
		}
		</script>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>