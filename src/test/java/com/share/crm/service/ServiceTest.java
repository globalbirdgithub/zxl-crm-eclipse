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
import com.share.crm.domain.Permission;
import com.share.crm.domain.Role;
import com.share.crm.domain.SystemDictionaryItem;
import com.share.crm.query.BaseQuery;
import com.share.crm.query.PageList;
import com.share.crm.query.SystemDictionaryItemQuery;

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
	@Test
	public void findByQuery() throws Exception {
		BaseQuery baseQuery = new BaseQuery();
		PageList pageList = departmentService.findByQuery(baseQuery);
		Long total = pageList.getTotal();
		System.out.println(total);
		List<Department> rows = pageList.getRows();
		for (Department object : rows) {
			System.out.println("本部门："+object);
			System.out.println("父部门："+object.getParent());
			System.out.println("部门经理："+object.getManager().getRealName());
			System.out.println("xxxxxxxxxxxxxxxxxxxxxx");
		}
	}
	@Test
	public void findByQuery2() throws Exception {
		BaseQuery baseQuery = new BaseQuery();
		PageList pageList = employeeService.findByQuery(baseQuery);
		Long total = pageList.getTotal();
		System.out.println(total);
		List<Employee> rows = pageList.getRows();
		for (Employee object : rows) {
			System.out.println("员工："+object);
			System.out.println("员工部门："+object.getDepartment());
			System.out.println("xxxxxxxxxxxxxxxxxxxxxx");
		}
	}
	@Test
	public void testName() throws Exception {
		Department department = departmentService.get(6L);
		System.out.println(department);
		List<Department> children = department.getChildren();
		System.out.println(children.size());
	}
	@Test
	public void DepartmentTree() throws Exception {
		List<Department> departmentTreeData = departmentService.getDepartmentTreeData();
		for (Department department : departmentTreeData) {
			System.out.println("父部门："+department);
			List<Department> children = department.getChildren();
			System.out.println("------------");
			for (Department department2 : children) {
				System.out.println("子部门："+department2);
			}
			System.out.println("=============");
		}
	}
	@Autowired
	private IPermissionService permissionService;
	@Autowired
	private IRoleService roleService;
	@Test
	public void testRole() throws Exception {
		Role role = new Role();
		role.setName("角色测试");
		roleService.save(role);
	}
	@Test
	public void testP() throws Exception {
		permissionService.delete(37L);
	}
	@Test
	public void testP2() throws Exception {
		Role role = roleService.get(8L);
		role.setName("角色测试1");
		roleService.update(role);
	}
	@Test
	public void testP3() throws Exception {
		Role role = roleService.get(8L);
		System.out.println(role);
		List<Role> list = roleService.getAll();
		for (Role role2 : list) {
			System.out.println(role2);
		}
	}
	@Test
	public void testP4() throws Exception {
		BaseQuery baseQuery = new BaseQuery();
		baseQuery.setPage(1);
		baseQuery.setRows(5);
		PageList pageList = roleService.findByQuery(baseQuery);
		System.out.println(pageList.getTotal());
		List rows = pageList.getRows();
		for (Object object : rows) {
			System.out.println(object);
		}
	}
	@Test
	public void testP5() throws Exception {
		roleService.delete(8L);
	}
	@Autowired
	private ISystemDictionaryItemService systemDictionaryItemService;
	@Test
	public void testS() throws Exception {
		PageList pageList = systemDictionaryItemService.findByQuery(new SystemDictionaryItemQuery());
		Long total = pageList.getTotal();
		System.out.println(total);
		List rows = pageList.getRows();
		for (Object object : rows) {
			System.out.println(object);
		}
	}
	@Test
	public void testP8() throws Exception {
		PageList pageList = roleService.findByQuery(new BaseQuery());
		System.out.println(pageList.getTotal());
		List<Role> rows = pageList.getRows();
		for (Role object : rows) {
			System.out.println(object);
			List<Permission> permissions = object.getPermissions();
			for (Permission permission : permissions) {
				System.out.println(permission);
			}
		}
	}
}
