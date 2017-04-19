package test.com.primeton.dgs.ontology.dao;



import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.ansj.domain.Term;
import org.ansj.splitWord.analysis.ToAnalysis;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.primeton.dgs.ontology.dao.TMdInstanceDAO;
import com.primeton.dgs.ontology.dao.TMdInstanceSegmentDAO;
import com.primeton.dgs.ontology.dao.TSegmentTaskDAO;
import com.primeton.dgs.ontology.pojos.ParameterMap;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegmentVote;
//import com.primeton.dgs.ontology.pojos.TSegmentRealation;
import com.primeton.dgs.ontology.pojos.TSegmentTask;

public class TestTMdInstanceSegmentDAO extends BaseTestCase {
	
	@Autowired
	private TMdInstanceSegmentDAO tMdInstanceSegmentDAO;

	@Autowired
	private TMdInstanceDAO tMdInstanceDAO;
	
	@Autowired
	private TSegmentTaskDAO tSegmentTaskDAO;

	@Test
	@Ignore
	public void testGetList() {
		String a = "a";
		String b = "你";
		String c = "你好";
		System.err.println(a.length());
		System.err.println(b.length());
		System.err.println(c.length());

		long row = 112166;
		long pageCount = 20000;
		long sum = (row - 1) / pageCount + 1;
		System.out.println(sum);

		System.err.println(tMdInstanceSegmentDAO);
		List<Map<String, String>> list = tMdInstanceSegmentDAO.getInstanceNameList();
		for (Map<String, String> map : list) {
			for (String key : map.keySet()) {
				System.out.println("" + key + " = " + map.get(key));
			}
		}
	}

	@Test
	//@Ignore
	public void segmentWord() {
		//修改任务表的状态：任务表状态。
		TSegmentTask task = new TSegmentTask();
		//获取库名instance_id 全部分词或者部分库分词
		String taskId = "taskId";
		try {
			String schemaIds = "all";
			String wordType = "叹词";
			if(schemaIds.equals("all")){
				//insert("Column",wordType,taskId);
				insert("Table",wordType,taskId);
			}else {
				insertPart(schemaIds, wordType,taskId);
			}
			task.setStatus("4");
		}
		catch (Exception e) {
			task.setStatus("3");
			task.setTaskResult(e.getMessage());
			e.printStackTrace();
		}finally {
			task.setTaskId(taskId);
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
			task.setUpdateTime(df.format(new Date()));//获取当前系统时间
			tSegmentTaskDAO.updateStatus(task);
		}
		
	}
	
