package com.share.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.share.crm.domain.SystemDictionary;
import com.share.crm.mapper.BaseMapper;
import com.share.crm.mapper.SystemDictionaryMapper;
import com.share.crm.service.ISystemDictionaryService;
@Service
public class SystemDictionaryServiceImpl extends BaseServiceImpl<SystemDictionary> implements ISystemDictionaryService{
	@Autowired
	private SystemDictionaryMapper dictionaryMapper;
	@Override
	protected BaseMapper<SystemDictionary> getBaseMapper() {
		return dictionaryMapper;
	}

}
