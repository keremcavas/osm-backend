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
    public void addRoute(@RequestParam(name = "clientid") int clientId, @RequestParam(name = "trackingid") int trackingId) {
        trackingService.addRouting(clientId, trackingId);
    }
}
