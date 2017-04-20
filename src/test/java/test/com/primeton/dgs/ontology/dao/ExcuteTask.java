package test.com.primeton.dgs.ontology.dao;


/**
 * 扫描任务表，执行术语提取任务.
 * <p>
 * Copyright: Copyright (c) 2017年4月20日 上午10:18:02
 * <p>
 * Company: 普元信息技术股份有限公司
 * <p>
 * @version 1.0.0
 */
public class ExcuteTask implements Runnable {

	//查询出所有待执行的术语提取任务
    private int time=1;
    private String id = "001";
    public void setTime(int time) {
        this.time = time;
    }
    
    @Override
    public void run() {
    	SegmentTaskDao segmentTaskDao = new SegmentTaskDao();
    	segmentTaskDao.queryTask();

        synchronized(this){
            s.notify();
            System.out.println("我唤醒了002！");
            System.out.println("我存入了id"+id);
            s.setSource(id);
        }
    }

}