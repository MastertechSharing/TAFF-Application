<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>
<%	
	session.setAttribute("page_g", "special"); 
	session.setAttribute("subpage", "importfile");
	session.setAttribute("subtitle", "type");	
	session.setAttribute("action", "file_upload_type.jsp?");
	String text_result = "", type_alert = "success", type_glyphicon = "ok-circle";
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script language="javascript" src="js/alert_box.js"></script> 
		<script language="javascript" src="js/check_input.js"></script>
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-filestyle.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
 
		<script>
			document.onkeydown = searchKeyPress_tool;
			
			$(":file").filestyle({ buttonBefore: true });
		</script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>
		
		<br/>
		
		<%@ include file="../tools/modal_warning.jsp"%>
		<%@ include file="../tools/modal_result.jsp"%>
		<%@ include file="../tools/modal_danger.jsp"%>
<%	
	int pass = 0;
	int no_pass = 0;
	int countall = 0;
	ArrayList msgerr = new ArrayList();
	String[] data_arr;
	String message = "";
	String sql = "";

	String contentType = request.getContentType();
	if((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)){
		
		String pathUpload = path_data.substring(0, (path_data.length() -6))+"\\Upload";
		makeDirectory(pathUpload); 
		
		DataInputStream in = new DataInputStream(request.getInputStream());
        int formDataLength = request.getContentLength();
        byte dataBytes[] = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;
        while(totalBytesRead < formDataLength){
            byteRead = in.read(dataBytes, totalBytesRead,formDataLength);
            totalBytesRead += byteRead;
        }
		
        String file = new String(dataBytes);
        String saveFile = file.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\") +1, saveFile.indexOf("\""));
		String fileName = saveFile.substring(saveFile.lastIndexOf("\\",saveFile.length()) +1, saveFile.length());
		String lastName = fileName.substring(fileName.indexOf(".") +1);
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex +1, contentType.length());
		int pos;
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
		
		String pathName = pathUpload;	//	 System.getProperty("user.dir");
	//	String fileName = getFileNameUpload(request, contentType);
	//	String lastName = fileName.substring(fileName.indexOf(".") +1);
		
		String fileSave = pathName+"\\"+fileName;
		if(!fileSave.equals("")){
			FileOutputStream fileOut = new FileOutputStream(fileSave);
			fileOut.write(dataBytes, startPos, (endPos - startPos));
			fileOut.flush();
			fileOut.close();
		}else{
			out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror5+"'); </script>");
		}
		
		if((fileName != "") && (lastName.equals("TXT") ||lastName.equals("txt") || lastName.equals("CSV") || lastName.equals("csv"))){
			try{
				rc.WriteDataLogFile("["+ses_user+"] Upload File Type [dbtype]");
				boolean chk_data = true;
				BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(pathName+"\\"+fileName),"tis-620"));
				int rec_no = 0;
				while((message = br.readLine()) != null){
					chk_data = true;
					rec_no++;
					if(rec_no == 1 || message.trim().length() == 0){
						continue;
					}
					if(message.length() > 250){
						message = message.substring(0, 250);
					}
					data_arr = (message+",#").split(",");
					
					boolean ckCode = chkPatternCode(data_arr[0].trim());
					if(!ckCode || data_arr.length != 4 || data_arr[0].length() > 6){
						msgerr.add(message+" -->("+lb_format_file_err+")");
						no_pass++;
					}else{
						sql = "INSERT INTO dbtype(type_code,th_desc,en_desc) VALUES ('"+data_arr[0]+"','"+data_arr[1]+"','"+data_arr[2]+"')";										
						try{
							resultQry = stmtUp.executeUpdate(sql);
							rc.WriteDataLogFile("["+ses_user+"] Insert type_code : " + data_arr[0] + " [dbtype]");
							pass++;
						}catch(SQLException e){
							if(resultQry != 1){
								sql = "UPDATE dbtype SET th_desc='"+data_arr[1]+"' ,en_desc='"+data_arr[2]+"' WHERE (type_code = '"+data_arr[0]+"')";
								try{
									stmtUp.executeUpdate(sql);
									rc.WriteDataLogFile("["+ses_user+"] Update type_code : " + data_arr[0] + " [dbtype]");
									pass++;
								}catch(SQLException eupdate){
									msgerr.add(message+" -->("+eupdate.getMessage()+")");
									no_pass++;
								}
							}
						}
					}
					countall++;
				}
				br.close();
				
				if((!chk_data)){
					out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror4+"'); </script>");//	ไม่มีข้อมูล
				}else if(no_pass == 0){
					out.println("<script> ModalSuccess_NoParam('"+uploadFile_msgerror3+"'); </script>");//	การอัพโหลดข้อมูลสำเร็จ
				}else if(pass == 0){
					out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror1+"'); </script>");//	ไม่สามารถอัพโหลดข้อมูลได้ [ กรุณารอสักครู่ .... ]
				}else{
					out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror2+"'); </script>");//	ไม่สามารถอัพโหลดข้อมูลได้ครบ
				}
				rc.WriteDataLogFile("[" + ses_user + "] Record all "+countall+" records, Upload success "+pass+" records, Upload fail "+no_pass+" records [dbtype]");
			}catch(IOException e){
				out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror5+"'); </script>");
			}
		}else{
			out.println("<script> ModalDanger_10Second_NoReturn('"+uploadFile_msgerror6+"'); </script>");
		}
		File f1 = new File(pathName+"\\"+fileName);
		f1.delete();
	}				
