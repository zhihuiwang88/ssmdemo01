package com.nengliang.web.util;

import java.util.List;

public class JsonResult {

	/**
	 * JsonResult
	 * @author Dell
	 * @param status,状态码； message，返回信息，data，返回数据
	 */
	private Integer code;
	private String  msg;
	private Integer count;
    private Object data;
	public Integer getCode() {
		return code;
	}
	public void setCode(Integer code) {
		this.code = code;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	
	@Override
	public String toString() {
		return "JsonResult [code=" + code + ", msg=" + msg + ", count=" + count + ", data=" + data + "]";
	}
	
    
}
