package com.primeton.dgs.kernel.core.web.ontolog;

import com.primeton.dgs.kernel.core.common.MessageHelper;
import com.primeton.dgs.kernel.core.common.SpringContextHelper;

/**
 * 所有应用Command的父类
 * 
 * @author user
 * @version 1.0 2009-7-7
 */
public class AppBaseDispatchCommand extends DispatchCommand {

	public Object getSpringBean(String beanName) {
		return SpringContextHelper.getBean(beanName);
	}

	/**
	 * 获取定义在Spring配置文件里的messageSource的信息
	 */
	public String getMessage(String key) {
		return MessageHelper.getMessage(request, key);
		// return SpringContextHelper.getMessage(key, null);
	}

	/**
	 * 获取定义在Spring配置文件里的messageSource的信息
	 */
	public String getMessage(String key, Object[] args) {
		return MessageHelper.getMessage(request, key, args);
		// return SpringContextHelper.getMessage(key, args, null);
	}

	/**
	 * 获取定义在Spring配置文件里的messageSource的信息,如果没有找到则返回defualmsg
	 */
	public String getMessage(String key, Object[] args, String defualmsg) {
		return MessageHelper.getMessage(request, key, args);
		// return SpringContextHelper.getMessage(key, args, defualmsg);
	}

}