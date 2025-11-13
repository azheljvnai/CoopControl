package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.exception.ResourceNotFoundException;
import com.grp10.CourseProject.model.EggProduction;
import com.grp10.CourseProject.service.IEggProductionService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/flocks/{flockId}/egg-production")
public class EggProductionRestController {

    @Autowired
    private IEggProductionService eggProductionService;

    @GetMapping
    public ResponseEntity<List<EggProduction>> getAllByFlock(@PathVariable Long flockId) {
        List<EggProduction> records = eggProductionService.findByFlockId(flockId);
        return ResponseEntity.ok(records);
    }

    @GetMapping("/all")
    public ResponseEntity<List<EggProduction>> getAll() {
        List<EggProduction> records = eggProductionService.getAll();
        return ResponseEntity.ok(records);
    }

    @GetMapping("/{id}")
    public ResponseEntity<EggProduction> getEggProduction(@PathVariable Long id) {
        EggProduction record = eggProductionService.findById(id);
        if (record == null) {
            throw new ResourceNotFoundException("EggProduction", "id", id);
        }
        return ResponseEntity.ok(record);
    }

    @GetMapping("/date-range")
    public ResponseEntity<List<EggProduction>> getByDateRange(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        List<EggProduction> records = eggProductionService.findByDateRange(startDate, endDate);
        return ResponseEntity.ok(records);
    }

    @PostMapping
    public ResponseEntity<EggProduction> createEggProduction(
            @PathVariable Long flockId,
            @Valid @RequestBody EggProduction eggProduction) {
        // Set flock if needed (assuming flockId in path)
        EggProduction created = eggProductionService.addEggProduction(eggProduction);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<EggProduction> updateEggProduction(
            @PathVariable Long id,
            @Valid @RequestBody EggProduction eggProduction) {
        EggProduction existing = eggProductionService.findById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("EggProduction", "id", id);
        }
        eggProduction.setId(id);
        EggProduction updated = eggProductionService.saveEggProduction(eggProduction);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteEggProduction(@PathVariable Long id) {
        EggProduction existing = eggProductionService.findById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("EggProduction", "id", id);
        }
        eggProductionService.deleteById(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/stats/total")
    public ResponseEntity<Integer> getTotalEggsByFlock(@PathVariable Long flockId) {
        return ResponseEntity.ok(eggProductionService.getTotalEggsByFlock(flockId));
    }
}

