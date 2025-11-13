package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.Medicine;
import java.util.List;

public interface IMedicineService {
    List<Medicine> getAll();
    Medicine addMedicine(Medicine medicine);
    Medicine saveMedicine(Medicine medicine);
    Medicine findById(Long id);
    void deleteById(Long id);
    double getTotalItems();
}