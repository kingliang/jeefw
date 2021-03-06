package com.jeefw.model.recode;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.GenericGenerator;

/***
 * 甲方合同主体信息
 * 
 * @author Administrator
 *
 */
@Entity
@Table(name = "m_master")
@Cache(region = "all", usage = CacheConcurrencyStrategy.READ_WRITE)
public class MasterEntity extends BaseEntity {
	@Column(name = "name")
	private String name;// 名称
	@Column(name = "address")
	private String address;// 地址
	@Column(name = "contactname")
	private String contactname;// 联系人
	@Column(name = "contactnumber")
	private String contactnumber;// 联系电话
	@Column(name = "taxnumber")
	private String taxnumber;// 税号
	@Column(name = "account")
	private String account;// 银行账号
	@Column(name = "accountname")
	private String accountname;// 户名
	@Column(name = "bankname")
	private String bankname;// 开户行
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getContactname() {
		return contactname;
	}
	public void setContactname(String contactname) {
		this.contactname = contactname;
	}
	public String getContactnumber() {
		return contactnumber;
	}
	public void setContactnumber(String contactnumber) {
		this.contactnumber = contactnumber;
	}
	public String getTaxnumber() {
		return taxnumber;
	}
	public void setTaxnumber(String taxnumber) {
		this.taxnumber = taxnumber;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getAccountname() {
		return accountname;
	}
	public void setAccountname(String accountname) {
		this.accountname = accountname;
	}
	public String getBankname() {
		return bankname;
	}
	public void setBankname(String bankname) {
		this.bankname = bankname;
	}

	
}
