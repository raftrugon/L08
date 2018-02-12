
package services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.RsvpRepository;
import domain.Rsvp;

@Service
@Transactional
public class RsvpService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private RsvpRepository			rsvpRepository;

	// Supporting services ----------------------------------------------------


	// Simple CRUD methods ----------------------------------------------------

	public Rsvp create() {
		Rsvp res = new Rsvp();

		return res;
	}

	public Rsvp findOne(int rsvpId) {
		Assert.isTrue(rsvpId != 0);
		Rsvp res = rsvpRepository.findOne(rsvpId);
		Assert.notNull(res);
		return res;
	}

	public Rsvp save(Rsvp rsvp) {
		return rsvpRepository.save(rsvp);
	}

	public void delete(final Rsvp rsvp) {
		rsvpRepository.delete(rsvp);

	}
	
	//Other Business Methods --------------------------------
	
	
}
