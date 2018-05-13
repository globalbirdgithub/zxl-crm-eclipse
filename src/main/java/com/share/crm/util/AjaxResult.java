package com.share.crm.util;
/**
 * 封装非查询类操作结果信息
 * @author MrZhang
 * @date 2018年5月12日 下午11:30:44
 * @version V1.0
 */
public class AjaxResult {
	private boolean success = true;
	private String message = "操作成功！";

	// 操作成功
	public AjaxResult() {
	}

	// 操作失败
	public AjaxResult(String message) {
		this.success = false;
		this.message = message;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
