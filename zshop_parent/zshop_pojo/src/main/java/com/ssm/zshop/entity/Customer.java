package com.ssm.zshop.entity;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

@Setter@Getter
public class Customer implements Serializable {

    private Integer id;
    private String name;
    private String loginName;
    private String password;
    private String phone;
    private String address;
    private Integer isValid;
    private Date registDate;
}
