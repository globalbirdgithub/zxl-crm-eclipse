package com.share.crm.web;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.share.crm.domain.Employee;
import com.share.crm.service.IEmployeeService;
import com.share.crm.util.AjaxResult;

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
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxResult delete(Long id){
		try {
			employeeService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			return new AjaxResult("删除失败！"+e.getMessage());
		}
	}
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(Employee employee){
		try {
			if (employee.getId() == null) {
				employeeService.save(employee);
			} else {
				employeeService.update(employee);
			} 
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败！"+e.getMessage());
		}
	}
}
