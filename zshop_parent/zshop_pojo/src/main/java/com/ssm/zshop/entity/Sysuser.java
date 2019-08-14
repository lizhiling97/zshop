package com.ssm.zshop.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class Sysuser implements Serializable {

    private Integer id;
    private String name;
    private String loginName;
    private String password;
    private String phone;
    private String email;
    private Integer isValid;//是否有效
    private Date createDate;//入职日期
    private Role role;

}