	/**
	 * 分词后入库
	 * @param type 分字段、表还是库
	 */
	public void insert(String type,String wordType,String taskId) {
		//Map<String, Object> parmap = new HashMap<String, Object>();
		//parmap.put("classid", "Column");
		// parmap.put("classid", "Table");
		// parmap.put("classid", "Schema");
		long row = 501;
		long pageCount = 20;
		long sum = (row - 1) / pageCount + 1;
		System.out.println(sum);
		Map<Object, Object> parameterMap = new ParameterMap("classifierId", type);
		row = tMdInstanceDAO.count(parameterMap);
		pageCount = 20000;
		sum = (row - 1) / pageCount + 1;
		System.out.println(sum);
		for (long page = 0; page < sum; page++) {
			parameterMap = new ParameterMap("classifierId", type,"start", page * pageCount,"limit", page * pageCount + pageCount);
			//parmap.put("start", page * pageCount);
			//parmap.put("limit", page * pageCount + pageCount);
			//parmap.put("classid", "Column");
			// parmap.put("classid", "Table");
			 //parmap.put("classid", "Schema");
			// parmap.put("classid", "S");
			List<Map<String, Object>> list = tMdInstanceDAO.getList(parameterMap);
			System.err.println(sum + "<=======>" + page);
			for (Map<String, Object> map : list) {
				divideInsert(map,wordType,taskId);
			}
		}
	}
	/**
	 * 分词后入库
	 * @param type 分字段、表还是库
	 */
	public void insertPart(String ids,String wordType,String taskId) {

		long row = 501;
		long pageCount = 20;
		long sum = (row - 1) / pageCount + 1;
		System.out.println(sum);
		
		/*
		 * select * from T_MD_INSTANCE where parent_id in('v46d9820eff311e19ca9fa042f8ce8e9')
			union all
			select * from T_MD_INSTANCE where parent_id in(
			select instance_id from T_MD_INSTANCE where parent_id in('v46d9820eff311e19ca9fa042f8ce8e9'));
		 */
		Map<Object, Object> parameterMap = new ParameterMap("parentIds", ids);
		row = tMdInstanceDAO.countByIds(parameterMap);
		pageCount = 20000;
		sum = (row - 1) / pageCount + 1;
		System.out.println(sum);
		for (long page = 0; page < sum; page++) {
			parameterMap = new ParameterMap("parentIds", ids,"start", page * pageCount,"limit", page * pageCount + pageCount);
			List<Map<String, Object>> list = tMdInstanceDAO.getListByids(parameterMap);
			System.err.println(sum + "<=======>" + page);
			//循环所有表分词
			for (Map<String, Object> map : list) {
				divideInsert(map,wordType,taskId);
				String tableIdString = map.get("instance_id")+"";
				parameterMap = new ParameterMap("parentIds", tableIdString,"start", page * pageCount,"limit", page * pageCount + pageCount);
				//循环所有column分词
				List<Map<String, Object>> columnList = tMdInstanceDAO.getListByids(parameterMap);
				for (Map<String, Object> columnMap : columnList) {
					divideInsert(columnMap,wordType,taskId);
				}
			}
		}
	}
	//筛选分词并入库
	public void divideInsert(Map<String, Object> map,String wordType,String taskId){
			List<Term> list1 = ToAnalysis.parse(map.get("INSTANCE_NAME") + "").getTerms();
			//List<Term> list1 = ToAnalysis.parse(map.get("INSTANCE_CODE") + "").getTerms();
			for (Term term : list1) {
				// 分词规则
				String nature = term.getNatureStr();
				String chinese = partSpeach(nature);
				//筛选规则
				if(chinese.equals(wordType)){
					continue;
				}
				//term.
				if (term.getName().length() == 1)
					continue;
				if (term.getName().equals("_") || term.getName().equals("id") || term.getName().equals("is"))
					continue;
				TMdInstanceSegment tMdInstanceSegment = new TMdInstanceSegment();
				tMdInstanceSegment.setSegmentWord(term.getName());
				String instanceId = map.get("INSTANCE_ID") + "";
				tMdInstanceSegment.setInstanceId(instanceId);
				String instanceCode = map.get("INSTANCE_CODE") + "";
				tMdInstanceSegment.setInstanceCode(instanceCode);
				String instanceName = map.get("INSTANCE_NAME") + "";
				tMdInstanceSegment.setInstanceName(instanceName);
				String classifierId = map.get("CLASSIFIER_ID") + "map";
				tMdInstanceSegment.setClassifierId(classifierId);
				String namespace = map.get("NAMESPACE") + "";
				tMdInstanceSegment.setNamespace(namespace);
				String parentId = map.get("PARENT_ID") + "";
				tMdInstanceSegment.setParentId(parentId);
				tMdInstanceSegment.setNature(nature);
				tMdInstanceSegment.setChinese(chinese);
				tMdInstanceSegment.setTaskId(taskId);
				tMdInstanceSegmentDAO.insert(tMdInstanceSegment);
			}
	}
	/*
	 * 获取对应关系
	 */
	public String partSpeach(String type) {
		if(type.equals("a")){
			return "形容词";
		}
		if(type.equals("ad")){
			return "副形词";
		}
		if(type.equals("Ag")){
			return "形语素";
		}
		if(type.equals("an")){
			return "名形词";
		}
		if(type.equals("Bg")){
			return "区别语素";
		}
		if(type.equals("b")){
			return "区别词";
		}
		if(type.equals("c")){
			return "连词";
		}
		if(type.equals("Dg")){
			return "副语素";
		}
		if(type.equals("d")){
			return "副词";
		}
		if(type.equals("e")){
			return "叹词";
		}
		if(type.equals("f")){
			return "方位词";
		}
		if(type.equals("h")){
			return "前接成分";
		}
		if(type.equals("i")){
			return "成语";
		}
		if(type.equals("j")){
			return "简称略语";
		}
		if(type.equals("k")){
			return "后接成分";
		}
		if(type.equals("l")){
			return "习用语";
		}
		if(type.equals("Mg")){
			return "数语素";
		}
		if(type.equals("m")){
			return "数词";
		}
		if(type.equals("Ng")){
			return "名语素";
		}
		if(type.equals("n")){
			return "名词";
		}
		if(type.equals("nr")){
			return "人名";
		}
		if(type.equals("ns")){
			return "地名";
		}
		if(type.equals("nt")){
			return "机构团体";
		}
		if(type.equals("nx")){
			return "外文字符";
		}
		if(type.equals("nz")){
			return "其他专名";
		}
		if(type.equals("o")){
			return "拟声词";
		}
		if(type.equals("p")){
			return "介词";
		}
		if(type.equals("q")){
			return "量词";
		}
		if(type.equals("Rg")){
			return "代语素";
		}
		if(type.equals("r")){
			return "代词";
		}
		if(type.equals("s")){
			return "处所词";
		}
		if(type.equals("Tg")){
			return "时语素";
		}
		if(type.equals("t")){
			return "时间词";
		}
		if(type.equals("u")){
			return "助词";
		}
		if(type.equals("Vg")){
			return "动语素";
		}
		if(type.equals("v")){
			return "动词";
		}
		if(type.equals("vd")){
			return "副动词";
		}
		if(type.equals("vn")){
			return "名动词";
		}
		if(type.equals("w")){
			return "标点符号";
		}
		if(type.equals("z")){
			return "状态词";
		}
		if(type.equals("en")){
			return "字母或英文";
		}
		return "无法识别";
	}
	/**
	 * 根据分词数据选举出库和表本体分词
	 */
	@Test
	@Ignore
	public void voteOntology() {
		voteOntology("Schemamap", "Tablemap");
		System.out.println("==        分割线         ==");
		voteOntology("Tablemap", "Columnmap");
		// 插入字段分词明细
	}

