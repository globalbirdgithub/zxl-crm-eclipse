package com.share.crm.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.share.crm.domain.Employee;
import com.share.crm.service.IEmployeeService;

@Controller
@RequestMapping("/employee")
public class EmployeeController {
	
	@Resource
	private IEmployeeService employeeService;
	
	@RequestMapping("/index")
	public String index(){
		return "/employee";
	}
	@RequestMapping("/list")
	@ResponseBody
	public List<Employee> list(){
		return employeeService.getAll();
	}
}
