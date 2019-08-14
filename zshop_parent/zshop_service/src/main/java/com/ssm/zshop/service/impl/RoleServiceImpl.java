package com.ssm.zshop.service.impl;

import com.ssm.zshop.dao.RoleDao;
import com.ssm.zshop.entity.Role;
import com.ssm.zshop.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleDao roleDao;

    @Override
    public List<Role> findALL() {
        return roleDao.selectAll();
    }
}
