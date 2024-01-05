<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Formatter"%>
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.awt.image.BufferedImage"%>
<%@ page import="java.awt.Graphics2D"%>
<%@ page import="javax.imageio.ImageIO"%>
<%@ page import="javax.servlet.ServletException"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="com.sun.org.apache.xerces.internal.impl.dv.util.Base64"%>

<%!	
	protected final byte[] HexDigits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd',
			'e', 'f' };
			
	public boolean getDirectory(String path) {
		boolean result = false;
		String dir = System.getProperty("user.dir").concat(path);
		File file = new File(dir);
		result = file.mkdirs();
		return result;
	}

	public boolean makeDirectory(String path) {
		boolean result = false;
		File file = new File(path);
		if (!file.exists()) {
			try {
				result = file.mkdir();
			} catch (SecurityException se) {

			}
		} else {
			result = true;
		}
		return result;
	}

	public String readFile(String path) {
		String result = "";
		try {
			BufferedReader br = null;
			try {
				br = new BufferedReader(
						new InputStreamReader(new FileInputStream("C:\\Tomcat 6.0\\" + path), "tis-620"));
				String message = "";
				while ((message = br.readLine()) != null) {
					result += message + "\n";
				}
			} catch (IOException e) {
				System.out.println("I/O Error, Can't Access File");
			} finally {
				if (br != null) {
					br.close();
				}
			}
		} catch (Exception ex) {
			System.out.println("Exception:" + ex.getMessage());
		}
		return result;
	}

	public boolean openFileExcel(String fileName, HttpServletResponse response) {
		boolean result = false;
		try {
			ServletOutputStream outStream = null;
			BufferedInputStream inStream = null;
			File myfile = null;
			try {
				myfile = new File(fileName);
				if (myfile.exists()) {
					outStream = response.getOutputStream();
					// set response headers
					response.setContentType("text/plain");
					response.setContentLength((int) myfile.length());
					response.addHeader("Content-Disposition", "attachment; filename=" + myfile);
					FileInputStream input = new FileInputStream(myfile);
					inStream = new BufferedInputStream(input);
					int readBytes = 0;
					// read from the file; write to the ServletOutputStream
					while ((readBytes = inStream.read()) != -1) {
						outStream.write(readBytes);
					}
					result = true;
				}
			} catch (IOException ioe) {
				System.out.println("IOException:" + ioe.getMessage());
			} finally {
				// close the input/output streams
				if (outStream != null) {
					outStream.flush();
					outStream.close();
				}
				if (inStream != null) {
					inStream.close();
				}
				if (myfile.exists()) {
					myfile.delete();
				}
			}
		} catch (Exception ex) {
			System.out.println("Exception:" + ex.getMessage());
		}
		return result;
	}

	public boolean downloadFile(String path, String fileName, HttpServletResponse response) {
		boolean result = false;
		try {
			ServletOutputStream outStream = null;
			DataInputStream inStream = null;
			File myfile = null;
			try {
				myfile = new File(path + "\\" + fileName);
				if (myfile.exists()) {
					outStream = response.getOutputStream();
					// set response headers
					response.setContentType("text/plain");
					response.setContentLength((int) myfile.length());
					response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
					FileInputStream input = new FileInputStream(myfile);
					inStream = new DataInputStream(new FileInputStream(myfile));
					int length = 0;
					byte[] bbuf = new byte[20];
					while ((inStream != null) && ((length = inStream.read(bbuf)) != -1)) {
						outStream.write(bbuf, 0, length);
					}
					result = true;
				}
			} catch (IOException ioe) {
			//	System.out.println("IOException:" + ioe.getMessage());
			} finally {
				// close the input/output streams
				if (outStream != null) {
					outStream.flush();
					outStream.close();
				}
				if (inStream != null) {
					inStream.close();
				}
				if (myfile.exists()) {
					myfile.delete();
				}
			}
		} catch (Exception ex) {
		//	System.out.println("Exception:" + ex.getMessage());
		}
		
		return result;
	}
	
	public byte[] readFileToByte(String fileName) throws IOException {
		//if (checkFileOnly(fileName)) {
			File file = new File(fileName);
			byte[] result = new byte[(int) file.length()];
			FileInputStream fIn = null;
			try {
				fIn = new FileInputStream(file);
				fIn.read(result);
			} catch (FileNotFoundException e) {
				result = null;
			} catch (IOException e) {
				result = null;
			} finally {
				try {
					if (fIn != null) {
						fIn.close();
					}
				} catch (Exception e) {

				}
			}
			return result;
		//} else {
		//	return null;
		//}
	}
	
	public byte[] getBytesFromFile(File file) throws IOException {
		byte[] result;
		InputStream is = null;
		try {
			is = new FileInputStream(file);
			long length = file.length();
			if (length > Integer.MAX_VALUE) {
				// File is too large (>2GB)
				System.out.println("File is too large (>2GB)");
			}
			result = new byte[(int) length];

			// Read in the bytes
			int offset = 0;
			int numRead = 0;
			while (offset < result.length && (numRead = is.read(result, offset, result.length - offset)) >= 0) {
				offset += numRead;
			}

			// Ensure all the bytes have been read in
			if (offset < result.length) {
				throw new IOException("Could not completely read file " + file.getName());
			}
		} finally {
			// Close the input stream and return bytes
			if (is != null) {
				is.close();
			}
		}
		return result;
	}
	
	// resize picture
	public BufferedImage resizeImage(BufferedImage originalImage, int IMG_WIDTH, int IMG_HEIGHT) {
		int type = BufferedImage.SCALE_SMOOTH;
		BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
		g.dispose();
		return resizedImage;
	}
	
	public String byteToHex(byte[] bytes) {
		StringBuilder result = new StringBuilder(2 * bytes.length);
		for (int i = 0; i < bytes.length; i++) {
			int v = bytes[i] & 0xFF;
			result.append((char) HexDigits[v >> 4]);
			result.append((char) HexDigits[v & 0xF]);
		}
		return result.toString();
	}
	
	public byte[] hexToByte(String hexStr) {
		String chunk = null;
		byte[] result = null;
		if (hexStr != null && hexStr.length() > 0) {
			int numBytes = hexStr.length() / 2;
			result = new byte[numBytes];
			int offset = 0;
			for (int i = 0; i < numBytes; i++) {
				chunk = hexStr.substring(offset, offset + 2);
				offset += 2;
				result[i] = (byte) (Integer.parseInt(chunk, 16) & 0xFF);
			}
		}
		return result;
	}
	
	public String convertHexToString(String hex){
		String result = "";
		hex = hex.trim();
		if (hex != null && hex.length() > 0) {
			int numBytes = hex.length() / 2;
			byte[] bytes = new byte[numBytes];
			int offset = 0;
			int bCounter = 0;
			String chunk = "";
			for (int i = 0; i < numBytes; i++) {
				chunk = hex.substring(offset, offset + 2);
				offset += 2;
				try {
					bytes[i] = (byte) (Integer.parseInt(chunk, 16) & 0x000000FF);
				} catch (Exception e) {
					result = "Hex Code Error";
					bCounter = 1;
					break;
				}
			}
			if (bCounter != 1) {
				result = new String(bytes);
				// result = new String(bytes, Charset.forName(fontThaiByte));
			}
		}
		return result;
	}
	
	public String convertStringToHex(String data) {
		if (data == null) {
			return null;
		} else {
			byte[] rawData = data.getBytes();
			StringBuffer hexText = new StringBuffer();
			String initialHex = null;
			int initHexLength = 0;
			for (int i = 0; i < rawData.length; i++) {
				int positiveValue = rawData[i] & 0x000000FF;
				initialHex = Integer.toHexString(positiveValue);
				initHexLength = initialHex.length();
				while (initHexLength++ < 2) {
					hexText.append("0");
				}
				hexText.append(initialHex);
			}
			return hexText.toString();
		}
	}

	public String bytesToHexString(byte bytes[]) {
		StringBuilder sb = new StringBuilder(bytes.length * 2);
		Formatter formatter = new Formatter(sb);
		for (byte b : bytes) {
			formatter.format("%02x", b);
		}
		return sb.toString();
	}
	
	public String getIP(String ip) {
		String result = "";
		ip = ip.replace('.', ',');
		ip = ip.replace(':', ',');
		String[] ip_arr = ip.split(",");
		for (int i = 0; i < ip_arr.length; i++) {
			result = result + ip_arr[i];
		}
		return result;
	}
	
	public String getHostIPAddress() {
		String result = "";
		try {
			result = InetAddress.getLocalHost().getHostAddress();
		} catch (Exception e) {

		}
		return result;
	}
	
	public String splitIP(String ip, int position) {
		String result = "";
		try {
			int startpoint = 0;
			int endpoint = 0;
			if ((position < 1) || (position > 4)) {
				result = "xxx";
			} else {// if ((position < 1) || (position > 4));
				for (int l = 0; l < position; l++) {
					if (l < 3) {
						startpoint = endpoint;
						endpoint = ip.indexOf('.', startpoint);
						result = ip.substring(startpoint, endpoint);
						endpoint++;
					} else {// if (l < 3);
						startpoint = endpoint;
						result = ip.substring(startpoint);
					} // if (l < 3);
				} // for (int l = 0; l < position; l++);
			} // if ((position < 1) || (position > 4));
		} catch (Exception e) {
			result = "";
		}
		return result;
	}
	
	public String splitMAC(String mac, int position) {
		String result = "";
		try {
			int startpoint = 0;
			int endpoint = 0;
			if ((position < 1) || (position > 6)) {
				result = "00";
			} else {
				for (int l = 0; l < position; l++) {
					if (l < 5) {
						startpoint = endpoint;
						endpoint = mac.indexOf(':', startpoint);
						result = mac.substring(startpoint, endpoint);
						endpoint++;
					} else {
						startpoint = endpoint;
						result = mac.substring(startpoint);
					}
				}
			}
		} catch (Exception e) {
			result = "";
		}
		
		return result;
	}

	public String removeLeadingZeros(String data) {
		String result = "";
		try {
			Integer intVal = Integer.parseInt(data);			 
			result = intVal.toString();
		} catch (Exception e) {
         
		}
		return result;
	}
	
	public String subStrPublicID(String data) {
		String result = "";
		// format = x-xxxx-xxxxx-xx-x
		if (data.length() == 17) {
			result = data.substring(0, 1) + data.substring(2, 6) + data.substring(7, 12) + data.substring(13, 15)
					+ data.substring(16, 17);
		}
		return result;
	}

	public String subStrPhone(String data) {
		String result = "";
		// format = xxx-xxx-xxxx
		if (data.length() == 12) {
			result = data.substring(0, 3) + data.substring(4, 7) + data.substring(8, 12);
		}
		return result;
	}
	
	public String chkSNCard(String data) {
		String result = "";
		if (data.length() == 8 || data.length() == 14) {
			result = data;
		}
		return result;
	}

	public String chkIssue(String data) {
		String result = "";
		if ((data.length() == 1) || (data.length() == 2)) {
			result = data;
		} else {
			result = "1";
		}
		return result;
	}

	public String chkPincode(String data) {
		String result = "";
		if (data.length() == 4) {
			result = data;
		}
		return result;
	}

	public boolean chkPatternCode(String data){
		boolean result = false;
		Pattern pattern1 = Pattern.compile("[a-zA-Z0-9]*");
		Pattern pattern2 = Pattern.compile("[0-9a-zA-Z]*");	
		if (pattern1.matcher(data).matches() || pattern2.matcher(data).matches()) {
			result = true;
		}
		return result;
	}
		
	public boolean chkPatternSNCard(String data){
		boolean result = false;
		Pattern pattern1 = Pattern.compile("[a-fA-F0-9]*");
		Pattern pattern2 = Pattern.compile("[0-9a-fA-F]*");
		if (pattern1.matcher(data).matches() || pattern2.matcher(data).matches()) {
			result = true;
		}
		return result;
	}
	
	public boolean chkPatternCardID(String data){
		boolean result = false;
		Pattern pattern1 = Pattern.compile("\\d{13}",13);
		if (pattern1.matcher(data).matches()) {
			result = true;
		}
		return result;
	}
	
	public boolean chkPatternIssue(String data){
		boolean result = false;
		Pattern pattern1 = Pattern.compile("\\d{1}",1);
		Pattern pattern2 = Pattern.compile("\\d{2}",2);
		if (pattern1.matcher(data).matches() || pattern2.matcher(data).matches()) {
			result = true;
		}
		return result;
	}
	
	public boolean chkPatternPinCode(String data){
		boolean result = false;
		Pattern pattern1 = Pattern.compile("\\d{4}",4);
		if (pattern1.matcher(data).matches()) {
			result = true;
		}
		return result;
	}
		
	public boolean chkPatternDate(String data){
		boolean result = false;
		Pattern pattern1 = Pattern.compile("(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[012])/((19|20|21)\\d\\d)");		
		if (pattern1.matcher(data).matches()) {
			result = true;
		}
		return result;
	}
	
	public boolean chkPatternTime(String data){
		boolean result = false;
		Pattern pattern1 = Pattern.compile("([01]?[0-9]|2[0-3])[0-5][0-9][0-5][0-9]");		
		if (pattern1.matcher(data).matches()) {
			result = true;
		}
		return result;
	}
	
	public boolean chkPatternTime2(String data){	//	HH:MM
		boolean result = false;
		Pattern pattern1 = Pattern.compile("([0-9]|0[0-9]|1[0-9]|2[0-3]):([0-9]|[0-5][0-9])");		
		if (pattern1.matcher(data).matches()) {
			result = true;
		}
		return result;
	}
	
	public boolean chkCharacterEng(String data){
		boolean result = false;
		Pattern pattern1 = Pattern.compile("[a-zA-Z]");		
		if (pattern1.matcher(data).matches()) {
			result = true;
		}
		return result;
	}
	
	public boolean chkPatternPhone(String data) {
		boolean result = false;
		Pattern pattern1 = Pattern.compile("\\d{10}");
		Pattern pattern2 = Pattern.compile("\\d{3}-\\d{7}");	
		Pattern pattern3 = Pattern.compile("\\d{3}-\\d{3}-\\d{4}");		
		if (pattern1.matcher(data).matches() || pattern2.matcher(data).matches() || pattern3.matcher(data).matches()) {
			result = true;
		}
		return result;
	}

	public boolean chkPatternEmail(String data) {
		boolean result = false;	
		Pattern pattern1 = Pattern.compile("^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$");		
		if (pattern1.matcher(data).matches()) {
			result = true;
		}
		return result;
	}
	
	public boolean checkPermission(int your_sesion, String permission) {
		boolean result = false;
		for(int i = 0; i < permission.length(); i++){
			if(your_sesion == Integer.parseInt(permission.substring(i, i +1))){
				result = true;
				break;
			}
		}
		return result;
	}
	
	public boolean checkPermissionNot(int your_sesion, int permission) {
		boolean result = false;
		if(your_sesion != permission){
			result = true;
		}
		return result;
	}
	
	public String checkDataSelected(String data, String value) {
		String result = "";
		try {
			if (data.equals(value)) {
				result = "selected";
			} else {
				result = "";
			}
		} catch (Exception e) {
			result = "";
		}
		return result;
	}
	
	public String checkValuesList(String[] dataList) {
		String result = "";
		for (int i = 0; i <= dataList.length - 1; i++) {
			if (i != dataList.length - 1) {
				result = result + dataList[i] + ",";
			} else {
				result = result + dataList[i];
			}
		}
		return result;
	}
	
	public String checkSelectQryDataList(String dataQuery, String[] dataList){
		String result = "";
		try{
			if(dataList.length > 0){
				for(int i = 0; i < dataList.length; i++){
					if(dataQuery.equals(dataList[i])){
						result = "selected";
						break;
					}
				}
			}
		} catch(Exception e) {
		
		}
		return result;
	}
	
	public Integer checkScreen(String screens){
		int result = 0;
		if(screens == null){
			result = 1; //กรณีเข้ามาหน้าแรก
		}else{
			result = Integer.parseInt(screens);  //กรณีกด link หน้า เข้ามา
		}		
		return result;
	}
	
	public String subStringCharAt(String data, int position) {
		String result = "";
		try {
			result = Character.toString(data.charAt(position));
		} catch (Exception e) {
			result = "";
		}
		if (result.trim().equals("")) {
			result = " ";
		}
		return result;
	}	
	
	public String getFileNameUpload(HttpServletRequest request, String contentType) {
		String result = "";
		try {
			DataInputStream dataIn = new DataInputStream(request.getInputStream());
			int dataLength = request.getContentLength();
			byte dataBytes[] = new byte[dataLength];
			int totalBytesRead = 0;
			while (totalBytesRead < dataLength) {
				totalBytesRead += dataIn.read(dataBytes, totalBytesRead, dataLength);
			}
			dataIn.close();

			String data = new String(dataBytes);
			String fileName = data.substring(data.indexOf("filename=\"") + 10);
			fileName = fileName.substring(0, fileName.indexOf("\n"));
			fileName = "upload\\" + fileName.substring(fileName.lastIndexOf("\\") + 1, fileName.indexOf("\""));
			result = fileName;

			int lastIndex = contentType.lastIndexOf("=") + 1;
			String boundary = contentType.substring(lastIndex, contentType.length());

			int pos = data.indexOf("filename=\"");
			pos = data.indexOf("\n", pos) + 1;
			pos = data.indexOf("\n", pos) + 1;
			pos = data.indexOf("\n", pos) + 1;

			int boundaryLocation = data.indexOf(boundary, pos) - 4;
			int startPos = ((data.substring(0, pos)).getBytes()).length;
			int endPos = ((data.substring(0, boundaryLocation)).getBytes()).length;

			FileOutputStream fileOut = new FileOutputStream(fileName);
			fileOut.write(dataBytes, startPos, (endPos - startPos));
			fileOut.flush();
			fileOut.close();
		} catch (IOException e) {

		}
		return result;
	}
	
	public String setFormatString(String data, String dataReplace, int maxLength) {
		String result = data;
		for(int i = data.length(); i < maxLength; i++){
			result += dataReplace;
		}
		return result;
	}
	
	public synchronized String getCrcASCII(byte[] byte_id, byte[] byte_template, byte[] byte_card) {
		String crc = null;
		char tmp = 0;

		tmp = (char) ((byte) byte_id[0] & 0xFF);
		for (int i = 1; i < byte_id.length; i++) {
			tmp = tmp ^= (char) ((byte) byte_id[i] & 0xFF);
		}

		if (byte_template != null) {
			for (int i = 0; i < byte_template.length; i++) {
				tmp = tmp ^= (char) ((byte) byte_template[i] & 0xFF);
			}
		}

		for (int i = 0; i < byte_card.length; i++) {
			tmp = tmp ^= (char) ((byte) byte_card[i] & 0xFF);
		}

		tmp = (char) ((byte) tmp & 0xFF);
		crc = Integer.toHexString(tmp).toUpperCase();
		if (crc.length() == 1)
			crc = "0" + crc;

		return crc;
	}
	
	public synchronized String getCrcASCII(byte[] byte_data) {
		String crc = null;
		char tmp = 0;

		tmp = (char) ((byte) byte_data[0] & 0xFF);
		for (int i = 1; i < byte_data.length; i++) {
			tmp = tmp ^= (char) ((byte) byte_data[i] & 0xFF);
		}

		tmp = (char) ((byte) tmp & 0xFF);
		crc = Integer.toHexString(tmp).toUpperCase();
		if (crc.length() == 1)
			crc = "0" + crc;

		return crc;
	}
	
	public String getBrowserInfo(String Information) {
		String browsername = "";
		String browserversion = "";
		String browser = Information;
		
		if(browser.contains("MSIE")){
			String subsString = browser.substring(browser.indexOf("MSIE"));
			String Info[] = (subsString.split(";")[0]).split(" ");
			browsername = "Internet Explorer";	//	Info[0];
			browserversion = Info[1];
		}else if(browser.contains("rv")){		//	Use for IE 11 Not Compatibility View Only. ***
			String subsString = browser.substring(browser.indexOf("rv"));
			String Info[] = (subsString.split("0")[0]).split(":");
			browsername = "Internet Explorer";	//	Info[0];
			browserversion = Info[1] + "0";
		}else if(browser.contains("Edge")){
			String subsString = browser.substring(browser.indexOf("Edge"));
			String Info[] = (subsString.split(" ")[0]).split("/");
			browsername = "Microsoft EdgeHTML";	//	Info[0];
			browserversion = Info[1];
		}else if(browser.contains("Firefox")){
			String subsString = browser.substring(browser.indexOf("Firefox"));
			String Info[] = (subsString.split(" ")[0]).split("/");
			browsername = "Mozilla Firefox";	//	Info[0];
			browserversion = Info[1];
		}else if(browser.contains("Chrome")){
			String subsString = browser.substring(browser.indexOf("Chrome"));
			String Info[] = (subsString.split(" ")[0]).split("/");
			browsername = "Google Chrome";		//	Info[0];
			browserversion = Info[1];
		}else if(browser.contains("Opera")){
			String subsString = browser.substring(browser.indexOf("Opera"));
			String Info[] = (subsString.split(" ")[0]).split("/");
			browsername = "Opera";				//	Info[0];
			browserversion = Info[1];
		}else if(browser.contains("Safari")){
			String subsString = browser.substring(browser.indexOf("Safari"));
			String Info[] = (subsString.split(" ")[0]).split("/");
			browsername = "Apple Safari";		//	Info[0];
			browserversion = Info[1];
		}
		
		if(!browsername.equals("")){
			browser = browsername + " Ver." +browserversion;
		}else{
			browser = "Unknown browser";
		}
		
		return browser;
	}
	
	public String decodeToImage(String imageString, String typePhoto) {
		try {
			BufferedImage image = ImageIO.read(new File(imageString));
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ImageIO.write(image, typePhoto, baos);
			byte[] res = baos.toByteArray();
			imageString = Base64.encode(baos.toByteArray());
		} catch(Exception e) { }
		return imageString;
    }
	/*
	public String WriteTextAppend(String location_file, String data, boolean newline) {
		boolean result = true;
		try{
			BufferedWriter writer = new BufferedWriter(new FileWriter(location_file, true));	//	Set true for append mode
			writer.write(data);
			if(newline){
				writer.newLine();	//	Add new line
			}
			writer.close();
		}catch(IOException ioe){
			result = false;
		}
		return result;
	}
	
	public String copyFileUsingStream(File source, File dest) {
	    String result = "";
		InputStream is = null;
	    OutputStream os = null;
	    try {
	    	if(!dest.exists()){
		        is = new FileInputStream(source);
		        os = new FileOutputStream(dest);
		        byte[] buffer = new byte[1024];
		        int length;
		        while ((length = is.read(buffer)) > 0) {
		            os.write(buffer, 0, length);
		        }
	    	}else{
	    		try {
	    			BufferedReader buffer = new BufferedReader(new FileReader(source));
	    			String line;
	    			while ((line = buffer.readLine()) != null) {
	    	    		WriteTextAppend(dest.toString(), line, true);
	    			}
	    			buffer.close();
	    		} catch (IOException e) {
	    			result = "2";
	    		}
	    	}
		}catch(IOException ioe){
			result = "1";
		} finally {
	    	if(is != null){
	    		is.close();
	    	}
	    	if(os != null){
	    		os.close();
	    	}
	    }
		return result;
	}
	
	public String moveFileToBackup(File source, File x, File y ) {
	    String result = "";
	    String backupFile = FileConfig.tmp_backup + source.toString().substring((source.toString().lastIndexOf("\\") + 1), source.toString().length());
        Path movefrom = FileSystems.getDefault().getPath(source.toString());
        Path target = FileSystems.getDefault().getPath(backupFile);
		
        if(!new File(backupFile).exists()){
            try {
                Files.move(movefrom, target, StandardCopyOption.REPLACE_EXISTING);
            } catch (IOException e) {
    			result = "1";
            }
        }else{
    		try {
    			BufferedReader br = new BufferedReader(new FileReader(source));
    			String line;
    			while ((line = br.readLine()) != null) {
					WriteTextAppend(backupFile, line, true);
    			}
    			br.close();
    		} catch (IOException e) {
    			result = "2";
    		}
			
    		File file = new File(source.toString());
    	//	boolean result = Files.deleteIfExists(file.toPath());
			if(!Files.deleteIfExists(file.toPath())){
				result = "3";
			}
        }
		return result;
	}
	*/
%>