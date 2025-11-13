package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.exception.ResourceNotFoundException;
import com.grp10.CourseProject.model.HealthRecord;
import com.grp10.CourseProject.service.IHealthRecordService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/flocks/{flockId}/health-records")
public class HealthRecordRestController {

    @Autowired
    private IHealthRecordService healthRecordService;

    @GetMapping
    public ResponseEntity<List<HealthRecord>> getAllByFlock(@PathVariable Long flockId) {
        List<HealthRecord> records = healthRecordService.findByFlockId(flockId);
        return ResponseEntity.ok(records);
    }

    @GetMapping("/all")
    public ResponseEntity<List<HealthRecord>> getAll() {
        List<HealthRecord> records = healthRecordService.getAll();
        return ResponseEntity.ok(records);
    }

    @GetMapping("/{id}")
    public ResponseEntity<HealthRecord> getHealthRecord(@PathVariable Long id) {
        HealthRecord record = healthRecordService.findById(id);
        if (record == null) {
            throw new ResourceNotFoundException("HealthRecord", "id", id);
        }
        return ResponseEntity.ok(record);
    }

    @GetMapping("/type/{recordType}")
    public ResponseEntity<List<HealthRecord>> getByRecordType(@PathVariable String recordType) {
        List<HealthRecord> records = healthRecordService.findByRecordType(recordType);
        return ResponseEntity.ok(records);
    }

    @PostMapping
    public ResponseEntity<HealthRecord> createHealthRecord(
            @PathVariable Long flockId,
            @Valid @RequestBody HealthRecord healthRecord) {
        HealthRecord created = healthRecordService.addHealthRecord(healthRecord);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<HealthRecord> updateHealthRecord(
            @PathVariable Long id,
            @Valid @RequestBody HealthRecord healthRecord) {
        HealthRecord existing = healthRecordService.findById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("HealthRecord", "id", id);
        }
        healthRecord.setId(id);
        HealthRecord updated = healthRecordService.saveHealthRecord(healthRecord);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteHealthRecord(@PathVariable Long id) {
        HealthRecord existing = healthRecordService.findById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("HealthRecord", "id", id);
        }
        healthRecordService.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}

