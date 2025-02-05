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
						ip		= message[i].childNodes[2].firstChild.nodeValue;
						if(ip == "---.---.---.---"){
							ip = "";
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
					//	console.log('showReponseCommand('+num+', '+ip+', '+door_id+', '+door_desc+', '+result+', '+data+')');
					
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
		setTimeout("sendRequest()", 1000); 
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

function openInNewWindow() { 
	// Change "_blank" to something like "newWindow" to load all links in the same new window 
	var newWindow = window.open(this.getAttribute('href'), '_blank'); 
	newWindow.focus(); 
	return false; 
}

String.prototype.trim = function () {
	return this.replace(/^\s*/, "").replace(/\s*$/, "");
}

function showReponseCommand(num,ip,door_id,door_desc,result,data){	
	if(request_Command=="22"){			//	Get Num ID Template
		show_getnumidtemplate(num,ip,door_id,door_desc,result,data); 	
	}else if((request_Command=="23")	//	Clear All ID Template
			|| (request_Command=="25")	//	Enroll Fingerprint
			|| (request_Command=="26")	//	Write Card
			|| (request_Command=="30")	//	Upload Configuration
			|| (request_Command=="31")	//	Upload Event Table
			|| (request_Command=="32")	//	Upload Timezone
			|| (request_Command=="33")	//	Upload Unlock
			|| (request_Command=="34")	//	Upload Holiday
			|| (request_Command=="35")	//	Upload lock
			|| (request_Command=="37")	//	Upload Firmware CRU
			|| (request_Command=="38")	//	Upload Firmware MU
			|| (request_Command=="39")	//	Upload TimeOn Out4
			|| (request_Command=="41")	//	Enroll Fingerprint
			|| (request_Command=="42")	//	Write Card
			|| (request_Command=="60")	//	Upload Configuration2
			|| (request_Command=="62")	//	Upload Picture
			|| (request_Command=="63")	//	Upload PIC EMP
			|| (request_Command=="64")	//	Upload VIDEO
			|| (request_Command=="65")	//	Upload Img Slide
			|| (request_Command=="66")	//	Upload Sound
			|| (request_Command=="72")	//	Set ID MU
			|| (request_Command=="78")	//	Clear All ID Table
			|| (request_Command=="79")	//	Delete ID Table
			|| (request_Command=="91")	//	Action Server	
			|| (request_Command=="93")	//	Upload Work Code			
			){
		show_setcommand(num,ip,door_id,door_desc,result); 		
	}else if(request_Command=="24"){	//	Get Type CRU
		show_gettypecru(num,ip,door_id,door_desc,result,data); 		
	}else if(request_Command=="28"){	//	Read Transaction Card
		show_readtransaction(num,ip,door_id,door_desc,result,data); 	
	}else if(request_Command=="29"){	//	Read Type Card
		show_gettypecard(num,ip,door_id,door_desc,result,data); 
	}else if((request_Command=="40")||(request_Command=="21")){	//	Get ID Template
		show_gettemplate(num,ip,door_id,door_desc,result,data); 	
	}else if((request_Command=="43")||(request_Command=="27")){	//	Read Card
		show_getreadcard(num,ip,door_id,door_desc,result,data); 	
	}else if((request_Command=="44")||(request_Command=="80")){	//	Add ID Table
		show_setidtable(num,ip,door_id,door_desc,result,data); 
	}else if((request_Command=="45")||(request_Command=="81")){	//	Get ID Table
		show_getidtable(num,ip,door_id,door_desc,result,data);
	}else if((request_Command=="47")||(request_Command=="A0")){	//	Upload ID Table File
		show_uploadidtable(num,ip,door_id,door_desc,result,data);  
	}else if((request_Command=="48")||(request_Command=="A1")){	//	Download ID Table File
		show_downloadidtables(num,ip,door_id,door_desc,result,data);
	}else if((request_Command=="50")	//	Download Configuration			
			|| (request_Command=="51")	//	Download Event Table
	    	|| (request_Command=="52")	//	Download Timezone
	    	|| (request_Command=="53")	//	Download Unlock
	    	|| (request_Command=="54")	//	Download Holiday
	   		|| (request_Command=="55")	//	Download lock
			|| (request_Command=="58")	//	Download Log
			|| (request_Command=="59")	//	Download TimeOn Out4
			|| (request_Command=="61")	//	Download Configuration2
			|| (request_Command=="12")	//	Download List Video
			|| (request_Command=="13")	//	Download List Slide
			|| (request_Command=="88")	//	Download List Admin
			){
	    show_getcommand(num,ip,door_id,door_desc,result); 
	}else if(request_Command=="56"){	//	Download Transaction
	    show_transferdata(num,ip,door_id,door_desc,result,data); 
	}else if(request_Command=="57"){	//	Dump Transaction
		show_dumpdata(num,ip,door_id,door_desc,result,data);
	}else if(request_Command=="69"){	//	Dump Transaction By DateTime
		show_dumpdata_bydatetime(num,ip,door_id,door_desc,result,data);
	}else if(request_Command=="70"){	//	Set Date Time
	    show_setdatetime(num,ip,door_id,door_desc,result,data); 
	}else if(request_Command=="71"){	//	Get Date Time
		show_getdatetime(num,ip,door_id,door_desc,result,data);	
	}else if(request_Command=="73"){	//	Get ID MU
		show_getmuid(num,ip,door_id,door_desc,result,data);
	}else if(request_Command=="74"){	//	Get Firmware Version
		show_getversion(num,ip,door_id,door_desc,result,data);
	}else if(request_Command=="75"){	//	Get Num ID Table
	    show_getnumidtable(num,ip,door_id,door_desc,result,data);
	}else if(request_Command=="76"){	//	Get Information
		show_getinformation(num,ip,door_id,door_desc,result,data);
	}else if(request_Command=="76h"){	//	Get Information
		show_getinformation_home(num,ip,door_id,door_desc,result,data);
	}else if(request_Command=="77"){	//	Get Network Properties
		show_getnetwork(num,ip,door_id,door_desc,result,data);		
	}else if((request_Command=="D0") 	//	Del Capture Picture
			|| (request_Command=="D1")	//	Del Employee Picture
			|| (request_Command=="D2")	// 	Del Video
			|| (request_Command=="D3")	//	Del Picture Slide
			){
		show_setcommand(num,ip,door_id,door_desc,result); 	
	}else if(request_Command=="10"){	//	Get Capture Picture by Date Time
		show_getcapture_datetime(num,ip,door_id,door_desc,result,data);		
	}else if(request_Command=="11"){	//	Get Capture Employee
		show_getcapture_employee(num,ip,door_id,door_desc,result); 	
	}else if(request_Command=="86"){	//	Read Serial Card
		show_getserialcard(num,ip,door_id,door_desc,result,data); 
	}else if(request_Command=="87"){	//	Add User Admin
		show_setadmin(num,ip,door_id,door_desc,result,data); 
	}else if(request_Command=="92"){	//	Get Work Code
		show_getworkcode(num,ip,door_id,door_desc,result,data);
	}else if(request_Command=="F2"){	//	Face Get Information
		show_getfaceinformation(num,ip,door_id,door_desc,result,data);
	}else if(request_Command=="F4"){	//	Face Get Employee List
		show_getcommand(num,ip,door_id,door_desc,result); 		
	}else if(request_Command=="F5"){	//	Face Get Employee
		show_getfaceemployee(num,ip,door_id,door_desc,result,data);		
	}else if((request_Command=="F1")	//	Face Set Date Time		
			|| (request_Command=="F6")	//	Face Set Employee			
			|| (request_Command=="F7")	//	Face Delete Employee	
			){
	    show_setcommandface(num,ip,door_id,door_desc,result,data); 
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
		case 16: msg = "ACU-67 Not Support Template 2";
		break;		
		case 17: msg = "Blacklist ID";
		break;		
		default: msg = "Fail etc.";
	}       
	return msg;
}

function show_setcommandface(num,ip,door_id,desc,result,data){ 
	
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
	var cell5 = document.createElement("td");	
	var cellText5 = document.createTextNode(data);		
		
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);	
	setstyletxt(cell5,"center");
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);	
	cell5.appendChild(cellText5);	
	
	row.appendChild(cell1);
 	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	
	tblBody.appendChild(row);			
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
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
}

