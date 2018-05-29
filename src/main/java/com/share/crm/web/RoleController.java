package com.share.crm.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.share.crm.domain.Role;
import com.share.crm.query.PageList;
import com.share.crm.query.RoleQuery;
import com.share.crm.service.IRoleService;
import com.share.crm.util.AjaxResult;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private IRoleService roleService;
	
	@RequestMapping("/index")
	public String index(){
		return "role";
	}
	
	@RequestMapping("/list")
	@ResponseBody
	public PageList list(RoleQuery roleQuery){
		PageList pageList = roleService.findByQuery(roleQuery);
		return pageList;
	}
	@RequestMapping(value="/delete/{id}",method=RequestMethod.GET)
	@ResponseBody
	public AjaxResult delete(@PathVariable(value="id") Long id){
		try {
			roleService.deleteRolePermissions(id);
			roleService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除失败！"+e.getMessage());
		}
	}
	@RequestMapping("/save")
	@ResponseBody
	public AjaxResult save(Role role){
		try {
			if(role.getId()==null){
				roleService.save(role);//先保存本身
				List<Map<String, Long>> rolePermissionMapList = role.getRolePermissionMapList();//再保存中间表
				if(rolePermissionMapList.size()>0){
					roleService.saveRolePermissions(rolePermissionMapList);
				}
			}else{
				roleService.update(role);
				//中间表：先删除再添加
				roleService.deleteRolePermissions(role.getId());
				List<Map<String, Long>> rolePermissionMapList = role.getRolePermissionMapList();//再保存中间表
				if(rolePermissionMapList.size()>0){
					roleService.saveRolePermissions(rolePermissionMapList);
				}
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败！"+e.getMessage());
		}
	}
}
