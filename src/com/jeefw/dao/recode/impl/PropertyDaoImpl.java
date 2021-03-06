package com.jeefw.dao.recode.impl;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.druid.support.json.JSONUtils;
import com.alibaba.fastjson.JSON;
import com.jeefw.model.sys.param.model.BigContractModel;
import com.jeefw.model.sys.param.model.DropDownModel;
import core.util.CommonUtil;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.stereotype.Repository;

import com.jeefw.dao.recode.PropertyDao;
import com.jeefw.model.recode.PropertyEntity;
import com.jeefw.model.recode.param.PropertyModel;

import core.dao.BaseDao;
import core.support.JqGridPageView;
import core.util.DateUnit;
import core.util.StringUnit;

@Repository
public class PropertyDaoImpl extends BaseDao<PropertyEntity> implements PropertyDao {

	public PropertyDaoImpl() {
		super(PropertyEntity.class);
		// TODO Auto-generated constructor stub
	}

	@Override
	public JqGridPageView<PropertyModel> getPropertyByCondition(
			PropertyModel model) {
		JqGridPageView<PropertyModel> result = new JqGridPageView<PropertyModel>();
		Session session = this.getSession();
		StringBuffer sb = new StringBuffer(" where t.deleteflg = '0' ");

		if(!StringUnit.isNullOrEmpty(model.getBuild())){
			sb.append(" and t.build = '"+model.getBuild()+"' ");
		}
		
		if(!StringUnit.isNullOrEmpty(model.getBuilds())){
			sb.append(" and t.build in ("+model.getBuilds()+")");
		}

		//等于查询
		if(model.getEqparam() != null){
			PropertyModel eqmodel = (PropertyModel) model.getEqparam();
			if(!StringUnit.isNullOrEmpty(eqmodel.getName())){
				sb.append(" and t.name = '"+eqmodel.getName()+"' ");
			}
			if(!StringUnit.isNullOrEmpty(eqmodel.getUsed())){
				sb.append(" and t.used = '"+eqmodel.getUsed()+"' ");
			}
			if(!StringUnit.isNullOrEmpty(eqmodel.getBuild())){
				sb.append(" and t.build = '"+eqmodel.getBuild()+"' ");
			}
			if(!StringUnit.isNullOrEmpty(eqmodel.getId())){
				sb.append(" and t.id = '"+eqmodel.getId()+"' ");
			}
		}
		//like查询
		if(model.getLikeparam() != null){
			PropertyModel likemodel = (PropertyModel) model.getLikeparam();
			if(!StringUnit.isNullOrEmpty(likemodel.getName())){
				sb.append(" and t.name like '%"+likemodel.getName()+"%' ");
			}
			if(!StringUnit.isNullOrEmpty(likemodel.getUsed())){
				sb.append(" and t.used like '%"+likemodel.getUsed()+"%' ");
			}
		}

		Query query = session.createSQLQuery("select t.id id,b.name buildname,t.build build,t.name name,t.area area,t.rent rent,t.used used"
				+ " from m_property t left join m_build b on t.build = b.id "+ sb.toString())
				.addScalar("id", StandardBasicTypes.STRING)
				.addScalar("buildname", StandardBasicTypes.STRING)
				.addScalar("build", StandardBasicTypes.STRING)
				.addScalar("name", StandardBasicTypes.STRING)
				.addScalar("area", StandardBasicTypes.STRING)
				.addScalar("rent", StandardBasicTypes.STRING)
				.addScalar("used", StandardBasicTypes.STRING)
				.setResultTransformer(Transformers.aliasToBean(PropertyModel.class));
		query.setFirstResult((Integer.parseInt(model.getPage()) - 1)
				* Integer.parseInt(model.getRows()));
		query.setMaxResults(Integer.parseInt(model.getRows()));

		List<PropertyModel> list = query.list();

		Object cout = session.createSQLQuery(
				"select count(1) from m_property  t left join m_build b on t.build = b.id " + sb.toString())
				.uniqueResult();
		long count = Long.parseLong(cout.toString());

		result.setRows(list);
		result.setTotal(count/Integer.parseInt(model.getRows())+1);
		result.setTotalNumber((int)count);
		result.setCurrentPage(Integer.parseInt(model.getPage()));
		return result;
	}

	@Override
	public void deleteEntity(String id, String userid) {
		Query query = this.getSession().createSQLQuery(
				"update m_property set deleteflg = '1' ,deleteuser = '"+userid+"',deletetime = '"+DateUnit.getTime14()+"' where id = ?");
		query.setParameter(0, id);
		query.executeUpdate();

	}

	@Override
	public String getPropertyJsonByCondition(BigContractModel model) {
		Session session = this.getSession();
		StringBuffer sb = new StringBuffer(" from PropertyEntity  where deleteflg = '0' and build = '" + model.getBuildid() + "'");
		List<PropertyEntity> list = session.createQuery(sb.toString()).list();
		List<DropDownModel> dropDownModels = new ArrayList<>();
		DropDownModel dropDownModel = new DropDownModel();
		for (PropertyEntity propertyEntity : list) {
			dropDownModel = new DropDownModel();
			if (CommonUtil.isNotNull(model.getPropertyids()) && model.getPropertyids().indexOf(propertyEntity.getId()) > -1) {
				dropDownModel.setSelected(true);
			} else {
				dropDownModel.setSelected(false);
			}
			dropDownModel.setId(propertyEntity.getId());
			dropDownModel.setName(propertyEntity.getName());
			dropDownModels.add(dropDownModel);
		}
		return JSON.toJSONString(dropDownModels);
	}

	@Override
	public PropertyEntity getPropertyEntity(String buildid,String name) {
		Session session = this.getSession();
		StringBuffer sb = new StringBuffer(" from PropertyEntity  where deleteflg = '0' and build = '" + buildid + "' and name = '"+name+"' ");
		PropertyEntity propertyEntity = (PropertyEntity)session.createQuery(sb.toString()).uniqueResult();
		return propertyEntity;
	}

}
