// JavaScript Document
function checkInputFile(obj, sText){
	if (obj.value == ''){
		ModalWarning_TextName(sText, "");
		return false;
	}else{
		document.form1.submit();
	}
}

function checkAllObj(obj, field,lang,txt){	
	if(field == undefined){
		if(lang=="th"){
			if(txt=="reader"){
				alert("ไม่มีข้อมูลหมายเลขเครื่อง");
			}else if(txt=="sec"){
				alert("ไม่มีข้อมูลแผนก");
			}else if(txt=="group"){
				alert("ไม่มีข้อมูลกลุ่มพนักงาน");
			}else if(txt=="door"){
				alert("ไม่มีข้อมูลประตู");
			}else if(txt=="secs"){
				alert("ไม่มีข้อมูลแผนก หรือ กลุ่มพนักงาน");
			}else if(txt=="emps"){
				alert("ไม่มีข้อมูลพนักงาน");
			}
		}else{
			if(txt=="reader"){
				alert("No data reader");
			}else if(txt=="sec"){
				alert("No data section");
			}else if(txt=="group"){
				alert("No data group employee");
			}else if(txt=="door"){
				alert("No data door");
			}else if(txt=="secs"){
				alert("No data section or group employee");
			}else if(txt=="emps"){
				alert("No data employee");
			}
		}
		obj.checked = false ;
	}else{
		if(obj.checked){		
			if(field.length == null){		        
				field.checked = true ;
			}else{
				for (i = 0; i < field.length; i++)
				   field[i].checked = true ;
			}			
		}else{
			if(field.length == null){
				field.checked = false ;
			}else{
				for (i = 0; i < field.length; i++)
					field[i].checked = false ;
			}
		}
	}
}

function checkSelectObj(obj, field){
	//document.form1.checkall.checked = false;
	//alert("ความยาว "+field.length);	
	if(field.length == null){		 
		if(field.checked == true){
		    obj.checked = true ;
		}else{
		    obj.checked = false ;
		}	
	}else{ 
		for (i = 0; i < field.length; i++){
			if(field[i].checked == true){
		    	obj.checked = true ;
			}else{
		    	obj.checked = false ;
		 		break;
		 	}	
		}
	}
}

function checkEmpID(obj, lang, ob){
	var text_warning = "";
	if(ob.value != "" ){	
		obj.checked = false;
		if(lang == "th"){
			text_warning = "คุณเลือกรหัสพนักงานแล้ว";
		}else{
			text_warning = "You selected ID Card";
		}
		ModalWarning_TextName(text_warning, "");
		return false;	
	}
}

function checkDoorID(obj, lang, ob){
	var text_warning = "";
	if(ob.value != "" ){	
		obj.checked = false;
		if(lang == "th"){
			text_warning = "คุณเลือกรหัสแล้ว";
		}else{
			text_warning = "You selected code";
		}
		ModalWarning_TextName(text_warning, "");
		return false;	
	}
}

function checkSectionID(obj, lang, ob){
	var text_warning = "";
	if(ob.value != "" ){	
		obj.checked =true;
		if(lang == "th"){
			text_warning = "คุณเลือกแผนกแล้ว";
		}else{
			text_warning = "You selected section";
		}
		ModalWarning_TextName(text_warning, "");
		return false;
	}
}

