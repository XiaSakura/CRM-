package com.xia.ssh.web.interceptor;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.xia.ssh.domain.User;

public class UserInterceptor extends MethodFilterInterceptor {

	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		// 判断session中是否有登录用户的信息 得到session
		User existUser = (User) ServletActionContext.getRequest().getSession().getAttribute("existUser");
		if (existUser.getUser_right().intValue()<3) {
			// 存错误信息,页面跳转到登录页面
			ActionSupport actionSupport = (ActionSupport) invocation.getAction();
			actionSupport.addActionError("您还没有登录！没有权限访问");
			return actionSupport.ERROR;
		} else {
			// 已经登录：
			return invocation.invoke();
		}
	}

}
