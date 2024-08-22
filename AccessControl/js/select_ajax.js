var req;
function Inint_AJAX() {
	try { return new ActiveXObject("Msxml2.XMLHTTP");  } catch(e) {} //IE
	try { return new ActiveXObject("Microsoft.XMLHTTP"); } catch(e) {} //IE
	try { return new XMLHttpRequest(); } catch(e) {} //Native Javascript
	alert("XMLHttpRequest not supported");
	return null;
}
function get_datatransaction(id,lang) {
	var random = Math.random();
	req = Inint_AJAX();
	req.onreadystatechange = getdata;
	//req.open('GET','Select.html?id='+id, true);
	req.open('GET','Select.html?id='+id+'&lang='+lang, true);
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=TIS-620");
	req.send(null);
}

function getdata() {
	 if (req.readyState == 4) {		
		if (req.status==200) {
			//var data=req.responseText;
			var message = req.responseXML.getElementsByTagName("data")[0];
			//document.getElementById("load").innerHTML='<img src="images/animated_loading.gif"/>';
			if (message!=null ) {
			    var name = message.childNodes[0].firstChild.nodeValue;
			    var depart = message.childNodes[1].firstChild.nodeValue;
				var i = depart.indexOf('~');
				if(i > 0){					
					depart = depart.replace("~","&")
				}	
			   document.getElementById("name").value = name;
			   document.getElementById("depart").value = depart;
			}else{} 			
		}
		//setTimeout("gen_datatransaction()", 3000); 
	}
}

function add_value_selectID(p_id, mode, post_file) {
	var req = Inint_AJAX();	
	req.onreadystatechange = function () {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var ret = req.responseText;
				if(ret != null){									
					if(mode == 1){
					    parent.window.document.getElementById("id1").value = p_id;	
					} else{
						parent.window.document.getElementById("id2").value = p_id;
					}					
					parent.window.top.$("#myModalViewDetail").modal('hide');
				}				
			}
		}  
	};
	
	req.open("POST", post_file);
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620");
	req.send("p_id="+p_id+"&mode="+mode);
}

function add_value_selectIDDesc(p_id, p_name, post_file) {
	var req = Inint_AJAX();	
	req.onreadystatechange = function () {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var ret = req.responseText;
				if(ret != null){
					parent.window.document.getElementById("code").value = p_id;
					parent.window.document.getElementById("desc").value = p_name;				
					parent.window.top.$("#myModalViewDetail").modal('hide');
				}
			}
		}  
	};
	
	req.open("POST", post_file);
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620");
	req.send("p_id="+p_id+"&p_name="+p_name);
}

function add_value_selectEmp(p_id, post_file) {
	var req = Inint_AJAX();	
	req.onreadystatechange = function () {
		if (req.readyState==4) {
			if (req.status==200) {
				var ret = req.responseText;
				if(ret != null){									
					parent.window.document.getElementById("emp_id").value = p_id;						
					parent.window.top.$("#myModalViewDetail").modal('hide');
				}				
			}
		}  
	};
	
	req.open("POST", post_file);
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620");
	req.send("p_id="+p_id+"&mode="+mode);
}

function add_value_selectEmpID(p_id, p_name, post_file) {
	var req = Inint_AJAX();	
	req.onreadystatechange = function () {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var ret = req.responseText;
				if(ret != null){
					parent.window.document.getElementById("emp_id").value = p_id;
					parent.window.document.getElementById("emp_name").value = p_name;				
					parent.window.top.$("#myModalViewDetail").modal('hide');
				}
			}
		}  
	};
	
	req.open("POST", post_file);
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620");
	req.send("p_id="+p_id+"&p_name="+p_name);
}

function add_value_event(p_id,  p_depart, post_file) {
	var req = Inint_AJAX();		
	req.onreadystatechange = function () {
		if (req.readyState == 4) {
			if (req.status == 200) {
				var ret = req.responseText;
				if(ret != null){											
					parent.window.document.getElementById("evid").value = p_id;	
					parent.window.document.getElementById("nameev").value = p_depart;											
					parent.window.top.$("#myModalViewDetail").modal('hide');
				}
			}
		}  
	};
	
	req.open("POST", post_file);
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620");
	req.send("p_id="+p_id+"&p_depart="+p_depart);
}

function add_value_door(door_id, desc, locate_desc) {
	var req = Inint_AJAX();	
	req.onreadystatechange = function () {
		if (req.readyState==4) {
			if (req.status==200) {
				var ret = req.responseText;
				if(ret != null){
					parent.window.document.getElementById("doorid").value = door_id;
					parent.window.document.getElementById("desc").value = desc;	
					parent.window.document.getElementById("locate_desc").value = locate_desc;			
					parent.window.sconname.style.display = 'none';
				}			
			}
		}  
	};		
		
	req.open("POST", "report_infor_door.jsp"); 
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620"); 
	req.send("door_id="+door_id+"&desc="+desc+"&locate_desc="+locate_desc);
}

function add_value_reader(reader_no, desc, reader_type) {
	var req = Inint_AJAX();	
	req.onreadystatechange = function () {
		if (req.readyState==4) {
			if (req.status==200) {
				var ret = req.responseText;
				if(ret != null){
					parent.window.document.getElementById("reader_no").value = reader_no;
					parent.window.document.getElementById("desc").value = desc;	
					parent.window.document.getElementById("reader_type").value = reader_type;			
					parent.window.sconname.style.display = 'none';
				}				
			}
		}  
	};		
		
	req.open("POST", "report_reader.jsp");
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=tis-620");
	req.send("reader_no="+reader_no+"&desc="+desc+"&reader_type="+reader_type);
}

function showclock(obj){
	var thistime = new Date();
	var myhour = thistime.getHours();
	var myminute = thistime.getMinutes();	
	if (myhour < 10){myhour = "0" + myhour }
	if (myminute < 10){myminute = "0" + myminute}	
	obj.value = myhour + ":" + myminute;// + ":" + mysecond; 
	obj.value = myhour + ":" + myminute;	
}

function get_writedatatransaction(id,lang) {
	var random = Math.random();
	req = Inint_AJAX();
	req.onreadystatechange = getwritedata;
//	req.open('GET','Select.html?id='+id, true);
	req.open('GET','Select.html?id='+id+'&lang='+lang, true);
	req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=TIS-620");
	req.send(null);
}

function getwritedata() {
	 if (req.readyState == 4) {		
		if (req.status==200) {
			//var data=req.responseText;
			var message = req.responseXML.getElementsByTagName("data")[0];
			//document.getElementById("load").innerHTML='<img src="images/animated_loading.gif"/>';
			if (message!=null ) {
			    var name = message.childNodes[0].firstChild.nodeValue;
			    var depart = message.childNodes[1].firstChild.nodeValue;
			    var enname = message.childNodes[2].firstChild.nodeValue;
				var i = depart.indexOf('~');
				if(i > 0){					
					depart = depart.replace("~","&")
				}	
			   document.getElementById("name").value = name;
			   document.getElementById("depart").value = depart;
			   document.getElementById("enname").value = enname;
			}else{} 			
		}
		//setTimeout("gen_datatransaction()", 3000); 
	}
}