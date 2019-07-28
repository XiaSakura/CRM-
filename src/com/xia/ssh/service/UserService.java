package com.xia.ssh.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.xia.ssh.domain.PageBean;
import com.xia.ssh.domain.User;

/**
 * @author q9826
 * 用户管理的业务层的接口
 */
public interface UserService {

	/**保存用户信息
	 * @param user
	 */
	public void save(User user);
	/**保存用户信息
	 * @param user
	 */
	public void save2(User user);
	
	/**登录查询用户的信息
	 * @param user
	 * @return
	 */
	public User login(User user);

	public PageBean<User> findByPage(DetachedCriteria detachedCriteria, Integer page, Integer rows);

	public User findById(Long user_id);

	public List<User> findAllUser();

	public void delete(User user);

	public void update(User user);


	
}
