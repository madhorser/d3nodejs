package test.com.primeton.dgs.ontology.dao;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.OutputStreamWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;


import com.primeton.dgs.ontology.dao.TMdInstanceDAO;
import com.primeton.dgs.ontology.pojos.ParameterMap;

public class TestTMdInstanceDAO    extends BaseTestCase{
	
	@Autowired
	private TMdInstanceDAO  tMdInstanceDAO;
	
	@Test
	//@Ignore
	public void testGetList(){
		System.err.println(tMdInstanceDAO);
		Map<Object, Object> parameterMap = new ParameterMap("start", 0,"limit", 10,"parentId", "m0841ec0aa2811e08be5ec91b51c864c");
		List<Map<String,Object>> list = tMdInstanceDAO.getList(parameterMap);
		for(Map<String,Object> map:list){
			  for (String key : map.keySet()) {
				   System.out.println(""+ key + " = " + map.get(key));
			  }
		}
	}
	
	@Test
	@Ignore
	public void testgetListCateGory(){
		System.err.println(tMdInstanceDAO);
		List<Map<String,Object>> list = tMdInstanceDAO.getListCateGory(null);
		for(Map<String,Object> map:list){
			  for (String key : map.keySet()) {
				   System.out.println(""+ key + " = " + map.get(key));
			  }
		}
	}
	
	@Test
	@Ignore
	public void testgetListCateGoryByName() {
		System.err.println(tMdInstanceDAO);
		Map<String,Object> parmap = new HashMap<String,Object>();
		parmap.put("name", "A3");
		List<Map<String,Object>> list = tMdInstanceDAO.getListCateGoryByName(null);
		for(Map<String,Object> map:list){
			  for (String key : map.keySet()) {
				  //System.out.println(""+ key + " = " + map.get(key));
				   if(key.equals("NAMESPACE")){
					   System.out.println(""+ key + " = " + map.get(key));
					   String  s[] = map.get(key).toString().split("/");
					   System.err.println(s[3]);
				   }
			  }
		}
	}
	
	
	@Test
	@Ignore
	public void testgetListTable() {
		System.err.println(tMdInstanceDAO);
		Map<String,Object> parmap = new HashMap<String,Object>();
		parmap.put("name", "A3");
		List<Map<String,Object>> list = tMdInstanceDAO.getListCateGoryByName(null);
		StringBuilder sb = new StringBuilder();
		sb.append("( ");
		for(Map<String,Object> map:list){
			  for (String key : map.keySet()) {
				  //System.out.println(""+ key + " = " + map.get(key));
				   if(key.equals("NAMESPACE")){
					   System.out.println(""+ key + " = " + map.get(key));
					   String  s[] = map.get(key).toString().split("/");
					   System.err.println(s[3]);
					   sb.append(" '" +s[3]+"' ,");
				   }
			  }
		}
		sb.append(" '' )");

		System.out.println(sb);
		if(null!=list&list.size()>0){
		 parmap.put("tableids", sb.toString());
		 list = tMdInstanceDAO.getListTable(null);
			for(Map<String,Object> map:list){
				  for (String key : map.keySet()) {
					  if(key.equals("INSTANCE_NAME"))
					  System.err.println( map.get("INSTANCE_NAME"));
				  }
		   }
		}
	}
	
	@Test
	@Ignore
	public void count(){
		Map<String,Object> parmap = new HashMap<String,Object>();
		parmap.put("classid", "Column");
		System.out.println(tMdInstanceDAO.count(null));
	}
	
