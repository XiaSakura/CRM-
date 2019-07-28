package com.xia.ssh.dao.impl;


import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.xia.ssh.dao.CustomerDao;
import com.xia.ssh.domain.Customer;

/**
 * @author q9826
 * dao层 客户管理的实现类
 */
public class CustomerDaoImpl extends BaseDaoImpl<Customer> implements CustomerDao {

	@Override
	public List<Customer> findAllCustomer() {
		List<Customer> list = (List<Customer>) this.getHibernateTemplate().find(" from Customer");
		return list;
	}
	

}