function handleDelete(lang, d1, d2, s1, s2, cd, ed, cs, order, supervisor){
	var text_warning = "";
	var currentTime = new Date();
	var month = currentTime.getMonth() + 1;
	if(month < 10){ 
		month = "0"+month
	}
	var day = currentTime.getDate();
	if(day < 10){
		day = "0"+day
	}
	var year = currentTime.getFullYear();
	var text = day + "/" + month + "/" + year;
	var mytext1 = new Array();
	var mytext2 = new Array();
	
	mytext1 = d1.value.split("/");
	mytext2 = d2.value.split("/");

	var t1 = mytext1[1]+"/"+mytext1[0]+"/"+mytext1[2];
	var t2 = mytext2[1]+"/"+mytext2[0]+"/"+mytext2[2];
	var nonums = /^[0-3][0-9]\/[0-1][0-9]\/[0-9][0-9][0-9][0-9]$/;
	var RegExPattern = /^(?=\d)(?:(?:(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2}))($|\ (?=\d)))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;

	var re_time = /^((0\d)|(1\d)|(2[0-3]))\:([0-5]\d)$/;
	flg = 0;
	if ((t1.match(RegExPattern)) && (d1.value!='')) {
		flg = 1;
	}
	
 	if(flg == 0){
		if(lang == "th"){
 			text_warning = "ข้อมูลผิดรูปแบบ กรุณากรอกข้อมูลใหม่ ตัวอย่าง : "+text;
 		}else{
 			text_warning = "Valid Date. Please enter again. Example : "+text;
 		}
		d1.value = "";
		ModalWarning_TextName(text_warning, "d1");
    	return false;
	}else{
		flg = 0;
		if ((t2.match(RegExPattern)) && (d2.value != '')) {
			flg = 1;
 		}
		
		if(flg == 0){
			if(lang == "th"){
				text_warning = "ข้อมูลผิดรูปแบบ กรุณากรอกข้อมูลใหม่ ตัวอย่าง : "+text;
 			}else{
 				text_warning = "Valid Date. Please enter again. Example : "+text;
 			}
			d2.value = "";
			ModalWarning_TextName(text_warning, "d2");
			return false;
		}else{
			flg = 0;
			if ((s1.value.match(re_time)) && (s1.value!='')) {
				flg = 1;
			} 
			
			if(flg == 0){
				if(lang == "th"){
					text_warning = "ข้อมูลผิดรูปแบบ กรุณากรอกข้อมูลใหม่ ตัวอย่าง : 00:00";
				}else{
					text_warning = "Valid Time. Please enter again. Example : 00:00";
				}
				s1.value = "";
				ModalWarning_TextName(text_warning, "s1");
				return false;
			}else{
				flg = 0;							
				if ((s2.value.match( re_time)) && (s2.value!='')) {
					flg = 1;
				}
				if(flg == 0){
					if(lang == "th"){
						text_warning = "ข้อมูลผิดรูปแบบ กรุณากรอกข้อมูลใหม่ ตัวอย่าง : 00:00";
					}else{
						text_warning = "Valid Time. Please enter again. Example : 00:00";
					}
					s2.value = "";
					ModalWarning_TextName(text_warning, "s2");
					return false; 
				}else{
					flg = 0;						
					if(cd.length == null){
						if(cd.checked == true){
							flg = 1;
						}
					}else{
						for(i = 0; i < cd.length; i++){
							if(cd[i].checked == true){
								flg = 1;
								break;  
							}
						}
					}
					if(flg == 0){
						if(lang == "th"){
							text_warning = "กรุณาเลือกหมายเลขเครื่อง";
						}else{
							text_warning = "Please select reader no";
						}
						ModalWarning_TextName(text_warning, "");
						return false;
					}else{
						flg = 0;
						if(ed.value == ''){
							if(cs.length == null){
								if(cs.checked == true){
									flg = 1;
								}
							}else{
								for(i = 0; i < cs.length; i++){
									if(cs[i].checked == true){
										flg = 1;
										break;  
									}
								}
							}
							if(supervisor == false){
								if(flg == 0){
									if(lang == "th"){
										text_warning = "กรุณาเลือกแผนก";
									}else{
										text_warning = "Please select section";
									}
									ModalWarning_TextName(text_warning, "");
									return false;	
								}
							}
						}			
					}	//	else_cd
				}	//	else_s2
			}	//	else_s1
		}	//	else_d2
	}	//	else_d1
	return true;
}	//	function

