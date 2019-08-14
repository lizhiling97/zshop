package com.ssm.zshop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.zshop.comm.constant.PaginationConstant;
import com.ssm.zshop.comm.util.ResponseResult;
import com.ssm.zshop.dto.ProductDto;
import com.ssm.zshop.entity.Product;
import com.ssm.zshop.entity.ProductType;
import com.ssm.zshop.service.ProductService;
import com.ssm.zshop.service.impl.ProductTypeServiceImpl;
import com.ssm.zshop.vo.ProductVo;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/backend/product")
public class ProductController {

    @Autowired
    private ProductTypeServiceImpl productTypeService;

    @Autowired
    private ProductService productService;

    /**
     * 获取启用状态的商品类型
     */
    @ModelAttribute("productTypes")
    public List<ProductType> loadProductType(){
        return productTypeService.findEnable();
    }

    @RequestMapping("findAll")
    public String findAll(Integer pageNum,Model model){

        //分页判断
        if (ObjectUtils.isEmpty(pageNum)){//
            //如果为空,给予赋值
            pageNum = PaginationConstant.PAGE_NUM;
        }
        //设置分页显示第几页和每页显示几条
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
        //查找商品
        List<Product> products = productService.selectAll();
        //查询出来的结果封装到pageInfo
        PageInfo<Product> productPageInfo = new PageInfo<>(products);
        model.addAttribute("productPageInfo",productPageInfo);
        return "productManager";
    }

    /**
     * 添加商品类型
     */
    @RequestMapping("add")
    public String add(ProductVo productVo, HttpSession session, Model model){

        //文件存放路径
        String uploadPath = session.getServletContext().getRealPath("/WEB-INF/upload");
        try {
            //将VO转换为DTO
            ProductDto productDto = new ProductDto();
            //对象之间属性复制
            PropertyUtils.copyProperties(productDto,productVo);
            //设置DTO的文件传输流
            productDto.setInputStream(productVo.getFile().getInputStream());
            //设置传输文件名
            productDto.setFileName(productVo.getFile().getOriginalFilename());
            //文件路径
            productDto.setUploadPath(uploadPath);
            //添加
            productService.add(productDto);
            //添加成功
            model.addAttribute("successMsg","添加成功");
        } catch (Exception e) {
            //添加失败
            model.addAttribute("errorMsg",e.getMessage());
        }
        return "forward:findAll";
    }

    /*
     * 校验商品是否存在
     */
    @RequestMapping("/checkName")
    @ResponseBody
    public Map<String,Object> checkName(String name){
        Map<String,Object> map = new HashMap<>();
        if(productService.selectByName(name)){//不存在
            map.put("valid",true);
        }else {
            map.put("valid",false);
            map.put("message","商品("+name+")已存在");
        }
        return map;
    }

    /*
     * 展示商品
     */
    @RequestMapping("/findById")
    @ResponseBody
    public ResponseResult findById(int id){
        Product product = productService.selectById(id);
        return ResponseResult.success(product);
    }

    /**
     * 获取图片
     */
    @RequestMapping("getImage")
    public void getImage(String path, OutputStream outputStream){
        productService.getImage(path,outputStream);
    }

    /*
     * 修改商品
     */
    @RequestMapping("/modify")
    public String modify(ProductVo productVo,Integer pageNum,HttpSession session,Model model){
        //文件存放路径
        String uploadPath = session.getServletContext().getRealPath("/WEB-INF/upload");
        try {
            //将VO转换为DTO
            ProductDto productDto = new ProductDto();
            //对象之间属性复制
            PropertyUtils.copyProperties(productDto,productVo);
            //设置DTO的文件传输流
            productDto.setInputStream(productVo.getFile().getInputStream());
            //设置传输文件名
            productDto.setFileName(productVo.getFile().getOriginalFilename());
            //文件路径
            productDto.setUploadPath(uploadPath);
            //添加
            productService.modify(productDto);
            //修改成功
            model.addAttribute("successMsg","修改成功");
        } catch (Exception e) {
            //修改失败
            model.addAttribute("errorMsg",e.getMessage());
        }
        return "forward:findAll?pageNum="+pageNum;
    }

    /*
     * 删除商品
     */
    @RequestMapping("delete")
    @ResponseBody
    public ResponseResult delete(int id){
        productService.delete(id);
        return ResponseResult.success("删除成功");
    }

}
