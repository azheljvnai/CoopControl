package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.exception.ResourceNotFoundException;
import com.grp10.CourseProject.model.FeedEntry;
import com.grp10.CourseProject.service.IInventoryService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/inventory/feed")
public class FeedEntryRestController {

    @Autowired
    private IInventoryService inventoryService;

    @GetMapping
    public ResponseEntity<List<FeedEntry>> getAllFeedEntries(
            @RequestParam(required = false) String feedType,
            @RequestParam(required = false) Long flockId) {
        List<FeedEntry> feedEntries = inventoryService.getAllFeedEntries();
        
        if (feedType != null && !feedType.isEmpty()) {
            feedEntries = feedEntries.stream()
                    .filter(f -> f.getFeedType() != null && f.getFeedType().equalsIgnoreCase(feedType))
                    .collect(java.util.stream.Collectors.toList());
        }
        
        if (flockId != null) {
            feedEntries = feedEntries.stream()
                    .filter(f -> f.getFlock() != null && f.getFlock().getId().equals(flockId))
                    .collect(java.util.stream.Collectors.toList());
        }
        
        return ResponseEntity.ok(feedEntries);
    }

    @GetMapping("/{id}")
    public ResponseEntity<FeedEntry> getFeedEntry(@PathVariable Long id) {
        FeedEntry feedEntry = inventoryService.findFeedEntryById(id);
        if (feedEntry == null) {
            throw new ResourceNotFoundException("FeedEntry", "id", id);
        }
        return ResponseEntity.ok(feedEntry);
    }

    @PostMapping
    public ResponseEntity<FeedEntry> createFeedEntry(@Valid @RequestBody FeedEntry feedEntry) {
        FeedEntry created = inventoryService.addFeedEntry(feedEntry);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<FeedEntry> updateFeedEntry(@PathVariable Long id, @Valid @RequestBody FeedEntry feedEntry) {
        FeedEntry existing = inventoryService.findFeedEntryById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("FeedEntry", "id", id);
        }
        feedEntry.setId(id);
        FeedEntry updated = inventoryService.saveFeedEntry(feedEntry);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteFeedEntry(@PathVariable Long id) {
        FeedEntry existing = inventoryService.findFeedEntryById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("FeedEntry", "id", id);
        }
        inventoryService.deleteFeedEntryById(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/stats/total")
    public ResponseEntity<Double> getTotalFeedStock() {
        return ResponseEntity.ok(inventoryService.getTotalFeedStockKg());
    }
}

