package test.com.primeton.dgs.ontology.dao;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.primeton.dgs.ontology.dao.TMdWordSimilarityDAO;
import com.primeton.dgs.ontology.pojos.TMdWordSimilarity;
/*
select * from T_MD_INSTANCE where CLASSIFIER_ID='Schema';

select * from T_MM_FEATURECOL where CLASSIFIER_ID='Column'

select * from T_MM_FEATURE where CLASSIFIER_ID='Column'

select * from T_MM_FEATURECOL where CLASSIFIER_ID='Table';

select * from T_MM_FEATURE where CLASSIFIER_ID='Table';

select * from T_MD_INSTANCE where PARENT_ID='hc821d04c51e4448adc52d44ba7d4327';


select INSTANCE_ID,INSTANCE_CODE,INSTANCE_NAME from T_MD_INSTANCE where PARENT_ID='sf907eb954a74e3e8dd942d0fef84a2e' and  CLASSIFIER_ID='Table';
select count(1) from T_MD_INSTANCE where PARENT_ID='g07825f38fd4450087348667da1f3b6b' and  CLASSIFIER_ID='Table';
select count(1) from T_MD_INSTANCE where PARENT_ID='g8e810ab11e94e288ba41fed0f8b6a80' and  CLASSIFIER_ID='Table';
select count(1) from T_MD_INSTANCE where PARENT_ID='j27e761f3134486ba0ffd0ee983b8ddd' and  CLASSIFIER_ID='Table';
*/
public class TestTMdWordSimilarity {
    
