
package controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.RendezvousService;
import services.UserService;
import domain.Rendezvous;

@Controller
@RequestMapping("/rendezvous")
public class RendezvousController extends AbstractController {

	@Autowired
	private RendezvousService	rendezvousService;
	@Autowired
	private UserService			userService;


	//Constructor
	public RendezvousController() {
		super();
	}
	
	@RequestMapping("/display")
	public ModelAndView display(@RequestParam(required=true) final int rendezvousId){
		ModelAndView result;
		try{
			Rendezvous rendezvous = rendezvousService.findOne(rendezvousId);
			result = new ModelAndView("rendezvous/display");
			result.addObject("rendezvous",rendezvous);
		}catch(Throwable oops){
			result = new ModelAndView("rendezvous/list");
			result.addObject("message","master.page.errors.entityNotFound");
		}
		return result;
	}
	@RequestMapping("/list")
	public ModelAndView list() {
		ModelAndView result;
		final List<Rendezvous> rendezvouss = new ArrayList<Rendezvous>(rendezvousService.findAll());
		result = new ModelAndView("rendezvous/list");
		result.addObject("rendezvouss", rendezvouss);
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