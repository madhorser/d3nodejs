package test.com.primeton.dgs.ontology.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.ansj.domain.Term;
import org.ansj.splitWord.analysis.ToAnalysis;
import org.junit.Ignore;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;

import com.primeton.dgs.ontology.dao.TMdInstanceDAO;
import com.primeton.dgs.ontology.dao.TMdInstanceSegmentDAO;
import com.primeton.dgs.ontology.dao.TMdSegmentVoteDAO;
import com.primeton.dgs.ontology.pojos.TMdDistance;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegment;
import com.primeton.dgs.ontology.pojos.TMdInstanceSegmentVote;
//import com.primeton.dgs.ontology.pojos.TSegmentRealation;




public class TestSegmentCodeDAO extends BaseTestCase {


	@Autowired
	private TMdSegmentVoteDAO tMdSegmentVoteDAO;


	/**
	 * 计算相似度
	 */
	@Test
	//@Rollback(false)
	//@Ignore
	public void computSimilar() {
		Map<String, Object> parmap = new HashMap<String, Object>();
		//parmap.put("classifierId", classifierType);
		//TMdWordSimilarity 
		List<Map<String, Object>> distanceList = tMdSegmentVoteDAO.getDistanceList(parmap);
		
		if (distanceList.size() > 1) {
			//欧几里德
			EuclideanMetric em = new EuclideanMetric();
			
			//皮尔逊
			//PearsonCorrelationScore pearsonCorrelationScore = new PearsonCorrelationScore(distanceList);  
			
			List<Map<String, Object>> listCopy = new ArrayList<Map<String, Object>>();
			listCopy.addAll(distanceList);
			
			for (int i = 0; i < distanceList.size(); i++) {
				if (listCopy.size() == 0) {
					continue;
				}
				Map<String, Object> map = distanceList.get(i);
				String name = map.get("NAME")+"";
				Double[] nameArr  = new Double[29];
				
				//nameArr[0]= Double.parseDouble(map.get("STABLEVALUE")+"");
				//nameArr[1]= Double.parseDouble(map.get("SCLOUMVALUE")+"");
				
				nameArr[0]= (double) 0;
				nameArr[1]= (double) 0;
				
				nameArr[2]= Double.parseDouble(map.get("NAMELENGTH")+"")/1.5;
				//nameArr[3]= Double.parseDouble(map.get("NAMETYPE")+"");
				nameArr[3]= Double.parseDouble(map.get("TYPE22")+"");
				nameArr[4]= Double.parseDouble(map.get("NMAEISNULL")+"");
				//nameArr[5]= Double.parseDouble(map.get("COMMENTS")+"")*3;
				//nameArr[6]= Double.parseDouble(map.get("TCOMMENTS")+"")*3;
				String columnComment = map.get("COMMENTS")+"";
				String tableComment = map.get("TCOMMENTS")+"";
				nameArr[5]=	(double) 0;
				nameArr[6]= (double) 0;
				
				nameArr[7]= Double.parseDouble(map.get("TYPE0")+"");
				nameArr[8]= Double.parseDouble(map.get("TYPE1")+"");
				nameArr[9]= Double.parseDouble(map.get("TYPE2")+"");
				nameArr[10]= Double.parseDouble(map.get("TYPE3")+"");
				nameArr[11]= Double.parseDouble(map.get("TYPE4")+"");
				nameArr[12]= Double.parseDouble(map.get("TYPE5")+"");
				nameArr[13]= Double.parseDouble(map.get("TYPE6")+"");
				nameArr[14]= Double.parseDouble(map.get("TYPE7")+"");
				nameArr[15]= Double.parseDouble(map.get("TYPE8")+"");
				nameArr[16]= Double.parseDouble(map.get("TYPE9")+"");
				nameArr[17]= Double.parseDouble(map.get("TYPE10")+"");
				nameArr[18]= Double.parseDouble(map.get("TYPE11")+"");
				nameArr[19]= Double.parseDouble(map.get("TYPE12")+"");
				nameArr[20]= Double.parseDouble(map.get("TYPE13")+"");
				nameArr[21]= Double.parseDouble(map.get("TYPE14")+"");
				nameArr[22]= Double.parseDouble(map.get("TYPE15")+"");
				nameArr[23]= Double.parseDouble(map.get("TYPE16")+"");
				nameArr[24]= Double.parseDouble(map.get("TYPE17")+"");
				nameArr[25]= Double.parseDouble(map.get("TYPE18")+"");
				nameArr[26]= Double.parseDouble(map.get("TYPE19")+"");
				nameArr[27]= Double.parseDouble(map.get("TYPE20")+"");
				nameArr[28]= Double.parseDouble(map.get("TYPE21")+"");
				//nameArrCopy[29]= Double.parseDouble(copyMap.get("TYPE22")+"");
				
				String tableName = map.get("TABLENAME")+"";
				listCopy.remove(distanceList.get(i));
				if (listCopy.size() > 0) {
					//StringBuffer sb = new StringBuffer();
					List<TMdDistance> resultList = new ArrayList<TMdDistance>();
					for (Map<String, Object> copyMap:listCopy) {
						String tableCopyName = copyMap.get("TABLENAME")+"";
						String typeFromString = map.get("NAMETYPE")+"";
						String typeToString = copyMap.get("NAMETYPE")+"";
						
						String nameCopy = copyMap.get("NAME")+"";
						Double[] nameArrCopy  = new Double[29];
						//nameArrCopy[0]= Double.parseDouble(copyMap.get("STABLEVALUE")+"");
						//nameArrCopy[1]= Double.parseDouble(copyMap.get("SCLOUMVALUE")+"");
						
						nameArrCopy[0]= (1-(double) JaccardSimilarity.jaccardSimilarity(tableName, tableCopyName, 2))/3;
						nameArrCopy[1]= (1-(double) JaccardSimilarity.jaccardSimilarity(name, nameCopy, 2))/3;
						
						nameArrCopy[2]= Double.parseDouble(copyMap.get("NAMELENGTH")+"")/1.5;
						//nameArrCopy[3]= Double.parseDouble(copyMap.get("NAMETYPE")+"");
						nameArrCopy[3]= Double.parseDouble(copyMap.get("TYPE22")+"");
						nameArrCopy[4]= Double.parseDouble(copyMap.get("NMAEISNULL")+"");
						
						
						String copyColumnComment = copyMap.get("COMMENTS")+"";
						String copyTableComment = copyMap.get("TCOMMENTS")+"";
						nameArrCopy[5]= (1-(double) JaccardSimilarity.jaccardSimilarity(columnComment, copyColumnComment, 2))/3;
						nameArrCopy[6]= (1-(double) JaccardSimilarity.jaccardSimilarity(tableComment, copyTableComment, 2))/3;
						
						nameArrCopy[7]= Double.parseDouble(copyMap.get("TYPE0")+"");
						nameArrCopy[8]= Double.parseDouble(copyMap.get("TYPE1")+"");
						nameArrCopy[9]= Double.parseDouble(copyMap.get("TYPE2")+"");
						nameArrCopy[10]= Double.parseDouble(copyMap.get("TYPE3")+"");
						nameArrCopy[11]= Double.parseDouble(copyMap.get("TYPE4")+"");
						nameArrCopy[12]= Double.parseDouble(copyMap.get("TYPE5")+"");
						nameArrCopy[13]= Double.parseDouble(copyMap.get("TYPE6")+"");
						nameArrCopy[14]= Double.parseDouble(copyMap.get("TYPE7")+"");
						nameArrCopy[15]= Double.parseDouble(copyMap.get("TYPE8")+"");
						nameArrCopy[16]= Double.parseDouble(copyMap.get("TYPE9")+"");
						nameArrCopy[17]= Double.parseDouble(copyMap.get("TYPE10")+"");
						nameArrCopy[18]= Double.parseDouble(copyMap.get("TYPE11")+"");
						nameArrCopy[19]= Double.parseDouble(copyMap.get("TYPE12")+"");
						nameArrCopy[20]= Double.parseDouble(copyMap.get("TYPE13")+"");
						nameArrCopy[21]= Double.parseDouble(copyMap.get("TYPE14")+"");
						nameArrCopy[22]= Double.parseDouble(copyMap.get("TYPE15")+"");
						nameArrCopy[23]= Double.parseDouble(copyMap.get("TYPE16")+"");
						nameArrCopy[24]= Double.parseDouble(copyMap.get("TYPE17")+"");
						nameArrCopy[25]= Double.parseDouble(copyMap.get("TYPE18")+"");
						nameArrCopy[26]= Double.parseDouble(copyMap.get("TYPE19")+"");
						nameArrCopy[27]= Double.parseDouble(copyMap.get("TYPE20")+"");
						nameArrCopy[28]= Double.parseDouble(copyMap.get("TYPE21")+"");
						//nameArrCopy[29]= Double.parseDouble(copyMap.get("TYPE22")+"");
						
						
						//相同表不比
						if(tableCopyName.equals(tableName)){
							continue;
						}
						//不同类型不比较
						if(!typeFromString.equals(typeToString)){
							continue;
						}
						double similary = em.sim_distance(nameArr, nameArrCopy);
						//System.out.println(name+"\t"+"与"+nameCopy+"\t"+"的欧几里德相似度="+"\t"+similary);
						//sb.append(name+"\t"+"与"+nameCopy+"\t"+"欧几里德距离"+"\t"+similary);
						//sb.append("\n");
						//System.out.println(name+"\t"+"与"+nameCopy+"\t"+"的皮尔逊相似度="+"\t"+pearsonCorrelationScore.sim_pearson(name,nameCopy));  
						//sb.append(name+"\t"+"与"+nameCopy+"\t"+"皮尔逊距离"+"\t"+pearsonCorrelationScore.sim_pearson(name,nameCopy));
						//sb.append("\n");
						TMdDistance distance = new TMdDistance();
						distance.setDistance(similary+"");
						distance.setFromWord(name);
						distance.setFromTable(tableName);
						distance.setLgorithms("欧几里德");
						distance.setToWord(nameCopy);
						distance.setToTable(tableCopyName);
						resultList.add(distance);
						/*
						TMdDistance distanceP = new TMdDistance();
						distanceP.setFromWord(name);
						distanceP.setFromTable(tableName);
						distanceP.setDistance(pearsonCorrelationScore.sim_pearson(name,nameCopy)+"");
						distanceP.setLgorithms("皮尔逊");
						distanceP.setToWord(nameCopy);
						distanceP.setToTable(tableCopyName);
						resultList.add(distanceP);
						*/
					}
					for (TMdDistance obj:resultList) {
						tMdSegmentVoteDAO.insert(obj);
					}
					//tMdSegmentVoteDAO.insert(obj);
					//#{fromWord}, #{toWord},#{lgorithms}, #{distance}
					//AiHttpClientMicTest.writeFile("/Users/bigdata/data/kind2.result"+i, sb.toString());
				}
			}
			//AiHttpClientMicTest.writeFile("/Users/bigdata/data/kind2.result", sb.toString());
		}
		
		/*
		SomSimlary som = new SomSimlary(distanceList);
		try {
			List<Map<String, Object>> listSom = SomSimlary.begin();
			//欧几里德
			EuclideanMetric em = new EuclideanMetric();
			
			if (listSom.size() > 1) {
				
				List<Map<String, Object>> listSomCopy = new ArrayList<Map<String, Object>>();
				listSomCopy.addAll(listSom);
				//StringBuffer sb = new StringBuffer();
				for (int i = 0; i < listSom.size(); i++) {
					if (listSomCopy.size() == 0) {
						continue;
					}
					Map<String, Object> map = listSomCopy.get(i);
					String name = map.get("name")+"";
					Double[] nameArr  = new Double[2];
					nameArr[0]= Double.parseDouble(map.get("x")+"");
					nameArr[1]= Double.parseDouble(map.get("y")+"");
					listSomCopy.remove(distanceList.get(i));
					if (listSomCopy.size() > 0) {
						//StringBuffer sb = new StringBuffer();
						List<TMdDistance> resultList = new ArrayList<TMdDistance>();
						for (Map<String, Object> copyMap:listSomCopy) {
							String nameCopy = copyMap.get("name")+"";
							Double[] nameArrCopy  = new Double[2];
							nameArrCopy[0]= Double.parseDouble(copyMap.get("x")+"");
							nameArrCopy[1]= Double.parseDouble(copyMap.get("y")+"");
							
							double similary = em.sim_distance(nameArr, nameArrCopy);
							//System.out.println(name+"\t"+"and"+nameCopy+"\t"+"SOM"+"\t"+similary);
							//sb.append(name+"\t"+"and"+nameCopy+"\t"+"SOM="+"\t"+similary);
							//sb.append("\n");
							TMdDistance distanceP = new TMdDistance();
							distanceP.setFromWord(name);
							distanceP.setDistance(similary+"");
							distanceP.setLgorithms("SOM");
							distanceP.setToWord(nameCopy);
							resultList.add(distanceP);
						}
						for (TMdDistance obj:resultList) {
							tMdSegmentVoteDAO.insert(obj);
						}
						//AiHttpClientMicTest.writeFile("/Users/bigdata/data/Som.result"+i, sb.toString());
					}
				}
				//AiHttpClientMicTest.writeFile("/Users/bigdata/data/Som.result", sb.toString());
			}
			
		}
		catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	}
}
