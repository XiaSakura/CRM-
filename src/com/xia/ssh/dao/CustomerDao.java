package com.xia.ssh.dao;

import java.util.List;

import com.xia.ssh.domain.Customer;

/**
 * @author q9826
 * dao层 客户管理的接口
 */
public interface CustomerDao extends BaseDao<Customer>{
	public List<Customer> findAllCustomer();
}
