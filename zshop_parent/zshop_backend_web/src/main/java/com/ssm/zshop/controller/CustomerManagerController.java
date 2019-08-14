package com.ssm.zshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("backend/customer")
public class CustomerManagerController {

    @RequestMapping("show")
    public String show(){
        return "customerManager";
    }
}