	 //SELECT a.* FROM user_tab_columns a WHERE  a.TABLE_NAME = 'T_MD_INSTANCE';
	 //SELECT a.* FROM user_tab_comments a WHERE  a.TABLE_NAME = 'T_MD_INSTANCE';
	 //SELECT a.* FROM user_col_comments a WHERE  a.TABLE_NAME = 'T_MD_INSTANCE';
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		TestTMdWordSimilarity tt = new TestTMdWordSimilarity();
         //tt.testData();
		tt.testDataForDB();
	}
	
	
	
	
	private   void  testDataForDB(){
		
		
		

		
		ApplicationContext factory=new ClassPathXmlApplicationContext("classpath*:spring/applicationContext.xml"); 
		System.err.println(factory);
		TMdWordSimilarityDAO tMdWordSimilarityDAO = (TMdWordSimilarityDAO) factory.getBean("tMdWordSimilarityDAO");
		System.err.println(tMdWordSimilarityDAO);
        Levenshtein lt = new Levenshtein();
        
        String tstr = "SQ_T_HOUSE";
        String cstr = "HOUSE";
        
		
		OracleDao od = new OracleDao();
		
		
		String dbt[] =  {"INSTANCE_ID","INSTANCE_CODE","INSTANCE_NAME","STRING_18"};
		od.getConnection();
		List<Map<String,Object>> list0 = od.getRes(2,dbt,"select INSTANCE_ID,INSTANCE_CODE,INSTANCE_NAME,STRING_18 from T_MD_INSTANCE where PARENT_ID='sf907eb954a74e3e8dd942d0fef84a2e' and  CLASSIFIER_ID='Table'");
		
		/*
		list0 = new ArrayList<Map<String,Object>>();
		Map<String,Object> temp = new HashMap<String,Object>();
		temp.put("INSTANCE_ID", "g2c122fd127f46729c504fe73d198f55");
		temp.put("INSTANCE_CODE", "HIS_HD_ESTATE_STOCK_APP");
		temp.put("INSTANCE_NAME", "历史备份--申报人员股票财产信息");
		list0.add(temp);
		temp = new HashMap<String,Object>();
		temp.put("INSTANCE_ID", "g4f3ac74d66244e2a0ec528266f59dfc");
		temp.put("INSTANCE_CODE", "HIS_HD_ESTATE_STOCK_CH");
		temp.put("INSTANCE_NAME", "历史备份--股票财产信息表");
		list0.add(temp);
		temp = new HashMap<String,Object>();
		temp.put("INSTANCE_ID", "g54157f650104caa879585bfdcd41198");
		temp.put("INSTANCE_CODE", "HD_ESTATE_CH");
		temp.put("INSTANCE_NAME", "核定--业务申报人员财产汇总表");
		list0.add(temp);
		temp = new HashMap<String,Object>();
		temp.put("INSTANCE_ID", "g6107eec249e46b4ad0e5004a4fbd0c3");
		temp.put("INSTANCE_CODE", "HD_ESTATE_STOCK_CH");
		temp.put("INSTANCE_NAME", "业务财产核定--股票财产信息表");
		list0.add(temp);
		temp = new HashMap<String,Object>();
		temp.put("INSTANCE_ID", "g647aeac800a44369c7ca1741f249b73");
		temp.put("INSTANCE_CODE", "HD_ESTATE_CAR_APP");
		temp.put("INSTANCE_NAME", "机动车辆信息表");
		list0.add(temp);*/
		
		
		 String sql = "select INSTANCE_ID,INSTANCE_CODE,INSTANCE_NAME,STRING_18 from T_MD_INSTANCE where  CLASSIFIER_ID='Table' and   INSTANCE_CODE in('bp_confim_main_business','sl_plans_to_charge','sl_actual_to_charge','sl_fund_intent','sl_charge_detail','sl_fund_detail','sl_fund_qlide','pl_guarantee_many_fund','cs_bank','sl_bank_account','gl_guaranteeloan_project')";
		 //sql ="SELECT INSTANCE_ID,INSTANCE_CODE,INSTANCE_NAME,STRING_18 FROM T_MD_INSTANCE WHERE  CLASSIFIER_ID='Table' and   INSTANCE_CODE IN('sl_fund_qlide','sl_fund_detail','sl_charge_detail','sl_bank_account','pl_guarantee_many_fund')";
		 //sql ="SELECT INSTANCE_ID,INSTANCE_CODE,INSTANCE_NAME,STRING_18 FROM T_MD_INSTANCE WHERE  CLASSIFIER_ID='Table' and  PARENT_ID='g07825f38fd4450087348667da1f3b6b' and  INSTANCE_CODE IN('SQ_T_ROOM','SQ_T_REGION','SQ_T_UNIT','SQ_T_HOUSE','SQ_T_BLOCK','T_LP')";
		 //sql ="SELECT INSTANCE_ID,INSTANCE_CODE,INSTANCE_NAME,STRING_18 FROM T_MD_INSTANCE WHERE  CLASSIFIER_ID='Table' and  PARENT_ID='g07825f38fd4450087348667da1f3b6b' and  INSTANCE_CODE IN('SQ_T_HOUSE_OWNER','SQ_T_HOUSE_MOD','SQ_T_HOUSE_LIVE_VOLUNTEER','SQ_T_HOUSE_LIVE_POLITICSLAW','SQ_T_HOUSE_LIVE_PLANBIRTH'  ,'SQ_T_HOUSE_LIVE_PARTYBUILD','SQ_T_HOUSE_LIVE_MOHRSS')";
		 //sql ="SELECT INSTANCE_ID,INSTANCE_CODE,INSTANCE_NAME,STRING_18 FROM T_MD_INSTANCE WHERE  CLASSIFIER_ID='Table' and  PARENT_ID='sf907eb954a74e3e8dd942d0fef84a2e' and  INSTANCE_CODE IN('HD_EXPENSE_APP','HD_PERSON_APP','HD_EXPENSE_DETAIL_APP','HD_FAMILY_APP','HD_PERSON_CH','HD_FAMILY_EXT_APP')";
		 //sql ="SELECT INSTANCE_ID,INSTANCE_CODE,INSTANCE_NAME,STRING_18 FROM T_MD_INSTANCE WHERE  CLASSIFIER_ID='Table' and  PARENT_ID='v46d9820eff311e19cacfa042f8ce8e9' and "
		 		//+ " INSTANCE_CODE IN('LCMASTER','LCCLAUSEINFO','LAMASTER','GAMASTER','ICACCEPT','ICPAY')";
		 
		 
		 
		 sql ="SELECT INSTANCE_ID,INSTANCE_CODE,INSTANCE_NAME,STRING_18 FROM T_MD_INSTANCE WHERE  CLASSIFIER_ID='Table' and  PARENT_ID='g07825f38fd4450087348667da1f3b6b' and  INSTANCE_CODE IN('SQ_T_ROOM','SQ_T_REGION','SQ_T_UNIT','SQ_T_HOUSE','SQ_T_BLOCK','SQ_T_WORK','SQ_T_ZONE','SQ_T_USER_SUGGEST','MON_ONLINE_USER','SQ_T_PUBLIC','DM_CZRY','DC_SYS_DIC','SQ_T_ORG','SQ_T_MY_FOLDER','MESSAGE_SYSTEM')";
		 
		 
		 System.err.println(sql.toUpperCase());
		 od.getConnection();
		 //list0 = od.getRes(2,dbt,sql.toUpperCase());
		 list0 = od.getRes(2,dbt,sql);
		
		
		StringBuilder sb = new StringBuilder();
		for(Map<String,Object> map0:list0){
		String v = map0.get("INSTANCE_ID")+"";
		String tnamev = map0.get("INSTANCE_CODE")+"";
		
		
		 String tcomenttable="0";
		 //System.err.println(map0.get("INSTANCE_NAME"));
		
		 //tcomenttable=lt.getSimilarityRatio(tstr , map0.get("INSTANCE_NAME").toString())+"";
		 //System.err.println(tstr +"与"+map0.get("INSTANCE_NAME")+"=====>的相似度=" +tcomenttable );
		 
		 tcomenttable=lt.getSimilarityRatio(tstr , map0.get("STRING_18").toString())+"";
		 System.err.println(tstr +"与"+map0.get("STRING_18")+"=====>的相似度=" +tcomenttable );

		String c[] = {"INSTANCE_CODE","INSTANCE_NAME","STRING_8","STRING_5","STRING_4","STRING_9"};
		
		od.getConnection();
		List<Map<String,Object>> list1 = od.getRes(2,c,"select INSTANCE_CODE,INSTANCE_NAME,STRING_8,STRING_5,STRING_4,STRING_9 from T_MD_INSTANCE where  CLASSIFIER_ID='Column' and PARENT_ID= '"+v+"'");
		for(Map<String,Object> map:list1){
             
			    //if(!map.get("INSTANCE_CODE").toString().startsWith("PK"))continue;
			   if(map.get("INSTANCE_CODE").toString().startsWith("EXT"))continue;
				if(map.get("INSTANCE_CODE").toString().startsWith("STRING"))continue;
				TMdWordSimilarity obj= new TMdWordSimilarity();
				obj.setId(UUID.randomUUID().toString().replaceAll("-", ""));
				obj.setComname(tstr+":"+cstr);
				obj.setTablename(tnamev);
				obj.setName(map.get("INSTANCE_CODE").toString());
				//obj.setTcomments(tcomenttable);
				
				if(null==map.get("STRING_18")){
					obj.setTcomments(map0.get("INSTANCE_NAME")+"");
				}else{
					obj.setTcomments(map0.get("STRING_18")+"");
				}

				String table="0";
				table= lt.getSimilarityRatio(tstr, tnamev.toString())+"";
				System.err.println(tstr+"与"+tnamev+"=====>的相似度=" +table);
				obj.setStablevalue(table);
				String cloumn="0";
				cloumn= lt.getSimilarityRatio(cstr, map.get("INSTANCE_CODE").toString())+"";
				System.err.println(cstr+"与"+map.get("INSTANCE_CODE")+"=====>的相似度=" +cloumn );
				obj.setScloumvalue(cloumn);

				if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("VARCHAR") ) ){
					//obj.setNametype("0");
					obj.setNametype("VARCHAR");
					obj.setType0("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("SMALLINT") ) ){
					//obj.setNametype("1");
					obj.setNametype("SMALLINT");
					obj.setType1("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("DOUBLE") ) ){
					//obj.setNametype("2");
					obj.setNametype("DOUBLE");
					obj.setType2("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("BIT") ) ){
					//obj.setNametype("3");
					obj.setNametype("BIT");
					obj.setType3("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("FLOAT") ) ){
					//obj.setNametype("4");
					obj.setNametype("FLOAT");
					obj.setType4("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("NVARCHAR") ) ){
					//obj.setNametype("5");
					obj.setNametype("NVARCHAR");
					obj.setType5("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("DATETIME") ) ){
					//obj.setNametype("6");
					obj.setNametype("DATETIME");
					obj.setType6("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("TEXT") ) ){
					//obj.setNametype("7");
					obj.setNametype("TEXT");
					obj.setType7("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("CHAR") ) ){
					//obj.setNametype("8");
					obj.setNametype("CHAR");
					obj.setType8("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("NUMBER") ) ){
					//obj.setNametype("9");
					obj.setNametype("NUMBER");
					obj.setType9("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().startsWith("VARCHAR2") ) ){
					//obj.setNametype("10");
					obj.setNametype("VARCHAR2");
					obj.setType10("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("DATE") ) ){
					//obj.setNametype("11");
					obj.setNametype("DATE");
					obj.setType11("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("CHAR") ) ){
					//obj.setNametype("12");
					obj.setNametype("CHAR");
					obj.setType12("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("TINYTEXT") ) ){
					//obj.setNametype("13");
					obj.setNametype("TINYTEXT");
					obj.setType13("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("VARBINARY") ) ){
					//obj.setNametype("14");
					obj.setNametype("VARBINARY");
					obj.setType14("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("LONGTEXT") ) ){
					//obj.setNametype("15");
					obj.setNametype("LONGTEXT");
					obj.setType15("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("TINYINT") ) ){
					//obj.setNametype("16");
					obj.setNametype("TINYINT");
					obj.setType16("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("LONGBLOB") ) ){
					//obj.setNametype("17");
					obj.setNametype("LONGBLOB");
					obj.setType17("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("BIGINT") ) ){
					//obj.setNametype("18");
					obj.setNametype("BIGINT");
					obj.setType18("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("BLOB") ) ){
					//obj.setNametype("19");
					obj.setNametype("BLOB");
					obj.setType19("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("DECIMAL") ) ){
					//obj.setNametype("20");
					obj.setNametype("DECIMAL");
					obj.setType20("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("INT") ) ){
					//obj.setNametype("21");
					obj.setNametype("INT");
					obj.setType21("1");
				}else if( (null!=map.get("STRING_8") )&&(map.get("STRING_8").toString().toUpperCase().equals("MEDIUMTEXT") ) ){
					//obj.setNametype("22");
					obj.setNametype("MEDIUMTEXT");
					obj.setType22("1");
				}else{
					//obj.setNametype("无类型");
					obj.setNametype(map.get("STRING_8")+"");
				}
				
				
				System.out.println(map.get("STRING_5"));
				System.out.println(null!=map.get("STRING_5"));
				
				if( null!=map.get("STRING_5") ){
					obj.setNamelength(map.get("STRING_5")+"");
				}else{
					obj.setNamelength("30");
				}
				
				if( null!=map.get("STRING_4")&&map.get("STRING_4").equals("YES")  ){
					obj.setNameisnull("1");
				}else{obj.setNameisnull("0");}
				
				
				String comenttable="0";
				/*
				if(null==map.get("INSTANCE_NAME")){
					
				}else{
					comenttable= lt.getSimilarityRatio(cstr, map.get("INSTANCE_NAME").toString())+"";
				}
				obj.setComments(comenttable);
				System.err.println(cstr+"与"+map.get("INSTANCE_NAME")+"=====>的相似度=" +comenttable );
				*/
				if(null==map.get("STRING_9")){
					obj.setComments(map.get("INSTANCE_NAME")+"");
				}else{
					obj.setComments(map.get("STRING_9")+"");
				}
				//obj.setComments(comenttable);
				System.err.println(cstr+"与"+map.get("STRING_9")+"=====>的相似度=" +comenttable );
				
				
				tMdWordSimilarityDAO.insert(obj);
				System.err.print(obj.getString()+map.get("STRING_8"));
                sb.append(obj.getString());
			 
			 
		}
		

		
		



		
		}
		
		
        BufferedWriter out = null;   
        try {   
            out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("/Users/miSter/本体.txt", true)));   
            out.write(sb.toString());
            out.close();
        } catch (Exception e) {   
            e.printStackTrace();   
        }
	}
	
	
	private   void  testData(){
		ApplicationContext factory=new ClassPathXmlApplicationContext("classpath*:spring/applicationContext.xml"); 
		System.err.println(factory);
		TMdWordSimilarityDAO tMdWordSimilarityDAO = (TMdWordSimilarityDAO) factory.getBean("tMdWordSimilarityDAO");
		System.err.println(tMdWordSimilarityDAO);
        Levenshtein lt = new Levenshtein();
        
        String tstr = "T_MD_INSTANCE";
        String cstr = "INSTANCE_CODE";
        
		
		OracleDao od = new OracleDao();
		
		String s[ ] = {"T_MD_INSTANCE","T_MD_COMPOSITION","T_MD_DEPENDENCY"};
		StringBuilder sb = new StringBuilder();
		for(String v:s){
		
		String t[] =  {"COMMENTS"};
		String c[] = {"COMMENTS"};
		String n[] = {"TABLE_NAME","COLUMN_NAME","DATA_TYPE","DATA_LENGTH","NULLABLE"};
		String tcomenttable="0";
		od.getConnection();
		List<Map<String,Object>> list1 = od.getRes(0,t,"SELECT a.* FROM user_tab_comments a WHERE  a.TABLE_NAME =  '"+v+"'");
		for(Map<String,Object> map:list1){
			 //System.err.println(map.get("COMMENTS"));
			tcomenttable=lt.getSimilarityRatio(tstr , map.get("COMMENTS").toString())+"";
			 System.err.println(tstr +"与"+map.get("COMMENTS")+"=====>的相似度=" +tcomenttable );
		}
		
		od.getConnection();
		List<Map<String,Object>> list2 = od.getRes(2,n,"SELECT a.* FROM user_tab_columns a WHERE  a.TABLE_NAME = '"+v+"'");
		for(Map<String,Object> map:list2){
			
			
			
			if(map.get("COLUMN_NAME").toString().startsWith("STRING"))continue;
			TMdWordSimilarity obj= new TMdWordSimilarity();
			obj.setId(UUID.randomUUID().toString().replaceAll("-", ""));
			obj.setComname(tstr+":"+cstr);
			obj.setTablename(v);
			obj.setName(map.get("COLUMN_NAME").toString());
			//obj.setTcomments(tcomenttable);
			if(null==map.get("COMMENTS")){
				obj.setTcomments(map.get("TABLE_NAME")+"");
			}else{
				obj.setTcomments(map.get("COMMENTS")+"");
			}

			String table="0";
			table= lt.getSimilarityRatio(tstr, map.get("TABLE_NAME").toString())+"";
			System.err.println(tstr+"与"+map.get("TABLE_NAME")+"=====>的相似度=" +table);
			obj.setStablevalue(table);
			String cloumn="0";
			cloumn= lt.getSimilarityRatio(cstr, map.get("COLUMN_NAME").toString())+"";
			System.err.println(cstr+"与"+map.get("COLUMN_NAME")+"=====>的相似度=" +cloumn );
			obj.setScloumvalue(cloumn);
			//System.err.println(map.get("TABLE_NAME"));
			//System.err.println(map.get("COLUMN_NAME"));
			
			/*
			if( map.get("DATA_TYPE").equals("VARCHAR2") || map.get("DATA_TYPE").equals("VARCHAR") ){
				obj.setNametype("1");
			}else{obj.setNametype("1");}*/
			
			if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("VARCHAR") ) ){
				//obj.setNametype("0");
				obj.setNametype("VARCHAR");
				obj.setType0("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("SMALLINT") ) ){
				//obj.setNametype("1");
				obj.setNametype("SMALLINT");
				obj.setType1("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("DOUBLE") ) ){
				//obj.setNametype("2");
				obj.setNametype("DOUBLE");
				obj.setType2("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("BIT") ) ){
				//obj.setNametype("3");
				obj.setNametype("BIT");
				obj.setType3("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("FLOAT") ) ){
				//obj.setNametype("4");
				obj.setNametype("FLOAT");
				obj.setType4("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("NVARCHAR") ) ){
				//obj.setNametype("5");
				obj.setNametype("NVARCHAR");
				obj.setType5("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("DATETIME") ) ){
				//obj.setNametype("6");
				obj.setNametype("DATETIME");
				obj.setType6("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("TEXT") ) ){
				//obj.setNametype("7");
				obj.setNametype("TEXT");
				obj.setType7("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("CHAR") ) ){
				//obj.setNametype("8");
				obj.setNametype("CHAR");
				obj.setType8("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("NUMBER") ) ){
				//obj.setNametype("9");
				obj.setNametype("NUMBER");
				obj.setType9("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("VARCHAR2") ) ){
				//obj.setNametype("10");
				obj.setNametype("VARCHAR2");
				obj.setType10("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("DATE") ) ){
				//obj.setNametype("11");
				obj.setNametype("DATE");
				obj.setType11("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("CHAR") ) ){
				//obj.setNametype("12");
				obj.setNametype("CHAR");
				obj.setType12("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("TINYTEXT") ) ){
				//obj.setNametype("13");
				obj.setNametype("TINYTEXT");
				obj.setType13("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("VARBINARY") ) ){
				//obj.setNametype("14");
				obj.setNametype("VARBINARY");
				obj.setType14("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("LONGTEXT") ) ){
				//obj.setNametype("15");
				obj.setNametype("LONGTEXT");
				obj.setType15("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("TINYINT") ) ){
				//obj.setNametype("16");
				obj.setNametype("TINYINT");
				obj.setType16("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("LONGBLOB") ) ){
				//obj.setNametype("17");
				obj.setNametype("LONGBLOB");
				obj.setType17("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("BIGINT") ) ){
				//obj.setNametype("18");
				obj.setNametype("BIGINT");
				obj.setType18("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("BLOB") ) ){
				//obj.setNametype("19");
				obj.setNametype("BLOB");
				obj.setType19("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("DECIMAL") ) ){
				//obj.setNametype("20");
				obj.setNametype("DECIMAL");
				obj.setType20("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("INT") ) ){
				//obj.setNametype("21");
				obj.setNametype("INT");
				obj.setType21("1");
			}else if( (null!=map.get("DATA_TYPE") )&&(map.get("DATA_TYPE").toString().toUpperCase().equals("MEDIUMTEXT") ) ){
				//obj.setNametype("22");
				obj.setNametype("MEDIUMTEXT");
				obj.setType22("1");
			}else{
				obj.setNametype("无类型");
			}
			
			//System.err.println(map.get("DATA_TYPE"));
			obj.setNamelength(map.get("DATA_LENGTH")+"");
			//System.err.println(map.get("DATA_LENGTH"));
			//System.err.println(map.get("NULLABLE"));
			if( map.get("NULLABLE").equals("Y")  ){
				obj.setNameisnull("1");
			}else{obj.setNameisnull("0");}
			
			
			od.getConnection();
			List<Map<String,Object>> list3 = od.getRes(1,c,"SELECT a.* FROM user_col_comments a WHERE  a.TABLE_NAME =  '"+v+"'  and COLUMN_NAME ='"+map.get("COLUMN_NAME")+"' ");
			for(Map<String,Object> map1:list3){
				//System.err.println(map1.get("COMMENTS"));
				String comenttable="0";
				/*
				if(null==map1.get("COMMENTS")){
					
				}else{
					comenttable= lt.getSimilarityRatio(cstr, map1.get("COMMENTS").toString())+"";
				}
				obj.setComments(comenttable);*/
				if(null==map1.get("COMMENTS")){
					obj.setComments(map1.get("COLUMN_NAME")+"");
				}else{
					obj.setComments(map1.get("COMMENTS")+"");
				}
				
				//System.err.println(cstr+"与"+map1.get("COMMENTS")+"=====>的相似度=" +comenttable );
			}
			tMdWordSimilarityDAO.insert(obj);
			System.err.print(obj.getString());
            sb.append(obj.getString());
		}
		
		



		
		}
		
        BufferedWriter out = null;   
        try {   
            out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("/Users/miSter/本体.txt", true)));   
            out.write(sb.toString());
            out.close();
        } catch (Exception e) {   
            e.printStackTrace();   
        }
	}

}
