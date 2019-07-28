package com.xia.ssh.service.impl;

import java.util.List;


import org.hibernate.criterion.DetachedCriteria;
import org.springframework.transaction.annotation.Transactional;

import com.xia.ssh.dao.ContractDao;
import com.xia.ssh.domain.Contract;
import com.xia.ssh.domain.PageBean;
import com.xia.ssh.service.ContractService;

/**
 * 合同的业务层的实现类
 * 
 * @author xia
 *
 */
@Transactional
public class ContractServiceImpl implements ContractService {

	// 注入合同记录的DAO:
	private ContractDao contractDao;

	public void setContractDao(ContractDao contractDao) {
		this.contractDao = contractDao;
	}

	@Override
	// 业务层分页显示拜访记录的方法:
	public PageBean<Contract> findByPage(DetachedCriteria detachedCriteria, Integer currPage, Integer pageSize) {
		PageBean<Contract> pageBean = new PageBean<Contract>();
		// 设置当前页数:
		pageBean.setCurrPage(currPage);
		// 设置每页显示记录数:
		pageBean.setPageSize(pageSize);
		// 设置总记录数:
		Integer totalCount = contractDao.findCount(detachedCriteria);
		pageBean.setTotalCount(totalCount);
		// 设置总页数：
		double tc = totalCount;
		Double num = Math.ceil(tc / pageSize);
		pageBean.setTotalPage(num.intValue());
		// 设置每页显示的数据的集合:
		Integer begin = (currPage - 1) * pageSize;
		List<Contract> list = contractDao.findByPage(detachedCriteria, begin, pageSize);
		pageBean.setList(list);
		return pageBean;
	}

	@Override
	public void save(Contract contract) {
		contractDao.save(contract);
	}

	@Override
	public void update(Contract contract) {
		contractDao.update(contract);
	}

	@Override
	public void delete(Contract contract) {
		contractDao.delete(contract);
	}

	@Override
	public Contract findById(Long contract_id) {
		return contractDao.findById(contract_id);
	}
}
