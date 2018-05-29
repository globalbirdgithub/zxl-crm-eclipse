package com.share.crm.domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 角色
 * @author MrZhang
 * @date 2018年5月26日 下午11:45:49
 * @version V1.0
 */
public class Role {
	private Long id;
	private String name;
	private String sn;// 编号
	private List<Permission> permissions = new ArrayList<>();//权限（多对多：双向多对一）
	
	public List<Map<String,Long>> getRolePermissionMapList(){//处理角色-权限中间表
		List<Map<String,Long>> rolePermissionsIdMapList = new ArrayList<>();
		if(permissions.size()==0){
			return rolePermissionsIdMapList;
		}
		for (Permission permission : permissions) {
			Map<String,Long> rolePermissionsIdMap = new HashMap<>();
			rolePermissionsIdMap.put("roleId", this.id);
			rolePermissionsIdMap.put("permissionId", permission.getId());
			rolePermissionsIdMapList.add(rolePermissionsIdMap);
		}
		return rolePermissionsIdMapList;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}
	
	public List<Permission> getPermissions() {
		return permissions;
	}

	public void setPermissions(List<Permission> permissions) {
		this.permissions = permissions;
	}

	@Override
	public String toString() {
		return "Role [id=" + id + ", name=" + name + ", sn=" + sn + "]";
	}

}
