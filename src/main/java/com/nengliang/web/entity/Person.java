package com.nengliang.web.entity;

public class Person {

	/*
	 * 用户表
	 * @author Dell
	 * @Data 2019/08/36
	 * @Param id,name,age,city
	 */
	private Integer id;
	private String name;
	private Integer  age;
	private String city;
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	@Override
	public String toString() {
		return "Person [id=" + id + ", name=" + name + ", age=" + age + ", city=" + city + "]";
	}
	
	
	
	
}
