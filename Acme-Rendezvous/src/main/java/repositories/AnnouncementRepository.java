
package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Announcement;
import domain.Rendezvous;
import domain.User;

@Repository
public interface AnnouncementRepository extends JpaRepository<Announcement, Integer> {

	@Query("select r.rendezvous.announcements from Rsvp r where r.user = ?1 order by creationMoment DESC")
	Collection<Announcement> getAnnouncementsForUser(User user);

}