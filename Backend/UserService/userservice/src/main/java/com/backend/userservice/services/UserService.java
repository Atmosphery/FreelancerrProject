package com.backend.userservice.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.backend.userservice.models.User;
import com.backend.userservice.repo.UserRepository;
import java.util.Collections;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class UserService {
    @Autowired
    private final UserRepository repo;
    
    public void createUser(User user){
        repo.insert(user);
    }
    public List<User> getAllUsers(){
        return repo.findAll();
    }
    public User getUser(String id){
        if(id == null){
            return null;
        }
        return repo.findById(id).get();
    }
    public void editUser(User user){
        repo.deleteById(user.getId());
        repo.insert(user);
    }
    public void deleteUser(User user){
        repo.deleteById(user.getId());
    }
    public List<String> getUserAppointments(User user){
        //throw not yet implemented
        //this should call the other service to find out the appointments details
        return Collections.emptyList();
    }


}
