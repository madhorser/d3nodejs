package com.primeton.dgs.ontology.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.primeton.dgs.ontology.dao.TSegmentTaskDAO;
import com.primeton.dgs.ontology.pojos.TSegmentTask;


@Scope("prototype")
@Repository("tSegmentTaskDAO")
public class TSegmentTaskDAOImpl implements TSegmentTaskDAO {

	
	@Autowired
	@Qualifier("sqlMapClientTemplate")
    private SqlMapClientTemplate sqlMapClientTemplate;  
    public SqlMapClientTemplate getSqlMapClientTemplate() {  
        return sqlMapClientTemplate;  
    }  
    public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {  
        this.sqlMapClientTemplate = sqlMapClientTemplate;  
    }
    
	@Override
	public void insertSegmentTask(TSegmentTask obj) {
		// TODO Auto-generated method stub
		getSqlMapClientTemplate().insert("TSegmentTask.insertSegmentTask", obj);
	}
	@Override
	public long count(Map<Object, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Map<String, Object>> getSchemaList(Map<Object, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void updateStatus(TSegmentTask obj) {
		// TODO Auto-generated method stub
		getSqlMapClientTemplate().update("TSegmentTask.updateStatus", obj);
	}
}