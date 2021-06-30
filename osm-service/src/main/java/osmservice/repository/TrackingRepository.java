package osmservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import osmservice.model.Tracking;

import java.util.List;

@Repository
public interface TrackingRepository extends JpaRepository<Tracking, Long> {

    @Query(value = "SELECT DISTINCT ON(trackingid) * FROM users_locations WHERE clientid = ?1" , nativeQuery = true)
    List<Tracking> findByClientId(int clientid);

    @Query(value = "SELECT count(*) FROM add_route(?1, ?2)", nativeQuery = true)
    void addRoute(@Param("cId") int clientId, @Param("tId") int trackingId);

    @Query(value = "SELECT *, 0 AS latitude, 0 AS longitude FROM get_routes_near_point(?1, ?2)", nativeQuery = true)
    List<Tracking> getRoutesNearPoint(@Param("latitude") double latitude, @Param("longitude") double longitude);

    @Query(value = "SELECT *, 0 AS latitude, 0 AS longitude FROM get_routes_near_point_time_inteval(?1, ?2, ?3, ?4)",
            nativeQuery = true)
    List<Tracking> getRoutesNearPointTimeInterval(
            @Param("latitude") double latitude, @Param("longitude") double longitude,
            @Param("start") long startTime, @Param("end") long endTime
    );

    @Query(value = "SELECT *, 0 AS latitude, 0 AS longitude FROM get_routes_inside_area(?1, ?2, ?3, ?4)",
            nativeQuery = true)
    List<Tracking> getRoutesInsideArea(
            @Param("latitude1") double latitude1, @Param("longitude1") double longitude1,
            @Param("latitude2") double latitude2, @Param("longitude2") double longitude2
    );

    @Query(value = "SELECT *, 0 AS latitude, 0 AS longitude " +
            "FROM get_routes_inside_area_time_interval(?1, ?2, ?3, ?4, ?5, ?6)",
            nativeQuery = true)
    List<Tracking> getRoutesInsideAreaTimeInterval(
            @Param("latitude1") double latitude1, @Param("longitude1") double longitude1,
            @Param("latitude2") double latitude2, @Param("longitude2") double longitude2,
            @Param("start") long startTime, @Param("end") long endTime
    );

    @Query(value = "SELECT *, 0 AS latitude, 0 AS longitude FROM get_routes_near_point_of_client(?1, ?2, ?3)", nativeQuery = true)
    List<Tracking> getRoutesNearPointOfClient(@Param("latitude") double latitude, @Param("longitude") double longitude,
                                              @Param("clnt") int client);

    @Query(value = "SELECT *, 0 AS latitude, 0 AS longitude FROM get_routes_near_point_time_inteval_of_client(?1, ?2, ?3, ?4, ?5)",
            nativeQuery = true)
    List<Tracking> getRoutesNearPointTimeIntervalOfClient(
            @Param("latitude") double latitude, @Param("longitude") double longitude,
            @Param("start") long startTime, @Param("end") long endTime,
            @Param("clnt") int client
    );

    @Query(value = "SELECT *, 0 AS latitude, 0 AS longitude FROM get_routes_inside_area_of_client(?1, ?2, ?3, ?4, ?5)",
            nativeQuery = true)
    List<Tracking> getRoutesInsideAreaOfClient(
            @Param("latitude1") double latitude1, @Param("longitude1") double longitude1,
            @Param("latitude2") double latitude2, @Param("longitude2") double longitude2,
            @Param("clnt") int client
    );

    @Query(value = "SELECT *, 0 AS latitude, 0 AS longitude " +
            "FROM get_routes_inside_area_time_interval_of_client(?1, ?2, ?3, ?4, ?5, ?6, ?7)",
            nativeQuery = true)
    List<Tracking> getRoutesInsideAreaTimeIntervalOfClient(
            @Param("latitude1") double latitude1, @Param("longitude1") double longitude1,
            @Param("latitude2") double latitude2, @Param("longitude2") double longitude2,
            @Param("start") long startTime, @Param("end") long endTime,
            @Param("clnt") int client
    );
}
