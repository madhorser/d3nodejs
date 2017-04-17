package com.primeton.dgs.kernel.core.web.ontolog;

import java.io.File;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;

import com.primeton.dgs.kernel.core.common.Constant;
import com.primeton.dgs.kernel.core.ex.VerifyLicenseException;
import com.primeton.licensemanager.checklicense.LicenseCheckManager;

/**
 * 抽象Command实现。
 * @author user
 * @version 1.0 2009-7-7
 */
public abstract class AbstractCommand {

	public static final String MULTIPART = "multipart/";

	protected Logger log;

	protected HttpServletRequest request;

	protected HttpServletResponse response;

	protected ServletConfig servletConfig;

	protected HttpSession session;
	
	protected ServletFileUpload fileupload;

	/**
	 * 子类实现，具体的操作
	 */
	public abstract String execute() throws Exception;

	public AbstractCommand() {
		log = Logger.getLogger(this.getClass());
	}

	/**
	 * 是否带附件
	 * @return boolean
	 */
	protected boolean isMultipartRequest() {
		if (!"post".equals(request.getMethod().toLowerCase())) {
			return false;
		}
		String contentType = request.getContentType();
		if (contentType != null &&
				contentType.toLowerCase().startsWith(MULTIPART)) {
			return true;
		}
		return false;
	}

	/**
	 * 初始化。子类如果需要，覆盖。比如实现：initUcc等。
	 */
	public void init(HttpServletRequest request, HttpServletResponse response,
			ServletConfig servletConfig) throws Exception {
		this.request = request;
		this.response = response;
		this.servletConfig = servletConfig;
		this.session = request.getSession();
		if (isMultipartRequest()) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			factory.setRepository(getRepositoryDir());
			this.fileupload = new ServletFileUpload(factory);
			String charset = request.getCharacterEncoding();
			if (charset != null) {
				this.fileupload.setHeaderEncoding(charset);
			}
		}
		//verifyLicense("Server"); //also can get from request
	}
	
	/**
	 * 文件上传的编码
	 * @return file content Encoding
	 */
	protected String getFileUploadEncoding() {
		return this.fileupload.getHeaderEncoding();
	}
	
	// 创建上传文件临时目录
	private File getRepositoryDir() {
		File dir = new File(Constant.WEB_PATH + "/upload/repository");
		if (!dir.exists()) {
			dir.mkdirs();
		}
		return dir;
	}
	
	/**
	 * 校验License
	 * @param module 模块
	 * @return succuss or not
	 * @throws VerifyLicenseException
	 */
	public boolean verifyLicense(String module) throws VerifyLicenseException, Exception {
		//return VerifyManager.getInstance().verify(module);
		return LicenseCheckManager.getInstance().verify(module);
		//sreturn true;
	}
	
}
