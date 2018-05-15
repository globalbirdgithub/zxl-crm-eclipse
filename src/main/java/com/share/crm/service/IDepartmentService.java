package com.share.crm.service;

import java.util.List;

import com.share.crm.domain.Department;

public interface IDepartmentService extends IBaseService<Department> {
	//获取部门树
	List<Department> getDepartmentTreeData();
}
