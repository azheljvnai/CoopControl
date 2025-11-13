package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.Medicine;
import com.grp10.CourseProject.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class MedicineService implements IMedicineService {

    @Autowired
    private MedicineRepository medicineRepository;

    @Override
    public List<Medicine> getAll() {
        return (List<Medicine>) medicineRepository.findAll();
    }

    @Override
    public Medicine addMedicine(Medicine medicine) {
        return saveMedicine(medicine); // Use saveMedicine for null-safe logic
    }

    @Override
    public Medicine saveMedicine(Medicine medicine) {
        // Null-safe logic for both create and update
        if (medicine.getQuantity() == null || medicine.getQuantity() < 0) {
            medicine.setQuantity(0.0);
        }
        if (medicine.getCost() == null) {
            medicine.setCost(BigDecimal.ZERO);
        }
        return medicineRepository.save(medicine);
    }

    @Override
    public Medicine findById(Long id) {
        return medicineRepository.findById(id).orElse(null);
    }

    @Override
    public void deleteById(Long id) {
        medicineRepository.deleteById(id);
    }

    @Override
    public double getTotalItems() {
        return getAll().stream()
                .mapToDouble(m -> (m.getQuantity() != null ? m.getQuantity() : 0.0))
                .sum();
    }
}