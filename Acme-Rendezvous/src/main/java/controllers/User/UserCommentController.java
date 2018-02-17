
package controllers.User;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import services.CommentService;
import services.UserService;
import controllers.AbstractController;
import domain.Comment;
import domain.User;

@Controller
@RequestMapping("/comment")
public class UserCommentController extends AbstractController {

	@Autowired
	private CommentService	commentService;
	@Autowired
	private UserService	userService;


	//Constructor
	public UserCommentController() {
		super();
	}
	
	@RequestMapping(value = "/createComment", method = RequestMethod.GET)
	public ModelAndView create(@RequestParam(required = true) final int rendezvousId) {
		ModelAndView result;
		try {
			Comment comment = commentService.createReply(rendezvousId);
			result = newEditModelAndView(comment);
		} catch (Throwable oops) {
			result = new ModelAndView("redirect:list.do");
		}
		return result;
	}	
	@RequestMapping(value = "/replyComment", method = RequestMethod.GET)
	public ModelAndView createReply(@RequestParam(required = true) final int commentId) {
		ModelAndView result;
		try {
			Comment comment = commentService.createReply(commentId);
			result = newEditModelAndView(comment);
		} catch (Throwable oops) {
			result = new ModelAndView("redirect:list.do");
		}
		return result;
	}

	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam(required = true) final int commentId) {
		Comment comment = commentService.findOne(commentId);
		if (comment.getUser().equals(userService.findByPrincipal()))
			return newEditModelAndView(comment);
		else
			return new ModelAndView("redirect:list.do");
	}

	@RequestMapping(value = "/save", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid final Comment comment, final BindingResult binding) {
		ModelAndView result;
		if (binding.hasErrors())
			result = newEditModelAndView(comment);
		else
			try {
				commentService.save(comment);
				result = new ModelAndView("redirect:list.do");
			} catch (Throwable oops) {
				result = newEditModelAndView(comment);
				result.addObject("message", "comment.commitError");
			}
		return result;
	}

	protected ModelAndView newEditModelAndView(final Comment comment) {
		ModelAndView result;
		result = new ModelAndView("comment/edit");
		result.addObject("comment", comment);
		result.addObject("actionUri", "user/comment/save.do");
		return result;
	}
}