package com.service.dmc.sql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SQLManager {

	public Connection getConnection(String driver, String url, String user, String password) throws SQLException, ClassNotFoundException{
		Class.forName(driver);
		return DriverManager.getConnection(url, user, password);
	}

	
	public void tryLogin(QueryBean bean) {

		SQL sql = null;
		try {
			sql = new SQL(getConnection(bean.getDriver(),
					bean.getUrl(),
					bean.getUser(),
					bean.getPassword()));
			
		} catch (Throwable t) {
			bean.setSucces(false);
			bean.setMessage(t.getMessage());
		}
		
		close(sql);
	
	}
	
	public void doExecute(QueryBean bean) {
		
		if (bean.isDml()) {
			execute(bean);
		} else {
			executeUpdate(bean);
		}
	
	}

	private void execute(QueryBean bean) {

		SQL sql = null;
		try {
			sql = new SQL(getConnection(bean.getDriver(),
					bean.getUrl(),
					bean.getUser(),
					bean.getPassword()));
			
			sql.prepareStatement(bean.getQuery());
			bean.setMessage(sql.executeUpdate() + " data updated");
			
		} catch (Throwable t) {
			bean.setSucces(false);
			bean.setMessage(t.getMessage());
		}
		
		close(sql);

	}

	
	private void executeUpdate(QueryBean bean) {

		SQL sql = null;
		try {
			sql = new SQL(getConnection(bean.getDriver(),
					bean.getUrl(),
					bean.getUser(),
					bean.getPassword()));
			
			sql.prepareStatement(bean.getQuery());
			sql.executeQuery();
			
			ResultSetMetaData metaData = sql.getMetaData(); 
			int columnCount = metaData.getColumnCount();
			String[] columns = new String[columnCount];
			for (int i = 0; i < columns.length; i++) {
				columns[i] = metaData.getColumnName(i+1);
			}
			
			Object[] row = null;
			List<Object[]> data = new ArrayList<Object[]>();
			
			while(sql.next()){
				row = new Object[columnCount];
				for (int i = 0; i < columns.length; i++) {
					row[i] = sql.getObject(i+1);
				}
				data.add(row);
			}
			
			bean.setColumns(columns);
			bean.setData(data);
			
		} catch (Throwable t) {
			bean.setSucces(false);
			bean.setMessage(t.getMessage());
		}
		
		close(sql);
	}

	private void close(SQL sql){
		if(sql != null){
			sql.close();
		}
	}
	

}
