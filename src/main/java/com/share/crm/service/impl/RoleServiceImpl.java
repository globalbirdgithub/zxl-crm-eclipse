package com.share.crm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.share.crm.domain.Role;
import com.share.crm.mapper.BaseMapper;
import com.share.crm.mapper.RoleMapper;
import com.share.crm.service.IRoleService;
@Service
public class RoleServiceImpl extends BaseServiceImpl<Role> implements IRoleService {

	@Autowired
	private RoleMapper roleMapper;

	@Override
	protected BaseMapper<Role> getBaseMapper() {
		return roleMapper;
	}
	
	@Override
	public void saveRolePermissions(List<Map<String, Long>> rolePermissionMapList) {
		roleMapper.saveRolePermissions(rolePermissionMapList);
	}

	@Override
	public void deleteRolePermissions(Long roleId) {
		roleMapper.deleteRolePermissions(roleId);
	}

}
