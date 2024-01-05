<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/displaydata.jsp"%>
<% 
	session.setAttribute("page_g", "tool");
	session.setAttribute("subpage", "transaction");
	session.setAttribute("subtitle", "gettransaction");
	String ip = "", door_id = "";
	if(request.getParameter("ip") != null){
		ip = new String(request.getParameter("ip").getBytes("ISO8859_1"),"tis-620");
	}
	if(request.getParameter("door_id") != null){
		door_id = new String(request.getParameter("door_id").getBytes("ISO8859_1"),"tis-620");
	}
	
	String row_data = "15";
	if(request.getParameter("row_data") != null){
		row_data = request.getParameter("row_data");
	}
	session.setAttribute("action", "cmd_get_transaction_data.jsp?ip="+ip+"&door_id="+door_id+"&row_data="+row_data+"&");
	
	String sql = "", desc = "";
	sql = " SELECT door_id, th_desc, en_desc FROM dbdoor ";
	if(!ip.equals("")){
		sql += " WHERE ip_address = '"+ip+"' ";
	}else{
		sql += " WHERE door_id = '"+door_id+"' ";
	}
	ResultSet rs = stmtQry.executeQuery(sql);
	while(rs.next()){
		door_id = rs.getString("door_id");
		if(lang.equals("th")){
			desc = rs.getString("th_desc");
		}else{
			desc = rs.getString("en_desc");
		}
	}
	rs.close();
	
	String pathfile = "";
	if(!ip.equals("")){
		pathfile = path_data + ip + "\\REC\\DATA.REC";
	}else{
		pathfile = path_data + door_id + "\\REC\\DATA.REC";
	}
	
	if(request.getParameter("download") != null){
		
		FileInputStream input = null;
		ServletOutputStream myOut = null;
		File myfile = null;
		try{
			myOut = response.getOutputStream();
			myfile = new File(pathfile);
			if (myfile.exists()){
				// set response headers
				response.setContentType("text/plain");
				response.addHeader("Content-Disposition", "attachment; filename="+door_id+".REC");
				response.setContentLength((int) myfile.length( ));
				input = new FileInputStream(myfile);
				int readBytes = 0;
				// read from the file; write to the ServletOutputStream
				while((readBytes = input.read()) != -1){
					myOut.write(readBytes);
				}
			}
		} catch (IOException ioe){
		
		} finally {
			if (myOut != null) {
				myOut.flush();
				myOut.close();
			}
			if (input != null){
				input.close();
			}
		}
		
	}else{
%>
<span/>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<!-- Preloader -->
		<link href="css/preloader.css" rel="stylesheet">
		<script src="js/preloader.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		
		<!-- Latest compiled and minified CSS -->
		<link href="css/bootstrap-select.min.css" rel="stylesheet">
		<!-- Latest compiled and minified JavaScript -->
		<script src="js/bootstrap-select.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			.bs-callout-info {
				border-left-color: #1b809e;
			}
			.bs-callout {
				padding: 10px;
				margin: 10px 0;
				border: 1px solid #1b809e;
				border-left-width: 5px;
				border-radius: 3px;
			}
		</style>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<div class="body-display">
			<div class="container" style="margin-bottom: -100px;">
			
