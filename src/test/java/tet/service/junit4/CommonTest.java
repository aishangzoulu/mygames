package tet.service.junit4;

import com.raymond.core.feature.test.TestSupport;
import com.raymond.game.util.EightDigitalUtil;
import org.junit.Test;

import com.alibaba.fastjson.JSONObject;
import com.raymond.core.util.DateUtils;

public class CommonTest extends TestSupport {

    @Test
    public void testDate() {
        System.out.println(JSONObject.toJSONString(DateUtils.getBetweenDates("2016-07-01", "2016-08-01")));
    }

    @Test
    public void testEightDigital() {
        EightDigitalUtil eightDigitalUtil = new EightDigitalUtil();
        String result = eightDigitalUtil.getResult("123456078");
        System.out.println(result);
    }
}
