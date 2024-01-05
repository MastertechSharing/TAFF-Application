<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%	
	String action = "", path = "", file_type = "", filename = "", listfile = "";
	if(request.getParameter("action") != null){
		action = request.getParameter("action");
	}
	if(request.getParameter("path") != null){
		path = request.getParameter("path");	//	.replace("?", "\\");
	}
	if(request.getParameter("file_type") != null){
		file_type = request.getParameter("file_type");
	}
	
	if(request.getParameter("filename") != null){
		filename = request.getParameter("filename");
	}
	if(request.getParameter("listfile") != null){
		listfile = request.getParameter("listfile");
	}

	if(action.equals("single")){
		
		out.println("<script> "
				+ " 	location.href = 'DownloadTXTFile.do?typedownload=single&lang="+lang+"&path="+path+"&filetype="+file_type+"&filename="+filename+"' "
				+ " </script>");
			
	}else if(action.equals("multi")){
		
		out.println("<script> "
				+ " 	location.href = 'DownloadTXTFile.do?typedownload=multi&lang="+lang+"&path="+path+"&filetype="+file_type+"&listfile="+listfile+"' "
				+ " </script>");
		
	}else if(action.equals("backup_single")){
		
		out.println("<script> "
				+ " 	location.href = 'DownloadTXTFile.do?typedownload=backup_single&lang="+lang+"&path="+path+"&filetype="+file_type+"&filename="+filename+"' "
				+ " </script>");
			
	}else if(action.equals("backup_multi")){
		
		out.println("<script> "
				+ " 	location.href = 'DownloadTXTFile.do?typedownload=backup_multi&lang="+lang+"&path="+path+"&filetype="+file_type+"&listfile="+listfile+"' "
				+ " </script>");
		
	}
	
%>
	
<%	if(action.equals("single_") || action.equals("multi_") || action.equals("backup_single_") || action.equals("backup_multi_")){	%>
	
	<script src="js/jquery.min.js"></script>
	
	<script>
		$(document).ready(function() {
		<%	if(action.equals("single_")){	%>
			$('#form1').attr('action', 'file_download_txt_download.jsp?action=single&path=<%= path %>&file_type=<%= file_type %>&filename=<%= filename %>');
		<%	}else if(action.equals("multi_")){	%>
			$('#form1').attr('action', 'file_download_txt_download.jsp?action=multi&path=<%= path %>&file_type=<%= file_type %>&listfile=<%= listfile %>');
		<%	}else if(action.equals("backup_single_")){	%>
			$('#form1').attr('action', 'file_download_txt_download.jsp?action=backup_single&path=<%= path %>&file_type=<%= file_type %>&filename=<%= filename %>');
		<%	}else if(action.equals("backup_multi_")){	%>
			$('#form1').attr('action', 'file_download_txt_download.jsp?action=backup_multi&path=<%= path %>&file_type=<%= file_type %>&listfile=<%= listfile %>');
		<%	}	%>
			$('#form1').attr('target', 'iframe_download_sub');
			$('#form1').submit();
		});
		
		document.onreadystatechange = function () {
			if (document.readyState === "complete") {
				
			<%	if(action.equals("single_") || action.equals("multi_")){	%>
				parent.window.$('#data_file').DataTable().destroy(); 
				parent.window.LoadDataTable(false); 
			<%	}	%>
				parent.window.$('#myModalProcess').modal('hide'); 
				
			}
		}
	</script>
	
	<form id="form1" name="form1" method="post">	
		<iframe src="" id="iframe_download_sub" name="iframe_download_sub" frameborder="0" style="margin-top: 50px;" height="0px" width="0px"> </iframe>
	</form>
	
<%	}	%>
	
<%@ include file="../function/disconnect.jsp"%>