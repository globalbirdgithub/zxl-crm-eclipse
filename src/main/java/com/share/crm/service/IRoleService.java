package com.share.crm.service;

import java.util.List;
import java.util.Map;

import com.share.crm.domain.Role;

public interface IRoleService extends IBaseService<Role>{
	//保存角色权限中间表
	void saveRolePermissions(List<Map<String, Long>> rolePermissionMapList);
	//删除角色权限中间表
	void deleteRolePermissions(Long roleId);
	
}
