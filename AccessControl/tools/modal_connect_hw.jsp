<div class="modal fade bs-example-modal-lg" id="myModalConnectHW" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog modal-lg" style="min-width: 1000px;" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" onClick="javascript: connect_hw.src = 'about:blank';">&times;</button>
				<h4 class="modal-title"> <%= lb_result_status %> </h4>
			</div>
			<div class="modal-body" align="center">
				<div class="table-responsive" style="border: 0px !important;" border="0">
					<iframe src="" id="connect_hw" name="connect_hw" frameborder="0" height="430px" style="min-width: 950px;"></iframe>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal" onClick="javascript: connect_hw.src = 'about:blank';"> <%= btn_close %> </button>
			</div>
		</div>
	</div>
</div>
