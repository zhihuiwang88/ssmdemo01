package com.nengliang.web.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.nengliang.web.entity.Person;

public interface PersonMapper {

	List<Person> showPageLimit(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

	List<Person> findParam();

	List<Person> selectByName(@Param("page")Integer page, @Param("limit")Integer limit, @Param("perName") String perName);

	void insertParam(@Param("name") String personName, @Param("age") Integer personAge,
			@Param("city") String personCity);

	String findByName(String persoName);
	

	void insertAllsParam(@Param("name") String perName, @Param("age") Integer perAge, @Param("city") String perCity);

	void updatePerson(Person person);

	void deleteById( Integer id);

	void updataParam(Person person);

	List<Person> selectName(@Param("pername") String persn);

	void deleteId(Integer id);

	List<Person> selectPerName(@Param("perpage") Integer page, @Param("perlimit") Integer limit,
			@Param("pername") String pername);

	Integer findById(Integer id);

	


}
