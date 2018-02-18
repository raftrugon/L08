
package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Rendezvous;
import domain.User;

@Repository
public interface RendezvousRepository extends JpaRepository<Rendezvous, Integer> {
	
	@Query("select r.rendezvous from Rsvp r where r.user = ?1")
	Collection<Rendezvous> getRSVPRendezvousesForUser(User user);
	
	@Query("select coalesce(avg(u.rendezvouses.size),0), coalesce(stddev(u.rendezvouses.size),0) from User u")
	Double[] getRendezvousStats();
	
	@Query("select coalesce((count(u)*1.0)/(select count(x) from User x where x.rendezvouses is empty),0) from User u" +
			" where u.rendezvouses is not empty")
	Double getRatioOfUsersWhoHaveCreatedRendezvouses();
	
	//Average and stdev of users per rendezvous
	
	//Average and stdev of rendezvouses that are RSVPd per user
	
	
	//Paginar query??
	@Query(value="select r from Rendezvous order by r.rsvps.size DESC limit 10", nativeQuery = true)
	Collection<Rendezvous> getTop10RendezvousByRSVPs();
	
	
	
	@Query("select coalesce(avg(r.announcements.size),0), coalesce(stddev(r.announcements.size),0) from Rendezvous r")
	Double[] getRendezvousAnnouncementStats();
	
	@Query("select r from Rendezvous r where (select count(a) from r.announcements a) >= ( select avg(r2.announcements.size)" +
			" from Rendezvous r2)*0.75 order by r.announcements.size DESC")
	Collection<Rendezvous> getRendezvousesWithNumberOfAnnouncementsOver75PerCentAvg();
	
	@Query("select r from Rendezvous r where (select count(a) from r.rendezvouses a) >= ( select avg(r2.rendezvouses.size)" +
			" from Rendezvous r2)*1.1 order by r.announcements.size DESC")
	Collection<Rendezvous> getRendezvousesLinkedToMoreThan10PerCentAVGNumberOfRendezvouses();
	
	
	
	@Query("select coalesce(avg(r.questions.size),0), coalesce(stddev(r.questions.size),0) from Rendezvous r")
	Double[] getRendezvousQuestionStats();
	
	//Avg and stdev of answers to questions per rendezvous
}