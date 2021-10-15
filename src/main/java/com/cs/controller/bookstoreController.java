package com.cs.controller;

import com.cs.model.bookstore;
import com.cs.model.users;
import com.cs.service.bookstoreService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bookstore")
public class bookstoreController {

    @Resource
    private bookstoreService bookstoreservice;


    //@ResponseBody将java对象转换为json格式的数据（将controller返回值转换成指定格式后，写入到response对象的body区）
    // 在使用此注解之后不会再走视图处理器，而是直接将数据写入到输入流中，他的效果等同于通过response对象输出指定格式的数据
   // 在使用 @RequestMapping后，返回值通常解析为跳转路径，但是加上 @ResponseBody 后返回结果不会被解析为跳转路径，而是直接写入 HTTP response body 中
    @RequestMapping("/list")
    @ResponseBody
    public List<bookstore> list(){
        List<bookstore> list = bookstoreservice.findAll();
        return list;
    }
/*
* 设计Map集合储存需要给页面的对象数据*/
    private Map<String,Object> result = new HashMap<String, Object>();

    @RequestMapping("/listByPage")
    @ResponseBody
    public Map<String,Object> listByPage(Integer page,Integer rows){
     //设置分页参数
        PageHelper.startPage(page,rows);
        List<bookstore> list = bookstoreservice.findAll();
//        使用PageInfo封装查询结果
        PageInfo<bookstore> pageInfo = new PageInfo<bookstore>(list);
//        取出查询结果1:总记录数
        Long total = pageInfo.getTotal();
//        当前数据列表
        List<bookstore> bklist = pageInfo.getList();
        result.put("total",total);
        result.put("rows",bklist);
        return result;
    }
    @RequestMapping("/save")
    @ResponseBody
    public Map<String,Object> save(bookstore bookstore, HttpSession session){
        try {
            users user = (users) session.getAttribute("users");
            if(user==null){
                result.put("success",false);
                result.put("msg","未登录状态！请先登录~");
            }else{
            bookstoreservice.save(bookstore);
            result.put("success",true);
            }
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
            result.put("msg",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/findById")
    @ResponseBody
    public bookstore findById(Integer id){
        bookstore book = bookstoreservice.findById(id);
        return book;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public Map<String,Object> delete(Integer[] id,HttpSession session){
        try {
            users user = (users) session.getAttribute("users");
            if (user == null) {
                result.put("success", false);
                result.put("msg", "未登录状态！请先登录~");
            } else {
                if (user.isFlag()) {
                    bookstoreservice.delete(id);
                    result.put("success", true);
                } else {
                    result.put("success",false);
                    result.put("msg","您不是管理员，无法操作！");
                }
            }
        }catch (Exception e){
            result.put("success",false);
            result.put("msg",e.getMessage());
        }
        return result;
    }
    @RequestMapping("/read")
    @ResponseBody
    public Map<String,Object> read(Integer[] id,HttpSession session){
        try {
            users user = (users) session.getAttribute("users");
            if (user == null) {
                result.put("success", false);
                result.put("msg", "未登录状态！请先登录~");
            } else {
               bookstore bookstore1= bookstoreservice.readbook(id);
                    result.put("success",true);
                    result.put("msg",bookstore1.getComment());
            }
        }catch (Exception e){
            result.put("success",false);
            result.put("msg",e.getMessage());
        }
        return result;
    }

}
