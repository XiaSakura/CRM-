package com.xia.ssh.service;
import org.hibernate.criterion.DetachedCriteria;

import com.xia.ssh.domain.PageBean;
import com.xia.ssh.domain.SaleVisit;


/**
 * 客户拜访记录的业务层的接口
 * @author jt
 *
 */
public interface SaleVisitService {

	PageBean<SaleVisit> findByPage(DetachedCriteria detachedCriteria, Integer currPage, Integer pageSize);

	void save(SaleVisit saleVisit);

	void update(SaleVisit saleVisit);

	void delete(SaleVisit saleVisit);

	SaleVisit findById(String visit_id);

}
