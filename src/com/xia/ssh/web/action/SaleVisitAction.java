package com.xia.ssh.web.action;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.xia.ssh.domain.Customer;
import com.xia.ssh.domain.PageBean;
import com.xia.ssh.domain.SaleVisit;
import com.xia.ssh.service.SaleVisitService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

/**
 * 客户拜访记录的Action的类
 * 
 * @author xia
 *
 */
public class SaleVisitAction extends ActionSupport implements ModelDriven<SaleVisit> {

	// 模型驱动使用的对象:
	private SaleVisit saleVisit = new SaleVisit();

	@Override
	public SaleVisit getModel() {
		return saleVisit;
	}

	// 在Action中注入Service:
	private SaleVisitService saleVisitService;

	public void setSaleVisitService(SaleVisitService saleVisitService) {
		this.saleVisitService = saleVisitService;
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
	/*
	 * // 接收数据: private Date visit_end_time;
	 * 
	 * public void setVisit_end_time(Date visit_end_time) { this.visit_end_time =
	 * visit_end_time; }
	 * 
	 * public Date getVisit_end_time() { return visit_end_time; }
	 */

	/**
	 * 查询拜访记录列表的方法：findAll
	 */
	public String findAll() {
		// 创建离线条件查询对象:
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(SaleVisit.class);
		// 设置条件:
		/*if (saleVisit.getVisit_time() != null) {
			detachedCriteria.add(Restrictions.ge("visit_time", saleVisit.getVisit_time()));
		}*/
		// 联系人名字

		// 拜访纪录所属客户
		if (saleVisit.getCustomer() != null) {
			if (saleVisit.getCustomer().getCust_id() != null && !"".equals(saleVisit.getCustomer().getCust_id())) {
				detachedCriteria.add(Restrictions.eq("customer.cust_id", saleVisit.getCustomer().getCust_id()));
			}
		}
		// 拜访记录所属用户
		if (saleVisit.getUser() != null) {
			if (saleVisit.getUser().getUser_id() != null && !"".equals(saleVisit.getUser().getUser_id())) {
				detachedCriteria.add(Restrictions.eq("user.user_id", saleVisit.getUser().getUser_id()));
			}
		}
		/*
		 * if (visit_end_time != null) {
		 * detachedCriteria.add(Restrictions.le("visit_time", visit_end_time)); }
		 */
		/*
		 */
		// 调用业务层
		PageBean<SaleVisit> pageBean = saleVisitService.findByPage(detachedCriteria, page, limit);
		// 使用jsonLib 先将数据放到map中
		Map<String, Object> map = new HashMap<>();
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", pageBean.getTotalCount());
		JsonConfig jsonConfig = new JsonConfig(); // 建立配置文件
		jsonConfig.setIgnoreDefaultExcludes(false); // 设置默认忽略
		jsonConfig.setExcludes(new String[] { "linkMans", "cust_saleVisits", "user_saleVisits","cust_contract","user_contract"});
		JSONArray array = JSONArray.fromObject(pageBean.getList(), jsonConfig);
		map.put("data", array);
		System.out.println(map);
		ActionContext.getContext().getValueStack().set("jsonData", JSONObject.fromObject(map));
		return SUCCESS;
	}

	public String saveOrUpdate() throws IOException {

		Map<String, String> map = new HashMap<String, String>();
		try {
			if (saleVisit.getVisit_id() != null && !saleVisit.getVisit_id().equals("")) {
				saleVisitService.update(saleVisit);
			} else {
				// 调用业务层:
				saleVisitService.save(saleVisit);
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
	 * 删除用户
	 * 
	 * @return
	 * @throws IOException
	 */
	public String delete() throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		try {
			// 调用业务层: 先查询再删除
			System.out.println(saleVisit.getVisit_id());
			saleVisit = saleVisitService.findById(saleVisit.getVisit_id());
			saleVisitService.delete(saleVisit);
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
	 * 拜访记录跳转到添加页面的方法:saveUI
	 */
	public String saveUI() {

		return "saveUI";
	}

}