function checkFormatDateTime(lang, d1, d2, s1, s2){
	var text_warning = "";
	var currentTime = new Date();
	var month = currentTime.getMonth() + 1;
	if(month < 10){ 
		month = "0"+month
	}
	var day = currentTime.getDate();
	if(day < 10){
		day = "0"+day
	}
	var year = currentTime.getFullYear();
	var text = day + "/" + month + "/" + year;
	var mytext1 = new Array();
	var mytext2 = new Array();
	
	mytext1 = d1.value.split("/");
	mytext2 = d2.value.split("/");

	var t1 = mytext1[1]+"/"+mytext1[0]+"/"+mytext1[2];
	var t2 = mytext2[1]+"/"+mytext2[0]+"/"+mytext2[2];
	var nonums = /^[0-3][0-9]\/[0-1][0-9]\/[0-9][0-9][0-9][0-9]$/;
	var RegExPattern = /^(?=\d)(?:(?:(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})|(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))|(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2}))($|\ (?=\d)))?(((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AP]M))|([01]\d|2[0-3])(:[0-5]\d){1,2})?$/;

	var re_time = /^((0\d)|(1\d)|(2[0-3]))\:([0-5]\d)$/;
	flg = 0;
	if ((t1.match(RegExPattern)) && (d1.value!='')) {
		flg = 1;
	}
 	if(flg == 0){
		if(lang == "th"){
 			text_warning = "ข้อมูลผิดรูปแบบ กรุณากรอกข้อมูลใหม่ ตัวอย่าง : "+text;
 		}else{
 			text_warning = "Valid Date. Please enter again. Example : "+text;
 		}
		d1.value = "";
		ModalWarning_TextName(text_warning, "d1");
    	return false;
	}else{
		flg = 0;
		if ((t2.match(RegExPattern)) && (d2.value != '')) {
			flg = 1;
 		}
		
		if(flg == 0){
			if(lang == "th"){
				text_warning = "ข้อมูลผิดรูปแบบ กรุณากรอกข้อมูลใหม่ ตัวอย่าง : "+text;
 			}else{
 				text_warning = "Valid Date. Please enter again. Example : "+text;
 			}
			d2.value = "";
			ModalWarning_TextName(text_warning, "d2");
			return false;
		}else{
			flg = 0;
			if ((s1.value.match(re_time)) && (s1.value!='')) {
				flg = 1;
			} 
			
			if(flg == 0){
				if(lang == "th"){
					text_warning = "ข้อมูลผิดรูปแบบ กรุณากรอกข้อมูลใหม่ ตัวอย่าง : 00:00";
				}else{
					text_warning = "Valid Time. Please enter again. Example : 00:00";
				}
				s1.value = "";
				ModalWarning_TextName(text_warning, "s1");
				return false;
			}else{
				flg = 0;							
				if ((s2.value.match( re_time)) && (s2.value!='')) {
					flg = 1;
				}
				if(flg == 0){
					if(lang == "th"){
						text_warning = "ข้อมูลผิดรูปแบบ กรุณากรอกข้อมูลใหม่ ตัวอย่าง : 00:00";
					}else{
						text_warning = "Valid Time. Please enter again. Example : 00:00";
					}
					s2.value = "";
					ModalWarning_TextName(text_warning, "s2");
					return false; 
				}	//	else_s2
			}	//	else_s1
		}	//	else_d2
	}	//	else_d1
	return true;
}	//	function

function checkDateTime(lang, d1, d2, t1, t2, sText){
	
	var st_date = d1.value.substring(6, 10) + d1.value.substring(3, 5) + d1.value.substring(0, 2) + t1.value.substring(0, 2) + t1.value.substring(3, 5);
	var ed_date = d2.value.substring(6, 10) + d2.value.substring(3, 5) + d2.value.substring(0, 2) + t2.value.substring(0, 2) + t2.value.substring(3, 5);
	
	
	if (Number(st_date) <= Number(ed_date)) {
		return true;
	} else {
		ModalWarning_TextName(sText, "");
		return false;
	}
}

function Length_TextField_Validator(obj){
	// Check the length of the value of the element named text_name
	// from the form named form_name if it's < 3 and > 10 characters
	// display a message asking for different input
	if (obj.value.length < 4) {
		// Build alert box message showing how many characters entered
		mesg = "You have entered " + form_name.text_name.value.length + " character(s)\n"
		mesg = mesg + "Valid entries are between 3 and 10 characters.\n"
		mesg = mesg + "Please verify your input and submit again."
		alert(mesg);
		// Place the cursor on the field for revision
		obj.focus();
		// return false to stop further processing
		return (false);
	}
	// If text_name is not null continue processing
	return (true);
}

// check การ เลือก ประตูและ ip address ที่ เมนูค่าพื้นฐาน 
function settingDatetime(count){   //ส่งค่าไปตอนกดปุ่ม seting
   alert(count);
	for (loop = 0; loop < count; loop++){
		var doorid = document.getElementById("checked"+loop);
		//if (doorid.checked) location.href=;
	}
}

function checkSelect(chkbox, lang){
	var num=0;
	if (document.form1.chkip.checked==true){
		  num ++;			  
	 }
	for (var i=0;i<chkbox.length;i++){
	  if (chkbox[i].checked==true){
		  num ++;
		  break;
	  }
	}
	if(lang=='th'){
	   if (num==0) {
		   alert("กรุณาเลือกรหัสประตู");
		   return false;
		}  else  return true;
	}else{
	 if (num==0) {
		   alert("Please select door");
		   return false;
		}  else  return true;
	}
}

function Confirm_ClearTemp(sText){  	 
	if(!confirm(sText)){ 
		return true;
	}else{ 		
		return false;
	}
}

function setExpireDate(currentObj, nextObj, incYear){
	var st_date = currentObj.value;
	var ex_date = nextObj.value;
	
	var dd1 = st_date.substring(0,2);
	var mm1 = st_date.substring(3,5);
	var yy1 = st_date.substring(6,10);
	
	var dd2 = ex_date.substring(0,2);
	var mm2 = ex_date.substring(3,5);
	var yy2 = ex_date.substring(6,10);
	
	var new_year = null;
	
	if(dd1>dd2 || mm1>mm2 || yy1>yy2){
		new_year =  parseInt(yy1)+incYear;
		ex_date = dd1+"/"+mm1+"/"+new_year;  //ให้วันที่สิ้นสุดเปลี่ยนเป็นวันที่ตามที่เลือกของวันที่เริ่มต้น
		nextObj.value = ex_date;
	}
}

