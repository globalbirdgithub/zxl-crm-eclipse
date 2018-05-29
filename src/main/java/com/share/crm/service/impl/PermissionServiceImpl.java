package com.share.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.share.crm.domain.Permission;
import com.share.crm.mapper.BaseMapper;
import com.share.crm.mapper.PermissionMapper;
import com.share.crm.service.IPermissionService;
@Service
public class PermissionServiceImpl extends BaseServiceImpl<Permission> implements IPermissionService{
	
	@Autowired
	private PermissionMapper permissionMapper;
	
	@Override
	protected BaseMapper<Permission> getBaseMapper() {
		return permissionMapper;
	}
	
}
