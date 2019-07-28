package com.xia.ssh.web.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.xia.ssh.domain.Customer;
import com.xia.ssh.domain.PageBean;
import com.xia.ssh.service.CustomerService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

/**
 * @author q9826 客户管理的action
 */
public class CustomerAction extends ActionSupport implements ModelDriven<Customer> {

	
	private Customer customer = new Customer();
	
	@Override
	public Customer getModel() {
		return customer;
	}

	private CustomerService customerService;
	public void setCustomerService(CustomerService customerService) {
		this.customerService = customerService;
	}

	/**
	 * 客户管理:跳转到添加页面的方法 saveUI 这里还没有实现功能 直接跳转
	 * 
	 * @return
	 */
	public String saveUI() {
		return "saveUI";
	}

	// 接收分页的数据：
	// 接收当前页数和每页显示的记录数，这两个值在easyUI中已经有规定。page当前页数，rows每页显示记录数
	private Integer page = 1;

	public void setPage(Integer page) {
		this.page = page;
	}

	private Integer limit = 2;


	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	/**
	 * 查出所有客户
	 * 
	 * @return
	 * @throws IOException
	 */
	public String findCustomer() throws IOException {
		List<Customer> list = customerService.findAllCustomer();
		Map<String, Object> map = new HashMap<>();
		map.put("customer", list);
		// 使用JSONOBJECT
		 JsonConfig jsonConfig = new JsonConfig(); //建立配置文件
		 jsonConfig.setIgnoreDefaultExcludes(false); //设置默认忽略
		 jsonConfig.setExcludes(new String[]{"linkMans","cust_saleVisits","cust_contract","baseDictIndustry","baseDictLevel","baseDictSource"});
		JSONArray jsonObject = JSONArray.fromObject(list,jsonConfig);
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().println(jsonObject);
		return NONE;
	}

	/**
	 * 查询客户所有信息 包含分页查询 和条件查询
	 * 
	 * @return
	 * @throws IOException
	 */
	public String findAll() throws IOException {
		
		// 使用离线查询
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(Customer.class);
		// 设置条件
		// 用户名字
		if (customer.getCust_name() != null) {
			detachedCriteria.add(Restrictions.like("cust_name", "%" + customer.getCust_name() + "%"));
		}
		// 用户级别
		if (customer.getBaseDictLevel() != null) {
			if (customer.getBaseDictLevel().getDict_id() != null
					&& !"".equals(customer.getBaseDictLevel().getDict_id())) {
				detachedCriteria
						.add(Restrictions.eq("baseDictLevel.dict_id", customer.getBaseDictLevel().getDict_id()));
			}
		}
		if (customer.getBaseDictSource() != null) {
			if (!"".equals(customer.getBaseDictSource().getDict_id())
					&& customer.getBaseDictSource().getDict_id() != null) {
				detachedCriteria
						.add(Restrictions.eq("baseDictSource.dict_id", customer.getBaseDictSource().getDict_id()));
			}
		}
		if (customer.getBaseDictIndustry() != null) {
			if (!"".equals(customer.getBaseDictIndustry().getDict_id())
					&& customer.getBaseDictIndustry().getDict_id() != null) {
				detachedCriteria
						.add(Restrictions.eq("baseDictIndustry.dict_id", customer.getBaseDictIndustry().getDict_id()));
			}
		}
		
		
		
		// 调用业务层
		PageBean<Customer> pageBean = customerService.findByPage(detachedCriteria, page, limit);

		// 使用jsonLib 先将数据放到map中
		Map<String, Object> map = new HashMap<>();
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", pageBean.getTotalCount());
		 JsonConfig jsonConfig = new JsonConfig(); //建立配置文件
		 jsonConfig.setIgnoreDefaultExcludes(false); //设置默认忽略
		 jsonConfig.setExcludes(new String[]{"linkMans","cust_saleVisits","cust_contract"});
		JSONArray array = JSONArray.fromObject(pageBean.getList(),jsonConfig);
		map.put("data", array);
		ActionContext.getContext().getValueStack().set("jsonData", JSONObject.fromObject(map));
		return SUCCESS;

	}
	
	public String saveOrUpdate() throws IOException {
		
		Map<String, String> map = new HashMap<String, String>();
		try {
			if (customer.getCust_id()!=null) {
				customerService.update(customer);
			}else {
				// 调用业务层:
				customerService.save(customer);
			}
			map.put("msg", "1");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "2");
		}
		// 将map转成JSON:
		JSONObject jsonObject = JSONObject.fromObject(map);
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().println(jsonObject);// {"msg":..}
		return NONE;
	}

	
	
	
	/**
	 * 编写save方法：
	 * 
	 * @throws IOException
	 */
	public String save() throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		try {
			System.out.println("Action中的save方法执行了...");
			System.out.println(customer);
			// 调用业务层:
			customerService.save(customer);
			map.put("msg", "1");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "2");
		}
		// 将map转成JSON:
		JSONObject jsonObject = JSONObject.fromObject(map);

		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().println(jsonObject);// {"msg":..}
		return NONE;
	}

	public String update() throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		System.out.println(customer);
		try {
//			System.out.println("Action中的save方法执行了...");
			// 调用业务层:
			customerService.update(customer);
			map.put("msg", "1");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "2");
		}
		// 将map转成JSON:
		JSONObject jsonObject = JSONObject.fromObject(map);
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().println(jsonObject);// {"msg":..}
		return NONE;
	}

	/**
	 * 删除用户
	 * 
	 * @return
	 * @throws IOException
	 */
	public String delete() throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		try {
			// 调用业务层: 先查询再删除
			customer = customerService.findById(customer.getCust_id());
			customerService.delete(customer);
			map.put("msg", "1");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "2");
		}
		// 将map转成JSON:
		JSONObject jsonObject = JSONObject.fromObject(map);
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().println(jsonObject);
		return NONE;
	}

	/**
	 * 根据id查找
	 * 
	 * @return
	 * @throws IOException
	 */
	public String findById() throws IOException {
		Customer customer2 = customerService.findById(customer.getCust_id());
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("customer2", customer2);
		JsonConfig jsonConfig = new JsonConfig(); // 建立配置文件
		jsonConfig.setIgnoreDefaultExcludes(false); // 设置默认忽略
		 jsonConfig.setExcludes(new String[]{"linkMans","cust_saleVisits","cust_contract"}); // 此处是亮点，只要将所需忽略字段加到数组中即可，在上述案例中，所要忽略的
		JSONObject jsonObject = JSONObject.fromObject(map, jsonConfig);
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().println(jsonObject.toString());

		return NONE;
	}

}
