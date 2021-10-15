package com.cs.interceptor;

import com.cs.model.users;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * 登录拦截器
 * */
public class loginInterceptor2 implements HandlerInterceptor {
    /*预处理方法 controller未执行就调用的
     * */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        System.out.println("preHandle");
        users users = (users) request.getSession().getAttribute("users");
        System.out.println(users);

        if(users!=null){if(users.isFlag()==true)
            return true;
        }else {
            request.setAttribute("message","<script>alert('权限不足')</script>");
            return false;
        }
        request.setAttribute("message","<script>alert('请先登录')</script>");
        request.getRequestDispatcher("/index.jsp").forward(request,response);
        return false;
    }
    /*controller执行完但视图未返回，可对模型数据加工
     * */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable ModelAndView modelAndView) throws Exception {
    }
    /*
     * 后处理方法 controller执行完且视图返回完后调用
     * */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, @Nullable Exception ex) throws Exception {
    }
}
