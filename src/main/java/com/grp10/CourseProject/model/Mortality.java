package com.grp10.CourseProject.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDate;
import java.util.Objects;

@Entity
@Table(name = "mortality_records")
public class Mortality {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "flock_id", nullable = false)
    @NotNull(message = "Flock is required")
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Flock flock;

    @NotNull(message = "Death date is required")
    private LocalDate deathDate;

    @NotNull(message = "Quantity is required")
    @Min(value = 1, message = "Quantity must be at least 1")
    private Integer quantity;

    @Size(max = 200, message = "Cause must not exceed 200 characters")
    private String cause;

    @Size(max = 500, message = "Notes must not exceed 500 characters")
    private String notes;

    public Mortality() {
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Flock getFlock() { return flock; }
    public void setFlock(Flock flock) { this.flock = flock; }
    public LocalDate getDeathDate() { return deathDate; }
    public void setDeathDate(LocalDate deathDate) { this.deathDate = deathDate; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public String getCause() { return cause; }
    public void setCause(String cause) { this.cause = cause; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Mortality mortality = (Mortality) o;
        return id.equals(mortality.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}

