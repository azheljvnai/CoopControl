package com.grp10.CourseProject.repository;

import com.grp10.CourseProject.model.Flock;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface FlockRepository extends CrudRepository<Flock, Long> {}
