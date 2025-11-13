package com.grp10.CourseProject.controller;

import com.grp10.CourseProject.model.Flock;
import com.grp10.CourseProject.service.IFlockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class FlockController {

    @Autowired
    private IFlockService flockService;

    @GetMapping("/flocks")
    public String viewFlocks(Model model) {
        model.addAttribute("flocks", flockService.getAllFlocks());
        return "flocks";
    }

    @PostMapping("/add-flock")
    public String addFlock(@ModelAttribute Flock flock) {
        flockService.addFlock(flock);
        return "redirect:/flocks?action=created&status=success";
    }

    @PostMapping("/update-flock")
    public String updateFlock(@ModelAttribute Flock flock) {
        flockService.saveFlock(flock);
        return "redirect:/flocks?action=updated&status=success";
    }

    @GetMapping("/delete-flock/{id}")
    public String deleteFlock(@PathVariable Long id) {
        flockService.deleteFlockById(id);
        return "redirect:/flocks?action=deleted&status=success";
    }
}