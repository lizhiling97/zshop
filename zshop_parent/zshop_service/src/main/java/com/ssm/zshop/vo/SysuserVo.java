package com.ssm.zshop.vo;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter@Setter
public class SysuserVo implements Serializable {

    private Integer id;
    private String name;
    private String loginName;
    private String password;
    private String phone;
    private String email;
    private Integer roleId;
}
