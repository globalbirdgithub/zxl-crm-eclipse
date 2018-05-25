package com.share.crm.query;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class EmployeeQuery extends BaseQuery {
	// 状态查询参数
	private int state = -1;
	// 时间查询参数
	private Date beginDate;
	private Date endDate;
	// 高级查询参数
	private String username;
	private String realName;
	private String tel;
	private String email;
	private Long departmentId;

	/**
	 * 覆写父类获取排序列名方法
	 * 
	 * @return String 2018年5月16日上午11:44:22
	 */
	@Override
	public String getSort() {
		if ("department".equals(sort)) {
			return "dname";
		}
		return super.sort;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Long getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Long departmentId) {
		this.departmentId = departmentId;
	}

}
