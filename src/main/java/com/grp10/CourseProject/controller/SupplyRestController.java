package com.grp10.CourseProject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.grp10.CourseProject.exception.ResourceNotFoundException;
import com.grp10.CourseProject.model.Supply;
import com.grp10.CourseProject.service.ISupplyService;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/api/inventory/supplies")
public class SupplyRestController {

    @Autowired
    private ISupplyService supplyService;

    @GetMapping
    public ResponseEntity<List<Supply>> getAllSupplies() {
        List<Supply> supplies = supplyService.getAll();
        return ResponseEntity.ok(supplies);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Supply> getSupply(@PathVariable Long id) {
        Supply supply = supplyService.findById(id);
        if (supply == null) {
            throw new ResourceNotFoundException("Supply", "id", id);
        }
        return ResponseEntity.ok(supply);
    }

    @PostMapping
    public ResponseEntity<Supply> createSupply(@Valid @RequestBody Supply supply) {
        Supply created = supplyService.addSupply(supply);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Supply> updateSupply(@PathVariable Long id, @Valid @RequestBody Supply supply) {
        Supply existing = supplyService.findById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Supply", "id", id);
        }
        supply.setId(id);
        Supply updated = supplyService.saveSupply(supply);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSupply(@PathVariable Long id) {
        Supply existing = supplyService.findById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Supply", "id", id);
        }
        supplyService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/stats/total")
    public ResponseEntity<Double> getTotalSupplyCount() {
        return ResponseEntity.ok(supplyService.getTotalItems());
    }
}

