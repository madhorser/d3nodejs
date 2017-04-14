package test.com.primeton.dgs.ontology.service;

import java.util.List;
import java.util.Map;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.primeton.dgs.ontology.dao.TMdInstanceDAO;

import test.com.primeton.dgs.ontology.dao.BaseTestCase;

public class TestTMdInstanceService     extends BaseTestCase{
	
	@Autowired
	private TMdInstanceDAO  tMdInstanceDAO;
	
	@Test
	@Ignore
	public void testGetList(){
		System.err.println(tMdInstanceDAO);
		List<Map<String,Object>> list = tMdInstanceDAO.getList(null);
		for(Map<String,Object> map:list){
			  for (String key : map.keySet()) {
				   System.out.println(""+ key + " = " + map.get(key));
			  }
		}
	}
}
