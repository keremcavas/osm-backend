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
    public List<Tracking> getRotesNearToPointTimeInterval(double latitude, double langitude, long startTime, long endTime) {
        return trackingRepository.getRoutesNearPointTimeInterval(latitude, langitude, startTime, endTime);
    }
}
