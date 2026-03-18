<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.IOException"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/sqlcmd.jsp"%>
<%	
	session.setAttribute("page_g", "special");
	session.setAttribute("subpage", "importfile");
	session.setAttribute("subtitle", "photos");
	session.setAttribute("action", "file_upload_photos.jsp?");	
%>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<script language="javascript" src="js/check_key.js"></script>
		<script language="javascript" src="js/check_input.js"></script>
		<script language="javascript" src="js/alert_box.js"></script> 
		
		<link rel="stylesheet" href="css/taff.css" type="text/css"> 
		
		<!-- Bootstrap -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/alert-messages.css" rel="stylesheet"> 
		<link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet">
		
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
		<script src="js/locales/bootstrap-datetimepicker.th.js" charset="UTF-8"></script>
		<script src="js/bootstrap-filestyle.min.js"></script>
		
		<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
		<script src="js/ie10-viewport-bug-workaround.js"></script>
		<script src="js/ie-emulation-modes-warning.js"></script>
		
		<style>
			table, tr, td { padding: 5px !important; }
		</style>		
	</head>
	
	<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">		
		<!-- INCLUDE HEADER & MENU-->
		<jsp:include page="header.jsp" flush="true"/>	
			
		<br/>
		<div class="body-display">
			<div class="container">
			
				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title"><i class="glyphicon glyphicon-cloud-upload"></i> <%= lb_fileupload %></h3>
					</div>
					<div class="panel-body" style="min-height: 100px; display: flex; flex-direction: column; justify-content: center;">
						<form id="fupload" name="fupload" method="post" enctype="multipart/form-data">
							
							<!-- 
							<div class="form-group text-left">
								<input type="file" id="folderInput" name="files[]" webkitdirectory directory multiple class="filestyle" data-buttonText=" Browse Folder" onChange="uploadFolder(this.files);" accept="image/jpeg">
							</div>	
							<ul id="fileList" style="max-height: 150px; overflow-y: auto; font-size: 12px; text-align: left;"></ul> 
							-->    

							<div class="form-group text-left">
								<input type="file" id="folderInput" name="files[]" multiple class="filestyle" data-buttonText=" Select Images" onChange="uploadFolder(this.files); uploadImages(this.files);" multiple accept="image/jpeg">								
							</div>							 
							<div id="previewContainer" style="margin-top:10px; display:none;">
								<strong>Photo Preview:</strong>
								<div id="imageThumbnails" style="max-height: 200px; overflow-y: auto; border: 1px solid #ddd; padding: 5px;"></div>
							</div>
							
						</form>
					</div>
				</div>
		
				<div id="uploadStatus" style="display:none; margin-top:10px;">
					<div class="progress">
						<div id="uploadProgress" class="progress-bar progress-bar-striped active" role="progressbar" style="width: 0%;">0%</div>
					</div>
					<p id="statusText" class="text-center">Preparing files....</p>
				</div>
			</div>
		</div>
		
		<script>
			function uploadImages(files) {
				if (files.length === 0) return;

				var thumbnailDiv = document.getElementById('imageThumbnails');
				var previewContainer = document.getElementById('previewContainer');
				thumbnailDiv.innerHTML = ""; // ล้างรูปเก่า
				previewContainer.style.display = 'block';

				// 1. แสดงรูปพรีวิว (Thumbnail)
				for (var i = 0; i < files.length; i++) {
					var file = files[i];
					if (!file.type.match('image.*')) continue;
					 
					var reader = new FileReader();
					reader.onload = (function(theFile) {
						return function(e) {
							var box = document.createElement("div");
							box.style.display = "inline-block";
							box.style.width = "80px"; // กว้างกว่ารูปเล็กน้อย
							box.style.textAlign = "center";
							box.style.verticalAlign = "top";
							box.style.margin = "5px";
		
							var img = document.createElement("img");
							img.src = e.target.result;
							img.style.width = "60px"; 
							img.style.height = "60px";
							img.style.margin = "3px";
							img.style.border = "1px solid #ccc";
							img.style.display = "inline-block"; // บังคับให้แสดงผล
							img.title = theFile.name;
							
							var fileName = document.createElement("div");
							fileName.textContent = theFile.name;
							fileName.style.fontSize = "10px";
							fileName.style.overflow = "hidden";
							fileName.style.textOverflow = "ellipsis"; // ถ้าชื่อยาวให้มี ... [MDN text-overflow](https://developer.mozilla.org)
							fileName.style.whiteSpace = "nowrap";
							fileName.style.marginTop = "2px";
							
							box.appendChild(img);
							box.appendChild(fileName);
							thumbnailDiv.appendChild(box);
		
							//thumbnailDiv.appendChild(img);
						};
					})(file);
					reader.readAsDataURL(file);
				}

				// 2. เรียกฟังก์ชัน AJAX Upload (ใช้ตัวเดิมที่คุณเขียนไว้ได้เลย)
				// แต่เปลี่ยนชื่อฟังก์ชันให้ตรงกัน
				startAjaxUpload(files); 
			}
					
			function uploadFolder(files) {
				if (files.length === 0) return;

				var formData = new FormData();
				var statusDiv = document.getElementById('uploadStatus');
				var statusText = document.getElementById('statusText');
				var progressBar = document.getElementById('uploadProgress');

				statusDiv.style.display = 'block';
    
				for (var i = 0; i < files.length; i++) {
					if (files[i].type === "image/jpeg" || files[i].type === "image/jpg") {
						formData.append('files[]', files[i]);
					}
				}

				var xhr = new XMLHttpRequest();
				xhr.open('POST', 'module/upload_processor.jsp', true);

				// Display Progress Bar
				xhr.upload.onprogress = function(e) {
					if (e.lengthComputable) {
						var percent = Math.round((e.loaded / e.total) * 100);
						progressBar.style.width = percent + '%';
						progressBar.innerHTML = percent + '%';
						statusText.innerHTML = "Uploading... (" + files.length + " files)";
					}
				};

				xhr.onload = function() {
				    var statusText = document.getElementById('statusText');
					var progressBar = document.getElementById('uploadProgress');

					if (xhr.status === 200) {            
						statusText.innerHTML = "<b style='color:green;'>Upload success " + xhr.responseText + " </b>";
						progressBar.classList.remove('active');
						progressBar.style.width = '100%';
						progressBar.innerHTML = '100%';
						progressBar.classList.add('progress-bar-success');
                        
						if(typeof resizeToContent === "function") resizeToContent();
						if (typeof getPageSize === 'function') {
							var size = getPageSize();
							window.resizeTo(size[0], size[1]);
						}
					} else {
						statusText.innerHTML = "<b style='color:red;'>Upload fail " + xhr.responseText + " </b>";
					}
					setTimeout(function() {
						 window.location.href = 'module/act_employee.jsp?action=check_file';
						// ถ้าต้องการให้ปิดหน้าต่างเองหลังจาก 3 วินาที
						// window.close(); 
					}, 3000);
				};

				xhr.send(formData);
			}
			
			document.getElementById('folderInput').addEventListener('change', function(event) {
				var files = event.target.files;
				var fileList = document.getElementById('fileList');
				fileList.innerHTML = ""; 

				for (var i = 0; i < files.length; i++) {
					var file = files[i];
					var li = document.createElement('li');	
					li.style.marginBottom = "10px";
					li.style.listStyle = "none";
					li.style.display = "flex";
					li.style.alignItems = "center";		
					
					if (file.type.match('image.*')) {
            var reader = new FileReader();
            
            // สร้าง Closure เพื่อรักษาตัวแปร li ของแต่ละไฟล์ไว้
            reader.onload = (function(theFile, theLi) {
                return function(e) {
                    var img = document.createElement('img');
                    img.src = e.target.result;
                    img.style.width = "40px";
                    img.style.height = "40px";
                    img.style.marginRight = "10px";
                    img.style.border = "1px solid #ddd";
                    img.style.objectFit = "cover";
                    
                    // แทรกรูปไว้หน้าชื่อไฟล์
                    theLi.prepend(img);
                };
            })(file, li);
            
            reader.readAsDataURL(file);
        }

        // ใส่ชื่อ Path หรือชื่อไฟล์
        var span = document.createElement('span');
        span.textContent = file.webkitRelativePath || file.name;
        li.appendChild(span);
        
        fileList.appendChild(li);
					//li.textContent = files[i].webkitRelativePath; 
					//fileList.appendChild(li);
				}
    
				if(typeof resizeToContent === "function") resizeToContent(); 
			});
		</script>
		
		<script language="javascript">
			$('.form_date').datetimepicker({
				language:  '<%= lang %>',
				weekStart: 1,
				todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 2,
				minView: 2,
				forceParse: 0
			});
		</script>
		
		<jsp:include page="footer.jsp" flush="true"/>
		
	</body>
</html>

<%@ include file="../function/disconnect.jsp"%>