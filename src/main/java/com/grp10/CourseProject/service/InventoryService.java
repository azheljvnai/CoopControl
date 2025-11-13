package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.FeedEntry;
import com.grp10.CourseProject.repository.FeedEntryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class InventoryService implements IInventoryService {

    @Autowired
    private FeedEntryRepository feedEntryRepository;

    @Override
    public List<FeedEntry> getAllFeedEntries() {
        return (List<FeedEntry>) feedEntryRepository.findAll();
    }

    @Override
    public FeedEntry addFeedEntry(FeedEntry feedEntry) {
        // For CREATING
        if (feedEntry.getQuantityKg() == null || feedEntry.getQuantityKg() < 0) {
            feedEntry.setQuantityKg(0.0);
        }
        if (feedEntry.getCost() == null) {
            feedEntry.setCost(BigDecimal.ZERO);
        }
        return feedEntryRepository.save(feedEntry);
    }

    @Override
    public double getTotalFeedStockKg() {
        return getAllFeedEntries().stream()
                .mapToDouble(entry -> (entry.getQuantityKg() != null ? entry.getQuantityKg() : 0.0))
                .sum();
    }

    @Override
    public FeedEntry findFeedEntryById(Long id) {
        return feedEntryRepository.findById(id).orElse(null);
    }

    @Override
    public FeedEntry saveFeedEntry(FeedEntry feedEntry) {
        // --- THIS IS THE FIX ---
        // This is for UPDATING
        if (feedEntry.getQuantityKg() == null || feedEntry.getQuantityKg() < 0) {
            feedEntry.setQuantityKg(0.0);
        }
        if (feedEntry.getCost() == null) {
            feedEntry.setCost(BigDecimal.ZERO);
        }
        // --- END OF FIX ---
        return feedEntryRepository.save(feedEntry);
    }

    @Override
    public void deleteFeedEntryById(Long id) {
        feedEntryRepository.deleteById(id);
    }
}