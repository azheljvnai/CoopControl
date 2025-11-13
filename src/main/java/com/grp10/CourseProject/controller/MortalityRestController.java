package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.exception.ResourceNotFoundException;
import com.grp10.CourseProject.model.Mortality;
import com.grp10.CourseProject.service.IMortalityService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/flocks/{flockId}/mortality")
public class MortalityRestController {

    @Autowired
    private IMortalityService mortalityService;

    @GetMapping
    public ResponseEntity<List<Mortality>> getAllByFlock(@PathVariable Long flockId) {
        List<Mortality> records = mortalityService.findByFlockId(flockId);
        return ResponseEntity.ok(records);
    }

    @GetMapping("/all")
    public ResponseEntity<List<Mortality>> getAll() {
        List<Mortality> records = mortalityService.getAll();
        return ResponseEntity.ok(records);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Mortality> getMortality(@PathVariable Long id) {
        Mortality record = mortalityService.findById(id);
        if (record == null) {
            throw new ResourceNotFoundException("Mortality", "id", id);
        }
        return ResponseEntity.ok(record);
    }

    @PostMapping
    public ResponseEntity<Mortality> createMortality(
            @PathVariable Long flockId,
            @Valid @RequestBody Mortality mortality) {
        Mortality created = mortalityService.addMortality(mortality);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Mortality> updateMortality(
            @PathVariable Long id,
            @Valid @RequestBody Mortality mortality) {
        Mortality existing = mortalityService.findById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Mortality", "id", id);
        }
        mortality.setId(id);
        Mortality updated = mortalityService.saveMortality(mortality);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMortality(@PathVariable Long id) {
        Mortality existing = mortalityService.findById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Mortality", "id", id);
        }
        mortalityService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/stats/total")
    public ResponseEntity<Integer> getTotalMortalityByFlock(@PathVariable Long flockId) {
        return ResponseEntity.ok(mortalityService.getTotalMortalityByFlock(flockId));
    }
}

