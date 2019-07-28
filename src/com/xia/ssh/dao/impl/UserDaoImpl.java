package com.xia.ssh.dao.impl;

import java.util.List;


import com.xia.ssh.dao.UserDao;
import com.xia.ssh.domain.User;

public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao {

	@Override
	public User login(User user) {
		List<User> list = (List<User>) this.getHibernateTemplate()
				.find("from User where user_code=? and user_password=? ", user.getUser_code(), user.getUser_password());
		// 判断一下 放置返回的不是唯一用户
		if (list.size() > 0) {
			return list.get(0);
		}
		return null;
	}

	@Override
	public List<User> findAllUser() {
		return (List<User>) this.getHibernateTemplate().find("from User");
	}

	@Override
	public void save2(User user) {
		this.getHibernateTemplate().save(user);
	}


}
