package osmservice.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import osmservice.model.Tracking;
import osmservice.repository.TrackingRepository;

import java.util.List;

@Service
public class TrackingService implements ITrackingService {

    @Autowired
    private TrackingRepository trackingRepository;

    @Override
    public List<Tracking> findAll() {
        return trackingRepository.findAll();
    }

    @Override
    public List<Tracking> findByClientId(int clientId) {
        return trackingRepository.findByClientId(clientId);
    }

    @Override
    public void pushRouting(Tracking tracking) {
        trackingRepository.save(tracking);
    }

    @Override
    public void addRouting(int clientId, int trackingId) {
        trackingRepository.addRoute(clientId, trackingId);
    }

    @Override
    public List<Tracking> getRotesNearToPoint(double latitude, double langitude) {
        return trackingRepository.getRoutesNearPoint(latitude, langitude);
    }

    @Override
    public List<Tracking> getRotesNearToPointTimeInterval(
            double latitude, double langitude, long startTime, long endTime) {
        return trackingRepository.getRoutesNearPointTimeInterval(latitude, langitude, startTime, endTime);
    }

    @Override
    public List<Tracking> getRoutesInsideArea(
            double latitude1, double longitude1, double latitude2, double longitude2) {
        return trackingRepository.getRoutesInsideArea(latitude1, longitude1, latitude2, longitude2);
    }

    @Override
    public List<Tracking> getRoutesInsideAreaTimeInterval(
            double latitude1, double longitude1, double latitude2, double longitude2, long startTime, long endTime) {
        return trackingRepository.getRoutesInsideAreaTimeInterval(
                latitude1, longitude1, latitude2, longitude2, startTime, endTime);
    }

    @Override
    public List<Tracking> getRotesNearToPointOfClient(double latitude, double langitude, int client) {
        return trackingRepository.getRoutesNearPointOfClient(latitude, langitude, client);
    }

    @Override
    public List<Tracking> getRotesNearToPointTimeIntervalOfClient(double latitude, double langitude, long startTime, long endTime, int client) {
        return trackingRepository.getRoutesNearPointTimeIntervalOfClient(latitude, langitude, startTime, endTime, client);
    }

    @Override
    public List<Tracking> getRoutesInsideAreaOfClient(double latitude1, double longitude1, double latitude2, double longitude2, int client) {
        return trackingRepository.getRoutesInsideAreaOfClient(latitude1, longitude1, latitude2, longitude2, client);
    }

    @Override
    public List<Tracking> getRoutesInsideAreaTimeIntervalOfClient(double latitude1, double longitude1, double latitude2, double longitude2, long startTime, long endTime, int client) {
        return trackingRepository.getRoutesInsideAreaTimeIntervalOfClient(latitude1, longitude1, latitude2, longitude2, startTime, endTime, client);
    }
}
