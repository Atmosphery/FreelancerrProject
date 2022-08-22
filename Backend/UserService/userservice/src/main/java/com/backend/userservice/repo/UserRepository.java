package com.backend.userservice.repo;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.backend.userservice.models.User;

public interface UserRepository extends MongoRepository<User, String> {
    
}

