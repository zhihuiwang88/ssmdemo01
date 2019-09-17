package com.nengliang.web.service.impl;

/**
 * 用户表的CRUD
 * @author Dell
 * @Data 2019/06/18
 */
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.nengliang.web.dao.PersonMapper;
import com.nengliang.web.entity.Person;

@Service
public class PersonServiceImpl implements PersonService {

	@Autowired
	private PersonMapper perMapper;

	/*
	 * 对所有数据进行分页显示
	 * 
	 * @Param pageNum：第几页开始，pageSize：每页显示多少条数据
	 * 
	 */
	public List<Person> showPageLimit(Integer pageNum, Integer pageSize) {
		List<Person> list = perMapper.showPageLimit(pageNum, pageSize);
		return list;
	}

	/*
	 * 查询出数据库所有的数据
	 */
	public List<Person> findParam() {
		List<Person> list = perMapper.findParam();
		return list;
	}

	/*
	 * 对姓名进行模糊查询
	 */
	public List<Person> selectByName(Integer page, Integer limit,String perName) {
		return  perMapper.selectByName(page,limit,perName);
	}

	/*
	 * 添加用户信息
	 * 
	 */
	public void insertParam(String personName, Integer personAge, String personCity) {
		perMapper.insertParam(personName, personAge, personCity);
	}

	/*
	 * 插入数据之前对名字先查询一下
	 */
	public String findByName(String persoName) {
		String  string = perMapper.findByName(persoName);
		return string;
	}

	public void insertAllsParam(String perName, Integer perAge, String perCity) {

		perMapper.insertAllsParam(perName, perAge, perCity);
	}

	/*
	 * 修改用户信息
	 */
	public void updatePerson(Person person) {
		perMapper.updatePerson(person);
	}

	/*
	 * 根据ID删除用户信息
	 */
	public void deleteById(Integer id) {
		perMapper.deleteById(id);
		
	}

	/*
            测试修改数据
	 */
	public void updataParam(Person person) {
		perMapper.updataParam(person);
		
	}

	/*
     查询名字，没有参数page 和 limit
	 */
	public List<Person> selectName(String persn) {
		// TODO Auto-generated method stub
		return perMapper.selectName(persn);
	}

	/*
    根据ID删除信息
	 */
	public void deleteId(Integer id) {
		perMapper.deleteId(id);
		
	}

	/*
      测试用户名模糊查询
	 */
	public List<Person> selectPerName(Integer page, Integer limit, String pername) {
		return perMapper.selectPerName(page,limit,pername);
	}

	/*
	 * 查询单个ID
	 * (non-Javadoc)
	 * @see com.nengliang.web.service.impl.PersonService#findById(java.lang.Integer)
	 */
	public Integer findById(Integer id) {
		return perMapper.findById(id);
	}





}
