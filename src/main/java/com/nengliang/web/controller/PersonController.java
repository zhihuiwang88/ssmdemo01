package com.nengliang.web.controller;


import java.util.List;
import org.apache.jasper.tagplugins.jstl.core.If;
import org.mybatis.generator.internal.util.StringUtility;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.BadSqlGrammarException;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.nengliang.web.entity.Person;
import com.nengliang.web.service.impl.PersonService;
import com.nengliang.web.util.JsonResult;

/**
 * 实现用户的CRUD
 * 
 * @author Dell
 * @Data 2019/12/03
 */

@Controller
@RequestMapping("/person")
public class PersonController {

	@Autowired
	private PersonService perService;

	/*
	 * 查询所有数据库的数据,并进行分页显示
	 * http://localhost:8082/ssmdemo/person/list
	 * @Param page:第几页， limit:每页显示多少条数据
	 */
	@RequestMapping(value = "/findAllParam",method=RequestMethod.GET)
	@ResponseBody
	public JsonResult selectParam(@RequestParam(value="page",required=false) Integer page,
			@RequestParam(value="limit",required=false) Integer limit,
			@RequestParam(value="personName",required=false) String personName
			) {
			
				JsonResult result = new JsonResult();
				//pageNum 第几页
				 Integer pageNum = (page-1)*limit;
				 List<Person> list = perService.findParam();
				 result.setCount(list.size());
				 result.setCode(0);
				 
				//进行分页显示数据
				 List<Person> listShowPage = perService.showPageLimit(pageNum,limit);
				 result.setData(listShowPage);
				 
				 if ( personName != null){
					 String persn = personName.replace(" ", "");
					 List<Person>	list2 = perService.selectByName(pageNum,limit,persn);
					
					 List<Person>	list3 = perService.selectName(persn);
					 result.setCount(list3.size());
					 result.setData(list2);
					 return result;
				 }
				
				 return result;
	}
	
	
	
	/*
	 * 返回list页面
	 */
	@RequestMapping("/listAll")
	public String strList() {
		return "list";
	}
	
	/*
	 * 添加用户信息
	 * @Param personName,personAge,personCity
	 * insertParam
	 */
	@RequestMapping("/addPerson")
	public String addPerson(){
		return "add";
	}

	
	@RequestMapping(value = "/insertParam", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult insertALLParam(@RequestParam(value = "persoName", required = false) String persoName,
			@RequestParam(value = "personAge", required = false) Integer personAge,
			@RequestParam(value = "personCity", required = false) String personCity) {
		JsonResult result = new JsonResult();
		Person person = new Person();
		
		try {
			String  pesName = perService.findByName(persoName);
				if (StringUtils.isEmpty(pesName)) {
					person.setName(persoName);
					person.setAge(personAge);
					person.setCity(personCity);
					perService.insertParam(persoName,personAge,personCity);
					result.setCode(200);
					result.setMsg("新增成功");
					result.setData(person);
				}
		} catch (Exception exception) {
			result.setMsg("用户名存在！");
			return result;
		}
		
		return result;
	}
	
	
	/*
	 * 修改用户信息
	 */
	@RequestMapping("/updatePerson")
	public String updatePerson(){
		return "update";
	}
	
	@RequestMapping(value = "/updateAllParam", method = RequestMethod.POST)
	@ResponseBody
	public JsonResult updatePerson(Person person) {
		
		JsonResult result = new JsonResult();
		if (StringUtils.isEmpty(person.getId())) {
			result.setCode(100);
			result.setMsg("参数ID为空");
			return result;
		} 
		
		try {
			String string = perService.findByName(person.getName());
			if (StringUtils.isEmpty(string)) {
				person.setId(person.getId());
				person.setName(person.getName());
				person.setAge(person.getAge());
				person.setCity(person.getCity());
				perService.updatePerson(person);		
				result.setData(person);
				result.setCode(200);
				result.setMsg("修改成功");
				
			}
		} catch (Exception e) {
			result.setMsg("用户名存在了");
			return result;
		}
		
		return result;
		
		
	}
	
	/*
	 * 根据ID删除用户信息
	 */
	@RequestMapping(value = "/deleteById", method = RequestMethod.GET)
	@ResponseBody
	public JsonResult  deleteById(@RequestParam("id") Integer id) {
		JsonResult result = new JsonResult();
		if(StringUtils.isEmpty(id)){
			result.setCode(100);
			result.setMsg("参数ID为空");
			return result;
		}
		perService.deleteById(id);
		result.setCode(200);
		result.setMsg("删除成功");
		return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	


	
	
	/*
	 * 以下代码是测试代码(成功)
	 */
	
	@RequestMapping("/personAdd")
	public String personAdd(){
		return "peradd";
	}
	
	/**
	 * 用户表新增，
	 */
	@RequestMapping(value="/insertALLParam",method=RequestMethod.POST)
	@ResponseBody
	public JsonResult  insertAllsParam(@RequestParam("perName") String perName,@RequestParam("perAge") Integer perAge,
			@RequestParam("perCity") String  perCity
			) {
		JsonResult jsonResult =new JsonResult();
		Person person = new Person();
		person.setName(perName);
		person.setAge(perAge);
		person.setCity(perCity);
		perService.insertAllsParam(perName,perAge,perCity);
		jsonResult.setData(person);
		return  jsonResult;
	}
	
	/*
	 * 编辑数据
	 * 
	 */
	@RequestMapping("/personUpdate")
	public String personUpdate(){
		return "perupdate";
	}
	
	@RequestMapping(value="/updataParam",method=RequestMethod.POST)
	@ResponseBody
	public JsonResult  updataParam(@RequestParam("perid") Integer perid,@RequestParam("pername") String pername,
			@RequestParam("perage") Integer perage,@RequestParam("percity") String percity) {
		JsonResult jsonResult =new JsonResult();
		Person person = new Person();
		person.setId(perid);
		person.setName(pername);
		person.setAge(perage);
		person.setCity(percity);
		perService.updataParam(person);
		
		jsonResult.setData(person);
		return  jsonResult;
	}
	
	/*
	 * 根据ID删除数据
	 */
	@RequestMapping(value="/deleteId",method=RequestMethod.GET)
	@ResponseBody
	public JsonResult  deleteId(@RequestParam("id") Integer id) {
		JsonResult jsonResult =new JsonResult();
		perService.deleteId(id);
		jsonResult.setCode(200);
		return  jsonResult;
	}
	
	/*
	 * 根据用户名模糊查询
	 * http://localhost:8082/ssmdemo/person/selectPerName?page=1&limit=2&pername=李四
	 */
	@RequestMapping(value="/selectPerName",method=RequestMethod.GET)
	@ResponseBody
	public JsonResult  selectPerName(@RequestParam("page") Integer page,@RequestParam("limit") Integer limit,
			@RequestParam("pername") String pername) {
		
		JsonResult jsonResult =new JsonResult();
		Integer pageNum = (page-1)*limit;
	    //用户名前后中去掉空格
		String personname = pername.replace(" ", "");
		List<Person> 	personList = perService.selectPerName(pageNum,limit,personname);
		jsonResult.setCode(0);
		jsonResult.setData(personList);
		return jsonResult;
		
	}
	
	
	
}
