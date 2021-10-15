package com.cs.service;

import com.cs.model.users;

import java.util.List;

public interface usersService {
       public List<users> findUsername();
       public void saveUser(users users);
       public users findByUid(Integer uid);
       public users findByFlag();
       public users loginSelect(users users);
       public void deleteUsers(Integer[] uid);
       public void deleteUser(Integer uid);

       public String findOnly(String username);
}
