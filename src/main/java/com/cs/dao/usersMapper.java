package com.cs.dao;

import com.cs.model.users;

import java.util.List;

public interface usersMapper {
    public List<users> findUsername();
    public void saveUser(users users);
    public users findByUid(Integer uid);
    public users findByFlag(boolean flag);
//    public users loginSelect(@Param("username")String username,@Param("password")String password);
public users loginSelect(users users);
    public void updateUser(users users);
    public void deleteUsers(Integer[] uid);
    public void deleteUser(Integer uid);

    public users findOnly(String username);
}