function checkDate(startObj, expireObj, sText){	
	var st_date = startObj.value;
	var ex_date = expireObj.value;
	
	var new_stdate = st_date.substring(6,10)+st_date.substring(3,5)+st_date.substring(0,2);
	var new_exdate = ex_date.substring(6,10)+ex_date.substring(3,5)+ex_date.substring(0,2);	
			
	if(new_stdate > new_exdate){
		alert(sText);
		expireObj.focus();	
	}
}

function checkTimeColon(obj){
	var sTime = obj.value;
	var colon  = 0;
	
	while(sTime.indexOf(":")>=0){
		colon = sTime.indexOf(":");
		sTime = sTime.substring(0,colon)+ sTime.substring(colon+1,sTime.length);
	}
	
	var calst_date = 4 - sTime.length;	
	while(calst_date > 0){
		//alert("0"+st_date)
		sTime = "0"+sTime;
		calst_date = 4 - sTime.length;
	}
	
	hh = sTime.substring(0, 2);
	mm = sTime.substring(2, 4);
	
	sTime = hh+":"+mm;
	obj.value = sTime;	
}

function OnSubmit_Set(lang){
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('กรุณาเลือกรหัสประตู');
		}else{
			alert('Please select door');
		}
	}else{
		if(checkSelect (document.form1.chkip,lang)){						
			window.document.form1.submit();		
		}else{
			return false;
		}
	}
}

function searchKeyPress_tool(e)
 { // look for window.event in case event isn't passed in
    if (window.event) { e = window.event; }
        if (e.keyCode == 13)
            {
                window.document.getElementById('btnok').click();
            }
}
function searchKeyPress_Report(e)
 { // look for window.event in case event isn't passed in
    if (window.event) { e = window.event; }
        if (e.keyCode == 13)
            {
                window.document.getElementById('pdf').click();
            }
}

function CheckNullReaderAndSec(obj,obj2,lang,empid,name,depart){
	flg = 0;	
	//obj = document.form1.check_door
	//obj2 = document.form1.check_sec
	
	//check reader
	if(obj == undefined){
		if(lang=="th"){
			alert("กรุณาเลือกหมายเลขเครื่อง");
		}else{
			alert("Please select reader no");
		}
		return false;
	}else{		
		if(obj.length == null){
			if(obj.checked== true){
				flg = 1;
			}
		}else{
			for(i=0;i<obj.length;i++){
				if(obj[i].checked == true){
					flg = 1;
					break;  
				}
			}
		}
		
		if(flg == 0){
			if(lang=="th"){
				alert("กรุณาเลือกหมายเลขเครื่อง");
			}else{
				alert("Please select reader no");
			}
			return false;
		}
	}
	//check section
	if(empid.value==""){		
		if(obj2 == undefined){
			if(lang=="th"){
				alert("กรุณาเลือกแผนก");
			}else{
				alert("Please select section");
			}	
			return false;
		}
		if(obj2.length == null){
			if(obj2.checked== true){
				flg = 1;
			}
		}else{
			for(i=0;i<obj2.length;i++){
				if(obj2[i].checked == true){
					flg = 1;
					break;  
				}
			}
		}
		
		if(flg == 0){		
			if(lang=="th"){
				alert("กรุณาเลือกแผนก");
			}else{
				alert("Please select section");
			}	
			return false;
		}
	}else{
		for(i=0;i<obj2.length;i++){
			if(obj2[i].checked == true){
				if(lang=="th"){
					alert("คุณเลือกแผนกแล้ว ไม่สามารถเลือกรหัสได้");
				}else{
					alert("You selected section. Can not select idcard");
				}
				empid.value = "";
				name.value = "";
				depart.value = "";
				return false;
			}
		}	
	}
}

//ย้ายฟังก์ชั่นมาวันที่ 27/08/2558
function OnSubmitSet(lang){
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{	
		if(checkSelect_pic(document.form1.chkip,lang)){			
			document.form1.submit();					
		}else{
			return false;
		}
	}
}

function OnSubmitSet_video(file,lang){	
	var filename = file.value;
	
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{	
		if(checkSelect_video(document.form1.chkip,lang)){		
			document.form1.filename.value = filename;
			document.form1.submit();					
		}else{
			return false;
		}
	}
}

