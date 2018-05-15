package com.share.crm.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.share.crm.domain.Department;
import com.share.crm.query.DepartmentQuery;
import com.share.crm.query.PageList;
import com.share.crm.service.IDepartmentService;
import com.share.crm.util.AjaxResult;

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
	public PageList list(DepartmentQuery departmentQuery){
		PageList pageList = departmentService.findByQuery(departmentQuery);
		return pageList;
	}
	@RequestMapping("/delete")
	@ResponseBody
	public AjaxResult delete(Long id){
		try {
			departmentService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			return new AjaxResult("操作失败！"+e.getMessage());
		}
	}
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult delete(Department department){
		try {
			if(department.getId()==null){
				departmentService.save(department);
			}else{
				departmentService.update(department);
			}
			return new AjaxResult();
		} catch (Exception e) {
			return new AjaxResult("操作失败！"+e.getMessage());
		}
	}
	@RequestMapping("/departmentTree")
	@ResponseBody
	public List<Department> departmentTree(){
		return departmentService.getDepartmentTreeData();
	}
}
