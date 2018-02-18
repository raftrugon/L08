
package services;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;

import repositories.RendezvousRepository;
import domain.Announcement;
import domain.Comment;
import domain.Rendezvous;
import domain.Rsvp;
import domain.User;
import forms.UserRendezvousCreateForm;

@Service
@Transactional
public class RendezvousService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private RendezvousRepository	rendezvousRepository;

	// Supporting services ----------------------------------------------------

	@Autowired
	private UserService				userService;
	@Autowired
	private AdminService			adminService;
	@Autowired
	private Validator				validator;


	// Simple CRUD methods ----------------------------------------------------

	public Rendezvous create() {
		Rendezvous res = new Rendezvous();
		User user = this.userService.findByPrincipal();
		Assert.notNull(user);
		res.setUser(user);
		res.setAdultOnly(false);
		res.setFinalMode(false);
		res.setDeleted(false);
		res.setQuestions(new ArrayList<String>());
		res.setRendezvouses(new ArrayList<Rendezvous>());
		res.setAnnouncements(new ArrayList<Announcement>());
		res.setComments(new ArrayList<Comment>());
		res.setRsvps(new ArrayList<Rsvp>());
		return res;
	}

	public Rendezvous findOne(final int rendezvousId) {
		Assert.isTrue(rendezvousId != 0);
		Rendezvous res = this.rendezvousRepository.findOne(rendezvousId);
		Assert.notNull(res);
		return res;
	}

	public Collection<Rendezvous> findAll() {
		return this.rendezvousRepository.findAll();
	}

	public Rendezvous save(final Rendezvous rendezvous) {
		Assert.notNull(rendezvous);
		Assert.isTrue(rendezvous.getUser().equals(this.userService.findByPrincipal()));

		//Checkeos contra base de datos
		if (rendezvous.getId() != 0) {
			Rendezvous bd = this.findOne(rendezvous.getId());
			Assert.isTrue(!bd.getFinalMode() && !bd.getDeleted());
			Assert.isTrue(bd.getUser().equals(this.userService.findByPrincipal()));
		}

		Rendezvous saved = this.rendezvousRepository.save(rendezvous);

		//Añadir rendezvous al user si es nuevo
		if (rendezvous.getId() == 0)
			rendezvous.getUser().getRendezvouses().add(saved);

		return saved;
	}

	public void deleteByAdmin(final Rendezvous rendezvous) {
		Assert.notNull(rendezvous);
		Assert.isTrue(rendezvous.getId() != 0);
		Assert.notNull(this.adminService.findByPrincipal());
		this.rendezvousRepository.delete(rendezvous);
	}

	public Rendezvous deleteByUser(final int rendezvousId) {
		Rendezvous rendezvous = this.findOne(rendezvousId);
		Assert.notNull(rendezvous);
		Assert.isTrue(rendezvous.getUser().equals(this.userService.findByPrincipal()));
		Assert.isTrue(!rendezvous.getFinalMode());
		rendezvous.setDeleted(true);
		return this.rendezvousRepository.save(rendezvous);
	}

	//Other Business Methods --------------------------------

	public Collection<Rendezvous> getRSVPRendezvousesForUser(final User user) {
		return this.rendezvousRepository.getRSVPRendezvousesForUser(user);
	}

	public Double[] getRendezvousStats() {
		return this.rendezvousRepository.getRendezvousStats();
	}

	public Double getRatioOfUsersWhoHaveCreatedRendezvouses() {
		return this.rendezvousRepository.getRatioOfUsersWhoHaveCreatedRendezvouses();
	}

	//Average and stdev of users per rendezvous

	//Average and stdev of rendezvouses that are RSVPd per user

	public Collection<Rendezvous> getTop10RendezvousByRSVPs() {
		return this.rendezvousRepository.getTop10RendezvousByRSVPs();
	}

	public Double[] getRendezvousAnnouncementStats() {
		return this.rendezvousRepository.getRendezvousAnnouncementStats();
	}

	public Collection<Rendezvous> getRendezvousesWithNumberOfAnnouncementsOver75PerCentAvg() {
		return this.rendezvousRepository.getRendezvousesWithNumberOfAnnouncementsOver75PerCentAvg();
	}

	public Collection<Rendezvous> getRendezvousesLinkedToMoreThan10PerCentAVGNumberOfRendezvouses() {
		return this.rendezvousRepository.getRendezvousesLinkedToMoreThan10PerCentAVGNumberOfRendezvouses();
	}

	public Double[] getRendezvousQuestionStats() {
		return this.rendezvousRepository.getRendezvousQuestionStats();
	}

	public Rendezvous reconstruct(final UserRendezvousCreateForm rendezvousForm, final BindingResult binding) {

		Rendezvous res;

		//Viendo si es create o edit
		if (rendezvousForm.getRendezvousId() == 0)
			res = this.create();
		else
			res = this.findOne(rendezvousForm.getRendezvousId());

		//OPCION: Checkear aqui bd, setear un objeto nuevo y validarlo. Si no tiene errores
		//setear el objeto con findOne. (no valdría para nada el save)

		res.setName(rendezvousForm.getName());
		res.setDescription(rendezvousForm.getDescription());
		res.setOrganisationMoment(rendezvousForm.getOrganisationMoment());
		res.setPicture(rendezvousForm.getPicture());
		res.setLatitude(rendezvousForm.getLatitude());
		res.setLongitude(rendezvousForm.getLongitude());
		res.setFinalMode(rendezvousForm.isFinalMode());
		res.setAdultOnly(rendezvousForm.isAdultOnly());

		this.validator.validate(res, binding);

		return res;
	}

}
