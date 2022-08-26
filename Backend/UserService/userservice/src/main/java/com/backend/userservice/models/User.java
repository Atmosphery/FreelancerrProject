package com.backend.userservice.models;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.Data;

@Data
@Document
public class User {
    @Id
    private String id;

    private String name;
    private String phonenumber;
    private String email;
    private String address;
    private String password;
    private String bio;
    private boolean isVender;
    //store the appointment Id's in a list
    private List<String> appointments;
    //create contructor
    public User(String name, String phonenumber, String email, String address, String password, String bio, boolean isVender, List<String> appointments) {
        this.name = name;
        this.phonenumber = phonenumber;
        this.email = email;
        this.address = address;
        this.password = password;
        this.bio = bio;
        this.isVender = isVender;
        this.appointments = appointments;
    }
    public User(String name){
        this.name = name;
    }
    //create a toString method
    @Override
    public String toString() {
        return "User{ "+ "name: " + name + ", phonenumber: " + phonenumber + ", email: " + email + ", address: " + address + ", password: " + password + ", bio: " + bio + ", isVender: " + isVender + ", appointments: " + appointments + "}";
    }
}
