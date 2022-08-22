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
    //store the appointment Id's in a list
    private List<String> appointments;
    //create contructor
    public User(String name, String phonenumber, String email, String address, List<String> appointments) {
        this.name = name;
        this.phonenumber = phonenumber;
        this.email = email;
        this.address = address;
        this.appointments = appointments;
    }
    //create a toString method
    @Override
    public String toString() {
        return "id=" + id + ", name=" + name + ", phonenumber=" + phonenumber + ", email=" + email + ", address=" + address + ", appointments=" + appointments;
    }
}
