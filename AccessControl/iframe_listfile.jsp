<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>

<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<script language="javascript" src="js/select_ajax.js"></script>
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>

		<style>
			.bs-callout-info {
				border-left-color: #1b809e;
			}
			.bs-callout {
				padding: 10px;
				margin: 10px 0;
				border: 1px solid #1b809e;
				border-left-width: 5px;
				border-radius: 3px;
			}
		</style>

		<script language="javascript">
			function add_valueID(p_id){
				var req = Inint_AJAX();
				req.onreadystatechange = function (){
					if(req.readyState == 4){
						if(req.status == 200){
							var ret = req.responseText;
							if(ret != null){
								parent.window.document.getElementById("files").value = p_id;
								
								window.top.$("#myModalViewDetail").modal('hide');
							}
						}
					}  
				};
				req.open("POST", "cmd_del_video.jsp");	//	Create connection
				req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620"); // set Header
				req.send("p_id="+p_id);	//	Send data
			}
			
			$(function(){
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</head>
 
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px;">
	
		<form name="form1" method="post">
		
			<div class="table-responsive" style="border: 0px !important;" border="0">
				<div style="min-width: 550px;" class="table" border="0">
				
					<div class="bs-callout bs-callout-info" style="margin-left: 5px; margin-right: 5px;"> 
						<div class="row">
						
							<table style="width: 96%;" class="table table-bordered table-hover" align="center" border="0">
								<thead>
									<tr class="active">
										<td width="10%" align="center"> <b> <%= lb_no %> </b> </td>
										<td width="80%" align="center"> <b> <%= lb_filename %> </b> </td>
										<td width="10%" align="center"> <b> <%= lb_select %> </b> </td>
									</tr>
								</thead>
								<tbody>
	<%  		
		String TempName = "tmplistfile_"+request.getParameter("listfile");	
		String sql = "CREATE TABLE  "+db_database+"."+TempName+" ("
			   + "numid int NOT NULL, "
			   + "filesname varchar(100) NOT NULL, "
			   + "PRIMARY KEY (numid) "
			   + ") ENGINE=MyISAM DEFAULT CHARSET=tis620 ROW_FORMAT=DYNAMIC;";			
		try{
			stmtUp.executeUpdate(dropTableTmpReport(db_database,TempName,mode));
			stmtUp.executeUpdate(sql);		
		}catch(SQLException e){
			out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");
		}
		
		String listFileName = "";
		if(request.getParameter("listfile").equals("vdo")){
			listFileName = "\\listVideo.txt";
		}else{
			listFileName = "\\listSlide.txt";
		}
		if (!listFileName.equals("")){
			int num = 1;
			String listFile = "";
			File folder = new File(path_data+"\\");
			File[] listOfFiles = folder.listFiles();
			for (int i = 0; i < listOfFiles.length; i++) {
				if (!listOfFiles[i].isFile()) {
					//	แสดงไฟล์ listSlide แต่ละ IP
					listFile = path_data+"\\"+listOfFiles[i].getName()+listFileName;	
					File chkList = new File(listFile);											
					if(chkList.exists()){
						BufferedReader in = new BufferedReader(new FileReader(listFile));
						String textStr = "";								
						while((textStr = in.readLine()) != null){
							sql = "INSERT INTO "+TempName+" (numid,filesname) VALUES ('"+(num++ )+"','"+textStr+"')";
							try{
								resultQry = stmtQry.executeUpdate(sql);																	
							}catch(SQLException e){}													
						} 
					}
				}
			}	
			
			num = 0;									
			String fileName = "";									
			ResultSet rs = stmtQry.executeQuery("SELECT filesname FROM "+TempName+" GROUP BY filesname");
			while(rs.next()){
				fileName = rs.getString("filesname");
				num++;
	%>
									<tr>
										<td align="center"> <%= num %> </td>
										<td class="pad-left-10"> <%= fileName %> </td>
										<td align="center"> 
											<img src="images/complete.gif" width="20" height="20" border="0" align="absmiddle" onMouseOver="this.style.cursor='hand';" onClick="add_valueID('<%= fileName %>');" data-toggle="tooltip" data-placement="left" title="<%= lb_select %>">
										</td>
									</tr>
	<%			
			}	
			rs.close();																							
		}
	%>
								</tbody>
							</table>							
						</div>
					</div>							
				</div>
			</div>			
		</form>		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>