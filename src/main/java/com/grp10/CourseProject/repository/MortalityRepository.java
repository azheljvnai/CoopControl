package com.grp10.CourseProject.repository;

import com.grp10.CourseProject.model.Mortality;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MortalityRepository extends CrudRepository<Mortality, Long> {
    List<Mortality> findByFlockId(Long flockId);
}

