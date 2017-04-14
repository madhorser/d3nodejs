package com.primeton.dgs.kernel.core.web.ontolog;

/*
 * Copyright 2009 by primedata Corporation. Address:TianChuang Technology Building, CaiHeFang 
 * Road,Haidian District, Beijing 
 * 
 * All rights reserved.
 * 
 * This software is the confidential and proprietary information of primedata
 * Corporation ("Confidential Information"). You shall not disclose such
 * Confidential Information and shall use it only in accordance with the terms
 * of the license agreement you entered into with primedata.
 */


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;

import com.primeton.dgs.kernel.core.common.ActionHelper;
import com.primeton.dgs.kernel.core.common.ActionResult;
import com.primeton.dgs.kernel.core.ex.VerifyLicenseException;
import com.primeton.dgs.kernel.core.util.ExUtils;
import com.primeton.licensemanager.checklicense.VerifyHLicenseException;

/**
 * mvc主控 Servlet
 * 
 * @author user
 * @version 1.0 2006-9-18
 */
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Logger log = Logger.getLogger(MainServlet.class);

	private static final String ENCODE = "UTF-8";

	/** Initialize global variables */
	public void init() throws ServletException {
		log.info("MainServlet init.");
	}

	/** Process the HTTP Get request */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		perform(request, response);
	}

	/** Process the HTTP Post request */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		perform(request, response);
	}

	/** Process the HTTP request */
	public void perform(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding(ENCODE);
		String next = "";

		try {
			String path = request.getServletPath();
			AbstractCommand cmd = CommandFactory.getInstance().getCommand(path);
			cmd.init(request, response, getServletConfig());

			next = cmd.execute();
			if (null != next) {
				dispatch(request, response, next);
			}
			return;

		} catch (VerifyHLicenseException e) {
			if (isExt(request)) {
				performOnError(request, response, e);
				return;
			}
			request.setAttribute("javax.servlet.jspException", e);
			dispatch(request, response, WebViewer.LICENSE_PAGE);
		} catch (Exception e) {
			log.error("MainServlet catch an error:", e);
			if (isExt(request)) {
				performOnError(request, response, e);
				return;
			}
			request.setAttribute("_CommandExecuteException_",
					ExUtils.getMessage(request, e));
			request.setAttribute("javax.servlet.jspException", e);
			dispatch(request, response, WebViewer.VIEW_ERROR);
		}

	}

	public void performOnError(HttpServletRequest request,
			HttpServletResponse response, Exception e) throws ServletException,
			IOException {
		String msg = ExUtils.getMessage(request, e);
		ActionResult rs = new ActionResult(false, msg);
		rs.put("list", new JSONArray());
		try {
			if (isReturnXml(request)) {
				ActionHelper.outputXmlList(response, null, 0, rs);
			} else {
				ActionHelper.output(response, rs);
			}
		} catch (Exception er) {
			throw new ServletException(er);
		}
	}

	private void dispatch(HttpServletRequest request,
			HttpServletResponse response, String page) throws ServletException,
			IOException {
		log.info("Command dispath request to: " + page);
		if (page.toLowerCase().startsWith("http:")
				|| page.toLowerCase().startsWith("https:")) {
			response.sendRedirect(page);
		} else {
			request.getRequestDispatcher(page).forward(request, response);
		}
	}

	private static boolean isExt(HttpServletRequest request) {
		return "Ext".equalsIgnoreCase(request.getHeader("Request-By"));
	}

	private static boolean isReturnXml(HttpServletRequest request) {
		return "XML".equalsIgnoreCase(request.getHeader("Response-By"));
	}

}

