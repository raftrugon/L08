package controllers.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Validator;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import services.AnnouncementService;
import services.CommentService;
import services.RendezvousService;
import services.RsvpService;
import services.UserService;
import domain.Announcement;
import domain.Comment;
import domain.Rendezvous;
import domain.Rsvp;
import domain.User;

@RestController
@RequestMapping("/user/ajax")
public class UserAjaxController {

	@Autowired
	private RsvpService 				rsvpService;
	@Autowired
	private AnnouncementService 				announcementService;
	@Autowired
	private UserService					userService;
	@Autowired
	private CommentService commentService;
	@Autowired
	private RendezvousService rendezvousService;
	@Autowired
	private Validator			validator;

	
	@RequestMapping(value="/newAnswer", method = RequestMethod.POST)
	public String newAnser(int rsvpId, String question, String answer){
		try{
			Rsvp rsvp = rsvpService.findOne(rsvpId);
			Map<String,String> newMap = rsvp.getQuestionsAndAnswers();
			newMap.put(question, answer);
			rsvp.setQuestionsAndAnswers(newMap);
			rsvpService.save(rsvp);
			return "1";
		}catch(Throwable oops){
			return "2";
		}
	}
	
	@RequestMapping(value = "	", method = RequestMethod.GET)
	public ModelAndView editQA(@RequestParam(required=true)final int rendezvousId) {
		ModelAndView result = new ModelAndView("rendezvous/qa/edit");
		Rendezvous r = rendezvousService.findOne(rendezvousId);
		result.addObject("questions",r.getQuestions());
		result.addObject("rendezvous", r);
		return result;
	}
	
	@RequestMapping(value = "rendezvous/qa/edit", method = RequestMethod.POST)
	public String editQASave(int rendezvousId, String questions) {
		System.out.println(rendezvousId);
		System.out.println(questions);
		String[] aux = questions.split(",,,");
		List<String> questionList = new ArrayList<String>();
		for(int i=0; i< aux.length; i++)
			questionList.add(aux[i]);
		Rendezvous r = rendezvousService.findOne(rendezvousId);
		try{
			r.setQuestions(questionList);
			Rendezvous res = rendezvousService.save(r);
			return String.valueOf(res.getId());
		} catch(Throwable oops){
			System.out.println(oops.getMessage());
			return "0";
		}
	}
	
	@RequestMapping(value = "announcement/save", method = RequestMethod.POST)
	public String save(@Valid final Announcement announcement, final BindingResult binding) {
		if (binding.hasErrors())
			return "0";
		else
			try {
				announcementService.save(announcement);
				return "1";
			} catch (Throwable oops) {
				return "2";
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
			System.out.println(oops.getMessage());
			return new ModelAndView("ajaxException");
		}
	}
	
	@RequestMapping(value="rsvp/save", method = RequestMethod.POST)
	public String saveRSVP(final Rsvp rsvp, final BindingResult binding){
		if(rsvp.getQuestionsAndAnswers() == null){
			rsvp.setQuestionsAndAnswers(new HashMap<String,String>());
		}
		validator.validate(rsvp,binding);
		if(binding.hasErrors()){
			return "0";
		}
		try{
			rsvpService.save(rsvp);
			return "1";
		}catch(Throwable oops){
			return "2";
		}
	}
	
	@RequestMapping(value="rsvp/createWithoutQuestions", method = RequestMethod.POST)
	public String createWithoutQuestions(final int rendezvousId){
		try{
			rsvpService.save(rsvpService.create(rendezvousId));
			return "1";
		}catch(Throwable oops){
			oops.printStackTrace();
			return "2";
		}
	}
	
	@RequestMapping(value="rsvp/cancelRSVP", method = RequestMethod.POST)
	public String cancelRSVP(final int rendezvousId){
		try{
			rsvpService.delete(rendezvousId);
			return "1";
		}catch(Throwable oops){
			oops.printStackTrace();
			return "2";
		}
	}
	
	@RequestMapping(value="rendezvous/link", method = RequestMethod.POST)
	public String linkRendezvous(final int sourceId, final int targetId){
		try{
			rendezvousService.link(sourceId, targetId);
			return "1";
		}catch(Throwable oops){
			return "2";
		}
	}
	
	@RequestMapping(value="rendezvous/link/delete", method = RequestMethod.POST)
	public String deleteLink(final int rendezvousId, final int linkId) {
		try{
			rendezvousService.deleteLink(rendezvousId, linkId);
			return "1";
		} catch (Throwable oops) {
			return "2";
		}
	}
}
