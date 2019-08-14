package com.ssm.zshop.dao;

import com.ssm.zshop.entity.Sysuser;
import com.ssm.zshop.param.SysuserParam;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SysuserDao {

    List<Sysuser> selectAll();

    public Sysuser selectById(int id);

    public void insert(Sysuser sysuser);

    public void update(Sysuser sysuser);

    public void updateStatus(@Param("id") int id, @Param("isValid") int isValid);

    public List<Sysuser> selectByParam(SysuserParam sysuserParam);

    public Sysuser selectLogin(@Param("loginName") String loginName,@Param("password") String password,@Param("isValid") int isValid);
}
