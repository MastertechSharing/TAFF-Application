<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
	<div class="col-xs-1 col-md-1"> </div>
	<div class="col-xs-5 col-md-5">
		<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
	</div>
	<div class="col-xs-5 col-md-5">
		<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: $('#myModalConfirm').modal('hide');" style="width: 100%;"> <%= btn_cancel %> </button>
	</div>
	<div class="col-xs-1 col-md-1"> 
		<input type="hidden" id="sCode" name="sCode" readonly>
		<input type="hidden" id="sCode2" name="sCode2" readonly>
		<input type="hidden" id="sType" name="sType" readonly>
	</div>
</div>