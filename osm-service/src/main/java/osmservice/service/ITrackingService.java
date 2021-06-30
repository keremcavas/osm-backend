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
    List<Tracking> getRoutesInsideArea(double latitude1, double longitude1, double latitude2, double longitude2);
    List<Tracking> getRoutesInsideAreaTimeInterval(double latitude1, double longitude1,
                                                   double latitude2, double longitude2,
                                                   long startTime, long endTime);
    List<Tracking> getRotesNearToPointOfClient(double latitude, double langitude, int client);
    List<Tracking> getRotesNearToPointTimeIntervalOfClient(double latitude, double langitude, long startTime, long endTime, int client);
    List<Tracking> getRoutesInsideAreaOfClient(double latitude1, double longitude1, double latitude2, double longitude2, int client);
    List<Tracking> getRoutesInsideAreaTimeIntervalOfClient(double latitude1, double longitude1,
                                                   double latitude2, double longitude2,
                                                   long startTime, long endTime,
                                                   int client);

}
