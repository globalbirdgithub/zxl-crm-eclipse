package com.share.crm.mapper;

import java.util.List;

import com.share.crm.domain.Department;

public interface DepartmentMapper extends BaseMapper<Department> {
	//获取部门树
	List<Department> getDepartmentTreeData();
}
