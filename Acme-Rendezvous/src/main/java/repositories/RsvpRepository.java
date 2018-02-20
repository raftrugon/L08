
package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Rsvp;

@Repository
public interface RsvpRepository extends JpaRepository<Rsvp, Integer> {
	
	@Query("select r.rendezvous from Rsvp r where r.user = ?1")
	Collection<String> getPendingQuestions(Rsvp rsvp);

}