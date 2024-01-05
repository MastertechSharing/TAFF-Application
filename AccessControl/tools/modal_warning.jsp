<div class="modal fade" id="myModalWarning" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog" role="document">
		<div id="modal_warning" class="modal-content alert-message alert-message-warning">
			<div class="modal-body" align="center">
				<div class="table-responsive" style="border: 0px !important;" border="0"> 
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span id="glyphicon_warning" class="glyphicon glyphicon-exclamation-sign alert-message-warning" style="font-size: 50px;"> </span> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_warning"> </p> </h4> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
						<div class="col-xs-3 col-md-3"> </div>
						<div class="col-xs-6 col-md-6">
							<button type="button" class="btn btn-warning btn-sm button-shadow1 button-shadow2" id="btn_warning" onClick="javascript: $('#myModalWarning').modal('hide'); javascript: document.getElementById($('#object_warning').val()).focus(); " style="width: 100%;"> <%= btn_ok %> </button>
						</div>
						<div class="col-xs-3 col-md-3"> 
							<input type="hidden" id="object_warning" name="object_warning" readonly>
							<input type="hidden" id="datetime_warning" name="datetime_warning" readonly>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>