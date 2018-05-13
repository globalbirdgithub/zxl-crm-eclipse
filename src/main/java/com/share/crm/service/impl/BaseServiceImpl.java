package com.share.crm.service.impl;

import java.io.Serializable;
import java.util.List;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.share.crm.mapper.BaseMapper;
import com.share.crm.service.IBaseService;

@Transactional(readOnly = true, propagation = Propagation.SUPPORTS)
public abstract class BaseServiceImpl<T> implements IBaseService<T> {
	// 获取Mapper(spring4之后可动态注入，即注入BaseMapper，自动获取运行时类)
	protected abstract BaseMapper<T> getBaseMapper();

	@Transactional
	public void save(T t) {
		getBaseMapper().insert(t);
	}

	@Transactional
	public void delete(Serializable id) {
		getBaseMapper().delete(id);
	}

	@Transactional
	public void update(T t) {
		getBaseMapper().update(t);
	}
	
	public T get(Serializable id) {
		return getBaseMapper().get(id);
	}

	public List<T> getAll() {
		return getBaseMapper().getAll();
	}

}
