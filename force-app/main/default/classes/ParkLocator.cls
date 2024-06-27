public class ParkLocator {

    public static List<string> country(String x) {
        ParkService.ParksImplPort parks = new ParkService.ParksImplPort();
        return parks.byCountry(x);
    
}
}