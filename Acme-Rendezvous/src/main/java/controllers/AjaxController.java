package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import domain.Announcement;

import services.AnnouncementService;
import services.RsvpService;

@RestController
@RequestMapping("/ajax")
public class AjaxController {

	@Autowired
	private RsvpService 				rsvpService;
	@Autowired
	private AnnouncementService 				announcementService;
	 
	
	@RequestMapping(value = "/qa", method = RequestMethod.GET)
	public ModelAndView qa(@RequestParam(required=true)final int rsvpId) {
		ModelAndView result = new ModelAndView("rsvp/qa");
		result.addObject("qa",rsvpService.findOne(rsvpId).getQuestionsAndAnswers());
		return result;
	}
	
	@RequestMapping(value="admin/announcement/delete", method=RequestMethod.POST)
	public int deleteAnnouncement(@RequestParam(required = true) Announcement announcement) {
		try{
			announcementService.delete(announcement);
			return 1;
		} catch(Throwable oops) {
			return 0;
		}
	}
}
