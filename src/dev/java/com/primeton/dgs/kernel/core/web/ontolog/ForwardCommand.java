package com.primeton.dgs.kernel.core.web.ontolog;

/**
 * 抽象Command实现：跳转。
 * 
 * @author dunkee
 * @version 1.0 2009-05-05
 */
public class ForwardCommand extends AbstractCommand {

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
		}
		if (forward != null && !forward.startsWith("/")) {
			forward = "/" + forward;
		}
		return forward;
	}

}