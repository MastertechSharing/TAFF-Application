
function ModalWarning_ObjectName(text_warning, object){
	var date = new Date().getTime();
	document.getElementById("text_warning").innerHTML = text_warning;
	document.getElementById("object_warning").value = object.name;
	document.getElementById("datetime_warning").value = date;
	$('#myModalWarning').modal('show');
	
	setTimeout(function(){ 
		if ((!$('#myModalWarning').is(':hidden')) && date == document.getElementById("datetime_warning").value) {
			$('#myModalWarning').modal('hide'); 
			document.getElementById($('#object_warning').val()).focus();
		}
	}, 10000); // 10 sec
}

function ModalWarning_TextName(text_warning, text_name){
	var date = new Date().getTime();
	document.getElementById("text_warning").innerHTML = text_warning;
	document.getElementById("object_warning").value = text_name;
	document.getElementById("datetime_warning").value = date;
	$('#myModalWarning').modal('show');
	
	setTimeout(function(){ 
		if ((!$('#myModalWarning').is(':hidden')) && date == document.getElementById("datetime_warning").value) {
			$('#myModalWarning').modal('hide');
			if(text_name != ''){
				document.getElementById($('#object_warning').val()).focus();
			}
		}
	}, 10000); // 10 sec
}

function ModalWarning_TextName_Parent(text_warning, text_name){
	var date = new Date().getTime();
	parent.window.document.getElementById("text_warning").innerHTML = text_warning;
	parent.window.document.getElementById("object_warning").value = text_name;
	parent.window.document.getElementById("datetime_warning").value = date;
	parent.window.top.$('#myModalWarning').modal('show');
	
	setTimeout(function(){ 
		if ((!$('#myModalWarning').is(':hidden')) && date == parent.window.document.getElementById("datetime_warning").value) {
			parent.window.top.$('#myModalWarning').modal('hide');
			if(text_name != ''){
				parent.window.document.getElementById($('#object_warning').val()).focus();
			}
		}
	}, 10000); // 10 sec
}

function ModalDanger_NoTimeout(text_danger){
	document.getElementById("text_danger").innerHTML = text_danger;
	$('#myModalDanger').modal('show');
}

var return_link = "";
function ModalDanger_NoTimeout_Link(text_danger, relink){
	return_link = relink;
	document.getElementById("text_danger_link").innerHTML = text_danger;
	$('#myModalDangerLink').modal('show');
}

function historyBack(){
	document.location = return_link;
}

function ModalDanger_10Second(text_danger){
	document.getElementById("text_danger").innerHTML = text_danger;
	$('#myModalDanger').modal('show');
	
	setTimeout(function(){ 
		if ((!$('#myModalDanger').is(':hidden'))) {		//	 && ( date == document.getElementById("sTime").value )
			$('#myModalDanger').modal('hide');
			history.back();
		}
	}, 10000);	//	Hold 10 seconds
}

function ModalDanger_10Second_NoReturn(text_danger){
	document.getElementById("text_danger_noreturn").innerHTML = text_danger;
	$('#myModalDangerNoReturn').modal('show');
	
	setTimeout(function(){ 
		if ((!$('#myModalDangerNoReturn').is(':hidden'))) {		//	 && ( date == document.getElementById("sTime").value )
			$('#myModalDangerNoReturn').modal('hide');
		}
	}, 10000);	//	Hold 10 seconds
}

function ModalSuccess_NoParam(text_result){
	document.getElementById("text_result_noparam").innerHTML = text_result;
	$('#myModalResultNoParam').modal('show');
	
	setTimeout(function(){ 
		if ((!$('#myModalResultNoParam').is(':hidden'))) {
			$('#myModalResultNoParam').modal('hide');
		}
	}, 3000);	//	Hold 3 seconds
}