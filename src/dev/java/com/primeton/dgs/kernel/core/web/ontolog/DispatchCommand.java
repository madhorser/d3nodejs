package com.primeton.dgs.kernel.core.web.ontolog;

import java.io.OutputStream;
import java.lang.reflect.Method;

/**
 * 抽象Command实现:分发
 * 
 * @author dunkee
 * @version 1.0 2009-7-7
 */
public class DispatchCommand extends AbstractCommand {

	/**
	 * 分发方法参数key, 用形如 invoke=method
	 */
	public static String INVOKE_PARAM = "invoke";
	public static String LOGIN_URL = "/login.do";
	public static String SHOW_LOGIN_URL = "/showlogin.do";
	public static String LOGOUT_URL = "/logout.do";

	/**
	 * 实现
	 */
	public String execute() throws Exception {
		String name = request.getParameter(INVOKE_PARAM);
		if (isMultipartRequest() && name == null) {
			log.error("Can not get paramter [" +INVOKE_PARAM+ "].");
		}
		if (name == null || "".equals(name.trim())) {
			name = this.retrieveFromUrl();
			if (name == null) {
				throw new IllegalArgumentException("must specify a method by ["+INVOKE_PARAM+"]");
			}
		}
		if ("execute".equals(name)) {
			throw new IllegalAccessException("can not call the method [execute]");
		}
		return (String) getMethod(name).invoke(this, (Object[])null);
	}
	
	protected String retrieveFromUrl() {
		String name = null;
		String str = request.getServletPath();
		log.info(str);
		if (LOGIN_URL.equals(request.getServletPath()) || SHOW_LOGIN_URL.equals(request.getServletPath())) {
			name = "login";
		} else if (LOGOUT_URL.equals(request.getServletPath())) {
			name = "logout";
		}
		return name;
	}

	/**
	 * 取方法
	 * 
	 * @param name
	 * @return Method
	 * @throws NoSuchMethodException
	 */
	protected Method getMethod(String name) throws NoSuchMethodException {
		Method[] ms = this.getClass().getMethods();
		for (int i = 0; i < ms.length; i++) {
			if (name.equalsIgnoreCase(ms[i].getName())) {
				return ms[i];
			}
		}
		throw new NoSuchMethodException("没有定义处理请求的方法：" + name);
	}

	protected void response(byte[] bytes) throws Exception {
		OutputStream os = response.getOutputStream();
		os.write(bytes);
		os.flush();
	}

	protected void response(String content) throws Exception {
		response(content.getBytes());
	}

}