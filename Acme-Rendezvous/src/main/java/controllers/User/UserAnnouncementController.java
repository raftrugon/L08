
package controllers.User;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.AnnouncementService;
import services.UserService;
import controllers.AbstractController;
import domain.Announcement;
import domain.Comment;
import domain.Rendezvous;
import domain.User;

@Controller
@RequestMapping("user/announcement")
public class UserAnnouncementController extends AbstractController {

	@Autowired
	private AnnouncementService	announcementService;
	@Autowired
	private UserService	userService;


	//Constructor
	public UserAnnouncementController() {
		super();
	}
	
	@RequestMapping("/list")
	public ModelAndView list() {
		ModelAndView result;
		final List<Announcement> announcements = new ArrayList<Announcement>(announcementService.getAnnouncementsForUser(userService.findByPrincipal()));
		result = new ModelAndView("announcement/list");
		result.addObject("announcements", announcements);
		result.addObject("requestUri", "announcement/list.do");
		return result;
	}
	

	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(@ModelAttribute @Valid final Announcement announcement, final BindingResult binding) {
		String result;
		if (binding.hasErrors())
			result = binding.getAllErrors().toString();
		else
			try {
				announcementService.save(announcement);
				result = "1";
			} catch (Throwable oops) {
				oops.printStackTrace();
				result = "2";
			}
		return result;
	}
	
	protected ModelAndView newEditModelAndView(final Announcement announcement) {
		ModelAndView result;
		result = new ModelAndView("announcement/edit");
		result.addObject("announcement", announcement);
		result.addObject("actionUri", "user/announcement/save.do");
		return result;
	}
}