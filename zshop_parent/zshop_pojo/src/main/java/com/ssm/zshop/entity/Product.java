package com.ssm.zshop.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class Product implements Serializable {

    private Integer id;
    private String name;
    private Double price;
    private String info; //简介
    private String image;
    private ProductType productType;
}
