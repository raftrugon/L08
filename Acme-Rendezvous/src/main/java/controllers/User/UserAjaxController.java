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
	 
	
	@RequestMapping(value = "/qa", method = RequestMethod.GET)
	public ModelAndView qa(@RequestParam(required=true)final int rsvpId) {
		ModelAndView result = new ModelAndView("rsvp/qa");
		Rsvp rsvp = rsvpService.findOne(rsvpId);
		result.addObject("qa",rsvp.getQuestionsAndAnswers());
		result.addObject("pendingQuestions", rsvpService.getPendingQuestions(rsvp));
		result.addObject("rsvp", rsvp);
		return result;
	}	
	
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
	
	@RequestMapping(value = "rendezvous/qa/edit", method = RequestMethod.GET)
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
	
	@RequestMapping(value="admin/rendezvous/delete", method=RequestMethod.POST)
	public String deleteRendezvous(@RequestParam(required = true) int rendezvousId) {
		Rendezvous r = rendezvousService.findOne(rendezvousId);
		try{
			rendezvousService.deleteByAdmin(r);
			return "1";
		} catch(Throwable oops) {
			return "2";
		}
	}	
	
	@RequestMapping(value="admin/announcement/delete", method=RequestMethod.POST)
	public String deleteAnnouncement(@RequestParam(required = true) int announcementId) {
		Announcement a = announcementService.findOne(announcementId);
		try{
			announcementService.deleteByAdmin(a);
			return "1";
		} catch(Throwable oops) {
			return "2";
		}
	}	
	
	@RequestMapping(value="admin/comment/delete", method=RequestMethod.POST)
	public String deleteComment(@RequestParam(required = true) int commentId) {
		Comment c = commentService.findOne(commentId);
		try{
			commentService.deleteByAdmin(c);
			return "1";
		} catch(Throwable oops) {
			return "2";
		}
	}
	
	@RequestMapping(value = "user/announcement/save", method = RequestMethod.POST)
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
	
	@RequestMapping(value="user-card", method = RequestMethod.GET)
	public ModelAndView userCard(@RequestParam(required=true) final int userId){
		ModelAndView result;
		try{
			User u = userService.findOne(userId);
			result = new ModelAndView("user/card");
			result.addObject("user",u);
		}catch(Throwable oops){
			result = null;
		}
		return result;
	}
	
	@RequestMapping(value="loadAnnouncements", method = RequestMethod.GET)
	public ModelAndView loadAnnouncements(@RequestParam(required=true) final int type){
		ModelAndView result = new ModelAndView("announcement/subList");
		if(type==0){
			result.addObject("announcements",announcementService.findAllOrdered());
		}else{
			try{
				User u = userService.findByPrincipal();
				if(type==1){
					result.addObject("announcements",announcementService.getMyAnnouncements(u));
				}else if(type==2){
					result.addObject("announcements",announcementService.getRSVPAnnouncementsForUser(u));
				}else{
					result.addObject("announcements",announcementService.findAllOrdered());
				}
			}catch(Throwable oops){
				result.addObject("announcements",announcementService.findAllOrdered());
			}
		}
		return result;
	}
	
	@RequestMapping(value="showComments", method = RequestMethod.GET)
	public ModelAndView showComments(@RequestParam(required=true) final int rendezvousId){
		ModelAndView result = new ModelAndView("comment/display");
		Boolean rsvpd = false;
		try{
			rsvpd = userService.isRsvpd(rendezvousId);
			if(rsvpd) result.addObject("newComment",commentService.createComment(rendezvousId));
		}catch(Throwable oops){}
		try{
			Rendezvous rendezvous = rendezvousService.findOne(rendezvousId);
			result.addObject("rendezvous",rendezvous);
			result.addObject("rsvpd",rsvpd);
			result.addObject("comments",commentService.getRendezvousCommentsSorted(rendezvousId));
		}catch(Throwable oops){
			result = new ModelAndView("ajaxException");
		}
		return result;
	}
	
	@RequestMapping(value="showAnnouncements", method = RequestMethod.GET)
	public ModelAndView showAnnouncements(@RequestParam(required=true) final int rendezvousId){
		ModelAndView result = new ModelAndView("announcement/display");
		try{
			result.addObject("announcements",announcementService.getRendezvousAnnouncementsSorted(rendezvousId));
		}catch(Throwable oops){
			result = new ModelAndView("ajaxException");
		}
		return result;
	}
	
	@RequestMapping(value="showButtons", method = RequestMethod.GET)
	public ModelAndView showButtons(@RequestParam(required=true) final int rendezvousId){
		ModelAndView result = new ModelAndView("rendezvous/buttonsalerts");
		Boolean rsvpd = false;
		Boolean isAdult = false;
		try{
			rsvpd = userService.isRsvpd(rendezvousId);
			isAdult = userService.isAdult();
		}catch(Throwable oops){}
		try{
			result.addObject("rendezvous",rendezvousService.findOne(rendezvousId));
			result.addObject("rsvpd",rsvpd);
			result.addObject("isAdult",isAdult);
		}catch(Throwable oops){
			result = new ModelAndView("ajaxException");
		}
		return result;
	}
	
	@RequestMapping(value="user/linkRendezvous", method = RequestMethod.POST)
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
		Rendezvous r = rendezvousService.findOne(rendezvousId);
		try{
			rendezvousService.deleteLink(rendezvousId, linkId);
			return "1";
		} catch (Throwable oops) {
			return "2";
		}
	}
}
