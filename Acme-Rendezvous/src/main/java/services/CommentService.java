
package services;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.CommentRepository;
import domain.Admin;
import domain.Comment;
import domain.Rendezvous;
import domain.User;

@Service
@Transactional
public class CommentService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private CommentRepository			commentRepository;

	// Supporting services ----------------------------------------------------
	@Autowired
	private UserService userService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private RendezvousService rendezvousService;
	
	// Simple CRUD methods ----------------------------------------------------

	public Comment createWithRendezvous(Rendezvous rendezvous) {
		Comment res = new Comment();
		User u = userService.findByPrincipal();
		
		Assert.notNull(rendezvous);
		Assert.notNull(u);
		
		res.setRendezvous(rendezvous);
		res.setReplies(new ArrayList<Comment>());
		res.setCreationMoment(new Date());
		res.setUser(u);

		return res;
	}
	
	public Comment createReply(Comment comment){
		Comment res = new Comment();
		User u = userService.findByPrincipal();
		

		Assert.notNull(comment);
		Assert.notNull(u);
		Assert.isNull(comment.getReplyingTo());
		Assert.isTrue(rendezvousService.getRSVPRendezvousesForUser(u).contains(comment.getRendezvous()));
		
		res.setRendezvous(null);
		res.setReplies(null);
		res.setCreationMoment(new Date());
		res.setReplyingTo(comment);
		res.setUser(u);
		
		return res;
	}

	public Comment findOne(int commentId) {
		Assert.isTrue(commentId != 0);
		Comment res = commentRepository.findOne(commentId);
		Assert.notNull(res);
		return res;
	}

	public Comment save(Comment comment) {
		User u = userService.findByPrincipal();
		Assert.notNull(comment);
		Assert.notNull(u);
		Assert.isTrue(rendezvousService.getRSVPRendezvousesForUser(u).contains(comment.getRendezvous()));
		return commentRepository.save(comment);
	}

	public void deleteByAdmin(final Comment comment) {
		Admin a = adminService.findByPrincipal();
		Assert.notNull(a);
		commentRepository.delete(comment);

	}
	
	//Other Business Methods --------------------------------
	
	
}
