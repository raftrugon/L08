
package repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Comment;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Integer> {

	@Query("select coalesce(avg(c.replies.size),0), coalesce(stddev(c.replies.size),0) from Comment c")
	Double[] getCommentRepliesStats();
}