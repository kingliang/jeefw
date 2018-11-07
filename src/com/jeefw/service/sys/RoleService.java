package com.jeefw.service.sys;

import com.jeefw.model.sys.Role;

import core.service.Service;

/**
 * 角色的业务逻辑层的接口
 * @JC
 */
public interface RoleService extends Service<Role> {

	// 删除角色
	void deleteSysUserAndRoleByRoleId(Long roleId);

}
