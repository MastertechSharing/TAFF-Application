// JavaScript Document

function checkIPAddress(currentObj, nextObj, sText){	
//	if((key >= 48 && key <= 57) || (key == 13)){	
		if(currentObj.value.length == 3){
			var ip = currentObj.value.valueOf();
			if(Number(ip) > 254){
				ModalWarning_ObjectName(sText, currentObj);
				currentObj.value = "";
			}else{
				nextObj.focus();
				/*if(nextObj.value.valueOf() <= 0){
					nextObj.value = currentObj.value.substring(3, 4);
				}*/
			}
		}else{
			return false;
		}
	/*}else{
		return false;
	}	*/
}

function checkMACAddress(currentObj, nextObj, sText){	
//	if((key >= 48 && key <= 57) || (key == 13)){	
		if(currentObj.value.length == 2){
		/*
			var ip = currentObj.value.valueOf();
			if(Number(ip) > 254){
				ModalWarning_ObjectName(sText, currentObj);
				currentObj.value = "";
			}else{
		*/
				nextObj.focus();
				/*if(nextObj.value.valueOf() <= 0){
					nextObj.value = currentObj.value.substring(3, 4);
				}*/
		//	}
		}else{
			return false;
		}
	/*}else{
		return false;
	}	*/
}

//check การกรอก hour
function checkHour(currentObj, nextObj, sText){
	// key 48 = '0', 57 = '9', 8 = backspace, 13 = Enter
	//	if ((key >= 48 && key <= 57) || (key == 8) || (key == 13)) {		
		if(currentObj.value.length == 2){  
			var time = currentObj.value.valueOf();
		   	if(time > 23){
				ModalWarning_ObjectName(sText, currentObj);
		  		currentObj.value = "";
		   	/*}else{ 								
				//nextObj.focus();
				if(nextObj.value.valueOf() <= 0) 
					nextObj.value = current.value.substring(0, 2);*/	
			}
	   	}else{
			return false;
 		}
	/*} else {
  		return false;
 	}*/
}

//check การกรอก minute
function checkMinute(currentObj, nextObj, sText){
	// key 48 = '0', 57 = '9', 8 = backspace, 13 = Enter	
	//	if ((key >= 48 && key <= 57) || (key == 8) || (key == 13)) {		
		if(currentObj.value.length == 2){
			var time = currentObj.value.valueOf();
		   	if(time > 59){
				ModalWarning_ObjectName(sText, currentObj);
		  		currentObj.value = "";
		   	/*}else{ 				
				//nextObj.focus();				
				if(nextObj.value.valueOf() <= 0) 
					nextObj.value = current.value.substring(0, 2);*/
			}
		}else{
			return false;
	 	}
	/*}else{
		return false;
 	}  */
}

function checkTimeAndDefault(currentObj, dfvalue, lang){
	var text_warning = "";
	var tPart = currentObj.value.match(/^(\d\d)\:(\d\d)$/);  
	
    if(tPart){	//	ใส่ค่าถูกรูปแบบ		
		if(tPart[1] < 24 && tPart[2] < 60){		  		
			return true;
		}else if (tPart[1] > 23){ 
			if(lang == "th"){
				text_warning = "กรุณากรอกข้อมูล ชั่วโมง 00-23 เท่านั้น";
			}else{
				text_warning = "Please input  Hour 00-23 only";
			}
			ModalWarning_ObjectName(text_warning, currentObj);
			currentObj.value = dfvalue;
			return false;			
		}else if(tPart[2] > 59){
			if(lang == "th"){
				text_warning = "กรุณากรอกข้อมูล นาที 00-59 เท่านั้น";
			}else{
				text_warning = "Please input  Minute 00-59 only";
			}
			ModalWarning_ObjectName(text_warning, currentObj);
			currentObj.value = dfvalue;
			return false;
		}
	}else{	
		if(lang == "th"){
			text_warning = "ข้อมูลผิดรูปแบบ กรุณากรอกข้อมูลใหม่ ตัวอย่าง : 00:00";
		}else{
			text_warning = "Valid Time. Please enter again.  Example : 00:00";
		}
		ModalWarning_ObjectName(text_warning, currentObj);
	  	currentObj.value = dfvalue;
    	currentObj.select();
	}
}

function checkKeyPadL(key, currentObj, nextObj, strLen, strValue) {	
	//	key 9 = tab, 13 = Enter
	var data = currentObj.value;
	if(data.length > 0){ 			
	/*	if(data.length == (strLen)){
			nextObj.focus();		
		}else{	 */
			if((key == 9) || (key == 11) || (key == 13)){
				while (data.length < strLen){
					data = strValue+data;
				}						
			}
	//	}
	}
	currentObj.value = data;
/*	if(data.length == (strLen)){
		nextObj.focus();		
	}	
*/
}

function checkLengthPadL(currentObj, strLen, strValue){	
	var data = currentObj.value;
	if(data.length > 0){  	
		while(data.length < strLen){
			data = strValue+data;
		}
	}
	currentObj.value = data;
}

function KeyPadL(currentObj, strLen, strValue){	
	var data = currentObj.value;		
	while(data.length < strLen){
		data = strValue+data;
	}
	currentObj.value = data;
}

function nextObject(key, nextObj){
	if((key == 9) || (key == 11) || (key == 13)){
		nextObj.focus();
	}	
}

function IsValidNumber(){
	// key 48 = '0', 57 = '9',
	if(event.keyCode < 48 || event.keyCode > 57){//|| (event.keyCode = 9) || (event.keyCode = 13)){  
		event.returnValue = false; 
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	} 
}

function IsValidNumberForDate(){
	// key 48 = '0', 57 = '9', 47 = '/'
	if(event.keyCode < 47 || event.keyCode > 57){  
		event.returnValue = false; 
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	} 
}

function IsValidNumberForTime(){
	// key 48 = '0', 57 = '9', 58 = ':'
	if(event.keyCode < 48 || event.keyCode > 58){
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	} 
}

