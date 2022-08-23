package com.backend.userservice.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.backend.userservice.models.User;
import com.backend.userservice.repo.UserRepository;
import com.backend.userservice.services.UserService;

import lombok.AllArgsConstructor;

@RestController
@AllArgsConstructor
public class ServiceController {
    private final UserService userService;
    private static final String USER_NOT_FOUND = "User not found";

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
    public String getUser(
        @PathVariable("id") String id
        )
    {
        return userService.getUser(id) != null? userService.getUser(id).toString() : USER_NOT_FOUND;
    }
    @GetMapping("/user/{id}/appointments")
    public List<String> userAppointments(
        @PathVariable("id") String id
    ){

        return userService.getUser(id) != null? 
                                userService.getUser(id).getAppointments() : new ArrayList<>();
    }
    
}
