package osmservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import osmservice.model.Tracking;

import java.util.List;

@Repository
public interface TrackingRepository extends JpaRepository<Tracking, Long> {

    @Query(value = "SELECT u from Tracking u WHERE u.clientid = ?1")
    List<Tracking> findByClientId(int clientid);

    @Query(value = "SELECT count(*) from add_route(?1, ?2)", nativeQuery = true)
    void addRoute(@Param("cId") int clientId, @Param("tId") int trackingId);
}
