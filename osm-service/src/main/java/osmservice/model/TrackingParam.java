package osmservice.model;

public class TrackingParam {

    private int clientid;
    private int trackingid;
    private double latitude;
    private double longitude;
    private long time;

    public TrackingParam(int clientid, int trackingid, double latitude, double longitude, long time) {
        this.clientid = clientid;
        this.trackingid = trackingid;
        this.latitude = latitude;
        this.longitude = longitude;
        this.time = time;
    }

    public TrackingParam() {
    }

    public int getClientid() {
        return clientid;
    }

    public void setClientid(int clientid) {
        this.clientid = clientid;
    }

    public int getTrackingid() {
        return trackingid;
    }

    public void setTrackingid(int trackingid) {
        this.trackingid = trackingid;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public long getTime() {
        return time;
    }

    public void setTime(long time) {
        this.time = time;
    }
}
