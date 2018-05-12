package com.share.crm.mapper;

import java.io.Serializable;
import java.util.List;

/**
 * @author MrZhang
 * @date 2018年5月8日 下午7:06:19
 * @version V1.0
 */
public interface BaseMapper<T> {
	//===================基本增删改查====================
	void save(T t);

	void delete(Serializable id);

	void update(T t);

	T get(Serializable id);

	List<T> getAll();

}
