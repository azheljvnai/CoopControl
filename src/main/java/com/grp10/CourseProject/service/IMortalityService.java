package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.Mortality;
import java.util.List;

public interface IMortalityService {
    List<Mortality> getAll();
    Mortality addMortality(Mortality mortality);
    Mortality findById(Long id);
    Mortality saveMortality(Mortality mortality);
    void deleteById(Long id);
    List<Mortality> findByFlockId(Long flockId);
    Integer getTotalMortalityByFlock(Long flockId);
    Integer getTotalMortality();
}

