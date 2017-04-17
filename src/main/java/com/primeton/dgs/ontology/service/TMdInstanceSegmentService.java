/**
 * 分词service
 */
package com.primeton.dgs.ontology.service;

import java.util.List;
import java.util.Map;

import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;

public interface TMdInstanceSegmentService {
	String SPRING_NAME = "tMdInstanceSegmentService";
	public List<TMdInstanceSegment> DealSegment();

	public List<Map<String, Object>> getListCateGory(Map<Object,Object> map);

	public List<Map<String, Object>> getListCateGoryMod(Map<Object,Object> map);

	public List<Map<String, Object>> getSegmentVoteList(Map<Object,Object> map);

	public List<Map<String, Object>> getListCateGoryByName(Map<Object,Object> map);

	public List<Map<String, Object>> getListTable(Map<Object,Object> map);

	public long count(Map<Object,Object> map);

	public List<Map<String, Object>> getListCateGoryByNameForPge(Map<Object,Object> map);

	public long countbyname(Map<Object,Object> map);

	public List<Map<String, Object>> getListTableForIn(Map<Object,Object> map);

	public void update(Map<Object,Object> map);

	public List<Map<String, Object>> getList(Map<Object,Object> map);

	public void updateids(Map<Object,Object> map);

	public List<Map<String, Object>> getListPage(Map<Object,Object> map);
	
	public List<Map<String, Object>> getRealationListPage(Map<Object,Object> map);
	
	public List<Map<String, Object>> getTopLevelListPage(Map<Object,Object> map);
	
	public List<Map<String, Object>> getTopRealationListPage(Map<Object,Object> map);
}
