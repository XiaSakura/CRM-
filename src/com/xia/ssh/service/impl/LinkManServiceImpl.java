package com.xia.ssh.service.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.transaction.annotation.Transactional;

import com.xia.ssh.dao.LinkManDao;
import com.xia.ssh.domain.LinkMan;
import com.xia.ssh.domain.PageBean;
import com.xia.ssh.service.LinkManService;

/**
 * @author q9826
 * 联系人业务层的实现类
 */
@Transactional
public class LinkManServiceImpl implements LinkManService {
	//注入dao
	private LinkManDao linkManDao;

	public void setLinkManDao(LinkManDao linkManDao) {
		this.linkManDao = linkManDao;
	}

	@Override
	public void update(LinkMan linkMan) {
		linkManDao.update(linkMan);
	}

	@Override
	public void delete(LinkMan linkMan) {
		linkManDao.delete(linkMan);
	}

	@Override
	public LinkMan findById(Long lkm_id) {
		return linkManDao.findById(lkm_id);
	}

	@Override
	public void save(LinkMan linkMan) {
		linkManDao.save(linkMan);
	}

	@Override
	public PageBean<LinkMan> findByPage(DetachedCriteria detachedCriteria, Integer page, Integer rows) {
		PageBean<LinkMan> pageBean = new PageBean<>();
		// 设置当前页数
		pageBean.setCurrPage(page);
		// 设置每页显示页数
		pageBean.setPageSize(rows);
		// 封装总记录数
		Integer totalCount = linkManDao.findCount(detachedCriteria);
		pageBean.setTotalCount(totalCount);
		double tc = totalCount;
		Double num = Math.ceil(tc / rows);
		// 设置总页数
		pageBean.setTotalPage(num.intValue());
		// 设置起始页面
		Integer begin = (page - 1) * rows;
		List<LinkMan> list = linkManDao.findByPage(detachedCriteria, begin, rows);
		System.out.println(list);
		pageBean.setList(list);

		return pageBean;
	}

	@Override
	public List<LinkMan> findAll() {
		List<LinkMan> list = linkManDao.findAll();
		
		return list;
	}
	
	
}
