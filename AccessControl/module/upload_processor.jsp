<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.List"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>

<%
    // 1. Specify the destination path.
    //String savePath = java.io.File.separator + "photos";	
    //String absolutePath = request.getServletContext().getRealPath(savePath);
	String absolutePath = path_EmpPhotos;
    
    // check and make directory
    File fileSaveDir = new File(absolutePath);
    if (!fileSaveDir.exists()) {
        fileSaveDir.mkdirs();
    }

    int fileCount = 0;
    
    // 2. check Multipart Request 
    if (ServletFileUpload.isMultipartContent(request)) {
        try {
            ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
			List<FileItem> items = (List<FileItem>) upload.parseRequest(request);

            for (FileItem item : items) {
                if (!item.isFormField() && item.getSize() > 0) { 
                    String fileName = new File(item.getName()).getName();
					File storeFile = new File(fileSaveDir, fileName);

                    // write file to Disk [Apache Commons](https://commons.apache.org)
                    item.write(storeFile);
                    fileCount++;
                }
            }
            // response to JavaScript (XHR)
            			
			out.clear(); 
			if (fileCount > 0) {
				out.print("total " + fileCount + " files");
			} else {
				out.print("file not found for upload");
			}
			//out.println("<script>alert('phoo action');</script>");
			//out.println("<script>location.href='act_employee.jsp?action=check_file';</script>");
			out.flush();
	
        } catch (Exception ex) {
            response.setStatus(500);
			out.clear();
            out.print("Error: " + ex.getMessage());
        }		
    }
%>

<%@ include file="../function/disconnect.jsp"%>