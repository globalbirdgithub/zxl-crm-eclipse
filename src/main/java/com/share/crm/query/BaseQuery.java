package com.share.crm.query;

/**
 * 封装查询条件:分页查询、关键字查询、排序
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
	// 查询关键字
	private String q;
	// 排序列：默认id
	protected String sort = "id";
	// 排序方式:默认升序
	protected String order = "asc";

	// 分页起始索引
	public int getStartIndex() {
		return (page - 1) * rows;
	}

	// 分页每页行数
	public int getPageSize() {
		return rows;
	}

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

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}
}
