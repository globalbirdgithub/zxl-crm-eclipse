package com.share.crm.domain;
import java.util.Date;
/**
 * 员工模型
 * 
 * @author MrZhang
 * @date 2018年5月8日 下午6:43:27
 * @version V1.0
 */
public class Employee {
	private Long id;
	private String username;// 用户名，非空
	private String realName;// 真实姓名，非空
	private String password;// 密码，非空
	private String tel;// 电话，非空
	private String email;// 邮箱
	private Date inputTime = new Date();// 录入时间
	private Integer state = 0;// 状态（0：正常，-1：离职）
	private Department department;// 所属部门

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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

	public Date getInputTime() {
		return inputTime;
	}

	public void setInputTime(Date inputTime) {
		this.inputTime = inputTime;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	@Override
	public String toString() {
		return "Employee [id=" + id + ", username=" + username + ", realName=" + realName + ", password=" + password
				+ ", tel=" + tel + ", email=" + email + ", inputTime=" + inputTime + ", state=" + state + "]";
	}
}
