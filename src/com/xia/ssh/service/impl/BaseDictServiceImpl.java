package com.xia.ssh.service.impl;

import java.util.List;

import com.xia.ssh.dao.BaseDictDao;
import com.xia.ssh.domain.BaseDict;
import com.xia.ssh.service.BaseDictService;

/**
 * 字典的业务层的实现类
 * @author jt
 *
 */
public class BaseDictServiceImpl implements BaseDictService {
	// 注入DAO
	private BaseDictDao baseDictDao;

	public void setBaseDictDao(BaseDictDao baseDictDao) {
		this.baseDictDao = baseDictDao;
	}

	@Override
	public List<BaseDict> findByTypeCode(String dict_type_code) {
		return baseDictDao.findByTypeCode(dict_type_code);
	}
	
}
