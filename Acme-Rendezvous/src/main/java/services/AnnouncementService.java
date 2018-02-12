
package services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.AnnouncementRepository;
import domain.Announcement;

@Service
@Transactional
public class AnnouncementService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private AnnouncementRepository			announcementRepository;

	// Supporting services ----------------------------------------------------


	// Simple CRUD methods ----------------------------------------------------

	public Announcement create() {
		Announcement res = new Announcement();

		return res;
	}

	public Announcement findOne(int announcementId) {
		Assert.isTrue(announcementId != 0);
		Announcement res = announcementRepository.findOne(announcementId);
		Assert.notNull(res);
		return res;
	}

	public Announcement save(Announcement announcement) {
		return announcementRepository.save(announcement);
	}

	public void delete(final Announcement announcement) {
		announcementRepository.delete(announcement);

	}
	
	//Other Business Methods --------------------------------
	
	
}
