package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.Flock;
import com.grp10.CourseProject.repository.FlockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FlockService implements IFlockService {
    @Autowired
    private FlockRepository flockRepository;

    @Override
    public List<Flock> getAllFlocks() {
        return (List<Flock>) flockRepository.findAll();
    }

    @Override
    public Flock addFlock(Flock flock) {
        // This logic is for creating NEW flocks
        if (flock.getInitialCount() == null || flock.getInitialCount() < 0) {
            flock.setInitialCount(0);
        }
        // Only set currentCount on creation
        flock.setCurrentCount(flock.getInitialCount());

        return flockRepository.save(flock);
    }

    @Override
    public Flock findFlockById(Long id) {
        return flockRepository.findById(id).orElse(null);
    }

    @Override
    public Flock saveFlock(Flock flock) {
        // --- THIS IS THE FIX ---
        // This logic is for UPDATING existing flocks
        // We must protect number fields from becoming null
        if (flock.getInitialCount() == null || flock.getInitialCount() < 0) {
            flock.setInitialCount(0);
        }
        if (flock.getCurrentCount() == null || flock.getCurrentCount() < 0) {
            flock.setCurrentCount(0);
        }
        // --- END OF FIX ---

        return flockRepository.save(flock);
    }

    @Override
    public void deleteFlockById(Long id) {
        flockRepository.deleteById(id);
    }

    @Override
    public long getTotalFlockCount() {
        return flockRepository.count();
    }

    @Override
    public int getTotalBirdCount() {
        return getAllFlocks().stream()
                .mapToInt(f -> (f.getCurrentCount() != null ? f.getCurrentCount() : 0))
                .sum();
    }
}