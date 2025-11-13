package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.Supply;
import com.grp10.CourseProject.repository.SupplyRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class SupplyService implements ISupplyService {

    @Autowired
    private SupplyRepository supplyRepository;

    @Override
    public List<Supply> getAll() {
        return (List<Supply>) supplyRepository.findAll();
    }

    @Override
    public Supply addSupply(Supply supply) {
        return saveSupply(supply); // Use saveSupply for null-safe logic
    }

    @Override
    public Supply saveSupply(Supply supply) {
        // Null-safe logic for both create and update
        if (supply.getQuantity() == null || supply.getQuantity() < 0) {
            supply.setQuantity(0.0);
        }
        if (supply.getCost() == null) {
            supply.setCost(BigDecimal.ZERO);
        }
        return supplyRepository.save(supply);
    }

    @Override
    public Supply findById(Long id) {
        return supplyRepository.findById(id).orElse(null);
    }

    @Override
    public void deleteById(Long id) {
        supplyRepository.deleteById(id);
    }

    @Override
    public double getTotalItems() {
        return getAll().stream()
                .mapToDouble(s -> (s.getQuantity() != null ? s.getQuantity() : 0.0))
                .sum();
    }
}