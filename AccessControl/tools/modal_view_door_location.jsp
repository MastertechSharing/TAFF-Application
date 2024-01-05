<div class="modal fade bs-example-modal-lg" id="myModalViewDoor" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"> <%= lb_viewdata %> </h4>
			</div>
			<div class="modal-body" align="center">
				<div class="table-responsive" style="border: 0px !important;" border="0">
					<iframe src="#" id="view_door" name="view_door" frameborder="0" height="450px" style="min-width: 850px;"></iframe>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade bs-example-modal-lg" id="myModalViewLocation" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title"> <%= lb_viewdata %> </h4>
			</div>
			<div class="modal-body" align="center">
				<div class="table-responsive" style="border: 0px !important;" border="0">
					<iframe src="#" id="view_location" name="view_location" frameborder="0" height="260px" style="min-width: 850px;"></iframe>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" data-dismiss="modal"> <%= btn_close %> </button>
			</div>
		</div>
	</div>
</div>