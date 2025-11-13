package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.exception.ResourceNotFoundException;
import com.grp10.CourseProject.model.Medicine;
import com.grp10.CourseProject.service.IMedicineService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/inventory/medicine")
public class MedicineRestController {

    @Autowired
    private IMedicineService medicineService;

    @GetMapping
    public ResponseEntity<List<Medicine>> getAllMedicines(@RequestParam(required = false) Long flockId) {
        List<Medicine> medicines = medicineService.getAll();
        
        if (flockId != null) {
            medicines = medicines.stream()
                    .filter(m -> m.getFlock() != null && m.getFlock().getId().equals(flockId))
                    .collect(java.util.stream.Collectors.toList());
        }
        
        return ResponseEntity.ok(medicines);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Medicine> getMedicine(@PathVariable Long id) {
        Medicine medicine = medicineService.findById(id);
        if (medicine == null) {
            throw new ResourceNotFoundException("Medicine", "id", id);
        }
        return ResponseEntity.ok(medicine);
    }

    @PostMapping
    public ResponseEntity<Medicine> createMedicine(@Valid @RequestBody Medicine medicine) {
        Medicine created = medicineService.addMedicine(medicine);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Medicine> updateMedicine(@PathVariable Long id, @Valid @RequestBody Medicine medicine) {
        Medicine existing = medicineService.findById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Medicine", "id", id);
        }
        medicine.setId(id);
        Medicine updated = medicineService.saveMedicine(medicine);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMedicine(@PathVariable Long id) {
        Medicine existing = medicineService.findById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Medicine", "id", id);
        }
        medicineService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/stats/total")
    public ResponseEntity<Double> getTotalMedicineCount() {
        return ResponseEntity.ok(medicineService.getTotalItems());
    }
}

