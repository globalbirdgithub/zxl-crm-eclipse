package com.share.crm.domain;

/**
 * 权限
 * 
 * @author MrZhang
 * @date 2018年5月26日 上午8:10:57
 * @version V1.0
 */
public class Permission {

	private Long id;
	// 权限名称
	private String name;
	// 资源地址
	private String resource;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getResource() {
		return resource;
	}

	public void setResource(String resource) {
		this.resource = resource;
	}

	@Override
	public String toString() {
		return "Permission [id=" + id + ", name=" + name + ", resource=" + resource + "]";
	}

}
