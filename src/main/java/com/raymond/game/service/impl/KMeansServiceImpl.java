package com.raymond.game.service.impl;

import com.raymond.game.service.KMeansService;
import com.raymond.game.util.EightDigitalUtil;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("kmeansService")
public class KMeansServiceImpl implements KMeansService {

    public List<String> getImages(String id) {
        return null;
    }

    public String getResult(String id) {
        EightDigitalUtil eightDigitalUtil = new EightDigitalUtil();
        return eightDigitalUtil.getResult(id);
    }
}
