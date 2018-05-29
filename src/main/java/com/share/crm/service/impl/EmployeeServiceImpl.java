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
	//登录
	@Override
	public Employee login(String username, String password) {
		Employee loginUser = employeeMapper.login(username);
		if(loginUser==null || !loginUser.getPassword().equals(password)){
			throw new RuntimeException("用户名或密码错误！");
		}
		if(loginUser.getState()==null || loginUser.getState()==-1){
			throw new RuntimeException("无法访问！");
		}
		return loginUser;
	}
	//离职
	@Override
	public void leave(Long id) {
		employeeMapper.leave(id);
	}
	
}
