package test.com.primeton.dgs.ontology.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.primeton.dgs.ontology.dao.TMdInstanceDAO;
import com.primeton.dgs.ontology.dao.TMdInstanceSegmentDAO;

import test.com.primeton.dgs.ontology.dao.BaseTestCase;


public class TestTMdInstanceSegmentService      extends BaseTestCase{
	
	@Autowired
	private TMdInstanceSegmentDAO  tMdInstanceSegmentDAO;
	
	@Test
	@Ignore
	public void testGetList(){
		System.err.println(tMdInstanceSegmentDAO);
		List<Map<String, String>> list = tMdInstanceSegmentDAO.getInstanceNameList();
		for(Map<String,String> map:list){
			  for (String key : map.keySet()) {
				   System.out.println(""+ key + " = " + map.get(key));
			  }
		}
	}
	
	@Test
	@Ignore
	public void testSegmentList(){
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", 1);
		map.put("end", 10);
		
		List<Map<String, Object>> list = tMdInstanceSegmentDAO.getListCateGoryMod(null);
		for(Map<String, Object> temp:list){
			System.out.println(temp.get("SEG"));
			System.out.println(temp.get("COLUM"));
			System.out.println(temp.get("TOTAL"));
		}
	}
	@Test
	//@Ignore
	public void testetListCateGory(){
		Map<String,Object> map1 = new HashMap<String,Object>();
		map1.put("start", 0);
		map1.put("end", 5);
		String name = null;
		if( null!=name && !(name.equals("")) ){
			
			map1.put("name", "INSTANCE_NAME like '%"+name+"%'");
		}else{
			map1.put("name", "1=1");
		}
		List<Map<String, Object>> list = tMdInstanceSegmentDAO.getListCateGory(null);
		for(Map<String,Object> map:list){
			  for (String key : map.keySet()) {
				   System.out.println(""+ key + " = " + map.get(key));
			  }
		}
	}
}
