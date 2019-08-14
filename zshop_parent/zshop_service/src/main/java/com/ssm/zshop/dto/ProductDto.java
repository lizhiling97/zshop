package com.ssm.zshop.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.InputStream;

@Getter@Setter
public class ProductDto {
    private Integer id;
    private String name;
    private Double price;
    private Integer productTypeId;
    private InputStream inputStream;//文件输入流
    private String fileName;//文件名字
    private String uploadPath;//文件上传路径

}
