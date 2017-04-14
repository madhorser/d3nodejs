package test.com.primeton.dgs.ontology.dao;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang.StringUtils;


public class JaccardSimilarity {
	  public static void main(String[] args) {  
	        //要比较的两个字符串  
	        String str1 = "今天星期四";  
	        String str2 = "今天是星期五"; 
	        // 
	        //jaccardSimilarity(str1, str2, 1); 
/*	        jaccardSimilarity("axbcd", "15axc", 1); 
	        jaccardSimilarity("axcqx", "15axc", 1); */
	        
	        //System.out.println("字符串axbcd与15axc的比较, 相似度是：" + getSimilarity("今天星期四", "今天是星期五"));
	        //System.out.println("字符串axcqx与15axc的比较, 相似度是：" + getSimilarity("axcqx", "15axc"));
//	        String str3 = filterFileContent("C:\\Users\\Wyw\\Desktop\\gk");
	        //jaccardSimilarity(str3);
	        
	        String s1 = "T_MD_INSTANCE PK_MINSTANCE INSTANCE_ID INSTANCE_CODE INSTANCE_NAME CLASSIFIER_ID PARENT_ID NAMESPACE VER_ID START_TIME ISROOT";
	        String s2 = "T_MD_DEPENDENCY PK_MDEPENDENCY FROM_INSTANCE_ID FROM_CLASSIFIER_ID TO_INSTANCE_ID TO_CLASSIFIER_ID RELATIONSHIP START_TIME REL_TYPE REL_STATUS";
	        String s3 = "T_MD_COMPOSITION PK_MCOMPOSITION FATHER_INSTANCE_ID FATHER_CLASSIFIER_ID CHILD_INSTANCE_ID CHILD_CLASSIFIER_ID RELATIONSHIP START_TIME";
	       /* String s1 = "T_MD_INSTANCE";
	        String s2 = "T_MD_DEPENDENCY";
	        String s3 = "T_MD_COMPOSITION";*/
	        /*jaccardSimilarity(s1, s1, 1); 
	        jaccardSimilarity(s2, s1, 1); 
	        jaccardSimilarity(s3, s1, 1); 
	        jaccardSimilarity(s3, s2, 1); 
	        jaccardSimilarity("OPR_NO", "HOUSE", 1);*/
	       /* double[] vector1 = new double[2];
	        double[] vector2 = new double[2];
	        vector1[0] = 1;vector1[1] = 2;
	        vector2[0] = 2;vector2[1] = 1;
	        double dis = sim_distance(vector1, vector2);
	        System.out.println("距离=" + dis);*/
	        String in = "C:\\Users\\Wyw\\Desktop\\输入3.txt";
	        String out = "C:\\Users\\Wyw\\Desktop\\输出3.txt";
	        calculateDistance(in, out);
	        /*filterFileContent("C:\\Users\\Wyw\\Desktop\\jhx.sql");
	        
	        String src = filterFileContent("C:\\Users\\Wyw\\Desktop\\字段.txt");

	        String[] srcArr = src.split(",");
	        for (int i = 0; i < srcArr.length - 1; i++) {
	        	jaccardSimilarity(srcArr[i], src, 1);
	        }*/
	    }
	  
	  

