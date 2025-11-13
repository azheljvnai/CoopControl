package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.Supply;
import java.util.List;

public interface ISupplyService {
    List<Supply> getAll();
    Supply addSupply(Supply supply);
    Supply saveSupply(Supply supply);
    Supply findById(Long id);
    void deleteById(Long id);
    double getTotalItems(); // For the dashboard card
}