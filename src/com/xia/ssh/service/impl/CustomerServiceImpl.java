package com.xia.ssh.service.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.transaction.annotation.Transactional;

import com.xia.ssh.dao.CustomerDao;
import com.xia.ssh.domain.Customer;
import com.xia.ssh.domain.PageBean;
import com.xia.ssh.service.CustomerService;

/**
 * @author q9826 业务层客户管理的实现类
 */
@Transactional
public class CustomerServiceImpl implements CustomerService {

	private CustomerDao customerDao;

	public void setCustomerDao(CustomerDao customerDao) {
		this.customerDao = customerDao;
	}

	@Override
	public PageBean<Customer> findByPage(DetachedCriteria detachedCriteria, Integer page, Integer rows) {
		PageBean<Customer> pageBean = new PageBean<>();
		// 设置当前页数
		pageBean.setCurrPage(page);
		// 设置每页显示页数
		pageBean.setPageSize(rows);
		// 封装总记录数
		Integer totalCount = customerDao.findCount(detachedCriteria);
		pageBean.setTotalCount(totalCount);
		double tc = totalCount;
		Double num = Math.ceil(tc / rows);
		// 设置总页数
		pageBean.setTotalPage(num.intValue());
		// 设置起始页面
		Integer begin = (page - 1) * rows;
		List<Customer> list = customerDao.findByPage(detachedCriteria, begin, rows);
		pageBean.setList(list);

		return pageBean;
	}

	@Override
	public List<Customer> findAll() {
		
		return customerDao.findAll();
	}

	@Override
	public void save(Customer customer) {
		customerDao.save(customer);
	}

	@Override
	public Customer findById(Long cust_id) {
		
		return customerDao.findById(cust_id);
	}

	@Override
	public void delete(Customer customer) {
		customerDao.delete(customer);
	}

	@Override
	public void update(Customer customer) {
		customerDao.update(customer);
	}

	@Override
	public List<Customer> findAllCustomer() {
		return customerDao.findAllCustomer();
	}

}
