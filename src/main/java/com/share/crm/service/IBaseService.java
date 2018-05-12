package com.share.crm.service;

import java.io.Serializable;
import java.util.List;

public interface IBaseService<T> {
	//===================基本增删改查====================
	void save(T t);

	void delete(Serializable id);

	void update(T t);

	T get(Serializable id);

	List<T> getAll();
}
