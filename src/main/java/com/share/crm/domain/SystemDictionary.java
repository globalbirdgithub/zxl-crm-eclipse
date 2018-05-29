package com.share.crm.domain;

/**
 * 数据字典目录
 * @author MrZhang
 * @date 2018年5月27日 上午12:27:00
 * @version V1.0
 */
public class SystemDictionary {
	private Long id;
	private String name;
	private String sn;// 编号
	private String intro;// 简介
	private Integer state = 1;// 1正常0停用
	

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

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	@Override
	public String toString() {
		return "SystemDictionary [id=" + id + ", name=" + name + ", sn=" + sn + ", intro=" + intro + ", state=" + state
				+ "]";
	}

}