function OnSubmitDel_video(file,lang){	
	var filename = file.value;
	
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{	
		if(checkSelect_video(document.form1.chkip,lang)){		
			document.form1.fname.value = filename;
			document.form1.submit();					
		}else{
			return false;
		}
	}
}

function checkdel_video(chkbox, lang){
	var num = 0;
	var sTextDoor = '';
	if(lang=='th'){		
		sTextDoor = "กรุณาเลือกรหัสประตู";				
	}else{		
		sTextDoor = "Please select door";
	}	
	if (document.form1.chkip.checked==true){
		num ++;			  
	}							
	for(var i=0;i<chkbox.length;i++){
		if (chkbox[i].checked==true){
			num ++;
			break;
		}
	}			
	if(num==0){
		alert(sTextDoor);
		return false;
	}else{
		return true;
	}
}
function checkSelect_video(chkbox, lang){
	
	var num = 0;
	var sTextDoor = '';
	var txtPic = '';
	if(lang=='th'){
		txtPic = "กรุณาเลือกวิดีโอที่จะอัพโหลด";
		sTextDoor = "กรุณาเลือกรหัสประตู";				
	}else{
		txtPic = "Plase select video for upload";
		sTextDoor = "Please select door";
	}
	
	if (document.form1.chkip.checked==true){
		num ++;			  
	}
							
	for(var i=0;i<chkbox.length;i++){
		if (chkbox[i].checked==true){
			num ++;
			break;
		}
	}
			
	if(document.fupload.uploadify.value == ""){
		alert(txtPic);
		return false;
	}	
			
	if(num==0){
		alert(sTextDoor);
		return false;
	}else{
		return true;
	}
}
function OnSubmitSet_Picslide(file,lang){	
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{	
		if(checkSelect_pic(document.form1.chkip,lang)){	
			document.form1.filename.value = file.value;
			document.form1.submit();					
		}else{
			return false;
		}
	}
}
function checkSelect_pic(chkbox, lang){
	var num = 0;
	var sTextDoor = '';
	var txtPic = '';
	if(lang=='th'){
		txtPic = "กรุณาเลือกรูปภาพที่จะอัพโหลด";
		sTextDoor = "กรุณาเลือกรหัสประตู";				
	}else{
		txtPic = "Plase select picture for upload";
		sTextDoor = "Please select door";
	}
	
	if (document.form1.chkip.checked==true){
		num ++;			  
	}
							
	for(var i=0;i<chkbox.length;i++){
		if (chkbox[i].checked==true){
			num ++;
			break;
		}
	}
			
	if(document.fupload.uploadify.value == ""){
		alert(txtPic);
		return false;
	}	
	if(num==0){
		alert(sTextDoor);
		return false;
	}else{
		return true;
	}
}

function OnSubmit_delete(lang){		
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{		
		if(checkDoorIP(document.form1.chkip,lang)){
			window.document.form1.submit();
		}else{
			return false;
		}
	}
}

function checkDoorIP(chkbox, lang){
	var text_warning = "";
	var num = 0;
	if(lang == 'th'){		
		text_warning = "กรุณาเลือกรหัสประตู";				
	}else{		
		text_warning = "Please select door";
	}
	if (document.form1.chkip.checked == true){
		num ++;			  
	}
	for(var i=0;i<chkbox.length;i++){
		if (chkbox[i].checked == true){
			num ++;
			break;
		}
	}	
	if(num == 0){
		ModalWarning_TextName(text_warning, '');
		return false;
	}else{
		return true;
	}
}

function checkSelect_idtables(chkbox,lang){
	var sTextEmp = '';
	var sTextDoor = '';
	if(lang == 'th'){
		sTextEmp = "กรุณาเลือกพนักงาน";
		sTextDoor = "กรุณาเลือกรหัสประตู";
	}else{
		sTextEmp = "Please select employee";
		sTextDoor = "Please select door";
	}
	
	var num=0;	
	if(document.form1.chkip.checked == true){
		num++;
	}
	 
	for(var i=0;i<chkbox.length;i++){
		if(chkbox[i].checked==true){
			num ++;
			break;
		}
	}
	//ถ้าค่ารหัสพนักงานเท่ากับค่าว่าง
	if(document.form1.hidden_ID.value== ""){		
		alert(sTextEmp);		
		return false;
	}
		 
	if(num == 0){
		alert(sTextDoor);
		return false;
	}else{
		return true;
	}
}	

