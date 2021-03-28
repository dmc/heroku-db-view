<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="com.service.dmc.util.ClassInspector"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
    ClassInspector inspector = new ClassInspector();
    Map<String, String> requestPrameters = inspector.inspect(request);
    Map<String, String> responsePrameters = inspector.inspect(response);
    Map<String, String> sessionPrameters = inspector.inspect(session);
    Map<String, String> contextParameters = inspector.inspect(application);
    Map<String, String> configParameters = inspector.inspect(config);
	
    Set<String> keys = null;
    Set<Object> systemKeys = null;
%>
   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">



<title>inspector</title>
</head>
<body>

<h1>System Parameters</h1>
<table>
<% 
systemKeys = System.getProperties().keySet();
for (Object key : systemKeys) {
    out.write("<tr><td>"+ key + "</td><td>" + System.getProperties().getProperty((String)key) + "</td></tr>");
}
%>
</table>

<h1>Request Parameters</h1>
<table>
<% 
keys = requestPrameters.keySet();
for (String key : keys) {
    out.write("<tr><td>"+ key + "</td><td>" + requestPrameters.get(key) + "</td></tr>");
}
%>
</table>

<h1>Response Parameters</h1>
<table>
<% 
keys = responsePrameters.keySet();
for (String key : keys) {
    out.write("<tr><td>"+ key + "</td><td>" + responsePrameters.get(key) + "</td></tr>");
}
%>
</table>

<h1>Context Parameters</h1>
<table>
<% 
keys = contextParameters.keySet();
for (String key : keys) {
    out.write("<tr><td>"+ key + "</td><td>" + contextParameters.get(key) + "</td></tr>");
}
%>
</table>

<h1>Config Parameters</h1>
<table>
<% 
keys = configParameters.keySet();
for (String key : keys) {
    out.write("<tr><td>"+ key + "</td><td>" + configParameters.get(key) + "</td></tr>");
}
%>
</table>

</body>
</html>