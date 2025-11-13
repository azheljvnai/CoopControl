package com.grp10.CourseProject.service;

import com.grp10.CourseProject.model.HealthRecord;
import com.grp10.CourseProject.repository.HealthRecordRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HealthRecordService implements IHealthRecordService {

    @Autowired
    private HealthRecordRepository repository;

    @Override
    public List<HealthRecord> getAll() {
        return (List<HealthRecord>) repository.findAll();
    }

    @Override
    public HealthRecord addHealthRecord(HealthRecord healthRecord) {
        return repository.save(healthRecord);
    }

    @Override
    public HealthRecord findById(Long id) {
        return repository.findById(id).orElse(null);
    }

    @Override
    public HealthRecord saveHealthRecord(HealthRecord healthRecord) {
        return repository.save(healthRecord);
    }

    @Override
    public void deleteById(Long id) {
        repository.deleteById(id);
    }

    @Override
    public List<HealthRecord> findByFlockId(Long flockId) {
        return repository.findByFlockId(flockId);
    }

    @Override
    public List<HealthRecord> findByRecordType(String recordType) {
        return repository.findByRecordType(recordType);
    }

    @Override
    public long getTotalHealthRecords() {
        return repository.count();
    }
}

