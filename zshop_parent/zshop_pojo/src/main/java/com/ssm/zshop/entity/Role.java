package com.ssm.zshop.entity;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter@Setter
public class Role implements Serializable {

    private Integer id;
    private String roleName;
}

