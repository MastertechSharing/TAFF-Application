<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	
	String server_code = "", file_type = "";
	if(request.getParameter("server_code") != null){
		server_code = request.getParameter("server_code");
	}
	if(request.getParameter("file_type") != null){
		file_type = request.getParameter("file_type");
	}
	
	String server_detail = "", path = "";
	ResultSet rs = stmtQry.executeQuery(" SELECT * FROM dbserver_config WHERE (server_code = '"+server_code+"') ");
	if(rs.next()){
		server_detail = server_code + " - " + rs.getString("server_ip");
		
		if (file_type.equals("TXT")){
			path = rs.getString("path_output");
		} else if (file_type.equals("STD")){
			path = rs.getString("path_output_std");
		} else if (file_type.equals("TA")){
			path = rs.getString("path_output");
		}		
		if(!path.substring((path.length() -1), path.length()).equals("\\")){
			path += "\\";
		}		
	}
	rs.close();
	
	if (file_type.equals("TA")){
		path = path+"TA\\";
	}	
	path += "BACKUP\\";
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
		<link href="css/dataTables.bootstrap.min.css" rel="stylesheet">
		<link href="css/dataTables.checkboxes.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.dataTables.min.js"></script>
		<script src="js/dataTables.bootstrap.min.js"></script>
		<script src="js/dataTables.checkboxes.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			.dt-body-center{
				text-align: center;
			}
			
			.bs-callout-warning {
			  border-left-color: #eb9826;
			  padding: 10px;
			  margin: 10px 0;
			  border: 1px solid #eb9826;
			  border-left-width: 5px;
			  border-radius: 3px;
			}
		</style>
		
		<script>
			var chk_dubbleclick = 0;
			
			function LoadDataTable(onload){
				
				$(document).ready(function() {
					
					var table_file = $('#data_file').DataTable({
						"columnDefs": [
							{ "targets": 0, "checkboxes": { "selectRow": true } }, 
							{ "bSortable": false, "aTargets": [ 0, 1, 2 ] },
							{ "bclassName": "btn btn-primary btn-sm" }
						],
						"select": { "style": "multi" },
						"aaSorting": [ ],
						"dom": "<f<t>>",	//	<lf<t>ip>
						"lengthMenu": [ [ -1 ], [ "All" ] ]
					<%	if(lang.equals("th")){	%>
						,"oLanguage": {
							"sProcessing":   "กำลังดำเนินการ...",
							"sZeroRecords":  "ไม่พบข้อมูล",
							"sSearch":       "ค้นหา: "
						}
					<%	}	%>
					});
				
					$('.dataTables_filter').addClass('pull-left');
					$('.dataTables_filter').addClass('pad-left-15');
					$('.data_table_filter, input').addClass('max-height-24');
					
					$('#btn_multi').on('click', function(){
						var form = this;
						var cRow_file = 0;
						var rows_selected_file = table_file.column(0).checkboxes.selected();
						$.each(rows_selected_file, function(index, rowId){
							cRow_file++;
						});
						
						//	Submit Form
						rows_selected_file.sort();
						if(cRow_file != 0){
							$('#check_file').val(rows_selected_file.join(','));
						}else{
							$('#check_file').val('');
						}
						
						if(cRow_file != 0){
							downloadMultiFile();
						}else{
							if(Number(chk_dubbleclick) == 0){
								chk_dubbleclick = 1;
								ModalWarning_TextName('<%= msg_select_file %>', '');
								return false;
							}
							rechk();
						}
						
						return false;
					});
					
					$('#data_file thead tr th').click(function(event) {
						$('input[type="checkbox"]').change(function () {
							var cRow_file = 0;
							$.each(table_file.column(0).checkboxes.selected(), function(index, rowId){
								cRow_file++;
							});
						});
					});
				});
			
			}
			
			function downloadSingleFile(filename){
			//	location.href = 'file_download_txt_download.jsp?action=single&path='+$("#path").val()+'&file_type='+$("#file_type").val()+'&filename='+filename;
				
				if(Number(chk_dubbleclick) == 0){
					chk_dubbleclick = 1;
					
					$('#form1').attr('action', 'file_download_txt_download.jsp?action=backup_single_&path='+$("#path").val()+'&file_type='+$("#file_type").val()+'&filename='+filename);
					$('#form1').attr('target', 'iframe_download');
					$('#form1').submit();
					
					$('#myModalProcess').modal('show');
				}
				rechk();
			}
			
			function downloadMultiFile(){
			//	location.href = 'file_download_txt_download.jsp?action=multi&path='+$("#path").val()+'&file_type='+$("#file_type").val()+'&listfile='+$("#check_file").val();
			//	$('#btn_multi').prop('disabled', true);
			
				if(Number(chk_dubbleclick) == 0){
					chk_dubbleclick = 1;
					
					$('#form1').attr('action', 'file_download_txt_download.jsp?action=backup_multi_&path='+$("#path").val()+'&file_type='+$("#file_type").val()+'&listfile='+$("#check_file").val());
					$('#form1').attr('target', 'iframe_download');
					$('#form1').submit();
					
					$('#myModalProcess').modal('show');
				}
				rechk();
			}
			
			function rechk(){
				setTimeout(function(){
					chk_dubbleclick = 0;
				}, 1000);
			}
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -25px; overflow-y: true;" onLoad="LoadDataTable(true);">
		
		<div class="table-responsive" style="border: 0px !important; max-width: 800px; margin-top: -25px; margin-bottom: -60px; margin-left: -15px; margin-right: 0px;" border="0">
			<div style="max-width: 800px;" class="table" border="0">

				<form id="form1" name="form1" method="post">	
				<div class="row" style="margin-left: 0px; margin-right: 0px;">
					<div class="col-xs-12 col-md-12">
						
						<div class="bs-callout bs-callout-warning" style="margin-right: -10px;"> 
							<div class="row alert-message-warning" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px;">
								<label class="control-label" style="margin-left: 2%; margin-top: 5px;"> <i class="glyphicon glyphicon-calendar"> </i> &nbsp; <%= lb_downloaddata %> [<%= file_type %>] </label>
							</div>
							<p>
							<div class="row">
								<div class="col-xs-12 col-md-12">
									<div class="row" style="margin-top: 0px; margin-bottom: -4px;">
										<table class="table table-bordered table-hover" id="data_file" name="data_file" align="center" border="0" style="max-width: 98% !important; margin-bottom: -5px;">
											<thead>
												<tr>
													<th width="15%" style="text-align: center;"> </th>
													<th width="75%" style="text-align: center; min-width: 420px;"> <%= path %> </th>
													<th width="10%" style="text-align: center; min-width: 100px;"> <%= lb_download %> </th>
												</tr>
											</thead>
											<tbody>
										
										<%	try{	
												//File files = new File(path + file_type);
												File files = new File(path);
												if (files.exists()) {
													String [] fileNames = files.list();
													File [] fileObjects = files.listFiles();
													
													for (int i = 0; i < fileObjects.length; i++) {
														if(!fileObjects[i].isDirectory()){
										%>
												<tr>
													<td align="center"> <%= fileNames[i] %> </td>
													<td class="pad-left-10" style="max-width: 240px;">
														<%= fileNames[i] %> &nbsp; ( <%= Long.toString(fileObjects[i].length()) %> bytes )
													</td>
													<td align="center" style="max-width: 100px;"> 
														<a href="#" onClick="downloadSingleFile('<%= fileNames[i] %>');" style="color: #eb9826;"> <i class="glyphicon glyphicon-download-alt" data-toggle="tooltip" data-placement="left" title="<%= lb_download %>"> </i> </a> 
													</td>
												</tr>
											<%     		}
													}
												}
											}catch(Exception  e){
												out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");	
											}
										%>
										
											</tbody>
										</table>
										<input type="button" class="btn btn-warning btn-sm max-height-26 button-shadow1 button-shadow2" name="btn_multi" id="btn_multi" style="margin-left: 8px;" value=" <%= lb_download_filezip %> " onMouseOver="this.style.cursor='hand';"> </input>
										<input type="hidden" name="check_file" id="check_file">
										<input type="hidden" name="path" id="path" value="<%= (path).replace("\\", "?") %>">
										<input type="hidden" name="file_type" id="file_type" value="<%= file_type %>">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				</form>
			
			</div>
		</div>
		
		<div class="modal fade" id="myModalWarning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="false" data-keyboard="false">
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
		
		<div class="modal fade" id="myModalProcess" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="false" data-keyboard="false">
			<div class="modal-dialog" role="document">
				<div class="modal-content alert-message alert-message-notice">
					<div class="modal-body" align="center">
						<div class="table-responsive" style="border: 0px !important;" border="0"> 
							<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <img src="images/loading2.gif" width="48" height="48" align="absmiddle"> </div>
							<div class="col-xs-12 col-md-12" style="margin-bottom:  0px;"> <h4> <p> <%= lb_please_wait %> </p> </h4> </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<iframe src="" id="iframe_download" name="iframe_download" frameborder="0" style="margin-top: 50px;" height="0px" width="0px"> </iframe>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>