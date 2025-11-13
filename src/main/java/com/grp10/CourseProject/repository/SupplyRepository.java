package com.grp10.CourseProject.repository;

import com.grp10.CourseProject.model.Supply;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SupplyRepository extends CrudRepository<Supply, Long> {
}