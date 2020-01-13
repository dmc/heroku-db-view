package com.service.dmc.util;

import java.io.File;
import java.io.FileFilter;

public class CssFileFilter implements FileFilter{

	@Override
	public boolean accept(File pathname) {
		return pathname.getName().endsWith(".css");
	}

}
