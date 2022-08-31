package com.backend.userservice.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.backend.userservice.models.User;
import com.backend.userservice.repo.UserRepository;
import com.backend.userservice.services.UserService;
import com.thoughtworks.xstream.mapper.Mapper.Null;

import lombok.AllArgsConstructor;
@RestController
@AllArgsConstructor
public class ServiceController {
    
    private final UserService userService;
    private static final User USER_NOT_FOUND = new User("User not found");

    @GetMapping("/test")
    public String test() {
        return "Hello World";
    }
    @GetMapping("/users")
    public List<User> getAllUsers(){
        return userService.getAllUsers();
    }
    @PostMapping("/createuser")
    public User createUser(@RequestBody User user) {
        userService.createUser(user);
        return user;
    }
    @GetMapping("/user/{id}")
    public User getUser(@PathVariable("id") String id)
    {
        return userService.getUser(id) != null? userService.getUser(id) : USER_NOT_FOUND;
    }
    @GetMapping("/finduser/{name}")
    public User getUserByName(@PathVariable("name") String name)
    {
        return userService.getUserByName(name) != null? userService.getUserByName(name) : USER_NOT_FOUND;
    }
    @GetMapping("/findallusers/{name}")
    public List<User> getAllUsersByName(@PathVariable("name") String name)
    {
        return userService.getAllUsersByName(name);
    }
    @GetMapping("/user/{id}/appointments")
    public List<String> userAppointments(
        @PathVariable("id") String id
    ){

        return userService.getUser(id) != null? 
                                userService.getUser(id).getAppointments() : new ArrayList<>();
    }
    @DeleteMapping("/user/{id}")
    public User deleteUser(@PathVariable("id") String id) {
        User deletedUser = userService.getUser(id);
        return userService.deleteUser(deletedUser) != null ? deletedUser: USER_NOT_FOUND;
    }
    @PutMapping("/user/{id}")
    public String editUser(@PathVariable("id") String id, @RequestBody User user) {
        return userService.editUser(id, user)? "User updated" : "User not found";
    }
}
