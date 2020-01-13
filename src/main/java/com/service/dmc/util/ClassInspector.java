package com.service.dmc.util;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

public class ClassInspector {

	public Map<String, String> inspect(Object o){
		Map<String, String> result = new HashMap<String, String>();
		Method[] methods = o.getClass().getMethods();
		String methodName = null;
		String returnValue = null;
		for (Method method : methods) {
			methodName = method.getName();
			if (method.getParameterTypes().length == 0 && !method.getReturnType().equals(Void.TYPE)){
				try {
					returnValue = method.invoke(o).toString();
					result.put(methodName, returnValue);
				} catch (Exception e) {
					result.put(methodName, "invoked.but error:" + e.getMessage());
				}
			} else {
				result.put(methodName, "do not invoked");
			}
		}
		return result;
	}
	
}
