package test.com.primeton.dgs.ontology.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.primeton.dgs.ontology.dao.TMdInstanceSegmentDAO;
import com.primeton.dgs.ontology.dao.TMdSegmentVoteDAO;
import com.primeton.dgs.ontology.pojos.TSegmentRealation;

public class SegmentRealationDAO extends BaseTestCase {

	@Autowired
	private TMdInstanceSegmentDAO tMdInstanceSegmentDAO;
	@Autowired
	private TMdSegmentVoteDAO tMdSegmentVoteDAO;

	/**
	 * 查询分词明细表找到表之间的关系，通过表之间的关系找到库之间的关系
	 */
	@Test
	//@Ignore
	//@Rollback(false)
	public void createRealation() {
		try {
			// 1.查询T_MD_INSTANCE_SEGMENT表，找出分词大于1次的--500个测试
			List<Map<String, Object>> columnList = tMdInstanceSegmentDAO.getMoreOneList();
			//List<Map<String, Object>> listParentId = new ArrayList<Map<String, Object>>();
			Map<String, Object> parentmap = new HashMap<String, Object>();
			// 2.循环1步中出现的分词，找到有关系的表分词，插入
			//int i =0;
			//int j =0;
			
			List<String> idList = new ArrayList<String>();
			for (Map<String, Object> map : columnList) {
				// 分词在哪些表里
				
				Map<String, Object> parTablemap = new HashMap<String, Object>();
				parTablemap.put("classifierId", "Columnmap");
				parTablemap.put("segmentWord", map.get("SEGMENT_WORD"));
				// 查询vote表
				List<Map<String, Object>> tablelist = tMdInstanceSegmentDAO.getTableList(null);
				// 每循环一次找出所有的表-去重(程序去重太慢，手工去重)
				List<Map<String, Object>> listCopy = new ArrayList<Map<String, Object>>();
				listCopy.addAll(tablelist);
				if (tablelist.size()>1) {
					Set<String>  set=new HashSet<String>();
					for (Map<String, Object> table : tablelist) {
						//取出vote表的id
						String instanceId = table.get("INSTANCE_ID") + "";
						idList.add(instanceId);
						if (listCopy.size() == 0) {
							continue;
						}
						listCopy.remove(table);//修改？？？
						if (listCopy.size() > 0) {
							//Map<String, Object> mulNo = new HashMap<String, Object>();
							String segmentFromString = table.get("SEGMENT_ID") + "";
							// 结果(segment_id)存储表到关系表from-to
							// segmentFrom}, #{segmentTo},#{type
							for (Map<String, Object> tableCopy : listCopy) {
								String segmentToString = tableCopy.get("SEGMENT_ID") + "";
								//以from+to进行虑重
								set.add(segmentFromString+"|"+segmentToString);
								//mulNo.put(segmentFromString, segmentToString);
							}
						}
					}
					//循环完毕去重完毕插入关系
					insert(set,"Tablemap");
					//等于1000报错
					if (idList.size()>1) {//&&idList.size()<1000
					Set<String>  setSchema=new HashSet<String>();
					//找到所有的表parentId集合，查询vote表找到所有segmentid然后存储
					// 查出有关系的库-去重(程序去重太慢，手工去重)
					parentmap.put("classifierId", "Tablemap");
					
					StringBuilder sb = new StringBuilder();
					sb.append("( ");
					for(String temp:idList){
						sb.append(" '" +temp+"' ,");
					}
					sb.append(" '')");
					
					parentmap.put("tableids", sb.toString());
					
					List<Map<String, Object>> schemalist = tMdInstanceSegmentDAO.getSchemaList(null);
					if (schemalist.size() > 1) {
						List<Map<String, Object>> schemalistCopy = new ArrayList<Map<String, Object>>();
						schemalistCopy.addAll(schemalist);
						for (Map<String, Object> schema : schemalist) {
							
							if (schemalistCopy.size() == 0) {
								continue;
							}
							schemalistCopy.remove(schema);
							if (schemalistCopy.size() > 0) {
								String segmentFromString = schema.get("SEGMENT_ID") + "";
								// 结果(segment_id)存储表到关系表from-to
								// segmentFrom}, #{segmentTo},#{type
								/*TSegmentRealation realation = new TSegmentRealation();
								realation.setSegmentFrom(segmentFromString);
								realation.setType("Schemamap"); */
								for (Map<String, Object> schemaCopy : schemalistCopy) {
									//realation.setSegmentTo(schemaCopy.get("SEGMENT_ID") + "");
									//以from+to进行虑重
									String segmentToString = schemaCopy.get("SEGMENT_ID") + "";
									setSchema.add(segmentFromString+"|"+segmentToString);
									// 结果存储库到关系表
									//tMdInstanceSegmentDAO.insertRealation(realation);
								}
							}
						}
						//循环完毕去重完毕插入关系
						insert(setSchema,"Schemamap");
					}
					}
				}
			}
			
			
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void insert(Set<String>  set,String type) {
		//循环完毕去重完毕插入关系
		for (Iterator<String> it = set.iterator(); it.hasNext(); ) {
			String realationString = it.next();
			String[] realationArr = realationString.split("\\|");
			TSegmentRealation realation = new TSegmentRealation();
			if ("".equals(realationArr[0])||"".equals(realationArr[1])) {
				continue;
			}
			//System.out.println("========"+realationArr[0]);
			//System.out.println("========"+realationArr[1]);
			realation.setSegmentFrom(realationArr[0]);
			realation.setSegmentTo(realationArr[1]);
			realation.setType(type);
			tMdInstanceSegmentDAO.insertRealation(realation);
		}
	}
	
	@Test
	@Ignore
	public void updateType() {
		//updateSegmentId("Schemamap","Tablemap");
		updateSegmentId("Tablemap","Columnmap");
	}
	/**
	 * 修改vote表中parentID为segmentID
	 * @param typeFrom
	 * @param typeTo
	 */
	public void updateSegmentId(String typeFrom,String typeTo) {
		Map<String, Object> parmap = new HashMap<String, Object>();
		parmap.put("classifierId", typeFrom);
		List<Map<String, Object>> voteSchemaList = tMdSegmentVoteDAO.getSchemaVote(null);
		//update T_MD_INSTANCE_SEGMENT_VOTE set parent_id = #{segmentId} 
		//where PARENT_ID=#{instanceId} and CLASSIFIER_ID=#{classifierId}
		parmap.put("classifierId", typeTo);
		for (Map<String, Object> map : voteSchemaList) {
			parmap.put("segmentId", map.get("SEGMENT_ID"));
			parmap.put("instanceId", map.get("INSTANCE_ID"));
			tMdSegmentVoteDAO.updateSegmentId(null);
		}
	}

}
