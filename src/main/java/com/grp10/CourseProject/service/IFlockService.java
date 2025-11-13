package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.Flock;
import java.util.List;

public interface IFlockService {
    List<Flock> getAllFlocks();
    Flock addFlock(Flock flock);
    long getTotalFlockCount();
    int getTotalBirdCount();

    // CRUD methods
    Flock findFlockById(Long id);
    Flock saveFlock(Flock flock);
    void deleteFlockById(Long id);
}