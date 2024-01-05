<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<div class="modal fade" id="myModalResult" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog" role="document">
		<div class="modal-content alert-message alert-message-<%= type_alert %>">
			<div class="modal-body" align="center">
				<div class="table-responsive" style="border: 0px !important;" border="0"> 
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-<%= type_glyphicon %> alert-message-<%= type_alert %>" style="font-size: 50px;"> </span> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p> <%= text_result %> </p> </h4> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
						<div class="col-xs-3 col-md-3"> </div>
						<div class="col-xs-6 col-md-6">
							<button type="button" class="btn btn-<%= type_alert %> btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="javascript: $('#myModalResult').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
						</div>
						<div class="col-xs-3 col-md-3"> 
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!--	Menu > Tools > Import & Export Data [TXT]	-->
<div class="modal fade" id="myModalResultNoParam" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
	<div class="modal-dialog" role="document">
		<div class="modal-content alert-message alert-message-<%= type_alert %>">
			<div class="modal-body" align="center">
				<div class="table-responsive" style="border: 0px !important;" border="0"> 
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-<%= type_glyphicon %> alert-message-<%= type_alert %>" style="font-size: 50px;"> </span> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_result_noparam"> </p> </h4> </div>
					<div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
						<div class="col-xs-3 col-md-3"> </div>
						<div class="col-xs-6 col-md-6">
							<button type="button" class="btn btn-<%= type_alert %> btn-sm button-shadow1 button-shadow2" id="btn_confirm" onClick="javascript: $('#myModalResultNoParam').modal('hide');" style="width: 100%;"> <%= btn_ok %> </button>
						</div>
						<div class="col-xs-3 col-md-3"> 
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>