package com.ssm.zshop.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class ProductType implements Serializable {
    private Integer id;
    private String name;
    private Integer status;

}
