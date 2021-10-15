package com.cs.dao;

import com.cs.model.bookstore;

import java.util.List;

public interface bookstoreMapper {
    public List<bookstore> findAll();
    public void addbook(bookstore bookstore);
    public void save(bookstore bookstore);
    public void update(bookstore bookstore);
    public bookstore findById(Integer id);
    public void delete(Integer[] id);
    public bookstore findOnlyBook(String bookname);
    public bookstore readbook(Integer[] id);
}
