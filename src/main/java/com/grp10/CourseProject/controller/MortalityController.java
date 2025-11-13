package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.model.Mortality;
import com.grp10.CourseProject.service.IMortalityService;
import com.grp10.CourseProject.service.IFlockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MortalityController {

    @Autowired
    private IMortalityService mortalityService;

    @Autowired
    private IFlockService flockService;

    @GetMapping("/mortality")
    public String viewMortality(Model model) {
        model.addAttribute("mortalityRecords", mortalityService.getAll());
        model.addAttribute("flocks", flockService.getAllFlocks());
        return "mortality";
    }

    @PostMapping("/add-mortality")
    public String addMortality(@ModelAttribute Mortality mortality) {
        // Load the Flock object from the ID
        if (mortality.getFlock() != null && mortality.getFlock().getId() != null) {
            com.grp10.CourseProject.model.Flock flock = flockService.findFlockById(mortality.getFlock().getId());
            mortality.setFlock(flock);
        }
        mortalityService.addMortality(mortality);
        return "redirect:/mortality?action=created&status=success";
    }

    @PostMapping("/update-mortality")
    public String updateMortality(@ModelAttribute Mortality mortality) {
        // Load the Flock object from the ID
        if (mortality.getFlock() != null && mortality.getFlock().getId() != null) {
            com.grp10.CourseProject.model.Flock flock = flockService.findFlockById(mortality.getFlock().getId());
            mortality.setFlock(flock);
        }
        mortalityService.saveMortality(mortality);
        return "redirect:/mortality?action=updated&status=success";
    }

    @GetMapping("/delete-mortality/{id}")
    public String deleteMortality(@PathVariable Long id) {
        mortalityService.deleteById(id);
        return "redirect:/mortality?action=deleted&status=success";
    }
}