	public void voteOntology(String classifierType, String classifierChildType) {
		// 查出库的分词
		Map<String, Object> parmap = new HashMap<String, Object>();
		parmap.put("classifierId", classifierType);
		List<Map<String, Object>> schemaList = tMdInstanceSegmentDAO.getSegmentWord(null);
		// 循环表的分词找到次数
		String schemaName = "";
		long maxTimes = 0;// 库分词出现最大次数
		long times = 0;// 库分词出现次数
		String maxTimesObject = "";
		String maxTimesName = "";
		// String maxTimesId = "";
		List<Map<String, Object>> tableList = new ArrayList<Map<String, Object>>();
		// 选出库内所有表最大的分词出现次数 Map<String, Object> schemaMap : schemaList
		for (int i = 0; i < schemaList.size(); i++) {
			// 数据库分词
			String schemaWord = schemaList.get(i).get("SEGMENT_WORD") + "";
			String newSchemaName = schemaList.get(i).get("INSTANCE_NAME") + "";
			String newInstanceId = schemaList.get(i).get("INSTANCE_ID") + "";
			String parentId = schemaList.get(i).get("PARENT_ID") + "";
			// 新schema统计，统计指标初始化
			if (!schemaName.equals(newSchemaName)) {
				// 非第一次统计
				System.out.println("+++schemaName+++++" + schemaName);
				if (!schemaName.equals("")) {
					if (maxTimes == 0) {
						maxTimesName = schemaName;
					}
					mostTimesTableSegment(maxTimes, maxTimesObject, maxTimesName, classifierChildType, newInstanceId, parentId, classifierType);
				}
				schemaName = newSchemaName;
				// instanceId = newInstanceId;
				maxTimes = 0;
				times = 0;
				maxTimesObject = "";
				maxTimesName = "";
				// maxTimesId = "";
				parmap.put("classifierId", classifierChildType);
				parmap.put("parentId", schemaList.get(i).get("INSTANCE_ID"));
				tableList = tMdInstanceSegmentDAO.getSegmentWordByParentId(null);
			}
			for (int j = 0; j < tableList.size(); j++) {
				// 一张表多个分词
				String tableWord = tableList.get(j).get("SEGMENT_WORD") + "";
				// 如果出现新的表分词,结束现有统计，并初始化新一轮统计
				if (schemaWord.equals(tableWord)) {
					times++;
				}
			}
			if (times > maxTimes) {
				maxTimes = times;
				times = 0;
				maxTimesObject = schemaWord;
				maxTimesName = schemaName;
			}
			// 避免最后一次打印失败
			if (i == schemaList.size() - 1) {
				if (maxTimes == 0) {
					maxTimesName = schemaName;
				}
				mostTimesTableSegment(maxTimes, maxTimesObject, maxTimesName, classifierChildType, newInstanceId, parentId, classifierType);
			}
		}
	}

