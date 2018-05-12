package com.share.crm.service.impl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.share.crm.domain.Department;
import com.share.crm.mapper.BaseMapper;
import com.share.crm.mapper.DepartmentMapper;
import com.share.crm.service.IDepartmentService;

@Service
public class DepartmentServiceImpl extends BaseServiceImpl<Department> implements IDepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Override
	protected BaseMapper<Department> getBaseMapper() {
		return departmentMapper;
	}

}
