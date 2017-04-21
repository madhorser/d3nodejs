package com.primeton.dgs.ontology.app.web;

import java.util.List;
import java.util.Map;

import org.ansj.domain.Term;
import org.ansj.splitWord.analysis.ToAnalysis;

import com.primeton.dgs.ontology.pojos.ParameterMap;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;
import com.primeton.dgs.ontology.service.TMdInstanceSegmentService;
import com.primeton.dgs.ontology.service.TMdInstanceService;

public class SegmentTask  implements Runnable {
    
    private TMdInstanceService tMdInstanceService = null;
    private TMdInstanceSegmentService tMdInstanceSegmentService = null;
    
    public SegmentTask(TMdInstanceService tMdInstanceService, TMdInstanceSegmentService tMdInstanceSegmentService) {
        this.tMdInstanceService = tMdInstanceService;
        this.tMdInstanceSegmentService = tMdInstanceSegmentService;
    }
    
    public void run() {
        //
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
		row = tMdInstanceService.count(parameterMap);
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
			List<Map<String, Object>> list = tMdInstanceService.getList(parameterMap);
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
		row = tMdInstanceSegmentService.countByIds(parameterMap);
		pageCount = 20000;
		sum = (row - 1) / pageCount + 1;
		System.out.println(sum);
		for (long page = 0; page < sum; page++) {
			parameterMap = new ParameterMap("parentIds", ids,"start", page * pageCount,"limit", page * pageCount + pageCount);
			List<Map<String, Object>> list = tMdInstanceSegmentService.getListByids(parameterMap);
			System.err.println(sum + "<=======>" + page);
			//循环所有表分词
			for (Map<String, Object> map : list) {
				divideInsert(map,wordType,taskId);
				String tableIdString = map.get("instance_id")+"";
				parameterMap = new ParameterMap("parentIds", tableIdString,"start", page * pageCount,"limit", page * pageCount + pageCount);
				//循环所有column分词
				List<Map<String, Object>> columnList = tMdInstanceSegmentService.getListByids(parameterMap);
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
				tMdInstanceSegmentService.insert(tMdInstanceSegment);
			}
	}
}