<%	
	try{
		File f = new File(pathfile);
		if(!f.exists()){
			out.println("<div class='alert alert-danger' role='alert'>");
			out.println("	<span class='alert-link'> "+msg_not_file_upload+" "+lb_cmd56+" "+lb_doorcode+" : "+door_id+" - "+desc+" </span>");
			out.println("</div>");
		}else{
			
			BufferedReader in = new BufferedReader(new FileReader(pathfile));
			String textStr = "";
			int row_trans = 0;
			
%>
				<div class="alert alert-info" role="alert" style="min-height: 50px;">
					<span class="modal-title col-xs-5 col-md-5" style="margin-top: -10px;">
						<span class="alert-link"> <%= lb_cmd56 %> <br/> <%= lb_doorcode %> : <%= door_id %> - <%= desc %> </span>
					</span>
					<span class="modal-title col-xs-7 col-md-7" style="text-align: right;">
						<div class="btn-group">
							<button class="btn btn-default btn-xs button-shadow1 button-shadow2" id="btn_download" onClick="saveFile('<%= ip %>', '<%= door_id %>');" onMouseOver="this.style.cursor='hand';"> &nbsp; <%= lb_download_file %> &nbsp; </button>
							<button class="btn btn-default btn-xs button-shadow1 button-shadow2" id="btn_process" onClick="ProcessToBase('<%= ip %>', '<%= door_id %>', '<%= lb_processing_to_base %>');" onMouseOver="this.style.cursor='hand';"> 
								<img id="img_load" src="images/loading2.gif" style="display: none; cursor: default;" class="img-rounded" width="16" height="16"><span id="space"></span> &nbsp; <%= lb_process_to_base %> &nbsp; 
							</button>
							<button class="btn btn-default btn-xs button-shadow1 button-shadow2" id="btn_format" onClick="ProcessToFormat('<%= ip %>', '<%= door_id %>', '<%= lb_processing_to_format %>');" onMouseOver="this.style.cursor='hand';"> 
								<img id="img_load2" src="images/loading2.gif" style="display: none; cursor: default;" class="img-rounded" width="16" height="16"><span id="space"></span> &nbsp; <%= lb_process_to_format %> &nbsp;
							</button>
							<button class="btn btn-default btn-xs button-shadow1 button-shadow2" id="btn_taf" onClick="ProcessToFileTAF('<%= ip %>', '<%= door_id %>', '<%= lb_processing_to_taf %>');" onMouseOver="this.style.cursor='hand';"> 
								<img id="img_load3" src="images/loading2.gif" style="display: none; cursor: default;" class="img-rounded" width="16" height="16"><span id="space"></span> &nbsp; <%= lb_process_to_taf %> &nbsp;
							</button>
						</div>
					</span>
				</div>
				
			<!--	<div class="table-responsive" style="border: 0px !important; margin-left: 0px; margin-right: 0px; margin-bottom: -70px;" border="0">	-->
					
					<div style="min-width: 1000px; max-width: 100%; margin-left: 0px; margin-right: -30px; margin-bottom: -70px;" class="table" border="0">
					
					<%	/* if(format_type.equals("raw")){	%>
					
						<table style="min-width: 1000px;" class="table table-hover" align="center" id="table1" border="0">
							<thead>
								<tr>
									<td width="10%" align="center"> <label class="control-label"> <%= lb_no %> </td>
									<td width="10%" align="center"> <label class="control-label"> </td>
									<td width="50%" align="center"> <label class="control-label"> <%= lb_detailtransaction %> </td>
									<td width="30%" align="center"> <label class="control-label"> </td>
								</tr>
							</thead>
							<tbody>
						<%	while((textStr = in.readLine()) != null){
								if(textStr.length() == 50){
									row_trans++;
						%>		<tr>
									<td align="center"> <%= row_trans %> </td>
									<td align="center"> </td>
									<td class="pad-left-10"> <strong> <font face="Courier New"> <%= textStr.replace(" ", "&nbsp;") %> </font> </strong> </td>
									<td align="center"> </td>
								</tr>
						<%		}	
							}	in.close();	
						%>
							</tbody>
						</table>
						
					<%	
						}
					 */
					//	if(format_type.equals("view")){	
					%>
					
						<table style="min-width: 1000px;" class="table table-hover" align="center" id="table1" border="0">
							<thead>
								<tr>
									<td width="10%" align="center"> <label class="control-label"> <%= lb_no %> </td>
									<td width="15%" align="center"> <label class="control-label"> <%= lb_date %> </td>
									<td width="15%" align="center"> <label class="control-label"> <%= lb_time %> </td>
									<td width="15%" align="center"> <label class="control-label"> <%= lb_duty %> </td>
									<td width="15%" align="center"> <label class="control-label"> <%= lb_empcode %> </td>
									<td width="15%" align="center"> <label class="control-label"> <%= lb_readers %> </td>
									<td width="15%" align="center"> <label class="control-label"> <%= lb_events %> </td>
								</tr>
							</thead>
							<tbody>							
						<%	//	id(16) + duty(1) + date(8) + time(6) + taff(5) + seq(4) + event_code(2) + blank(6) + crc(2)
							String id = "", duty = "", dates = "", times = "", taff = "", seq = "", ev_code = "", blank = "", crc =  "";
							while((textStr = in.readLine()) != null){
								
								if(textStr.trim().length() != 0){
									row_trans++;
									
									if(textStr.length() < 50){
										for(int i = textStr.length(); i < 50; i++){
											textStr += " ";
										}
									}
									
									if(!(row_data.equals("all"))){
										if(row_trans > Integer.parseInt(row_data)) continue;
									}
									
									id = textStr.substring(0, 16);
									duty = textStr.substring(16, 17);
									if(textStr.substring(17, 25).trim().length() != 0){
										dates = textStr.substring(17, 19) +"/"+ textStr.substring(19, 21) +"/"+  textStr.substring(21, 25);
									}
									if(textStr.substring(25, 31).trim().length() != 0){
										times = textStr.substring(25, 27) +":"+ textStr.substring(27, 29) +":"+  textStr.substring(29, 31);
									}
									taff = textStr.substring(31, 36);
								//	seq = textStr.substring(36, 40);
									ev_code = textStr.substring(40, 42);
								//	blank = textStr.substring(42, 48);
								//	crc = textStr.substring(48, 50);
									
									String idcard_link = "<b> <span onClick='show_detail(\""+id+"\", \"employee\");' style='color: #337AB7; cursor: pointer;' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + id + "</span> </b>";
									String reader_link = "<b> <span onClick='show_detail(\""+taff+"\", \"reader\");' style='color: #337AB7; cursor: pointer;' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + taff + "</span> </b>";
									String event_link = "<b> <span onClick='show_detail(\""+ev_code+"\", \"event\");' style='color: #337AB7; cursor: pointer;' data-toggle='tooltip' data-placement='left' data-html='true' title='"+lb_viewdata+"'>" + ev_code + "</span> </b>";
									
						%>		
								<tr>
									<td align="center"> <%= row_trans %> </td>
									<td align="center"> <%= dates %> </td>
									<td align="center"> <%= times %> </td>
									<td align="center"> <%= duty %> </td>
									<td class="pad-left-30"> <%= idcard_link %> </td>
									<td align="center"> <%= reader_link %> </td>
									<td align="center"> <%= event_link %> </td>
								</tr>
						<%		}
								dates = "";
								times = "";
							}	in.close();	
						%>
							</tbody>
						</table>
					<%	//	}	%>
						
						<div class="row" style="border: 0px !important; margin-top: -10px; margin-bottom: -100px; margin-left: 0px; margin-right: 0px;" border="0">
							<label class="col-xs-6 col-md-6" style="margin-top: 6px;">
								<%= lb_alldata_event %> <%= row_trans %> <%= lb_reccorddata %>
							</label>
							<label class="col-xs-6 col-md-6" style="text-align: right"> 
								<%= lb_show %> &nbsp; 
								<select class="form-control selectpicker dropup" data-width="100px" data-size="12" style="max-height: 24px !important;" name="row_data" id="row_data" onChange="reload('<%= ip %>', '<%= door_id %>');">
									<option name="row_data" value="15" selected> 15 </option>
									<option name="row_data" value="100" <% if(row_data.equals("100")){ %> selected <% } %>> 100 </option>
									<option name="row_data" value="1000" <% if(row_data.equals("1000")){ %> selected <% } %>> 1000 </option>
									<option name="row_data" value="all" <% if(row_data.equals("all")){ %> selected <% } %>> <%= lb_all %> </option>
								</select>
								&nbsp; <%= lb_reccorddata %>
							</label>
						</div> 
						
					</div>
			<!--	</div>	-->
<%	
		}
	}catch(Exception e){
		out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
	}	
