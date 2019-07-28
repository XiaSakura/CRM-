package com.xia.ssh.domain;

import java.util.HashSet;
import java.util.Set;

/**
 * @author q9826 CREATE TABLE `cst_customer` ( `cust_id` bigint(32) NOT NULL
 *         AUTO_INCREMENT COMMENT '客户编号(主键)', `cust_name` varchar(32) NOT NULL
 *         COMMENT '客户名称(公司名称)', `cust_source` varchar(32) DEFAULT NULL COMMENT
 *         '客户信息来源', `cust_industry` varchar(32) DEFAULT NULL COMMENT '客户所属行业',
 *         `cust_level` varchar(32) DEFAULT NULL COMMENT '客户级别', `cust_phone`
 *         varchar(64) DEFAULT NULL COMMENT '固定电话', `cust_mobile` varchar(16)
 *         DEFAULT NULL COMMENT '移动电话', PRIMARY KEY (`cust_id`) ) ENGINE=InnoDB
 *         AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
 */
public class Customer {


	@Override
	public String toString() {
		return "Customer [cust_id=" + cust_id + ", cust_name=" + cust_name + ", cust_phone=" + cust_phone
				+ ", cust_mobile=" + cust_mobile + ", baseDictSource=" + baseDictSource + ", baseDictIndustry="
				+ baseDictIndustry + ", baseDictLevel=" + baseDictLevel + ", linkMans=" + linkMans + "]";
	}

	private Long cust_id;
	private String cust_name;
	private String cust_phone;
	private String cust_mobile;
	/**
	 * 客户和字典表示多对一：需要在多的一方放的是一的一方的对象
	 */
	private BaseDict baseDictSource;
	private BaseDict baseDictIndustry;
	private BaseDict baseDictLevel;
	
	//一个客户有多个联系人 并且删除客户 就删除了对用的联系人
	private Set<LinkMan> linkMans=new HashSet<>();
	//
	private Set<SaleVisit> cust_saleVisits=new HashSet<>();
	
	private Set<Contract> cust_contract=new HashSet<>();

	public Set<Contract> getCust_contract() {
		return cust_contract;
	}

	public void setCust_contract(Set<Contract> cust_contract) {
		this.cust_contract = cust_contract;
	}

	public Long getCust_id() {
		return cust_id;
	}

	public void setCust_id(Long cust_id) {
		this.cust_id = cust_id;
	}

	public String getCust_name() {
		return cust_name;
	}


	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}

	public String getCust_phone() {
		return cust_phone;
	}

	public void setCust_phone(String cust_phone) {
		this.cust_phone = cust_phone;
	}

	public String getCust_mobile() {
		return cust_mobile;
	}

	public void setCust_mobile(String cust_mobile) {
		this.cust_mobile = cust_mobile;
	}

	public BaseDict getBaseDictSource() {
		return baseDictSource;
	}

	public void setBaseDictSource(BaseDict baseDictSource) {
		this.baseDictSource = baseDictSource;
	}

	public BaseDict getBaseDictIndustry() {
		return baseDictIndustry;
	}

	public void setBaseDictIndustry(BaseDict baseDictIndustry) {
		this.baseDictIndustry = baseDictIndustry;
	}

	public BaseDict getBaseDictLevel() {
		return baseDictLevel;
	}

	public Set<LinkMan> getLinkMans() {
		return linkMans;
	}

	public void setLinkMans(Set<LinkMan> linkMans) {
		this.linkMans = linkMans;
	}

	public void setBaseDictLevel(BaseDict baseDictLevel) {
		this.baseDictLevel = baseDictLevel;
	}

	public Set<SaleVisit> getCust_saleVisits() {
		return cust_saleVisits;
	}

	public void setCust_saleVisits(Set<SaleVisit> cust_saleVisits) {
		this.cust_saleVisits = cust_saleVisits;
	}


}
