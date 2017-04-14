package com.primeton.dgs.kernel.core.web.ontolog;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 重定向URL
 * @author user
 * @version 2.2 2011-02-28
 */
public class RedirectCommand extends AppBaseDispatchCommand {

	public void init(HttpServletRequest request, HttpServletResponse response,
			ServletConfig servletConfig) throws Exception {
		super.init(request, response, servletConfig);
	}
	
	/**
	 * 跳转到系统主页
	 */
	public String execute() throws Exception {
		return WebViewer.MAIN_PAGE;
	}
	
}

