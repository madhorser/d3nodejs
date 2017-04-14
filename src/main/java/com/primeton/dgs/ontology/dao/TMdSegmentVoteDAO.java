package com.primeton.dgs.ontology.dao;

import java.util.List;
import java.util.Map;

import com.primeton.dgs.ontology.pojos.TMdDistance;
import com.primeton.dgs.ontology.pojos.TMdInstance;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegmentVote;
import com.primeton.dgs.ontology.pojos.TSegmentRealation;

public interface TMdSegmentVoteDAO {


	//public long countbyname(Map<String, Object> map);

	public List<Map<String, Object>> getSchemaVote(Map<Object,Object> map);

	public void updateSegmentId(Map<Object,Object> map);
	
	public List<String> getSegmentList(Map<Object,Object> map);
	
	public List<Map<String, Object>> getDistanceList(Map<Object,Object> map);
	
    public void insert(TMdDistance obj); 

	//public long count(Map<String, Object> map);

}
