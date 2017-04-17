package com.primeton.dgs.ontology.app.web;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.primeton.dgs.ontology.service.TMdInstanceSegmentService;

//生产时候使用这个类
//import com.primeton.dgs.workspace.miws.core.web.AppDispatchCommand;
//开发时候为了方便使用这个类
import com.primeton.dgs.kernel.core.web.ontolog.AppDispatchCommand;

public class SegmentCommand  extends AppDispatchCommand{
	private TMdInstanceSegmentService tMdInstanceSegmentService;
	public void init(HttpServletRequest request, HttpServletResponse response,ServletConfig servletConfig) throws Exception {		
		super.init(request, response, servletConfig);
		// 配置Service
		tMdInstanceSegmentService = (TMdInstanceSegmentService) getSpringBean(TMdInstanceSegmentService.SPRING_NAME);
		System.err.println(tMdInstanceSegmentService);
	}
	
	/**
	 * 分词列表，返回页面
	 * 
	 * @throws Exception
	 *             网络I/O异常
	 */
	public String getPageList() throws Exception {
		String taskId = request.getParameter("taskId");
		if (StringUtils.isNotEmpty(taskId)) {
			// 目前暂时没有编辑操作
		}
		return "/app/ontology/segment/segment.jsp";
	}
}
