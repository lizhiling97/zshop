package com.ssm.zshop.param;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductParam {

    private String name;
    private Double maxPrice;
    private Double minPrice;
    private Integer productTypeId;
}
