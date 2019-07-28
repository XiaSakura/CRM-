package com.xia.ssh.service;

import java.util.List;

import com.xia.ssh.domain.BaseDict;


/**
 * 字典的业务层的接口
 * @author jt
 *
 */
public interface BaseDictService {

	List<BaseDict> findByTypeCode(String dict_type_code);

}
