<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%	
	String action = request.getParameter("action");
	String idcard = request.getParameter("idcard");
	String username = (String) session.getAttribute("ses_username");
	
	if(action.equals("add")){
		session.setAttribute("action_capture", "add");
		session.setAttribute("idcard_capture", "");
		new File(getServletContext().getRealPath("/") + "photos\\tmpCapture\\CaptureBy-"+username+".jpg").delete();
	}else if(action.equals("edit")){
		session.setAttribute("action_capture", "edit");
		session.setAttribute("idcard_capture", idcard);
	}
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/jquery.webcam.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script type="text/javascript">
			var pos = 0;
			var ctx = null;
			var cam = null;
			var image = null;

			var filter_on = false;
			var filter_id = 0;
			
			jQuery("#webcam").webcam({

				width: 320,
				height: 240,
				mode: "callback",
				swffile: "flash/jscam_canvas_only.swf",

				onTick: function(remain) {
				/* 	if (0 == remain) {
						jQuery("#status").text("Cheese!");
					} else {
						jQuery("#status").text(remain + " seconds remaining...");
					}	 
				*/
				},

				onSave: function(data) {

					var col = data.split(";");
					var img = image;

					for(var i = 0; i < 320; i++) {
						var tmp = parseInt(col[i]);
						img.data[pos + 0] = (tmp >> 16) & 0xff;
						img.data[pos + 1] = (tmp >> 8) & 0xff;
						img.data[pos + 2] = tmp & 0xff;
						img.data[pos + 3] = 0xff;
						pos+= 4;
					}
					
					if (pos >= 0x4B000) {
						ctx.putImageData(img, 0, 0);
				//		$.post("camera_savefile.jsp?action=<%= action %>&idcard=<%= idcard %>", {type: "data", image: canvas.toDataURL("image/png")});
						pos = 0;
					}
					
				},

				onCapture: function () {
					webcam.save();
				/* 	jQuery("#flash").css("display", "block");
					jQuery("#flash").fadeOut(100, function () {
						jQuery("#flash").css("opacity", 1);
					});	
				*/
					
					var imageData = canvas.toDataURL('image/jpeg');
					var params = imageData;

					//Initiate the request
					var httpRequest = new XMLHttpRequest();            
					httpRequest.open('POST', 'camera_savefile.jsp?action=<%= action %>&idcard=<%= idcard %>', true);

					//Send proper headers
					httpRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
					httpRequest.setRequestHeader("Content-length", params.length);
					httpRequest.setRequestHeader("Connection", "close");

					//Send your data
					httpRequest.send(params);
					
					ImgLoad();
					
				<%	if(action.equals("edit")){	%>
					
					$("#btn_save").prop('disabled', false);
					$("#btn_del").prop('disabled', true);
					
				/* 	//	Update Status Photo
					setTimeout(function(){
						iframe_update_status.location = 'module/update_camera_finger.jsp?action=jpg_add&idcard=<%= idcard %>';
					}, 500);
				 */	
				<%	}	%>
				
				},

				debug: function (type, string) {
				/* 	jQuery("#status").html(type + ": " + string);	 */
				},

				onLoad: function () {
					var cams = webcam.getCameraList();
					for(var i in cams) {
						jQuery("#cams").append("<li>" + cams[i] + "</li>");
					}
				}
			});

			function getPageSize() {

				var xScroll, yScroll;

				if (window.innerHeight && window.scrollMaxY) {
					xScroll = window.innerWidth + window.scrollMaxX;
					yScroll = window.innerHeight + window.scrollMaxY;
				} else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
					xScroll = document.body.scrollWidth;
					yScroll = document.body.scrollHeight;
				} else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
					xScroll = document.body.offsetWidth;
					yScroll = document.body.offsetHeight;
				}

				var windowWidth, windowHeight;

				if (self.innerHeight) { // all except Explorer
					if(document.documentElement.clientWidth){
						windowWidth = document.documentElement.clientWidth;
					} else {
						windowWidth = self.innerWidth;
					}
					windowHeight = self.innerHeight;
				} else if (document.documentElement && document.documentElement.clientHeight) { // Explorer 6 Strict Mode
					windowWidth = document.documentElement.clientWidth;
					windowHeight = document.documentElement.clientHeight;
				} else if (document.body) { // other Explorers
					windowWidth = document.body.clientWidth;
					windowHeight = document.body.clientHeight;
				}

				// for small pages with total height less then height of the viewport
				if(yScroll < windowHeight){
					pageHeight = windowHeight;
				} else {
					pageHeight = yScroll;
				}

				// for small pages with total width less then width of the viewport
				if(xScroll < windowWidth){
					pageWidth = xScroll;
				} else {
					pageWidth = windowWidth;
				}

				return [pageWidth, pageHeight];
			}

			window.addEventListener("load", function() {
				
				var canvas = document.getElementById("canvas");
				if (canvas.getContext) {
					ctx = document.getElementById("canvas").getContext("2d");
					ctx.clearRect(0, 0, 320, 240);
					
					var img = new Image();
					img.src = "photos/<%= idcard %>.jpg";
					img.onload = resizeCanvas;
					img.onerror = function(){ 
						img.src = "photos/<%= idcard %>.JPG"; 
						img.onload = resizeCanvas;
						img.onerror = function(){ 
							img.src = "photos/person.png";
							img.onload = noPhoto;
						}
					}
					
					// below here to resize canvas
					function resizeCanvas(){
						canvas.width = 320;
						canvas.height = 240;
						ctx.drawImage(img, 0, 0, 320, 240);
					}
					function noPhoto(){
						ctx.drawImage(img, 129, 89);
					}
					
					image = ctx.getImageData(0, 0, 320, 240);
					
				}
				
				var pageSize = getPageSize();

			}, false);

			window.addEventListener("resize", function() {

				var pageSize = getPageSize();
			//	jQuery("#flash").css({ height: pageSize[1] + "px" });

			}, false);

			function ImgLoad(){ 
				setTimeout(function(){
					var myobj = window.top.document.getElementById("img_emp");	
					if(myobj != null){
						var oImg = new Image();
					<%	if(action.equals("add")){	%>
						oImg.src = "photos/tmpCapture/CaptureBy-<%= username %>.jpg";
					<%	}else if(action.equals("edit")){	%>
						oImg.src = "photos/<%= idcard %>.jpg";
					<%	}	%>
						oImg.onload = function(){ myobj.src = oImg.src; }
						oImg.onerror = function(){ 
							oImg.src = "photos/person.png";
						}
					}
				}, 1200);
			}
		</script>
		
	</head>
 
	<body style="width: 95%; margin-top: -40px; margin-bottom: -80px;" align="center" onLoad="ImgLoad(); disabledButton();">
		
		<div class="row" style="margin-bottom: -80px;" align="center">
			<div class="row" style="margin-left: 10px; margin-right: 10px;"> 
				<div class="col-xs-6" style="border: 0px !important; margin-top: -10px; margin-bottom: -10px; margin-left: 30px; width: 360px;">
					<div class="bs-callout bs-callout-info"> 
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-camera"> </i> &nbsp; <b> Camera </b> </label>
						</div>
						<div class="row form-group" style=" margin-top: -8px; margin-bottom: -8px;">
							<div id="webcam" style="width: 320px; height: 240px;">
								<object id="XwebcamXobjectX" type="application/x-shockwave-flash" data="flash/jscam_canvas_only.swf" width="320" height="240">
									<param name="movie" value="flash/jscam_canvas_only.swf">
									<param name="FlashVars" value="mode=callback&amp;quality=100">
									<param name="allowScriptAccess" value="always">
								</object>
							</div>
						</div>
						<div class="row form-group" style=" margin-top: 15px; margin-bottom: 5px; height: 24px;">
							<div id="cams"> </div>
						</div>
						<div class="row form-group" style=" margin-top: 5px; margin-bottom: 5px;">
							<div class="btn-group dropup">
								<button type="button" onClick="webcam.capture();" class="btn btn-primary btn-md dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									&nbsp; &nbsp; &nbsp; <i class="glyphicon glyphicon-camera"> </i> &nbsp; <%= lb_take_photo %> &nbsp; &nbsp; &nbsp;  
								</button> 
							</div>
						</div>
					</div>
				</div>
				<div class="col-xs-6" style="border: 0px !important; margin-top: -10px; margin-bottom: -10px; margin-left: 30px; width: 360px;">
					<div class="bs-callout bs-callout-info"> 
						<div class="row alert-message-info" style="height: 32px; margin-left: -10px; margin-top: -10px; margin-right: -10px; margin-bottom: 10px;">
							<label class="control-label" style="margin-left: 5%; margin-top: 5px;"> <i class="glyphicon glyphicon-picture"> </i> &nbsp; <b> Photo Review </b> </label>
						</div>
						<div class="row form-group" style=" margin-top: -8px; margin-bottom: -12px;">
							<canvas id="canvas" width="320" height="240"></canvas>
						</div>
						<div class="row form-group" style=" margin-top: 15px; margin-bottom: 5px; height: 24px;">
							<div id="statusSave" style="display: none;"> <font style="color: green;"> <strong> Save success. </strong> </font> </div>
							<div id="statusDel" style="display: none;"> <font style="color: red;"> <strong> Delete success. </strong> </font> </div>
						</div>
						<div class="row form-group" style=" margin-top: 5px; margin-bottom: 5px;">
							<div class="btn-group">
							<%	if(action.equals("add")){	%>
								<button type="button" id="btn_del" onClick="deleteFilePageAdd();" class="btn btn-danger btn-md dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									&nbsp; &nbsp; &nbsp; <i class="glyphicon glyphicon-trash"> </i> &nbsp; <%= lb_delete_photo %> &nbsp; &nbsp; &nbsp;
								</button> 
							<%	}else if(action.equals("edit")){	%>
								<div class="btn-group dropup">
									<button type="button" id="btn_save" onClick="modalSaveFile();" class="btn btn-primary btn-md dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										&nbsp; &nbsp; &nbsp; <i class="glyphicon glyphicon-floppy-save"> </i> &nbsp; <%= lb_save_photo %> &nbsp; &nbsp; &nbsp;
									</button> 
								</div>
								<button type="button" id="btn_del" onClick="modalDeleteFile();" class="btn btn-danger btn-md dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									&nbsp; &nbsp; &nbsp; <i class="glyphicon glyphicon-trash"> </i> &nbsp; <%= lb_delete_photo %> &nbsp; &nbsp; &nbsp;
								</button> 
							<%	}	%>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div align="left" style="margin-left: 20px; margin-top: 5px; margin-bottom: -30px;"> 
				<strong> &nbsp; &nbsp; &nbsp; &nbsp; <i class="glyphicon glyphicon-info-sign" style="color: #337AB7;"> </i>&nbsp;&nbsp;How to allow and remember camera </strong> <br/>
				&nbsp; &nbsp; &nbsp; &nbsp; Right click on camera and select "<strong>Settings...</strong>", 
				Tab Privacy check "<strong><!--<input type="radio" checked onclick="return false;">--><i class="glyphicon glyphicon-ok-sign" style="color: #008000;"></i>Allow</strong>" and "<strong><!--<input type="checkbox" checked onclick="return false;">-->Remember</strong>", 
				Click "<strong>Close</strong>" button.
			</div>
			
			<iframe src="" id="iframe_copy_file" name="iframe_copy_file" frameborder="0" width="0px" height="0px" style="margin-bottom: 20px;"></iframe>
			<iframe src="" id="iframe_delete_file" name="iframe_delete_file" frameborder="0" height="0px" width="0px" style="margin-bottom: 20px;"></iframe>
			<iframe src="" id="iframe_update_status" name="iframe_update_status" frameborder="0" width="0px" height="0px" style="margin-bottom: 20px;"></iframe>
			
			<div class="modal fade" id="myModalConfirmSave" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="false" data-keyboard="false">
				<div class="modal-dialog" role="document">
					<div class="modal-content alert-message alert-message-success">
						<div class="modal-body" align="center">
							<div class="table-responsive" style="border: 0px !important;" border="0"> 
								<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_save" class="glyphicon glyphicon-floppy-save alert-message-success" style="font-size: 50px;"> </span> </div>
								<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <%= msg_confirmsave_photo %> </h4> </div>
								<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
									<div class="col-xs-1 col-md-1"> </div>
									<div class="col-xs-5 col-md-5">
										<button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" id="btn_save" onClick="saveFile('<%= action %>');" style="width: 100%;"> <%= btn_ok %> </button>
									</div>
									<div class="col-xs-5 col-md-5">
										<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_save_cancel" onClick="javascript: $('#myModalConfirmSave').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
									</div>
									<div class="col-xs-1 col-md-1"> 
										<input type="hidden" id="text_label" name="text_label" readonly>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="modal fade" id="myModalConfirmDelete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="false" data-keyboard="false">
				<div class="modal-dialog" role="document">
					<div class="modal-content alert-message alert-message-danger">
						<div class="modal-body" align="center">
							<div class="table-responsive" style="border: 0px !important;" border="0"> 
								<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_delete" class="glyphicon glyphicon-trash alert-message-danger" style="font-size: 50px;"> </span> </div>
								<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <%= msg_confirmdel_photo %> </h4> </div>
								<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
									<div class="col-xs-1 col-md-1"> </div>
									<div class="col-xs-5 col-md-5">
										<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_del" onClick="deleteFile('<%= action %>');" style="width: 100%;"> <%= btn_ok %> </button>
									</div>
									<div class="col-xs-5 col-md-5">
										<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" id="btn_del_cancel" onClick="javascript: $('#myModalConfirmDelete').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
									</div>
									<div class="col-xs-1 col-md-1"> 
										<input type="hidden" id="text_label" name="text_label" readonly>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		
	</body>
	
	<script type="text/javascript">
		function deleteFilePageAdd(){
			
			iframe_delete_file.location = 'camera_deletefile.jsp?action=add&file=CaptureBy-<%= username %>.jpg';
			
			setTimeout(function(){
			
				var canvas = document.getElementById("canvas");
				if (canvas.getContext) {
					ctx = document.getElementById("canvas").getContext("2d");
					ctx.clearRect(0, 0, 320, 240);
					var img = new Image();
					img.src = "photos/person.png";
					img.onload = function() {
						ctx.drawImage(img, 129, 89);
					}
					image = ctx.getImageData(0, 0, 320, 240);
				}
			
				ImgLoad();
				
			}, 100);
			
			setTimeout(function(){
				$("#statusDel").fadeOut(2000);
			}, 2000);
			
		}
		
		function disabledButton(){
		
		<%	if(action.equals("edit")){	%>
			
			$("#btn_save").prop('disabled', true);
			
			<%	if((new File(getServletContext().getRealPath("/")+"photos/" + idcard + ".jpg").exists() == true)){	%>
				$("#btn_del").prop('disabled', false);
			<%	}else if((new File(getServletContext().getRealPath("/")+"photos/" + idcard + ".jpg").exists() == false)){	%>
				$("#btn_del").prop('disabled', true);
			<%	}	%>
			
		<%	}	%>
		
		}
		
		function modalSaveFile(){
			$('#myModalConfirmSave').modal('show');
		}
		
		function saveFile(action){
			
			$("#btn_save").prop('disabled', true);
			$("#btn_del").prop('disabled', false);
			
			$('#statusDel').hide();
			$("#statusSave").fadeIn();
			
			setTimeout(function(){
				$("#statusSave").fadeOut(2000);
			}, 2000);
			
			$('#myModalConfirmSave').modal('hide');
			
			iframe_copy_file.location = 'module/act_employee.jsp?action=copy_file&idcard=<%= idcard %>';
			
			setTimeout(function(){
				parent.loadView();
			}, 1000);
		}
		
		function modalDeleteFile(){
			$('#myModalConfirmDelete').modal('show');
		}
		
		function deleteFile(action){
			
			$("#btn_save").prop('disabled', true);
			$("#btn_del").prop('disabled', true);
			
			$('#statusSave').hide();
			$("#statusDel").fadeIn();
			
			if(action == 'add'){
				iframe_delete_file.location = 'camera_deletefile.jsp?action='+action+'&file=CaptureBy-<%= username %>.jpg';
			}else if(action == 'edit'){
				iframe_delete_file.location = 'camera_deletefile.jsp?action='+action+'&file=<%= idcard %>.jpg';
				
				//	Update Status Photo
				setTimeout(function(){
					iframe_update_status.location = 'module/update_camera_finger.jsp?action=jpg_del&idcard=<%= idcard %>';
				}, 500);
			}
			
			setTimeout(function(){
			
				var canvas = document.getElementById("canvas");
				if (canvas.getContext) {
					ctx = document.getElementById("canvas").getContext("2d");
					ctx.clearRect(0, 0, 320, 240);
					var img = new Image();
					img.src = "photos/person.png";
					img.onload = function() {
						ctx.drawImage(img, 129, 89);
					}
					image = ctx.getImageData(0, 0, 320, 240);
				}
			
				ImgLoad();
				
			}, 100);
			
			setTimeout(function(){
				$("#statusDel").fadeOut(2000);
			}, 2000);
			
			$('#myModalConfirmDelete').modal('hide');
			
			setTimeout(function(){
				parent.loadView();
			}, 1000);
		}
	</script>
	
</html>