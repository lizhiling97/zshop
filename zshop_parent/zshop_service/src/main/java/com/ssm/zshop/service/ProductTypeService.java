package com.ssm.zshop.service;

import com.ssm.zshop.comm.exception.ProductTypeExistException;
import com.ssm.zshop.entity.ProductType;

import java.util.List;

public interface ProductTypeService {

    public List<ProductType> findAll();

    public void add(String name) throws ProductTypeExistException;

    public ProductType findById(int id);

    public void updateProductType(int id, String name) throws ProductTypeExistException;

    public void deleteProductType(int id);

    public void changeProductTypeStatus(int id);

    public List<ProductType> findEnable();
}
