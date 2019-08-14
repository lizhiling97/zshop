package com.ssm.zshop.dao;

import com.ssm.zshop.entity.ProductType;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProductTypeDao {

    public List<ProductType> findAll();

    public ProductType selectById(int id);

    public ProductType selectByName(String name);

    public void insert(@Param("name") String name,@Param("status") int status);

    public void updateName(@Param("id") int id, @Param("name") String name);

    public void updateStatus(@Param("id") int id, @Param("status") int status);

    public void delete(int id);


    public List<ProductType> findByStatus(int status);
}
