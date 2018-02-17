
package controllers.User;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.RendezvousService;
import services.UserService;
import controllers.AbstractController;
import domain.Rendezvous;

@Controller
@RequestMapping("/user/rendezvous")
public class UserRendezvousController extends AbstractController {

	@Autowired
	private RendezvousService	rendezvousService;
	@Autowired
	private UserService	userService;


	//Constructor
	public UserRendezvousController() {
		super();
	}

	@RequestMapping("/created-list")
	public ModelAndView listCreated() {
		ModelAndView result;
		final List<Rendezvous> rendezvouss = new ArrayList<Rendezvous>(userService.findByPrincipal().getRendezvouses());
		result = new ModelAndView("rendezvous/list");
		result.addObject("rendezvouss", rendezvouss);
		result.addObject("requestUri", "user/rendezvous/created-list.do");
		return result;
	}

	@RequestMapping("/rsvp-list")
	public ModelAndView listRSVP() {
		ModelAndView result;
		final List<Rendezvous> rendezvouss = new ArrayList<Rendezvous>(rendezvousService.getRSVPRendezvousesForUser(userService.findByPrincipal()));
		result = new ModelAndView("rendezvous/list");
		result.addObject("rendezvouss", rendezvouss);
		result.addObject("requestUri", "user/rendezvous/rsvp-list.do");
		return result;
	}
	
	@RequestMapping("/questions-list")
	public ModelAndView listQuestions(@RequestParam int rendezvousId) {
		ModelAndView result;
		
		Rendezvous rendezvous = rendezvousService.findOne(rendezvousId);
		
		result = new ModelAndView("rendezvous/listQuestions");
		result.addObject("questions", rendezvous.getQuestions());
		result.addObject("rendezvous", rendezvous);
		result.addObject("requestUri", "user/rendezvous/questions-list.do?rendezvousId="+rendezvousId);
		return result;
	}
	
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView result;
		try {
			Rendezvous rendezvous = rendezvousService.create();
			result = newEditModelAndView(rendezvous);
		} catch (Throwable oops) {
			result = new ModelAndView("redirect:list.do");
		}
		return result;
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam(required = true) final int rendezvousId) {
		Rendezvous rendezvous = rendezvousService.findOne(rendezvousId);
		if (rendezvous.getUser().equals(userService.findByPrincipal()))
			return newEditModelAndView(rendezvous);
		else
			return new ModelAndView("redirect:list.do");
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid final Rendezvous rendezvous, final BindingResult binding) {
		ModelAndView result;
		if (binding.hasErrors())
			result = newEditModelAndView(rendezvous);
		else
			try {
				rendezvousService.save(rendezvous);
				result = new ModelAndView("redirect:list.do");
			} catch (Throwable oops) {
				result = newEditModelAndView(rendezvous);
				result.addObject("message", "rendezvous.commitError");
			}
		return result;
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST, params = "delete")
	public ModelAndView delete(@Valid final Rendezvous rendezvous, final BindingResult binding) {
		ModelAndView result;
		if (binding.hasErrors())
			result = newEditModelAndView(rendezvous);
		else
			try {
				rendezvousService.deleteByUser(rendezvous);
				result = new ModelAndView("redirect:list.do");
			} catch (Throwable oops) {
				result = newEditModelAndView(rendezvous);
				result.addObject("message", "rendezvous.commitError");
			}
		return result;
	}
	protected ModelAndView newEditModelAndView(final Rendezvous rendezvous) {
		ModelAndView result;
		result = new ModelAndView("rendezvous/edit");
		result.addObject("rendezvous", rendezvous);
		result.addObject("actionUri", "user/rendezvous/save.do");
		return result;
	}
}