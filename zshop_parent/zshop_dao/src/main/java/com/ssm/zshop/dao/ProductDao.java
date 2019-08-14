package com.ssm.zshop.dao;

import com.ssm.zshop.entity.Product;
import com.ssm.zshop.param.ProductParam;

import java.util.List;

public interface ProductDao {

    public void insert(Product product);

    Product selectByName(String name);

    List<Product> findAll();

    Product findById(int id);

    void update(Product product);


    void deleteById(int id);

    void deleteByName(String name);

    List<Product> selectParam(ProductParam productParam);
}
