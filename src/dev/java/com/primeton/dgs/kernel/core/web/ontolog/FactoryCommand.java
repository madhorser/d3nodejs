package com.primeton.dgs.kernel.core.web.ontolog;

import java.net.URLEncoder;
import java.util.Enumeration;

/**
 * 抽象Command实现：跳转到factory.jsp。
 * @author user
 * @version 1.0 2009-7-7
 */
public class FactoryCommand extends AbstractCommand {

	/**
	 * factory 页面
	 */
	public static String FACTORY_PAGE = "/common/factory.jsp";
	
	/**
	 * forward参数key
	 */
	public static String FORWARD_PARAM = "forward";

	/**
	 * 实现跳转
	 */
	public String execute() throws Exception {
		String forward = request.getParameter(FORWARD_PARAM);
		if (forward == null) {
			forward = request.getQueryString();
		} else {
			String queryString = this.getQueryString();
			if (!"".equals(queryString)) {
				forward += (forward.indexOf('?')>=0 ? "&" : "?") + queryString;
			}
		}
		request.setAttribute("forwardUrl", forward);
		return FACTORY_PAGE;
	}
	
	/**
	 * 将查询参数重新整合
	 * @throws Exception 不支持的编码（默认使用UTF-8）
	 */
	protected String getQueryString() throws Exception {
		StringBuffer sb = new StringBuffer();
		Enumeration<?> names = request.getParameterNames();
		while (names.hasMoreElements()) {
			String name = (String) names.nextElement();
			if (FORWARD_PARAM.equals(name)){
				continue;
			}
			sb.append(sb.length() > 0 ? "&" : "").append(name).append("=");
			sb.append(URLEncoder.encode(request.getParameter(name), "UTF-8"));
		}
		return sb.toString();
	}

}