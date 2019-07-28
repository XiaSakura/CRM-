package com.xia.ssh.web.interceptor;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;
import com.xia.ssh.domain.User;

public class ContractInterceptor extends MethodFilterInterceptor{
	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		// 判断session中是否有登录用户的信息 得到session
		User existUser = (User) ServletActionContext.getRequest().getSession().getAttribute("existUser");
		if (existUser.getUser_right().intValue()<2) {
			// 直接跳转到提示用户没有权限页面
			ActionSupport actionSupport = (ActionSupport) invocation.getAction();
			return actionSupport.ERROR;
		} else {
			return invocation.invoke();
		}
	}
}
