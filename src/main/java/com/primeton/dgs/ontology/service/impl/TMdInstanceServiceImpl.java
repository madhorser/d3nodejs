package com.primeton.dgs.ontology.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.primeton.dgs.ontology.dao.TMdInstanceDAO;
import com.primeton.dgs.ontology.pojos.TMdInstance;
import com.primeton.dgs.ontology.service.TMdInstanceService;

@Service("tMdInstanceService")
public class TMdInstanceServiceImpl implements TMdInstanceService{

	
	
	@Autowired
	private TMdInstanceDAO  tMdInstanceDAO;
	
	@Override
	public void insert(TMdInstance obj) {
		tMdInstanceDAO.insert(obj);
	}

	@Override
	public void update(TMdInstance obj) {
		tMdInstanceDAO.update(obj);
	}

	@Override
	public TMdInstance findById(String id) {
		return tMdInstanceDAO.findById(id);
	}

	@Override
	public void delete(String id) {
		tMdInstanceDAO.delete(id);
	}

	@Override
	public List<Map<String, Object>> getList(Map<Object, Object> map) {
		return tMdInstanceDAO.getList(map);
	}

	@Override
	public List<Map<String, Object>> getListCateGory(Map<Object,Object> map) {
		return tMdInstanceDAO.getListCateGory(map);
	}

	@Override
	public List<Map<String, Object>> getListCateGoryByName(Map<Object,Object> map) {
		return tMdInstanceDAO.getListCateGoryByName(map);
	}

	@Override
	public List<Map<String, Object>> getListTable(Map<Object,Object> map) {
		return tMdInstanceDAO.getListTable(map);
	}

	@Override
	public long count(Map<Object,Object> map) {
		return tMdInstanceDAO.count(map);
	}

	@Override
	public List<Map<String, Object>> getListCateGoryAll(Map<Object,Object> map) {
		return tMdInstanceDAO.getListCateGoryAll(map);
	}

	@Override
	public List<Map<String, Object>> getListRootCateGoryAll(Map<Object,Object> map) {
		return tMdInstanceDAO.getListRootCateGoryAll(map);
	}

	@Override
	public List<Map<String, Object>> getListSchemaCateGoryAll(Map<Object,Object> map) {
		return tMdInstanceDAO.getListSchemaCateGoryAll(map);
	}

	@Override
	public List<Map<String, Object>> getListInstanceMdATT(Map<Object,Object> map) {
		return tMdInstanceDAO.getListInstanceMdATT(map);
	}
	
 

}
