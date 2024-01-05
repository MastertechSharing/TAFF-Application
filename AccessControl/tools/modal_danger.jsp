<div class="modal fade" id="myModalDanger" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog" role="document">
		<div class="modal-content alert-message alert-message-danger">
			<div class="modal-body" align="center">
				<div class="table-responsive" style="border: 0px !important;" border="0"> 
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-remove-circle alert-message-danger" style="font-size: 50px;"> </span> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_danger"> </p> </h4> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
						<div class="col-xs-3 col-md-3"> </div>
						<div class="col-xs-6 col-md-6">
							<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_danger" onClick="window.history.go(-1);" style="width: 100%;"> <%= btn_ok %> </button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myModalDangerNoReturn" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog" role="document">
		<div class="modal-content alert-message alert-message-danger">
			<div class="modal-body" align="center">
				<div class="table-responsive" style="border: 0px !important;" border="0"> 
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-remove-circle alert-message-danger" style="font-size: 50px;"> </span> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_danger_noreturn"> </p> </h4> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
						<div class="col-xs-3 col-md-3"> </div>
						<div class="col-xs-6 col-md-6">
							<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_danger" onClick="$('#myModalDangerNoReturn').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="myModalDangerLink" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog" role="document">
		<div class="modal-content alert-message alert-message-danger">
			<div class="modal-body" align="center">
				<div class="table-responsive" style="border: 0px !important;" border="0"> 
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-remove-circle alert-message-danger" style="font-size: 50px;"> </span> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_danger_link"> </p> </h4> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
						<div class="col-xs-3 col-md-3"> </div>
						<div class="col-xs-6 col-md-6">
							<button type="button" class="btn btn-danger btn-sm button-shadow1 button-shadow2" id="btn_danger" onClick="window.top.historyBack();" style="width: 100%;"> <%= btn_ok %> </button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>