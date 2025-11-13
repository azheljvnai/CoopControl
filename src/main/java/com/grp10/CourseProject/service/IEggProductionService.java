package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.EggProduction;
import java.time.LocalDate;
import java.util.List;

public interface IEggProductionService {
    List<EggProduction> getAll();
    EggProduction addEggProduction(EggProduction eggProduction);
    EggProduction findById(Long id);
    EggProduction saveEggProduction(EggProduction eggProduction);
    void deleteById(Long id);
    List<EggProduction> findByFlockId(Long flockId);
    List<EggProduction> findByDateRange(LocalDate startDate, LocalDate endDate);
    Integer getTotalEggsByFlock(Long flockId);
    Integer getTotalEggs();
}

