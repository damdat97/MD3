package service;

import model.Product;

import java.util.List;

public interface ProductService {
    List<Product> findAll();

    void save(Product product);

    int findIndexById(int id);

    Product findById(int id);

    List<Product> findByName(String name);

    void update(int id, Product product);

    void delete(int id);
}
