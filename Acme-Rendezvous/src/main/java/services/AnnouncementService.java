
package services;

import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.AnnouncementRepository;
import domain.Admin;
import domain.Announcement;
import domain.Rendezvous;
import domain.User;

@Service
@Transactional
public class AnnouncementService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private AnnouncementRepository			announcementRepository;
	@Autowired
	private UserService			userService;
	@Autowired
	private RendezvousService			rendezvousService;
	@Autowired
	private AdminService adminService;
	
	

	// Supporting services ----------------------------------------------------


	// Simple CRUD methods ----------------------------------------------------

	public Announcement create(int rendezvousId) {
		Announcement res = new Announcement();
		Rendezvous r = rendezvousService.findOne(rendezvousId);
		User u = userService.findByPrincipal();
		Assert.notNull(u);
		Assert.isTrue(u == r.getUser());
		res.setCreationMoment(new Date(System.currentTimeMillis()-1000));
		res.setRendezvous(r);
		return res;
	}

	public Announcement findOne(int announcementId) {
		Assert.isTrue(announcementId != 0);
		Announcement res = announcementRepository.findOne(announcementId);
		Assert.notNull(res);
		return res;
	}

	public Announcement save(Announcement announcement) {
		Assert.notNull(announcement);
		User u = userService.findByPrincipal();
		Assert.notNull(u);
		
		announcement.setCreationMoment(new Date(System.currentTimeMillis()-1000));
		Announcement res = announcementRepository.save(announcement);
		res.getRendezvous().getAnnouncements().add(res);
		return res;
	}

	public Announcement deleteByAdmin(final Announcement announcement) {
		Assert.notNull(announcement);
		Admin a = adminService.findByPrincipal();
		Assert.notNull(a);
		announcement.setinappropriate(true);
		return announcementRepository.save(announcement);

	}
	
	//Other Business Methods --------------------------------
	
	public Collection<Announcement> getAnnouncementsForUser(User user) {
		return announcementRepository.getAnnouncementsForUser(user);
	}
	
}
