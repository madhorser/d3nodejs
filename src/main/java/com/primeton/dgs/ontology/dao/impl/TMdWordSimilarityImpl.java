package com.primeton.dgs.ontology.dao.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Repository;

import com.primeton.dgs.ontology.dao.TMdWordSimilarityDAO;
import com.primeton.dgs.ontology.pojos.TMdWordSimilarity;

@Scope("prototype")
@Repository("tMdWordSimilarityDAO")
public class TMdWordSimilarityImpl implements TMdWordSimilarityDAO {
	
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
	public void insert(TMdWordSimilarity obj) {
		// TODO Auto-generated method stub
		//TMdWordSimilarityMapper mapper = this.sqlSessionTemplate.getMapper(TMdWordSimilarityMapper.class);
		//mapper.insert(obj);
	}
	 
}
