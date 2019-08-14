package com.ssm.zshop.service.impl;

import com.ssm.zshop.comm.constant.CustomerConstant;
import com.ssm.zshop.comm.exception.CustomerNotException;
import com.ssm.zshop.dao.CustomerDao;
import com.ssm.zshop.entity.Customer;
import com.ssm.zshop.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao customerDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public Customer login(String loginName, String password) throws CustomerNotException {
        Customer customer = customerDao.selectByLoginNamePassword(loginName, password, CustomerConstant.CUSTOMER_VALID);
        if (customer != null){
            return customer;
        }
        throw new CustomerNotException("用户名或密码错误");
    }
}
