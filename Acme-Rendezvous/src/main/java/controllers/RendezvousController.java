
package controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import services.AnnouncementService;
import services.RendezvousService;
import services.UserService;
import utilities.internal.SchemaPrinter;
import domain.Announcement;
import domain.Rendezvous;

@Controller
@RequestMapping("/rendezvous")
public class RendezvousController extends AbstractController {

	@Autowired
	private RendezvousService	rendezvousService;
	@Autowired
	private UserService			userService;
	@Autowired
	private AnnouncementService			announcementService;


	//Constructor
	public RendezvousController() {
		super();
	}
	
	@RequestMapping("/display")
	public ModelAndView display(@RequestParam(required=true) final int rendezvousId, RedirectAttributes redir){
		ModelAndView result;
		Boolean rsvpd = false;
		Announcement newAnnouncement = null;
		try{
			rsvpd = userService.isRsvpd(rendezvousId);
			newAnnouncement = announcementService.create(rendezvousId);
		}catch(Throwable oops){}
		try{
			Rendezvous rendezvous = rendezvousService.findOne(rendezvousId);
			result = new ModelAndView("rendezvous/display");
			result.addObject("rendezvous",rendezvous);
			result.addObject("rsvpd",rsvpd);
			if(newAnnouncement != null)
				result.addObject("announcement",newAnnouncement);
		}catch(Throwable oops){
			result = new ModelAndView("redirect: list.do");
			redir.addFlashAttribute("message","master.page.errors.entityNotFound");
		}
		return result;
	}
	@RequestMapping("/list")
	public ModelAndView list() {
		ModelAndView result;
		final List<Rendezvous> rendezvouss = new ArrayList<Rendezvous>(rendezvousService.findAll());
		result = new ModelAndView("rendezvous/list");
		result.addObject("rendezvouss", rendezvouss);
		try{
			result.addObject("rsvpdRendezvouses", rendezvousService.getRSVPRendezvousesForUser(userService.findByPrincipal()));
		} catch (Throwable oops) {}
		result.addObject("requestUri", "rendezvous/list.do");
		return result;
	}
	
	@RequestMapping("/{userId}/list")
	public ModelAndView listRSVP(@PathVariable int userId) {
		ModelAndView result;
		final List<Rendezvous> rendezvouss = new ArrayList<Rendezvous>(rendezvousService.getRSVPRendezvousesForUser(userService.findOne(userId)));
		result = new ModelAndView("rendezvous/list");
		result.addObject("rendezvouss", rendezvouss);
		result.addObject("requestUri", "rendezvous/{userId}/list.do");
		return result;
	}
	
}