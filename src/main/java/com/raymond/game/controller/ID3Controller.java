package com.raymond.game.controller;

import com.raymond.game.util.id3.ID3Algorithm;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/game/id3")
public class ID3Controller {

    @RequestMapping(value = {"/index", ""})
    public String index(Model model) {
        model.addAttribute("root",ID3Algorithm.getDecisionTreeJson());
        return "game/id3";
    }
}
