package com.grp10.CourseProject.repository;

import com.grp10.CourseProject.model.EggProduction;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface EggProductionRepository extends CrudRepository<EggProduction, Long> {
    List<EggProduction> findByFlockId(Long flockId);
    List<EggProduction> findByCollectionDateBetween(LocalDate startDate, LocalDate endDate);
}

