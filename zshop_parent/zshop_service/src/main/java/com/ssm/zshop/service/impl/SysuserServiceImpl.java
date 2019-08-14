package com.ssm.zshop.service.impl;

import com.ssm.zshop.comm.constant.SysuserConstant;
import com.ssm.zshop.comm.exception.NotFindSysuserException;
import com.ssm.zshop.dao.SysuserDao;
import com.ssm.zshop.entity.Role;
import com.ssm.zshop.entity.Sysuser;
import com.ssm.zshop.param.SysuserParam;
import com.ssm.zshop.service.SysuserService;
import com.ssm.zshop.vo.SysuserVo;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class SysuserServiceImpl implements SysuserService {

    @Autowired
    private SysuserDao sysuserDao;

    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    @Override
    public List<Sysuser> findAll() {
        return sysuserDao.selectAll();
    }

    @Override
    public Sysuser findById(int id) {
        return sysuserDao.selectById(id);
    }

    @Override
    public void add(SysuserVo sysuserVo) {

        Sysuser sysuser = new Sysuser();
        try {
            PropertyUtils.copyProperties(sysuser, sysuserVo);
            //角色ID
            Role role = new Role();
            role.setId(sysuserVo.getRoleId());
            sysuser.setRole(role);
            //默认为有效
            sysuser.setIsValid(SysuserConstant.SYSUSER_VALID);
            //创建时间为当前时间
            sysuser.setCreateDate(new Date());

            sysuserDao.insert(sysuser);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void modify(SysuserVo sysuserVo) {
        Sysuser sysuser = new Sysuser();
        try {
            PropertyUtils.copyProperties(sysuser,sysuserVo);
            //角色id
            Role role = new Role();
            role.setId(sysuserVo.getRoleId());
            sysuser.setRole(role);
            //默认有效
            sysuser.setIsValid(SysuserConstant.SYSUSER_VALID);
            sysuser.setCreateDate(new Date());

            sysuserDao.update(sysuser);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void modifyStatus(int id) {
        Sysuser sysuser = sysuserDao.selectById(id);
        Integer isValid = sysuser.getIsValid();
        if (isValid == SysuserConstant.SYSUSER_VALID){
            isValid = SysuserConstant.SYSUSER_INVALID;
        }else {
            isValid = SysuserConstant.SYSUSER_VALID;
        }
        sysuserDao.updateStatus(id,isValid);
    }

    @Override
    public List<Sysuser> findByParam(SysuserParam sysuserParam) {
        return sysuserDao.selectByParam(sysuserParam);
    }

    @Override
    public Sysuser login(String loginName, String password) throws NotFindSysuserException {
        Sysuser sysuser = sysuserDao.selectLogin(loginName, password, SysuserConstant.SYSUSER_VALID);
        if (sysuser != null){
            return sysuser;
        }
        throw new NotFindSysuserException("用户名或密码错误!");
    }
}
