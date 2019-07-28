package com.xia.ssh.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.xia.ssh.domain.LinkMan;
import com.xia.ssh.domain.PageBean;

/**
 * @author q9826
 * 联系人的业务层的接口
 */
public interface LinkManService {

	void update(LinkMan linkMan);


	void delete(LinkMan linkMan);
	
	List<LinkMan> findAll();

	LinkMan findById(Long lkm_id);



	PageBean<LinkMan> findByPage(DetachedCriteria detachedCriteria, Integer page, Integer rows);


	void save(LinkMan linkMan);

}
