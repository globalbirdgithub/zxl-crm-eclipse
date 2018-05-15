package com.share.crm.query;

import java.util.ArrayList;
import java.util.List;

/**
 * 封装查询结果
 * @author MrZhang
 * @date 2018年5月14日 上午10:39:33
 * @version V1.0
 */
public class PageList {
	// 总条数
	private long total = 0;
	// 分页数据
	private List rows = new ArrayList<>();

	public PageList() {
	}

	public PageList(long total, List rows) {
		this.total = total;
		this.rows = rows;
	}

	public Long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}

}
