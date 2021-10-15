package com.cs.controller;

import com.cs.model.users;
import com.cs.service.usersService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/usersCon")
public class usersController {
    @Resource
    private usersService usersService;

    private Map<String,Object> result = new HashMap<>();
    @RequestMapping("/listByPage")
    @ResponseBody
    public Map<String ,Object> listByPage(Integer page,Integer rows){
        //分页参数
        PageHelper.startPage(page,rows);
        List<users> list = usersService.findUsername();
        //用PageInfo封装
        PageInfo<users> pageInfo = new PageInfo<>(list);
        //总数
        long total = pageInfo.getTotal();
        List<users> ulist = pageInfo.getList();
        result.put("total",total);
        result.put("rows",ulist);
        return  result;
    }
    @RequestMapping("/userXXList")
    @ResponseBody
    public Map<String ,Object> userXXList(HttpSession session,Integer page,Integer rows){
        //分页参数
        System.out.println("1");
        PageHelper.startPage(page,rows);
        users user = (users) session.getAttribute("users");
        System.out.println(user);
                    List<users> list=new ArrayList<>();
                    list.add(user);
        //用PageInfo封装
        PageInfo<users> pageInfo = new PageInfo<>(list);
        //总数
        long total = pageInfo.getTotal();
        List<users> ulist = pageInfo.getList();
        result.put("total",total);
        result.put("rows",ulist);
        return  result;
    }
    @RequestMapping("/save")
    @ResponseBody
    public Map<String,Object> save(users users){
        try {
            usersService.saveUser(users);
            result.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("msg",e.getMessage());
        }
        return  result;
    }

    @RequestMapping("/findByUid")
    @ResponseBody
    public users fingByUid(Integer uid){
        users user = usersService.findByUid(uid);
        return user;
    }

    @RequestMapping("/deleteUsers")
    @ResponseBody
    public Map<String,Object>deleteUsers(Integer[] uid){
        try {
            usersService.deleteUsers(uid);
            result.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("msg",e.getMessage());
        }
        return  result;
    }
}
