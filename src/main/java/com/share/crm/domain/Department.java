package com.share.crm.domain;

import java.util.ArrayList;
import java.util.List;

/**
 * 部门
 * 
 * @author MrZhang
 * @date 2018年5月8日 下午6:47:24
 * @version V1.0
 */
public class Department {
	private Long id;
	private String name;// 部门名称，非空
	private String sn;// 部门编号，非空
	private Integer state = 0;// 状态 0 正常 ，-1停用 数字
	private String dirPath;// 部门路径，用于查询后代部门
	private Employee manager;// 部门经理
	private Department parent;// 上级部门
	private List<Department> children = new ArrayList<Department>();// 子级部门
	//提供给easyui
	public String getText(){
		return name;
	}
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	public String getDirPath() {
		return dirPath;
	}

	public void setDirPath(String dirPath) {
		this.dirPath = dirPath;
	}

	public Employee getManager() {
		return manager;
	}

	public void setManager(Employee manager) {
		this.manager = manager;
	}

	public Department getParent() {
		return parent;
	}

	public void setParent(Department parent) {
		this.parent = parent;
	}

	public List<Department> getChildren() {
		return children;
	}

	public void setChildren(List<Department> children) {
		this.children = children;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "Department [id=" + id + ", name=" + name + ", sn=" + sn + ", state=" + state + ", dirPath=" + dirPath
				+", 父部门："+parent+" ,"+"子部门："+children.size()+ "]";
	}
}
