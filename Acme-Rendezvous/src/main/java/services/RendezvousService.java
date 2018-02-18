
package services;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.RendezvousRepository;
import security.LoginService;
import security.UserAccount;
import domain.Rendezvous;
import domain.Rsvp;
import domain.User;

@Service
@Transactional
public class RendezvousService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private RendezvousRepository			rendezvousRepository;

	// Supporting services ----------------------------------------------------

	@Autowired
	private UserService						userService;
	@Autowired
	private AdminService					adminService;

	// Simple CRUD methods ----------------------------------------------------

	public Rendezvous create() {
		Rendezvous res = new Rendezvous();
		User user = userService.findByPrincipal();
		Assert.notNull(user);
		res.setUser(user);
		res.setAdultOnly(false);
		res.setFinalMode(false);
		res.setDeleted(false);
		res.setQuestions(new ArrayList<String>());
		res.setRendezvouses(new ArrayList<Rendezvous>());
		res.setRsvps(new ArrayList<Rsvp>());
		return res;
	}

	public Rendezvous findOne(int rendezvousId) {
		Assert.isTrue(rendezvousId != 0);
		Rendezvous res = rendezvousRepository.findOne(rendezvousId);
		Assert.notNull(res);
		return res;
	}
	
	public Collection<Rendezvous> findAll(){
		return rendezvousRepository.findAll();
	}

	public Rendezvous save(Rendezvous rendezvous) {
		Assert.notNull(rendezvous);
		Assert.isTrue(!rendezvous.getFinalMode() && !rendezvous.getDeleted());
		Assert.isTrue(rendezvous.getUser().equals(userService.findByPrincipal()));
		return rendezvousRepository.save(rendezvous);
	}

	public void deleteByAdmin(final Rendezvous rendezvous) {
		Assert.notNull(rendezvous);
		Assert.isTrue(rendezvous.getId() != 0);
		Assert.notNull(adminService.findByPrincipal());
		rendezvousRepository.delete(rendezvous);
	}
	
	public Rendezvous deleteByUser(final Rendezvous rendezvous){
		Assert.notNull(rendezvous);
		Assert.isTrue(rendezvous.getId() != 0);
		Assert.isTrue(rendezvous.getUser().equals(userService.findByPrincipal()));
		rendezvous.setDeleted(true);
		return rendezvousRepository.save(rendezvous);
	}
	
	//Other Business Methods --------------------------------
	
	public Collection<Rendezvous> getRSVPRendezvousesForUser(User user){
		return rendezvousRepository.getRSVPRendezvousesForUser(user);
	}
	
	public Double[] getRendezvousStats(){
		return rendezvousRepository.getRendezvousStats();
	}
	
	public Double getRatioOfUsersWhoHaveCreatedRendezvouses() {
		return rendezvousRepository.getRatioOfUsersWhoHaveCreatedRendezvouses();
	}
	
	//Average and stdev of users per rendezvous
	
	//Average and stdev of rendezvouses that are RSVPd per user
	
	public Collection<Rendezvous> getTop10RendezvousByRSVPs() {
		return rendezvousRepository.getTop10RendezvousByRSVPs();
	}
	
	public Double[] getRendezvousAnnouncementStats() {
		return rendezvousRepository.getRendezvousAnnouncementStats();
	}
	
	public Collection<Rendezvous> getRendezvousesWithNumberOfAnnouncementsOver75PerCentAvg() {
		return rendezvousRepository.getRendezvousesWithNumberOfAnnouncementsOver75PerCentAvg();
	}
	
	public Collection<Rendezvous> getRendezvousesLinkedToMoreThan10PerCentAVGNumberOfRendezvouses() {
		return rendezvousRepository.getRendezvousesLinkedToMoreThan10PerCentAVGNumberOfRendezvouses();
	}
	
	public Double[] getRendezvousQuestionStats() {
		return rendezvousRepository.getRendezvousQuestionStats();
	}
	
	//Avg and stdev of answers to questions per rendezvous
	
}
