package osmservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import osmservice.model.Tracking;

import java.util.List;

@Repository
public interface TrackingRepository extends JpaRepository<Tracking, Long> {

    @Query(value = "SELECT u FROM Tracking u WHERE u.clientid = ?1")
    List<Tracking> findByClientId(int clientid);

    @Query(value = "SELECT count(*) FROM add_route(?1, ?2)", nativeQuery = true)
    void addRoute(@Param("cId") int clientId, @Param("tId") int trackingId);

    @Query(value = "SELECT *, 0 AS latitude, 0 AS longitude FROM get_routes_near_point(?1, ?2)", nativeQuery = true)
    List<Tracking> getRoutesNearPoint(@Param("latitude") double latitude, @Param("longitude") double longitude);

    @Query(value = "SELECT *, 0 AS latitude, 0 AS longitude FROM get_routes_near_point_time_inteval(?1, ?2, ?3, ?4)",
            nativeQuery = true)
    List<Tracking> getRoutesNearPointTimeInterval(
            @Param("latitude") double latitude, @Param("longitude") double longitude,
            @Param("start") long startTime, @Param("end") long endTime);
}
