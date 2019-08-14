package com.ssm.zshop.service;

import com.ssm.zshop.comm.exception.NotFindSysuserException;
import com.ssm.zshop.entity.Sysuser;
import com.ssm.zshop.param.SysuserParam;
import com.ssm.zshop.vo.SysuserVo;

import java.util.List;

public interface SysuserService {

    List<Sysuser> findAll();

    public Sysuser findById(int id);

    public void add(SysuserVo sysuserVo);

    public void modify(SysuserVo sysuserVo);

    public void modifyStatus(int id);

    List<Sysuser> findByParam(SysuserParam sysuserParam);

    public Sysuser login(String loginName, String password) throws NotFindSysuserException;
}