function onSubmit(id,rdo,rdo1,rdo2,lang){ // รับค่าสถานะการทำงาน		
	var v1="1";
	var v2="1";
	var v3="1";
	var v="";
	var empids = "";

	for(var i=0;i<rdo.length;i++){
		if(rdo[i].checked==true){	
			v1 = rdo[i].value;
		}
	}	
	for(var i=0;i<rdo1.length;i++){
		if(rdo1[i].checked==true){	
			v2 = rdo1[i].value;
		}
	}
	for(var i=0;i<rdo2.length;i++){
		if(rdo2[i].checked==true){	
			v3 = rdo2[i].value;
		}
	}
	v=v1+v2+v3;	
		 
	if(id.value != "" ){ 
		empids = v+id;
	}
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{  
		if(checkSelect_idtables(document.form1.chkip,lang)){  				    
			document.form1.empids.value=empids;
			document.form1.submit();
		}else{
			return false;
		}
	}
} 
function checkSelect_writecard(chkbox,lang){
	   var sTextEmp,sTextDoor = '';
		if(lang == 'th'){
			sTextEmp = "กรุณากรอกรหัสบัตร";
			sTextDoor = "กรุณาเลือกรหัสประตู";
		}else{
			sTextEmp = "Please Input ID Card";
			sTextDoor = "Please select door";
		}
	  var num=0;
	  
	    if (document.form1.chkip.checked==true){
			  num ++;			  
	 	}
	  for (var i=0;i<chkbox.length;i++){
		  if (chkbox[i].checked==true){
			  num ++;
			  break;
		  }
	  }
	  
	if(document.form1.empid.value == "" ){
		 alert(sTextEmp);
		 return false;
	} 
	document.form1.enname.value = document.form1.name.value;
 
    if (num==0) {
	   alert(sTextDoor);
	   return false;
	}  else  return true;
	
}
function onSubmit_WriteCard(lang){
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{
		if(checkSelect(document.form1.chkip,lang)){
			document.form1.submit();
		}else{
			return false;
		}
	}
}
function onSubmit_WriteCardM(lang){
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{
		if(checkSelect_writecard(document.form1.chkip,lang)){
			document.form1.submit();
		}else{
			return false;
		}
	}
}

function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}

function checksection(obj,field){
var id = "";
	loop = 0;	
	if(field.length == null){		 
		if(field.checked == true){
		     obj.checked = true ;
		}else{
		     obj.checked = false ;
		}	
	}else{ 
		for (i = 0; i < field.length; i++){
			if(field[i].checked == true){
		    	obj.checked = true ;
			}else{
		    	obj.checked = false ;
		 		break;
		 	}	
		}
			
	}
	
	if(field.length == null){	
		if(field.checked == true){	
			loop = 1;
			id = form1.check_door.value;				
		}				
	}else{	
		for (var i = 0; i < field.length; i++) {
			if(field[i].checked == true){
				loop = loop + 1;
				if(loop != 1){
					id = id +","+ field[i].value;	

					if(loop == field.length){
						obj.checked = true;
					}				
				}
				if(loop == 1){
					id = id + field[i].value;
					obj.checked = false;
				}else{
					obj.checked = true;	
				}	
			}else{
				obj.checked = false;
			}								
		}							
	}
	document.getElementById("hiddenSection").value = id;	
}

function CheckAllsec(obj,field,lang){
	if(field == undefined){
		if(lang=="th"){
			alert("ไม่มีข้อมูลแผนก");
		}else{
			alert("No data section");
		}
		obj.checked = false ;
	}else{
		if(obj.checked){
			if(field.length == null){		        
				field.checked = true;
			}else{
				for(i = 0; i < field.length; i++)
					field[i].checked = true;
			}
			document.getElementById("hiddenSection").value = 'all';
			
		}else{
			if(field.length == null){
				field.checked = false;
			}else{
				for(i = 0; i < field.length; i++)
					field[i].checked = false;			
			}
			document.getElementById("hiddenSection").value = '';			
		}	
	}
}
//--------------------CRU 71 ------------------------------

function OnSubmitDumpTnsByDatetime(lang){
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{	
		if(checkDoorIP(document.form1.chkip,lang)){	
			document.form1.submit();					
		}else{
			return false;
		}
	}
}

function OnSubmitSetPicEmp(lang){		
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{	
		if(checkSelect_PicEmp(document.form1.chkip,lang)){	
			document.form1.submit();					
		}else{
			return false;
		}
	}
}

