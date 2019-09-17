package com.nengliang.web.service.impl;

import java.util.List;
import com.nengliang.web.entity.Person;

public interface PersonService {

	List<Person> showPageLimit(Integer pageNum, Integer pageSize);

	List<Person> findParam();

	List<Person> selectByName(Integer page, Integer limit, String perName);

	void insertParam(String personName, Integer personAge, String personCity);

	String findByName(String persoName);

	void insertAllsParam(String perName, Integer perAge, String perCity);

	void updatePerson(Person person);

	void deleteById(Integer id);

	void updataParam(Person person);

	List<Person> selectName(String persn);

	void deleteId(Integer id);

	List<Person> selectPerName(Integer page, Integer limit, String pername);

	Integer findById(Integer id);


}
