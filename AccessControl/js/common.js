function MakeArrayday(size) {
	this.length = size;
	for(var i = 1; i <= size; i++) {
		this[i] = "";
	}
	return this;
}

function MakeArraymonth(size) {
	this.length = size;
	for(var i = 1; i <= size; i++) {
		this[i] = "";
	}
	return this;
}

function funClock() {
	if (!document.layers && !document.all) return;
	var runTime = new Date();
	var hours = runTime.getHours();
	var minutes = runTime.getMinutes();
	var seconds = runTime.getSeconds();
	var dn = "AM";
	if (hours >= 12) {
		dn = "PM";
		hours = hours - 12;
	}
	if (hours == 0) {
		hours = 12;
	}
	if (minutes <= 9) {
		minutes = "0" + minutes;
	}
	if (seconds <= 9) {
		seconds = "0" + seconds;
	}
	movingtime = "<b>"+ hours + ":" + minutes + ":" + seconds + " " + dn + "</b>";
	if (document.layers) {
		document.layers.clock.document.write(movingtime);
		document.layers.clock.document.close();
	}else if (document.all) {
		clock.innerHTML = movingtime;
	}
	setTimeout("funClock()", 1000);
}//window.onload = funClock;

function hideLeftCol(id){
	if(this.document.getElementById( id).style.display=='none'){
		this.document.getElementById( id).style.display='inline';
		Set_Cookie('showLeftCol','true',30,'/','','');
		var show = Get_Cookie('showLeftCol');
		document['HideHandle'].src = 'images/hide.gif';		
	}else{
		this.document.getElementById(  id).style.display='none';
		Set_Cookie('showLeftCol','false',30,'/','','');
		var show = Get_Cookie('showLeftCol');
		document['HideHandle'].src = 'images/show.gif';	
	}
}

function showSubMenu(id){
	if(this.document.getElementById( id).style.display=='none'){
		tbButtonMouseOver('HideHandle',122,'',10);
	}
}

function showhide(layerID, mode){   
	var currentRef = document.getElementById(layerID).style      
	modes = new Array
	modes[0] = 'none'   
	modes[1] = 'block'      
	if(isNaN(mode))     
		currentRef.display = (currentRef.display == 'none') ? 'block' : 'none'   
	else      
		currentRef.display = modes[mode] 
} 