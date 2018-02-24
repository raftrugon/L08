
package controllers.User;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.RendezvousService;
import services.RsvpService;
import services.UserService;
import controllers.AbstractController;
import domain.Rendezvous;
import domain.Rsvp;
import forms.UserQuestionsRendezvousCreateForm;
import forms.UserRendezvousCreateForm;

@Controller
@RequestMapping("/user/rendezvous")
public class UserRendezvousController extends AbstractController {

	@Autowired
	private RendezvousService	rendezvousService;
	@Autowired
	private UserService			userService;
	@Autowired
	private RsvpService			rsvpService;


	//Constructor
	public UserRendezvousController() {
		super();
	}

	@RequestMapping("/created-list")
	public ModelAndView listCreated() {
		ModelAndView result;
		final List<Rendezvous> rendezvouss = new ArrayList<Rendezvous>(this.userService.findByPrincipal().getRendezvouses());
		result = new ModelAndView("rendezvous/list");
		result.addObject("rendezvouss", rendezvouss);
		result.addObject("requestUri", "user/rendezvous/created-list.do");
		return result;
	}

	@RequestMapping("/rsvp-list")
	public ModelAndView listRSVP() {
		ModelAndView result;
		final List<Rendezvous> rendezvouss = new ArrayList<Rendezvous>(this.rendezvousService.getRSVPRendezvousesForUser(this.userService.findByPrincipal()));
		result = new ModelAndView("rendezvous/list");
		result.addObject("rendezvouss", rendezvouss);
		result.addObject("requestUri", "user/rendezvous/rsvp-list.do");
		return result;
	}

	@RequestMapping("/questions-list")
	public ModelAndView listQuestions(@RequestParam final int rendezvousId) {
		ModelAndView result;

		Rendezvous rendezvous = this.rendezvousService.findOne(rendezvousId);

		result = new ModelAndView("rendezvous/listQuestions");
		result.addObject("questions", rendezvous.getQuestions());
		result.addObject("rendezvous", rendezvous);
		result.addObject("requestUri", "user/rendezvous/questions-list.do?rendezvousId=" + rendezvousId);
		return result;
	}

	@RequestMapping(value = "/answer", method = RequestMethod.POST)
	public ModelAndView answer(@RequestParam final String question, @RequestParam final String rsvpId,
		@RequestParam final String answer) {

		ModelAndView result;

		try{
			int rsvpIdInt = Integer.parseInt(rsvpId);
			Rsvp rsvp = this.rsvpService.findOne(rsvpIdInt);
			Assert.notNull(rsvp);
			Assert.isTrue(rsvp.getUser().equals(this.userService.findByPrincipal()));

			rsvp.getQuestionsAndAnswers().put(question, answer);
			this.rsvpService.save(rsvp);

			result = new ModelAndView("redirect:/rendezvous/display.do?rendezvousId="+rsvp.getRendezvous().getId());
		}
		catch (Throwable oops) {
			result = new ModelAndView("redirect:/rendezvous/list.do");
			result.addObject("message", "rendezvous.commitError");
		}

		return result;
	}

	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public ModelAndView create() {
		ModelAndView result;
		try {
			//UserRendezvousCreateForm rendezvous = new UserRendezvousCreateForm();
			result = this.newEditModelAndView(rendezvousService.create());
		} catch (Throwable oops) {
			result = new ModelAndView("redirect:list.do");
		}
		return result;
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam(required = true) final int rendezvousId) {
		ModelAndView result;
		try {
			Rendezvous rendezvous = this.rendezvousService.findOne(rendezvousId);
			//UserRendezvousCreateForm rendezvousForm = new UserRendezvousCreateForm(rendezvous);
			Assert.isTrue(rendezvous.getUser().equals(this.userService.findByPrincipal()));
			result = this.newEditModelAndView(rendezvous);
		} catch (Throwable oops) {
			result = new ModelAndView("redirect:list.do");
		}
		return result;
	}
	
	@RequestMapping(value = "/editQuestions", method = RequestMethod.GET)
	public ModelAndView editQuestions(@RequestParam(required = true) final Integer rendezvousId) {
		ModelAndView result;

		try {
			Rendezvous rendezvous = this.rendezvousService.findOne(rendezvousId);
			UserQuestionsRendezvousCreateForm questionsRendezvousForm = new UserQuestionsRendezvousCreateForm(rendezvous);
			Assert.isTrue(rendezvous.getUser().equals(this.userService.findByPrincipal()));
			result = new ModelAndView("rendezvous/editQuestions");
			result.addObject("rendezvousId", rendezvousId);
			result.addObject("rendezvous", questionsRendezvousForm);
			result.addObject("actionUri", "user/rendezvous/saveQuestions.do");
			return result;
		} catch (Throwable oops) {
			result = new ModelAndView("redirect:display.do?rendezvousId="+rendezvousId);
		}
		return result;
	}
	
