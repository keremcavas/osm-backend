package osmservice.model;

import javax.persistence.*;

@Entity
@Table(name = "users_locations")
public class Tracking {

    @GeneratedValue(strategy = GenerationType.AUTO)

    private int clientid;
    private int trackingid;
    private double latitude;
    private double longitude;

    @Id
    private long time;

    public  Tracking() {
    }

    public Tracking(int clientid, int trackingid, double latitude, double longitude, long time) {
        this.clientid = clientid;
        this.trackingid = trackingid;
        this.latitude = latitude;
        this.longitude = longitude;
        this.time = time;
    }

    public Tracking(TrackingParam param) {
        this.clientid = param.getClientid();
        this.latitude = param.getLatitude();
        this.trackingid = param.getTrackingid();
        this.time = param.getTime();
        this.longitude = param.getLongitude();
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
