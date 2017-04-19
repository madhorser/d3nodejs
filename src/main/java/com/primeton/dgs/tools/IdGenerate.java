package com.primeton.dgs.tools;

import java.util.UUID;


/**
 * ID生成器
 * <p>
 * Copyright: Copyright (c) 2017年4月19日 下午5:34:34
 * <p>
 * Company: 普元信息技术股份有限公司
 * <p>
 * @version 1.0.0
 */
public class IdGenerate {

	public static String uuidGen() {
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		return uuid;
	}

}