	public static void jaccardSimilarity(String src) { 
		if(src == null || src.length() == 0) {
	 		return;
	 	}
        String[] srcArr = src.split(",");
        
        for (int i = 0; i < srcArr.length - 1; i++) {
            for (int j = 1; j < srcArr.length; j++) {
            	jaccardSimilarity(srcArr[i], srcArr[j], 1);
            }
        }
        
	}
	/**
	 * 
	 * @param src
	 * @param tar
	 * @param wordLen  分词个数
	 */
	 public static float jaccardSimilarity(String src, String tar, int wordLen) { 
		 
		 	if(src == null || src.length() == 0 || tar == null || tar.length() == 0 || wordLen <= 0) {
		 		return 0;
		 	}

	        //计算两个字符串的长度。  
	        int srcLen = src.length();  
	        int tarLen = tar.length(); 
	           
	        Map<String , Integer> wordMap = new HashMap<String , Integer>();
	        Map<String, String> srcWordMap = new HashMap<String, String>();
	        Map<String, String> tarWordMap = new HashMap<String, String>();

	        int totalCount = 0;
	        if (srcLen <= wordLen) {
	        	wordMap.put(src, 1);
	        	srcWordMap.put(src, "");
	        } else {
		        for (int i = 0; i <= srcLen - wordLen; i++) {  
		        	String subSrc = src.substring(i, i + wordLen);
		        	if (wordMap.containsKey(subSrc)) {
		        		int num = wordMap.get(subSrc);
			        	wordMap.put(subSrc, num + 1);
		        	} else {
			        	wordMap.put(subSrc, 1);
		        	}
		        	srcWordMap.put(subSrc, "");
		        }  
	        }

	        if (tarLen <= wordLen) {
	        	if (wordMap.containsKey(tar)) {
	        		int num = wordMap.get(tar);
	        		wordMap.put(tar, num + 1);
	        	} else {
	        		wordMap.put(tar, 1);
	        	}
	        	if (srcWordMap.containsKey(tar)) {
	        		
	        	}
	        	tarWordMap.put(src, "");
	        } else {
		        for (int i = 0; i <= tarLen - wordLen; i++) {  
		        	String subTar = tar.substring(i, i + wordLen);
		        	if (wordMap.containsKey(subTar)) {
		        		int num = wordMap.get(subTar);
		        		wordMap.put(subTar, num + 1);
		        	} else {
			        	wordMap.put(subTar, 1);
		        	}
		        	tarWordMap.put(subTar, "");
		        }  
	        }
	        totalCount = wordMap.size();
	        		
	        int sameCount = 0;
	        
	        if (!srcWordMap.isEmpty() & !tarWordMap.isEmpty()) {
        		Iterator<Entry<String, String>> srcIt = srcWordMap.entrySet().iterator();
        		Iterator<Entry<String, String>> tarIt;
        		while (srcIt.hasNext()) {
        			Entry<String, String> v = srcIt.next();
        			String vv = v.getKey();
        			tarIt = tarWordMap.entrySet().iterator();
            		while (tarIt.hasNext()) {
            			Entry<String, String> v1 = tarIt.next();
            			String vv1 = v1.getKey();
            			if (StringUtils.equals(vv, vv1)) {
            				sameCount ++;
            			}
            		}
        			
        		}
        		
	        }
	        
	        float similarity = 0;
	        if (totalCount != 0) {
		        //float similarity = (float) (tarArr.length + srcArr.length - size) / size;
	            similarity = (float) sameCount / totalCount;
		        
		        System.out.println("字符串\t\"" + src + "\"\t与\t\"" + tar+"\"\t的比较,相似度：\t" + similarity);
	        }
	        return similarity;
	   }
	 
	 
	  