%>  
			</div>
		</div>
		
		<div class="modal fade bs-example-modal-lg" id="myModalProcessToBase" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog modal-lg" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title"> <%= uploadFile_msgerror6 %> </h4>
					</div>
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0">
							<iframe src="" id="process_result" name="process_result" frameborder="0" height="450px" style="min-width: 850px;"></iframe>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalWait" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-warning">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; margin-bottom: -30px;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <img id="img_load" src="images/loading2.gif" style=" cursor: default;" class="img-rounded" width="48" height="48"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="processing"> </p> </h4> </div>
						<!--	
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="javascript: $('#myModalWait').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> 
								</div>
							</div>
						-->
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalResult" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important; margin-bottom: -10px;" border="0"> 
						<!--	<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-ok-circle alert-message-success" style="font-size: 50px;"> </span> </div>	-->
							<div class="col-xs-12 col-md-12" style="margin-bottom: 20px; margin-top: 10px;"> <h4> <p id="process_res"> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 20px;"> 
								<div class="col-xs-5 col-md-5" style="text-align: right;"> <h4> <%= lb_total_processl %> </h4> </div>
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-4 col-md-4" style="text-align: right;"> <h4> <span id="result_all"></span> <%= lb_record %> </h4> </div>
								<div class="col-xs-2 col-md-2"> </div>
							</div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 20px;"> 
								<div class="col-xs-5 col-md-5" style="text-align: right;"> <h4> <span class="glyphicon glyphicon-ok-circle alert-message-success"></span> &nbsp; <%= lb_succ %> </h4> </div>
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-4 col-md-4" style="text-align: right;"> <h4> <span id="result_ok"></span> <%= lb_record %> </h4> </div>
								<div class="col-xs-2 col-md-2"> </div>
							</div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 20px;" id="result_sumfail"> 
								<div class="col-xs-5 col-md-5" style="text-align: right;"> <h4> <font style="color: #D9534F;"> <span class="glyphicon glyphicon-remove-circle" style="color: #D9534F;"></span> &nbsp; <%= lb_notprocessuc %> </font> </h4> </div>
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-4 col-md-4" style="text-align: right;"> <h4> <font style="color: #D9534F;"> <span id="result_fail" style="color: #D9534F;"></span> <%= lb_record %> </font> </h4> </div>
								<div class="col-xs-2 col-md-2"> </div>
							</div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 0px; display: none;" id="result_1btn"> 
								<div class="col-xs-4 col-md-4"> </div>
								<div class="col-xs-4 col-md-4">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="javascript: $('#myModalResult').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button> &nbsp; 
								</div>
								<div class="col-xs-4 col-md-4"> </div>
							</div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 0px; display: none;" id="result_2btn"> 
								<div class="col-xs-1 col-md-1"> </div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="javascript: $('#myModalResult').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button> &nbsp; 
								</div>
								<div class="col-xs-5 col-md-5">
									<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_result" onClick="javascript: $('#myModalResult').modal('hide'); $('#myModalProcessToBase').modal('show');" style="width: 100%;"> <span class="glyphicon glyphicon-exclamation-sign" style="color: #D9534F;"></span> </font> &nbsp; <%= uploadFile_msgerror6 %> </button>
								</div>
								<div class="col-xs-1 col-md-1"> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModalDownload" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-success">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-ok-circle alert-message-success" style="font-size: 50px;"> </span> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p> <%= msg_download_file_success %> </p> </h4> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
								<div class="col-xs-3 col-md-3"> </div>
								<div class="col-xs-6 col-md-6">
									<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_save" onClick="javascript: $('#myModalDownload').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
								</div>
								<div class="col-xs-3 col-md-3"> <input type="hidden" id="datetime_result" name="datetime_result" readonly> </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%@ include file="tools/modal_viewdetail.jsp"%>
		
		<iframe id="download_file" name="download_file" src="" frameborder="0" width="0px" height="0px" scrolling="yes"></iframe>
		
		<script>
			function show_detail(data, data_type){
				var page = "";
				if(data_type == 'employee'){
					page = 'view_employee.jsp?action=view&idcard='+data;
				}else if(data_type == 'reader'){
					page = 'view_reader.jsp?action=view&reader_no='+data;
				}else if(data_type == 'event'){
					page = 'view_event.jsp?action=view&event_code='+data;
				}
				view_detail_450px.location = page;
				$('#myModalViewDetail450px').modal('show');
			}
			
			function saveFile(ip, door_id){
				if(ip != ''){
					download_file.location.href = 'cmd_get_transaction_data.jsp?ip='+ip+'&download=1&';
				}else{
					download_file.location.href = 'cmd_get_transaction_data.jsp?door_id='+door_id+'&download=1&';
				}
				
				setTimeout(function(){
					var date = new Date().getTime();
					$('#myModalDownload').modal('show');
					document.getElementById("datetime_result").value = date;
					setTimeout(function(){
						if ((!$('#myModalDownload').is(':hidden')) && date == document.getElementById("datetime_result").value) {
							$('#myModalDownload').modal('hide');
						}
					}, 3000);
				}, 100);
			}
		
			function ProcessToBase(ip, door_id, sText){
				document.getElementById("btn_process").disabled = true;
			//	document.getElementById('img_load').style.display = '';
			//	document.getElementById('space').style.display = 'none';
				process_result.location.href = 'module/transaction_to_database.jsp?ip='+ip+'&door_id='+door_id+'&subfolder=REC&filename=DATA.REC&pages=process';
				
				document.getElementById('processing').innerHTML = sText;
				$('#myModalWait').modal('show');
			//	setTimeout(function(){
			//		$('#myModalWait').modal('hide');
			//	}, 3000);
			}
		
			function ProcessToFormat(ip, door_id, sText){
				document.getElementById("btn_format").disabled = true;
				process_result.location.href = 'module/transaction_to_dataformat.jsp?ip='+ip+'&door_id='+door_id+'&subfolder=REC&filename=DATA.REC&pages=process';
				document.getElementById('processing').innerHTML = sText;
				$('#myModalWait').modal('show');
			}
		
			function ProcessToFileTAF(ip, door_id, sText){
				document.getElementById("btn_taf").disabled = true;
				process_result.location.href = 'module/transaction_to_filetaf.jsp?ip='+ip+'&door_id='+door_id+'&subfolder=REC&filename=DATA.REC&pages=process';
				document.getElementById('processing').innerHTML = sText;
				$('#myModalWait').modal('show');
			}
			
			function reload(ip, door_id){
				location.href = "cmd_get_transaction_data.jsp?ip="+ip+"&door_id="+door_id+"&row_data="+document.getElementById("row_data").value+"&";
			}
			
			document.onreadystatechange = function () {
				if (document.readyState === "complete") {
					$('body').addClass('loaded');
				}
			}
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%	}	%>

<%@ include file="../function/disconnect.jsp"%>