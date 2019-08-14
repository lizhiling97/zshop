package com.ssm.zshop.vo;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Getter@Setter
public class ProductVo {

    private Integer id;
    private String name;
    private Double price;
    private CommonsMultipartFile file;
    private Integer productTypeId;
}
