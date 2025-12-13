package vn.dao;

import vn.model.Banner;
import vn.model.Product;

import java.util.*;

public class BannerDao {
    static Map<Integer, Banner> data=new HashMap<Integer,Banner>();
    static {
        data.put(1,new Banner(1,"Gumdam Red Lighting TechX","https://i.redd.it/9skpdpurchu41.jpg","","",new Date(2025,1,1),new Date(2026,1,1),1,1,new Date(2024,10,2),new Date(2024,12,1)));
        data.put(2,new Banner(2,"Fly Car TechX","https://welovecar.vn/wp-content/uploads/2020/11/wlc-aircar.jpg","","",new Date(2025,1,1),new Date(2026,1,1),2,1,new Date(2024,10,2),new Date(2024,12,1)));
        data.put(3,new Banner(3,"Cyber Dog TechX","https://media.vov.vn/sites/default/files/styles/large/public/2023-08/1_66.jpg","","",new Date(2025,1,1),new Date(2026,1,1),3,1,new Date(2024,10,2),new Date(2024,12,1)));
        data.put(4,new Banner(4,"Siêu Sayda","https://cdn.renderhub.com/damariscarson01/son-goku-dragon-ball-z/son-goku-dragon-ball-z-02.jpg","","",new Date(2025,1,1),new Date(2026,1,1),4,1,new Date(2024,10,2),new Date(2024,12,1)));
        //data.put(5,new Banner(4,"","","","",new Date(2025,1,1),new Date(2026,1,1),5,1,new Date(2024,10,2),new Date(2024,12,1)));

    }
    public static List<Banner> banners = new ArrayList<>(data.values());
}
