package com.xia.ssh.domain;

import java.util.Date;

public class Contract {
	private Long contract_id;
	private String contract_number;
	//// 拜访记录关联的客户的对象
	private Customer customer;
	// 拜访记录关联的用户的对象
	private User user;
	private Date contract_time;
	private String contract_context;
	
	
	public Long getContract_id() {
		return contract_id;
	}
	public void setContract_id(Long contract_id) {
		this.contract_id = contract_id;
	}
	public String getContract_number() {
		return contract_number;
	}
	public void setContract_number(String contract_number) {
		this.contract_number = contract_number;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getContract_time() {
		return contract_time;
	}
	public void setContract_time(Date contract_time) {
		this.contract_time = contract_time;
	}
	public String getContract_context() {
		return contract_context;
	}
	public void setContract_context(String contract_context) {
		this.contract_context = contract_context;
	}
	
	
	

}
