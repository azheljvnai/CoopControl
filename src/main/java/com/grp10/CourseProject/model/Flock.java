package com.grp10.CourseProject.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDate;
import java.util.Objects;

@Entity
@Table(name = "flocks")
public class Flock {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Flock name is required")
    @Size(min = 1, max = 100, message = "Name must be between 1 and 100 characters")
    private String name;

    @NotBlank(message = "Breed is required")
    @Size(max = 100, message = "Breed must not exceed 100 characters")
    private String breed;

    @NotNull(message = "Acquisition date is required")
    private LocalDate acquisitionDate;

    @NotNull(message = "Initial count is required")
    @Min(value = 0, message = "Initial count cannot be negative")
    private Integer initialCount;

    @NotNull(message = "Current count is required")
    @Min(value = 0, message = "Current count cannot be negative")
    private Integer currentCount;

    public Flock() {
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getBreed() { return breed; }
    public void setBreed(String breed) { this.breed = breed; }
    public LocalDate getAcquisitionDate() { return acquisitionDate; }
    public void setAcquisitionDate(LocalDate acquisitionDate) { this.acquisitionDate = acquisitionDate; }
    public Integer getInitialCount() { return initialCount; }
    public void setInitialCount(Integer initialCount) { this.initialCount = initialCount; }
    public Integer getCurrentCount() { return currentCount; }
    public void setCurrentCount(Integer currentCount) { this.currentCount = currentCount; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Flock flock = (Flock) o;
        return id.equals(flock.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}