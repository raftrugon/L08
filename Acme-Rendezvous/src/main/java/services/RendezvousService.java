
package services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.RendezvousRepository;
import domain.Rendezvous;

@Service
@Transactional
public class RendezvousService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private RendezvousRepository			rendezvousRepository;

	// Supporting services ----------------------------------------------------


	// Simple CRUD methods ----------------------------------------------------

	public Rendezvous create() {
		Rendezvous res = new Rendezvous();

		return res;
	}

	public Rendezvous findOne(int rendezvousId) {
		Assert.isTrue(rendezvousId != 0);
		Rendezvous res = rendezvousRepository.findOne(rendezvousId);
		Assert.notNull(res);
		return res;
	}

	public Rendezvous save(Rendezvous rendezvous) {
		return rendezvousRepository.save(rendezvous);
	}

	public void delete(final Rendezvous rendezvous) {
		rendezvousRepository.delete(rendezvous);

	}
	
	//Other Business Methods --------------------------------
	
	
}
