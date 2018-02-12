
package services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.CommentRepository;
import domain.Comment;

@Service
@Transactional
public class CommentService {

	// Managed repository -----------------------------------------------------

	@Autowired
	private CommentRepository			commentRepository;

	// Supporting services ----------------------------------------------------


	// Simple CRUD methods ----------------------------------------------------

	public Comment create() {
		Comment res = new Comment();

		return res;
	}

	public Comment findOne(int commentId) {
		Assert.isTrue(commentId != 0);
		Comment res = commentRepository.findOne(commentId);
		Assert.notNull(res);
		return res;
	}

	public Comment save(Comment comment) {
		return commentRepository.save(comment);
	}

	public void delete(final Comment comment) {
		commentRepository.delete(comment);

	}
	
	//Other Business Methods --------------------------------
	
	
}
