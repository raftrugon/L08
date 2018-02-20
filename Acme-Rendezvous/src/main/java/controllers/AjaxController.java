package controllers;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import domain.Announcement;
import domain.Rendezvous;
import domain.Rsvp;

import services.AnnouncementService;
import services.RendezvousService;
import services.RsvpService;

@RestController
@RequestMapping("/ajax")
public class AjaxController {

	@Autowired
	private RsvpService 				rsvpService;
	@Autowired
	private AnnouncementService 				announcementService;
	@Autowired
	private RendezvousService			rendezvousService;
	 
	
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
	
	@RequestMapping(value = "user/announcement/save", method = RequestMethod.POST)
	public String save(@Valid final Announcement announcement, final BindingResult binding) {
		if (binding.hasErrors())
			return "1";
		else
			try {
				announcementService.save(announcement);
				return "2";
			} catch (Throwable oops) {
				return "3";
			}
	}
	
	@RequestMapping(value="rsvp/create", method = RequestMethod.GET)
	public ModelAndView createRSVP(@RequestParam(required=true) final int rendezvousId){
		try{
			Rsvp rsvp = rsvpService.create(rendezvousId);
			ModelAndView result = new ModelAndView("rsvp/edit");
			result.addObject("rsvp",rsvp);
			return result;
		}catch(Throwable oops){
			return new ModelAndView("redirect: /rendezvous/display.do?rendezvousId="+rendezvousId);
		}
	}
	
	@RequestMapping(value="rsvp/save", method = RequestMethod.POST)
	public ModelAndView saveRSVP(@Valid final Rsvp rsvp, final BindingResult binding){
		try{
			rsvpService.save(rsvp);
		}catch(Throwable oops){}
		
		return new ModelAndView("redirect: /rendezvous/display.do?rendezvousId="+rsvp.getRendezvous().getId());
	}
}
