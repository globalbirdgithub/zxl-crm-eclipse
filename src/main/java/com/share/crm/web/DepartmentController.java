package com.share.crm.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.share.crm.domain.Department;
import com.share.crm.service.IDepartmentService;

@Controller
@RequestMapping("/department")
public class DepartmentController {
	@Autowired
	private IDepartmentService departmentService;
	
	//跳转部门管理页面
	@RequestMapping("/index")
	public String index(){
		return "department";
	}
	//以json数据格式返回部门列表数据
	@RequestMapping("/list")
	@ResponseBody
	public List<Department> list(){
		return departmentService.getAll();
	}
}
