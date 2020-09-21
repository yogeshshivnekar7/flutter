package node_service;

import com.cubeone.app.R;

import java.util.ArrayList;
import java.util.List;

public class AppConstant {
    public final static String NOODE_URL_KEY = "node_url_key";
    //    public final static  String NODE_SERVER_URL = "http://stgrealtime.vizitorlog.com/";
    public final static String PREFERNCE_KEY = "com.cubeone.app";
    public final static int PRIVATE_MODE = 0;
    static List<Integer> color;

    public static int getColor(char s) {
        List<Integer> mcolor = getCarColors();
        return mcolor.get(s % 26);
    }

    public static List<Integer> getCarColors() {
        if (color == null) {
            color = new ArrayList<>();
            color.add(R.color.color_F44336);
            color.add(R.color.color_E91E63);
            color.add(R.color.color_673AB7);
            color.add(R.color.color_3F51B5);
            color.add(R.color.color_03A9F4);
            color.add(R.color.color_2196F3);
            color.add(R.color.color_009688);
            color.add(R.color.color_FFC107);
            color.add(R.color.color_CDDC39);
            color.add(R.color.color_4CAF50);
            color.add(R.color.color_F44336);
            color.add(R.color.color_E91E63);
            color.add(R.color.color_673AB7);
            color.add(R.color.color_3F51B5);
            color.add(R.color.color_03A9F4);
            color.add(R.color.color_2196F3);
            color.add(R.color.color_009688);
            color.add(R.color.color_FFC107);
            color.add(R.color.color_CDDC39);
            color.add(R.color.color_4CAF50);
            color.add(R.color.color_F44336);
            color.add(R.color.color_E91E63);
            color.add(R.color.color_673AB7);
            color.add(R.color.color_3F51B5);
            color.add(R.color.color_03A9F4);
            color.add(R.color.color_2196F3);

        }
        return color;
    }
}