function IsValidNumberForFolat(){
	// key 48 = '0', 57 = '9', 46 = '.'
	// key = event.keyCode;
	if((event.keyCode != 46) & (event.keyCode < 48 || event.keyCode > 57)){
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}

function IsValidNumberAndDash(){
	if((event.keyCode < 48 || event.keyCode > 57 ) && (event.keyCode != 45 )){ 
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}

function IsValidCharacter(){
	// key 48 = '0', 57 = '9', 65 = 'A', 90 = 'Z', 97 = 'a', 122 = 'z'
	// key = event.keyCode;
	if(event.keyCode < 48 || event.keyCode >122 || event.keyCode == 58 || event.keyCode == 59 || event.keyCode == 61 ||(event.keyCode == 60) || (event.keyCode == 62) || (event.keyCode == 63) || (event.keyCode == 64) || (event.keyCode >= 91) && (event.keyCode <= 95 )){
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}
function IsValidCharacter_AZ09(){
	// key 48 = '0', 57 = '9', 65 = 'A', 90 = 'Z'
	// key = event.keyCode;
	if(event.keyCode < 48 || event.keyCode >122 || event.keyCode == 58 || event.keyCode == 59 || event.keyCode == 61 ||(event.keyCode == 60) || (event.keyCode == 62) || (event.keyCode == 63) || (event.keyCode == 64) || (event.keyCode >= 91) && (event.keyCode <= 95) || (event.keyCode >= 97) && (event.keyCode <= 122)){
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}
function IsValidCharacter_AZaz(){
	// key 65 = 'A', 90 = 'Z', 97 = 'a', 122 = 'z'
	// key = event.keyCode;
	if((event.keyCode < 65 || event.keyCode > 90) && (event.keyCode < 97 || event.keyCode > 122)){
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}
function IsValidCharacters(){
	// key 48 = '0', 57 = '9', 65 = 'A', 90 = 'Z', 97 = 'a', 122 = 'z',95='_',45='-'
	// key = event.keyCode;
	if(event.keyCode < 45 || event.keyCode == 46 || event.keyCode == 47  || event.keyCode >122 || event.keyCode == 58 || event.keyCode == 59 || event.keyCode == 61 ||(event.keyCode == 60) || (event.keyCode == 62) || (event.keyCode == 63) || (event.keyCode == 64) || (event.keyCode >= 91) && (event.keyCode <= 94 )){
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}
function IsValidCharacterEn(){
	// key 48 = '0', 57 = '9', 65 = 'A', 90 = 'Z', 97 = 'a', 122 = 'z', 32= ,
	// key = event.keyCode;
	if((event.keyCode != 32 && event.keyCode != 189) && event.keyCode < 48 || event.keyCode >122 || event.keyCode == 58 || event.keyCode == 59 || event.keyCode == 61 ||(event.keyCode == 60) || (event.keyCode == 62) || (event.keyCode == 63) || (event.keyCode == 64) || (event.keyCode >= 91) && (event.keyCode <= 95 )){
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}
function IsValidCharThEn_keyword(){
	//กรอกได้เฉพาะ 0-9,a-z,A-Z,ก-ฮ ภาษาไทย เท่านั้น ,95='_',45='-'
	if(((event.keyCode >= 33) && (event.keyCode <= 44)) || ((event.keyCode >= 46) && (event.keyCode <= 47)) || ((event.keyCode >= 58) && (event.keyCode <= 64)) || ((event.keyCode >= 91) && (event.keyCode <= 94)) || ((event.keyCode >= 123)&& (event.keyCode <= 126))){
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}
function IsValidHex(){
	//(event.keyCode < 48 || event.keyCode >57) = 0-9
	//(event.keyCode < 65 || event.keyCode >70) = A-F
	//(event.keyCode < 97 || event.keyCode >102 ) = a-f	
	if((event.keyCode < 48 || event.keyCode >57) && (event.keyCode < 65 || event.keyCode >70)  && (event.keyCode < 97 || event.keyCode >102 )){	
		event.returnValue = false;		
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}

function IsValidAlphabet(){
	// key 33=!, 34=", 37=%, 38=&, 39=', 47=/, 60=<, 62=>, 63=?, 92=\, 94=^, 124=|	
	if((event.keyCode == 33) || (event.keyCode == 34) || (event.keyCode == 37) || (event.keyCode == 38) || (event.keyCode == 39) || (event.keyCode == 47) || (event.keyCode == 60) || (event.keyCode == 62) || (event.keyCode == 63) || (event.keyCode == 92) || (event.keyCode == 94) || (event.keyCode == 124)){
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}
function IsValidCharacterEn2(){
	if((event.keyCode != 32 && event.keyCode != 187 && event.keyCode != 45) && event.keyCode < 48 || event.keyCode >122 || event.keyCode == 58 || event.keyCode == 59 || event.keyCode == 61 ||(event.keyCode == 60) || (event.keyCode == 62) || (event.keyCode == 63) || (event.keyCode == 64) || (event.keyCode >= 91) && (event.keyCode <= 95 )){
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}
function IsValidKeyEng(){ // En
	if(((event.keyCode < 48) || (event.keyCode > 122))){  
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	} 
}

function IsValidKeyThai(){ //Th
	if(((event.keyCode >= 65) && (event.keyCode <= 122))){  
		event.returnValue = false;
		event.cancel = true;	//	Fix javascript not work in IE11
		if (event.preventDefault) {
			event.preventDefault();
		}
	}
}

/*function checkCharacter(data, lang){
	//key 33=!, 34=", 37=%, 38=&, 39=', 47=/, 60=<, 62=>, 63=?, 92=\, 94=^, 124=|			
	var str = " ! ' % & /<>?\^|"; //ตัวอักษรที่ไม่ต้องการให้มี
	if(data.indexOf("'")!= -1) return true; //เครื่องหมาย '
	if(data.indexOf('"')!= -1) return true; //เครื่องหมาย "
	for(i = 0; i < str.length; i++){
		if(data.indexOf(str.charAt(i))!= -1){
		//	alert('มีอักขระพิเศษในข้อความ');
			ModalWarning_TextName("มีอักขระพิเศษในข้อความ", "");
			return true;
		}
	}
	return false;
}*/

function checkEmail(obj, lang){
	var text_warning = "";
	if((obj.value != '') && ( !(/[0-9a-zA-Z_\.\-]+@[0-9a-zA-Z_\.\-]+.[a-zA-Z]+/ig).test(obj.value ))){
		if(lang == 'th'){
			text_warning = "กรอก E-mail ไม่ถูกต้อง";
		}else{  
			text_warning = "Please fill in correct email address.";
		}
		ModalWarning_ObjectName(text_warning, obj);
		return false; 
	}
}

function checkPublicID(obj, lang){
	var text_warning = "";
	if((obj.value != '') && (!(/(^\d{13}$)|(^\d{1}-\d{4}-\d{5}-\d{2}-\d{1}$)/).test(obj.value))){
		if(lang == 'th'){
			text_warning = "หมายเลขบัตรประชาชนไม่ถูกต้อง ตัวอย่าง : x-xxxx-xxxxx-xx-x";
		}else{
			text_warning = "Please fill in correct card id entered as: x-xxxx-xxxxx-xx-x";
		}
		ModalWarning_ObjectName(text_warning, obj);
		return false;
	}
}

function checkPhoneNumber(obj, lang){
	//	var objRegExp  = /(^\d{5}$)|(^\d{5}-\d{4}$)/; 99999 or 99999-9999
	//	var regExp = /(^\d{10}$)|(^\d{3}-\d{3}-\d{4}$)/;
	//	Check for correct phone number // if(!/(^[0-9\s\-\+]{10,})$/gi.test(str.value ){
	//	if ((str.value != '') && (!(/^\(?([0-9]{3})\)?[-]?([0-9]{3})?[-]?([0-9]{4})$/).test(str.value))){		
	var text_warning = "";
	if((obj.value != '') && (!(/(^\d{10}$)|(^\d{3}-\d{3}-\d{4}$)/).test(obj.value))){			
		if(lang == 'th'){
			text_warning =  "กรอกเบอร์โทรศัพท์ไม่ถูกต้อง ตัวอย่าง : xxx-xxx-xxxx";
		}else{
			text_warning = "Please fill in correct phone number entered as: xxx-xxx-xxxx";
		}
		ModalWarning_ObjectName(text_warning, obj);	
		return false;
	}			 
}

//เติม , (คอมมา)
function dokeyup(currentObj){
	var key = event.keyCode;
	if( key != 37 & key != 39 & key != 110 ){
		var value = currentObj.value;
		var svals = value.split( "." ); //แยกทศนิยมออก
		var sval = svals[0]; //ตัวเลขจำนวนเต็ม
     
		var n = 0;
		var result = "";
		var c = "";
		for( a = sval.length - 1; a >= 0 ; a-- ){
			c = sval.charAt(a);
			if( c != ':' ){
				n++;
                if ( n == 3 ){
					result = ":" + result;
					n = 1;
				}
				result = c + result;
			}
		}
     
		if( svals[1] ){
			result = result + '.' + svals[1];
		};    
		currentObj.value = result;
	}
}

function searchKeyPress(e){
    // look for window.event in case event isn't passed in
	if (window.event) { e = window.event; }
	if (e.keyCode == 13){
		window.document.getElementById('btnok').click();
	}
}

var new_year = null;
var dates = null;
var month = null;
var exdate = null;

function onChange_Date(st_date,ex_date){	
	var dd1 = st_date.substring(0,2);
	var mm1 = st_date.substring(3,5);
	var yy1 = st_date.substring(6,10);
	
	var dd2 = ex_date.substring(0,2);
	var mm2 = ex_date.substring(3,5);
	var yy2 = ex_date.substring(6,10);
	
	var st_dateYMD = yy1+mm1+dd1;
	var ex_dateYMD = yy2+mm2+dd2;
	
    if(st_dateYMD > ex_dateYMD){		
		new_year = parseInt(yy1)+1;		
		var year = st_dateYMD.substring(0,4);		
		if (isLeapYear(year)){
			if(dd1 == 29 && (mm1 == 2 || mm1 == 02)){					
				dates = 28;
					if(dates < 10){dates='0' + dates; }else{dates = dates;}	
				month = parseInt(mm1);
					if(month < 10){month='0' + month; }else{month = month;}			
				exdate = dates+"/"+month+"/"+new_year;
			}else{
				exdate = dd1+"/"+mm1+"/"+new_year;	
			}
		}else{
			exdate = dd1+"/"+mm1+"/"+new_year;
		}			
		document.form1.ex_date.value = exdate;
	}
}

function isLeapYear(yr) {
  return new Date(yr,2-1,29).getDate()==29;
}

function padZero (num, length) {
    num = String(num);
    length = parseInt(length) || 2;
    while (num.length < length)
        num = "0" + num;
    return num;
};

function daysInMonth(month,year) {
	var m = [31,28,31,30,31,30,31,31,30,31,30,31];
	if (month != 2) return m[month - 1];
	if (year%4 != 0) return m[1];
	if (year%100 == 0 && year%400 != 0) return m[1];
	return m[1] + 1;
}
function getDaysInFebruary (p_iYearEng)
  {
    var numDays = 28 ;
    if (((p_iYearEng) % 4 == 0) && ( (!((p_iYearEng) % 100 == 0)) || ((p_iYearEng) % 400 == 0))){
      numDays = 29 ;
    }
    return numDays ;
  }

// แฟ้มที่มี 3 ฟิวด์เช็คเหมือนกัน  Location, Depart, Position, Type, Group	================
function Confirm_add_edit(obj, sText, sText2, url, act){
	if(obj.value == ""){
		ModalWarning_ObjectName(sText2, obj);
		return false;
	}
	if(act == 'add'){
		document.form1.action = url;
		document.form1.submit();
	}else{
		ModalConfirm(sText, url);
	}	
}

function ModalConfirm(sText, url){
	document.getElementById("text_confirm").innerHTML = sText;
	document.getElementById("text_url").value = url;
	$('#myModalConfirm').modal('show');
}

function Confirm_Button(){
	document.form1.action = document.getElementById("text_url").value;
	document.form1.submit();	
}
//	============================================================================

function onSubmit(obj, url, sText2){
	if(obj.value == ""){
		ModalWarning_ObjectName(sText2, obj);
		return false;
	}else{
		document.form1.action = url;
		document.form1.submit();
	}
}
/*hhmmss*/

function chkEmptyTimeSec(hh1,mm1,ss1,hh2,mm2,ss2){
		if(hh1=='' || hh2=='' || mm1=='' || mm2=='' || ss1=='' || ss2==''){
			return true;
		}else{
			return false;
		}		
	}
function comparetimesec(hh1,mm1,ss1,hh2,mm2,ss2){
	var time1 = hh1+mm1+ss1;
	var time2 = hh2+mm2+ss2;
	
	if(time1 > time2){
		return true;
	}else{
		return false;
	}

}
//hhmm
function chkEmptyTime(hh1,mm1,hh2,mm2){
		if(hh1=='' || hh2=='' || mm1=='' || mm2==''){
			return true;
		}else{
			return false;
		}		
	}
	
function comparetime(hh1,mm1,hh2,mm2){
	var time1 = hh1+mm1;
	var time2 = hh2+mm2;
	
	if(time1 > time2){
		return true;
	}else{
		return false;
	}

}
// time lock, unlock
function ConfirmEditTime(act,url,sText,msg_t1,msg_chkmis_t1,msg_t2,msg_chkmis_t2,msg_t3,msg_chkmis_t3,
msg_t4,msg_chkmis_t4,msg_t5,msg_chkmis_t5){
	
	//------------time1------------
	var time1,hh1,mm1,hh2,mm2="";
	hh1=document.form1.hh1.value;
	mm1=document.form1.mm1.value;
	hh2=document.form1.hh2.value;
	mm2=document.form1.mm2.value;
	time1 = hh1+mm1+hh2+mm2;	
	if(time1!=''){
		if(chkEmptyTime(hh1,mm1,hh2,mm2)){
			ModalWarning_TextName(msg_t1, "");
			return false;
			
		}else{			
			if(comparetime(hh1,mm1,hh2,mm2)){
				ModalWarning_TextName(msg_chkmis_t1, "");
				return false;
			}
		}
	}
	//------------time2------------	
	var time2,hh3,mm3,hh4,mm4="";
	hh3=document.form1.hh3.value;
	mm3=document.form1.mm3.value;
	hh4=document.form1.hh4.value;
	mm4=document.form1.mm4.value;	
	time2 = hh3+mm3+hh4+mm4;
	if(time2 !=''){
		if(chkEmptyTime(hh3,mm3,hh4,mm4)){
			ModalWarning_TextName(msg_t2, "");
			return false;
		}else{		
			if(comparetime(hh3,mm3,hh4,mm4)){
				ModalWarning_TextName(msg_chkmis_t2, "");
				return false;
			}
		}
	}
	//------------time3------------
	var time3,hh5,mm5,hh6,mm6="";
	hh5=document.form1.hh5.value;
	mm5=document.form1.mm5.value;
	hh6=document.form1.hh6.value;
	mm6=document.form1.mm6.value;	
	time3 = hh5+mm5+hh6+mm6;
	if(time3 !=''){
		if(chkEmptyTime(hh5,mm5,hh6,mm6)){
			ModalWarning_TextName(msg_t3, "");
			return false;
		}else{
			if(comparetime(hh5,mm5,hh6,mm6)){
				ModalWarning_TextName(msg_chkmis_t3, "");
				return false;
			}
		}
	}
	//------------time4------------
	var time4,hh7,mm7,hh8,mm8="";
	hh7=document.form1.hh7.value;
	mm7=document.form1.mm7.value;
	hh8=document.form1.hh8.value;
	mm8=document.form1.mm8.value;	
	time4 = hh7+mm7+hh8+mm8;
	if(time4!=''){
		if(chkEmptyTime(hh7,mm7,hh8,mm8)){
			ModalWarning_TextName(msg_t4, "");
			return false;
		}else{
			if(comparetime(hh7,mm7,hh8,mm8)){
				ModalWarning_TextName(msg_chkmis_t4, "");
				return false;
			}
		}
	}
	//------------time5------------
	var time5,hh9,mm9,hh10,mm10="";
	hh9=document.form1.hh9.value;
	mm9=document.form1.mm9.value;
	hh10=document.form1.hh10.value;
	mm10=document.form1.mm10.value;	
	time5 = hh9+mm9+hh10+mm10;
	if(time5!=''){
	if(chkEmptyTime(hh9,mm9,hh10,mm10)){
			ModalWarning_TextName(msg_t5, "");
			return false;
		}else{
			if(comparetime(hh9,mm9,hh10,mm10)){
				ModalWarning_TextName(msg_chkmis_t5, "");
				return false;
			}
		}
	}
	
	if(act == 'edit'){
		ModalConfirm(sText, url);
	}
}


function ConfirmAddEditTimeDesc(action,obj,url,sText,sText2,msg_t1,msg_chkmis_t1,msg_t2,msg_chkmis_t2,msg_t3,msg_chkmis_t3,
msg_t4,msg_chkmis_t4,msg_t5,msg_chkmis_t5){
	
	if(obj.value == ""){
		ModalWarning_ObjectName(sText2, obj);
		return false;
	}
	
	//------------time1------------
	var time1,hh1,mm1,hh2,mm2="";
	hh1=document.form1.hh1.value;
	mm1=document.form1.mm1.value;
	hh2=document.form1.hh2.value;
	mm2=document.form1.mm2.value;
	time1 = hh1+mm1+hh2+mm2;	
	if(time1 != ''){
		if(chkEmptyTime(hh1,mm1,hh2,mm2)){
			ModalWarning_TextName(msg_t1, "");
			return false;
		}else{			
			if(comparetime(hh1,mm1,hh2,mm2)){
				ModalWarning_TextName(msg_chkmis_t1, "");
				return false;
			}
		}
	}
	//------------time2------------	
	var time2,hh3,mm3,hh4,mm4="";
	hh3=document.form1.hh3.value;
	mm3=document.form1.mm3.value;
	hh4=document.form1.hh4.value;
	mm4=document.form1.mm4.value;	
	time2 = hh3+mm3+hh4+mm4;
	if(time2 !=''){
		if(chkEmptyTime(hh3,mm3,hh4,mm4)){
			ModalWarning_TextName(msg_t2, "");
			return false;
		}else{		
			if(comparetime(hh3,mm3,hh4,mm4)){
				ModalWarning_TextName(msg_chkmis_t2, "");
				return false;
			}
		}
	}
	//------------time3------------
	var time3,hh5,mm5,hh6,mm6="";
	hh5=document.form1.hh5.value;
	mm5=document.form1.mm5.value;
	hh6=document.form1.hh6.value;
	mm6=document.form1.mm6.value;	
	time3 = hh5+mm5+hh6+mm6;
	if(time3 !=''){
		if(chkEmptyTime(hh5,mm5,hh6,mm6)){
			ModalWarning_TextName(msg_t3, "");
			return false;
		}else{
			if(comparetime(hh5,mm5,hh6,mm6)){
				ModalWarning_TextName(msg_chkmis_t3, "");
				return false;
			}
		}
	}
	//------------time4------------
	var time4,hh7,mm7,hh8,mm8="";
	hh7=document.form1.hh7.value;
	mm7=document.form1.mm7.value;
	hh8=document.form1.hh8.value;
	mm8=document.form1.mm8.value;	
	time4 = hh7+mm7+hh8+mm8;
	if(time4!=''){
		if(chkEmptyTime(hh7,mm7,hh8,mm8)){
			ModalWarning_TextName(msg_t4, "");
			return false;
		}else{
			if(comparetime(hh7,mm7,hh8,mm8)){
				ModalWarning_TextName(msg_chkmis_t4, "");
				return false;
			}
		}
	}
	//------------time5------------
	var time5,hh9,mm9,hh10,mm10="";
	hh9=document.form1.hh9.value;
	mm9=document.form1.mm9.value;
	hh10=document.form1.hh10.value;
	mm10=document.form1.mm10.value;	
	time5 = hh9+mm9+hh10+mm10;
	if(time5!=''){
	if(chkEmptyTime(hh9,mm9,hh10,mm10)){
			ModalWarning_TextName(msg_t5, "");
			return false;
		}else{
			if(comparetime(hh9,mm9,hh10,mm10)){
				ModalWarning_TextName(msg_chkmis_t5, "");
				return false;
			}
		}
	}
	
	if(action == 'add'){		
		document.form1.action = url;		//	"module/act_timedesc.jsp?action=add";
		document.form1.submit();
	}else{
		ModalConfirm(sText, url);			//	"module/act_timedesc.jsp?action=edit";
	}	
}

// tomeonoutput4
function ConfirmEditOutput4(url,sText,
	alertT1,alertMT1,alertT2,alertMT2,alertT3,alertMT3,alertT4,alertMT4,alertT5,alertMT5,
	alertT6,alertMT6,alertT7,alertMT7,alertT8,alertMT8,alertT9,alertMT9,alertT10,alertMT10,
	alertT11,alertMT11,alertT12,alertMT12,alertT13,alertMT13,alertT14,alertMT14,alertT15,alertMT15,
	alertT16,alertMT16,alertT17,alertMT17,alertT18,alertMT18,alertT19,alertMT19,alertT20,alertMT20,
	alertT21,alertMT21,alertT22,alertMT22,alertT23,alertMT23,alertT24,alertMT24,alertT25,alertMT25,
	alertT26,alertMT26,alertT27,alertMT27,alertT28,alertMT28,alertT29,alertMT29,alertT30,alertMT30 ){
	//time1
	var time1,hh1,mm1,ss1,hh2,mm2,ss2="";
	hh1=document.form1.hh1.value;
	mm1=document.form1.mm1.value;
	ss1=document.form1.ss1.value;
	hh2=document.form1.hh2.value;
	mm2=document.form1.mm2.value;
	ss2=document.form1.ss2.value;
	time1 = hh1+mm1+ss1+hh2+mm2+ss2;	
	if(time1!=''){		
		if(chkEmptyTimeSec(hh1,mm1,ss1,hh2,mm2.ss2)){
			ModalWarning_TextName(alertT1, "");
			return false;			
		}else{			
			if(comparetimesec(hh1,mm1,ss1,hh2,mm2,ss2)){
				ModalWarning_TextName(alertMT1, "");
				return false;
			}
		}
	}	
	// time2
	var time2,hh3,mm3,ss3,hh4,mm4,ss4="";
	hh3=document.form1.hh3.value;
	mm3=document.form1.mm3.value;
	ss3=document.form1.ss3.value;
	hh4=document.form1.hh4.value;
	mm4=document.form1.mm4.value;
	ss4=document.form1.ss4.value;
	time2 = hh3+mm3+ss3+hh4+mm4+ss4;
	if(time2!=''){
		if(chkEmptyTimeSec(hh3,mm3,ss3,hh4,mm4.ss4)){
			ModalWarning_TextName(alertT2, "");
			return false;			
		}else{			
			if(comparetimesec(hh3,mm3,ss3,hh4,mm4,ss4)){
				ModalWarning_TextName(alertMT2, "");
				return false;
			}
		}
	
	}
	// time3
	var time3,hh5,mm5,ss5,hh6,mm6,ss6="";
	hh5=document.form1.hh5.value;
	mm5=document.form1.mm5.value;
	ss5=document.form1.ss5.value;
	hh6=document.form1.hh6.value;
	mm6=document.form1.mm6.value;
	ss6=document.form1.ss6.value;
	time3 = hh5+mm5+ss5+hh6+mm6+ss6;
	if(time3!=''){
		if(chkEmptyTimeSec(hh5,mm5,ss5,hh6,mm6.ss6)){
			ModalWarning_TextName(alertT3, "");
			return false;			
		}else{			
			if(comparetimesec(hh5,mm5,ss5,hh6,mm6,ss6)){
				ModalWarning_TextName(alertMT3, "");
				return false;
			}
		}
	
	}
	// time4
	var time4,hh7,mm7,ss7,hh8,mm8,ss8="";
	hh7=document.form1.hh7.value;
	mm7=document.form1.mm7.value;
	ss7=document.form1.ss7.value;
	hh8=document.form1.hh8.value;
	mm8=document.form1.mm8.value;
	ss8=document.form1.ss8.value;
	time4 = hh7+mm7+ss7+hh8+mm8+ss8;
	if(time4!=''){
		if(chkEmptyTimeSec(hh7,mm7,ss7,hh8,mm8.ss8)){
			ModalWarning_TextName(alertT4, "");
			return false;			
		}else{			
			if(comparetimesec(hh7,mm7,ss7,hh8,mm8.ss8)){
				ModalWarning_TextName(alertMT4, "");
				return false;
			}
		}
	
	}
	// time5
	var time5,hh9,mm9,ss9,hh10,mm10,ss10="";
	hh9=document.form1.hh9.value;
	mm9=document.form1.mm9.value;
	ss9=document.form1.ss9.value;
	hh10=document.form1.hh10.value;
	mm10=document.form1.mm10.value;
	ss10=document.form1.ss10.value;
	time5 = hh9+mm9+ss9+hh10+mm10+ss10;
	if(time5!=''){
		if(chkEmptyTimeSec(hh9,mm9,ss9,hh10,mm10.ss10)){
			ModalWarning_TextName(alertT5, "");
			return false;			
		}else{			
			if(comparetimesec(hh9,mm9,ss9,hh10,mm10.ss10)){
				ModalWarning_TextName(alertMT5, "");
				return false;
			}
		}
	
	}
	// time6
	var time6,hh11,mm11,ss11,hh12,mm12,ss12="";
	hh11=document.form1.hh11.value;
	mm11=document.form1.mm11.value;
	ss11=document.form1.ss11.value;
	hh12=document.form1.hh12.value;
	mm12=document.form1.mm12.value;
	ss12=document.form1.ss12.value;
	time6 = hh11+mm11+ss11+hh12+mm12+ss12;
	if(time6!=''){
		if(chkEmptyTimeSec(hh11,mm11,ss11,hh12,mm12,ss12)){
			ModalWarning_TextName(alertT6, "");
			return false;			
		}else{			
			if(comparetimesec(hh11,mm11,ss11,hh12,mm12,ss12)){
				ModalWarning_TextName(alertMT6, "");
				return false;
			}
		}
	
	}
	// time7
	var time7,hh13,mm13,ss13,hh14,mm14,ss14="";
	hh13=document.form1.hh13.value;
	mm13=document.form1.mm13.value;
	ss13=document.form1.ss13.value;
	hh14=document.form1.hh14.value;
	mm14=document.form1.mm14.value;
	ss14=document.form1.ss14.value;
	time7 = hh13+mm13+ss13+hh14+mm14+ss14;
	if(time7!=''){
		if(chkEmptyTimeSec(hh13,mm13,ss13,hh14,mm14,ss14)){
			ModalWarning_TextName(alertT7, "");
			return false;			
		}else{			
			if(comparetimesec(hh13,mm13,ss13,hh14,mm14,ss14)){
				ModalWarning_TextName(alertMT7, "");
				return false;
			}
		}
	
	}
	// time8
	var time8,hh15,mm15,ss15,hh16,mm16,ss16="";
	hh15=document.form1.hh15.value;
	mm15=document.form1.mm15.value;
	ss15=document.form1.ss15.value;
	hh16=document.form1.hh16.value;
	mm16=document.form1.mm16.value;
	ss16=document.form1.ss16.value;
	time8 = hh15+mm15+ss15+hh16+mm16+ss16;
	if(time8!=''){
		if(chkEmptyTimeSec(hh15,mm15,ss15,hh16,mm16,ss16)){
			ModalWarning_TextName(alertT8, "");
			return false;			
		}else{			
			if(comparetimesec(hh15,mm15,ss15,hh16,mm16,ss16)){
				ModalWarning_TextName(alertMT8, "");
				return false;
			}
		}
	
	}
	// time9
	var time9,hh17,mm17,ss17,hh18,mm18,ss18="";
	hh17=document.form1.hh17.value;
	mm17=document.form1.mm17.value;
	ss17=document.form1.ss17.value;
	hh18=document.form1.hh18.value;
	mm18=document.form1.mm18.value;
	ss18=document.form1.ss18.value;
	time9 = hh17+mm17+ss17+hh18+mm18+ss18;
	if(time9!=''){
		if(chkEmptyTimeSec(hh17,mm17,ss17,hh18,mm18,ss18)){
			ModalWarning_TextName(alertT9, "");
			return false;			
		}else{			
			if(comparetimesec(hh17,mm17,ss17,hh18,mm18,ss18)){
				ModalWarning_TextName(alertMT9, "");
				return false;
			}
		}
	
	}
	// time10
	var time10,hh19,mm19,ss19,hh20,mm20,ss20="";
	hh19=document.form1.hh19.value;
	mm19=document.form1.mm19.value;
	ss19=document.form1.ss19.value;
	hh20=document.form1.hh20.value;
	mm20=document.form1.mm20.value;
	ss20=document.form1.ss20.value;
	time10 = hh19+mm19+ss19+hh20+mm20+ss20;
	if(time10!=''){
		if(chkEmptyTimeSec(hh19,mm19,ss19,hh20,mm20,ss20)){
				ModalWarning_TextName(alertT10, "");
			return false;			
		}else{			
			if(comparetimesec(hh19,mm19,ss19,hh20,mm20,ss20)){
				ModalWarning_TextName(alertMT10, "");
				return false;
			}
		}
	
	}
	// time11
	var time11,hh21,mm21,ss21,hh22,mm22,ss22="";
	hh21=document.form1.hh21.value;
	mm21=document.form1.mm21.value;
	ss21=document.form1.ss21.value;
	hh22=document.form1.hh22.value;
	mm22=document.form1.mm22.value;
	ss22=document.form1.ss22.value;
	time11 = hh21+mm21+ss21+hh22+mm22+ss22;
	if(time11!=''){
		if(chkEmptyTimeSec(hh21,mm21,ss21,hh22,mm22,ss22)){
			ModalWarning_TextName(alertT11, "");
			return false;			
		}else{			
			if(comparetimesec(hh21,mm21,ss21,hh22,mm22,ss22)){
				ModalWarning_TextName(alertMT11, "");
				return false;
			}
		}
	
	}
	// time12	
	var time12,hh23,mm23,ss23,hh24,mm24,ss24="";
	hh23=document.form1.hh23.value;
	mm23=document.form1.mm23.value;
	ss23=document.form1.ss23.value;
	hh24=document.form1.hh24.value;
	mm24=document.form1.mm24.value;
	ss24=document.form1.ss24.value;
	time12 = hh23+mm23+ss23+hh24+mm24+ss24;
	if(time12!=''){
		if(chkEmptyTimeSec(hh23,mm23,ss23,hh24,mm24,ss24)){
			ModalWarning_TextName(alertT12, "");
			return false;			
		}else{			
			if(comparetimesec(hh23,mm23,ss23,hh24,mm24,ss24)){
				ModalWarning_TextName(alertMT12, "");
				return false;
			}
		}
	
	}
	
	// time13
	var time13,hh25,mm25,ss25,hh26,mm26,ss26="";
	hh25=document.form1.hh25.value;
	mm25=document.form1.mm25.value;
	ss25=document.form1.ss25.value;
	hh26=document.form1.hh26.value;
	mm26=document.form1.mm26.value;
	ss26=document.form1.ss26.value;
	time13 = hh25+mm25+ss25+hh26+mm26+ss26;
	if(time13!=''){
		if(chkEmptyTimeSec(hh25,mm25,ss25,hh26,mm26,ss26)){
			ModalWarning_TextName(alertT13, "");
			return false;			
		}else{			
			if(comparetimesec(hh25,mm25,ss25,hh26,mm26,ss26)){
				ModalWarning_TextName(alertMT13, "");
				return false;
			}
		}
	
	}
	// time14
	var time14,hh27,mm27,ss27,hh28,mm28,ss28="";
	hh27=document.form1.hh27.value;
	mm27=document.form1.mm27.value;
	ss27=document.form1.ss27.value;
	hh28=document.form1.hh28.value;
	mm28=document.form1.mm28.value;
	ss28=document.form1.ss28.value;
	time14 = hh27+mm27+ss27+hh28+mm28+ss28;
	if(time14!=''){
		if(chkEmptyTimeSec(hh27,mm27,ss27,hh28,mm28,ss28)){
			ModalWarning_TextName(alertT14, "");
			return false;			
		}else{			
			if(comparetimesec(hh27,mm27,ss27,hh28,mm28,ss28)){
				ModalWarning_TextName(alertMT14, "");
				return false;
			}
		}
	
	}
	// time15
	var time15,hh29,mm29,ss29,hh30,mm30,ss30="";
	hh29=document.form1.hh29.value;
	mm29=document.form1.mm29.value;
	ss29=document.form1.ss29.value;
	hh30=document.form1.hh30.value;
	mm30=document.form1.mm30.value;
	ss30=document.form1.ss30.value;
	time15 = hh29+mm29+ss29+hh30+mm30+ss30;
	if(time15!=''){
		if(chkEmptyTimeSec(hh29,mm29,ss29,hh30,mm30,ss30)){
			ModalWarning_TextName(alertT15, "");
			return false;			
		}else{			
			if(comparetimesec(hh29,mm29,ss29,hh30,mm30,ss30)){
				ModalWarning_TextName(alertMT15, "");
				return false;
			}
		}
	
	}
	//time16
	var time16,hh31,mm31,ss31,hh32,mm32,ss32="";
	hh31=document.form1.hh31.value;
	mm31=document.form1.mm31.value;
	ss31=document.form1.ss31.value;
	hh32=document.form1.hh32.value;
	mm32=document.form1.mm32.value;
	ss32=document.form1.ss32.value;
	time16 = hh31+mm31+ss31+hh32+mm32+ss32;
	if(time16!=''){
		if(chkEmptyTimeSec(hh31,mm31,ss31,hh32,mm32,ss32)){
			ModalWarning_TextName(alertT16, "");
			return false;			
		}else{			
			if(comparetimesec(hh31,mm31,ss31,hh32,mm32,ss32)){
				ModalWarning_TextName(alertMT16, "");
				return false;
			}
		}
	
	}
	// time17
	var time17,hh33,mm33,ss33,hh34,mm34,ss34="";
	hh33=document.form1.hh33.value;
	mm33=document.form1.mm33.value;
	ss33=document.form1.ss33.value;
	hh34=document.form1.hh34.value;
	mm34=document.form1.mm34.value;
	ss34=document.form1.ss34.value;
	time17 = hh33+mm33+ss33+hh34+mm34+ss34;
	if(time17!=''){
		if(chkEmptyTimeSec(hh33,mm33,ss33,hh34,mm34,ss34)){
			ModalWarning_TextName(alertT17, "");
			return false;			
		}else{			
			if(comparetimesec(hh33,mm33,ss33,hh34,mm34,ss34)){
				ModalWarning_TextName(alertMT17, "");
				return false;
			}
		}
	
	}
	// time18
	var time18,hh35,mm35,ss35,hh36,mm36,ss36="";
	hh35=document.form1.hh35.value;
	mm35=document.form1.mm35.value;
	ss35=document.form1.ss35.value;
	hh36=document.form1.hh36.value;
	mm36=document.form1.mm36.value;
	ss36=document.form1.ss36.value;
	time18 = hh35+mm35+ss35+hh36+mm36+ss36;
	if(time18!=''){
		if(chkEmptyTimeSec(hh35,mm35,ss35,hh36,mm36,ss36)){
			ModalWarning_TextName(alertT18, "");
			return false;			
		}else{			
			if(comparetimesec(hh35,mm35,ss35,hh36,mm36,ss36)){
				ModalWarning_TextName(alertMT18, "");
				return false;
			}
		}
	
	}
	// time19
	var time19,hh37,mm37,ss37,hh38,mm38,ss38="";
	hh37=document.form1.hh37.value;
	mm37=document.form1.mm37.value;
	ss37=document.form1.ss37.value;
	hh38=document.form1.hh38.value;
	mm38=document.form1.mm38.value;
	ss38=document.form1.ss38.value;
	time19 = hh37+mm37+ss37+hh38+mm38+ss38;
	if(time19!=''){
		if(chkEmptyTimeSec(hh37,mm37,ss37,hh38,mm38,ss38)){
			ModalWarning_TextName(alertT19, "");
			return false;			
		}else{			
			if(comparetimesec(hh37,mm37,ss37,hh38,mm38,ss38)){
				ModalWarning_TextName(alertMT19, "");
				return false;
			}
		}
	
	}
	// time20
	var time20,hh39,mm39,ss39,hh40,mm40,ss40="";
	hh39=document.form1.hh39.value;
	mm39=document.form1.mm39.value;
	ss39=document.form1.ss39.value;
	hh40=document.form1.hh40.value;
	mm40=document.form1.mm40.value;
	ss40=document.form1.ss40.value;
	time20 = hh39+mm39+ss39+hh40+mm40+ss40;
	if(time20!=''){
		if(chkEmptyTimeSec(hh39,mm39,ss39,hh40,mm40,ss40)){
			ModalWarning_TextName(alertT20, "");
			return false;			
		}else{			
			if(comparetimesec(hh39,mm39,ss39,hh40,mm40,ss40)){
				ModalWarning_TextName(alertMT20, "");
				return false;
			}
		}
	
	}
	// time21
	var time21,hh41,mm41,ss41,hh42,mm42,ss42="";
	hh41=document.form1.hh41.value;
	mm41=document.form1.mm41.value;
	ss41=document.form1.ss41.value;
	hh42=document.form1.hh42.value;
	mm42=document.form1.mm42.value;
	ss42=document.form1.ss42.value;
	time21 = hh41+mm41+ss41+hh42+mm42+ss42;
	if(time21!=''){
		if(chkEmptyTimeSec(hh41,mm41,ss41,hh42,mm42,ss42)){
			ModalWarning_TextName(alertT21, "");
			return false;			
		}else{			
			if(comparetimesec(hh41,mm41,ss41,hh42,mm42,ss42)){
				ModalWarning_TextName(alertMT21, "");
				return false;
			}
		}
	
	}
	// time22
	var time22,hh43,mm43,ss43,hh44,mm44,ss44="";
	hh43=document.form1.hh43.value;
	mm43=document.form1.mm43.value;
	ss43=document.form1.ss43.value;
	hh44=document.form1.hh44.value;
	mm44=document.form1.mm44.value;
	ss44=document.form1.ss44.value;
	time22 = hh43+mm43+ss43+hh44+mm44+ss44;
	if(time22!=''){
		if(chkEmptyTimeSec(hh43,mm43,ss43,hh44,mm44,ss44)){
			ModalWarning_TextName(alertT22, "");
			return false;			
		}else{			
			if(comparetimesec(hh43,mm43,ss43,hh44,mm44,ss44)){
				ModalWarning_TextName(alertMT22, "");
				return false;
			}
		}
	
	}
	// time23
	var time23,hh45,mm45,ss45,hh46,mm46,ss46="";
	hh45=document.form1.hh45.value;
	mm45=document.form1.mm45.value;
	ss45=document.form1.ss45.value;
	hh46=document.form1.hh46.value;
	mm46=document.form1.mm46.value;
	ss46=document.form1.ss46.value;
	time23 = hh45+mm45+ss45+hh46+mm46+ss46;
	if(time23!=''){
		if(chkEmptyTimeSec(hh45,mm45,ss45,hh46,mm46,ss46)){
			ModalWarning_TextName(alertT23, "");
			return false;			
		}else{			
			if(comparetimesec(hh45,mm45,ss45,hh46,mm46,ss46)){
				ModalWarning_TextName(alertMT23, "");
				return false;
			}
		}
	
	}
	// time24
	var time24,hh47,mm47,ss47,hh48,mm48,ss48="";
	hh47=document.form1.hh47.value;
	mm47=document.form1.mm47.value;
	ss47=document.form1.ss47.value;
	hh48=document.form1.hh48.value;
	mm48=document.form1.mm48.value;
	ss48=document.form1.ss48.value;
	time24 = hh47+mm47+ss47+hh48+mm48+ss48;
	if(time24!=''){
		if(chkEmptyTimeSec(hh47,mm47,ss47,hh48,mm48,ss48)){
			ModalWarning_TextName(alertT24, "");
			return false;			
		}else{			
			if(comparetimesec(hh47,mm47,ss47,hh48,mm48,ss48)){
				ModalWarning_TextName(alertMT24, "");
				return false;
			}
		}
	
	}
	// time25
	var time25,hh49,mm49,ss49,hh50,mm50,ss50="";
	hh49=document.form1.hh49.value;
	mm49=document.form1.mm49.value;
	ss49=document.form1.ss49.value;
	hh50=document.form1.hh50.value;
	mm50=document.form1.mm50.value;
	ss50=document.form1.ss50.value;
	time25 = hh49+mm49+ss49+hh50+mm50+ss50;
	if(time25!=''){
		if(chkEmptyTimeSec(hh49,mm49,ss49,hh50,mm50,ss50)){
			ModalWarning_TextName(alertT25, "");
			return false;			
		}else{			
			if(comparetimesec(hh49,mm49,ss49,hh50,mm50,ss50)){
				ModalWarning_TextName(alertMT25, "");
				return false;
			}
		}
	
	}
	// time26
	var time26,hh51,mm51,ss51,hh52,mm52,ss52="";
	hh51=document.form1.hh51.value;
	mm51=document.form1.mm51.value;
	ss51=document.form1.ss51.value;
	hh52=document.form1.hh52.value;
	mm52=document.form1.mm52.value;
	ss52=document.form1.ss52.value;
	time26 = hh51+mm51+ss51+hh52+mm52+ss52;
	if(time26!=''){
		if(chkEmptyTimeSec(hh51,mm51,ss51,hh52,mm52,ss52)){
			ModalWarning_TextName(alertT26, "");
			return false;			
		}else{			
			if(comparetimesec(hh51,mm51,ss51,hh52,mm52,ss52)){
				ModalWarning_TextName(alertMT26, "");
				return false;
			}
		}
	
	}
	// time27
	var time27,hh53,mm53,ss53,hh54,mm54,ss54="";
	hh53=document.form1.hh53.value;
	mm53=document.form1.mm53.value;
	ss53=document.form1.ss53.value;
	hh54=document.form1.hh54.value;
	mm54=document.form1.mm54.value;
	ss54=document.form1.ss54.value;
	time27 = hh53+mm53+ss53+hh54+mm54+ss54;
	if(time27!=''){
		if(chkEmptyTimeSec(hh53,mm53,ss53,hh54,mm54,ss54)){
			ModalWarning_TextName(alertT27, "");
			return false;			
		}else{			
			if(comparetimesec(hh53,mm53,ss53,hh54,mm54,ss54)){
				ModalWarning_TextName(alertMT27, "");
				return false;
			}
		}
	
	}
	// time28
	var time28,hh55,mm55,ss55,hh56,mm56,ss56="";
	hh55=document.form1.hh55.value;
	mm55=document.form1.mm55.value;
	ss55=document.form1.ss55.value;
	hh56=document.form1.hh56.value;
	mm56=document.form1.mm56.value;
	ss56=document.form1.ss56.value;
	time28 = hh55+mm55+ss55+hh56+mm56+ss56;
	if(time28!=''){
		if(chkEmptyTimeSec(hh55,mm55,ss55,hh56,mm56,ss56)){
			ModalWarning_TextName(alertT28, "");
			return false;			
		}else{			
			if(comparetimesec(hh55,mm55,ss55,hh56,mm56,ss56)){
				ModalWarning_TextName(alertMT28, "");
				return false;
			}
		}
	
	}
	// time29	
	var time29,hh57,mm57,ss57,hh58,mm58,ss58="";
	hh57=document.form1.hh57.value;
	mm57=document.form1.mm57.value;
	ss57=document.form1.ss57.value;
	hh58=document.form1.hh58.value;
	mm58=document.form1.mm58.value;
	ss58=document.form1.ss58.value;
	time29 = hh57+mm57+ss57+hh58+mm58+ss58;
	if(time29!=''){
		if(chkEmptyTimeSec(hh57,mm57,ss57,hh58,mm58,ss58)){
			ModalWarning_TextName(alertT29, "");
			return false;			
		}else{			
			if(comparetimesec(hh57,mm57,ss57,hh58,mm58,ss58)){
				ModalWarning_TextName(alertMT29, "");
				return false;
			}
		}
	
	}
	// time30	
	var time30,hh59,mm59,ss59,hh60,mm60,ss60="";
	hh59=document.form1.hh59.value;
	mm59=document.form1.mm59.value;
	ss59=document.form1.ss59.value;
	hh60=document.form1.hh60.value;
	mm60=document.form1.mm60.value;
	ss60=document.form1.ss60.value;
	time30 = hh59+mm59+ss59+hh60+mm60+ss60;
	if(time30!=''){
		if(chkEmptyTimeSec(hh59,mm59,ss59,hh60,mm60,ss60)){
			ModalWarning_TextName(alertT30, "");	
			return false;			
		}else{			
			if(comparetimesec(hh59,mm59,ss59,hh60,mm60,ss60)){
				ModalWarning_TextName(alertMT30, "");
				return false;
			}
		}
	
	}
	
	Confirm_edit(sText, url);
}

//	holiday, timezone, zonegroup	================
function Confirm_edit(sText, url){
	ModalConfirm(sText, url);	
}

function onSubmit_Ok(url){
	document.form1.action = url;
	document.form1.submit();
}

// pad value to next text auto
function autofocus(field, limit, next, evt) {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.keyCode) ? evt.keyCode : 
        ((evt.which) ? evt.which : 0));
    if (charCode > 31 && field.value.length == limit) {
        field.form.elements[next].focus();
    }
}

// เกี่ยวกับปุ่ม ค้นหา เพิ่ม ตกลง และ ดูทั้งหมด //
function onSubmit_Search(url,view,view1,item){ 
	document.form_search.action = url+"&view="+view+"&view1="+view1+"&select_item="+item;
	document.form_search.submit();	
}
function onSubmit_Add(url){
   document.form_add.action= url;	
   document.form_add.submit();
}
function onSubmit_View(url){
   document.form_view.action= url;	
   document.form_view.submit();
}
/* 
function changeImage(url,dataval,objID) { //รูปที่ควบคุม การเรียงจากน้อยไปมาก มากไปน้อย		
	var newsrc = "";
	var asc_desc = "";
	var hvalue = document.images[objID].value;
	if (newsrc == "images/column-desc.png" || document.form1.view1.value == '2') {
		asc_desc = '1';	//asc			
		document.images[objID].src = "images/column-asc.png";
		newsrc  = "images/column-desc.png";					
	}else{
		asc_desc = '2';	//desc		
		document.images[objID].src = "images/column-desc.png";
		newsrc  = "images/column-asc.png";		
	}  
	
	if(dataval=='1'){
		location.href = ''+url+'?view='+hvalue+'&view1='+asc_desc+'&keyword='+document.form1.hid_key.value+'&select_item='+document.form_item.SelItem.value;	
	}else if(dataval=='2'){//door
		location.href = ''+url+'?view='+hvalue+'&view1='+asc_desc+'&keyword='+document.form1.hid_key.value+'&locate_code='+document.form1.hid_locate.value+'&select_item='+document.form_item.SelItem.value;
	}else if(dataval=='3'){//zonegroup
		location.href = ''+url+'&view='+hvalue+'&view1='+asc_desc+'&keyword='+document.form1.hid_key.value+'&select_item='+document.form_item.SelItem.value;
	}
}
 */
 
function changeImage(url,view){ //รูปที่ควบคุม การเรียงจากน้อยไปมาก มากไปน้อย	
	//document.images[view].value //ค่าของ ค่าของรูปภาพให้เท่ากับview คือค่าของคอลัมน์ที่จะจัดเรียง 
	//var view = document.form1.view.value;
	if(document.form1.view1.value == '2'){
		asc_desc = '1';	//asc					
	}else{
		asc_desc = '2';	//desc				
	}	
	location.href = url+'view='+document.images[view].value+'&view1='+asc_desc+'&keyword='+document.form1.hid_key.value+'&select_item='+document.form_item.SelItem.value;	
}		
function changeImageDoor(url,view){ //รูปที่ควบคุม การเรียงจากน้อยไปมาก มากไปน้อย	
	//document.images[view].value //ค่าของ ค่าของรูปภาพให้เท่ากับview คือค่าของคอลัมน์ที่จะจัดเรียง 
	//var view = document.form1.view.value;
	if(document.form1.view1.value == '2'){
		asc_desc = '1';	//asc					
	}else{
		asc_desc = '2';	//desc				
	}	
	location.href = url+'view='+document.images[view].value+'&view1='+asc_desc+'&locate_code='+document.form1.hid_locate.value+'&keyword='+document.form1.hid_key.value+'&select_item='+document.form_item.SelItem.value;	
}	