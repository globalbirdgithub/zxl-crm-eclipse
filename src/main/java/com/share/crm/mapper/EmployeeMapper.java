package com.share.crm.mapper;

import com.share.crm.domain.Employee;

public interface EmployeeMapper extends BaseMapper<Employee> {
	
	//登录
	Employee login(String username);
	//离职
	void leave(Long id);
}
