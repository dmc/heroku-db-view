<%@page import="com.service.dmc.util.CssFileFilter"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileFilter"%>
<%@page import="java.util.List"%>
<%@page import="com.service.dmc.sql.QueryBean"%>
<%@page import="com.service.dmc.util.CssFileFilter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	QueryBean bean = (QueryBean) request.getAttribute("bean");
	if(bean == null) {bean = new QueryBean();}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" language="javascript" src="<%= application.getContextPath() %>/javascript/jquery.js"></script>
<script type="text/javascript" language="javascript" src="<%= application.getContextPath() %>/javascript/jquery-ui.js"></script>
<link id="theme" rel="stylesheet" href="<%= application.getContextPath() %>/css/default.css">


<script language="JavaScript" type="text/javascript">

var presets = [
["","","","",""],
["postgres-heroku","org.postgresql.Driver","jdbc:postgresql://ec2-54-83-205-164.compute-1.amazonaws.com:5432/d9v6d5uqacptit","kyuljdoqfyziks","x9LvzxTGy8izs-7NFY30VDhqT0"],
["mysql-heroku","com.mysql.jdbc.Driver","jdbc:mysql://us-cdbr-iron-east-02.cleardb.net:3306/heroku_126abff0eac31c8","bf05d3bb2265c3","fc67f770"],
["mysql-heroku-information_schema","com.mysql.jdbc.Driver","jdbc:mysql://us-cdbr-iron-east-02.cleardb.net:3306/information_schema","bf05d3bb2265c3","fc67f770"],
["postgres-template","org.postgresql.Driver","jdbc:postgresql://localhost/db","user","password"],
["mysql-template","com.mysql.jdbc.Driver","jdbc:mysql://localhost/mysql","user","password"],
["oracle-template","oracle.jdbc.driver.OracleDriver","jdbc:oracle:thin:@host:port:db","user","password"]
 ];

var csspresets =
["default.css",
 "black.css",
 "orange.css",
 "dark.css",
 "blox.css",
 "bttf.css",
 "atari.css",
 "blox.css",
 "creep.css"];


jQuery(function ($) {

	for (var i = 0; i < presets.length; i++) {
		$("#preset").append($('<option>').html(presets[i][0]).val(i));
	}

	for (var i = 0; i < csspresets.length; i++) {
		var $option = $('<option>').html(csspresets[i]).val(csspresets[i]).attr('id',csspresets[i]);
		$("#css-list").append($('<option>').html(csspresets[i]).val(csspresets[i]));
	}



	$("#query-buttons").hide();

	$('#login').click(function() {

    	$("input[type='button']").prop("disabled",true);

    	$.ajax({
    		  url: "<%=application.getContextPath()%>/action",
    		  type: "post",
    		  data: {event: "login",driver: $('#driver').val(),url: $('#url').val(),user: $('#user').val(),password: $('#password').val()}
    		  }).done(function(data) {
            	$('#query-box').html(data);
    			if ($(data).filter('#error').size()){
    				$('#query-box').html(data);
              	} else {
                    $("#login-parameter").hide();
                  	$("#query-buttons").show();
              	}
              }).always(function() {
  		    	$("input[type='button']").prop("disabled",false);
	  		  });

       });

    $('#execute').click(function() {

    	$("input[type='button']").prop("disabled",true);

    	$.ajax({
    		  url: "<%= application.getContextPath() %>/action",
    		  type: "post",
    		  data: {event: "execute",driver: $('#driver').val(),url: $('#url').val(),user: $('#user').val(),password: $('#password').val(),query: $('#sql').val(),}
		  }).done(function(data) {
				$('#result').html(data);

		  }).always(function() {
		    	$("input[type='button']").prop("disabled",false);
	  	});
    });

	$('#history').click(function() {
    	$.ajax({
  		  url: "<%= application.getContextPath() %>/action",
  		  type: "post",
  		  data: {event: "history",driver: $('#driver').val(),url: $('#url').val(),user: $('#user').val(),password: $('#password').val(),query: $('#sql').val(),}
  		}).done(function(data) {
  			$('#dialog').html(data);
  			if($('#dialog').dialog("instance")){
  				$('#dialog').dialog();
  			}else {
  	  			$('#dialog').dialog({width: 500});
  			}
  		});
	});

	$('#exit').click(function() {
        $("#login-parameter").show();
      	$("#query-buttons").hide();
        $("#query-box").html("");
      	$("#result").html("");
		if($('#dialog').dialog("instance")){
	        $("#dialog").html("");
			$('#dialog').dialog("destroy");
		}
	});

});

function setParameter() {
	var value = $('#preset').val();
	$("#driver").val(presets[value][1]);
	$("#url").val(presets[value][2]);
	$("#user").val(presets[value][3]);
	$("#password").val(presets[value][4]);
};

function changeTheme() {
	$('#theme').attr("href","<%= application.getContextPath() %>/css/" + $("#css-list").val());
};

</script>

<title>db-view</title>
</head>
<body>

<div id="css-selector">
<table>
<tr>
<td>theme</td>
<td>
<select id="css-list" onchange="changeTheme()">
</select>
</td>
</tr>
</table>
<hr/>
</div>


<div id="header">
<table cellpadding="" class="header">
<tr>
<td align="left"><h1>db-view 3.0</h1></td>
</tr>
<tr>
<td align="right">buid on 9th June 2015.<br>developed by dmc system service.</td>
</tr>
</table>
<hr/>
</div>

<div id="login-parameter">
<table>
<tr>
<td>database</td>
<td>
<select id="preset" onchange="setParameter()">
</select>
</td>
</tr>
</table>
<table>
<tr>
<td>driver</td>
<td><input id="driver" name="driver" type="text" size="40pix" value="<%= bean.getDriver() %>"/></td>
</tr>
<tr>
<td>url</td>
<td><input id="url" name="url" type="text" size="40pix" value="<%= bean.getUrl() %>"/></td>
</tr>
<tr>
<td>user</td>
<td><input id="user" name="user" type="text" size="40pix" value="<%= bean.getUser() %>"/></td>
</tr>
<tr>
<td>password</td>
<td><input id="password" name="password" type="text" size="40pix" value="<%= bean.getPassword() %>"/></td>
</tr>
</table>
<input class="button" type="button" value="login" id="login"/>
<hr/>
</div>

<div id="query-box">
</div>
<div id="query-buttons">
<table>
<tr>
<td><input type="button" value="execute" id="execute"/></td>
<td><input type="button" value="history" id="history"/></td>
<td><input type="button" value="exit" id="exit"/></td>
</tr>
</table>
<hr/>
</div>

<div id="result">
</div>

<div id="dialog" title="history">
</div>


</body>
</html>
