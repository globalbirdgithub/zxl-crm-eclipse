package com.share.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.share.crm.domain.Employee;
import com.share.crm.mapper.BaseMapper;
import com.share.crm.mapper.EmployeeMapper;
import com.share.crm.service.IEmployeeService;

@Service
public class EmployeeServiceImpl extends BaseServiceImpl<Employee> implements IEmployeeService {

	@Autowired
	private EmployeeMapper employeeMapper;

	@Override
	protected BaseMapper<Employee> getBaseMapper() {
		return employeeMapper;
	}
	
}