	    /** 
	     * 根据输入的Unicode字符，获取它的GB2312编码或者ascii编码， 
	     *  
	     * @param ch 
	     *            输入的GB2312中文字符或者ASCII字符(128个) 
	     * @return ch在GB2312中的位置，-1表示该字符不认识 
	     */  
	    public static short getGB2312Id(char ch) {  
	        try {  
	            byte[] buffer = Character.toString(ch).getBytes("GB2312");  
	            if (buffer.length != 2) {  
	                // 正常情况下buffer应该是两个字节，否则说明ch不属于GB2312编码，故返回'?'，此时说明不认识该字符  
	                return -1;  
	            }  
	            int b0 = (int) (buffer[0] & 0x0FF) - 161; // 编码从A1开始，因此减去0xA1=161  
	            int b1 = (int) (buffer[1] & 0x0FF) - 161; // 第一个字符和最后一个字符没有汉字，因此每个区只收16*6-2=94个汉字  
	            return (short) (b0 * 94 + b1);  
	        } catch (UnsupportedEncodingException e) {  
	            e.printStackTrace();  
	        }  
	        return -1;  
	    }  
	    /**
	     * 读取文件内容，组装成以逗号间隔的字符串.
	     * @param filePath 文件路径
	     * @return
	     */
		public static String filterFileContent(String filePath) {
	    	String retStr = "";
			FileInputStream f = null;
			BufferedReader dr = null;
			try {
				f = new FileInputStream(filePath); 
				dr = new BufferedReader(new InputStreamReader(f));   
				String temp = "";
				while((temp = dr.readLine()) != null){
					if (StringUtils.isNotBlank(temp)) {
						if (StringUtils.isNotBlank(retStr)) {
							retStr += ",";
						}
						retStr += temp;
						if (temp.contains("DROP")) {
		        	        System.out.println(temp);
						}
					}
				}
			} catch (Exception e) {
				
			} finally {
				try {
					f.close();
					dr.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			return retStr;
		}
		  
	    /**
	     * 读取文件内容，组装成以逗号间隔的字符串.
	     * @param inputFile 文件路径
	     * @param outputFile 文件路径
	     * @return
	     */
		public static void calculateDistance(String inputFile, String outputFile) {
			FileInputStream f = null;
			BufferedReader dr = null;
			double[] vector;
			Map<String, double[]> m = new HashMap<String, double[]>();
			Map<String, double[]> m1 = new HashMap<String, double[]>();
			try {
				f = new FileInputStream(inputFile); 
				dr = new BufferedReader(new InputStreamReader(f));   
				String temp = "";
				int i = 0;
				while((temp = dr.readLine()) != null) {
					if (StringUtils.isNotBlank(temp)) {
						vector = new double[7];
						//String[] v = temp.split("	"); 
						String[] v = temp.split(" "); //V0:序号、V1：字段id、V2：字段（code）、V3：对比字符串（表和字段）：
						vector[0] = Double.valueOf(v[4]);//表名相似度
						vector[1] = Double.valueOf(v[4]);//字段名相似度
						vector[2] = Double.valueOf(v[5]);//长度
						vector[3] = Double.valueOf(v[6]);//类型
						vector[4] = Double.valueOf(v[7]);//是否为空
						vector[5] = Double.valueOf(v[8]);//字段备注
						vector[6] = Double.valueOf(v[9]);//表备注
						m.put(v[10] + "-" + v[2], vector);
						m1.put(v[10] + "-" + v[2], vector);
						System.out.println(i++ +" " + v[10] + "." + v[2]);
					}
				}
				String retStr = "";
				if (!m.isEmpty()) {
					int j = 0;
					Map<String, String> m2 = new HashMap<String, String>();
					String key = "";
					double[] value = new double[7];
					String key1 = "";
					double[] value1 = new double[7];
					
	        		Iterator<Entry<String, double[]>> it = m.entrySet().iterator();
	        		while (it.hasNext()) {
	        			Entry<String, double[]> v = it.next();
	        			key = v.getKey();
	        			value = v.getValue();
	        			
	        			if (key == null || value == null) {
	        				continue;
	        			}
	        			
		        		Iterator<Entry<String, double[]>> it1 = m1.entrySet().iterator();
		        		while (it1.hasNext()) {
		        			Entry<String, double[]> v1 = it1.next();
		        			key1 = v1.getKey();
		        			value1 = v1.getValue();
		        			
		        			if (key1 == null || value1 == null) {
		        				continue;
		        			}
		        			
		        			//相同表不对比
		        			if (key.split("-") !=null & key.split("-").length > 0 & key.split("-")[0] != null
		        					& key1.split("-") !=null & key1.split("-").length > 0 & key1.split("-")[0] != null 
		        					& key.split("-")[0].equals(key1.split("-")[0])) {
		        				continue;
		        			}
		        			

		        			//数据类型不同不对比
		        			if (value[3] != value1[3]) {
		        				continue;
		        			}
		        			
		        			//A-B对比后，B-A不比对
		        			if (StringUtils.isNotBlank(m2.get(key1)) & StringUtils.contains(m2.get(key1), key)) {
		        				continue;
		        			}
		        			m2.put(key, m2.get(key) + "," + key1);
		        			
		        			float tableDistance = jaccardSimilarity(key.split("-")[0], key1.split("-")[0], 1);
		        			float columnDistance = jaccardSimilarity(key.split("-")[1], key1.split("-")[1], 1);
		        			value[0] = tableDistance;value[1] = columnDistance;
		        			value1[0] = 0;value1[1] = 0;
		        			double distance = sim_distance(value, value1);
		        	        System.out.println(j++ + "\t" + key + "\t和\t" + key1 + "\t距离=\t" + distance);
		        	        retStr += key.split("-")[0]  + "\t" + key.split("-")[1]  + "\t" + key1.split("-")[0]  + "\t" + key1.split("-")[1] + "\t" + distance + "\t" + tableDistance + "\t" + columnDistance;
		        	        retStr += "\n";
		        		}
	        		}
				}
				writeFile(outputFile, retStr);
			} catch (Exception e) {
    	        System.out.println(e.toString());
			} finally {
				try {
					f.close();
					dr.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}		
		
		  /** 
	     * 两个向量可以为任意维度，但必须保持维度相同，表示n维度中的两点 
	     *  
	     * @param vector1 
	     * @param vector2 
	     * @return 两点间距离 
	     */  
	    public static double sim_distance(double[] vector1, double[] vector2) {  
	        double distance = 0;  
	          
	        if (vector1.length == vector2.length) {  
	            for (int i = 0; i < vector1.length; i++) {  
	                double temp = Math.pow((vector1[i] - vector2[i]), 2);  
	                distance += temp;  
	            }  
	            distance = Math.sqrt(distance);  
	        }  
	        return distance;  
	    }  	  
	    
	    /**
		 * 写文件
		 * 
		 * @param filePathAndName
		 * @param fileContent
		 */
		public static void writeFile(String filePathAndName, String fileContent) {
			/*System.out.println("====fileContent====="+fileContent);*/
			try {
				File f = new File(filePathAndName);
				if (!f.exists()) {
					f.createNewFile();
				}
				OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(f), "UTF-8");
				FileWriter writer = new FileWriter(filePathAndName, true);
				writer.write(fileContent);
				writer.close();
			}
			catch (Exception e) {
				System.out.println("写文件内容操作出错");
				e.printStackTrace();
			}
		}
}
