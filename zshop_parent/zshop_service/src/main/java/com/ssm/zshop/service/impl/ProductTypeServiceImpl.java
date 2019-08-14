package com.ssm.zshop.service.impl;

import com.ssm.zshop.comm.constant.ProductTypeConstant;
import com.ssm.zshop.comm.exception.ProductTypeExistException;
import com.ssm.zshop.dao.ProductTypeDao;
import com.ssm.zshop.entity.ProductType;
import com.ssm.zshop.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ProductTypeServiceImpl implements ProductTypeService {

    @Autowired
    ProductTypeDao productTypeDao;

    @Override
    public List<ProductType> findAll() {
        return productTypeDao.findAll();
    }

    @Override
    public void add(String name) throws ProductTypeExistException {
        ProductType productType = productTypeDao.selectByName(name);
        if (null != productType) {
            throw new ProductTypeExistException("商品已存在");
        }
        productTypeDao.insert(name, ProductTypeConstant.PRODUCT_TYPE_ENABLE);
    }

    @Override
    public ProductType findById(int id) {
       return productTypeDao.selectById(id);
    }

    @Override
    public void updateProductType(int id, String name) throws ProductTypeExistException {
        ProductType productType = productTypeDao.selectByName(name);
        if (null != productType) {
           throw new ProductTypeExistException("此商品类型已存在");
        }
        productTypeDao.updateName(id, name);
    }

    @Override
    public void deleteProductType(int id) {
        productTypeDao.delete(id);
    }

    @Override
    public void changeProductTypeStatus(int id) {
        ProductType productType = productTypeDao.selectById(id);
        Integer status = productType.getStatus();
        if (status == ProductTypeConstant.PRODUCT_TYPE_ENABLE){
            status = ProductTypeConstant.PRODUCT_TYPE_DISABLE;
        }else{
            status = ProductTypeConstant.PRODUCT_TYPE_ENABLE;
        }
        productTypeDao.updateStatus(id,status);
    }

    @Override
    public List<ProductType> findEnable() {
        return productTypeDao.findByStatus(ProductTypeConstant.PRODUCT_TYPE_ENABLE);
    }
}
