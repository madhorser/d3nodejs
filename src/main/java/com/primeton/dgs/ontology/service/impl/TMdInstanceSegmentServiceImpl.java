package com.primeton.dgs.ontology.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.ansj.splitWord.analysis.ToAnalysis;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.primeton.dgs.ontology.dao.TMdInstanceSegmentDAO;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;
import com.primeton.dgs.ontology.service.TMdInstanceSegmentService;

/**
 * @author bigdata 首先删除已有分词表内容-删除之前是否需要备份？ 查询元数据表instance_name等信息，然后进行分词，然后进行保持
 */
@Service("tMdInstanceSegmentService")
public class TMdInstanceSegmentServiceImpl implements TMdInstanceSegmentService {

	@Autowired
	@Qualifier("tMdInstanceSegmentDAO")
	private TMdInstanceSegmentDAO tMdInstanceSegmentDAO;

	@Override
	public List<TMdInstanceSegment> DealSegment() {
		System.err.println(tMdInstanceSegmentDAO);
		// 查询结果
		List<Map<String, String>> instanceNameList = tMdInstanceSegmentDAO.getInstanceNameList();
		// 为空直接返回
		if (null == instanceNameList) {
			return null;
		}

		// 分词
		// instance_id,instance_code,instance_name,classifier_id,namespace,segment_word
		List<TMdInstanceSegment> instanceSegmentList = new ArrayList<TMdInstanceSegment>();
		for (int i = 0; i < instanceNameList.size(); i++) {
			TMdInstanceSegment tMdInstanceSegment = new TMdInstanceSegment();
			String segmentWord = ToAnalysis.parse(instanceNameList.get(i).get("SEGMENT_WORD")).toString();
			tMdInstanceSegment.setSegmentWord(segmentWord);
			String instanceId = instanceNameList.get(i).get("INSTANCE_ID");
			tMdInstanceSegment.setInstanceId(instanceId);
			String instanceCode = instanceNameList.get(i).get("INSTANCE_CODE");
			tMdInstanceSegment.setInstanceCode(instanceCode);
			String instanceName = instanceNameList.get(i).get("INSTANCE_NAME");
			tMdInstanceSegment.setInstanceName(instanceName);
			String classifierId = instanceNameList.get(i).get("CLASSIFIER_ID");
			tMdInstanceSegment.setClassifierId(classifierId);
			String namespace = instanceNameList.get(i).get("NAMESPACE");
			tMdInstanceSegment.setNamespace(namespace);
			instanceSegmentList.add(tMdInstanceSegment);
		}
		// 保存
		return instanceSegmentList;
	}

	@Override
	public List<Map<String, Object>> getListCateGoryByName(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getListCateGoryByName(map);
	}

	@Override
	public List<Map<String, Object>> getListTable(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getListTable(map);
	}

	@Override
	public List<Map<String, Object>> getListCateGory(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getListCateGory(map);
	}

	@Override
	public List<Map<String, Object>> getListCateGoryMod(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getListCateGoryMod(map);
	}

	@Override
	public long count(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.count(map);
	}

	@Override
	public List<Map<String, Object>> getListCateGoryByNameForPge(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getListCateGoryByNameForPge(map);
	}

	@Override
	public long countbyname(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.countbyname(map);
	}

	@Override
	public List<Map<String, Object>> getListTableForIn(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getListTableForIn(map);
	}

	@Override
	public void update(Map<Object,Object> map) {
		tMdInstanceSegmentDAO.update(map);
	}

	@Override
	public List<Map<String, Object>> getList(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getList(map);
	}

	@Override
	public void updateids(Map<Object,Object> map) {
		tMdInstanceSegmentDAO.updateids(map);
	}


	@Override
	public List<Map<String, Object>> getListPage(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getListPage(map);
	}



	@Override
	public List<Map<String, Object>> getSegmentVoteList(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getSegmentVoteList(map);
	}

	@Override
	public List<Map<String, Object>> getRealationListPage(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getRealationListPage(map);
	}

	@Override
	public List<Map<String, Object>> getTopLevelListPage(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getTopLevelListPage(map);
	}

	@Override
	public List<Map<String, Object>> getTopRealationListPage(Map<Object,Object> map) {
		return tMdInstanceSegmentDAO.getTopRealationListPage(map);
	}

}
