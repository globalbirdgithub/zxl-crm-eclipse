package com.share.crm.domain;

/**
 * 数据字典明细
 * 
 * @author MrZhang
 * @date 2018年5月27日 上午8:04:21
 * @version V1.0
 */
public class SystemDictionaryItem {
	private Long id;
	private String name;
	private String intro;// 描述
	private Integer sequence;// 字典明细序号
	private SystemDictionary parent;// 字典目录

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

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Integer getSequence() {
		return sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}

	public SystemDictionary getParent() {
		return parent;
	}

	public void setParent(SystemDictionary parent) {
		this.parent = parent;
	}

	@Override
	public String toString() {
		return "SystemDictionaryItem [id=" + id + ", name=" + name + ", intro=" + intro + ", sequence=" + sequence
				+ ", parent=" + parent + "]";
	}

}
