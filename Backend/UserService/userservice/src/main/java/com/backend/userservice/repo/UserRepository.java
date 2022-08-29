package com.backend.userservice.repo;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.backend.userservice.models.User;

public interface UserRepository extends MongoRepository<User, String> {
    User findByNameIgnoreCase(String name);
    List<User> findAllByNameIgnoreCase(String name);
}

