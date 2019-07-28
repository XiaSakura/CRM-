package com.xia.ssh.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.transaction.annotation.Transactional;

import com.xia.ssh.dao.UserDao;
import com.xia.ssh.domain.LinkMan;
import com.xia.ssh.domain.PageBean;
import com.xia.ssh.domain.User;
import com.xia.ssh.service.UserService;
import com.xia.ssh.utils.MD5Utils;

@Transactional
public class UserServiceImpl implements UserService {
	private UserDao userDao;

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	/* 
	 * 业务层保存用户的方法
	 */
	@Override
	public void save(User user) {
		//加密密码
		user.setUser_password(MD5Utils.md5(user.getUser_password()));
		user.setUser_state("正常");
		//默认权限 为1
		user.setUser_right(1);
		Date now = new Date(); 
		 //得到当前时间
		 user.setUser_createTime(now);
		// 调用dao
		userDao.save(user);
	}

	/* 
	 * 业务层登录的方法
	 */
	@Override	
	public User login(User user) {
		//解密
		user.setUser_password(MD5Utils.md5(user.getUser_password()));
	  	
	   //调用dao
		
		return userDao.login(user);
	}

	@Override
	public PageBean<User> findByPage(DetachedCriteria detachedCriteria, Integer page, Integer rows) {
		
		PageBean<User> pageBean = new PageBean<>();
		// 设置当前页数
		pageBean.setCurrPage(page);
		// 设置每页显示页数
		pageBean.setPageSize(rows);
		// 封装总记录数
		Integer totalCount = userDao.findCount(detachedCriteria);
		pageBean.setTotalCount(totalCount);
		double tc = totalCount;
		Double num = Math.ceil(tc / rows);
		// 设置总页数
		pageBean.setTotalPage(num.intValue());
		// 设置起始页面
		Integer begin = (page - 1) * rows;
		List<User> list = userDao.findByPage(detachedCriteria, begin, rows);
		System.out.println(list);
		pageBean.setList(list);

		return pageBean;
	}

	@Override
	public User findById(Long user_id) {
		return userDao.findById(user_id);
	}

	@Override
	public List<User> findAllUser() {
		return userDao.findAllUser();
	}

	@Override
	public void delete(User user) {
		userDao.delete(user);
	}

	@Override
	public void update(User user) {
		// 调用dao
		User user2 = userDao.findById(user.getUser_id());
		user.setUser_code(user2.getUser_code());
		user.setUser_code(user2.getUser_password());
		userDao.delete(user2);
		userDao.save(user);
	}

	@Override
	public void save2(User user) {
		userDao.save(user);
		
	}

}
