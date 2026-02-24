package com.example.group76.service;

import com.example.group76.model.Course;
import com.example.group76.model.CourseFilter;

import java.util.List;
import java.util.stream.Collectors;

public class CourseSearchService {

    public List<Course> searchCourses(List<Course> allCourses, CourseFilter filter) {
        if (filter == null || filter.getKeyword() == null || filter.getKeyword().isEmpty())
            return allCourses;

        String keywordLower = filter.getKeyword().toLowerCase();

        return allCourses.stream()
                .filter(c -> c.getName().toLowerCase().contains(keywordLower))
                .collect(Collectors.toList());
    }
}
