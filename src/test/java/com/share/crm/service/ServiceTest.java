package com.share.crm.service;

import static org.junit.Assert.*;

import java.util.List;

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
	public void save() throws Exception {
		Employee employee2 = new Employee();
		employee2.setUsername("xxxxxxxxxxxx");
		employee2.setPassword("xxxxxxxxxxxxx");
		employeeService.save(employee2);
	}
	@Test
	public void delete() throws Exception {
		employeeService.delete(81L);
	}
	@Test
	public void update() throws Exception {
		Employee employee = employeeService.get(80L);
		employee.setUsername("aaa");
		employeeService.update(employee);
	}
	@Test
	public void getAll() throws Exception {
		List<Employee> all = employeeService.getAll();
		for (Employee employee : all) {
			System.out.println(employee.getUsername());
		}
	}
}
