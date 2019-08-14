package com.ssm.zshop.param;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter@Setter
public class SysuserParam implements Serializable {

    private String name;
    private String loginName;
    private String phone;
    private Integer roleId;
    private Integer isValid;
}
