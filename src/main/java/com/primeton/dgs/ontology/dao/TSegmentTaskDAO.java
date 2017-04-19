package com.primeton.dgs.ontology.dao;

import java.util.List;
import java.util.Map;

import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegmentVote;
import com.primeton.dgs.ontology.pojos.TSegmentRealation;
import com.primeton.dgs.ontology.pojos.TSegmentTask;

public interface TSegmentTaskDAO {

	public void insertSegmentTask(TSegmentTask obj);

	public long count(Map<Object,Object> map);

	public void update(Map<Object,Object> map);

	public void updateids(Map<Object,Object> map);
	
	public List<Map<String, Object>> getSchemaList(Map<Object,Object> map);

}
