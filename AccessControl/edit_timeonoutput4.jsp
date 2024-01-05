<!DOCTYPE html>
<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ include file="../function/connect.jsp"%>
<%@ include file="../function/session.jsp"%>
<%@ include file="../function/language.jsp"%>
<%@ include file="../function/datetime.jsp"%>
<%@ include file="../function/utility.jsp"%>
<% 
    session.setAttribute("page_g", "database");
    session.setAttribute("subpage", "abouttime");
    session.setAttribute("subtitle", "timeonoutput4"); 
    session.setAttribute("action", "edit_timeonoutput4.jsp?"+"&action="+request.getParameter("action")+"&day_type="+request.getParameter("day_type")+"&");    
%>

<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=tis-620">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge, chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        
        <script language="javascript" src="js/check_input.js"></script>
        <script language="javascript" src="js/check_key.js"></script> 
        <script language="javascript" src="js/alert_box.js"></script>
        
        <link rel="stylesheet" href="css/taff.css" type="text/css"> 
        
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/alert-messages.css" rel="stylesheet"> 
        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        
        <!-- Latest compiled and minified CSS -->
        <link href="css/bootstrap-select.min.css" rel="stylesheet">
        <!-- Latest compiled and minified JavaScript -->
        <script src="js/bootstrap-select.min.js"></script>
        
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <script src="js/ie10-viewport-bug-workaround.js"></script>
        <script src="js/ie-emulation-modes-warning.js"></script>

        <script language="javascript">
            document.onkeydown = searchKeyPress;
        </script>
    </head>
 
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
        
<% 
        String action = "";
        if(request.getParameter("action") != null){
            action = request.getParameter("action");
        }else{
            response.sendRedirect("data_timeonoutput4.jsp");
        }
        session.setAttribute("act", action);
