package osmservice.service;

import osmservice.model.Tracking;

import java.util.List;

public interface ITrackingService {
    List<Tracking> findAll();
    List<Tracking> findByClientId(int clientId);
    void pushRouting(Tracking trackings);
    void addRouting(int clientId, int trackingId);
    List<Tracking> getRotesNearToPoint(double latitude, double langitude);
    List<Tracking> getRotesNearToPointTimeInterval(double latitude, double langitude, long startTime, long endTime);
}
