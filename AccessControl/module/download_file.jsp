<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>

<%	
	FileInputStream input = null;
	ServletOutputStream myOut = null;
	File myfile = null;
	try{
		myOut = response.getOutputStream();
		myfile = new File(request.getParameter("files"));
		if (myfile.exists()){
			//set response headers
			response.setContentType("text/plain");
			response.addHeader("Content-Disposition","attachment; filename="+myfile );
			response.setContentLength((int) myfile.length( ));
			input = new FileInputStream(myfile);
			int readBytes = 0;
			//read from the file; write to the ServletOutputStream
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
%>