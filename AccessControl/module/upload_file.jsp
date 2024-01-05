<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.io.File"%>
<%@ page import ="java.awt.image.BufferedImage"%>
<%@ page import ="javax.imageio.ImageIO"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>

<%	
	String contentType = request.getContentType();	
    if((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)){
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
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\")+1,saveFile.indexOf("\""));
		String fileName = saveFile.substring(saveFile.lastIndexOf("\\",saveFile.length())+1,saveFile.length());
		String lastName = fileName.substring(fileName.indexOf(".")+1);
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex + 1,contentType.length());
		int pos;
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
		
		String fileSave = "";
		String typeFile = "";
		if(!(request.getParameter("type") == null || request.getParameter("type").equals("")
			|| request.getParameter("type").equals("null"))){
			typeFile = request.getParameter("type");
		}
		if(typeFile.equals("screen")){
			if(lastName.equals("bmp") || lastName.equals("BMP")){
				fileSave = path_data+"PIC.BMP";
			}
		}else if(typeFile.equals("video")){
			if(lastName.equals("mp4") || lastName.equals("MP4")){
				fileSave = path_Video+fileName;
			}
		}else if(typeFile.equals("slide")){
			if(lastName.equals("jpg") || lastName.equals("JPG") || lastName.equals("jpeg") || lastName.equals("JPEG")){
				fileSave = path_ImgSlide+fileName;
			}
		}else if(typeFile.equals("sound")){
			if(lastName.equals("mp3") || lastName.equals("MP3")){
				String typeSound = "";
				if(!(request.getParameter("typesound") == null || request.getParameter("typesound").equals("")
					|| request.getParameter("typesound").equals("null"))){
					typeSound = request.getParameter("typesound");
				}
				if(typeSound.equals("0")){
					fileName = "PassTh.mp3";
				}else if(typeSound.equals("1")){
					fileName = "PassEn.mp3";
				}else if(typeSound.equals("2")){
					fileName = "NoPassTh.mp3";
				}else if(typeSound.equals("3")){
					fileName = "NoPassEn.mp3";
				}else if(typeSound.equals("4")){
					fileName = "DutyITh.mp3";
				}else if(typeSound.equals("5")){
					fileName = "DutyIEn.mp3";
				}else if(typeSound.equals("6")){
					fileName = "DutyOTh.mp3";
				}else if(typeSound.equals("7")){
					fileName = "DutyOEn.mp3";
				}
				fileSave = path_AccSound+fileName;
			}
		}
		
		if(!fileSave.equals("")){
			FileOutputStream fileOut = new FileOutputStream(fileSave);
			fileOut.write(dataBytes, startPos, (endPos - startPos));
			fileOut.flush();
			fileOut.close();
			
			/*if(typeFile.equals("slide")){
				try{
					// Resize
					File files = new File(fileSave);
					BufferedImage img = ImageIO.read(files);
					if ((img.getWidth() != 800) && (img.getHeight() != 480)){
						ImageIO.write(resizeImage(img, 800, 480), "jpg", new File(fileSave));
					}
				}catch(IOException e){ }
			}*/
		}
	}	
%>

<%@ include file="../function/disconnect.jsp"%>