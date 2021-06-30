package osmservice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import osmservice.model.Tracking;
import osmservice.model.TrackingParam;
import osmservice.service.ITrackingService;

import java.util.List;

@RestController
public class Controller {

    @Autowired
    private ITrackingService trackingService;

    @GetMapping("/getAllPoints")
    public List<Tracking> getAllPoints() {
        return trackingService.findAll();
        /*
        List<Tracking> trackings = trackingService.findAll();
        model.addAttribute("trackings", trackings);
        return "getAllPoints";
         */
    }

    @GetMapping(value = "/getPointsOfClient", params = "clientid")
    public List<Tracking> getAllPointsByClientId(@RequestParam(name = "clientid") int clientId) {
        return trackingService.findByClientId(clientId);
    }

    @PostMapping(value = "/pushRouting")
    public void pushRouting(@RequestBody TrackingParam trackingParam) {
        Tracking tracking = new Tracking(trackingParam);
        trackingService.pushRouting(tracking);
    }

    @PostMapping(value = "/addRoute")
    public void addRoute(
            @RequestParam(name = "clientid") int clientId, @RequestParam(name = "trackingid") int trackingId) {
        trackingService.addRouting(clientId, trackingId);
    }

    @GetMapping(value = "/getRoutesClosePoint")
    public List<Tracking> getRoutesClosePoint(
            @RequestParam(name = "latitude") double latitude, @RequestParam("longitude") double longitude) {
        return trackingService.getRotesNearToPoint(latitude, longitude);
    }

    @GetMapping(value = "/getRoutesClosePointTimeInterval")
    public List<Tracking> getRoutesCloseToPointTimeInterval(
            @RequestParam(name = "latitude") double latitude, @RequestParam("longitude") double longitude,
            @RequestParam(name = "start") long startTime, @RequestParam(name = "end") long endTime) {
        return trackingService.getRotesNearToPointTimeInterval(latitude, longitude, startTime, endTime);
    }

    @GetMapping(value = "/getRoutesInsideArea")
    public List<Tracking> getRoutesInsideArea(
            @RequestParam(name = "latitude1") double latitude1, @RequestParam("longitude1") double longitude1,
            @RequestParam(name = "latitude2") double latitude2, @RequestParam("longitude2") double longitude2) {
        return trackingService.getRoutesInsideArea(latitude1, longitude1, latitude2, longitude2);
    }

    @GetMapping(value = "/getRoutesInsideAreaTimeInterval")
    public List<Tracking> getRoutesInsideAreaTimeInterval(
            @RequestParam(name = "latitude1") double latitude1, @RequestParam("longitude1") double longitude1,
            @RequestParam(name = "latitude2") double latitude2, @RequestParam("longitude2") double longitude2,
            @RequestParam(name = "start") long startTime, @RequestParam(name = "end") long endTime) {
        return trackingService.getRoutesInsideAreaTimeInterval(
                latitude1, longitude1, latitude2, longitude2, startTime, endTime);
    }

    @GetMapping(value = "/getRoutesClosePointOfClient")
    public List<Tracking> getRoutesClosePointOfClient(
            @RequestParam(name = "latitude") double latitude, @RequestParam("longitude") double longitude,
            @RequestParam(name = "clnt") int client) {
        return trackingService.getRotesNearToPointOfClient(latitude, longitude, client);
    }

    @GetMapping(value = "/getRoutesClosePointTimeIntervalOfClient")
    public List<Tracking> getRoutesCloseToPointTimeIntervalOfClient(
            @RequestParam(name = "latitude") double latitude, @RequestParam("longitude") double longitude,
            @RequestParam(name = "start") long startTime, @RequestParam(name = "end") long endTime,
            @RequestParam(name = "clnt") int client) {
        return trackingService.getRotesNearToPointTimeIntervalOfClient(latitude, longitude, startTime, endTime, client);
    }

    @GetMapping(value = "/getRoutesInsideAreaOfClient")
    public List<Tracking> getRoutesInsideAreaOfClient(
            @RequestParam(name = "latitude1") double latitude1, @RequestParam("longitude1") double longitude1,
            @RequestParam(name = "latitude2") double latitude2, @RequestParam("longitude2") double longitude2,
            @RequestParam(name = "clnt") int client) {
        return trackingService.getRoutesInsideAreaOfClient(latitude1, longitude1, latitude2, longitude2, client);
    }

    @GetMapping(value = "/getRoutesInsideAreaTimeIntervalOfClient")
    public List<Tracking> getRoutesInsideAreaTimeIntervalOfClient(
            @RequestParam(name = "latitude1") double latitude1, @RequestParam("longitude1") double longitude1,
            @RequestParam(name = "latitude2") double latitude2, @RequestParam("longitude2") double longitude2,
            @RequestParam(name = "start") long startTime, @RequestParam(name = "end") long endTime,
            @RequestParam(name = "clnt") int client) {
        return trackingService.getRoutesInsideAreaTimeIntervalOfClient(
                latitude1, longitude1, latitude2, longitude2, startTime, endTime, client);
    }
}
