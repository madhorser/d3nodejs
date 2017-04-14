package com.primeton.dgs.ontology.dao;

import java.util.List;
import java.util.Map;

import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegmentVote;
import com.primeton.dgs.ontology.pojos.TSegmentRealation;

public interface TMdInstanceSegmentDAO {

    public List<Map<String, Object>> getListPage(Map<Object,Object> map);
	public List<Map<String, Object>> getListCateGoryMod(Map<Object,Object> map);

	public long countbyname(Map<Object,Object> map);

	public List<Map<String, Object>> getSegmentWord(Map<Object,Object> map);

	public List<Map<String, Object>> getSegmentWordByParentId(Map<Object,Object> map);

	public List<Map<String, Object>> getMostTimeSegmentWord(Map<Object,Object> map);

	public void insertSegmentVote(TMdInstanceSegmentVote map);

	public List<Map<String, Object>> getSegmentVoteList(Map<Object,Object> map);

	public List<Map<String, String>> getInstanceNameList();

	public void insert(TMdInstanceSegment obj);

	public List<Map<String, Object>> getListCateGory(Map<Object,Object> map);

	public List<Map<String, Object>> getListCateGoryByName(Map<Object,Object> map);

	public List<Map<String, Object>> getListTable(Map<Object,Object> map);

	public long count(Map<Object,Object> map);

	public List<Map<String, Object>> getListCateGoryByNameForPge(Map<Object,Object> map);

	public List<Map<String, Object>> getListTableForIn(Map<Object,Object> map);

	public void update(Map<Object,Object> map);

	public List<Map<String, Object>> getList(Map<Object,Object> map);

	public void updateids(Map<Object,Object> map);

	public List<Map<String, Object>> getMoreOneList();
	
	public List<Map<String, Object>> getTableList(Map<Object,Object> map);
	
	public void insertRealation(TSegmentRealation obj);
	
	public List<Map<String, Object>> getSchemaList(Map<Object,Object> map);

	public List<Map<String, Object>> getRealationListPage(Map<Object,Object> map);

	
	public List<Map<String, Object>> getTopLevelListPage(Map<Object,Object> map);

	public List<Map<String, Object>> getTopRealationListPage(Map<Object,Object> map);

}
