package com.example.group76.model;

public class Course {
    private String name;
    private String url;

    public Course(String name, String url){
        this.name = name;
        this.url = url;
    }

    public String getName() {
        return name;
    }

    public String getUrl() {
        return url;
    }
}
