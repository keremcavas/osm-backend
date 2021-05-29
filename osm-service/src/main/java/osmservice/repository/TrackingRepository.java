package osmservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import osmservice.model.Tracking;

import java.util.List;

@Repository
public interface TrackingRepository extends JpaRepository<Tracking, Long> {

    @Query(value = "SELECT u from Tracking u WHERE u.clientid = ?1")
    List<Tracking> findByClientId(int clientid);
}
