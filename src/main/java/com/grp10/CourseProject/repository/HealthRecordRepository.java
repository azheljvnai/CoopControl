package com.grp10.CourseProject.repository;

import com.grp10.CourseProject.model.HealthRecord;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HealthRecordRepository extends CrudRepository<HealthRecord, Long> {
    List<HealthRecord> findByFlockId(Long flockId);
    List<HealthRecord> findByRecordType(String recordType);
}

