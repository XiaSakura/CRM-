package com.xia.ssh.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.xia.ssh.domain.Customer;
import com.xia.ssh.domain.PageBean;

/**
 * @author q9826
 *业务层客户管理的接口
 */
public interface CustomerService {

	PageBean<Customer> findByPage(DetachedCriteria detachedCriteria, Integer page, Integer rows);

	List<Customer> findAll();

	void save(Customer customer);
	
	public List<Customer> findAllCustomer();

	Customer findById(Long cust_id);


	void delete(Customer customer);


	void update(Customer customer);


	
	
}
