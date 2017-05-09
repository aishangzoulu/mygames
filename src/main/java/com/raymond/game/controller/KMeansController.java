package com.raymond.game.controller;

import com.alibaba.fastjson.JSONObject;
import com.raymond.game.service.KMeansService;
import com.raymond.game.util.kmeans.KMeans;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/game/kmeans")
public class KMeansController {
    @Resource
    private KMeansService kMeansService;

    @RequestMapping(value = {"/index", ""})
    public String index(Model model) {
        return "game/kmeans";
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
        return kMeansService.getImages(id);
    }

    /**
     * @param id
     * @return
     */
    @RequestMapping(value ="/result",produces = "application/json")
    @ResponseBody
    public String getResult(@RequestParam(value = "id", required = true) String id) {
        KMeans kmeans = new KMeans();
        kmeans.init();
        kmeans.calculate();
        kmeans.getClustersList();
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("pointsList",kmeans.getPointsList());
        jsonObject.put("clustersList",kmeans.getClustersList());
        return jsonObject.toJSONString();
    }
}