%>
		<div class="body-display">
			<div class="container" style="margin-top: -20px;">
			
				<div class="col-md-1"> </div>
				<div class="col-md-10">
					<form name="form1" id="form1" enctype="multipart/form-data" method="post" action="file_upload_type.jsp">
						<div class="panel panel-primary"> 
							<div class="panel-heading">
								<h3 class="panel-title"> <b> <%= lb_typeemp %> </b> </h3> 
							</div> 
							<div class="panel-body"> 
							
								<div class="table-responsive" style="border: 0px !important;" border="0">
									<div style="min-width: 800px; max-width: 100%; margin-left: 15px; margin-right: 15px;" border="0">

										<div class="row">
											<label class="col-md-2 col-xs-2"> 
												<span class="glyphicon glyphicon-list-alt" style="margin-left: -15px; font-size: 16px;"> </span> &nbsp; <%= lb_dataformat %> 
											</label> 
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_typecode %> ( 6 <%= lb_letter %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_thdesc %> ( 100 <%= lb_letter2 %> ), </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<label class="col-md-10 col-xs-10" style="margin-top: 3px;"> <%= lb_endesc %> ( 100 <%= lb_letter2 %> ) </label> 
										</div>
										<div class="row">
											<div class="col-md-2 col-xs-2"> &nbsp; </div>
											<div class="col-md-6 col-xs-6">
												<input type="file" name="files" id="files" class="filestyle" data-buttonBefore="true" data-buttonText="&nbsp; Choose File" data-buttonName="btn-primary" data-size="md">
											</div>
											<div class="col-md-4 col-xs-4" align="right" style="margin-bottom: 0px;"> 
												<input type="button" name="upload" id="btnok" class="btn btn-primary btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= lb_upload %> &nbsp; &nbsp; &nbsp; " onclick="return checkInputFile(document.form1.files, '<%= alert_InputFile %>');">
											</div> 
										</div>
									</div> 
								</div>

							<%	if(msgerr.size() != 0){	%>
							
								<div class="table-responsive" style="border: 0px !important;" border="0">
									<div style="min-width: 800px; max-width: 100%; margin-top: 15px; margin-left: 15px; margin-right: 15px;" border="0">
							
										<div class="row">
											<label class="col-md-12"> 
												<div class="alert alert-danger" role="alert">
													<span class="glyphicon glyphicon-remove"> </span> <%= lb_incorrectdata %> &nbsp; <%= lb_notupload %> <%= no_pass %> <%= lb_reccorddata %> , &nbsp; <%= lb_uploadok %> <%= pass %> <%= lb_reccorddata %> , &nbsp; <%= lb_recordall %> <%= countall %> <%= lb_reccorddata %>
												</div>
											</label> 
										</div>
									<%		for (int i = 0; i < msgerr.size(); i++) {	%>
										<div class="row">
											<label class="col-md-12"> 
												<%= i + 1 + ". " + msgerr.get(i) %>
											</label> 
										</div>
									<%		}	%>
									
									</div> 
								</div>
								
							<%	}	%>
							
							</div> 
						</div>
					</form>
				</div>
				<div class="col-md-1"> </div>
				
			</div>
		</div> 
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>