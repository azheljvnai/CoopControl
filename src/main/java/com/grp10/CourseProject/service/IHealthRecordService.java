package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.HealthRecord;
import java.util.List;

public interface IHealthRecordService {
    List<HealthRecord> getAll();
    HealthRecord addHealthRecord(HealthRecord healthRecord);
    HealthRecord findById(Long id);
    HealthRecord saveHealthRecord(HealthRecord healthRecord);
    void deleteById(Long id);
    List<HealthRecord> findByFlockId(Long flockId);
    List<HealthRecord> findByRecordType(String recordType);
    long getTotalHealthRecords();
}

