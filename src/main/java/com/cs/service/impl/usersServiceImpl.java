package com.cs.service.impl;

import com.cs.dao.usersMapper;
import com.cs.model.users;
import com.cs.service.usersService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class usersServiceImpl implements usersService {
    @Resource
    private usersMapper usersMapper;
    @Override
    public List<users> findUsername() {
        return usersMapper.findUsername();
    }

    @Override
    public void saveUser(users users) {
        if(users.getUid()!=null){
            usersMapper.updateUser(users);
        }else {
            boolean flag=false;
            users.setFlag(flag);
        usersMapper.saveUser(users);
        }
    }

    @Override
    public users findByUid(Integer uid) {
        return usersMapper.findByUid(uid);
    }
    @Override
    public users findByFlag() {
        boolean flag=false;
        return usersMapper.findByFlag(flag);
    }

@Override
public users loginSelect(users users) {
    return usersMapper.loginSelect(users);
 }

    @Override
    public void deleteUsers(Integer[] uid) {
        usersMapper.deleteUsers(uid);
    }

    @Override
    public void deleteUser(Integer uid) {
        usersMapper.deleteUser(uid);
    }

    @Override
    public String findOnly(String username) {
       return usersMapper.findOnly(username).getUsername();
    }
}
