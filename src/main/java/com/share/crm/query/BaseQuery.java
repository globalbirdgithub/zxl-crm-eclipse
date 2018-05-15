package com.share.crm.query;

/**
 * 封装查询条件
 * 
 * @author MrZhang
 * @date 2018年5月14日 上午10:40:02
 * @version V1.0
 */
public class BaseQuery {
	// 当前页
	private int page = 1;
	// 每页条数
	private int rows = 10;

	// 起始索引
	public int getStartIndex() {
		return (page - 1) * rows;
	}

	// 每页行数
	public int getPageSize() {
		return rows;
	}

	// 关键字
	private String q;

	public String getQ() {
		return q;
	}

	public void setQ(String q) {
		this.q = q;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}
}
