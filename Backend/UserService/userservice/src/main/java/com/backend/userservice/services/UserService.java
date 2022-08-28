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
    public boolean editUser(String id, User user){
        repo.findById(id).ifPresent(u -> {
            u.setName(user.getName());
            u.setPhonenumber(user.getPhonenumber());
            u.setEmail(user.getEmail());
            u.setAddress(user.getAddress());
            u.setAppointments(user.getAppointments());
            u.setBio(user.getBio());
            u.setPassword(user.getPassword());
            u.setVender(user.isVender());
            repo.save(u);
        } );
        return repo.findById(id).isPresent();
    }
    public User deleteUser(User user){
        try{
            repo.deleteById(user.getId());
            return user;
        }
        catch(Exception e){
            return null;
        }
    }
    public List<String> getUserAppointments(User user){
        //throw not yet implemented
        //this should call the other service to find out the appointments details
        return Collections.emptyList();
    }
}
