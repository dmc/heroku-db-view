
package com.service.dmc.sql;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

public class SQL {

	Connection connection = null;
	ResultSet result = null;
	PreparedStatement preparedStatement = null;
	
	public SQL(Connection connection) {
		this.connection = connection;
	}
	
	public void prepareStatement(String sql) throws SQLException {
		this.preparedStatement = connection.prepareStatement(sql);
	}
	
	public ResultSetMetaData getMetaData() throws SQLException {
		return preparedStatement.getMetaData();
	}
	
	public void executeQuery() throws SQLException {
		this.result = preparedStatement.executeQuery();
	}

	public int executeUpdate() throws SQLException {
		return preparedStatement.executeUpdate();
	}

	public Object getObject(int columnIndex) throws SQLException {
		return result.getObject(columnIndex);
	}
	public boolean next() throws SQLException{
		return result.next();
	}
	
	public void close() {
		try {
			if(result != null) result.close();
		} catch (Exception ignore) {}
		try {
			if(preparedStatement != null) preparedStatement.close();
		} catch (Exception ignore) {}
		try {
			if(connection != null) connection.close();
		} catch (Exception ignore) {}
	}
	
	
	
}
