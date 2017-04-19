package com.primeton.dgs.ontology.dao.impl;

import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.primeton.dgs.ontology.dao.TMdInstanceSegmentDAO;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegmentVote;
import com.primeton.dgs.ontology.pojos.TSegmentRealation;

@Scope("prototype")
@Repository("tMdInstanceSegmentDAO")
public class TMdInstanceSegmentDAOImpl implements TMdInstanceSegmentDAO {

	
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

	@Override
	public List<Map<String, String>> getInstanceNameList() {
		// mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getInstanceNameList();
		return null;
	}

	@Override
	public void insert(TMdInstanceSegment obj) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//mapper.insert(obj);
		getSqlMapClientTemplate().insert("TMdInstanceSegment.insertTMdInstanceSegment", obj);
	}

	@Override
	public List<Map<String, Object>> getListCateGoryByName(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getListCateGoryByName(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getListTable(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getListTable(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getListCateGory(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getListCateGory(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getListCateGoryMod(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getListCateGoryMod(map);
		return null;
	}

	@Override
	public long count(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.count(map);
		return 0;
	}

	@Override
	public List<Map<String, Object>> getListCateGoryByNameForPge(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getListCateGoryByNameForPge(map);
		return null;
	}

	@Override
	public long countbyname(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.countbyname(map);
		return 0;
	}

	@Override
	public List<Map<String, Object>> getListTableForIn(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getListTableForIn(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getSegmentWord(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getSegmentWord(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getSegmentWordByParentId(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getSegmentWordByParentId(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getMostTimeSegmentWord(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getMostTimeSegmentWord(map);
		return null;
	}

	@Override
	public void insertSegmentVote(TMdInstanceSegmentVote map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//mapper.insertSegmentVote(map);
		
	}

	@Override
	public List<Map<String, Object>> getSegmentVoteList(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getMostTimeSegmentWord(map);
		return null;
	}

	@Override
	public void update(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//mapper.update(map);
		
	}

	@Override
	public List<Map<String, Object>> getList(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getList(map);
		return null;
	}

	@Override
	public void updateids(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//mapper.updateids(map);
	}

	@Override
	public List<Map<String, Object>> getListPage(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getListPage(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getMoreOneList() {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getMoreOneList();
		return null;
	}
	
	@Override
	public List<Map<String, Object>> getTableList(Map<Object,Object> map) {
		//TMdInstanceSegmentVoteMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentVoteMapper.class);
		//return mapper.getTableList(map);
		return null;
	}


	@Override
	public void insertRealation(TSegmentRealation obj) {
		//TSegmentRealationMapper mapper = this.sqlSessionTemplate.getMapper(TSegmentRealationMapper.class);
		//mapper.insertRealation(obj);
	}
	
	@Override
	public List<Map<String, Object>> getSchemaList(Map<Object,Object> map) {

		//TMdInstanceSegmentVoteMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentVoteMapper.class);
		//return mapper.getSchemaList(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getRealationListPage(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getRealationListPage(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getTopLevelListPage(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getTopLevelListPage(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getTopRealationListPage(Map<Object,Object> map) {
		//TMdInstanceSegmentMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceSegmentMapper.class);
		//return mapper.getTopRealationListPage(map);
		return null;
	}


}
