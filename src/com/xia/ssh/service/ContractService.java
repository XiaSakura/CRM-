package com.xia.ssh.service;
import org.hibernate.criterion.DetachedCriteria;

import com.xia.ssh.domain.Contract;
import com.xia.ssh.domain.PageBean;


/**
 * 合同的业务层的接口
 * @author jt
 *
 */
public interface ContractService {

	PageBean<Contract> findByPage(DetachedCriteria detachedCriteria, Integer currPage, Integer pageSize);

	void save(Contract contract);

	void update(Contract contract);

	void delete(Contract contract);

	Contract findById(Long contract_id);

}
