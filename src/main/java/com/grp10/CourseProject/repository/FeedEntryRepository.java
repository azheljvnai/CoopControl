package com.grp10.CourseProject.repository;

import com.grp10.CourseProject.model.FeedEntry;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FeedEntryRepository extends CrudRepository<FeedEntry, Long> {}
