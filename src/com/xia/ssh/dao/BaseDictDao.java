package com.xia.ssh.dao;

import java.util.List;

import com.xia.ssh.domain.BaseDict;


/**
 * 字典DAO的接口
 * @author jt
 *
 */
public interface BaseDictDao extends BaseDao<BaseDict>{

	List<BaseDict> findByTypeCode(String dict_type_code);

}