	@Test
	@Ignore
	public void getListByPage(){
		Map<String,Object> parmap = new HashMap<String,Object>();
		parmap.put("classid", "Column");
		//System.out.println(tMdInstanceDAO.count(parmap));
		long row=501; 
		long pageCount=20; 
		long sum=(row-1)/pageCount+1;
		System.out.println(sum); 
		
		
		
		row = tMdInstanceDAO.count(null);
		pageCount=1000; 
		sum=(row-1)/pageCount+1;
		System.out.println(sum); 
		for(long page=0;page<sum;page++){
			parmap.put("start", page*pageCount);
			parmap.put("limit", page*pageCount+pageCount);
			parmap.put("classid", "Column");
			List<Map<String,Object>> list = tMdInstanceDAO.getList(null);

			for(Map<String,Object> map:list){
				  for (String key : map.keySet()) {
					  System.out.println(""+ key + " = " + map.get(key));
				  }
			}
		}
		
	}
	
	
	@Test
	@Ignore
	public void getAIData(){
		Map<String,Object> parmap = new HashMap<String,Object>();
		//parmap.put("id", "v46d9820eff311e19cb3fa042f8ce8e9");//核心系统库
		
		//parmap.put("id", "l120a790eddf11e1b62fba336a952ee8");//PVIEW2库
		
		//parmap.put("id", "n25aa46eec5641bab368aa25b4d618d8");//DBWLHR库
		
		//parmap.put("id", "o12373f6c4504c83969ad64c04d0909f");//库
		
		parmap.put("id", "hba1f06d815d446bb9a2630fc1769994");//库
		
		List<Map<String,Object>> list = tMdInstanceDAO.getListCateGoryAll(null);
		
		System.out.println("总表数= " + list.size());
		
		StringBuilder code = new StringBuilder();
		StringBuilder name = new StringBuilder();
		
		StringBuilder view = new StringBuilder();
		StringBuilder prc = new StringBuilder();
		
		for(int i=0;i<list.size();i++){
			Map<String,Object> map = list.get(i);
			 //if(!map.get("CLASSIFIER_ID").equals("View"))continue;
			 if(!map.get("CLASSIFIER_ID").equals("Table"))continue;
			 //if(!map.get("CLASSIFIER_ID").equals("Procedure"))continue;
			 
			 if(map.get("INSTANCE_CODE").toString().startsWith("TEMPTABLE"))continue;
			 
			//System.out.println( map.get("INSTANCE_CODE"));
			//System.out.println( map.get("INSTANCE_NAME"));
			
			code.append(map.get("INSTANCE_CODE")).append(" ");
			name.append(map.get("INSTANCE_NAME")).append(" ");
			
			//code.append(map.get("INSTANCE_CODE")).append(" ").append(map.get("STRING_1")).append(" ");
			//name.append(map.get("INSTANCE_NAME")).append(" ").append(map.get("STRING_1")).append(" ");
			 
				//code.append(map.get("INSTANCE_CODE")).append(" ").append(map.get("STRING_5")).append(" ");
				//name.append(map.get("INSTANCE_NAME")).append(" ").append(map.get("STRING_5")).append(" ");
			 
			//code.append(map.get("INSTANCE_CODE")).append(" ").append(map.get("STRING_23")).append(" ");
			//name.append(map.get("INSTANCE_NAME")).append(" ").append(map.get("STRING_23")).append(" ");
			  
			 /*
			  System.out.println( map.get("STRING_1"));
			  System.out.println( null!=map.get("STRING_1") &&map.get("STRING_1").equals("<BLOB>") );
			  
			 if(null!=map.get("STRING_1") &&map.get("STRING_1").equals("<BLOB>") ){
				 parmap.put("attid", map.get("INSTANCE_ID"));
				 List<Map<String,Object>> list3 = tMdInstanceDAO.getListInstanceMdATT(parmap);
				 for(int k=0;k<list3.size();k++){
						Map<String,Object> map3 = list3.get(k);
						code.append(map.get("INSTANCE_CODE")).append(" ").append(map3.get("ATTR_VALUE")).append(" ");
						name.append(map.get("INSTANCE_NAME")).append(" ").append(map3.get("ATTR_VALUE")).append(" ");
				}
				 
			 } else{
			code.append(map.get("INSTANCE_CODE")).append(" ").append(map.get("STRING_1")).append(" ");
			name.append(map.get("INSTANCE_NAME")).append(" ").append(map.get("STRING_1")).append(" ");
			 }*/
			  
			
			  parmap.put("id", map.get("INSTANCE_ID"));
			  List<Map<String,Object>> list2 = tMdInstanceDAO.getListCateGoryAll(null);
			 for(int j=0;j<list2.size();j++){
					Map<String,Object> map1 = list2.get(j);
					//System.out.println( map1.get("INSTANCE_CODE"));
					//System.out.println( map1.get("INSTANCE_NAME"));
					code.append(map1.get("INSTANCE_CODE")).append(" ");
					name.append(map1.get("INSTANCE_NAME")).append(" ");
			}
				code.append("\n");
				name.append("\n");	
			
		}
		
		//System.out.println( name);
		//System.out.println( code);
		
		writeFile("/Users/miSter/name.txt", name.toString());
		writeFile("/Users/miSter/code.txt", code.toString());
		
		/*
		for(Map<String,Object> map:list){
			
			  for (String key : map.keySet()) {
				  if(!key.equals("INSTANCE_CODE"))continue;
				  System.out.println(""+ key + " = " + map.get(key));
				  
				  parmap.put("id", map.get(key));
				  List<Map<String,Object>> list2 = tMdInstanceDAO.getListSchemaCateGoryAll(parmap);
					for(Map<String,Object> map1:list2){
						  for (String key1 : map1.keySet()) {
							  //System.out.println(""+ key1 + " = " + map.get(key1));
						  }
					}
			  }
		}*/
		
		
		
		
	}
	
	
	
	@Test
	@Ignore
	public void getListRootCateGoryAll(){
		Map<String,Object> parmap = new HashMap<String,Object>();
		
		List<Map<String,Object>> list = tMdInstanceDAO.getListRootCateGoryAll(null);

		for(Map<String,Object> map:list){
			  for (String key : map.keySet()) {
				  if(!key.equals("CLASSIFIER_ID"))continue;
				  if(map.get("CLASSIFIER_ID").equals("Table"))continue;
				  if(map.get("CLASSIFIER_ID").equals("Column"))continue;
				  parmap.put("classid", map.get("CLASSIFIER_ID"));
				  //System.out.println( map.get("CLASSIFIER_ID"));
				  
				  list = tMdInstanceDAO.getListSchemaCateGoryAll(null);
					for(Map<String,Object> map1:list){
						  for (String key1 : map1.keySet()) {
							  System.out.println(""+ key + " = " + map.get(key));
						  }
					}
			  }
		}
		
		
		
		
	}
    
	public static void writeFile(String filePathAndName, String fileContent) {
		  try {
		   File f = new File(filePathAndName);
		   if (!f.exists()) {
		    f.createNewFile();
		   }
		   OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(f),"UTF-8");
		   FileWriter writer = new FileWriter(filePathAndName, true);
		   writer.write(fileContent);
		   writer.close();
		  } catch (Exception e) {
		   System.out.println("写文件内容操作出错");
		   e.printStackTrace();
		  }
	}
	
}
