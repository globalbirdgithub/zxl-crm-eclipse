package com.share.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.share.crm.domain.SystemDictionaryItem;
import com.share.crm.mapper.BaseMapper;
import com.share.crm.mapper.SystemDictionaryItemMapper;
import com.share.crm.service.ISystemDictionaryItemService;
@Service
public class SystemDictionaryItemServiceImpl extends BaseServiceImpl<SystemDictionaryItem> implements ISystemDictionaryItemService{
	@Autowired
	private SystemDictionaryItemMapper systemDictionaryItemMapper;
	@Override
	protected BaseMapper<SystemDictionaryItem> getBaseMapper() {
		return systemDictionaryItemMapper;
	}

}
