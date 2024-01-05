var xmlHttp;

function createXMLHttpRequest() {
	if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    } else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}

function refreshList() {
	rant=new Date();
   	var number = document.form1.group_code.value;
    var url = "combo.jsp?number=" + number + "& rant=" + rant;
    createXMLHttpRequest();
    xmlHttp.onreadystatechange = handleStateChange;
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
}
    
function handleStateChange() {
    if(xmlHttp.readyState == 4) {
        if(xmlHttp.status == 200) {
            updateList();
        }
    }
}

function updateList() {
	clearList();
    var results = xmlHttp.responseText;
	var option = null;
    p=results.split(",");
    for (var i = 0; i < (p.length-1); i++){
	c=p[i].split("-");
		if(p[i]!=""){
			document.form1.taff_id.options[i] = new Option(c[1],c[0]);
		}
    }
}

function clearList() {
	var taff = document.form1.taff_id;
    while(taff.childNodes.length > 0) {
		taff.removeChild(taff.childNodes[0]);
    }
}

function enabled_combo(id) {
	if (id=="0") {
	    document.form1.taff_id.disabled = true;
	} else {
		document.form1.taff_id.disabled = false;
	}
}