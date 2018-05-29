package com.share.crm.web;
import javax.annotation.Resource;
import javax.websocket.server.PathParam;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.share.crm.domain.Employee;
import com.share.crm.query.EmployeeQuery;
import com.share.crm.query.PageList;
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
	public PageList list(EmployeeQuery employeeQuery){
		PageList pageList = employeeService.findByQuery(employeeQuery);
		return pageList;
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
	@RequestMapping("/leave")
	@ResponseBody
	public AjaxResult leave(@PathParam(value="id")Long id){
		try {
			employeeService.leave(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("离职失败："+e.getMessage());
		}
	}
}
