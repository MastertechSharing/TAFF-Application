var req;
function Inint_AJAX() {
	try { return new ActiveXObject("Msxml2.XMLHTTP");  } catch(e) {} //IE
	try { return new ActiveXObject("Microsoft.XMLHTTP"); } catch(e) {} //IE
	try { return new XMLHttpRequest(); } catch(e) {} //Native Javascript
	alert("XMLHttpRequest not supported");
	return null;
}

function get_datatransaction(data) {			
	var random = Math.random();
	req = Inint_AJAX();
	req.onreadystatechange = getdata;	
	
	/*
	if(data.event_code == 48){		
		data.id = "****************";		
	}
	*/
	
	var lang = document.getElementById("lang").value;			
	var door_id = data.readerid.substr(0,4);	
	var eventcode = data.event_code;		 
	var param = "";	
		param = "idcard="+data.id+
	    "&doorid="+door_id +
		"&eventcode="+eventcode+"&lang="+lang;
	
	req.open('POST',"GetDataMonitor.do", true);
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=TIS-620");
	req.send(param);
}

String.prototype.trim = function(){
	return this.replace(/^\s*/, "").replace(/\s*$/, "");
}

function diaplayDataFromSever(data){
	document.getElementById('dispaly').innerHTML += data;	
}

function diaplayDataObjectFromSever(data){  	
    get_datatransaction(data);	
	displaydata(data);		
}

function getPort(){
	var port = document.getElementById("server_port").value;
	return port;
}

function ImgLoad(door_id,id){
	var myobj = document.getElementById("img_emp_"+door_id);		
	if(myobj != null){	
		var oImg = new Image();
		oImg.src = "photos/"+id+".jpg";
		oImg.onload = function(){ myobj.src = oImg.src; }		
		oImg.onerror = function(){ 		
			oImg.src = "photos/"+id+".JPG"; 
			oImg.onerror = function(){ 
				oImg.src = "photos/person.png";
			}
		}
	}	
}

function getdata() {	
	if (req.readyState == 4) {// Complete		
		if (req.status == 200) {// OK response
			var response = req.responseXML;
			var message = response.getElementsByTagName("data")[0];
			if (message !=null && message.childNodes.length >= 6) {
				//***** Value from XML *******
				
				var door_id = message.childNodes[0].firstChild.nodeValue;				
				var idcard = message.childNodes[1].firstChild.nodeValue;				
				var fname = message.childNodes[2].firstChild.nodeValue;				
				var sname = message.childNodes[3].firstChild.nodeValue;					
				var event_code = message.childNodes[4].firstChild.nodeValue;
				var event_desc = message.childNodes[5].firstChild.nodeValue;				
				
				var page = document.getElementById("data_page").value;
				if((page == "map") || (page == "row")){
				
					var tb_emp = document.getElementById("tb_emp_"+door_id);	
					if(tb_emp != null){
						if(idcard != '****************'){
							tb_emp.innerHTML = "<b><span onClick=\"show_detail2('"+idcard.trim()+"', 'employee_detail');\" style='color: #337AB7; cursor: pointer; cursor: hand;'>"+idcard+"</span></b>";
						}
					}
					
					var tb_emp_name = document.getElementById('tb_names_'+door_id);				
					if (tb_emp_name != null){
						if(idcard != '****************'){
							if(fname == '-' && sname == '-'){
								tb_emp_name.innerHTML = "-";
							}else if(fname != "-" && sname == '-'){
								tb_emp_name.innerHTML = fname;
							}else{
								tb_emp_name.innerHTML = fname+" &nbsp; "+sname;
							}
						}					
					}
			
					var tb_event_code = document.getElementById('door_event_'+door_id);	
					if (tb_event_code != null){
						tb_event_code.innerHTML = "<b><span onClick=\"show_detail2('"+event_code.trim()+"', 'event_detail');\" style='color: #337AB7; cursor: pointer; cursor: hand;'>"+event_code+"</span></b> : "+event_desc;
					}
				}
			}
			
		} else {
			document.getElementById("load").innerHTML = '';		
		}
	}
}

