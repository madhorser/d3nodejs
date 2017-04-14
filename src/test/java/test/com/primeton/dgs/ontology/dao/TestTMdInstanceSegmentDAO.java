package test.com.primeton.dgs.ontology.dao;

import java.util.ArrayList;
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
import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegmentVote;
//import com.primeton.dgs.ontology.pojos.TSegmentRealation;

public class TestTMdInstanceSegmentDAO extends BaseTestCase {

	@Autowired
	private TMdInstanceSegmentDAO tMdInstanceSegmentDAO;

	@Autowired
	private TMdInstanceDAO tMdInstanceDAO;

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
	public void insert() {
		Map<String, Object> parmap = new HashMap<String, Object>();
		// System.out.println(tMdInstanceDAO.count(parmap));
		parmap.put("classid", "Column");
		// parmap.put("classid", "Table");
		// parmap.put("classid", "Schema");
		long row = 501;
		long pageCount = 20;
		long sum = (row - 1) / pageCount + 1;
		System.out.println(sum);

		row = tMdInstanceDAO.count(parmap);
		pageCount = 20000;
		sum = (row - 1) / pageCount + 1;
		System.out.println(sum);
		for (long page = 0; page < sum; page++) {
			parmap.put("start", page * pageCount);
			parmap.put("limit", page * pageCount + pageCount);
			parmap.put("classid", "Column");
			// parmap.put("classid", "Table");
			 //parmap.put("classid", "Schema");
			// parmap.put("classid", "S");
			List<Map<String, Object>> list = tMdInstanceDAO.getList(null);
			System.err.println(sum + "<=======>" + page);
			for (Map<String, Object> map : list) {
				//List<Term> list1 = ToAnalysis.parse(map.get("INSTANCE_NAME") + "").getTerms();
				List<Term> list1 = ToAnalysis.parse(map.get("INSTANCE_CODE") + "").getTerms();
				for (Term term : list1) {
					// System.err.println(term.getName());
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
					tMdInstanceSegmentDAO.insert(tMdInstanceSegment);
				}
			}
		}
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
		List<Map<String, Object>> schemaList = tMdInstanceSegmentDAO.getSegmentWord(parmap);
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
				tableList = tMdInstanceSegmentDAO.getSegmentWordByParentId(parmap);
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
			List<Map<String, Object>> tableList = tMdInstanceSegmentDAO.getMostTimeSegmentWord(parmap);
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

		List<Map<String, Object>> list = tMdInstanceSegmentDAO.getList(parmap);

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
			tMdInstanceSegmentDAO.updateids(parmap);

		}
	};
	
}
