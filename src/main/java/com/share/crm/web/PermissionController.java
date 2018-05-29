package com.share.crm.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.share.crm.domain.Permission;
import com.share.crm.query.PageList;
import com.share.crm.query.PermissionQuery;
import com.share.crm.service.IPermissionService;
import com.share.crm.util.AjaxResult;

@Controller
@RequestMapping("/permission")
public class PermissionController {
	@Autowired
	private IPermissionService permissionService;
	
	@RequestMapping("/index")
	public String index(){
		return "permission";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageList list(PermissionQuery permissionQuery){
		PageList pageList = permissionService.findByQuery(permissionQuery);
		return pageList;
	}
	@RequestMapping(value="/delete/{id}",method=RequestMethod.GET)
	@ResponseBody
	public AjaxResult delete(@PathVariable(value="id") Long id){
		try {
			permissionService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除失败！"+e.getMessage());
		}
	}
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(Permission permission){
		try {
			if(permission.getId()==null){
				permissionService.save(permission);
			}else{
				permissionService.update(permission);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败！"+e.getMessage());
		}
	}
}
