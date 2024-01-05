<div class="modal fade bs-example-modal-lg" id="myModalFlash" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"> Flash Player <%= lb_blocked %> </h4>
			</div>
			<div class="modal-body" align="center">
				<div class="table-responsive" style="border: 0px !important; height: 420px; margin-bottom: 0px;" border="0">
				
					<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
						<div class="panel panel-default">
							<div class="panel-heading" role="tab" id="h0">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseZero" aria-expanded="true" aria-controls="collapseZero">
										Adobe Flash Player
									</a>
								</h4>
							</div>
							<div id="collapseZero" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="h0">
								<div class="panel-body">									
									<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" id="FlexClient" width="0" height="0" codebase="http://fpdownload.macromedia.com/get/flashplayer/current/swflash.cab">
										<param name="movie" value="ClientReciveFlex.swf" />
										<param name="quality" value="high" />
										<param name="bgcolor" value="#869ca7" />
										<param name="allowScriptAccess" value="sameDomain" />
										<embed src="flash/ClientReciveFlex.swf" quality="high" bgcolor="#869ca7" width="400" height="240" name="FlexClient" align="middle"
											play="true" loop="false" quality="high" allowScriptAccess="sameDomain" type="application/x-shockwave-flash"
											pluginspage="http://www.adobe.com/go/getflashplayer">
										</embed>
									</object>
								</div>
							</div>
						</div>
						<%	String space_bar = "&nbsp; &nbsp; &nbsp; ";	%>
						
						<!--	Google Chrome	-->
						
						<div class="panel panel-default" id="chromestep1" style="display: none;">
							<div class="panel-heading" role="tab" id="chrome1">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOneChrome" aria-expanded="false" aria-controls="collapseOneChrome">
										Step 1: Turn on Flash
									</a>
								</h4>
							</div>
							<div id="collapseOneChrome" class="panel-collapse collapse" role="tabpanel" aria-labelledby="chrome1">
								<div class="panel-body" align="left">
									<%= space_bar %> 1. On your computer, open Chrome. <br/>
									<%= space_bar %> 2. At the top right, click More <i class="glyphicon glyphicon-option-vertical" data-toggle="tooltip" data-placement="top" title="More"></i>&nbsp;<i class="glyphicon glyphicon-menu-right" data-toggle="tooltip" data-placement="top" title="and then"></i>&nbsp;<strong>Settings</strong>. <br/>
									<%= space_bar %> 3. At the bottom, click <strong>Advanced</strong>. <br/>
									<%= space_bar %> 4. Under "Privacy and security," click <strong>Content settings</strong>. <br/>
									<%= space_bar %> 5. Click <strong>Flash</strong>. <br/>
									<%= space_bar %> 6. Turn on <strong>Allow sites to run Flash</strong>. <br/>
									<%= space_bar %> 7. Turn on <strong>Ask first</strong>. <br/>
									<%= space_bar %> 8. Go back to the page with the Flash content. If it doesn't load automatically, at the top left, click Reload Reload.
								</div>
							</div>
						</div>
				
						<div class="panel panel-default" id="chromestep2" style="display: none;">
							<div class="panel-heading" role="tab" id="chrome2">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoChrome" aria-expanded="false" aria-controls="collapseTwoChrome">
										Step 2: Update Flash
									</a>
								</h4>
							</div>
							<div id="collapseTwoChrome" class="panel-collapse collapse" role="tabpanel" aria-labelledby=chrome2">
								<div class="panel-body" align="left">
									<%= space_bar %> 1. On your computer, open Chrome. <br/>
									<%= space_bar %> 2. In the address bar at the top, enter <font color="#006600">chrome://components</font> and press <strong>Enter</strong>. <br/>
									<%= space_bar %> 3. Look for "Adobe Flash Player." <br/>
									<%= space_bar %> 4. Click <strong>Check for update</strong>. <br/>
									<%= space_bar %> 5. If you see "Component not updated" or "Component updated," you're on the latest version. <br/>
									<%= space_bar %> 6. Go back to the page with the Flash content. If it doesn't load automatically, at the top left, click Reload Reload.
								</div>
							</div>
						</div>
				
						<div class="panel panel-default" id="chromestep3" style="display: none;">
							<div class="panel-heading" role="tab" id="chrome3">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThreeChrome" aria-expanded="false" aria-controls="collapseThreeChrome">
										Step 3: Update Chrome
									</a>
								</h4>
							</div>
							<div id="collapseThreeChrome" class="panel-collapse collapse" role="tabpanel" aria-labelledby="chrome3">
								<div class="panel-body" align="left">
									<%= space_bar %> 1. On your computer, open Chrome. <br/>
									<%= space_bar %> 2. At the top right, click More <i class="glyphicon glyphicon-option-vertical" data-toggle="tooltip" data-placement="top" title="More"></i>. <br/>
									<%= space_bar %> 3. Click <strong>Update Google Chrome</strong>. If you don't see this button, you're on the latest version. <br/>
									<%= space_bar %> 4. Click <strong>Relaunch</strong>.
								</div>
							</div>
						</div>
				
						<div class="panel panel-default" id="chromestep4" style="display: none;">
							<div class="panel-heading" role="tab" id="chrome4">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFourChrome" aria-expanded="false" aria-controls="collapseFourChrome">
										Step 4: Reinstall Flash
									</a>
								</h4>
							</div>
							<div id="collapseFourChrome" class="panel-collapse collapse" role="tabpanel" aria-labelledby="chrome4">
								<div class="panel-body" align="left">
									Make sure that you only install Flash from Adobe's website. <br/><p><p>
									<%= space_bar %> 1. On your computer, open Chrome. <br/>
									<%= space_bar %> 2. Go to <a href="https://adobe.com/go/chrome" target="_blank">adobe.com/go/chrome</a>. <br/>
									<%= space_bar %> 3. Under "Step 1," select your computer's operating system. <br/>
									<%= space_bar %> 4. Under "Step 2," choose the option that lists "PPAPI." <br/>
									<%= space_bar %> 5. Click <strong>Download now</strong>, and follow the steps to install Flash.
								</div>
							</div>
						</div>
				
						<div class="panel panel-default" id="chromestep5" style="display: none;">
							<div class="panel-heading" role="tab" id="chrome5">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFiveChrome" aria-expanded="false" aria-controls="collapseFiveChrome">
										Reference Link
									</a>
								</h4>
							</div>
							<div id="collapseFiveChrome" class="panel-collapse collapse" role="tabpanel" aria-labelledby="chrome5">
								<div class="panel-body" align="left">
									<%= space_bar %> <a href="https://support.google.com/chrome/answer/6258784" target="_blank">support.google.com/chrome/answer/6258784</a> <i> ( External Link ) </i>
								</div>
							</div>
						</div>
						
						<!--	Internet Explorer 6-11	-->
						
						<div class="panel panel-default" id="iestep1" style="display: none;">
							<div class="panel-heading" role="tab" id="ie1">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOneIE" aria-expanded="false" aria-controls="collapseOneIE">
										Enable Flash Player
									</a>
								</h4>
							</div>
							<div id="collapseOneIE" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ie1">
								<div class="panel-body" align="left">
									<%= space_bar %> 1. Click the <strong>Tools</strong> menu <i class="glyphicon glyphicon-cog" data-toggle="tooltip" data-placement="top" title="Tools"></i>, in the upper-right corner of Internet Explorer. <br/>
									<%= space_bar %> 2. From the Tools menu, choose <strong>Manage add-ons</strong>. <br/>
									<%= space_bar %> 3. Select <strong>Shockwave Flash Object</strong> from the list. <br/>
									<%= space_bar %> 4. Click <strong>Enable</strong>, and then click <strong>Close</strong>.
								</div>
							</div>
						</div>
				
						<div class="panel panel-default" id="iestep2" style="display: none;">
							<div class="panel-heading" role="tab" id="ie2">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoIE" aria-expanded="false" aria-controls="collapseTwoIE">
										Disable ActiveX Filtering
									</a>
								</h4>
							</div>
							<div id="collapseTwoIE" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ie2">
								<div class="panel-body" align="left">
									<%= space_bar %> 1. Click the <strong>Tools</strong> menu <i class="glyphicon glyphicon-cog" data-toggle="tooltip" data-placement="top" title="Tools"></i> and choose <strong>Safety</strong> <i class="glyphicon glyphicon-menu-right" and then"></i> <strong>ActiveX Filtering</strong>. <br/>
									<%= space_bar %> 2. Close the browser and open it. Then, try to view the content.
								</div>
							</div>
						</div>
				
						<div class="panel panel-default" id="iestep3" style="display: none;">
							<div class="panel-heading" role="tab" id="ie3">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThreeIE" aria-expanded="false" aria-controls="collapseThreeIE">
										Reference Link
									</a>
								</h4>
							</div>
							<div id="collapseThreeIE" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ie3">
								<div class="panel-body" align="left">
									<%= space_bar %> <a href="https://helpx.adobe.com/flash-player/kb/flash-player-issues-windows-10-ie.html" target="_blank">helpx.adobe.com/flash-player/kb/flash-player-issues-windows-10-ie.html</a> <i> ( External Link ) </i>
								</div>
							</div>
						</div>
						
						<!--	Internet Explorer Edge	-->
						
						<div class="panel panel-default" id="ieedgestep1" style="display: none;">
							<div class="panel-heading" role="tab" id="ieedge1">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOneIEEdge" aria-expanded="false" aria-controls="collapseOneIEEdge">
										Enable Flash Player
									</a>
								</h4>
							</div>
							<div id="collapseOneIEEdge" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ieedge1">
								<div class="panel-body" align="left">
									<%= space_bar %> 1. Click the " <i class="glyphicon glyphicon-option-horizontal"></i> " button to access the Edge menu. <br/>
									<%= space_bar %> 2. Select the <strong>Settings</strong> menu item. <br/>
									<%= space_bar %> 3. Scroll down to the <strong>Advanced Settings</strong> section and click the <strong>View advanced settings</strong> button. <br/>
									<%= space_bar %> 4. Locate the <strong>Use Adobe Flash Player</strong> section and toggle the switch on to enable Adobe Flash Player. <br/>
									<%= space_bar %> 5. Refresh your web page or open a new browser tab.
								</div>
							</div>
						</div>
				
						<div class="panel panel-default" id="ieedgestep2" style="display: none;">
							<div class="panel-heading" role="tab" id="ieedge2">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoIEEdge" aria-expanded="false" aria-controls="collapseTwoIEEdge">
										Reference Link
									</a>
								</h4>
							</div>
							<div id="collapseTwoIEEdge" class="panel-collapse collapse" role="tabpanel" aria-labelledby="ieedge2">
								<div class="panel-body" align="left">
									<%= space_bar %> <a href="https://helpx.adobe.com/flash-player/kb/flash-player-issues-windows-10-edge.html" target="_blank">helpx.adobe.com/flash-player/kb/flash-player-issues-windows-10-edge.html</a> <i> ( External Link ) </i>
								</div>
							</div>
						</div>
						
						<!--	Firefox	-->
						
						<div class="panel panel-default" id="firefoxstep1" style="display: none;">
							<div class="panel-heading" role="tab" id="firefox1">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOneFirefox" aria-expanded="false" aria-controls="collapseOneFirefox">
										Enable Flash Player
									</a>
								</h4>
							</div>
							<div id="collapseOneFirefox" class="panel-collapse collapse" role="tabpanel" aria-labelledby="firefox1">
								<div class="panel-body" align="left">
									<%= space_bar %> 1. Open your Firefox browser, on the top-right corner, click the <strong>three-bar icon</strong> <i class="glyphicon glyphicon-menu-hamburger"  data-toggle="tooltip" data-placement="top" title="three-bar icon"></i> and choose <strong>Add-ons</strong> option. <br/>
									<%= space_bar %> 2. On the left side, choose <strong>Plugins</strong>. Then select from the drop down box of category Shockwave Flash <strong>Always Activate</strong>.
								</div>
							</div>
						</div>
				
						<div class="panel panel-default" id="firefoxstep2" style="display: none;">
							<div class="panel-heading" role="tab" id="firefox2">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoFirefox" aria-expanded="false" aria-controls="collapseTwoFirefox">
										Reference Link
									</a>
								</h4>
							</div>
							<div id="collapseTwoFirefox" class="panel-collapse collapse" role="tabpanel" aria-labelledby="firefox2">
								<div class="panel-body" align="left">
									<%= space_bar %> <a href="https://www.drivereasy.com/knowledge/enable-flash-on-chrome-firefox-opera-and-edge-on-windows-10/#2" target="_blank">www.drivereasy.com/knowledge/enable-flash-on-chrome-firefox-opera-and-edge-on-windows-10/#2</a> <i> ( External Link ) </i>
								</div>
							</div>
						</div>
						
						<!--	Opera	-->
						
						<div class="panel panel-default" id="operastep1" style="display: none;">
							<div class="panel-heading" role="tab" id="oepra1">
								<h4 class="panel-title">
									<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOneOpera" aria-expanded="false" aria-controls="collapseOneOpera">
										Enable Flash Player
									</a>
								</h4>
							</div>
							<div id="collapseOneOpera" class="panel-collapse collapse" role="tabpanel" aria-labelledby="oepra1">
								<div class="panel-body" align="left">
									<%= space_bar %> 1. Open a blank page in Opera. Press the <strong>Settings</strong> <i class="glyphicon glyphicon-cog"  data-toggle="tooltip" data-placement="top" title="Settings"></i> button, which is on the side menu bar on the left side. Then choose <strong>Websites</strong> option. Scroll down a little bit and choose <strong>Manage Individual plug-ins...</strong> under Plug-ins category. <br/>
									<%= space_bar %> 2. Make sure you are seeing a <strong>Disable</strong> button here if you are to enable your Adobe Flash Player.
								</div>
							</div>
						</div>
				
						<div class="panel panel-default" id="operastep2" style="display: none;">
							<div class="panel-heading" role="tab" id="oepra2">
								<h4 class="panel-title">
									<a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwoOpera" aria-expanded="false" aria-controls="collapseTwoOpera">
										Reference Link
									</a>
								</h4>
							</div>
							<div id="collapseTwoOpera" class="panel-collapse collapse" role="tabpanel" aria-labelledby="oepra2">
								<div class="panel-body" align="left">
									<%= space_bar %> <a href="https://www.drivereasy.com/knowledge/enable-flash-on-chrome-firefox-opera-and-edge-on-windows-10/#3" target="_blank">www.drivereasy.com/knowledge/enable-flash-on-chrome-firefox-opera-and-edge-on-windows-10/#3</a> <i> ( External Link ) </i>
								</div>
							</div>
						</div>
						
					</div>
					
				</div>
			</div>
			<div class="modal-footer" style="max-height: 55px !important; margin-bottom: 0px;">
				<div align="left" style="margin-top: 4px;"> <strong> <%= lb_comment %> : <%= lb_note_block %> </strong> </div>
				<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" style="margin-top: -46px;" data-dismiss="modal"> <%= btn_close %> </button>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" language="javascript">
	function checkFlash(){
		var detectFlash = detectflash();
		if(detectFlash != true){
			$('#myModalFlash').modal('show');
		}
	}
	
	function detectflash(){
		if (navigator.plugins != null && navigator.plugins.length > 0){
			return navigator.plugins["Shockwave Flash"] && true;
		}
		if(~navigator.userAgent.toLowerCase().indexOf("webtv")){
			return true;
		}
		if(~navigator.appVersion.indexOf("MSIE") && !~navigator.userAgent.indexOf("Opera")){
			try{
				return new ActiveXObject("ShockwaveFlash.ShockwaveFlash") && true;
			} catch(e){}
		}
		return false;
	}
	
	function checkBrowserFixFlash(){
		var isChrome = !!window.chrome && !!window.chrome.webstore;			// Chrome 1+
		var isIE = /*@cc_on!@*/false || !!document.documentMode;			// Internet Explorer 6-11
		var isEdge = !isIE && !!window.StyleMedia;							// Edge 20+
		var isFirefox = typeof InstallTrigger !== 'undefined';				// Firefox 1.0+
		var isOpera = (!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;	// Opera 8.0+
		
		if(isChrome == true){
			document.getElementById('chromestep1').style.display = '';
			document.getElementById('chromestep2').style.display = '';
			document.getElementById('chromestep3').style.display = '';
			document.getElementById('chromestep4').style.display = '';
			document.getElementById('chromestep5').style.display = '';
		}
		if(isIE == true){
			document.getElementById('iestep1').style.display = '';
			document.getElementById('iestep2').style.display = '';
			document.getElementById('iestep3').style.display = '';
		}
		if(isEdge == true){
			document.getElementById('ieedgestep1').style.display = '';
			document.getElementById('ieedgestep2').style.display = '';
		}
		if(isFirefox == true){
			document.getElementById('firefoxstep1').style.display = '';
			document.getElementById('firefoxstep2').style.display = '';
		}
		if(isOpera == true){
			document.getElementById('operastep1').style.display = '';
			document.getElementById('operastep2').style.display = '';
		}
	}
</script>
