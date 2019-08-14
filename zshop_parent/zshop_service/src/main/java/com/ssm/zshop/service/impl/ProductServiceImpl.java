package com.ssm.zshop.service.impl;

import com.ssm.zshop.comm.util.RenameUtil;
import com.ssm.zshop.dao.ProductDao;
import com.ssm.zshop.dto.ProductDto;
import com.ssm.zshop.entity.Product;
import com.ssm.zshop.entity.ProductType;
import com.ssm.zshop.param.ProductParam;
import com.ssm.zshop.service.ProductService;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StreamUtils;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Override
    public void add(ProductDto productDto) throws FileUploadException {
        //文件上传
        //文件重命名
        String fileName = RenameUtil.renameFile(productDto.getFileName());
        //上传路径
        String filePath = productDto.getUploadPath() + "/" + fileName;
        try {
            StreamUtils.copy(productDto.getInputStream(), new FileOutputStream(filePath));
        } catch (IOException e) {
            throw new FileUploadException("文件上传失败!" + e.getMessage());
        }

        //保存数据库
        Product product = new Product();
        //将DTO转换为PO
        try {
            PropertyUtils.copyProperties(product, productDto);
            product.setImage(filePath);
            ProductType productType = new ProductType();
            productType.setId(productDto.getProductTypeId());
            product.setProductType(productType);
            productDao.insert(product);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public boolean selectByName(String name) {
        Product product = productDao.selectByName(name);
        if (product == null) {
            return true;
        }
        return false;
    }

    @Override
    public List<Product> selectAll() {
        return productDao.findAll();
    }

    @Override
    public Product selectById(int id) {
        return productDao.findById(id);
    }

    @Override
    public void getImage(String path, OutputStream outputStream) {
        try {
            StreamUtils.copy(new FileInputStream(path), outputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void modify(ProductDto productDto) throws FileUploadException {
        //文件上传
        //文件重命名
        String fileName = RenameUtil.renameFile(productDto.getName());
        //上传路径
        String uploadPath = productDto.getUploadPath() + "/" + fileName;

        try {
            StreamUtils.copy(productDto.getInputStream(), new FileOutputStream(fileName));
        } catch (IOException e) {
            throw new FileUploadException("文件上传失败");
        }

        //保存数据库
        Product product = new Product();
        //将DTO转换为PO
        try {
            PropertyUtils.copyProperties(product, productDto);
            product.setImage(uploadPath);
            ProductType productType = new ProductType();
            productType.setId(productDto.getProductTypeId());
            product.setProductType(productType);
            productDao.update(product);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        productDao.deleteById(id);
    }

    @Override
    public List<Product> selectParam(ProductParam productParam) {
        return productDao.selectParam(productParam);
    }


}
