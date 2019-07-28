package com.xia.ssh.dao;

import java.util.List;

import com.xia.ssh.domain.User;

public interface UserDao extends BaseDao<User> {


	User login(User user);
	List<User> findAllUser();
	void save2(User user);

}
