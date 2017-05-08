package com.raymond.game.controller;

import com.raymond.game.service.EightDigitalService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/game/ed")
public class EightDigitalController {
    @Resource
    private EightDigitalService eightDigitalService;

    @RequestMapping(value = {"/index", ""})
    public String index(Model model) {
        return "game/eightdigital";
    }

    /**
     * 返回某一关游戏
     *
     * @param id
     * @return
     */
    @RequestMapping(value = "/show")
    @ResponseBody
    public List<String> detail(@RequestParam(value = "id", required = true) String id) {
        return eightDigitalService.getImages(id);
    }

    /**
     * @param id
     * @return
     */
    @RequestMapping("/result")
    @ResponseBody
    public String getResult(@RequestParam(value = "id", required = true) String id) {
        return eightDigitalService.getResult(id);
    }
}
