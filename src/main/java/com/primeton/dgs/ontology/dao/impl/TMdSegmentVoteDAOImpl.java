package com.primeton.dgs.ontology.dao.impl;

import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.primeton.dgs.ontology.dao.TMdInstanceSegmentDAO;
import com.primeton.dgs.ontology.dao.TMdSegmentVoteDAO;
import com.primeton.dgs.ontology.pojos.TMdDistance;
import com.primeton.dgs.ontology.pojos.TMdInstance;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegmentVote;
import com.primeton.dgs.ontology.pojos.TSegmentRealation;

@Scope("prototype")
@Repository("tMdSegmentVoteDAO")
public class TMdSegmentVoteDAOImpl implements TMdSegmentVoteDAO {

	
	@Autowired
	@Qualifier("sqlMapClientTemplate")
    private SqlMapClientTemplate sqlMapClientTemplate;  
    public SqlMapClientTemplate getSqlMapClientTemplate() {  
        return sqlMapClientTemplate;  
    }  
    public void setSqlMapClientTemplate(  
            SqlMapClientTemplate sqlMapClientTemplate) {  
        this.sqlMapClientTemplate = sqlMapClientTemplate;  
    }

	/**
	@Override
	public List<Map<String, String>> getInstanceNameList() {
		TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		return mapper.getInstanceNameList();
	}


	@Override
	public long count(Map<String, Object> map) {
		TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		return mapper.count(map);
	}


	@Override
	public void insertSegmentVote(TMdInstanceSegmentVote map) {
		TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		mapper.insertSegmentVote(map);
	}

	*/

	@Override
	public void updateSegmentId(Map<Object,Object> map) {
		//TMdInstanceSegmentVoteMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentVoteMapper.class);
		//mapper.updateSegmentId(map);
	}
	
	@Override
	public List<Map<String, Object>> getSchemaVote(Map<Object,Object> map) {
		//TMdInstanceSegmentVoteMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentVoteMapper.class);
		//return mapper.getSchemaVote(map);
		return null;
	}

	@Override
	public List<String> getSegmentList(Map<Object,Object> map) {
		// TODO Auto-generated method stub
		//TMdInstanceSegmentVoteMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentVoteMapper.class);
		//return mapper.getSegmentList(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getDistanceList(Map<Object,Object> map) {
		//TMdInstanceSegmentVoteMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentVoteMapper.class);
		//return mapper.getDistanceList(map);
		return null;
	}

	@Override
	public void insert(TMdDistance obj) {
		//TMdInstanceSegmentVoteMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentVoteMapper.class);
		//mapper.insert(obj);
		
	}

}
