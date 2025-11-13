package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.exception.ResourceNotFoundException;
import com.grp10.CourseProject.model.Flock;
import com.grp10.CourseProject.service.IFlockService;
import jakarta.validation.Valid;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/flocks")
public class FlockRestController {

    @Autowired
    private IFlockService flockService;

    @GetMapping
    public ResponseEntity<List<Flock>> getAllFlocks(
            @RequestParam(required = false) String breed,
            @RequestParam(required = false) Integer minCount,
            @RequestParam(required = false) Integer maxCount) {
        List<Flock> flocks = flockService.getAllFlocks();
        
        // Filter by breed if provided
        if (breed != null && !breed.isEmpty()) {
            flocks = flocks.stream()
                    .filter(f -> f.getBreed() != null && f.getBreed().equalsIgnoreCase(breed))
                    .collect(Collectors.toList());
        }
        
        // Filter by minCount if provided
        if (minCount != null) {
            flocks = flocks.stream()
                    .filter(f -> f.getCurrentCount() != null && f.getCurrentCount() >= minCount)
                    .collect(Collectors.toList());
        }
        
        // Filter by maxCount if provided
        if (maxCount != null) {
            flocks = flocks.stream()
                    .filter(f -> f.getCurrentCount() != null && f.getCurrentCount() <= maxCount)
                    .collect(Collectors.toList());
        }
        
        return ResponseEntity.ok(flocks);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Flock> getFlock(@PathVariable Long id) {
        Flock flock = flockService.findFlockById(id);
        if (flock == null) {
            throw new ResourceNotFoundException("Flock", "id", id);
        }
        return ResponseEntity.ok(flock);
    }

    @PostMapping
    public ResponseEntity<Flock> createFlock(@Valid @RequestBody Flock flock) {
        Flock created = flockService.addFlock(flock);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Flock> updateFlock(@PathVariable Long id, @Valid @RequestBody Flock flock) {
        Flock existing = flockService.findFlockById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Flock", "id", id);
        }
        flock.setId(id);
        Flock updated = flockService.saveFlock(flock);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteFlock(@PathVariable Long id) {
        Flock existing = flockService.findFlockById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Flock", "id", id);
        }
        flockService.deleteFlockById(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/stats/count")
    public ResponseEntity<Long> getTotalFlockCount() {
        return ResponseEntity.ok(flockService.getTotalFlockCount());
    }

    @GetMapping("/stats/birds")
    public ResponseEntity<Integer> getTotalBirdCount() {
        return ResponseEntity.ok(flockService.getTotalBirdCount());
    }
}

