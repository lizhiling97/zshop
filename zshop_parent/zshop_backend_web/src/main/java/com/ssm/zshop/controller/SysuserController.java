package com.ssm.zshop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.zshop.comm.constant.PaginationConstant;
import com.ssm.zshop.comm.exception.NotFindSysuserException;
import com.ssm.zshop.comm.util.ResponseResult;
import com.ssm.zshop.entity.Role;
import com.ssm.zshop.entity.Sysuser;
import com.ssm.zshop.param.SysuserParam;
import com.ssm.zshop.service.RoleService;
import com.ssm.zshop.service.SysuserService;
import com.ssm.zshop.vo.SysuserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("backend/sysuser")
public class SysuserController {

    @Autowired
    private SysuserService sysuserService;

    @Autowired
    private RoleService roleService;

    @ModelAttribute("roles")
    public List<Role> loadRoles() {
        List<Role> roles = roleService.findALL();
        return roles;
    }

    /*
     * 登录功能
     */
    @RequestMapping("login")
    public String login(String loginName, String password, HttpSession session, Model model){
        try {
            Sysuser sysuser = sysuserService.login(loginName, password);
            model.addAttribute("sysuser",sysuser);
            return "main";
        } catch (NotFindSysuserException e) {
            model.addAttribute("errorMsg",e.getMessage());
            return "login";
        }
    }

    /*
     * 查询所有
     */
    @RequestMapping("/findAll")
    public String findAll(Integer pageNum, Model model) {

        //实现分页
        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = PaginationConstant.PAGE_NUM;
        }
        //分页插件
        PageHelper.startPage(pageNum, PaginationConstant.PAGE_SIZE);
        List<Sysuser> sysusers = sysuserService.findAll();
        PageInfo<Sysuser> pageInfo = new PageInfo<Sysuser>(sysusers);
        model.addAttribute("pageInfo", pageInfo);
        return "sysuserManager";
    }

    /*
     * 参数查询
     */
    @RequestMapping("findByParam")
    public String findByParam(Integer pageNum, SysuserParam sysuserParam, Model model) {

        if (ObjectUtils.isEmpty(pageNum)) {
            pageNum = PaginationConstant.PAGE_NUM;
        }

        PageHelper.startPage(pageNum, PaginationConstant.PAGE_SIZE);
        List<Sysuser> sysusers = sysuserService.findByParam(sysuserParam);
        PageInfo<Sysuser> pageInfo = new PageInfo<>(sysusers);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("sysuserParam", sysuserParam);

        return "sysuserManager";
    }

    /*
     * 添加
     */
    @RequestMapping("add")
    @ResponseBody
    public ResponseResult add(SysuserVo sysuserVo) {
        sysuserService.add(sysuserVo);
        return ResponseResult.success();
    }


    /*
     * 根据id查询系统用户
     */
    @RequestMapping("findById")
    @ResponseBody
    public ResponseResult findById(int id, Model model) {

        Sysuser sysuser = sysuserService.findById(id);
        System.out.println(sysuser);
        return ResponseResult.success(sysuser);
    }

    /*
     * 根据id修改系统用户
     */
    @RequestMapping("/modify")
    public String modify(SysuserVo sysuserVo) {
        sysuserService.modify(sysuserVo);
        return "forward:findAll";
    }

    /*
     * 修改系统用户状态
     */
    @RequestMapping("changeStatus")
    @ResponseBody
    public ResponseResult changeStatus(int id){
        sysuserService.modifyStatus(id);
        return ResponseResult.success();
    }

}
