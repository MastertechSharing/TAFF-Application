<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%	
	String iframe_emp = (String) session.getAttribute("iframe_emp");
	if(iframe_emp == null){
		session.setAttribute("page_g", "tool");
		session.setAttribute("subpage", "aboutcard");
		session.setAttribute("subtitle", "enrollfinger");
		session.setAttribute("action", "cmd_enroll_finger_report.jsp?");
	}
	
	String countip = "";
	if (session.getAttribute("ipcount") != null) { 
		countip = Integer.toString((Integer)session.getAttribute("ipcount"));
	}
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="css/taff.css" type="text/css">
		
		<!-- Bootstrap -->
		<link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">

		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script language="javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin-top: -50px;" onLoad="sendRequest(); ShowCurrentTime(); updateClock();">
		
		<div class="table-responsive" style="border: 0px !important; margin-bottom: -55px;" border="0">
			<table style="min-width: 550px;" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="100%" align="left" height="20" colspan="5" >
						<span style="font-family:Tahoma; color:Green;"><%= lb_total %>  <%= countip %> <%= lb_matchin %> &nbsp; <%= lb_start_time %> <span id="clock"> </span> <%= lb_min %> <%= lb_to_time %> <span id="lblTime"> </span> <%= lb_min %><span id="load"></span> </span>
					</td>
				</tr>  
			</table>
		
			<form action="#">
				<input name="command" id="command" type="hidden" value="<%= session.getAttribute("command") %>"/>
				<input name="refcode" id="refcode" type="hidden" value="<%= session.getAttribute("refcode") %>" />
				<input name="process_count" id="process_count" type="hidden" value="0" />
				<input name="lang" id="lang" type="hidden" value="<%= lang %>" />
			</form>	
		
			<table style="min-width: 550px; margin-bottom: 0px;" class="table table-hover" align="center" id="table1" border="0">
				<thead>
					<td width="5%" align="center"> <b> <%= lb_no %> </b> </td>
					<td width="20%" align="center"> <b> <%= lb_doorcode %> </b> </td>
					<td width="60%" align="center"> <b> <%= lb_description %> </b> </td>
					<td width="15%" align="center"> <b> <%= lb_result %> </b> </td>
				</thead>
			</table>
		</div>
		
	<%	if(iframe_emp != null){	%>
		<iframe src="" id="iframe_update_status" name="iframe_update_status" frameborder="0" width="0px" height="0px"></iframe>
	<%	}	%>	
	
	</body>
	
	<script>
		var request;
		var request_Command;
		function getRequestObject() {
		//	window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest()
			if (window.ActiveXObject) {
				return(new ActiveXObject("Microsoft.XMLHTTP"));
			}  else if (window.XMLHttpRequest) {
				return(new XMLHttpRequest());
			} else {
				return(null);
			}
		}
		 
		function checkIfContinue() {
			if(confirm("Do you want to continue?")){
				window.setTimeout('checkIfContinue()', 30*60*1000);  //start the timer again
			}  else {
				window.location = 'login.jsp';
			}
		}

		function sendRequest(address) {	
			request = getRequestObject();
			request.onreadystatechange = handleResponse;
			request_Command = document.getElementById("command").value; 
			
			var param ="command="+document.getElementById("command").value+
				  "&refcode="+document.getElementById("refcode").value+
				  "&retry="+document.getElementById("process_count").value+ 
				  "&lang="+document.getElementById("lang").value;
			
			request.open("POST", "GetResponse.do", true);
			request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			request.send(param);
		}

		function handleResponse() {
		//	setTimeout('checkIfContinue()', 30*60*1000);  //30 minutes
		//	sleep(1000);
			if (request.readyState == 4){
				if (request.status == 200){	
					try {
						//document.getElementById("load").innerHTML = '<img src="images/loading.gif" align="absmiddle"/>';
						var count = parseInt(document.getElementById("process_count").value);
						//var dt = new Date();
						var dt = new Date();
						var toHours = dt.getHours();
						var toMinutes = dt.getMinutes();
						var toSeconds = dt.getSeconds();
						
						// Pad the minutes and seconds with leading zeros, if required
						toMinutes = ( toMinutes < 10 ? "0" : "" ) + toMinutes;
						toSeconds = ( toSeconds < 10 ? "0" : "" ) + toSeconds;
						toHours = ( toHours > 24 ) ? toHours - 24 : toHours;
						var toTime = toHours + ":" + toMinutes + ":" + toSeconds ;

						var message = request.responseXML.getElementsByTagName("door")[0]; // check has xml  
						if (message != null){
							message = request.responseXML.getElementsByTagName("door");
							var ip;
							var door_id;
							var door_desc;				
							var result;				
							var data;				
							var num = 0;
							for (i = 0; i < message.length; i++){
								result	= message[i].childNodes[0].firstChild.nodeValue; 
								if (message[i].childNodes[2].firstChild.nodeValue != null){
									ip		  = message[i].childNodes[2].firstChild.nodeValue;
								}else{
									ip  	  = "---.---.---.---";
								}
								if (message[i].childNodes[3].firstChild.nodeValue != null){						
									door_id   = message[i].childNodes[3].firstChild.nodeValue;
								}else{
									door_id   = "----";
								}
								if (message[i].childNodes[4].firstChild.nodeValue != null){
									door_desc = message[i].childNodes[4].firstChild.nodeValue;
								}else{
									door_desc = "----";
								}			
								data = message[i].childNodes[6].firstChild.nodeValue;
								num++;
								
								showReponseCommand(num, ip, door_id, door_desc, result, data);	
							} // end for 	
							
							document.getElementById("load").innerHTML = '&nbsp;';				
							document.getElementById("lblTime").innerHTML = toTime;//dt.toLocaleTimeString();
							return;				
						}else{  // else message null
							count = count + 1;
						}					
						document.getElementById("process_count").value = count;
					}catch (err){
						count = count + 1;
						document.getElementById("process_count").value = count;
					}
				} // end status 200 
				setTimeout("sendRequest()", 1500); 
				setTimeout("ShowCurrentTime()", 1000);	
			} // ready stage = 4 	
		}

		function sleep(milliseconds) {
			var start = new Date().getTime();
			for (var i = 0; i < 1e7; i++) {
				if ((new Date().getTime() - start) > milliseconds)
					break;
			}
		}

		function ShowCurrentTime() { 
			document.getElementById("lblTime").innerHTML = '<img src="images/loading.gif" align="absmiddle"/>';
		}

		function updateClock(){
			var currentTime = new Date();
			var currentHours = currentTime.getHours ( );
			var currentMinutes = currentTime.getMinutes ( );
			var currentSeconds = currentTime.getSeconds ( );
			//alert("Page load took " + (Date.now() - currentTime) + "milliseconds");

			// Pad the minutes and seconds with leading zeros, if required
			currentMinutes = ( currentMinutes < 10 ? "0" : "" ) + currentMinutes;
			currentSeconds = ( currentSeconds < 10 ? "0" : "" ) + currentSeconds;

			// Choose either "AM" or "PM" as appropriate
			//var timeOfDay = ( currentHours < 12 ) ? "AM" : "PM";

			// Convert the hours component to 24-hour format if needed
			currentHours = ( currentHours > 24 ) ? currentHours - 24 : currentHours;

			// Convert an hours component of "0" to "12"
			//currentHours = ( currentHours == 0 ) ? 12 : currentHours;

			// Compose the string for display
			var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds ;

			// Update the time display
			document.getElementById("clock").firstChild.nodeValue = currentTimeString;
			//alert(document.getElementById("clock").firstChild.nodeValue);
		}

		String.prototype.trim = function () {
			return this.replace(/^\s*/, "").replace(/\s*$/, "");
		}

		function showReponseCommand(num,ip,door_id,door_desc,result,data){	
			if((request_Command=="25")||(request_Command=="41")){	// Enroll Fingerprint
				show_setcommand(num,ip,door_id,door_desc,result); 
			}
		}

		function getresult(result){
			var msg;
			if(result == "A" || result == "a"){
				result = 10;
			}
			var iResult = parseInt(result);
			switch (iResult){
				case 0: msg = "Fail";
				break;
				case 1: msg = "Success";
				break;
				case 2: msg = "Fail Connecting";
				break;
				case 3: msg = "IO Error";
				break;
				case 4: msg = "Time Out";
				break;
				case 5: msg = "Busy Upload Firmware";
				break;
				case 6: msg = "Busy Upload ID Table";
				break;
				case 7: msg = "Busy Download Transaction";
				break;
				case 8: msg = "Busy Dump Transaction";
				break;
				case 9: msg = "Not Response";
				break;
				case 10: msg = "No Data ID";
				break;
				case 11: msg = "No Command";
				break;		
				case 12: msg = "File Not Found";
				break;		
				case 13: msg = "Error Exception";
				break;		
				case 14: msg = "In Process";
				break;		
				case 15: msg = "Busy Download ID Table";
				break;		
				default: msg = "Fail etc.";
			}       
			return msg;
		}
		
		function show_setcommand(num,ip,door_id,desc,result){ 
			var tbl = document.getElementById("table1");
			var tblBody = document.createElement("tbody");	
			var row = document.createElement("tr");      
				
			var cell1 = document.createElement("td");
			var cellText1 = document.createTextNode(num);
			var cell2 = document.createElement("td");
			var cellText2 = document.createTextNode(door_id);
			var cell3 = document.createElement("td");
			var cellText3 = document.createTextNode(desc);
			var cell4 = document.createElement("td");	
			var cellText4 = document.createTextNode(getresult(result));		
			
			setstyletxt(cell1,"center");
			setstyletxt(cell2,"center");
			setstyledesc(cell3);
			setstyleresult(cell4,result);	
			
			cell1.appendChild(cellText1);
			cell2.appendChild(cellText2);
			cell3.appendChild(cellText3);
			cell4.appendChild(cellText4);		
			
			row.appendChild(cell1);
			row.appendChild(cell2);
			row.appendChild(cell3);
			row.appendChild(cell4);
			
			tblBody.appendChild(row);			
			tbl.appendChild(tblBody);
			tbl.setAttribute("border", "0");
			
			//	Update Status Template
			if(Number(result) == 1){
				setTimeout(function(){
					iframe_update_status.location = 'module/update_camera_finger.jsp?action=tpl&idcard=<%= iframe_emp %>';
				}, 500);
				setTimeout(function(){
					parent.loadView();
				}, 1000);
			}
		}

		function setstyledesc(object){
			object.style.fontFamily	= "sans-serif";
			object.style.fontSize	= "12px";
			object.style.paddingLeft	= "5px";
		}

		function setstyleresult(object,result){
			object.style.fontFamily	= "sans-serif";
			object.style.fontSize	= "12px";
			object.align = "center" ;
			var iResult = parseInt(result);
				
			switch (iResult){
				case 0: object.style.color = 'red';
				break;
				case 1: object.style.color = 'black';
				break;
				case 2: object.style.color = 'green';
				break;
				case 3: object.style.color = 'blue';
				break;
				case 4: object.style.color = 'brown';
							object.style.fontSize = "14px";
							object.style.fontWeight = "bolder";
							object.style.fontStyle = "italic";
				break;
				default: object.style.color = 'red';
			}	
		}

		function setstyletxt(object , txtalign){
			object.style.fontFamily	= "sans-serif";
			object.style.fontSize	= "12px";  
			object.align = txtalign;
		}
	</script>
	
</html>

<%@ include file="../function/disconnect.jsp"%>