package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.model.EggProduction;
import com.grp10.CourseProject.model.Flock;
import com.grp10.CourseProject.service.IEggProductionService;
import com.grp10.CourseProject.service.IFlockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class EggProductionController {

    @Autowired
    private IEggProductionService eggProductionService;

    @Autowired
    private IFlockService flockService;

    @GetMapping("/egg-production")
    public String viewEggProduction(Model model) {
        model.addAttribute("eggProductions", eggProductionService.getAll());
        model.addAttribute("flocks", flockService.getAllFlocks());
        return "egg-production";
    }

    @PostMapping("/add-egg-production")
    public String addEggProduction(@ModelAttribute EggProduction eggProduction) {
        // Load the Flock object from the ID
        if (eggProduction.getFlock() != null && eggProduction.getFlock().getId() != null) {
            Flock flock = flockService.findFlockById(eggProduction.getFlock().getId());
            eggProduction.setFlock(flock);
        }
        eggProductionService.addEggProduction(eggProduction);
        return "redirect:/egg-production?action=created&status=success";
    }

    @PostMapping("/update-egg-production")
    public String updateEggProduction(@ModelAttribute EggProduction eggProduction) {
        // Load the Flock object from the ID
        if (eggProduction.getFlock() != null && eggProduction.getFlock().getId() != null) {
            Flock flock = flockService.findFlockById(eggProduction.getFlock().getId());
            eggProduction.setFlock(flock);
        }
        eggProductionService.saveEggProduction(eggProduction);
        return "redirect:/egg-production?action=updated&status=success";
    }

    @GetMapping("/delete-egg-production/{id}")
    public String deleteEggProduction(@PathVariable Long id) {
        eggProductionService.deleteById(id);
        return "redirect:/egg-production?action=deleted&status=success";
    }
}

