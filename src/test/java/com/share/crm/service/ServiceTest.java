package com.share.crm.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.share.crm.domain.Department;
import com.share.crm.domain.Employee;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class ServiceTest {
	@Autowired
	IEmployeeService employeeService;
	@Autowired
	IDepartmentService departmentService;
	@Test
	public void test() throws Exception {
		Employee employee = employeeService.get(1L);
		System.out.println(employee);
		Department department = departmentService.get(1L);
		System.out.println(department);
	}
}
