package com.ssm.zshop.service;

import com.ssm.zshop.comm.exception.CustomerNotException;
import com.ssm.zshop.entity.Customer;

public interface CustomerService {

    public Customer login(String loginName,String password) throws CustomerNotException;
}