function displaydata(data){
	
	var idcard = data.id.trim();
	var datadate = data.data_date;
	var datatime = data.data_time; 
	var reader_id = data.readerid;
	var door_id = data.readerid.substr(0,4);
	var doorduty = data.readerid.substr(4,1);	    
	var event_code = data.event_code;
	
	var lang = document.getElementById("lang").value;
	var page = document.getElementById("data_page").value;
	var pic_door = 'images/';
	if((page == "map") || (page == "row")){		//	Page Map & Row	================================================================================
	
		// ส่วนของการทำงานของประตู การเปิด ปิดประตู กรณีมีการแตะบัตรเข้ามา
		var tb_door = document.getElementById('imgdoor_'+door_id);
		
		if((event_code==29)||(event_code==32)||(event_code==33)||(event_code==36)){
			pic_door = pic_door+'close_door.gif';
		}else if((event_code==30)||(event_code==31)||(event_code==34)){
			pic_door = pic_door+'open_door.gif';
		}else if(event_code==35){
			pic_door = pic_door+'alarm_door.gif';
		}else pic_door = pic_door+'close_door.gif';

		if(tb_door != null){
			tb_door.innerHTML = "<img src="+pic_door+" width='24' height='24' align='absmiddle'>"
							+ "<div onClick='show_detail2(\""+door_id+"\", \"map_detail\");' style='margin-top: -11px; margin-left: 22px; color: #286090; font-size: 10px;'>"
							+ "	<span class='glyphicon glyphicon-info-sign' id='search"+door_id+"'> </span>"
							+ "</div>";
		}
		// ส่วนของเหตุการณ์ประตู
		var tb_event = document.getElementById('door_duty'+door_id);
		if(tb_event != null){		
			if(lang == "th"){
				if(doorduty == "1"){
					tb_event.innerHTML = "<span class='label label-success'> เข้า </span>";
				}else if(doorduty == "2"){
					tb_event.innerHTML = "<span class='label label-danger'> ออก </span>";
				}else{
					tb_event.innerHTML = "<span class='label label-danger'> "+door_duty+" </span>";
				}
			}else{
				if(doorduty == "1"){
					tb_event.innerHTML = "<span class='label label-success'> In </span>";
				}else if(doorduty == "2"){
					tb_event.innerHTML = "<span class='label label-danger'> Out </span>";
				}else{
					tb_event.innerHTML = "<span class='label label-danger'> "+door_duty+" </span>";
				}
			}
		}
		
		var tb_emp_date = document.getElementById('date_'+door_id);
		if(tb_emp_date != null){
			tb_emp_date.innerHTML =  datadate+" "+datatime;
		}	
		
		// ส่วนของ รูปพนักงาน
		var tb_pic_emp = document.getElementById("tb_pic_"+door_id);	
		if(tb_pic_emp != null){	
			if(idcard !='****************' && idcard != ''){ // มี id เข้ามา	
				ImgLoad(door_id,idcard);
			}
		}
	
		if(page == "map"){
			showAutoDetail(door_id);
		}
		
	}else if(page == "event"){					//	Page Event	====================================================================================
	
		var img_door = document.getElementById('img_door'+door_id);
		var chk_hide = datadate+" "+datatime;
		var group_img = "";
		var hints = "";
		
		if( (event_code ==  1) || (event_code ==  2) || (event_code ==  3) || (event_code ==  4) || (event_code ==  5) || 
			(event_code ==  9) || (event_code == 10) || (event_code == 26) || (event_code == 28) || (event_code == 30) || 
			(event_code == 32) || (event_code == 33) || (event_code == 36) || (event_code == 38) || (event_code == 40) || 
			(event_code == 41) || (event_code == 44) || (event_code == 46) || (event_code == 47) ){
			pic_door = pic_door+'door_close.gif';
			group_img = "0";
		}else if( (event_code == 31) || (event_code == 34) ){
			pic_door = pic_door+'door_open.gif';
			group_img = "1";
		}else if( (event_code == 35) || (event_code == 37) || (event_code == 39) || (event_code == 43) || (event_code == 45) ){
			pic_door = pic_door+'door_alarm.gif';
			group_img = "2";
		}else if( (event_code ==  6) || (event_code ==  7) || (event_code ==  8) || (event_code == 11) || (event_code == 12) || 
				  (event_code == 13) || (event_code == 14) || (event_code == 15) || (event_code == 16) || (event_code == 17) || 
				  (event_code == 18) || (event_code == 19) || (event_code == 20) || (event_code == 21) || (event_code == 22) || 
				  (event_code == 23) || (event_code == 24) ){
			pic_door = pic_door+'door_alert.gif';
			group_img = "3";
		}else if( (event_code == 25) || (event_code == 27) ){
			pic_door = pic_door+'door_disconnect.gif';
			group_img = "4";
		}else if( (event_code == 29) || (event_code == 48) || (event_code == 49) ){
			pic_door = pic_door+'door_switch.gif';
			group_img = "5";
		}else if( (event_code == 42) ){
			pic_door = pic_door+'door_stop.gif';
			group_img = "6";
		}else if( (event_code == 52) ){
			pic_door = pic_door+'door_unplug.gif';
			group_img = "7";
		}
		
		if(door_id != null){
			img_door.src = pic_door;
			var idDisplay = "";
			if((idcard != null) &&(idcard != "")){
				idDisplay  = "[ID:"+idcard+"]";
			}
			if(event_code != null){
				hints = "<p style='text-align: left; max-width: 200px;'>"+idDisplay+" "+datadate+" "+datatime+"</p> <p style='text-align: left; max-width: 200px; margin-top: -10px; margin-bottom: 0px;'> ["+event_code+"] *"+displayText(group_img, lang)+" </p>";
			}else{
				hints = "<p style='text-align: left; max-width: 200px; margin-bottom: 0px;'> *"+displayText('0', lang)+" </p>";
			}
			$("#img_door"+door_id).attr('data-original-title', hints).tooltip('show');
			
			setTimeout(function() {
				$("#img_door"+door_id).tooltip('hide');
			}, 8000)
		}
	
	}
}

function displayText(group_img, lang) {
	var result = "";
	if (lang == "th") {
		switch (parseInt(group_img)) {
		case 0: result = "ประตูปิด";
			break;
		case 1: result = "ประตูเปิด";
			break;
		case 2: result = "สัญญานแจ้งเตือน";
			break;
		case 3: result = "การแตะบัตรไม่ถูกต้อง";
			break;
		case 4: result = "ติดต่อเซิฟเวอร์ไม่ได้";
			break;
		case 5: result = "การกดปุ่ม";
			break;
		case 6: result = "ระบบไฟฟ้าหยุดทำงาน";
			break;
		case 7: result = "เครื่องถูกถอดออกจากที่ติดตั้ง";
			break;
		}
	} else {
		switch (parseInt(group_img)) {
		case 0: result = "Close Door";
			break;
		case 1: result = "Open Door";
			break;
		case 2: result = "Alarm Door";
			break;
		case 3: result = "Transaction Error";
			break;
		case 4: result = "Disconnect Server";
			break;
		case 5: result = "Switch Press";
			break;
		case 6: result = "Door Stop";
			break;
		case 7: result = "Door Unplug";
			break;
		}
	}
	return result;
}