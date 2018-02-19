
package services;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.RsvpRepository;
import domain.Rendezvous;
import domain.Rsvp;
import domain.User;

@Service
@Transactional
public class RsvpService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private RsvpRepository			rsvpRepository;
	@Autowired
	private RendezvousService		rendezvousService;
	@Autowired
	private UserService				userService;

	// Supporting services ----------------------------------------------------


	// Simple CRUD methods ----------------------------------------------------

	public Rsvp create(int rendezvousId) {
		Rsvp res = new Rsvp();
		User u = userService.findByPrincipal();
		Assert.notNull(u);
		Rendezvous r = rendezvousService.findOne(rendezvousId);
		Assert.notNull(r);
		Assert.isTrue(!userService.isRsvpd(rendezvousId));
		res.setUser(u);
		res.setRendezvous(r);
		Map<String,String> questions = new HashMap<String,String>();
		for(String question: r.getQuestions()){
			questions.put(question, "");
		}
		res.setQuestionsAndAnswers(questions);
		return res;
	}

	public Rsvp findOne(int rsvpId) {
		Assert.isTrue(rsvpId != 0);
		Rsvp res = rsvpRepository.findOne(rsvpId);
		Assert.notNull(res);
		return res;
	}

	public Rsvp save(Rsvp rsvp) {
		Assert.isTrue(rsvp.getUser().equals(userService.findByPrincipal()));
		Assert.isTrue(!userService.isRsvpd(rsvp.getId()));
		return rsvpRepository.save(rsvp);
	}

	public void delete(final Rsvp rsvp) {
		rsvpRepository.delete(rsvp);

	}
	
	//Other Business Methods --------------------------------
	
	
}
