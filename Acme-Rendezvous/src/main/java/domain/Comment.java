
package domain;

import java.util.Collection;
import java.util.Date;

import javax.persistence.Access;
import javax.persistence.AccessType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.URL;

@Entity
@Access(AccessType.PROPERTY)
public class Comment extends DomainEntity {

	public Comment() {
		super();
	}


	private Date	creationMoment;
	private String	text;
	private String	picture;


	@Past
	@NotNull
	public Date getCreationMoment() {
		return creationMoment;
	}

	public void setCreationMoment(Date creationMoment) {
		this.creationMoment = creationMoment;
	}

	@NotBlank
	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@URL
	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}


	//Relationships ----------------------------------

	private Collection<Comment>	replies;
	private Comment				replyingTo;
	private User				user;
	private Rendezvous			rendezvous;


	@NotNull
	@OneToMany(mappedBy = "replyingTo")
	public Collection<Comment> getReplies() {
		return replies;
	}

	public void setReplies(Collection<Comment> replies) {
		this.replies = replies;
	}

	@Valid
	@ManyToOne(optional = true)
	public Comment getReplyingTo() {
		return replyingTo;
	}

	public void setReplyingTo(Comment replyingTo) {
		this.replyingTo = replyingTo;
	}

	@NotNull
	@Valid
	@ManyToOne(optional = false)
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@NotNull
	@Valid
	@ManyToOne(optional = false)
	public Rendezvous getRendezvous() {
		return rendezvous;
	}

	public void setRendezvous(Rendezvous rendezvous) {
		this.rendezvous = rendezvous;
	}
}
