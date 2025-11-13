package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.Mortality;
import com.grp10.CourseProject.repository.MortalityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MortalityService implements IMortalityService {

    @Autowired
    private MortalityRepository repository;

    @Override
    public List<Mortality> getAll() {
        return (List<Mortality>) repository.findAll();
    }

    @Override
    public Mortality addMortality(Mortality mortality) {
        return repository.save(mortality);
    }

    @Override
    public Mortality findById(Long id) {
        return repository.findById(id).orElse(null);
    }

    @Override
    public Mortality saveMortality(Mortality mortality) {
        return repository.save(mortality);
    }

    @Override
    public void deleteById(Long id) {
        repository.deleteById(id);
    }

    @Override
    public List<Mortality> findByFlockId(Long flockId) {
        return repository.findByFlockId(flockId);
    }

    @Override
    public Integer getTotalMortalityByFlock(Long flockId) {
        return repository.findByFlockId(flockId).stream()
                .mapToInt(m -> m.getQuantity() != null ? m.getQuantity() : 0)
                .sum();
    }

    @Override
    public Integer getTotalMortality() {
        return getAll().stream()
                .mapToInt(m -> m.getQuantity() != null ? m.getQuantity() : 0)
                .sum();
    }
}

