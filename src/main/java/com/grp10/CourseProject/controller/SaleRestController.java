package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.exception.ResourceNotFoundException;
import com.grp10.CourseProject.model.Sale;
import com.grp10.CourseProject.service.IFinanceService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/financials/sales")
public class SaleRestController {

    @Autowired
    private IFinanceService financeService;

    @GetMapping
    public ResponseEntity<List<Sale>> getAllSales(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(required = false) Long flockId) {
        List<Sale> sales = financeService.getAllSales();
        
        // Filter by date range
        if (startDate != null || endDate != null) {
            if (startDate != null && endDate != null) {
                sales = sales.stream()
                        .filter(s -> s.getSaleDate() != null && 
                                !s.getSaleDate().isBefore(startDate) && 
                                !s.getSaleDate().isAfter(endDate))
                        .collect(Collectors.toList());
            } else if (startDate != null) {
                sales = sales.stream()
                        .filter(s -> s.getSaleDate() != null && !s.getSaleDate().isBefore(startDate))
                        .collect(Collectors.toList());
            } else if (endDate != null) {
                sales = sales.stream()
                        .filter(s -> s.getSaleDate() != null && !s.getSaleDate().isAfter(endDate))
                        .collect(Collectors.toList());
            }
        }
        
        // Filter by flock ID
        if (flockId != null) {
            sales = sales.stream()
                    .filter(s -> s.getFlock() != null && s.getFlock().getId().equals(flockId))
                    .collect(Collectors.toList());
        }
        
        return ResponseEntity.ok(sales);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Sale> getSale(@PathVariable Long id) {
        Sale sale = financeService.findSaleById(id);
        if (sale == null) {
            throw new ResourceNotFoundException("Sale", "id", id);
        }
        return ResponseEntity.ok(sale);
    }

    @PostMapping
    public ResponseEntity<Sale> createSale(@Valid @RequestBody Sale sale) {
        Sale created = financeService.addSale(sale);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Sale> updateSale(@PathVariable Long id, @Valid @RequestBody Sale sale) {
        Sale existing = financeService.findSaleById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Sale", "id", id);
        }
        sale.setId(id);
        Sale updated = financeService.saveSale(sale);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteSale(@PathVariable Long id) {
        Sale existing = financeService.findSaleById(id);
        if (existing == null) {
            throw new ResourceNotFoundException("Sale", "id", id);
        }
        financeService.deleteSaleById(id);
        return ResponseEntity.noContent().build();
    }
}

