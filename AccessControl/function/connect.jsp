<%@ page contentType="text/html; charset=tis-620" language="java" errorPage="../try_catch.jsp"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="util.ini.INIFileManager"%>

<%	
	INIFileManager rc = new INIFileManager();		
	String version = rc.getVersion();
	String db_driver = rc.getBaseDriver();
	String db_host = rc.getBaseHost();
	String db_database = rc.getBaseName();	
	String db_username = rc.getBaseUser();
	String db_password = rc.getBasePass();		
	String hostIPAddr = rc.getServerIPAddress();
	int mode = rc.getBaseType();
	int port3 = rc.getServerPort() + 3;
	int port4 = rc.getServerPort() + 4;
	String network_feature = Integer.toString(rc.getNetworkFeature());	
		
	String path_default = rc.getPathDefault();
	String path_default_txt = rc.getPathDefault()+"TXT\\";
	String path_default_std = rc.getPathDefault()+"STD\\";
	String path_data = rc.getPathData();
	String path_taff = rc.getPathTAFF();
	String path_tpl = rc.getPathTPL();
	String path_log = rc.getPathLOG();
	String path_err = rc.getPathERR();
	String path_raw = rc.getPathRAW();
	String path_Config = rc.getPathConfig();
	String path_Picture = rc.getPathPicture();
	String path_EmpPic = rc.getPathEmpPic();
	String path_Video = rc.getPathVideo();
	String path_ImgSlide = rc.getPathImgSlide();
	String path_AccSound = rc.getPathSound();		
	
	int ssTimeOut = rc.getSessionTimeOut();
	
	String className = "", URL = "";	
	if (mode == 0) { 		// ===== // [ MySQL ]
		className = db_driver;//"com.mysql.jdbc.Driver";
		URL = "jdbc:mysql://" + db_host + "/" + db_database + "?useUnicode=true&characterEncoding=TIS620&autoReconnect=true";
	} else if (mode == 1) { // ===== // [ SQL Server 2008 R2 ]
		className = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		URL = "jdbc:sqlserver://" + db_host + ";DatabaseName=" + db_database;		
	}
	
	try {
		Class.forName(className);// .newInstance();
	} catch (Exception e) {
		response.sendRedirect("../try_catch.jsp?error=" + e.getMessage());
	}

	Connection con = null;	
	try {
		con = DriverManager.getConnection(URL, db_username, db_password);
	} catch (SQLException sqle) {		
		response.sendRedirect("../try_catch.jsp?error=" + sqle.getMessage());
	}
	
	Statement stmtQry = con.createStatement();
	Statement stmtUp = con.createStatement();
	Statement stmtTmp = con.createStatement();
	Statement stmtSes = con.createStatement();
	if (mode == 1) {
		stmtQry = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		stmtUp = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		stmtTmp = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		stmtSes = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
	}

	int sizeSW = 0;
	try {
		String ver_soft = "";	
		ResultSet rs_company = stmtQry.executeQuery("SELECT * FROM dbcompany");
		if (rs_company.next()) {
			ver_soft = rs_company.getString("ver_soft");
			rs_company.close();
		}
		sizeSW = Integer.parseInt(ver_soft);
	} catch (Exception e) {
		
	}
	
	String title = rc.displayVersionSW(sizeSW, "5.7");
	session.setAttribute("sw_title", title);
	session.setAttribute("sw_version", version);
	NumberFormat nf1 = NumberFormat.getInstance();	
%>