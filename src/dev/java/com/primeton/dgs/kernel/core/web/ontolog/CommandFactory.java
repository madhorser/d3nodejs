package com.primeton.dgs.kernel.core.web.ontolog;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * CommandFactory，Web转发及业务处理类工厂，通过context-web.xml配置于Spring文件中
 * 
 * @author user
 * @version 1.0 2009-08-08
 */
public class CommandFactory implements ApplicationContextAware {

	/**
	 * Spring上下文
	 */
	private ApplicationContext applicationContext;
	
	private static CommandFactory instance = new CommandFactory();
	
	private CommandFactory() {
		super();
	}
	
	public static CommandFactory getInstance() {
		return instance;
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see org.springframework.context.ApplicationContextAware
	 * #setApplicationContext(org.springframework.context.ApplicationContext)
	 */
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		this.applicationContext = applicationContext;
	}

	/**
	 * 根据cmd获取Command实例
	 * 
	 * @param cmd
	 *            命令类名称
	 * @return AbstractCommand实例
	 * @throws Exception
	 */
	public AbstractCommand getCommand(String cmd) throws Exception {
		if (cmd != null && cmd.startsWith("/")) {
			cmd = cmd.substring(1);
		}
		if (!this.applicationContext.containsBean(cmd)) {
			throw new IllegalStateException("没有定义名为" + cmd + "的Command.");
		}
		return (AbstractCommand) this.applicationContext.getBean(cmd);
	}

}
