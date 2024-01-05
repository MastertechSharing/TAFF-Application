<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import = "java.awt.image.BufferedImage"%>
<%@ page import = "javax.imageio.ImageIO"%>
<%@ page import = "java.io.File"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/utility.jsp"%>

<%	
	String filename = "";
	if(request.getParameter("filename") != null){
		filename = new String(request.getParameter("filename").getBytes("ISO8859_1"), "tis-620");
	}
	
	try{
		BufferedImage img = ImageIO.read(new File(application.getRealPath("/") + "photos\\" + filename));
		ImageIO.write(resizeImage(img, 640, 480), "jpg", new File(path_EmpPic + "\\" + filename));
		
		out.println(" <script> window.parent.document.getElementById('filename').value = '"+filename+"'; </script> ");
		
	}catch (IOException e){ 
		out.println(" <script> window.parent.document.getElementById('filename').value = ''; </script> ");
	}
%>

<%@ include file="../function/disconnect.jsp"%>