function OnSubmitSetSound(rdo,lang){
	var r1 = '';
	var value_s = '';
	for(var i=0;i<rdo.length;i++){
		if(rdo[i].checked==true){	
			r1 = rdo[i].value;
		}
	}	
	value_s = r1;
	
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{	
		if(checkSelect_sound(document.form1.chkip,lang)){		
			document.form1.typesound.value = value_s;
			document.form1.submit();					
		}else{
			return false;
		}
	}
}
function OnSubmitDelSound(rdo,lang){
	var r1 = '';
	var value_s = '';
	for(var i=0;i<rdo.length;i++){
		if(rdo[i].checked==true){	
			r1 = rdo[i].value;
		}
	}	
	value_s = r1;
	
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{	
		if(checkDoorIP(document.form1.chkip,lang)){
			document.form1.submit();					
		}else{
			return false;
		}
	}
}
function checkSelect_PicEmp(chkbox, lang){
	var num = 0;
	
	var sTextDoor = '';
	var txtPic = '';
	if(lang=='th'){
		txtPic = "กรุณาเลือกรหัสพนักงาน";
		sTextDoor = "กรุณาเลือกรหัสประตู";				
	}else{
		txtPic = "Plase select idcard";
		sTextDoor = "Please select door";
	}
	
	if (document.form1.chkip.checked==true){
		num ++;			  
	}
							
	for(var i=0;i<chkbox.length;i++){
		if (chkbox[i].checked==true){
			num ++;
			break;
		}
	}
		
	if(num==0){
		alert(sTextDoor);
		return false;
	}else{
		return true;
	}
}

function checkSelect_sound(chkbox, lang){
	var num = 0;
	
	var sTextDoor = '';
	var txtPic = '';
	if(lang=='th'){
		txtPic = "กรุณาเลือกไฟล์เสียงที่จะอัพโหลด";
		sTextDoor = "กรุณาเลือกรหัสประตู";				
	}else{
		txtPic = "Plase select file sound for upload";
		sTextDoor = "Please select door";
	}
	
	if (document.form1.chkip.checked==true){
		num ++;			  
	}
							
	for(var i=0;i<chkbox.length;i++){
		if (chkbox[i].checked==true){
			num ++;
			break;
		}
	}
			
	if(document.fupload.uploadify.value == ""){
		alert(txtPic);
		return false;
	}	
			
	if(num==0){
		alert(sTextDoor);
		return false;
	}else{
		return true;
	}
}

function OnSubmitFile_Upload(file,lang){
	
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{
		if(document.form1.command.value=='64'){
			if(document.fupload.files.value==""){
				if(lang == "th"){
					alert('กรุณาเลือกไฟล์วิดีโอที่จะอัพโหลด');
				}else{
					alert('Please select file video for upload');
				}
				return false;
			}
		}
		if(document.form1.command.value=='65'){
			if(document.fupload.files.value==""){
				if(lang == "th"){
					alert('กรุณาเลือกไฟล์รูปภาพที่จะอัพโหลด');
				}else{
					alert('Please select file picture for upload');
				}
				return false;
			}
		}
		if(checkDoorIP(document.form1.chkip,lang)){	
			document.form1.filename.value = file.value;
			document.form1.submit();					
		}else{
			return false;
		}
	}
}
function SubmitCmdD0(lang){
	var stdate = document.form1.st_date.value;
	var endate = document.form1.end_date.value;
	var strDate1 = stdate.substring(6,10)+''+stdate.substring(3,5)+''+stdate.substring(0,2);
	var strDate2 = endate.substring(6,10)+''+endate.substring(3,5)+''+endate.substring(0,2);
	var n1 = parseInt(strDate1);
    var n2 = parseInt(strDate2);  
	
	var numdate = n2-n1; 
	var numdate2 = n1-n2;
	
	if(numdate > 31 || numdate2 > 31){
		if(lang == "th"){
			alert('กำหนดค่าวันที่ไม่เกิน 31 วัน');
		}else{
			alert('set date not over 31 days');
		}
		return false;
	}
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{	
		if(checkDoorIP(document.form1.chkip,lang)){			
			document.form1.submit();					
		}else{
			return false;
		}
	}
}
function OnSubmitDelFile(file, sText, sDel, lang, txtPage){
	var text_warning = "";
	num = 0;
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			text_warning = 'ไม่มีข้อมูลประตู';
		}else{
			text_warning = 'No data door';
		}
		ModalWarning_TextName(text_warning, '');
	}else{
		if(file.value != "" && document.form1.delall.checked == true){
			if(lang == "th"){
				text_warning = 'กรุณาเลือกลบแบบไฟล์  หรือ ลบไฟล์ทั้งหมด ';
			}else{
				text_warning = 'Select delete file or delete file all';
			}
			ModalWarning_TextName(text_warning, '');
			return false;
		}else{
			if(file.value != ""){
				num++;
				document.form1.delall.checked = false;
			//	ValidateExtension();
			//	document.getElementById("delall").disabled = true;
				var allowedFiles = '';
				var regex = '';
				if(txtPage == "vdo"){
					regex = new RegExp("(^.*\.(mp4|MP4)$)");
					allowedFiles = ['.mp4'];
				}else {
					regex = new RegExp("(^.*\.(jpg|JPG)$)");
					allowedFiles = ['.jpg'];
				}
				var fileUpload = document.getElementById("files");
				if (!regex.test(fileUpload.value.toLowerCase())) {
					if(lang == 'th'){
						text_warning = "กรุณาอัปโหลดไฟล์ที่มีนามสกุล  " + allowedFiles + " เท่านั้น";
					}else{
						text_warning = "Please upload files having extensions " + allowedFiles + " only.";
					}
					ModalWarning_TextName(text_warning, 'file');
					return false;
				}else{ 
					if(checkDoorIP(document.form1.chkip,lang)){
						document.form1.filename.value = file.value;	
				
					//	window.document.form1.submit();		
						$('#myModalConnectHW').modal('show');
						window.document.form1.action = 'SetRequest.do'
						window.document.form1.target = 'connect_hw';
						window.document.form1.submit();
					}	
				}
			}else{
				if(document.form1.delall.checked == true){			
					if(checkDoorIP(document.form1.chkip, lang)){
						document.getElementById("text_confirm").innerHTML = sDel + "?";
						$('#myModalConfirm').modal('show');	
					}
				}			
			}
		}
		
		if(document.form1.delall.checked == false){
			if(num == 0){
				ModalWarning_TextName(sText, 'file');
				return false;
			}
		}
	}
}

