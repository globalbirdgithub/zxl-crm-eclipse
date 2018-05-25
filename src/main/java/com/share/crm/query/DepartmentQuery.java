package com.share.crm.query;

public class DepartmentQuery extends BaseQuery {
	
	// 状态查询条件
	private int state = -2;
	// 高级查询条件
	private String name;
	private String sn;
	private Long managerId;
	private Long parentId;
	// 覆写父类排序列
	@Override
	public String getSort() {
		if ("parent".equals(super.sort)) {
			return "pname";
		}
		if ("manager".equals(sort)) {
			return "rname";
		}
		return super.sort;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public Long getManagerId() {
		return managerId;
	}

	public void setManagerId(Long managerId) {
		this.managerId = managerId;
	}

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

}
