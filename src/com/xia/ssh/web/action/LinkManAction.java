package com.xia.ssh.web.action;

import java.io.IOException;
import java.util.ArrayList;
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
import com.xia.ssh.domain.LinkMan;
import com.xia.ssh.domain.PageBean;
import com.xia.ssh.service.LinkManService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

public class LinkManAction extends ActionSupport implements ModelDriven<LinkMan> {

	// 注入LinkMan 模型驱动
	private LinkMan linkMan = new LinkMan();

	@Override
	public LinkMan getModel() {
		return linkMan;
	}

	// 注入service
	private LinkManService linkManService;

	public void setLinkManService(LinkManService linkManService) {
		this.linkManService = linkManService;
	}

	/**
	 * 联系人管理:跳转到添加页面的方法 saveUI 这里还没有实现功能 直接跳转
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
	 * 查询客户所有信息 包含分页查询 和条件查询
	 * 
	 * @return
	 * @throws IOException
	 */
	public String findAll() throws IOException {
		// 使用离线查询
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(LinkMan.class);
		// 设置条件
		// 联系人名字
		if (linkMan.getLkm_name() != null) {
			detachedCriteria.add(Restrictions.like("lkm_name", "%" + linkMan.getLkm_name() + "%"));
		}

		// 联系人所属客户
		if (linkMan.getCustomer() != null) {
			if (linkMan.getCustomer().getCust_id() != null && !"".equals(linkMan.getCustomer().getCust_id())) {
				detachedCriteria.add(Restrictions.eq("customer.cust_id", linkMan.getCustomer().getCust_id()));
			}
		}
		
		// 调用业务层
				PageBean<LinkMan> pageBean = linkManService.findByPage(detachedCriteria, page, limit);

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
			if (linkMan.getLkm_id()!=null) {
				linkManService.update(linkMan);
			}else {
				// 调用业务层:
				linkManService.save(linkMan);
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
			System.out.println("save");
			System.out.println(linkMan);
			// 调用业务层:
			linkManService.save(linkMan);
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
		try {
			// 调用业务层:
			linkManService.update(linkMan);
			map.put("msg", "1");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "2");
		}
		// 将map转成JSON:
		JSONObject jsonObject = JSONObject.fromObject(map);
		System.out.println(jsonObject.toString());
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().println(jsonObject.toString());// {"msg":..}
		return NONE;
	}

	/**
	 * 删除联系人
	 * 
	 * @return
	 * @throws IOException
	 */
	public String delete() throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		try {
			// 调用业务层: 先查询再删除
			System.out.println(linkMan.getLkm_id());
			linkMan = linkManService.findById(linkMan.getLkm_id());
			linkManService.delete(linkMan);
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
		System.out.println("findById");
		System.out.println(linkMan.getLkm_id());
		linkMan = linkManService.findById(linkMan.getLkm_id());
		ActionContext.getContext().getValueStack().push(linkMan);

		return "findById";
	}

}