%>
    
        <!-- INCLUDE HEADER & MENU-->
        <jsp:include page="header.jsp" flush="true"/> <p>
		
		<%	if(!checkPermission(ses_per, "01")){	%>
		
			<%@ include file="../tools/modal_danger.jsp"%>
			
			<script> ModalDanger_NoTimeout('<%= lb_invalid_permissions %>'); </script>
			
		<%	}else{	%>
		
        <div class="body-display">
            <div class="container">
                
                <form id="form1" name="form1" method="post">
            
                <div class="row" style="border: 0px !important; margin-bottom: -15px; margin-left: 0px; margin-right: 0px;" border="0">
                    <div class="bs-callout bs-callout-info"> 
                    
<%      if(action.equals("edit")){          
            String day_type = request.getParameter("day_type");        
            try{
                ResultSet rs = stmtQry.executeQuery("SELECT * FROM dbtimeon_out4 WHERE (day_type = '"+day_type+"') ");
                while(rs.next()){               
                    int typeday = Integer.parseInt(day_type);  
                        
                    String maxTime1 = rs.getString("time1");
                    String maxTime2 = rs.getString("time2");
                    String maxTime3 = rs.getString("time3");
                    String maxTime4 = rs.getString("time4");
                    String maxTime5 = rs.getString("time5");
                    
                    String maxTime6 = rs.getString("time6");
                    String maxTime7 = rs.getString("time7");
                    String maxTime8 = rs.getString("time8");
                    String maxTime9 = rs.getString("time9");
                    String maxTime10 = rs.getString("time10");  
                    
                    String maxTime11 = rs.getString("time11");
                    String maxTime12 = rs.getString("time12");
                    String maxTime13 = rs.getString("time13");
                    String maxTime14 = rs.getString("time14");
                    String maxTime15 = rs.getString("time15");  
                    
                    String maxTime16 = rs.getString("time16");
                    String maxTime17 = rs.getString("time17");
                    String maxTime18 = rs.getString("time18");
                    String maxTime19 = rs.getString("time19");
                    String maxTime20 = rs.getString("time20");  
                    
                    String maxTime21 = rs.getString("time21");
                    String maxTime22 = rs.getString("time22");
                    String maxTime23 = rs.getString("time23");
                    String maxTime24 = rs.getString("time24");
                    String maxTime25 = rs.getString("time25");  
                    
                    String maxTime26 = rs.getString("time26");
                    String maxTime27 = rs.getString("time27");
                    String maxTime28 = rs.getString("time28");
                    String maxTime29 = rs.getString("time29");
                    String maxTime30 = rs.getString("time30");                  
%>
 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_day %> : </label>
                            <div class="col-md-4" style="margin-top: 6px;">
                                <div class="form-group has-error has-feedback" id="textbox_locate_code" style="margin-bottom: 0px">
                                    <%= getLongDay(typeday, lang) %>
                                    <input type="hidden" id="day_type" name="day_type" value="<%= day_type %>">
                                </div>
                            </div>
                            <div class="col-md-6" style="margin-top: 6px;"> </div>
                        </div>
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 1 : </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh1" name="hh1" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime1, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm1', event)" onBlur="return checkHour(this, document.form1.mm1, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm1" name="mm1" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime1, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss1, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss1', event)" onBlur="return checkMinute(this, document.form1.ss1, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss1" name="ss1" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime1, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh2, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh2', event)" onBlur="return checkMinute(this, document.form1.hh2, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh2" name="hh2" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime1, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm2', event)" onBlur="return checkHour(this, document.form1.mm2, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm2" name="mm2" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime1, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss2, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss2', event)" onBlur="return checkMinute(this, document.form1.ss2, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss2" name="ss2" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime1, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh3, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh3', event)" onBlur="return checkMinute(this, document.form1.hh3, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" id="hidtime1" name="hidtime1" value="<%= maxTime1 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 2 : </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh3" name="hh3" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime2, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm3, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm3', event)" onBlur="return checkHour(this, document.form1.mm3, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm3" name="mm3" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime2, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss3, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss3', event)" onBlur="return checkMinute(this, document.form1.ss3, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss3" name="ss3" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime2, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh4, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh4', event)" onBlur="return checkMinute(this, document.form1.hh4, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh4" name="hh4" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime2, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm4, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm4', event)" onBlur="return checkHour(this, document.form1.mm4, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm4" name="mm4" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime2, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss4, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss4', event)" onBlur="return checkMinute(this, document.form1.ss4, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss4" name="ss4" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime2, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh5, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh5', event)" onBlur="return checkMinute(this, document.form1.hh5, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" id="hidtime2" name="hidtime2" value="<%= maxTime2 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 3 : </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh5" name="hh5" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime3, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm5, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm5', event)" onBlur="return checkHour(this, document.form1.mm5, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm5" name="mm5" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime3, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss5, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss5', event)" onBlur="return checkMinute(this, document.form1.ss5, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss5" name="ss5" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime3, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh6, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh6', event)" onBlur="return checkMinute(this, document.form1.hh6, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh6" name="hh6" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime3, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm6, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm6', event)" onBlur="return checkHour(this, document.form1.mm6, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm6" name="mm6" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime3, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss6, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss6', event)" onBlur="return checkMinute(this, document.form1.ss6, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss6" name="ss6" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime3, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh7, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh7', event)" onBlur="return checkMinute(this, document.form1.hh7, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" id="hidtime3" name="hidtime3" value="<%= maxTime3 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 4 : </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh7" name="hh7" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime4, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm7, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm7', event)" onBlur="return checkHour(this, document.form1.mm7, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm7" name="mm7" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime4, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss7, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss7', event)" onBlur="return checkMinute(this, document.form1.ss7, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss7" name="ss7" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime4, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh8, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh8', event)" onBlur="return checkMinute(this, document.form1.hh8, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh8" name="hh8" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime4, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm8, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm8', event)" onBlur="return checkHour(this, document.form1.mm8, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm8" name="mm8" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime4, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss8, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss8', event)" onBlur="return checkMinute(this, document.form1.ss8, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss8" name="ss8" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime4, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh9, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh9', event)" onBlur="return checkMinute(this, document.form1.hh9, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" id="hidtime4" name="hidtime4" value="<%= maxTime4 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 5 : </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh9" name="hh9" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime5, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm9, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm9', event)" onBlur="return checkHour(this, document.form1.mm9, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm9" name="mm9" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime5, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss9, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss9', event)" onBlur="return checkMinute(this, document.form1.ss9, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss9" name="ss9" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime5, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh10, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh10', event)" onBlur="return checkMinute(this, document.form1.hh10, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh10" name="hh10" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime5, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm10, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm10', event)" onBlur="return checkHour(this, document.form1.mm10, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm10" name="mm10" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime5, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss10, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss10', event)" onBlur="return checkMinute(this, document.form1.ss10, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss10" name="ss10" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime5, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh11, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh11', event)" onBlur="return checkMinute(this, document.form1.hh11, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" id="hidtime5" name="hidtime5" value="<%= maxTime5 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 6 : </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh11" name="hh11" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime6, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm11, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm11', event)" onBlur="return checkHour(this, document.form1.mm11, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm11" name="mm11" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime6, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss11, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss11', event)" onBlur="return checkMinute(this, document.form1.ss11, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss11" name="ss11" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime6, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh12, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh12', event)" onBlur="return checkMinute(this, document.form1.hh12, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh12" name="hh12" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime6, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm12, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm12', event)" onBlur="return checkHour(this, document.form1.mm12, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm12" name="mm12" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime6, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss12, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss12', event)" onBlur="return checkMinute(this, document.form1.ss12, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss12" name="ss12" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime6, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh13, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh13', event)" onBlur="return checkMinute(this, document.form1.hh13, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" id="hidtime6" name="hidtime6" value="<%= maxTime6 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 7 : </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh13" name="hh13" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime7, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm13, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm13', event)" onBlur="return checkHour(this, document.form1.mm13, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm13" name="mm13" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime7, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss13, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss13', event)" onBlur="return checkMinute(this, document.form1.ss13, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss13" name="ss13" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime7, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh14, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh14', event)" onBlur="return checkMinute(this, document.form1.hh14, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh14" name="hh14" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime7, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm14, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm14', event)" onBlur="return checkHour(this, document.form1.mm14, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm14" name="mm14" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime7, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss14, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss14', event)" onBlur="return checkMinute(this, document.form1.ss14, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss14" name="ss14" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime7, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh15, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh15', event)" onBlur="return checkMinute(this, document.form1.hh15, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" id="hidtime7" name="hidtime7" value="<%= maxTime7 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 8 : </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh15" name="hh15" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime8, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm15, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm15', event)" onBlur="return checkHour(this, document.form1.mm15, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm15" name="mm15" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime8, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss15, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss15', event)" onBlur="return checkMinute(this, document.form1.ss15, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss15" name="ss15" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime8, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh16, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh16', event)" onBlur="return checkMinute(this, document.form1.hh16, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh16" name="hh16" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime8, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm16, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm16', event)" onBlur="return checkHour(this, document.form1.mm16, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm16" name="mm16" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime8, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss16, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss16', event)" onBlur="return checkMinute(this, document.form1.ss16, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss16" name="ss16" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime8, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh17, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh17', event)" onBlur="return checkMinute(this, document.form1.hh17, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" id="hidtime8" name="hidtime8" value="<%= maxTime8 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 9 : </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh17" name="hh17" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime9, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm17, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm17', event)" onBlur="return checkHour(this, document.form1.mm17, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm17" name="mm17" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime9, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss17, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss17', event)" onBlur="return checkMinute(this, document.form1.ss17, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss17" name="ss17" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime9, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh18, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh18', event)" onBlur="return checkMinute(this, document.form1.hh18, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="hh18" name="hh18" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime9, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm18, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm18', event)" onBlur="return checkHour(this, document.form1.mm18, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="mm18" name="mm18" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime9, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss18, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss18', event)" onBlur="return checkMinute(this, document.form1.ss18, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="text" id="ss18" name="ss18" class="form-control" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime9, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh19, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh19', event)" onBlur="return checkMinute(this, document.form1.hh19, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" id="hidtime9" name="hidtime9" value="<%= maxTime9 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 10 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh19" type="text" class="form-control" id="hh19" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime10, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm19, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm19', event)" onBlur="return checkHour(this, document.form1.mm19, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm19" type="text" class="form-control" id="mm19" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime10, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss19, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss19', event)" onBlur="return checkMinute(this, document.form1.ss19, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss19" type="text" class="form-control" id="ss19" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime10, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh20, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh20', event)" onBlur="return checkMinute(this, document.form1.hh20, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh20" type="text" class="form-control" id="hh20" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime10, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm20, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm20', event)" onBlur="return checkHour(this, document.form1.mm20, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm20" type="text" class="form-control" id="mm20" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime10, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss20, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss20', event)" onBlur="return checkMinute(this, document.form1.ss20, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss20" type="text" class="form-control" id="ss20" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime10, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh21, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh21', event)" onBlur="return checkMinute(this, document.form1.hh21, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime10" id="hidtime10" value="<%= maxTime10 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 11 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh21" type="text" class="form-control" id="hh21" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime11, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm21, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm21', event)" onBlur="return checkHour(this, document.form1.mm21, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm21" type="text" class="form-control" id="mm21" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime11, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss21, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss21', event)" onBlur="return checkMinute(this, document.form1.ss21, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss21" type="text" class="form-control" id="ss21" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime11, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh22, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh22', event)" onBlur="return checkMinute(this, document.form1.hh22, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh22" type="text" class="form-control" id="hh22" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime11, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm22, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm22', event)" onBlur="return checkHour(this, document.form1.mm22, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm22" type="text" class="form-control" id="mm22" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime11, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss22, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss22', event)" onBlur="return checkMinute(this, document.form1.ss22, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss22" type="text" class="form-control" id="ss22" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime11, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh23, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh23', event)" onBlur="return checkMinute(this, document.form1.hh23, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime11" id="hidtime11" value="<%= maxTime11 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 12 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh23" type="text" class="form-control" id="hh23" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime12, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm23, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm23', event)" onBlur="return checkHour(this, document.form1.mm23, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm23" type="text" class="form-control" id="mm23" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime12, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss23, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss23', event)" onBlur="return checkMinute(this, document.form1.ss23, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss23" type="text" class="form-control" id="ss23" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime12, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh24, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh24', event)" onBlur="return checkMinute(this, document.form1.hh24, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh24" type="text" class="form-control" id="hh24" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime12, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm24, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm24', event)" onBlur="return checkHour(this, document.form1.mm24, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm24" type="text" class="form-control" id="mm24" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime12, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss24, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss24', event)" onBlur="return checkMinute(this, document.form1.ss24, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss24" type="text" class="form-control" id="ss24" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime12, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh25, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh25', event)" onBlur="return checkMinute(this, document.form1.hh25, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime12" id="hidtime12" value="<%= maxTime12 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 13 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh25" type="text" class="form-control" id="hh25" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime13, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm25, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm25', event)" onBlur="return checkHour(this, document.form1.mm25, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm25" type="text" class="form-control" id="mm25" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime13, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss25, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss25', event)" onBlur="return checkMinute(this, document.form1.ss25, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss25" type="text" class="form-control" id="ss25" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime13, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh26, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh26', event)" onBlur="return checkMinute(this, document.form1.hh26, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh26" type="text" class="form-control" id="hh26" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime13, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm26, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm26', event)" onBlur="return checkHour(this, document.form1.mm26, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm26" type="text" class="form-control" id="mm26" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime13, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss26, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss26', event)" onBlur="return checkMinute(this, document.form1.ss26, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss26" type="text" class="form-control" id="ss26" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime13, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh27, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh27', event)" onBlur="return checkMinute(this, document.form1.hh27, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime13" id="hidtime13" value="<%= maxTime13 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 14 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh27" type="text" class="form-control" id="hh27" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime14, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm27, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm27', event)" onBlur="return checkHour(this, document.form1.mm27, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm27" type="text" class="form-control" id="mm27" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime14, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss27, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss27', event)" onBlur="return checkMinute(this, document.form1.ss27, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss27" type="text" class="form-control" id="ss27" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime14, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh28, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh28', event)" onBlur="return checkMinute(this, document.form1.hh28, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh28" type="text" class="form-control" id="hh28" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime14, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm28, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm28', event)" onBlur="return checkHour(this, document.form1.mm28, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm28" type="text" class="form-control" id="mm28" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime14, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss28, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss28', event)" onBlur="return checkMinute(this, document.form1.ss28, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss28" type="text" class="form-control" id="ss28" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime14, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh29, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh29', event)" onBlur="return checkMinute(this, document.form1.hh29, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime14" id="hidtime14" value="<%= maxTime14 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 15 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh29" type="text" class="form-control" id="hh29" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime15, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm29, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm29', event)" onBlur="return checkHour(this, document.form1.mm29, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm29" type="text" class="form-control" id="mm29" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime15, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss29, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss29', event)" onBlur="return checkMinute(this, document.form1.ss29, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss29" type="text" class="form-control" id="ss29" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime15, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh30, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh30', event)" onBlur="return checkMinute(this, document.form1.hh30, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh30" type="text" class="form-control" id="hh30" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime15, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm30, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm30', event)" onBlur="return checkHour(this, document.form1.mm30, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm30" type="text" class="form-control" id="mm30" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime15, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss30, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss30', event)" onBlur="return checkMinute(this, document.form1.ss30, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss30" type="text" class="form-control" id="ss30" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime15, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh31, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh31', event)" onBlur="return checkMinute(this, document.form1.hh31, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime15" id="hidtime15" value="<%= maxTime15 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 16</label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh31" type="text" class="form-control" id="hh31" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime16, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm31, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm31', event)" onBlur="return checkHour(this, document.form1.mm31, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm31" type="text" class="form-control" id="mm31" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime16, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss31, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss31', event)" onBlur="return checkMinute(this, document.form1.ss31, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss31" type="text" class="form-control" id="ss31" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime16, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh32, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh32', event)" onBlur="return checkMinute(this, document.form1.hh32, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh32" type="text" class="form-control" id="hh32" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime16, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm32, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm32', event)" onBlur="return checkHour(this, document.form1.mm32, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm32" type="text" class="form-control" id="mm32" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime16, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss32, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss32', event)" onBlur="return checkMinute(this, document.form1.ss32, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss32" type="text" class="form-control" id="ss32" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime16, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh33, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh33', event)" onBlur="return checkMinute(this, document.form1.hh33, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime16" id="hidtime16" value="<%= maxTime16 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 17</label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh33" type="text" class="form-control" id="hh33" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime17, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm33, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm33', event)" onBlur="return checkHour(this, document.form1.mm33, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm33" type="text" class="form-control" id="mm33" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime17, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss33, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss33', event)" onBlur="return checkMinute(this, document.form1.ss33, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss33" type="text" class="form-control" id="ss33" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime17, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh34, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh34', event)" onBlur="return checkMinute(this, document.form1.hh34, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh34" type="text" class="form-control" id="hh34" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime17, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm34, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm34', event)" onBlur="return checkHour(this, document.form1.mm34, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm34" type="text" class="form-control" id="mm34" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime17, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss34, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss34', event)" onBlur="return checkMinute(this, document.form1.ss34, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss34" type="text" class="form-control" id="ss34" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime17, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh35, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh35', event)" onBlur="return checkMinute(this, document.form1.hh35, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime17" id="hidtime17" value="<%= maxTime17 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 18</label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh35" type="text" class="form-control" id="hh35" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime18, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm35, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm35', event)" onBlur="return checkHour(this, document.form1.mm35, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm35" type="text" class="form-control" id="mm35" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime18, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss35, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss35', event)" onBlur="return checkMinute(this, document.form1.ss35, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss35" type="text" class="form-control" id="ss35" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime18, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh36, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh36', event)" onBlur="return checkMinute(this, document.form1.hh36, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh36" type="text" class="form-control" id="hh36" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime18, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm36, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm36', event)" onBlur="return checkHour(this, document.form1.mm36, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm36" type="text" class="form-control" id="mm36" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime18, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss36, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss36', event)" onBlur="return checkMinute(this, document.form1.ss36, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss36" type="text" class="form-control" id="ss36" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime18, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh37, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh37', event)" onBlur="return checkMinute(this, document.form1.hh37, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime18" id="hidtime18" value="<%= maxTime18 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 19</label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh37" type="text" class="form-control" id="hh37" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime19, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm37, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm37', event)" onBlur="return checkHour(this, document.form1.mm37, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm37" type="text" class="form-control" id="mm37" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime19, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss37, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss37', event)" onBlur="return checkMinute(this, document.form1.ss37, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss37" type="text" class="form-control" id="ss37" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime19, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh38, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh38', event)" onBlur="return checkMinute(this, document.form1.hh38, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh38" type="text" class="form-control" id="hh38" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime19, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm38, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm38', event)" onBlur="return checkHour(this, document.form1.mm38, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm38" type="text" class="form-control" id="mm38" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime19, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss38, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss38', event)" onBlur="return checkMinute(this, document.form1.ss38, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss38" type="text" class="form-control" id="ss38" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime19, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh39, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh39', event)" onBlur="return checkMinute(this, document.form1.hh39, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime19" id="hidtime19" value="<%= maxTime19 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 20</label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh39" type="text" class="form-control" id="hh39" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime20, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm39, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm39', event)" onBlur="return checkHour(this, document.form1.mm39, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm39" type="text" class="form-control" id="mm39" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime20, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss39, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss39', event)" onBlur="return checkMinute(this, document.form1.ss39, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss39" type="text" class="form-control" id="ss39" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime20, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh40, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh40', event)" onBlur="return checkMinute(this, document.form1.hh40, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh40" type="text" class="form-control" id="hh40" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime20, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm40, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm40', event)" onBlur="return checkHour(this, document.form1.mm40, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm40" type="text" class="form-control" id="mm40" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime20, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss40, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss40', event)" onBlur="return checkMinute(this, document.form1.ss40, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss40" type="text" class="form-control" id="ss40" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime20, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh41, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh41', event)" onBlur="return checkMinute(this, document.form1.hh41, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime20" id="hidtime20" value="<%= maxTime20 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 21 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh41" type="text" class="form-control" id="hh41" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime21, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm41, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm41', event)" onBlur="return checkHour(this, document.form1.mm41, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm41" type="text" class="form-control" id="mm41" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime21, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss41, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss41', event)" onBlur="return checkMinute(this, document.form1.ss41, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss41" type="text" class="form-control" id="ss41" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime21, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh42, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh42', event)" onBlur="return checkMinute(this, document.form1.hh42, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh42" type="text" class="form-control" id="hh42" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime21, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm42, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm42', event)" onBlur="return checkHour(this, document.form1.mm42, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm42" type="text" class="form-control" id="mm42" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime21, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss42, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss42', event)" onBlur="return checkMinute(this, document.form1.ss42, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss42" type="text" class="form-control" id="ss42" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime21, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh43, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh43', event)" onBlur="return checkMinute(this, document.form1.hh43, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime21" id="hidtime21" value="<%= maxTime21 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 22 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh43" type="text" class="form-control" id="hh43" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime22, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm43, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm43', event)" onBlur="return checkHour(this, document.form1.mm43, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm43" type="text" class="form-control" id="mm43" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime22, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss43, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss43', event)" onBlur="return checkMinute(this, document.form1.ss43, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss43" type="text" class="form-control" id="ss43" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime22, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh44, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh44', event)" onBlur="return checkMinute(this, document.form1.hh44, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh44" type="text" class="form-control" id="hh44" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime22, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm44, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm44', event)" onBlur="return checkHour(this, document.form1.mm44, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm44" type="text" class="form-control" id="mm44" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime22, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss44, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss44', event)" onBlur="return checkMinute(this, document.form1.ss44, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss44" type="text" class="form-control" id="ss44" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime22, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh45, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh45', event)" onBlur="return checkMinute(this, document.form1.hh45, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime22" id="hidtime22" value="<%= maxTime22 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 23 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh45" type="text" class="form-control" id="hh45" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime23, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm45, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm45', event)" onBlur="return checkHour(this, document.form1.mm45, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm45" type="text" class="form-control" id="mm45" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime23, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss45, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss45', event)" onBlur="return checkMinute(this, document.form1.ss45, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss45" type="text" class="form-control" id="ss45" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime23, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh46, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh46', event)" onBlur="return checkMinute(this, document.form1.hh46, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh46" type="text" class="form-control" id="hh46" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime23, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm46, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm46', event)" onBlur="return checkHour(this, document.form1.mm46, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm46" type="text" class="form-control" id="mm46" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime23, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss46, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss46', event)" onBlur="return checkMinute(this, document.form1.ss46, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss46" type="text" class="form-control" id="ss46" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime23, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh47, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh47', event)" onBlur="return checkMinute(this, document.form1.hh47, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime23" id="hidtime23" value="<%= maxTime23 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 24 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh47" type="text" class="form-control" id="hh47" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime24, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm47, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm47', event)" onBlur="return checkHour(this, document.form1.mm47, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm47" type="text" class="form-control" id="mm47" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime24, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss47, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss47', event)" onBlur="return checkMinute(this, document.form1.ss47, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss47" type="text" class="form-control" id="ss47" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime24, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh48, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh48', event)" onBlur="return checkMinute(this, document.form1.hh48, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh48" type="text" class="form-control" id="hh48" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime24, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm48, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm48', event)" onBlur="return checkHour(this, document.form1.mm48, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm48" type="text" class="form-control" id="mm48" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime24, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss48, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss48', event)" onBlur="return checkMinute(this, document.form1.ss48, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss48" type="text" class="form-control" id="ss48" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime24, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh49, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh49', event)" onBlur="return checkMinute(this, document.form1.hh49, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime24" id="hidtime24" value="<%= maxTime24 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 25 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh49" type="text" class="form-control" id="hh49" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime25, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm49, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm49', event)" onBlur="return checkHour(this, document.form1.mm49, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm49" type="text" class="form-control" id="mm49" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime25, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss47, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss49', event)" onBlur="return checkMinute(this, document.form1.ss47, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss49" type="text" class="form-control" id="ss49" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime25, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh50, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh50', event)" onBlur="return checkMinute(this, document.form1.hh50, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh50" type="text" class="form-control" id="hh50" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime25, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm50, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm50', event)" onBlur="return checkHour(this, document.form1.mm50, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm50" type="text" class="form-control" id="mm50" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime25, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss50, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss50', event)" onBlur="return checkMinute(this, document.form1.ss50, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss50" type="text" class="form-control" id="ss50" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime25, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh51, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh51', event)" onBlur="return checkMinute(this, document.form1.hh51, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime25" id="hidtime25" value="<%= maxTime25 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 26</label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh51" type="text" class="form-control" id="hh51" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime26, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm51, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm51', event)" onBlur="return checkHour(this, document.form1.mm51, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm51" type="text" class="form-control" id="mm51" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime26, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss51, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss51', event)" onBlur="return checkMinute(this, document.form1.ss51, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss51" type="text" class="form-control" id="ss51" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime26, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh52, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh52', event)" onBlur="return checkMinute(this, document.form1.hh52, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh52" type="text" class="form-control" id="hh52" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime26, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm52, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm52', event)" onBlur="return checkHour(this, document.form1.mm52, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm52" type="text" class="form-control" id="mm52" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime26, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss52, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss52', event)" onBlur="return checkMinute(this, document.form1.ss52, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss52" type="text" class="form-control" id="ss52" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime26, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh53, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh53', event)" onBlur="return checkMinute(this, document.form1.hh53, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime26" id="hidtime26" value="<%= maxTime26 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 27 </label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh53" type="text" class="form-control" id="hh53" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime27, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm53, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm53', event)" onBlur="return checkHour(this, document.form1.mm53, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm53" type="text" class="form-control" id="mm53" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime27, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss53, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss53', event)" onBlur="return checkMinute(this, document.form1.ss53, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss53" type="text" class="form-control" id="ss53" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime27, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh54, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh54', event)" onBlur="return checkMinute(this, document.form1.hh54, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh54" type="text" class="form-control" id="hh54" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime27, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm54, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm54', event)" onBlur="return checkHour(this, document.form1.mm54, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm54" type="text" class="form-control" id="mm54" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime27, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss54, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss54', event)" onBlur="return checkMinute(this, document.form1.ss54, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss54" type="text" class="form-control" id="ss54" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime27, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh55, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh55', event)" onBlur="return checkMinute(this, document.form1.hh55, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime27" id="hidtime27" value="<%= maxTime20 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 28</label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh55" type="text" class="form-control" id="hh55" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime28, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm55, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm55', event)" onBlur="return checkHour(this, document.form1.mm55, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm55" type="text" class="form-control" id="mm55" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime28, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss55, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss55', event)" onBlur="return checkMinute(this, document.form1.ss55, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss55" type="text" class="form-control" id="ss55" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime28, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh56, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh56', event)" onBlur="return checkMinute(this, document.form1.hh56, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh56" type="text" class="form-control" id="hh56" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime28, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm56, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm56', event)" onBlur="return checkHour(this, document.form1.mm56, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm56" type="text" class="form-control" id="mm56" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime28, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss56, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss56', event)" onBlur="return checkMinute(this, document.form1.ss56, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss56" type="text" class="form-control" id="ss56" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime28, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh57, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh57', event)" onBlur="return checkMinute(this, document.form1.hh57, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime28" id="hidtime28" value="<%= maxTime28 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 29</label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh57" type="text" class="form-control" id="hh57" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime29, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm57, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm57', event)" onBlur="return checkHour(this, document.form1.mm57, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm57" type="text" class="form-control" id="mm57" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime29, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss57, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss57', event)" onBlur="return checkMinute(this, document.form1.ss57, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss57" type="text" class="form-control" id="ss57" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime29, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh58, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh58', event)" onBlur="return checkMinute(this, document.form1.hh58, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh58" type="text" class="form-control" id="hh58" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime29, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm58, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm58', event)" onBlur="return checkHour(this, document.form1.mm58, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm58" type="text" class="form-control" id="mm58" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime29, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss58, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss58', event)" onBlur="return checkMinute(this, document.form1.ss58, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss58" type="text" class="form-control" id="ss58" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime29, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh59, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh59', event)" onBlur="return checkMinute(this, document.form1.hh59, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime29" id="hidtime29" value="<%= maxTime29 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group">
                            <label class="control-label label-text-1 col-md-2"> <%= lb_timezone %> 30</label>
                            <div class="col-md-8">
                                <div class="row form-inline">
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh59" type="text" class="form-control" id="hh59" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime30, 1) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm59, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm59', event)" onBlur="return checkHour(this, document.form1.mm59, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm59" type="text" class="form-control" id="mm59" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime30, 2) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss59, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss59', event)" onBlur="return checkMinute(this, document.form1.ss59, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss59" type="text" class="form-control" id="ss59" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime30, 3) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh60, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh60', event)" onBlur="return checkMinute(this, document.form1.hh60, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> - </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="hh60" type="text" class="form-control" id="hh60" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime30, 4) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkHour(this, document.form1.mm60, '<%= msg_input_hour %>'); autofocus(this, 2, 'mm60', event)" onBlur="return checkHour(this, document.form1.mm60, '<%= msg_input_hour %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="mm60" type="text" class="form-control" id="mm60" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime30, 5) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.ss60, '<%= msg_input_minute %>'); autofocus(this, 2, 'ss60', event)" onBlur="return checkMinute(this, document.form1.ss60, '<%= msg_input_minute %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <label class="control-label col-xs-1 col-md-1" style="margin-left: 20px; margin-right: -25px; margin-top: 6px;"> : </label>
                                    <div class="col-xs-1 col-md-1">
                                        <input name="ss60" type="text" class="form-control" id="ss60" style="min-width: 50px; max-width: 50px;" maxlength="2" value="<%= getTimeSec(maxTime30, 6) %>" onKeyPress="IsValidNumber()" onKeyUp="return checkMinute(this, document.form1.hh1, '<%= msg_input_sec %>'); autofocus(this, 2, 'hh1', event)" onBlur="return checkMinute(this, document.form1.hh1, '<%= msg_input_sec %>'); return checkLengthPadL(this, 2, '0')">
                                    </div>
                                    <div class="col-xs-1 col-md-1">
                                        <input type="hidden" name="hidtime30" id="hidtime30" value="<%= maxTime30 %>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2"> </div>
                        </div> 
                        <div class="row form-group" style="margin-bottom: 0px;">
                            <div class="col-md-12" align="center"> 
                                <input type="button" class="btn btn-primary btn-sm button-shadow1 button-shadow2" id="btnok" value=" &nbsp; &nbsp; &nbsp; <%= btn_ok %> &nbsp; &nbsp; &nbsp; " onClick="ConfirmEditOutput4('module/act_timeonoutput4.jsp?action=edit', '<%= msg_confirmedit %>', '<%= msg_input_time1 %>', '<%= msg_chk_mistaketime1 %>', '<%= msg_input_time2 %>', '<%= msg_chk_mistaketime2 %>', '<%= msg_input_time3 %>', '<%= msg_chk_mistaketime3 %>', '<%= msg_input_time4 %>', '<%= msg_chk_mistaketime4 %>', '<%= msg_input_time5 %>', '<%= msg_chk_mistaketime5 %>', '<%= msg_input_time6 %>', '<%= msg_chk_mistaketime6 %>', '<%= msg_input_time7 %>', '<%= msg_chk_mistaketime7 %>', '<%= msg_input_time8 %>', '<%= msg_chk_mistaketime8 %>', '<%= msg_input_time9 %>', '<%= msg_chk_mistaketime9 %>', '<%= msg_input_time10 %>', '<%= msg_chk_mistaketime10 %>', '<%= msg_input_time11 %>', '<%= msg_chk_mistaketime11 %>', '<%= msg_input_time12 %>', '<%= msg_chk_mistaketime12 %>', '<%= msg_input_time13 %>', '<%= msg_chk_mistaketime13 %>', '<%= msg_input_time14 %>', '<%= msg_chk_mistaketime14 %>', '<%= msg_input_time15 %>', '<%= msg_chk_mistaketime15 %>', '<%=msg_input_time16 %>', '<%= msg_chk_mistaketime16 %>', '<%= msg_input_time17 %>', '<%= msg_chk_mistaketime17 %>', '<%= msg_input_time18 %>', '<%= msg_chk_mistaketime18 %>', '<%= msg_input_time19 %>', '<%= msg_chk_mistaketime19 %>', '<%= msg_input_time20 %>', '<%= msg_chk_mistaketime20 %>', '<%= msg_input_time21 %>', '<%= msg_chk_mistaketime21 %>', '<%= msg_input_time22 %>', '<%= msg_chk_mistaketime22 %>', '<%= msg_input_time23 %>', '<%= msg_chk_mistaketime23 %>', '<%= msg_input_time24 %>', '<%= msg_chk_mistaketime24 %>', '<%= msg_input_time25 %>', '<%= msg_chk_mistaketime25 %>', '<%= msg_input_time26 %>', '<%= msg_chk_mistaketime26 %>', '<%= msg_input_time27 %>', '<%= msg_chk_mistaketime27 %>', '<%= msg_input_time28 %>', '<%= msg_chk_mistaketime28 %>', '<%=msg_input_time29 %>', '<%= msg_chk_mistaketime29 %>', '<%= msg_input_time30 %>', '<%= msg_chk_mistaketime30 %>');"> &nbsp; 
                                <input type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" value=" &nbsp; &nbsp; &nbsp; <%= btn_cancel %> &nbsp; &nbsp; &nbsp; " onClick="location.href='data_timeonoutput4.jsp'">
                            </div>
                        </div> 
                        
<%  
            }   
            rs.close();
        }catch(SQLException e){
            out.println("<div class='alert alert-danger' role='alert'> SQL Exception :"+e.getMessage()+"</div>");       
        } 
    
    }
