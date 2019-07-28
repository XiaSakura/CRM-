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
import com.xia.ssh.domain.LinkMan;
import com.xia.ssh.domain.PageBean;
import com.xia.ssh.domain.User;
import com.xia.ssh.service.UserService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

/**
 * @author q9826 用户管理的action
 */
public class UserAction extends ActionSupport implements ModelDriven<User> {

	private User user = new User();

	private UserService userService;

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	@Override
	public User getModel() {
		return user;
	}

	//
	public String findById() {

		User user2 = userService.findById(user.getUser_id());
		ActionContext.getContext().getValueStack().push(user2);

		return "findById";

	}

	/**
	 * 查出所有用户
	 * 
	 * @return
	 * @throws IOException
	 */
	public String findUser() throws IOException {
		List<User> list = userService.findAllUser();
		Map<String, Object> map = new HashMap<>();
		map.put("user", list);
		// 使用JSONOBJECT
		JsonConfig jsonConfig = new JsonConfig(); // 建立配置文件
		jsonConfig.setIgnoreDefaultExcludes(false); // 设置默认忽略
		jsonConfig.setExcludes(new String[] { "user_saleVisits","user_contract"});
		JSONArray jsonObject = JSONArray.fromObject(list, jsonConfig);
		ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
		ServletActionContext.getResponse().getWriter().println(jsonObject);
		return NONE;
	}

	// 接收分页的数据：
	// 接收当前页数和每页显示的记录数，这两个值在layUI中已经有规定。page当前页数，limit每页显示记录数
	private Integer page = 1;

	public void setPage(Integer page) {
		this.page = page;
	}

	private Integer limit = 2;

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	/**
	 * 用户管理:跳转到添加页面的方法 saveUI 这里还没有实现功能 直接跳转
	 * 
	 * @return
	 */
	public String saveUI() {
		return "saveUI";

	}
	
	/**
	 * 查询用户所有信息 包含分页查询 和条件查询
	 * 
	 * @return
	 * @throws IOException
	 */
	public String findAll() throws IOException {
		// 使用离线查询
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(User.class);
		// 设置条件
		// 用户
		if (user.getUser_name() != null) {
			if (!"".equals(user.getUser_name())) {
				detachedCriteria.add(Restrictions.eq("user_name", user.getUser_name()));
			}
		}
		// 根据手机号 查询用户
		if (user.getUser_phone() != null) {
			if (!"".equals(user.getUser_phone())) {
				detachedCriteria.add(Restrictions.eq("user_phone", user.getUser_phone()));
			}
		}
		//根据 权限等级查询用户
		if (user.getUser_right() != null) {
			if (!"".equals(user.getUser_right())) {
				detachedCriteria.add(Restrictions.eq("user_right", user.getUser_right()));
			}
		}
		
		// 调用业务层
		PageBean<User> pageBean = userService.findByPage(detachedCriteria, page, limit);
		// 使用jsonLib 先将数据放到map中
		Map<String, Object> map = new HashMap<>();
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", pageBean.getTotalCount());
		JsonConfig jsonConfig = new JsonConfig(); // 建立配置文件
		jsonConfig.setIgnoreDefaultExcludes(false); // 设置默认忽略
		jsonConfig.setExcludes(new String[] {"user_saleVisits","user_contract"});
		JSONArray array = JSONArray.fromObject(pageBean.getList(), jsonConfig);
		map.put("data", array);
		ActionContext.getContext().getValueStack().set("jsonData", JSONObject.fromObject(map));
		return SUCCESS;
	}
	
	public String saveOrUpdate() throws IOException {
		
		Map<String, String> map = new HashMap<String, String>();
		try {
			if (user.getUser_id()!=null) {
				User user2 = userService.findById(user.getUser_id());
				user.setUser_code(user2.getUser_code());
				user.setUser_createTime(user2.getUser_createTime());
				user.setUser_password(user2.getUser_password());
				user.setUser_state(user2.getUser_state());
				userService.delete(user2);
				userService.save2(user);
			}else {
				// 调用业务层:
				userService.save(user);
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
	 * 用户注册的方法
	 * 
	 * @return
	 * @throws IOException
	 */
	public String regist() throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		try {
			userService.save(user);
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
	 * 用户登录的方法
	 * 
	 * @return
	 * @throws IOException
	 */
	public String login() throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		// 调用业务层查询用户
		try {
			User existUser = userService.login(user);
			if (existUser != null) {
				// 将登录信息放到session中
				ActionContext.getContext().getSession().put("existUser", existUser);
				map.put("msg", "1");
			} else {
				// 调用业务层:
				map.put("msg", "2");
			}
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
	 * 删除用户
	 * 
	 * @return
	 * @throws IOException
	 */
	public String delete() throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		try {
			// 调用业务层: 先查询再删除
			user = userService.findById(user.getUser_id());
			userService.delete(user);
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

}
