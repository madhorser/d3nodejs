package com.primeton.dgs.ontology.service;

import java.util.List;
import java.util.Map;

import com.primeton.dgs.ontology.pojos.TMdInstance;

public interface TMdInstanceService {
	String SPRING_NAME = "tMdInstanceService";
    public void insert(TMdInstance obj); 
    
    public void update(TMdInstance obj);  
       
    public TMdInstance findById(String id);  
     
    public void delete(String id); 
    
    public List<Map<String,Object>> getList(Map<Object,Object> map);
    
    public List<Map<String, Object>> getListCateGory(Map<Object,Object> map);
    
    public List<Map<String, Object>> getListCateGoryByName(Map<Object,Object> map);
    
    public List<Map<String, Object>> getListTable(Map<Object,Object> map);
    
    public long count(Map<Object,Object> map);
    
    public List<Map<String, Object>> getListCateGoryAll(Map<Object,Object> map);
    
   public List<Map<String, Object>> getListRootCateGoryAll(Map<Object,Object> map);
    
    public List<Map<String, Object>> getListSchemaCateGoryAll(Map<Object,Object> map);
    
    public List<Map<String, Object>> getListInstanceMdATT(Map<Object,Object> map);
}
