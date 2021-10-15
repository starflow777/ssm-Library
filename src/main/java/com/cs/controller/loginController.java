package com.cs.controller;

import com.cs.model.users;
import com.cs.service.usersService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/loginCon")
public class loginController {
    @Resource
    private usersService usersService;
    /*
     * 设计Map集合储存需要给页面的对象数据*/
    private Map<String,Object> result = new HashMap<String, Object>();
    @RequestMapping("/register")
    @ResponseBody
    public Map<String,Object> register(users users){
        try {
            if(usersService.findOnly(users.getUsername()).equals(users.getUsername())){
                result.put("success",false);
                result.put("msg","用户名不能重复！");
            }else {
            usersService.saveUser(users);
            result.put("success",true);
            }
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("msg",e.getMessage());
        }
        return  result;
    }
    @RequestMapping("/login")
    @ResponseBody
    public Map<String,Object> login(users users, HttpSession session){
        try{
        users users1 = usersService.loginSelect(users);
        if(users1.isFlag()==true){
            session.setAttribute("users", users1);
            result.put("success",true);
            result.put("toSource",true);
        }else
        if(users1.isFlag()==false){
            session.setAttribute("users", users1);
            result.put("success",true);
            result.put("toSource",false);
        }
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("msg",e.getMessage());
        }
        return result;
    }

    @RequestMapping("/quitLogin")
    @ResponseBody
    public Map<String,Object>  quitLogin(HttpSession session){
        try {
            session.removeAttribute("users");
            result.put("success",true);
            result.put("msg","退出成功！");
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("msg",e.getMessage());
        }
        return result;
    }

}
