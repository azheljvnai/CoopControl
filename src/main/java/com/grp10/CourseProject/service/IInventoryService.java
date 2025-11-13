package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.FeedEntry;
import java.util.List;

public interface IInventoryService {
    List<FeedEntry> getAllFeedEntries();
    FeedEntry addFeedEntry(FeedEntry feedEntry);
    double getTotalFeedStockKg();

    // CRUD methods
    FeedEntry findFeedEntryById(Long id);
    FeedEntry saveFeedEntry(FeedEntry feedEntry);
    void deleteFeedEntryById(Long id);
}