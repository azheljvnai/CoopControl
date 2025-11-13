package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.EggProduction;
import com.grp10.CourseProject.repository.EggProductionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

@Service
public class EggProductionService implements IEggProductionService {

    @Autowired
    private EggProductionRepository repository;

    @Override
    public List<EggProduction> getAll() {
        return (List<EggProduction>) repository.findAll();
    }

    @Override
    public EggProduction addEggProduction(EggProduction eggProduction) {
        return repository.save(eggProduction);
    }

    @Override
    public EggProduction findById(Long id) {
        return repository.findById(id).orElse(null);
    }

    @Override
    public EggProduction saveEggProduction(EggProduction eggProduction) {
        return repository.save(eggProduction);
    }

    @Override
    public void deleteById(Long id) {
        repository.deleteById(id);
    }

    @Override
    public List<EggProduction> findByFlockId(Long flockId) {
        return repository.findByFlockId(flockId);
    }

    @Override
    public List<EggProduction> findByDateRange(LocalDate startDate, LocalDate endDate) {
        return repository.findByCollectionDateBetween(startDate, endDate);
    }

    @Override
    public Integer getTotalEggsByFlock(Long flockId) {
        return repository.findByFlockId(flockId).stream()
                .mapToInt(ep -> ep.getQuantity() != null ? ep.getQuantity() : 0)
                .sum();
    }

    @Override
    public Integer getTotalEggs() {
        return getAll().stream()
                .mapToInt(ep -> ep.getQuantity() != null ? ep.getQuantity() : 0)
                .sum();
    }
}

