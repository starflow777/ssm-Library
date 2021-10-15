package com.cs.service.impl;

import com.cs.dao.bookstoreMapper;
import com.cs.model.bookstore;
import com.cs.service.bookstoreService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class bookstoreServiceimpl implements bookstoreService {
    @Resource
    private bookstoreMapper bookstoremapper;
    @Override
    public List<bookstore> findAll(){return bookstoremapper.findAll();}
    @Override
    public void addbook(bookstore bookstore){bookstoremapper.addbook(bookstore);}
    @Override
    public void save(bookstore bookstore){
        //判断是添加还是修改
        if(bookstore.getId()!=null){
            bookstoremapper.update(bookstore);
        }else {
            bookstoremapper.save(bookstore);
        }
    }
    @Override
    public bookstore findById(Integer id){return bookstoremapper.findById(id);}
    @Override
    public void delete(Integer[] id){bookstoremapper.delete(id);}
    @Override
    public bookstore findOnlyBook(String bookname) {
        return bookstoremapper.findOnlyBook(bookname);
    }
    @Override
    public bookstore readbook(Integer[] id){return bookstoremapper.readbook(id);}
}
