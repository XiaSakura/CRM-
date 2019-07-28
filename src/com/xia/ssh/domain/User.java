package com.xia.ssh.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * @author q9826
 *CREATE TABLE `sys_user` (
  `user_id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_code` varchar(32) NOT NULL COMMENT '用户账号',
  `user_name` varchar(64) NOT NULL COMMENT '用户名称',
  `user_password` varchar(32) NOT NULL COMMENT '用户密码',
  `user_state` char(1) NOT NULL COMMENT '1:正常,0:暂停',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

 */
public class User {
	private Long user_id;
	private String user_code;
	private String user_name;
	private String user_password;
	private String user_state;
	private String user_qq;
	private String user_phone;
	private String user_gender;
	private String user_email;
	private Integer user_right;
	private Date user_createTime;
	
	public Integer getUser_right() {
		return user_right;
	}
	public void setUser_right(Integer user_right) {
		this.user_right = user_right;
	}
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	private Set<SaleVisit> user_saleVisits=new HashSet<>();
	private Set<Contract> user_contract=new HashSet<>();
	
	public Set<Contract> getUser_contract() {
		return user_contract;
	}
	public void setUser_contract(Set<Contract> user_contract) {
		this.user_contract = user_contract;
	}
	public Set<SaleVisit> getUser_saleVisits() {
		return user_saleVisits;
	}
	public void setUser_saleVisits(Set<SaleVisit> user_saleVisits) {
		this.user_saleVisits = user_saleVisits;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public Date getUser_createTime() {
		return user_createTime;
	}
	public void setUser_createTime(Date user_createTime) {
		this.user_createTime = user_createTime;
	}
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getUser_state() {
		return user_state;
	}
	public void setUser_state(String user_state) {
		this.user_state = user_state;
	}
	public String getUser_qq() {
		return user_qq;
	}
	public void setUser_qq(String user_qq) {
		this.user_qq = user_qq;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	
}
