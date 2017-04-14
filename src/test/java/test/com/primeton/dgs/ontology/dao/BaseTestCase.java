package test.com.primeton.dgs.ontology.dao;

import java.text.SimpleDateFormat;

import org.apache.log4j.Logger;
import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.test.context.ContextConfiguration;  
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;  

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath*:applicationContext-ontology.xml")
@Transactional
@TransactionConfiguration(transactionManager = "transactionManager", defaultRollback = false)
public class BaseTestCase extends AbstractTransactionalJUnit4SpringContextTests {  
	private static final Logger log = Logger.getLogger(BaseTestCase.class);
	
	public SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	

	
	
	@Before
	public void setUp(){

	
	}
	
	@After
	public void tearDown(){
		
	}
	
	@Test
	//@Ignore
	public void test(){}
}