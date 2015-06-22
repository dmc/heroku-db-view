package com.service.dmc.servlet;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.service.dmc.sql.QueryBean;
import com.service.dmc.sql.SQLManager;

public class DbvServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final String ENCODE = "UTF-8";
	private static final int HISTORY_SIZE = 30;
	private static final String LINE_SEPARATOR = System.getProperty("line.separator");
	private static final String LINE_SEPARATOR_REPLACEMENT = " ";
	
	private String getParameter(HttpServletRequest request,String key,String _default) {
		String ret = (String) request.getParameter(key);
		if(ret != null) {
			return ret;
		}
		return _default;
	}

	private String replaceLineSeparator(String query){
		
		return query.replaceAll(LINE_SEPARATOR, LINE_SEPARATOR_REPLACEMENT);
		
	}
	
	private QueryBean getSQLBean(HttpServletRequest request) {
		
		QueryBean bean = new QueryBean();
		
		bean.setEvent(getParameter(request, "event",""));
		bean.setDriver(getParameter(request, "driver",""));
		bean.setUrl(getParameter(request, "url",""));
		bean.setUser(getParameter(request, "user",""));
		bean.setPassword(getParameter(request, "password",""));
		bean.setQuery(getParameter(request, "query",""));
		
		return bean;
	}


	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		doExecute(req, resp);
	}

	public void doExecute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			req.setCharacterEncoding(ENCODE);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		


		QueryBean bean = getSQLBean(req);
		

		if("login".equals(bean.getEvent())){
		
			new SQLManager().tryLogin(bean);
			req.setAttribute("bean", bean);
			req.getRequestDispatcher("/sql.jsp").forward(req, resp);
			
		} else if ("execute".equals(bean.getEvent())) {
		
			new SQLManager().doExecute(bean);
			stackHistory(bean);
			req.setAttribute("bean", bean);
			req.getRequestDispatcher("/result.jsp").forward(req, resp);

		} else if ("history".equals(bean.getEvent())) {

			req.setAttribute("bean", bean);
			req.getRequestDispatcher("/history.jsp").forward(req, resp);

		} else {
			req.getRequestDispatcher("/index.jsp").forward(req, resp);
		}
		
	}
	
	private void stackHistory(QueryBean bean) {
		if(!bean.isSucces()){
			return;
		} 
		
		synchronized (this) {
			String url = bean.getUrl();
			String query = replaceLineSeparator(bean.getQuery());
			
			@SuppressWarnings("unchecked")
			Map<String, ArrayList<String>> map = (Map<String, ArrayList<String>>) getServletContext().getAttribute("sql-history");
			if( map == null) {
				map = new HashMap<String, ArrayList<String>>();
			}
			ArrayList<String> list = map.get(url);
			if (list == null) {
				list = new ArrayList<String>();
			}
			int index = list.indexOf(query);
			if( index != -1 ){
				query = list.remove(index);
			} else {
				if(list.size() > HISTORY_SIZE){
					list.remove(HISTORY_SIZE-1);
				}
			}
			
			list.add(0, query);
			
			map.put(url, list);
			getServletContext().setAttribute("sql-history",map);
		}

		
		
	}

}
