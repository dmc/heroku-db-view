package com.service.dmc.servlet;

import java.beans.XMLDecoder;
import java.beans.XMLEncoder;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class DbvServletContextListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent event) {

		saveSqlHistory(event);
	
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		loadCSS(event);
		loadSqlHistory(event);
	}
	
	private void loadCSS(ServletContextEvent event) {
		
	}

	@SuppressWarnings("unchecked")
	private void saveSqlHistory(ServletContextEvent event){

		
		XMLEncoder encoder = null;

		try {

			Map<String, ArrayList<String>> map = (Map<String, ArrayList<String>>) event
					.getServletContext().getAttribute("sql-history");
			
			if (map != null) {
				File f = new File(event.getServletContext().getRealPath(
						"/WEB-INF")
						+ "/sql-history.xml");
				
				if(f != null && f.exists()) {
					f.delete();
				}
				
				encoder = new XMLEncoder(new BufferedOutputStream(
						new FileOutputStream(f)));
				encoder.writeObject(map);
				encoder.flush();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		try {
			if (encoder != null) {
				encoder.close();
			}
		} catch (Exception ignore) {
		}
	}
	
	@SuppressWarnings("unchecked")
	private void loadSqlHistory(ServletContextEvent event){
		
		Map<String, ArrayList<String>> map = null;
		File f = new File(event.getServletContext().getRealPath(
							"/WEB-INF")
							+ "/sql-history.xml");
		if(f != null && f.exists()) {
			XMLDecoder decoder = null;
			try {

				decoder = new XMLDecoder(new BufferedInputStream(
						new FileInputStream(f)));
				map = (Map<String, ArrayList<String>>) decoder.readObject();
			} catch (Exception e) {
				e.printStackTrace();
			}

			try {
				if (decoder != null) {
					decoder.close();
				}
			} catch (Exception ignore) {
			}
		}

		event.getServletContext().setAttribute("sql-history", map);
	}
	

}
