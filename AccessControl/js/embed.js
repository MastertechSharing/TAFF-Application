function showClock(obj){
	var str = '<embed src="http://www.clocklink.com/clocks/'
		+ obj.clockfile;
	str += "?";
		
	for( prop in obj ) {
		if( 'clockfile' == prop 
			|| 'width' == prop
			|| 'height' == prop
			|| 'wmode' == prop
			|| 'type' == prop
		) continue;
		str += ( prop + "=" + _escape(obj[prop]) + "&" );
	}
	str += '" ';
	str += ' width="' + obj.width + '"';
	str += ' height="' + obj.height + '"';
	str += ' wmode="' + obj.wmode + '"';
	str += ' type="application/x-shockwave-flash">';
	
	document.write( str );
}

function _escape(str){
	str = str.replace(/ /g, '+');
	str = str.replace(/%/g, '%25');
	str = str.replace(/\?/, '%3F');
	str = str.replace(/&/, '%26');
	return str;
}

function showBanner(BannerLink){
	document.write(BannerLink);
}