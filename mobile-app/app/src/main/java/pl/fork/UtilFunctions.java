package pl.fork;

/**
 * Created by Artur on 2015-11-26.
 */
public class UtilFunctions {
    public static String getImageURI(int id){
        String url = Config.baseURL + "image/" + id;
        return url;
    }

}
