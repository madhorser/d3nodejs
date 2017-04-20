package test.com.primeton.dgs.ontology.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.primeton.dgs.ontology.dao.TSegmentTaskDAO;
import com.primeton.dgs.ontology.pojos.ParameterMap;
import com.primeton.dgs.ontology.pojos.TSegmentTask;
import com.primeton.dgs.tools.IdGenerate;

/**
 * 术语提取任务
 * <p>
 * Copyright: Copyright (c) 2017年4月19日 下午1:39:11
 * <p>
 * Company: 普元信息技术股份有限公司
 * <p>
 * 
 * @version 1.0.0
 */

public class SegmentTaskDao extends BaseTestCase {

	@Autowired
	private TSegmentTaskDAO tSegmentTaskDao;

	@Test
	@Ignore
	public void saveTask() {
		TSegmentTask task = new TSegmentTask();
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
		task.setInsertTime(df.format(new Date()));//获取当前系统时间
		task.setSegmentFrom("");
		task.setSegmentRule("");
		//等待执行
		task.setStatus("1");
		task.setTaskName("");
		task.setTaskId(IdGenerate.uuidGen());
		tSegmentTaskDao.insertSegmentTask(task);
	}
	/**
	 * 查询任务
	 */
	public List<Map<String, Object>> queryTask() {
		//查询等待执行的任务
		String status  = "1";
		Map<Object, Object> parameterMap = new ParameterMap("start", 0,"limit", 10,"status", status);
		List<Map<String, Object>> list = tSegmentTaskDao.queryTask(parameterMap);
		return list;
	}

}