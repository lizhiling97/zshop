package com.ssm.zshop.dao;

import com.ssm.zshop.entity.Customer;
import org.apache.ibatis.annotations.Param;

public interface CustomerDao {

    public Customer selectByLoginNamePassword(@Param("loginName") String loginName, @Param("password") String password, @Param("isValid") Integer isValid);
}
