package com.xia.ssh.dao.impl;

import java.util.List;

import org.springframework.orm.hibernate5.support.HibernateDaoSupport;

import com.xia.ssh.dao.BaseDictDao;
import com.xia.ssh.domain.BaseDict;
import com.xia.ssh.domain.Customer;

/**
 * 字典DAO的实现类
 * 
 * @author jt
 *
 */
public class BaseDictDaoImpl extends BaseDaoImpl<BaseDict> implements BaseDictDao {
	
	@Override
	// 根据类型编码查询字典数据
	public List<BaseDict> findByTypeCode(String dict_type_code) {
		return (List<BaseDict>) this.getHibernateTemplate().find("from BaseDict where dict_type_code = ?",
				dict_type_code);
	}

}
