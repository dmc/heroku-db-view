<%@page import="com.service.dmc.sql.QueryBean"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% QueryBean bean = (QueryBean) request.getAttribute("bean"); %>
<% if (!bean.isSucces()) {
	out.print("<label id='error'>" + bean.getMessage() + "</label>");
} else { %>

<table>
<tr>
<td>login database is <%= bean.getUrl() %></td>
</tr>
<tr>
</table>

<table>
<tr>
<td><textarea rows="6" cols="60" name="sql" id="sql"><%= bean.getQuery() %></textarea></td>
</tr>
</table>
<% } %>