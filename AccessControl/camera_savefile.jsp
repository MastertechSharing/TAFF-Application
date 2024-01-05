<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="org.apache.commons.codec.binary.*"%>
<%@ page import="org.apache.commons.io.*"%>

<%	
	String action =	(String) session.getAttribute("action_capture");
	String idcard = (String) session.getAttribute("idcard_capture");
	String username = (String) session.getAttribute("ses_username");
	
	try {
		HttpServletRequestWrapper wrappedRequest = new HttpServletRequestWrapper(request);
		InputStream is = wrappedRequest.getInputStream();
		StringWriter writer = new StringWriter();
		IOUtils.copy(is, writer, "UTF-8");
		String imageString = writer.toString();
		imageString = imageString.substring("data:image/jpeg;base64,".length());
		
		byte[] contentData = imageString.getBytes();
		byte[] decodedData = Base64.decodeBase64(contentData);
		String imgName = "";
	//	if(action.equals("add")){
			imgName = getServletContext().getRealPath("/") + "photos\\tmpCapture\\CaptureBy-"+username+".jpg";
	//	}else if(action.equals("edit")){
	//		imgName = getServletContext().getRealPath("/") + "photos\\"+idcard+".jpg";
	//	}
		FileOutputStream fos = new FileOutputStream(imgName);
		fos.write(decodedData);
		fos.close();
	} catch (Exception e) { } 
	
%>