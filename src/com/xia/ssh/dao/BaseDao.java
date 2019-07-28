package com.xia.ssh.dao;

import java.io.Serializable;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

/**
 * @author q9826 通用的dao接口
 */
public interface BaseDao<T> {
	public void save(T t);
	public void update(T t);
	public void delete(T t);
	
	// 查询所有
	public List<T> findAll();
	
	/** 根据id 进行查询
	 * @param id
	 * @return
	 */
	public T findById(Serializable id);
	
	/**统计个数的方法
	 * @param detachedCriteria
	 * @return
	 */
	public Integer findCount(DetachedCriteria detachedCriteria);
	
	/** 分页查询的方法
	 * @param detachedCriteria
	 * @param begin
	 * @param pageSize
	 * @return
	 */
	public List<T> findByPage(DetachedCriteria detachedCriteria,Integer begin,Integer pageSize);
	
	
}