	public void mostTimesTableSegment(long maxTimes, String maxTimesObject, String maxTimesName, String classifierChildType, String instanceId,
	        String parentId, String classifierType) {
		// 没有出现，从表分词中选出出现最多次数的词
		if (maxTimes == 0) {
			Map<String, Object> parmap = new HashMap<String, Object>();
			// "Tablemap"
			parmap.put("classifierId", classifierChildType);
			parmap.put("schemaName", maxTimesName);
			List<Map<String, Object>> tableList = tMdInstanceSegmentDAO.getMostTimeSegmentWord(null);
			if (tableList.size() > 0) {
				// MAXTIMES,SEGMENT_WORD
				maxTimesObject = tableList.get(0).get("SEGMENT_WORD") + "";
				maxTimes = Long.parseLong(tableList.get(0).get("MAXTIMES") + "");
			}
		}
		// 正推反推都取不出本体
		if (maxTimes == 0) {
			return;
		} else {
			// 入库操作
			// instanceId},#{classifierId},#{parentId},#{segmentWord
			TMdInstanceSegmentVote vote = new TMdInstanceSegmentVote();
			System.out.println("==maxTimes==" + maxTimes);
			System.out.println("==maxTimesWord==" + maxTimesObject);
			System.out.println("==maxTimesName==" + maxTimesName);
			System.out.println("==instanceId==" + instanceId);
			System.out.println("==parentId==" + parentId);
			System.out.println("==classifierId==" + classifierType);
			vote.setClassifierId(classifierType);
			vote.setInstanceId(instanceId);
			vote.setParentId(parentId);
			vote.setSegmentWord(maxTimesObject);
			tMdInstanceSegmentDAO.insertSegmentVote(vote);
		}
	}

	@Test
	@Ignore
	public void getListSchemaCateGoryAll() {
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		Map<String, Object> parmap = new HashMap<String, Object>();
		parmap.put("pid", "1=1");

		List<Map<String, Object>> list = tMdInstanceSegmentDAO.getList(null);

		for (Map<String, Object> map : list) {
			uuid = UUID.randomUUID().toString().replaceAll("-", "");
			parmap = new HashMap<String, Object>();
			parmap.put("id", uuid);
			// INSTANCE_ID = #{sid} and CLASSIFIER_ID = #{scid} and PARENT_ID =
			// #{pid} and SEGMENT_WORD PARENT_ID = #{ssw}
			for (String key : map.keySet()) {
				System.out.println("" + key + " = " + map.get(key));
				if (key.equals("INSTANCE_ID")) {
					parmap.put("sid", map.get(key));
				}
				if (key.equals("CLASSIFIER_ID")) {
					parmap.put("scid", map.get(key));
				}
				if (key.equals("PARENT_ID")) {
					parmap.put("pid", map.get(key));
				}
				if (key.equals("SEGMENT_WORD")) {
					parmap.put("ssw", map.get(key));
				}
			}
			System.err.println(parmap);
			tMdInstanceSegmentDAO.updateids(null);

		}
	};
	
}
