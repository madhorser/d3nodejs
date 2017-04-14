package com.primeton.dgs.ontology.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.primeton.dgs.ontology.dao.TMdWordSimilarityDAO;
import com.primeton.dgs.ontology.pojos.TMdWordSimilarity;
import com.primeton.dgs.ontology.service.TMdWordSimilarityService;

@Service("tMdWordSimilarityService")
public class TMdWordSimilarityServiceImpl implements TMdWordSimilarityService {

	@Autowired
	private TMdWordSimilarityDAO  tMdWordSimilarityDAO;
	@Override
	public void insert(TMdWordSimilarity obj) {
		
		tMdWordSimilarityDAO.insert(obj);
	}

}
