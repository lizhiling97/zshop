package com.ssm.zshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/backend/code")
public class CodeController {

    @RequestMapping("checkCode")
    @ResponseBody
    public Map<String,Object> checkCode(String code, HttpSession session){
        Map<String, Object> map = new HashMap<>();
        String sRand = (String)session.getAttribute("sRand");
        if(code.equalsIgnoreCase(sRand)){
            map.put("valid",true);
        }else {
            map.put("valid",false);
        }
        return map;
    }
}
