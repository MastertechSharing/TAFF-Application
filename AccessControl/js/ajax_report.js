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
	}else if((request_Command=="D0") 
		|| (request_Command=="D1")
		|| (request_Command=="D2")		//	ลบวิดีโอ และ ลบวิดีโอทั้งหมด 
		|| (request_Command=="D3")){
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
		||(request_Command==55)||(request_Command==58)||(request_Command==59)||(request_Command==61)||(request_Command==12)||(request_Command==13)||(request_Command==88))){
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