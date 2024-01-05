<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<div class="btn-group dropup">
	<button type="button" class="btn btn-info btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		<i class="glyphicon glyphicon-info-sign"> </i> &nbsp; <%= lb_information %> &nbsp; 
		<span class="caret"></span>
		<span class="sr-only">Toggle Dropdown</span>
	</button>
	<ul class="dropdown-menu" style="width: 200px;" data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
		<li> <img src="images/edit.png" width="20" height="20" align="absmiddle" style="margin-left: 12px"> &nbsp; <%= lb_editdata %> <p> </li>
		<li> <img src="images/delete.png" width="22" height="22" align="absmiddle" style="margin-left: 10px"> &nbsp; <%= lb_deletedata %> </li>
	</ul>
</div>