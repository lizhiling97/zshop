package com.ssm.zshop.service;

import com.ssm.zshop.dto.ProductDto;
import com.ssm.zshop.entity.Product;
import com.ssm.zshop.param.ProductParam;
import org.apache.commons.fileupload.FileUploadException;

import java.io.OutputStream;
import java.util.List;

public interface ProductService {

    public void add(ProductDto productDto) throws FileUploadException;

    boolean selectByName(String name);

    public List<Product> selectAll();

    public Product selectById(int id);

    public void getImage(String path, OutputStream outputStream);

    public void modify(ProductDto productDto) throws FileUploadException;

    public void delete(int id);

    public List<Product> selectParam(ProductParam productParam);
}
