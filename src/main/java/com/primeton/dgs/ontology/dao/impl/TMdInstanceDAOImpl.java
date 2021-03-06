package com.primeton.dgs.ontology.dao.impl;

import java.util.List;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.primeton.dgs.ontology.dao.TMdInstanceDAO;
import com.primeton.dgs.ontology.pojos.ParameterMap;
import com.primeton.dgs.ontology.pojos.TMdInstance;

@Scope("prototype")
@Repository("tMdInstanceDAO")
public class TMdInstanceDAOImpl implements TMdInstanceDAO{

	
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
	public void insert(TMdInstance obj) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//mapper.insert(obj);
	}

	@Override
	public void update(TMdInstance obj) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//mapper.update(obj);
	}

	@Override
	public TMdInstance findById(String id) {
		Map<Object, Object> parameterMap = new ParameterMap("instanceId", id);
		return (TMdInstance)getSqlMapClientTemplate().queryForObject("TMdInstance.findById", parameterMap);
	}

	@Override
	public void delete(String id) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//mapper.delete(id);
	}

	@Override
	public List<Map<String, Object>> getList(Map<Object, Object> map) {
		List<Map<String, Object>> list =  getSqlMapClientTemplate().queryForList("TMdInstance.findByPage2", map);
		return list;
	}

	@Override
	public List<Map<String, Object>> getListCateGory(Map<Object,Object> map) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//return mapper.getListCateGory(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getListCateGoryByName(Map<Object,Object> map) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//return mapper.getListCateGoryByName(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getListTable(Map<Object,Object> map) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//return mapper.getListTable(map);
		return getSqlMapClientTemplate().queryForList("TMdInstance.getListTable", map);
	}

	@Override
	public long count(Map<Object,Object> map) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//return mapper.count(map);
		return (Long)getSqlMapClientTemplate().queryForObject("TMdInstance.findByCount", map);
	}

	@Override
	public List<Map<String, Object>> getListCateGoryAll(Map<Object,Object> map) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//return mapper.getListCateGoryAll(map);
		return  getSqlMapClientTemplate().queryForList("TMdInstance.getListSchemaCateGoryAll", map);
	}

	@Override
	public List<Map<String, Object>> getListRootCateGoryAll(Map<Object,Object> map) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//return mapper.getListRootCateGoryAll(map);
		return null;
	}

	@Override
	public List<Map<String, Object>> getListSchemaCateGoryAll(Map<Object,Object> map) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//return mapper.getListSchemaCateGoryAll(map);
		return  getSqlMapClientTemplate().queryForList("TMdInstance.getListSchemaCateGoryAll", map);
	}

	@Override
	public List<Map<String, Object>> getListInstanceMdATT(Map<Object,Object> map) {
		//TMdInstanceMapper mapper = this.sqlSessionTemplate.getMapper(TMdInstanceMapper.class);
		//return mapper.getListInstanceMdATT(map);
		return null;
	}
	@Override
	public long countByIds(Map<Object, Object> map) {
		return (Long)getSqlMapClientTemplate().queryForObject("TMdInstance.countByIds", map);
	}
	@Override
	public List<Map<String, Object>> getListByids(Map<Object, Object> map) {
		// TODO Auto-generated method stub
		return  getSqlMapClientTemplate().queryForList("TMdInstance.getListByids", map);
	}

}
