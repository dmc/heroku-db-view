<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="com.service.dmc.sql.QueryBean"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! private static String escapeHtml( String str ) {
    if(str==null) {
        return str;
    }
    str = str.replaceAll("&" , "&amp;" );
    str = str.replaceAll("<" , "&lt;"  );
    str = str.replaceAll(">" , "&gt;"  );
    str = str.replaceAll("\"", "&#92;&quot;");
    str = str.replaceAll("'" , "&#39;" );
    
    return str;
 }
%>

<% QueryBean bean = (QueryBean) request.getAttribute("bean"); 

    @SuppressWarnings("unchecked")
    Map<String, ArrayList<String>> map = (Map<String, ArrayList<String>>) getServletContext().getAttribute("sql-history");
    if( map == null) {
        return;
    }
    ArrayList<String> list = map.get(bean.getUrl());
    if( list == null) {
        return;
    }

    String escaped = null;
    out.println("<table>");
    for (String s : list) {
        out.print("<tr><td nowrap>");
        escaped = escapeHtml(s);
        out.print("<span style='cursor: pointer' onclick='$(\"#sql\").val(\""+ escaped + "\")'>" + s + "</span>");
        out.println("</td></tr>");
    }
     out.println("</table>");

%>