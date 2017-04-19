package com.primeton.dgs.ontology.pojos;

/**
 * 术语提取任务
 */
public class TSegmentTask implements java.io.Serializable {
	private static final long serialVersionUID = 1L;

	protected String taskId;
	protected String taskName;
	//术语来源库
	protected String segmentFrom;
	
	protected String insertTime;
	protected String updateTime;
	//分词规则
	protected String segmentRule;
	
	protected String status;
	protected String taskResult;
	
	public String getTaskId() {
		return taskId;
	}
	
	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}
	
	public String getTaskName() {
		return taskName;
	}
	
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	
	public String getSegmentFrom() {
		return segmentFrom;
	}
	
	public void setSegmentFrom(String segmentFrom) {
		this.segmentFrom = segmentFrom;
	}
	
	public String getInsertTime() {
		return insertTime;
	}
	
	public void setInsertTime(String insertTime) {
		this.insertTime = insertTime;
	}
	
	public String getUpdateTime() {
		return updateTime;
	}
	
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	
	public String getSegmentRule() {
		return segmentRule;
	}
	
	public void setSegmentRule(String segmentRule) {
		this.segmentRule = segmentRule;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getTaskResult() {
		return taskResult;
	}
	
	public void setTaskResult(String taskResult) {
		this.taskResult = taskResult;
	}

}