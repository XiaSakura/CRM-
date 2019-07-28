package com.xia.ssh.web.interceptor;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.xia.ssh.domain.User;

/**
 * 权限拦截器
 * @author jt
 *
 */
public class PrivilegeInterceptor extends MethodFilterInterceptor{

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		// 判断session中是否有登录用户的信息
		User existUser = (User)ServletActionContext.getRequest().getSession().getAttribute("existUser");
		if(existUser == null){
			// 存错误信息,页面跳转到登录页面
			ActionSupport actionSupport = (ActionSupport) invocation.getAction();
			actionSupport.addActionError("您还没有登录！没有权限访问");
			//TODO 判断角色权限
			/*
			 * 如果她的 user.user_right ="1","2","3" 1是普通员工 2是经理 3是管理员
			 * 默认为1 
			 * if('user_right'!=)
			 * swtich(user_right)
			 * case 1: return login 
			 * case 2:return 因为不同的管理 需要有不同的人员 
			 * 创建多个拦截器 普通用户的拦截器 经理的拦截器 管理员的拦截器
			 * 但是都需要在登录的情况 下才能进入下一级页面
			 * 普通用户的拦截器需要 只能访问 客户管理联系人管理 跟进管理
			 * 经理用户 多一个 合同管理
			 * 管理员 全部都可以访问 读一个用户管理 
			 */
			return actionSupport.LOGIN;
		}else{
			// 已经登录：
			return invocation.invoke();
		}
	}

}