function SubmitCommandIP(lang){
	if(document.form1.chkip == undefined){
		if(lang == "th"){
			alert('ไม่มีข้อมูลประตู');
		}else{
			alert('No data door');
		}
	}else{	
		if(checkDoorIP(document.form1.chkip,lang)){
			document.form1.submit();					
		}else{
			return false;
		}
	}
}

function checkedid(msgalert){	
	if(document.form1.delall.checked == true){		
		if(document.form1.files.value!=""){
			ModalWarning_TextName(msgalert, "");
			document.form1.delall.checked = false;
		}else{
			document.getElementById('files').readOnly = true;
			document.getElementById('files').style.background = "f0f0f0";
			document.getElementById("imgfied").disabled = true;
		}			
	}else{
		document.getElementById('files').readOnly = false;
		document.getElementById('files').style.background = "ffffff";
		document.getElementById("imgfied").disabled = false;
	}	
}
function OnloadDelFile(){
	if(document.form1.delall.checked == true){		
		if(document.form1.files.value!=""){					
			document.form1.delall.checked = false;
		}else{
			document.getElementById('files').readOnly = true;
			document.getElementById('files').style.background = "f0f0f0";
			document.getElementById("imgfied").disabled = true;
		}			
	}else{
		document.getElementById('files').readOnly = false;
		document.getElementById('files').style.background = "ffffff";
		document.getElementById("imgfied").disabled = false;
	}	
}

//	[Connect HW & Report] History Checkbox	================================
function historyCheckbox(obj, chkData){
	var objData = "";
	for(i = 0; i < obj.length; i++){
		if(obj[i].checked == true){
			objData = objData + obj[i].value+",";
		}
	}
	if(objData != ""){
		objData = new Array( objData.substring(0, (objData.length -1)) );
	}
	sessionStorage.setItem(chkData, objData);
}

function loadCheckbox(obj, chkData){
	if(sessionStorage.getItem(chkData) !== null){
		var chkDataArr = sessionStorage.getItem(chkData).split(",");
		for(i = 0; i < obj.length; i++){
			for(j = 0; j < chkDataArr.length; j++){
				if(chkDataArr[j] == obj[i].value){
					obj[i].checked = true;
					break;
				}
			}
		}
		if(obj.length == chkDataArr.length){
			if(chkData == 'door'){
				document.form1.checkall.checked = true;
			}else if(chkData == 'section'){
				document.form1.checkall2.checked = true;
			}
		}
	}
}

//	Connect HW
function Clear_Session_Table(clear_ses, key){ 
	if(clear_ses == 'true'){
		sessionStorage.removeItem(key);
	}else{
		loadCheckbox(document.form1.chkip, "door");
	}
}

//	Report
function Clear_Session_Table_Report(clear_ses, key1, key2){
	if(clear_ses == 'true'){
		sessionStorage.removeItem(key1);
		sessionStorage.removeItem(key2);
	}else{
		loadCheckbox(document.form1.check_door, "door");
		loadCheckbox(document.form1.check_sec, "section");
	}
}
//	========================================================================


