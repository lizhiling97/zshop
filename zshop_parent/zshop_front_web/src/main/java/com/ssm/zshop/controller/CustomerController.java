package com.ssm.zshop.controller;

import com.ssm.zshop.comm.constant.ResponseStatusConstant;
import com.ssm.zshop.comm.exception.CustomerNotException;
import com.ssm.zshop.comm.util.ResponseResult;
import com.ssm.zshop.entity.Customer;
import com.ssm.zshop.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/front/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;


    /**
     * 登录
     */
    @RequestMapping("login")
    @ResponseBody
    public ResponseResult login(String loginName, String password, HttpSession session){
        ResponseResult result = new ResponseResult();
        try {
            Customer customer = customerService.login(loginName, password);
            session.setAttribute("customer",customer);
            result.setData(customer);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        } catch (CustomerNotException e) {
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAIL);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    /**
     * 退出
     */
    @RequestMapping("exit")
    @ResponseBody
    public ResponseResult exit(HttpSession session){
        session.invalidate();
        return ResponseResult.success();
    }
}