	@RequestMapping(value = "/save", method = RequestMethod.POST, params = "save")
	public ModelAndView save(final Rendezvous rendezvous, final BindingResult binding) {
		ModelAndView result;
		Rendezvous saved;
		Rendezvous validatedObject = this.rendezvousService.reconstructNew(rendezvous, binding);
		if (binding.hasErrors()) {
			result = newEditModelAndView(rendezvous);
		} else
			try {
				saved = rendezvousService.save(validatedObject);
				result = new ModelAndView("redirect:../../rendezvous/display.do?rendezvousId=" + saved.getId());
			} catch (Throwable oops) {
				result = newEditModelAndView(rendezvous);
				result.addObject("message", "rendezvous.commitError");
			}
		return result;
	}
	
	protected ModelAndView newEditModelAndView(final Rendezvous rendezvous) {
		ModelAndView result;
		result = new ModelAndView("user/rendezvous/edit");
		result.addObject("rendezvous", rendezvous);
		result.addObject("rendezvouses", rendezvousService.getRendezvousesToLink());
		result.addObject("actionUri", "user/rendezvous/save.do");
		return result;
	}
	

	//---------------------- POST ----------------------

//	@RequestMapping(value = "/save", method = RequestMethod.POST, params = "save")
//	public ModelAndView save(final UserRendezvousCreateForm rendezvousForm, final BindingResult binding) {
//		ModelAndView result;
//		Rendezvous saved;
//
//		Rendezvous validatedObject = this.rendezvousService.reconstruct(rendezvousForm, binding);
//
//		if (binding.hasErrors()) {
//			System.out.println(binding.toString());
//			result = this.newEditModelAndView(rendezvousForm);
//		} else
//			try {
//				if(rendezvousForm.getRendezvousId() == 0)								//Si es un objeto nuevo
//					saved = this.rendezvousService.save(validatedObject);
//				else																	//Si es un objecto existente en base de datos
//					saved = this.rendezvousService.reconstructAndSave(rendezvousForm);
//
//				result = new ModelAndView("redirect:../../rendezvous/display.do?rendezvousId=" + saved.getId());
//			} catch (Throwable oops) {
//				result = this.newEditModelAndView(rendezvousForm);
//				result.addObject("message", "rendezvous.commitError");
//			}
//		return result;
//	}
//	
//	@RequestMapping(value = "/saveQuestions", method = RequestMethod.POST, params = "save")
//	public ModelAndView saveQuestions(final UserQuestionsRendezvousCreateForm questionsForm, final BindingResult binding, Integer rendezvousId) {
//		ModelAndView result;
//		Rendezvous saved;
//		
//		if (binding.hasErrors()) {
//			System.out.println(binding.toString());
//			result = new ModelAndView("rendezvous/editQuestions");
//			result.addObject("rendezvousId", rendezvousId);
//			result.addObject("rendezvous", questionsForm);
//			result.addObject("actionUri", "user/rendezvous/saveQuestions.do");
//		} else
//			try {
//				saved = this.rendezvousService.reconstructQuestionsAndSave(questionsForm, rendezvousId);
//
//				result = new ModelAndView("redirect:../../rendezvous/display.do?rendezvousId=" + saved.getId());
//			} catch (Throwable oops) {
//				System.out.println(oops.getLocalizedMessage());
//				System.out.println(oops.getMessage());
//				result = new ModelAndView("rendezvous/editQuestions");
//				result.addObject("rendezvousId", rendezvousId);
//				result.addObject("rendezvous", questionsForm);
//				result.addObject("actionUri", "user/rendezvous/saveQuestions.do");
//				result.addObject("message", "rendezvous.commitError");
//			}
//		return result;
//	}
//
//	@RequestMapping(value = "/save", method = RequestMethod.POST, params = "delete")
//	public ModelAndView delete(final UserRendezvousCreateForm rendezvousForm, final BindingResult binding) {
//		ModelAndView result;
//		if (binding.hasErrors())
//			result = this.newEditModelAndView(rendezvousForm);
//		else
//			try {
//				this.rendezvousService.deleteByUser(rendezvousForm.getRendezvousId());
//				result = new ModelAndView("redirect:../../rendezvous/list.do");
//			} catch (Throwable oops) {
//				result = this.newEditModelAndView(rendezvousForm);
//				result.addObject("message", "rendezvous.commitError");
//			}
//		return result;
//	}
//
//	protected ModelAndView newEditModelAndView(final UserRendezvousCreateForm rendezvousForm) {
//		ModelAndView result;
//		result = new ModelAndView("user/rendezvous/edit");
//		result.addObject("rendezvous", rendezvousForm);
//		result.addObject("rendezvouses", rendezvousService.getRendezvousesToLink());
//		result.addObject("actionUri", "user/rendezvous/save.do");
//		return result;
//	}
}
