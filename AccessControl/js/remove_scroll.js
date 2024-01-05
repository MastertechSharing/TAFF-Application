var detect = navigator.userAgent.toLowerCase();
var browser,thestring;

if (checkIt('msie')){
	browser = "Internet Explorer";
}else if (!checkIt('compatible')){
	browser = "Netscape Navigator";
}else{
	browser = "An unknown browser";
}

function checkIt(string){
	place = detect.indexOf(string) + 1;
	thestring = string;
	return place;
}

function noScrollIE(){
	document.body.scroll="no";
}

function scrollIE(){
	document.body.scroll="yes";
}

function noScrollNS(){
	document.width= window.innerWidth;
	document.height=window.innerHeight;
}

function scrollNS(){
	document.width=1000;
	document.height=1000;
}

function removeScrollBars(){
	if (browser = "Internet Explorer"){
		noScrollIE();
	}else if (browser = "Netscape Navigator"){
		noScrollNS();
	}
}