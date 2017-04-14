package test.com.primeton.dgs.ontology.dao;

import java.sql.SQLException;   
import java.sql.Statement;   
import java.sql.Connection;   
import java.sql.DriverManager;   
import java.sql.ResultSet;   
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;   
   

   
public class OracleDao {   
       
       
    private Statement stmt = null;   
       
    private  ResultSet rs = null;   
       
    private Connection conn = null;   
       
    public OracleDao(){   
        this.getConnection();   
    }   
       
    public void getConnection(){   
        try{   
            Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();    
            String url="jdbc:oracle:thin:@192.168.10.217:1521:orcl"; //orcl为数据库的SID    
            String user="metacube";    
            String password="metacube";    
            //String url="jdbc:oracle:thin:@192.168.10.249:1521:orcl"; //orcl为数据库的SID    
            //String user="metacube7";    
            //String password="metacube7";   
            //String url="jdbc:oracle:thin:@192.168.10.144:1521:orcl"; //orcl为数据库的SID    
            //String user="dgs";    
            //String password="dgs";  
            conn= DriverManager.getConnection(url,user,password);    
        }catch (Exception e) {   
            System.out.println(e);   
        }   
    }   
       
    public List<Map<String,Object>> getRes(int flag,String arry[],String sql){   
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();    
        try {   
            stmt = conn.createStatement();   
            rs = stmt.executeQuery(sql);   
            while (rs.next()) {  
            	Map<String,Object> temp = new HashMap<String,Object>();
            	for(String s:arry){
            		//System.err.println(rs.getObject(s));
            		
            		if(0==flag || 1==flag){
            			temp.put(s, rs.getObject(s));
            			//System.err.println(rs.getString(2)+"==="+rs.getObject(s));
            		}else if(2==flag){
            			//System.err.println(s+"==="+rs.getObject(s));
            			temp.put(s, rs.getObject(s));
            		}
            	}
            	list.add(temp);
            }   
            
        } catch (SQLException e) {   
            list = null ;   
            e.printStackTrace();   
        }finally{   
            this.close(conn, stmt, rs);   
        }   
        return list;   
    }   
       
    public int delete(String sql) throws SQLException{   
        int number = 0 ;   
        try{   
            stmt = conn.createStatement();   
               
            number = stmt.executeUpdate(sql);   
               
            conn.commit();   
        }catch(Exception e){   
            System.out.println(e);   
            conn.rollback();   
            number = 0 ;   
        }finally{   
            this.close(conn, stmt, rs);   
        }   
        return number;   
    }   
       
    public void close(Connection conn , Statement stmt, ResultSet rs){   
        try{   
            if(rs != null){   
                rs.close();   
                rs = null ;   
            }   
            if(stmt != null){   
                stmt.close();   
                stmt = null ;   
            }   
            if(conn != null){   
                conn.close();   
                conn = null;   
            }   
               
        }catch(Exception e){   
            System.out.println(e);   
        }   
    }   
       
} 
