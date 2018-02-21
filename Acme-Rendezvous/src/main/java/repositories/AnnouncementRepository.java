
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
	
	@Query("select a from Announcement a order by creationMoment DESC")
	Collection<Announcement> findAllOrdered();

	@Query("select r.rendezvous.announcements from Rsvp r where r.user = ?1 order by creationMoment DESC")
	Collection<Announcement> getRSVPAnnouncementsForUser(User user);
	
	@Query("select r.announcements from Rendezvous r where r.user = ?1 order by creationMoment DESC")
	Collection<Announcement> getMyAnnouncements(User user);


}