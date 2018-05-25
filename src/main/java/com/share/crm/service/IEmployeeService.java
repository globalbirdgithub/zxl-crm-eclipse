package com.share.crm.service;

import com.share.crm.domain.Employee;

public interface IEmployeeService extends IBaseService<Employee> {
	// 登录
	Employee login(String username, String password);
}
