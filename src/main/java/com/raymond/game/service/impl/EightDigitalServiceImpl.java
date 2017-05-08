package com.raymond.game.service.impl;

import com.raymond.core.generic.GenericDao;
import com.raymond.core.generic.GenericServiceImpl;
import com.raymond.game.service.EightDigitalService;
import com.raymond.game.util.EightDigitalUtil;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("eightDigitalService")
public class EightDigitalServiceImpl extends GenericServiceImpl<String, String> implements
        EightDigitalService {

    @Override
    public GenericDao<String, String> getDao() {
        return null;
    }

    public List<String> getImages(String id) {
        return null;
    }

    public String getResult(String id) {
        EightDigitalUtil eightDigitalUtil = new EightDigitalUtil();
        return eightDigitalUtil.getResult(id);
    }
}