function show_getcapture_datetime(num,ip,door_id,desc,result){ 
	
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
	
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode("");
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode("");
	var linkpage = "";
	if(result == "1"){
		var linkpage5 = document.createElement('a');
		linkpage5.setAttribute('href', 'cmd_get_capture_data.jsp?'+checkModeData(ip, door_id)+'&format_type=pass');
		linkpage5.onclick = openInNewWindow;
		linkpage5.innerHTML = "Pass";	
		setstyleresult(cell5, result);
		cell5.style.fontStyle = "italic";
		cell5.appendChild(linkpage5);
		
		var linkpage6 = document.createElement('a');
		linkpage6.setAttribute('href', 'cmd_get_capture_data.jsp?'+checkModeData(ip, door_id)+'&format_type=notpass');
		linkpage6.onclick = openInNewWindow;
		linkpage6.innerHTML = "Not Pass";	
		setstyleresult(cell6, result);
		cell6.style.fontStyle = "italic";
		cell6.appendChild(linkpage6);
	}else{
		cellText5 = document.createTextNode("-");
		cell5.appendChild(cellText5);
		cellText6 = document.createTextNode("-");
		cell6.appendChild(cellText6);			
	}
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getcapture_employee(num,ip,door_id,desc,result){ 
	
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
	
	var cell5 = document.createElement("td");	
	var cellText5 = document.createTextNode("");	
	if(result == "1"){
		var imgview = document.createElement('img');
		imgview.src = 'images/view.png';
		imgview.setAttribute("class", "img-rounded");
		imgview.setAttribute("height", "18");
		imgview.setAttribute("width", "18");
		imgview.setAttribute("align", "absmiddle");
		imgview.setAttribute("alt", "View");
		imgview.onclick = function(){ showPicture(ip, door_id); };
		setstyleresult(cell5, 4);
		cell5.appendChild(imgview);
	}else{
		cellText5 = document.createTextNode("");
		cell5.appendChild(cellText5);
	}	
	
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode("");
	if(result == "1"){
		var linkpage = document.createElement('a');
		linkpage.setAttribute('href', '#');
		linkpage.onclick = function(){ saveFile(ip, door_id); };
		linkpage.innerHTML = "Save";
		setstyleresult(cell6, 4);
		cell6.appendChild(linkpage);
	}else{
		cellText6 = document.createTextNode("-");
		cell6.appendChild(cellText6);
	}
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);		
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	
	tblBody.appendChild(row);			
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getcommand(num,ip,door_id,desc,result){
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
	msg = getresult(result);
	var cellText4 = document.createTextNode(msg);				
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3); 	
	if ((result == "1") && ((request_Command==50)||(request_Command==51)||(request_Command==52)||(request_Command==53)||(request_Command==54)
		||(request_Command==55)||(request_Command==58)||(request_Command==59)||(request_Command==61)||(request_Command==12)||(request_Command==13)||(request_Command==88)||(request_Command=="F4"))){
		setstyleresult(cell4,4);
	}else{
		setstyleresult(cell4,result);	
	}		               
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	if(msg=="Success"){
		if (request_Command==50) {					
			var data =document.getElementById("param").value; 
			var linkpage = document.createElement('a');				
			if (data == "5") {
				msg = "MU-RD67";
				linkpage.setAttribute('href', 'cmd_get_config_data.jsp?'+checkModeData(ip, door_id));
			}
			linkpage.onclick = openInNewWindow;										
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		} else if (request_Command == 51) {	
			msg = "Event";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', 'cmd_get_event_data.jsp?'+checkModeData(ip, door_id));
			linkpage.onclick = openInNewWindow;
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		} else if (request_Command==52) {	
			msg = "Timezone";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', 'cmd_get_timezone_data.jsp?'+checkModeData(ip, door_id));
			linkpage.onclick = openInNewWindow;
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		} else if (request_Command==53) {			
			msg = "Unlock";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', 'cmd_get_unlock_data.jsp?'+checkModeData(ip, door_id));
			linkpage.onclick = openInNewWindow;
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		} else if (request_Command==54) {			
			msg = "Holiday";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', 'cmd_get_holiday_data.jsp?'+checkModeData(ip, door_id));
			linkpage.onclick = openInNewWindow;
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		} else if (request_Command==55) {			
			msg = "Lock";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', 'cmd_get_lock_data.jsp?'+checkModeData(ip, door_id));
			linkpage.onclick = openInNewWindow;
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		}else if (request_Command==58) {			
			msg = "Log File";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', 'DownloadLogFile.do?'+checkModeData(ip, door_id));
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		}else if (request_Command==59) {			
			msg = "Time On Output 4";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', 'cmd_get_timeonoutput4_data.jsp?'+checkModeData(ip, door_id));
			linkpage.onclick = openInNewWindow;
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		}else if (request_Command==61) {
			msg = "MU-RD67_2";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', 'cmd_get_config2_data.jsp?'+checkModeData(ip, door_id));
			linkpage.onclick = openInNewWindow;
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		}else if (request_Command==12) {
			msg = "List Video";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', '#');
			linkpage.onclick = function(){ showList(ip, door_id); };
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		}else if (request_Command==13) {
			msg = "List Slide";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', '#');
			linkpage.onclick = function(){ showList(ip, door_id); };
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		}else if (request_Command==88) {
			msg = "List Admin";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', '#');
			linkpage.onclick = function(){ showList(ip, door_id); };
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);
		}else if (request_Command=="F4") {
			msg = "EMPLOYEE_LIST.txt";
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', 'cmd_face_get_employee_list_data.jsp?'+checkModeData(ip, door_id));
			linkpage.onclick = openInNewWindow;
			linkpage.innerHTML = msg;
			cell4.appendChild(linkpage);			
		} else {
			cell4.appendChild(cellText4);
		}
	} else {
		cell4.appendChild(cellText4);
	}			
	
	row.appendChild(cell1);
 	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);	
	
	tblBody.appendChild(row);			
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getdatetime(num,ip,door_id,desc,result,data){	
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
			
	var data_date = "-"; 
	var data_time = "-";
	if (result == "1") {
		data_date = data.substring(0,2)+"/"+data.substring(2,4)+"/"+data.substring(4,8);
		data_time = data.substring(8,10)+":"+data.substring(10,12)+":"+data.substring(12,14);	
	}
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(data_date);
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode(data_time);
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
			
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getmuid(num,ip,door_id,desc,result,data){
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
	var muid = "-";
	if (result == "1") {
		muid=data;		
	}	
	var cell5 = document.createElement("td");	
	var cellText5 = document.createTextNode(muid);
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	
	cell1.appendChild(cellText1);	
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	
	row.appendChild(cell1);	
	row.appendChild(cell2);
 	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
				                
	tblBody.appendChild(row);	
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getversion(num,ip,door_id,desc,result,data){
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

	var mu = "-";
	var reader1 = "-";
	var reader2 = "-";				

	if (result == "1"){
		mu = data.substring(0,16);
		reader1 = data.substring(16,32);				
		reader2 = data.substring(32,48);				
	}

	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(mu);
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode(reader1);
	var cell7 = document.createElement("td");
	var cellText7 = document.createTextNode(reader2);
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	setstyletxt(cell7,"center");
	
	cell1.appendChild(cellText1);	
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	cell7.appendChild(cellText7);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	row.appendChild(cell7);
				
	tblBody.appendChild(row);	
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getnumidtable(num,ip,door_id,desc,result,data){
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

	var fullTable = "-";
	var freeTable1 = "-/-";
	var freeTable2 = "-/-";	
	var useTable1 = "-";
	var useTable2 = "-";	
	// Free Table1(5) + Free Table2(5) + Full Table(5)
	if (data.substring(0,1)!="*" && data.length==15) {		
		if(data.substring(10,15) != '*****'){
			fullTable = data.substring(10,15);
		}
		
		if(data.substring(0,5) != '*****'){			
			freeTable1 = data.substring(0,5);
			useTable1 = parseInt(fullTable,10) - parseInt(freeTable1,10);
			freeTable1 = freeTable1+"/"+fullTable;
		}else{	
			useTable1 = "-";
		}
		
		if(data.substring(5,10) != '*****'){	
			freeTable2 = data.substring(5,10);
			useTable2 = parseInt(fullTable,10) - parseInt(freeTable2,10);
			freeTable2 = freeTable2+"/"+fullTable;
		}else{ 
			useTable2 = "-";
		}		
	}
	
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(freeTable1);	
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode(useTable1);	
	var cell7 = document.createElement("td");
	var cellText7 = document.createTextNode(freeTable2);	
	var cell8 = document.createElement("td");
	var cellText8 = document.createTextNode(useTable2);
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	setstyletxt(cell7,"center");
	setstyletxt(cell8,"center");
	
	cell1.appendChild(cellText1);	
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	cell7.appendChild(cellText7);
	cell8.appendChild(cellText8);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	row.appendChild(cell7);
	row.appendChild(cell8);
				                
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getnumidtemplate(num,ip,door_id,desc,result,data){
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
	var numid = "-";
				
	if (result == "1") {
		numid = data;
	}
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(numid);
	
	setstyletxt(cell1,"center");	
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	
	cell1.appendChild(cellText1);			
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
		
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);	
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getfaceinformation(num,ip,door_id,desc,result,data){
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
		
	var managernum = "-";
	var real_facerecord = "-";
	var max_managernum = "-";
	var ipAddr = "-";
	var alg_edition = "-";
	var edition = "-";
	var max_employee = "-";
	var type = "-";	
	var mac = "-";
	var max_facerecord = "-";
	var volume = "-";
	var wiegand = "-";
	var max_faceregist = "=";
	var netmask = "-";
	var real_employee = "-";
	var name = "-";
	var real_other = "=";
	var managerlock = "-";
	var max_other = "=";
	var real_faceregist = "=";
	var sn = "=";
	var time = "=";
	var gateway = "=";
	
	if (result == "1"){
		//{"managernum":"1","real_facerecord":"149","max_managernum":"4","ip":"192.168.1.198","alg_edition":"V5.5.2.0","edition":"5.1000.21002.1.0.127","max_employee":"10000",
		//"type":"VF1000X","mac":"00:0C:5B:0C:D8:76","max_facerecord":"80000","volume":"2","wiegand":"0","max_faceregist":"10000","netmask":"255.255.254.0","real_employee":"37",
		//"name":"","real_other":"0","managerlock":"false","max_other":"0","real_faceregist":"37","sn":"6728122050000270","time":"07/01/2025 01:41:16","gateway":"192.168.1.1"}	
		var d = JSON.parse(data); 
		var jsonData = {managernum:d.managernum, real_facerecord:d.real_facerecord, max_managernum:d.max_managernum, ip:d.ip, alg_edition:d.alg_edition, edition:d.edition, max_employee:d.max_employee, 
			type:d.type, mac:d.mac, max_facerecord:d.max_facerecord, volume:d.volume, wiegand:d.wiegand, max_faceregist:d.max_faceregist, netmask:d.netmask, real_employee:d.real_employee, 
			name:d.name, real_other:d.real_other, managerlock:d.managerlock, max_other:d.max_other, real_faceregist:d.real_faceregist, sn:d.sn, time:d.time, gateway:d.gateway};	
			
		managernum = jsonData.managernum;
		real_facerecord = jsonData.real_facerecord;
		max_managernum = jsonData.max_managernum;
		ipAddr = jsonData.ip;
		alg_edition = jsonData.alg_edition;
		edition = jsonData.edition;
		max_employee = jsonData.max_employee;
		type = jsonData.type;	
		mac = jsonData.mac;
		max_facerecord = jsonData.max_facerecord;	
		volume = jsonData.volume;
		wiegand = jsonData.wiegand;
		max_faceregist = jsonData.max_faceregist;
		netmask = jsonData.netmask;
		real_employee = jsonData.real_employee;
		name = jsonData.name;
		real_other = jsonData.real_other;
		managerlock = jsonData.managerlock;
		max_other = jsonData.max_other;
		real_faceregist = jsonData.real_faceregist;
		sn = jsonData.sn;
		time = jsonData.time;
		gateway = jsonData.gateway;		
	}
	
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(time);
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode(sn);
	var cell7 = document.createElement("td");
	var cellText7 = document.createTextNode(alg_edition);
	var cell8 = document.createElement("td");
	var cellText8 = document.createTextNode(edition);				
	var cell9 = document.createElement("td");
	var cellText9 = document.createTextNode(real_employee+"/"+max_employee);			
	var cell10 = document.createElement("td");
	var cellText10 = document.createTextNode(real_facerecord+"/"+max_facerecord);		
	var cell11 = document.createElement("td");
	var cellText11 = document.createTextNode(real_faceregist+"/"+max_faceregist);		
	var cell12 = document.createElement("td");
	var cellText12 = document.createTextNode(real_other+"/"+max_other);	
	
	var cell13 = document.createElement("td");
	var cellText13 = document.createTextNode(managernum+"/"+max_managernum);
	var cell14 = document.createElement("td");
	var cellText14 = document.createTextNode(mac);
	var cell15 = document.createElement("td");
	var cellText15 = document.createTextNode(ipAddr);
	var cell16 = document.createElement("td");
	var cellText16 = document.createTextNode(netmask);	
	var cell17 = document.createElement("td");
	var cellText17 = document.createTextNode(gateway);
	var cell18 = document.createElement("td");
	var cellText18 = document.createTextNode(managerlock);
	var cell19 = document.createElement("td");
	var cellText19 = document.createTextNode(type);
	var cell20 = document.createElement("td");
	var cellText20 = document.createTextNode(name);
	var cell21 = document.createElement("td");
	var cellText21 = document.createTextNode(volume);
	var cell22 = document.createElement("td");
	var cellText22 = document.createTextNode(wiegand);	
			
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	setstyletxt(cell7,"center");
	setstyletxt(cell8,"center");
	setstyletxt(cell9,"center");
	setstyletxt(cell10,"center");				
	setstyletxt(cell11,"center");	
	setstyletxt(cell12,"center");
	setstyletxt(cell13,"center");
	setstyletxt(cell14,"center");
	setstyletxt(cell15,"center");
	setstyletxt(cell16,"center");
	setstyletxt(cell17,"center");
	setstyletxt(cell18,"center");
	setstyletxt(cell19,"center");
	setstyletxt(cell20,"center");
	setstyletxt(cell21,"center");
	setstyletxt(cell22,"center");	
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	cell7.appendChild(cellText7);
	cell8.appendChild(cellText8);
	cell9.appendChild(cellText9);
	cell10.appendChild(cellText10);				
	cell11.appendChild(cellText11);		
	cell12.appendChild(cellText12);	
	cell13.appendChild(cellText13);	
	cell14.appendChild(cellText14);	
	cell15.appendChild(cellText15);	
	cell16.appendChild(cellText16);	
	cell17.appendChild(cellText17);	
	cell18.appendChild(cellText18);	
	cell19.appendChild(cellText19);	
	cell20.appendChild(cellText20);	
	cell21.appendChild(cellText21);	
	cell22.appendChild(cellText22);	
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	row.appendChild(cell7);
	row.appendChild(cell8);
	row.appendChild(cell9);
	row.appendChild(cell10);				
	row.appendChild(cell11);	
	row.appendChild(cell12);
	row.appendChild(cell13);
	row.appendChild(cell14);
	row.appendChild(cell15);
	row.appendChild(cell16);
	row.appendChild(cell17);
	row.appendChild(cell18);
	row.appendChild(cell19);
	row.appendChild(cell20);
	row.appendChild(cell21);
	row.appendChild(cell22);
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getfaceemployee(num,ip,door_id,desc,result,data){
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

	var resultmsg = "-";	
	var message = "-";
	var reason = "-";
	var employee_code = "-";
	var idcard_jpg = "-";
	var name = "-";
	var card_serial_number = "-";
	var capture_jpeg_base64 = "-";
	var user_type = "-";
	var identify_mode = "-";
	var last_update_utc = "-";
	var job_num = "-";
	var pin = "-";	
	var last_updated = "-";
	var showPic = "-";
	
	if (result == "1"){
		//{"reason":"","last_update_utc":"2025-01-16T03:43:51Z","message":"192.168.1.198: Get Employee ID 4410094",
		//"capture_jpeg_base64":"/9j/4AAQSkZJRgABAQEA/gFFAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRof\r\nHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwh\r\nMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAAR\r\nCAG1AVADASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAA\r\nAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkK\r\nFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWG\r\nh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl\r\n5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREA\r\nAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYk\r\nNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOE\r\nhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk\r\n5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD0QjiTAzyO9I3y78Z+6BStj95x3FDDmTj0\r\n71ZmDfx9fujtS88+mwdvpQx5fJI+Ud6Xs2SQNo5/KmMkPAb/AHR0ph/i6/dFSPwG+XsO9MYA\r\nls5xgcCpQMN2M9fu0gH+1/B6UuBgnn7ooBx3PC0xC9uOfkoHbp9yjnOBz8tKMDGSPu0AOxlR\r\ngHqKYVDZ6/ep+fkBCnGfWoZpo4I2klbYu7qWwPzoQxzkKSMtnPQ1Dd3lvaQGWeTy4gcFm/xG\r\nc1x/iTx1DppaGwBnn672G1B+J+9+Feaav4iudVlaS8vnky2fKD4RPotK4WPR9V8fQee8Nhsk\r\n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",
		//"employee_code":"4410094","idcard_jpg":"","result":"success","user_type":"1","job_num":"4410094","pin":"","name":" PH G","card_serial_number":"4410094","identify_mode":0}
		//last_updated
		var d = JSON.parse(data); 
		var jsonData = {employee_code:d.employee_code, name:d.name, card_serial_number:d.card_serial_number, capture_jpeg_base64:d.capture_jpeg_base64, user_type:d.user_type, 
			identify_mode:d.identify_mode, last_update_utc:d.last_update_utc, job_num:d.job_num, pin:d.pin, resultmsg:d.result, message:d.message, reason:d.reason, last_updated:d.last_updated};							
	
		employee_code = jsonData.employee_code;
		idcard_jpg = jsonData.idcard_jpg;
		name = jsonData.name;
		card_serial_number = jsonData.card_serial_number;
		capture_jpeg_base64 = jsonData.capture_jpeg_base64;
		user_type = jsonData.user_type;
		identify_mode = jsonData.identify_mode;
		last_update_utc = jsonData.last_update_utc;
		job_num = jsonData.job_num;
		pin = jsonData.pin;		
		last_updated = jsonData.last_updated
	}
		
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(employee_code);
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode(name);
	var cell7 = document.createElement("td");
	var cellText7 = document.createTextNode(card_serial_number);
	var cell8 = document.createElement("td");
	var cellText8 = document.createTextNode(user_type);				
	var cell9 = document.createElement("td");
	var cellText9 = document.createTextNode(identify_mode);			
	var cell10 = document.createElement("td");
	var cellText10 = document.createTextNode(last_updated);		
	var cell11 = document.createElement("td");
	var cellText11 = document.createTextNode(job_num);		
	var cell12 = document.createElement("td");
	var cellText12 = document.createTextNode(pin);	
	var cell13 = document.createElement("td");
	var cellText13 = document.createTextNode(showPic);
				
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	setstyletxt(cell7,"center");
	setstyletxt(cell8,"center");
	setstyletxt(cell9,"center");
	setstyletxt(cell10,"center");				
	setstyletxt(cell11,"center");	
	setstyletxt(cell12,"center");
	setstyletxt(cell13,"center");
		
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	cell7.appendChild(cellText7);
	cell8.appendChild(cellText8);
	cell9.appendChild(cellText9);
	cell10.appendChild(cellText10);				
	cell11.appendChild(cellText11);		
	cell12.appendChild(cellText12);	
		
	if(capture_jpeg_base64 != null){
		//alert(capture_jpeg_base64);
		showPic = "View";		
		var linkpage = document.createElement('a');
		linkpage.setAttribute('href', 'cmd_face_get_employee_view.jsp?'+checkModeData(ip, door_id)+'&idcard='+employee_code);
		linkpage.onclick = openInNewWindow;
		linkpage.innerHTML = showPic;
		cell13.appendChild(linkpage);				
	}else{		
		cell13.appendChild(cellText13);	
	}
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	row.appendChild(cell7);
	row.appendChild(cell8);
	row.appendChild(cell9);
	row.appendChild(cell10);				
	row.appendChild(cell11);	
	row.appendChild(cell12);
	row.appendChild(cell13);
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getinformation(num,ip,door_id,desc,result,data){
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

	//ddmmyyyyhhmmss(14)+Domain(4)+Version MU(16)+Version CRU1(16)+Version CRU2(16)+Free Transaction(6)+Full Transaction(6)
	var date_time = "-";
	var mu_id = "-";
	var mu_ver = "-";
	var reader1_ver = "-";
	var reader2_ver = "-";
	var free_rec = "-";
	var full_rec = "-";
	var use_rec = "-";	
	if (result == "1"){
		if(data.substring(0,14) != '**************'){
			date_time	= data.substring(0,2)+"/"+data.substring(2,4)+"/"+data.substring(4,8)+" "+data.substring(8,10)+":"+data.substring(10,12)+":"+data.substring(12,14);
		}else{
			date_time = "-";
		}		
		mu_id = data.substring(14,18);
		mu_ver = data.substring(18,34);
		reader1_ver = data.substring(34,50);
		reader2_ver   = data.substring(50,66);		
		if(data.substring(66,72).length == 6 && data.substring(66,72) != '******'){
			free_rec = data.substring(66,72);//parseInt(data.substring(66,72),10);
		}else{
			free_rec = "-";			
		}		
		if(data.substring(72,78).length == 6 && data.substring(72,78) != '******'){
			full_rec = data.substring(72,78);//parseInt(data.substring(72,78),10);
		}else{
			full_rec = "-";
		}		
		use_rec = full_rec - free_rec;
	}
	
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(date_time);
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode(mu_id);
	var cell7 = document.createElement("td");
	var cellText7 = document.createTextNode(mu_ver);
	var cell8 = document.createElement("td");
	var cellText8 = document.createTextNode(reader1_ver);				
	var cell9 = document.createElement("td");
	var cellText9 = document.createTextNode(reader2_ver);			
	var cell10 = document.createElement("td");
	var cellText10 = document.createTextNode(free_rec+"/"+full_rec);		
	var cell11 = document.createElement("td");
	var cellText11 = document.createTextNode(use_rec);			
			
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	setstyletxt(cell7,"center");
	setstyletxt(cell8,"center");
	setstyletxt(cell9,"center");
	setstyletxt(cell10,"center");				
	setstyletxt(cell11,"center");
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	cell7.appendChild(cellText7);
	cell8.appendChild(cellText8);
	cell9.appendChild(cellText9);
	cell10.appendChild(cellText10);				
	cell11.appendChild(cellText11);	
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	row.appendChild(cell7);
	row.appendChild(cell8)
	row.appendChild(cell9);
	row.appendChild(cell10);				
	row.appendChild(cell11);
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getinformation_home(num,ip,door_id,desc,result,data){
	var tbl = document.getElementById("table1");
	var tblBody = document.createElement("tbody");
	var row = document.createElement("tr");
	
	var cell1 = document.createElement("td");
	var cellText1 = document.createTextNode(num);
	var cell2 = document.createElement("td");
	var cellText2 = document.createTextNode(door_id);
	var cell3 = document.createElement("td");
	var cellText3 = document.createTextNode(desc);
	
	var result_view = "";
	if (result == "1"){
		result_view = "Connect";
	}else{
		result_view = "Disonnect"
	}
	
	var cell4 = document.createElement("td");
	var cellText4 = document.createTextNode(result_view);
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult_home(cell4, result);
	
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
}

function show_getnetwork(num,ip,door_id,desc,result,data){
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
				
	var ipaddress = "-";
	var gateway	= "-";
	var netmask	= "-";
	var host = "-";
	var port = "-";	
	if (result == "1") {
		ipaddress = data.substring(0,15);
		gateway = data.substring(15,30);
		netmask = data.substring(30,45);
		host = data.substring(45,60);
		port = parseInt(data.substring(60,65),10);
	}
	
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(ipaddress);
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode(gateway);
	var cell7 = document.createElement("td");
	var cellText7 = document.createTextNode(netmask);
	var cell8 = document.createElement("td");
	var cellText8 = document.createTextNode(host);
	var cell9 = document.createElement("td");
	var cellText9 = document.createTextNode(port);				
	
	setstyletxt(cell1,"center");	
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	setstyletxt(cell7,"center");              
	setstyletxt(cell8,"center");
	setstyletxt(cell9,"center");
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	cell7.appendChild(cellText7);
	cell8.appendChild(cellText8);
	cell9.appendChild(cellText9);
    
	row.appendChild(cell1);
 	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	row.appendChild(cell7);
	row.appendChild(cell8);
	row.appendChild(cell9);
	
	tblBody.appendChild(row);	
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_gettypecru(num,ip,door_id,desc,result,data){
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
	            
	var data_cru1= "";
	var data_cru2= "";	
	if (result =="1" && data.length>=1) {
		data_cru1 = data.substring(0,1);
		data_cru2 = data.substring(1,2);	
	} 
				
	if(data_cru1 == "F"){
		data_cru1 = "Finger Print";
	}else if(data_cru1 == "P" ){
		data_cru1= "PALM VEIN ";
	}else if(data_cru1 == "*"){
		data_cru1= "CRU Connect Fail";
	}else{
	   	data_cru1 = "-";
	}
					
	if(data_cru2 == "F"){
		data_cru2 = "Finger Print";
	}else if(data_cru2 == "P"){
		data_cru2= "PALM VEIN ";
	}else if(data_cru2 == "*"){
		data_cru2= "CRU Connect Fail";
	}else{
	   	data_cru2 = "-";
	}
			    
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(data_cru1);
	var cell6= document.createElement("td");
	var cellText6 = document.createTextNode(data_cru2);
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
				
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
				                
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_setdatetime(num,ip,door_id,desc,result,data){
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
	error_code = parseInt(data);	
	if (result==1) {
		result = 0;
		switch (error_code) {
			case 1:	msg = "Success ";
						result = 1;
						break;
			case 2: msg = "MU Fail";
						break;
			case 3: msg = "Reader1 Fail";
	 					break;
	 		case 4: msg = "Reader2 Fail";
	 					break;
	 		case 5: msg = "Reader1 + Reader2 Fail";
	 					break;
			default:msg = "Fail ";
		}
	} else {
		msg = getresult(result);
	}				
	var cellText4 = document.createTextNode(msg);

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
}

function show_downloadidtables(num,ip,door_id,desc,result,data){	
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
	var cell5 = document.createElement("td");	
	var cellText5 = document.createTextNode("");		
	var cell6 = document.createElement("td");	
	var cellText6 = document.createTextNode("-");
	
	if(result == "1") {
		if(Number(data) != 0){
			var linkpage = document.createElement('a');
			
			linkpage.setAttribute('href', 'cmd_get_idtables_data.jsp?'+checkModeData(ip, door_id)+'&');
			linkpage.onclick = openInNewWindow;
			linkpage.innerHTML = data;
			setstyleresult(cell5,4);
			cell5.appendChild(linkpage);
			
			linkpage = document.createElement('a');
			linkpage.setAttribute('href', '#');
			linkpage.onclick = function(){ saveFile(ip, door_id); };
			linkpage.innerHTML = "Excel";
			setstyleresult(cell6,4);		
			cell6.appendChild(linkpage);
		}else{	
			cell5.innerHTML = "000000";
			cell5.appendChild(cellText5);
			setstyletxt(cell5,"center");	
			cell6.appendChild(cellText6);
			setstyletxt(cell6,"center");		
		}	
	}else{	
		cell5.innerHTML = "-";
		cell5.appendChild(cellText5);
		setstyletxt(cell5,"center");		
		cell6.appendChild(cellText6);
		setstyletxt(cell6,"center");		
	}	
    
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
	row.appendChild(cell5);	
	row.appendChild(cell6);	
	
	tblBody.appendChild(row);	
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function getMsgHaveYesNo(data,lang){
	var result;
	if(data == "1"){
		if(lang == "th"){
			result = "มี";
		}else{
			result = "Yes";
		}
	}else if(data == "0"){
		if(lang == "th"){
			result = "ไม่มี";
		}else{
			result = "No";
		}
	}else{
		result = "-";
	}
	return result;
}

function getMsgUseYesNo(data,lang){
	var result;
	if(data == "1"){
		if(lang == "th"){
			result = "ใช้";
		}else{
			result = "Yes";
		}
	}else if(data == "0"){
		if(lang == "th"){
			result = "ไม่ใช้";
		}else{
			result = "No";
		}
	}else{
		result = "-";
	}
	return result;
}

function show_gettemplate(num,ip,door_id,desc,result,data){
	var lang = document.getElementById("lang").value;
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
	
	var msg_data = "-";	
	var havefinger1 = "-";
	var havefinger2 = "-";
	var date_time = "-";
	if(result == "1"){
		if (data.length==1) {
			if (data=="1"){
				msg_data = "No data";
			}else if (data=="2") {
				msg_data = "CRU Connect Fail";
			}
		}else{			
			msg_data = data.substring(0,16);
			havefinger1 = getMsgHaveYesNo(data.substring(16,17),lang);
			havefinger2 = getMsgHaveYesNo(data.substring(17,18),lang);
			if(data.substring(18,32).length == 14 && data.substring(18,32) != '**************'){
				date_time = data.substring(24,26)+"/"+data.substring(22,24)+"/"+data.substring(18,22)+" "+data.substring(26,28)+":"+data.substring(28,30)+":"+data.substring(30,32);				
			}else{
				date_time = "-";
			}
		}//if (data.length==1) 
	}//if(result == "1")
				
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(msg_data);
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode(havefinger1);
	var cell7 = document.createElement("td");
	var cellText7 = document.createTextNode(havefinger2);
	var cell8 = document.createElement("td");
	var cellText8 = document.createTextNode(date_time);			
		
	setstyletxt(cell1,"center");		
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	setstyletxt(cell7,"center");
	setstyletxt(cell8,"center");
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	cell7.appendChild(cellText7);	
	cell8.appendChild(cellText8);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);	
	row.appendChild(cell7);
	row.appendChild(cell8);
				                
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_setidtable(num,ip,door_id,desc,result,data){
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
	error_code = parseInt(data);
	if (result==1) {
		result = 0;	   
		switch (error_code) {
			case 1: msg = "Success ";
						result = 1;
						break;
			case 2: msg = "RAM Full";
						break;
			case 3: msg = "MMC Full";
						break;
			case 4: msg = "MMC  Error";
						break;
			default: msg = "Fail";
		}
	}else{
		msg = getresult(result);
	}
			
	var cellText4 = document.createTextNode(msg);
	
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
}

function show_transferdata(num,ip,door_id,desc,result,data){
	var tbl = document.getElementById("table1");
	var tblBody = document.createElement("tbody");
	var row = document.createElement("tr");
	
	var cell1 = document.createElement("td");
	var cellText1 = document.createTextNode(num);
	var cell2 = document.createElement("td");
	var cellText2 = document.createTextNode(door_id);
	var cell3 = document.createElement("td");
	var cellText3 = document.createTextNode(desc);
	
	var num_rec = "-";
	var num_total = "-";
	if (data.substring(0, 1) != "*" && data.length >= 12) {
		num_rec = parseInt(data.substring(0, 6), 10) ;
		num_total = parseInt(data.substring(6, 12), 10);
	}
	
	var cell4 = document.createElement("td");
	var cellText4 = document.createTextNode("");	
	if(result == "1" && num_rec != '-' && num_rec != '0'){
		var linkpage = document.createElement('a');
		linkpage.setAttribute('href', 'cmd_get_transaction_data.jsp?'+checkModeData(ip, door_id));
		linkpage.onclick = openInNewWindow;
		linkpage.innerHTML = getresult(result);	
		setstyleresult(cell4, 4);
		cell4.appendChild(linkpage);
	}else{		  
		cellText4 = document.createTextNode(getresult(result));
		cell4.appendChild(cellText4);			
	}
	
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(num_rec+"/"+num_total);
	
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode("");
	if(result == "1" && num_rec != '-' && num_rec != '0'){
		var linkpage = document.createElement('a');
		linkpage.setAttribute('href', '#');
		linkpage.onclick = function(){ saveFile(ip, door_id); };
		linkpage.innerHTML = "Download";	
		setstyleresult(cell6, 4);
		cell6.appendChild(linkpage);
	}else{		  
		cellText6 = document.createTextNode("-");
		cell6.appendChild(cellText6);			
	}
	
	setstyletxt(cell1,"center");	
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");	 
}

function show_dumpdata(num, ip, door_id, desc, result, data){
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
	
	var num_rec = "-";	
	if (data.substring(0, 1) != "*" && data.length >= 6) {
		num_rec = parseInt(data.substring(0, 6), 10);
	}
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode("");	
	if(result == "1"){
		var linkpage = document.createElement('a');
		linkpage.setAttribute('href', 'cmd_dump_transaction_data.jsp?'+checkModeData(ip, door_id));
		linkpage.onclick = openInNewWindow;
		linkpage.innerHTML = num_rec;	
		setstyleresult(cell5, 4);
		cell5.appendChild(linkpage);
	}else{		  
		cellText5 = document.createTextNode("-");
		cell5.appendChild(cellText5);			
	}
	
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode("");
	if(result == "1"){
		var linkpage = document.createElement('a');
		linkpage.setAttribute('href', '#');
		linkpage.onclick = function(){ saveFile(ip, door_id); };
		linkpage.innerHTML = "Download";	
		setstyleresult(cell6, 4);
		cell6.appendChild(linkpage);
	}else{		  
		cellText6 = document.createTextNode("-");
		cell6.appendChild(cellText6);			
	}
	
	setstyletxt(cell1,"center");	
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_dumpdata_bydatetime(num, ip, door_id, desc, result, data){
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
	var cellText4 = document.createTextNode("");	
	if(result == "1"){
		var linkpage = document.createElement('a');
		linkpage.setAttribute('href', 'cmd_dump_transbydatetime_data.jsp?'+checkModeData(ip, door_id));
		linkpage.onclick = openInNewWindow;
		linkpage.innerHTML = getresult(result);	
		setstyleresult(cell4, 4);
		cell4.appendChild(linkpage);
	}else{		  
		cellText4 = document.createTextNode(getresult(result));
		cell4.appendChild(cellText4);			
	}
	
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode("");
	if(result == "1"){
		var linkpage = document.createElement('a');
		linkpage.setAttribute('href', '#');
		linkpage.onclick = function(){ saveFile(ip, door_id); };
		linkpage.innerHTML = "Download";	
		setstyleresult(cell5, 4);
		cell5.appendChild(linkpage);
	}else{		  
		cellText5 = document.createTextNode("-");
		cell5.appendChild(cellText5);			
	}
	
	setstyletxt(cell1,"center");	
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_getidtable(num,ip,door_id,desc,result,data){	
	var lang = document.getElementById("lang").value;
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
	
	// idcard(16)+issue(2)+pincode(4)+startdate(8)+expiredate(8)+timecode_rd1(2)+timecode_rd2(2)+datetime_data(14)
	var idcard = "-";
	var issue = "-";
	var pincode	= "-";
	var st_date = "";
	var ex_date	= "";
	var time_rd1	= "-";
	var time_rd2	= "-";
	var datetime_data = "-";
	//use finger(1)+blank(1)+name(32)+use mapcard(1)+sn_card(8)+start_time(4)+ex_time(4)+finger1(1)+finger2(1)+datetime_finger(14)
	var usefinger = "-";	
	var name = "-";
	var use_map_card = "-";
	var sn_card = "-";	
	var time1 = "";
	var time2 = "";
	var havefinger1 = "-";
	var havefinger2 = "-";
	var datetime_data2 = "-";
	if (result == "1"){	
		if(data.length >= 123){ //TAFF67										
			idcard = data.substring(0,16);
			issue = data.substring(16,18);	
			if(issue == "" || issue == '**'){
				issue = "-";
			}			
			pincode = data.substring(18,22);
			if(pincode == "" || pincode == '****'){
				pincode = "-";
			}
			if(data.substring(22,30).length == 8 && data.substring(22,30) != '********'){				
				st_date	= data.substring(28,30)+"/"+data.substring(26,28)+"/"+data.substring(22,26);
			}			
			if(data.substring(30,38).length == 8 && data.substring(30,38) != '********'){
				ex_date = data.substring(36,38)+"/"+data.substring(34,36)+"/"+data.substring(30,34);
			}
			if(data.substring(38,40) != '**'){
				time_rd1 = data.substring(38,40);		
			}
			if(data.substring(40,42) != '**'){			
				time_rd2	= data.substring(40,42);	
			}						
			if(data.substring(42,56).length == 14 && data.substring(42,56) != '**************'){
				datetime_data = data.substring(42,56);
				datetime_data = datetime_data.substring(6,8)+"/"+datetime_data.substring(4,6)+"/"+datetime_data.substring(0,4)+" "+datetime_data.substring(8,10)+":"+datetime_data.substring(10,12)+":"+datetime_data.substring(12,14);		
			}
			usefinger = getMsgUseYesNo(data.substring(56,57),lang);			
			if(data.substring(58,90).length == 32 && data.substring(58,59) != '*'){
				name = data.substring(58,90);			
			}			
			use_map_card = getMsgUseYesNo(data.substring(90,91),lang);			
			if(data.substring(91,99).length == 8 && data.substring(91,92) != '*'){
				sn_card = data.substring(91,99).toUpperCase();
				if(data.substring(123,124) != '*'){
					sn_card += data.substring(123,129).toUpperCase();
				}
			}			
			if(data.substring(99,103) != '****' && data.substring(99,103).length == 4){
				time1 = data.substring(99,101)+":"+data.substring(101,103);			
			}
			if(data.substring(103,107) != '****' && data.substring(103,107).length == 4){				
				time2 = data.substring(103,105)+":"+data.substring(105,107);
			}			
			havefinger1 = getMsgHaveYesNo(data.substring(107,108),lang);
			havefinger2 = getMsgHaveYesNo(data.substring(108,109),lang);						
			if(data.substring(109,123).length == 14 && data.substring(109,123) != '**************'){
				datetime_data2 = data.substring(109,123);						
				datetime_data2 = datetime_data2.substring(6,8)+"/"+datetime_data2.substring(4,6)+"/"+datetime_data2.substring(0,4)+" "+datetime_data2.substring(8,10)+":"+datetime_data2.substring(10,12)+":"+datetime_data2.substring(12,14);				
			}
		}else{ // TAFF65		
			idcard = data.substring(0,16);
			issue = data.substring(16,18);	
			if(issue == "" || issue == '**'){
				issue = "-";
			}			
			pincode = data.substring(18,22);
			if(pincode == "" || pincode == '****'){
				pincode = "-";
			}			
			if(data.substring(22,30).length == 8 && data.substring(22,30) != '********'){				
				st_date	= data.substring(28,30)+"/"+data.substring(26,28)+"/"+data.substring(22,26);
			}			
			if(data.substring(30,38).length == 8 && data.substring(30,38) != '********'){
				ex_date = data.substring(36,38)+"/"+data.substring(34,36)+"/"+data.substring(30,34);
			}			
			if(data.substring(38,40) != '**'){
				time_rd1 = data.substring(38,40);		
			}
			if(data.substring(40,42) != '**'){			
				time_rd2	= data.substring(40,42);	
			}									
			if(data.substring(42,56).length == 14 && data.substring(42,56) != '**************'){
				datetime_data = data.substring(42,56);
				datetime_data	= datetime_data.substring(6,8)+"/"+datetime_data.substring(4,6)+"/"+datetime_data.substring(0,4)+" "+datetime_data.substring(8,10)+":"+datetime_data.substring(10,12)+":"+datetime_data.substring(12,14);
			}			
			//data.substring(56,57) Quality1
			havefinger1 = getMsgHaveYesNo(data.substring(57,58),lang);						
			//data.substring(58,59) Quality2
			havefinger2 = getMsgHaveYesNo(data.substring(59,60),lang);
			if(data.substring(60,74).length == 14 && data.substring(60,74) != '**************'){
				datetime_data2 = data.substring(60,74);				
				datetime_data2 = datetime_data2.substring(6,8)+"/"+datetime_data2.substring(4,6)+"/"+datetime_data2.substring(0,4)+" "+datetime_data2.substring(8,10)+":"+datetime_data2.substring(10,12)+":"+datetime_data2.substring(12,14);				
			}
			usefinger = getMsgUseYesNo(data.substring(74,75),lang);
			use_map_card = "-";	
		}
	}
	st_date = st_date+" "+time1;
	if (st_date == " ") {
		st_date = '-';	
	}
	ex_date = ex_date+" "+time2;
	if (ex_date == " ") {
		ex_date = '-';	
	}
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(idcard);
	var cell6 = document.createElement("td");
	var cellText6 = document.createTextNode(issue);
	var cell7 = document.createElement("td");
	var cellText7 = document.createTextNode(pincode);
	var cell8 = document.createElement("td");
	var cellText8 = document.createTextNode(st_date);				
	var cell9 = document.createElement("td");
	var cellText9 = document.createTextNode(ex_date);			
	var cell10 = document.createElement("td");
	var cellText10 = document.createTextNode(time_rd1);		
	var cell11 = document.createElement("td");
	var cellText11 = document.createTextNode(time_rd2);		
	var cell12 = document.createElement("td");
	var cellText12 = document.createTextNode(datetime_data);		
	var cell13 = document.createElement("td");
	var cellText13 = document.createTextNode(usefinger);		
	var cell14 = document.createElement("td");
	var cellText14 = document.createTextNode(name);		
	var cell15 = document.createElement("td");
	var cellText15 = document.createTextNode(use_map_card);		
	var cell16 = document.createElement("td");
	var cellText16 = document.createTextNode(sn_card);	
	var cell17 = document.createElement("td");
	var cellText17 = document.createTextNode(havefinger1);		
	var cell18 = document.createElement("td");
	var cellText18 = document.createTextNode(havefinger2);		
	var cell19 = document.createElement("td");
	var cellText19 = document.createTextNode(datetime_data2);		
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	setstyletxt(cell7,"center");
	setstyletxt(cell8,"center");
	setstyletxt(cell9,"center");				
	setstyletxt(cell10,"center");
	setstyletxt(cell11,"center");
	setstyletxt(cell12,"center");
	setstyletxt(cell13,"center");
	setstyletxt(cell14,"center");
	setstyletxt(cell15,"center");
	setstyletxt(cell16,"center");
	setstyletxt(cell17,"center");
	setstyletxt(cell18,"center");
	setstyletxt(cell19,"center");	
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	cell7.appendChild(cellText7);
	cell8.appendChild(cellText8);
	cell9.appendChild(cellText9);
	cell10.appendChild(cellText10);		
	cell11.appendChild(cellText11);	
	cell12.appendChild(cellText12);	
	cell13.appendChild(cellText13);		
	cell14.appendChild(cellText14);	
	cell15.appendChild(cellText15);
	cell16.appendChild(cellText16);		
	cell17.appendChild(cellText17);	
	cell18.appendChild(cellText18);
	cell19.appendChild(cellText19);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	row.appendChild(cell7);
	row.appendChild(cell8);
	row.appendChild(cell9);
	row.appendChild(cell10);
	row.appendChild(cell11);
	row.appendChild(cell12);
	row.appendChild(cell13);
	row.appendChild(cell14);
	row.appendChild(cell15);
	row.appendChild(cell16);
	row.appendChild(cell17);
	row.appendChild(cell18);
	row.appendChild(cell19);
	
	tblBody.appendChild(row);	
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_uploadidtable(num,ip,door_id,desc,result,data){
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
	var muid = "-";			
	if ((result == "1")||(result == "0")){
		muid = data;
	}	
	var cell5 = document.createElement("td");
	var cellText5 = document.createTextNode(muid);
	
	setstyletxt(cell1,"center");	
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
				
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
				
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
				                
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_setEnroll(ip,door_id,desc,result,data){
	var tbl = document.getElementById("table1");
	var tblBody = document.createElement("tbody");	
	var row = document.createElement("tr");

	var cell1 = document.createElement("td");
	var cellText1 = document.createTextNode(door_id);
	var cell2 = document.createElement("td");
	var cellText2 = document.createTextNode(desc);
	var cell3 = document.createElement("td");
	var cellText3 = "";//document.createTextNode(getresult(result));
	
	var quality = "-";
	var msg = "-";
	if (result== "1"){
		if(data.length == 1){
			if(data=="1"){
				msg = "Error";
				cellText3 = document.createTextNode(msg);
			}else{
			    cellText3 = document.createTextNode(getresult(result));	
			}
		}else{
			quality = data.substring(0,1)+data.substring(1,385);
		}
	}
	
	setstyleip(cell1);
	setstyledesc(cell2);
	setstyleresult(cell3, result);
	
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

 function show_setwritecard(ip,door_id,door_desc,result){	 			
		var tbl = document.getElementById("table1");
		var tblBody = document.createElement("tbody");	
		var row = document.createElement("tr");
	                
		var cell1 = document.createElement("td");
		var cellText1 = document.createTextNode(door_id);
		var cell2 = document.createElement("td");
		var cellText2 = document.createTextNode(desc);
		var cell3 = document.createElement("td");
		msg = getresult(result);		
		var cellText3 = document.createTextNode(msg);				
		
		setstyleip(cell1);
		setstyledesc(cell2);
		setstyleresult(cell3, result);	
			               
		cell1.appendChild(cellText1);
		cell2.appendChild(cellText2);
		cell3.appendChild(cellText3);			
				
		row.appendChild(cell1);
	 	row.appendChild(cell2);
		row.appendChild(cell3);
					
		tblBody.appendChild(row);			
		tbl.appendChild(tblBody);
		tbl.setAttribute("border", "0");
	}
	
function show_getreadcard(num,ip,door_id,desc,result,data){	
	var lang = document.getElementById("lang").value;
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
	var cellText4 = "";
	var cell5 = document.createElement("td");
	var cellText5 = "";
	var cell6 = document.createElement("td");
	var cellText6 = "";
	var cell7 = document.createElement("td");
	var cellText7 = "";
	var cell8 = document.createElement("td");
	var cellText8 = "";
	var cell9 = document.createElement("td");
	var cellText9 = "";
	var cell10 = document.createElement("td");
	var cellText10 = "";
	
	var id = "-";		
	var name = "-";
	var customer = "-";
	var issue = "-";		
	var usefinger = "-";
	var havefinger1 = "-";
	var havefinger2 = "-";	
	if(data != "" || data != null){
		if(result == "1"){
			if(data.length >= 37){
				id = data.substring(0,16);
				name = data.substring(16,32);
				customer = data.substring(32,35);
				issue = data.substring(35,37);	
				if(data.length == 40){										
					usefinger = getMsgUseYesNo(data.substring(37,38),lang);					
					havefinger1 = getMsgHaveYesNo(data.substring(38,39),lang);
					havefinger2 = getMsgHaveYesNo(data.substring(39,40),lang);					
				}
				cellText4 = document.createTextNode(getresult(result));
			}
		}else{
			cellText4 = document.createTextNode(getresult(result));
		}
	}
	cellText5 = document.createTextNode(id);
	cellText6 = document.createTextNode(name);
	cellText7 = document.createTextNode(issue);
	cellText8 = document.createTextNode(usefinger);
	cellText9 = document.createTextNode(havefinger1);
	cellText10 = document.createTextNode(havefinger2);
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	setstyletxt(cell6,"center");
	setstyletxt(cell7,"center");
	setstyletxt(cell8,"center");
	setstyletxt(cell9,"center");
	setstyletxt(cell10,"center");
				
	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	cell6.appendChild(cellText6);
	cell7.appendChild(cellText7);
	cell8.appendChild(cellText8);
	cell9.appendChild(cellText9);
	cell10.appendChild(cellText10);
						
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	row.appendChild(cell6);
	row.appendChild(cell7);
	row.appendChild(cell8);
	row.appendChild(cell9);
	row.appendChild(cell10);
	
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);	
	tbl.setAttribute("border", "0");		
}

function show_readtransaction(num,ip,door_id,desc,result,data){
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
		
	var cell5 = document.createElement("td");
	var cellText5 = "";	
	if(result == "1"){
		cellText5 = document.createTextNode(data);
		if ((data.length == 16)&&(data != "")){			
			var linkpage = document.createElement('a');
			linkpage.setAttribute('href', 'cmd_read_transcard_data.jsp?'+checkModeData(ip, door_id)+'&idcard='+data+"&");
			linkpage.onclick = openInNewWindow;
			linkpage.innerHTML= data;	
			setstyleresult(cell5,4);
			cell5.appendChild(linkpage);
		}else{			
			cell5.appendChild(cellText5);		
		}
	} else{		  
		cellText5 = document.createTextNode("-");
		cell5.appendChild(cellText5);			
	}
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");		

	cell1.appendChild(cellText1);
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);			
	
	row.appendChild(cell1);
	row.appendChild(cell2);
	row.appendChild(cell3);
	row.appendChild(cell4);	
	row.appendChild(cell5);
			
	tblBody.appendChild(row);
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}

function show_gettypecard(num,ip,door_id,desc,result,data){
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
	var cellText4 = "";
		
	if (result == "1") {
		if(data != ""){
			var msg;
			var iData = parseInt(data);
			if(iData != null || iData != ""){
				msg = getresult_typecard(iData);			
			}
			cellText4 = document.createTextNode(msg);
			setstyleresulttypecard(cell4,msg);
		}else{
			cellText4 = document.createTextNode(getresult(result));
		}	  
	} else {
		cellText4 = document.createTextNode(getresult(result));
	}
	
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
}

function show_getserialcard(num,ip,door_id,desc,result,data){
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
	var cellText4 = document.createTextNode(data);
		
/* 	if (result == "1") {
		if(data != ""){
			var msg;
			var iData = parseInt(data);
			if(iData != null || iData != ""){
				msg = getresult_typecard(iData);			
			}
			cellText4 = document.createTextNode(msg);
			setstyleresulttypecard(cell4,msg);
		}else{
			cellText4 = document.createTextNode(getresult(result));
		}	  
	} else {
		cellText4 = document.createTextNode(getresult(result));
	}
 */	
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
}

function show_setadmin(num,ip,door_id,desc,result,data){
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
	var cellText4 = "";
	
	if (result == "1") {
		if(data != ""){
			cellText4 = document.createTextNode(getresultadmin(data));
			setstyleresultadmin(cell4, data);
		}else{
			cellText4 = document.createTextNode(getresult(result));
			setstyleresult(cell4, result);
		}	  
	} else {
		cellText4 = document.createTextNode(getresult(result));
		setstyleresult(cell4, result);
	}
	
	setstyletxt(cell1,"center");	
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	
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
}

function show_getworkcode(num,ip,door_id,desc,result,data){
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
	var workcode = "-";
	if (result == "1") {
		workcode = data;		
	}	
	var cell5 = document.createElement("td");	
	var cellText5 = document.createTextNode(workcode);
	
	setstyletxt(cell1,"center");
	setstyletxt(cell2,"center");
	setstyledesc(cell3);
	setstyleresult(cell4,result);
	setstyletxt(cell5,"center");
	
	cell1.appendChild(cellText1);	
	cell2.appendChild(cellText2);
	cell3.appendChild(cellText3);
	cell4.appendChild(cellText4);
	cell5.appendChild(cellText5);
	
	row.appendChild(cell1);	
	row.appendChild(cell2);
 	row.appendChild(cell3);
	row.appendChild(cell4);
	row.appendChild(cell5);
	
	tblBody.appendChild(row);	
	tbl.appendChild(tblBody);
	tbl.setAttribute("border", "0");
}



function getresult_typecard(result){	
	var msg;
	var iResult = parseInt(result);
	switch (iResult){		
		case 0: msg = "Fail";
		break;
		case 1: msg = "1K";
		break;
		case 2: msg = "4K";
		break;		
		default: msg = "Fail";
	}
	return msg;
}

function setstyleip(object){
	object.style.fontFamily	= "sans-serif";
    object.style.fontSize	= "12px";
    object.style.paddingLeft  = "5px";
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

function setstyleresult_home(object,result){
	object.style.fontFamily	= "sans-serif";
    object.style.fontSize	= "12px";
	object.align = "center" ;
    var iResult = parseInt(result);
		
	switch (iResult){
		case 1: object.style.color = 'green';
		break;
		default: object.style.color = 'red';
	}	
}

function setstyletxt(object , txtalign){
 	object.style.fontFamily	= "sans-serif";
    object.style.fontSize	= "12px";  
	object.align = txtalign;
}

function setstyleresulttypecard(object,result){
	object.style.fontFamily	= "sans-serif";
    object.style.fontSize	= "12px";
	object.align = "center" ;
    var iResult = parseInt(result);		
	switch (iResult){
		case 0: object.style.color = 'red';
		break;
		case 1: object.style.color = 'black';
		break;
		case 2: object.style.color = 'black';
		break;		
		default: object.style.color = 'red';
	}	
}

function getresultadmin(result){	
	var msg;
	var iResult = parseInt(result);
	switch (iResult){		
		case 0: msg = "UnSuccess";
		break;
		case 1: msg = "Success";
		break;
		case 2: msg = "Full Limit (10 user)";
		break;		
		case 3: msg = "Not User ID";
		break;		
		case 4: msg = "Duplicate ID";
		break;		
		default: msg = "Fail";
	}
	return msg;
}

function setstyleresultadmin(object, result){
	object.style.fontFamily	= "sans-serif";
    object.style.fontSize	= "12px";
	object.align = "center" ;
    var iResult = parseInt(result);		
	switch (iResult){
		case 0: object.style.color = 'red';
		break;
		case 1: object.style.color = 'green';
		break;
		case 2: object.style.color = 'red';
		break;	
		case 3: object.style.color = 'red';
		break;
		case 4: object.style.color = 'red';
		break;		
		default: object.style.color = 'red';
	}	
}

function setStyletxtHead(object , txtalign){
	object.style.fontFamily	= "MS Sans Serif";
    object.style.fontSize	= "12px"; 
	object.align = txtalign;	
}

function clearScreen(){	
	var parent = document.getElementById('table1');
	var el = parent.childNodes;
	var j=0;
	for(var i=0;i<el.length;i++){		
		parent.removeChild(el[1]);
	}
}

function checkModeData(ip, door_id){
	var result = 'ip='+ip;
	if(ip == '' || ip == '---.---.---.---'){
		result = 'door_id='+door_id;
	}
	return result;
}