%>
                    </div>
                </div> 

                </form> 
                
            </div>
        </div>
        
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
        
        <div class="modal fade" id="myModalConfirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-toggle="modal" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog" role="document">
                <div class="modal-content alert-message alert-message-success">
                    <div class="modal-body" align="center">
                        <div class="table-responsive" style="border: 0px !important;" border="0"> 
                            <div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <span class="glyphicon glyphicon-floppy-saved alert-message-success" style="font-size: 50px;"> </span> </div>
                            <div class="col-xs-12 col-md-12" style="margin-bottom: 30px;"> <h4> <p id="text_confirm"> </p> </h4> </div>
                            <div class="col-xs-12 col-md-12" style="margin-bottom: 15px;"> 
                                <div class="col-xs-1 col-md-1"> </div>
                                <div class="col-xs-5 col-md-5">
                                    <button type="button" class="btn btn-success btn-sm button-shadow1 button-shadow2" onClick="Confirm_Button();" style="width: 100%;"> <%= btn_ok %> </button>
                                </div>
                                <div class="col-xs-5 col-md-5">
                                    <button type="button" class="btn btn-default btn-sm button-shadow1 button-shadow2" onClick="javascript: location.href = 'data_timeonoutput4.jsp';" style="width: 100%;"> <%= btn_cancel %> </button>
                                </div>
                                <div class="col-xs-1 col-md-1"> 
                                    <input type="hidden" id="text_url" name="text_url" readonly>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		
		<%	}	%>

        <jsp:include page="footer.jsp" flush="true"/>
        
    </body>
</html>

<%@ include file="../function/disconnect.jsp"%>