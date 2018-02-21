package controllers;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import services.AnnouncementService;
import services.CommentService;
import services.RsvpService;
import services.UserService;
import domain.Announcement;
import domain.Comment;
import domain.Rsvp;
import domain.User;

@RestController
@RequestMapping("/ajax")
public class AjaxController {

	@Autowired
	private RsvpService 				rsvpService;
	@Autowired
	private AnnouncementService 				announcementService;
	@Autowired
	private UserService					userService;
	@Autowired
	private CommentService commentService;
	 
	
	@RequestMapping(value = "/qa", method = RequestMethod.GET)
	public ModelAndView qa(@RequestParam(required=true)final int rsvpId) {
		ModelAndView result = new ModelAndView("rsvp/qa");
		Rsvp rsvp = rsvpService.findOne(rsvpId);
		result.addObject("qa",rsvp.getQuestionsAndAnswers());
		result.addObject("pendingQuestions", rsvpService.getPendingQuestions(rsvp));
		result.addObject("rsvp", rsvp);
		return result;
	}
	
	@RequestMapping(value="admin/announcement/delete", method=RequestMethod.POST)
	public String deleteAnnouncement(@RequestParam(required = true) int announcementId) {
		Announcement a = announcementService.findOne(announcementId);
		try{
			announcementService.deleteByAdmin(a);
			return "1";
		} catch(Throwable oops) {
			return "0";
		}
	}	
	
	@RequestMapping(value="admin/comment/delete", method=RequestMethod.POST)
	public String deleteComment(@RequestParam(required = true) int commentId) {
		Comment c = commentService.findOne(commentId);
		try{
			commentService.deleteByAdmin(c);
			return "1";
		} catch(Throwable oops) {
			return "0";
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
			return new ModelAndView("error");
		}
	}
	
	@RequestMapping(value="rsvp/save", method = RequestMethod.POST)
	public ModelAndView saveRSVP(@Valid final Rsvp rsvp, final BindingResult binding){
		try{
			rsvpService.save(rsvp);
		}catch(Throwable oops){}
		
		return new ModelAndView("redirect: /rendezvous/display.do?rendezvousId="+rsvp.getRendezvous().getId());
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
}
