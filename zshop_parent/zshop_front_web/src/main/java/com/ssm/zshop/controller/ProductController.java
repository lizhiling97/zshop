package com.ssm.zshop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.zshop.comm.constant.PaginationConstant;
import com.ssm.zshop.entity.Product;
import com.ssm.zshop.entity.ProductType;
import com.ssm.zshop.param.ProductParam;
import com.ssm.zshop.service.ProductService;
import com.ssm.zshop.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/front/product")
public class ProductController {

    @Autowired
    private ProductTypeService productTypeService;

    @Autowired
    private ProductService productService;

    @ModelAttribute("productTypes")
    public List<ProductType> findProductTypes(){
        return productTypeService.findEnable();
    }

    @RequestMapping("/search")
    public String search(ProductParam productParam, Integer pageNum, HttpSession session, Model model){

        if (ObjectUtils.isEmpty(pageNum)){
            pageNum = PaginationConstant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
        List<Product> products = productService.selectParam(productParam);
        PageInfo<Product> pageInfo = new PageInfo<Product>(products);
        model.addAttribute("pageInfo",pageInfo);
        return "main";
    }
}
