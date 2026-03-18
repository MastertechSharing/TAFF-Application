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
		session.setAttribute("action_browse", "add");
		session.setAttribute("idcard_browse", "");
		new File(path_EmpPhotos + "tmpBrowse\\BrowseBy-" + username + ".jpg").delete();
	}else if(action.equals("edit")){
		session.setAttribute("action_browse", "edit");
		session.setAttribute("idcard_browse", idcard);
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
		<script src="js/bootstrap-filestyle.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<script type="text/javascript">	
			$(":file").filestyle({ buttonBefore: true });
			
			var pos = 0;
			var ctx = null;
			var cam = null;
			var image = null;

			var filter_on = false;
			var filter_id = 0;
			
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

				return [pageWidth + 50, pageHeight + 100];
			}

			window.addEventListener("load", function() {
				
				var canvas = document.getElementById("canvas");
				if (canvas.getContext) {
					ctx = document.getElementById("canvas").getContext("2d");
					ctx.clearRect(0, 0, 320, 240);		
					var timestamp = new Date().getTime();					
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
				window.resizeTo(pageSize[0] + 50, pageSize[1] + 100);

			}, false);

			window.addEventListener("resize", function() {

				var pageSize = getPageSize();
				

			//	jQuery("#flash").css({ height: pageSize[1] + "px" });

			}, false);

			function ImgLoad(){ 
				setTimeout(function(){
					var myobj = window.top.document.getElementById("img_emp");	
					if(myobj != null){
						var timestamp = new Date().getTime();
						var oImg = new Image();
					<%	if(action.equals("add")){	%>
						oImg.src = "photos/tmpBrowse/BrowseBy-<%= username %>.jpg?t=" + timestamp;					
					<%	}else if(action.equals("edit")){	%>
						oImg.src = "photos/<%= idcard %>.jpg?t=" + timestamp;
					<%	}	%>
						oImg.onload = function(){ myobj.src = oImg.src }
						oImg.onerror = function(){ 
							oImg.src = "photos/person.png";
						}						
					}
				}, 1200);
			}
		</script>
		
	</head>
	<body style="width: 100%; margin: 0; padding: 1px; overflow: hidden;" align="center" onLoad="ImgLoad(); disabledButton();">			
			
        <div class="panel panel-info">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="glyphicon glyphicon-cloud-upload"></i> <%= lb_fileupload %></h3>
            </div>
            <div class="panel-body" style="min-height: 100px; display: flex; flex-direction: column; justify-content: center;">
                <form id="fupload" name="fupload" method="post" enctype="multipart/form-data">
                    <div class="form-group text-left">
                        <label><font color="red">*** <%= lb_msg_jpg %></font></label>
                        <input type="hidden" name="idcard" id="idcard" value="<%= idcard %>">
                        <!-- เรียกใช้ฟังก์ชันอัปโหลดที่ปรับปรุงใหม่ -->
                        <input type="file" name="files" id="files" class="filestyle" data-buttonBefore="true" data-buttonText="" data-buttonName="btn-primary" data-size="xs" onChange="checkInputFile('<%= lb_msg_jpg %>');" accept="image/jpeg">
                    </div>
                    <iframe id="iframe_target" name="iframe_target" style="display:none;"></iframe>
                </form>
            </div>
        </div>			
        
		<div class="panel panel-default">
            <div class="panel-heading alert-message-info">
                <h3 class="panel-title"><i class="glyphicon glyphicon-picture"></i> Photo Preview</h3>
            </div>
            <div class="panel-body text-center" style="min-height: 300;">
                <div style="border: 2px dashed #ddd; padding: 10px; display: inline-block; border-radius: 8px;">
                    <canvas id="canvas" width="320" height="240" style="background: #eee; border-radius: 4px;"></canvas>
                </div>
                <div style="margin-top: 15px;">
                    <div id="statusDel" style="display: none; margin-bottom: 10px;">
                        <span class="label label-danger">Delete Success</span>
                    </div>
                    <div class="btn-group">
                        <% if(action.equals("add")){ %>
                            <button type="button" id="btn_del" class="btn btn-danger" onClick="deleteFilePageAdd();">
                                <i class="glyphicon glyphicon-trash"></i> <%= lb_delete_photo %>
                            </button> 
                        <% } else if(action.equals("edit")){ %>								
                            <button type="button" id="btn_del" class="btn btn-danger" onClick="modalDeleteFile();">
                                <i class="glyphicon glyphicon-trash"></i> <%= lb_delete_photo %>
                            </button> 
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        
		<iframe src="" id="iframe_copy_file" name="iframe_copy_file" frameborder="0" width="0px" height="0px" style="margin-bottom: 20px;"></iframe>
		<iframe src="" id="iframe_delete_file" name="iframe_delete_file" frameborder="0" height="0px" width="0px" style="margin-bottom: 20px;"></iframe>
		<iframe src="" id="iframe_update_status" name="iframe_update_status" frameborder="0" width="0px" height="0px" style="margin-bottom: 20px;"></iframe>			
			
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
				
	</body>
	
	<script type="text/javascript">
		function disabledButton(){			
		<%	
			boolean isFileExists = new File(path_EmpPhotos + idcard + ".jpg").exists();
		%>
			$("#btn_del").prop('disabled', <%= !isFileExists%> );						
		}
	
		function checkInputFile(text){		
				
			var path = document.fupload.files;	
			//	Checking file type
			var re_text = /\.jpg|\.JPG/i;
			var filename = path.value;	
			if(filename != null){								
				if(filename.search(re_text) != -1){		
					var id =  document.getElementById("idcard").value;	
					document.fupload.action = 'module/upload_file.jsp?type=photos&idname='+id;
					document.fupload.target = 'iframe_target';
					document.fupload.submit();						
				}else{
					ModalWarning_TextName(text, '');
					document.fupload.reset();
					return false;
				}	   
			}
			
			//	Update Status Photo
			setTimeout(function(){
				iframe_update_status.location = 'module/update_camera_finger.jsp?action=jpg_add&idcard=<%= idcard %>';
			}, 500);
			
			setTimeout(function() {
				
				ImgLoad();
				if(window.parent && window.parent.jQuery) {
					window.parent.jQuery('#myModalBrowse').modal('hide');            
            
					if(typeof window.parent.ImgLoad === 'function'){
						window.parent.ImgLoad();
					}
				}
			}, 3000); 
						
		}
		
		function modalDeleteFile(){
			$('#myModalConfirmDelete').modal('show');
		}
		
		function deleteFile(action){
						
			$("#btn_del").prop('disabled', true);
						
			$("#statusDel").fadeIn();
			
			if(action == 'add'){
				iframe_delete_file.location = 'camera_deletefile.jsp?action='+action+'&file=BrowseBy-<%= username %>.jpg';
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
	</script>
	
</html>