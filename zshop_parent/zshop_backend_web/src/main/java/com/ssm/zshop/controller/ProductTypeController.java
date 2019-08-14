package com.ssm.zshop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.zshop.comm.constant.PaginationConstant;
import com.ssm.zshop.comm.constant.ResponseStatusConstant;
import com.ssm.zshop.comm.exception.ProductTypeExistException;
import com.ssm.zshop.comm.util.ResponseResult;
import com.ssm.zshop.entity.ProductType;
import com.ssm.zshop.service.impl.ProductTypeServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/backend/productType")
public class ProductTypeController {

    @Autowired
    ProductTypeServiceImpl productTypeService;

    /**
     * 查询所有商品类型
     */
    @RequestMapping("findAll")
    public String findAll(Integer pageNum,Model model){
        //分页判断
        if(ObjectUtils.isEmpty(pageNum)){
            //如果为null,给予赋值
            pageNum = PaginationConstant.PAGE_NUM;
        }

        //设置分页: arg0:显示第几页,arg1:显示条数
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);

        //查找所有商品
        List<ProductType> typeList = productTypeService.findAll();
        //查询出来的结果封装到pageInfo
        PageInfo<ProductType> pageInfo = new PageInfo<>(typeList);

        model.addAttribute("pageInfo",pageInfo);
        return "productTypeManager";
    }

    /**
     * 添加商品类型
     */
    @RequestMapping("/add")
    @ResponseBody
    public ResponseResult addProductType(String name){
        ResponseResult result = new ResponseResult();
        try {
            productTypeService.add(name);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
            result.setMessage("添加成功");
        } catch (ProductTypeExistException e) {
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAIL);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    /**
     * 根据id查询商品类型
     */
    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult showProductType(int id){
        ProductType productType = productTypeService.findById(id);
        return ResponseResult.success(productType);
    }

    /**
     * 修改商品类型名称
     */
    @RequestMapping("/updateProductType")
    @ResponseBody
    public ResponseResult updateProductType(int id,String name){
        try {
            productTypeService.updateProductType(id,name);
            return ResponseResult.success("添加成功");
        } catch (ProductTypeExistException e) {
            return ResponseResult.fail(e.getMessage());
        }
    }

    /**
     * 删除商品
     */
    @RequestMapping("/deleteProductType")
    @ResponseBody
    public ResponseResult deleteProductType(int id){
        productTypeService.deleteProductType(id);
        return ResponseResult.success("删除成功");
    }

    /**
     * 改变商品类型状态
     */
    @RequestMapping("/changeStatus")
    @ResponseBody
    public ResponseResult changeStatus(int id){
        productTypeService.changeProductTypeStatus(id);
        return ResponseResult.success();
    }

}
